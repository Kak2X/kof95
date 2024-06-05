; =============== SGB_SGB_SendBorderData ===============
SGB_SendBorderData:

	; The border tiles need to be sent to the SGB side through VRAM.
	; That leaves us with a $1000 byte buffer to store uncompressed data ($8800-$9800),
	; meaning that large chunks of graphics (like the 4bpp border tiles) are sent in chunks.
	
	
	;
	; Transfer the first part of border tiles
	;
	ld   hl, GFX_SGB_Border0
	ld   de, SGBPacket_CopyBorderTiles0
	call SGB_SendBlock4KB
	ld   bc, $0010
	call SGB_SendBorderData_WaitAfterSend
	
	;
	; Transfer the second part of border tiles
	;
	ld   hl, GFX_SGB_Border1
	ld   de, SGBPacket_CopyBorderTiles1
	call SGB_SendBlock4KB
	ld   bc, $0010
	call SGB_SendBorderData_WaitAfterSend
	
	;
	; Transfer the border tilemap and proper palette.
	; These are stored contiguously in the same 4KB block
	; - $0000-$06FF: Tilemap
	; - $0800-$087F: Palette data
	;
	ld   hl, BG_SGB_Border
	ld   de, SGBPacket_CopyBorderTilemap
	call SGB_SendBlock4KB
	ld   bc, $0010
	call SGB_SendBorderData_WaitAfterSend
	
IF FIX_BUGS == 0
	;
	; Attempt to erase the GFX area we've used for the transfers.
	; [BUG] Not only this is pointless, but it's done while the display is enabled,
	;       causing VRAM inaccessibility issues and so the tiles get striped.
	;       If you want to fix this for some reason, move "rst $10" above this loop.
	;
	ld   hl, $8800		; HL = Starting address
	ld   bc, $1000		; BC = Bytes left
	xor  a				; A = Clear with
.clrLoop:
	xor  a
	ldi  [hl], a		; Clear byte
	dec  bc
	ld   a, b
	or   c				; Are we done?
	jp   nz, .clrLoop	; If not, loop
ENDC
	;-----------------------------------
	rst  $10			; Stop LCD
	ret


SGBPacket_CopyBorderTiles0:
	pkg SGB_PACKET_CHR_TRN, $01
	db $00 ; Transfer tiles $00-$7F
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	mIncJunk "L04404E"

SGBPacket_CopyBorderTiles1:
	pkg SGB_PACKET_CHR_TRN, $01
	db $01  ; Transfer tiles $80-$FF
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	mIncJunk "L044060"
	
SGBPacket_CopyBorderTilemap:
	pkg SGB_PACKET_PCT_TRN, $01
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	
	mIncJunk "L044072"

; =============== SGB_SendBlock4KB ===============
; Sends a 4KB block of uncompressed data to the SGB by transferring it through the screen.
;
; IN
; - HL: Ptr to uncompressed data
; - DE: Ptr to SGB packet which uses this transfer method
SGB_SendBlock4KB:
	di   
	push de						; Save SGB packet ptr
		;-----------------------------------
		rst  $10				; Stop LCD
		ld   a, $E4				; Required palette for screen tranfer
		ldh  [rBGP], a
		
		;
		; Copy the data to the VRAM tiles area
		;
		ld   de, $8800			; Start from 2nd tiles block
		ld   bc, $1000			; Overwrite blocks 2 and 3
		call SGB_SendBorderData_CopyBytes
		
		;
		; Generate a tilemap where every single tile is visible on-screen, in order,
		; starting from the top left corner.
		; The screen coords should be set to 0 when we get here.
		; 
		; The SNES has access to the rendered frame from its GFX area, so all it needs to do
		; is reading that as the sent data.
		; As a result, anything that isn't visible on screen isn't accessible by the SNES.
		; 
		
		ld   hl, $9800					; HL = Tilemap start
		ld   de, BG_TILECOUNT_H-$14		; DE = Bytes to seek to the start of the next row
		ld   a, $80						; A = Starting Tile ID (points to tile at $8800)
		ld   c, $0D						; C = Min number of rows required to draw all tiles
	.vLoop:
		ld   b, $14						; B = Visible tiles in a row
	.rowLoop:
		ldi  [hl], a			; Write Tile Id to tilemap, TilemapPtr++
		inc  a					; TileId++
		dec  b					; TilesLeft--
		jr   nz, .rowLoop		; Written the row? If not, loop
		add  hl, de				; Move down 1 tile, at the start of the next row
		dec  c					; RowsLeft--
		jr   nz, .vLoop			; Written all rows
		
		
		; Enable screen without OBJ or WINDOW 
		ld   a, LCDC_PRIORITY|LCDC_ENABLE
		ldh  [rLCDC], a
		; Make sure the SGB is ready
		ld   bc, $0005
		call SGB_SendBorderData_WaitAfterSend
		
	; Now that the screen is set up, execute the transfer
	pop  hl						; HL = SGB Packet ptr
	call SGB_SendPackets
	ld   bc, $0006
	call SGB_SendBorderData_WaitAfterSend
	
	; We're done
	ei   
	ret  

; =============== SGB_SendBorderData_CopyBytes ===============
; Generic loop for copying data.
; - HL: Ptr to source uncompressed data
; - DE: Ptr to destination
; - BC: Bytes to copy
SGB_SendBorderData_CopyBytes:
	ldi  a, [hl]		; Read from source, SrcPtr++
	ld   [de], a		; Copy to destination
	inc  de				; DestPtr++
	dec  bc				; BytesLeft--
	ld   a, b
	or   c				; Are we done?
	jp   nz, SGB_SendBorderData_CopyBytes	; If not, loop
	ret
	
; =============== SGB_SendBorderData_WaitAfterSend ===============
; Waits for a multiple of $06D6 frames after a packet is sent.
; IN
; - BC: Wait multiplier
SGB_SendBorderData_WaitAfterSend:
	ld   de, $06D6			; DE = LoopsLeft
.wait:
	nop  					; Waste some cycles
	nop  
	nop  
	dec  de					; DE--
	ld   a, d
	or   e					; DE == 0?
	jr   nz, .wait			; If not, loop
	
	dec  bc					; BC--
	ld   a, b
	or   c					; BC == 0?
	jr   nz, SGB_SendBorderData_WaitAfterSend	; If not, loop
	ret
	
GFX_SGB_Border0: INCBIN "data/gfx/sgb_border0.bin"
GFX_SGB_Border1: INCBIN "data/gfx/sgb_border1.bin"
BG_SGB_Border: INCBIN "data/bg/sgb_border.bin"

; [TCRF] There's a bit more to the backgrounds than what's used, but the unused
;        portions are just padding areas.
GFXDef_Play_Stage_00: mGfxDef "data/gfx/play_stage_00.bin"
BG_Play_Stage_00: INCBIN "data/bg/play_stage_00.bin"
GFXDef_Play_Stage_01: mGfxDef "data/gfx/play_stage_01.bin"
BG_Play_Stage_01: INCBIN "data/bg/play_stage_01.bin"
BG_Play_Stage_01_Unused: INCBIN "data/bg/play_stage_01_unused.bin"
GFXDef_Play_Stage_04: mGfxDef "data/gfx/play_stage_04.bin"
BG_Play_Stage_04: INCBIN "data/bg/play_stage_04.bin"
BG_Play_Stage_04_Unused: INCBIN "data/bg/play_stage_04_unused.bin"
GFXDef_Play_Stage_02: mGfxDef "data/gfx/play_stage_02.bin"
BG_Play_Stage_02: INCBIN "data/bg/play_stage_02.bin"
BG_Play_Stage_02_Unused: INCBIN "data/bg/play_stage_02_unused.bin"

; =============== END OF BANK ===============
; Junk area below.
	mIncJunk "L047F97"