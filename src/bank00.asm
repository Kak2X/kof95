; =============== RESET VECTOR $00 ===============
; Bankswitches to code in a different bank.
; Because this doesn't return, this is typically used to switch modes
; -- the code which is jumped to resets the stack and sets up its own main loop.
; IN
; -  B: Bank number where the code is located
; - HL: Ptr to code to code to execute
; WIPES
; - A
SECTION "Rst00", ROM0[$0000]
FarJump:
	ld   a, b
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	jp   hl
	mIncJunk "L000007"
	
; =============== RESET VECTOR $08 ===============
SECTION "Rst08", ROM0[$0008]
;Rst_FarCall:
	jp   FarCall
	mIncJunk "L00000B"

; =============== RESET VECTOR $10 ===============
SECTION "Rst10", ROM0[$0010]
;Rst_StopLCDOperation:
	jp   StopLCDOperation
	mIncJunk "L000013"

; =============== RESET VECTOR $18 ===============
SECTION "Rst18", ROM0[$0018]
;Rst_StartLCDOperation:
	jp   StartLCDOperation
	mIncJunk "L00001B"

; =============== RESET VECTOR $20 ===============
; Disables the SERIAL interrupt.
SECTION "Rst20", ROM0[$0020]
;Rst_DisableSerialInt:
	ldh  a, [rIE]
	and  a, $FF^I_SERIAL
	ldh  [rIE], a
	ret
	mIncJunk "L000027"

; =============== RESET VECTOR $28 ===============
; Enables the SERIAL interrupt.
SECTION "Rst28", ROM0[$0028]
;Rst_EnableSerialInt:
	ldh  a, [rIE]
	or   a, I_SERIAL
	ldh  [rIE], a
	ret
	mIncJunk "L00002F"
; =============== RESET VECTOR $30 ===============
SECTION "Rst30", ROM0[$0030]
; Not used.
	ret
	mIncJunk "L000031"
; =============== RESET VECTOR $38 ===============
SECTION "Rst38", ROM0[$0038]
; Not used.
	ret
	mIncJunk "L000039"
; =============== VBLANK INTERRUPT ===============
SECTION "VBlankInt", ROM0[$0040]
	jp   VBlankHandler
	mIncJunk "L000043"

; =============== LCDC/STAT INTERRUPT ===============
SECTION "LCDCInt", ROM0[$0048]
	jp   LCDCHandler
	mIncJunk "L00004B"
; =============== TIMER INTERRUPT ===============
; Not used.
SECTION "TimerInt", ROM0[$0050]
	reti
	mIncJunk "L000051"
; =============== SERIAL INTERRUPT ===============
SECTION "SerialInt", ROM0[$0058]
	jp   SerialHandler
	mIncJunk "L00005B"
; =============== JOYPAD INTERRUPT ===============
; Not used.
SECTION "JoyInt", ROM0[$0060]
	reti

SECTION "IntFunc", ROM0[$0061]
; =============== FarCall / SubCall ===============
; This subroutine performs a bankswitch to the specified code and calls it.
; When the subroutine is done, the previous bank is restored.
;
; IN
; -  B: Bank number where the code is located
; - HL: Ptr to code to code to execute
; WIPES
; - A
FarCall:
	ldh  a, [hROMBank]			; Save the current bank number for later.
	push af
	ld   a, b					; Bankswitch to the new bank
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call .exec					; Execute the code
	pop  af						; Restore the previous bank
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
.exec:
	jp   hl
	
; =============== StopLCDOperation ===============
; Disables the screen output in a safe way.
;
; This will wait for VBlank before stopping the LCD.
StopLCDOperation:
	ldh  a, [rIE]			; Disable VBlank interrupt to prevent it from firing
	and  a, $FF^I_VBLANK
	ldh  [rIE], a

	; If the LCD is already disabled, we're done.
	ldh  a, [rLCDC]
	bit  LCDCB_ENABLE, a	; Is the display enabled?
	jp   z, .end			; If not, skip

	; Otherwise, wait in a loop until the scanline counter reaches what would be VBlank.
.wait:
	ldh  a, [rLY]			; Read scanline number
	cp   LY_VBLANK+1		; Is it 1 after the VBlank trigger?
	jr   nz, .wait			; If not, loop

	; Now we can safely disable the LCD
	ldh  a, [rLCDC]
	and  a, $FF^LCDC_ENABLE
	ldh  [rLCDC], a
.end:
	ret

; =============== StartLCDOperation ===============
; Enables the screen output with the specified options.
; IN
; - A: LCDC options.
StartLCDOperation:
	or   a, LCDC_ENABLE				; Set new LCDC status
	ldh  [rLCDC], a
	ldh  a, [rIE]					; Enable VBLANK and Serial interrupts
	or   a, I_VBLANK|I_SERIAL
	ldh  [rIE], a
	ret
	
; =============== Bar Data ===============
; Tile IDs used for bars that grow from left to right
; Increasing and decreasing pick different ranges of bytes due to the different tile picked as "bar tip".
Play_Bar_TileIdTbl_LGrow: 
	db $D5 ; Only used when decreasing as last value (completely empty)
	db $D6,$D7,$D8,$D9,$DA,$DB,$DC
	db $D4 ; Only used when increasing as last value (completely filled)

; Table of tilemap offsets, helps determine where the tilemap pointer to the tip.
; Calculated like this:
; 	vBGHealthBar1P + Play_Bar_BGOffsetTbl_LGrow[BarValue/8]
; Doing it this way is quite flexible, and allowed 96 to reverse the bar directions
; by simply swapping out the LGrow with RGrow here.
; (However, they had to alter the bar flash logic too due to hardcoded positions.)
Play_Bar_BGOffsetTbl_LGrow:
	db $00,$01,$02,$03,$04,$05,$06,$07,$08

; Like above, but for bars growing from right to left.
Play_Bar_TileIdTbl_RGrow:
	db $D5 ; ""
	db $DD,$DE,$DF,$E0,$E1,$E2,$E3
	db $D4 ; ""
Play_Bar_BGOffsetTbl_RGrow:
	db $08,$07,$06,$05,$04,$03,$02,$01,$00

; =============== Play_HUDTileIdTbl ===============
; Maps digits to tile IDs, relative to where the HUD is loaded.
Play_HUDTileIdTbl:
	db $F1 ; 0
	db $F2 ; 1
	db $F3 ; 2
	db $F4 ; 3
	db $F5 ; 4
	db $F6 ; 5
	db $F7 ; 6
	db $F8 ; 7
	db $F9 ; 8
	db $FA ; 9
	mIncJunk "L0000C8"

SECTION "EntryPoint", ROM0[$0100]
; =============== HW ENTRY POINT ===============
	nop
	jp   EntryPoint

; =============== GAME HEADER ===============
	; logo
	db   $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
	db   $00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
	db   $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E

IF REV_VER == VER_96F
	db   "NETTOU KOF 96",$00,$00	; title
ELSE
	db   "NETTOU KOF 95",$00,$00	; title
ENDC
	db   $00      		; DMG - classic gameboy
IF REV_VER == VER_EU
	db   $33,$38		; new license
ELSE
	db   $41,$37		; new license
ENDC
	db   $03      		; SGB flag: SGB capable
	db   $01      		; cart type: MBC1
	db   $04      		; ROM size: 512KiB
	db   $00      		; RAM size: 0KiB
IF VER_EN
	db   $01      		; destination code: non-Japanese
ELSE
	db   $00      		; destination code: Japanese
ENDC
	db   $33      		; old license: SGB capable
	db   $00      		; mask ROM version number
	
IF REV_VER == VER_EU
	db   $D3      		; header check
ELSE
	db   $C7      		; header check
ENDC
	
IF REV_VER == VER_96F
	; Fake 96 forgets to update the header checksum, but the global checksum is ok
	dw   $A527    		; global check
ELIF REV_VER == VER_EU
	dw   $0FC5    		; global check
ELSE
	dw   $B7B2    		; global check
ENDC

	
; =============== EntryPoint ===============
EntryPoint:
	rst  $10				; Stop LCD
	di
	ld   sp, $DC00			; Setup stack
	ld   a, $0A				; Enable SRAM
	ld   [MBC1SRamEnable], a
	ld   a, $01				; Initialize first bank
	ld   [MBC1RomBank], a
	
	;
	; Clear memory range wSndSet-$CBBE.
	; This is used by the sound driver and shared/mode-specific variables.
	; (-$CBC1 in the EN version, for the two added text-related variables.
	;
	ld   hl, wSndSet	; HL = Initial address
IF VER_EN
	ld   de, $0BC1		; DE = Bytes to clear
ELSE
	ld   de, $0BBF		; DE = Bytes to clear
ENDC
	ld   b, $00			; B = Value to repeat
.clMem1:
	ld   a, b
	ldi  [hl], a
	dec  de
	ld   a, d
	or   a, e
	jr   nz, .clMem1
	
	;
	; Clear memory range wGFXBufInfo_Pl1+iGFXBufInfo_DestPtr_Low-$DFFF.
	; This clears the sprite mapping / player / object areas.
	;

IF VER_EN
	ld   hl, wGFXBufInfo_Pl1-$300
	ld   de, $1100+$300 ; $300 extra bytes, for what ???
ELSE	
	ld   hl, wGFXBufInfo_Pl1
	ld   de, $1100
ENDC
	ld   b, $00
.clMem2:
	ld   a, b
	ldi  [hl], a
	dec  de
	ld   a, d
	or   a, e
	jr   nz, .clMem2
	
	;
	; Clear HRAM ($FF80-$FFFE)
	;
	ld   hl, hOAMDMA
	ld   de, $007E
	ld   b, $00
.clMem3:
	ld   a, b
	ldi  [hl], a
	dec  de
	ld   a, d
	or   a, e
	jr   nz, .clMem3

	;
	; Copy the OAMDMA routine.
	;
	ld   c, LOW(hOAMDMA)	; C = Destination
	ld   b, (OAMDMACode.end-OAMDMACode) ; $11 B = Bytes to copy
	ld   hl, OAMDMACode		; HL = Source
.dccLoop:
	ldi  a, [hl]			; Read the byte
	ld   [c], a				; Copy it to $FF00 + C
	inc  c
	dec  b
	jr   nz, .dccLoop
	
	;
	; Misc init
	;
	call Serial_Init
	
	;
	; Copy over the default settings
	;
	ld   hl, DefaultSettings						; HL = Source
	ld   de, wDifficulty							; DE = Destination
	ld   bc, (DefaultSettings.end-DefaultSettings)	; BC = Bytes to copy
.dscLoop:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  bc
	ld   a, b
	or   a, c
	jr   nz, .dscLoop
	
	; Copy to WRAM what doesn't fit in their banks
	ld   b, BANK(Play_CopyColiBoxToRAM) ; BANK $1D
	ld   hl, Play_CopyColiBoxToRAM
	rst  $08

	; Initialize screen
	ld   a, LCDC_ENABLE|LCDC_WTILEMAP
	ldh  [rLCDC], a
	xor  a
	ldh  [rSCX], a
	ldh  [rSCY], a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ldh  [rIF], a
	ldh  [rSTAT], a
	
	; Initialize sound
	call HomeCall_Sound_Init
	
	; Detect if we're running under the SGB
	ld   a, BANK(SGBPacket_EnableMultiJoy_2Pl) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call IsSGBHardware		; Running under SGB?
	jr   c, .isSGB			; If so, jump
.isGB:
	ld   hl, wMisc_C025		; Unmark SGB mode
	res  MISCB_IS_SGB, [hl]
	jp   .switchToTakaraLogo
.isSGB:
	ld   hl, wMisc_C025		; Mark SGB mode
	set  MISCB_IS_SGB, [hl]
	ld   bc, $0078			; Wait $78 superticks
	call SGB_DelayAfterPacketSendCustom
	
	;
	; Do the loading of the initial data immediately.
	; In 96, this got moved to SGB_LoadInitial, which only gets executed after
	; the Takara logo is done.
	;
	
MACRO mSendPkg
	ld   hl, \1
	call SGB_SendPackets
	ld   bc, $0004
	call SGB_DelayAfterPacketSendCustom
ENDM
	
	; Stop the screen to prevent it from displaying the data sent to the SGB side through VRAM
	mSendPkg SGBPacket_FreezeScreen
	
	; Send 65816 code over to the SNES WRAM from 00:0810 to 00:0868.
	; Almost every SGB game sends this at startup, apparently it's a bugfix for the original SGB1 BIOS.
	; (SGB1b and SGB2 already have this code in memory)
	mSendPkg SGBPacket_SGB1BiosPatch7
	mSendPkg SGBPacket_SGB1BiosPatch6
	mSendPkg SGBPacket_SGB1BiosPatch5
	mSendPkg SGBPacket_SGB1BiosPatch4
	mSendPkg SGBPacket_SGB1BiosPatch3
	mSendPkg SGBPacket_SGB1BiosPatch2
	mSendPkg SGBPacket_SGB1BiosPatch1
	mSendPkg SGBPacket_SGB1BiosPatch0
	
	;-----------------------------------
	; FarCall into border loader, which also stops the LCD	
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(SGB_SendBorderData) ; BANK $04
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		call SGB_SendBorderData
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	
	
	ld   bc, $0078
	call SGB_DelayAfterPacketSendCustom
	
	; Clear the tilemap and zero out the BG palette to actually hide the SGB transfer leftovers.
	; Why isn't this part of SGB_SendBorderData, which tries to do something similar with the GFX?
	call ClearBGMap
	
	; Show white palette
	xor  a
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
		
	call Task_SkipAllAndWaitVBlank
	
	; Resume the screen since we're done now
	mSendPkg SGBPacket_ResumeScreen
	
	; Enable multicontroller support
	mSendPkg SGBPacket_EnableMultiJoy_2Pl
	
.switchToTakaraLogo:
	ei
	
	; Set the main task, which will point to the custom module code.
	
	; Switch to the bank with the TAKARA logo display
	ld   a, BANK(Module_TakaraLogo) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	
	; Have this as the first task
	ld   a, $01						; Task ID
	ld   bc, Module_TakaraLogo		; Target
	call Task_CreateAt
	
	jp   Task_GetNext

; =============== SGB_SendPackets ===============
; Sends one or more packets to the Super Game Boy.
; IN
; - HL: Ptr to packet structure (format: <number of packets><packet 0>[<packet 1>]...)
SGB_SendPackets:
	
	; The first byte marks the number of packets to send in the lower 3 bits.
	; These are stored one after the other in the ROM.
	ld   a, [hl]	; A = Number of packets
	and  a, $07		; SGB supports a max of 7 packets at once.
	ret  z			; If there are no packets, return
	
	
	ld   b, a		; B = Number of packets 
	
	; These packets are sent through the joypad register.
	ld   c, LOW(rJOYP)	; C = $FF00
	
.nextPacket:
	push bc				; Save for later
	
	; Send out the reset signal
	ld   a, SGB_BIT_RESET	; Reset
	ld   [c], a		
	ld   a, SGB_BIT_SEP		; Separator
	ld   [c], a
	
	; Send out the $10 bytes of the packet.
	; Each byte is sent out 1 bit at a time, from bit0 to bit7.
	ld   b, $10			; B = Remaining bytes to send out
.nextByte:
	ld   e, $08			; E = Remaining bits in the byte
	ldi  a, [hl]		; D = Byte to read
	ld   d, a
.nextBit:
	; Send out the bit.
	; If it's 0, send $20, otherwise send $10.
	; After a bit is sent out, a $30 is always sent.
	
	bit  0, d 			; Is the bit set?
	ld   a, SGB_BIT_1	; A = Value to send with bit set
	jr   nz, .sendBit	; If so, jump
.bitIs0:
	ld   a, SGB_BIT_0	; A = Value to send with bit cleared
.sendBit:
	ld   [c], a			; Send it out
	ld   a, SGB_BIT_SEP	; Send the separator
	ld   [c], a
	rr   d				; Rotate the next bit into bit0
	dec  e				; Sent all 8 bits?
	jr   nz, .nextBit	; If not, loop
	dec  b				; Sent all $10 bytes?
	jr   nz, .nextByte	; If not, loop
	
	ld   a, SGB_BIT_0	; Send last "stop" bit
	ld   [c], a
	ld   a, SGB_BIT_SEP
	ld   [c], a
	
	pop  bc			; Restore number of packets left
	
	dec  b			; All packets sent?
	ret  z			; If so, return
	
	call SGB_DelayAfterPacketSend
	jr   .nextPacket

; =============== SGB_DelayAfterPacketSend ===============
; Delays for a bit after sending a packet.
SGB_DelayAfterPacketSend:
	ld   de, $1B58
.loop:
	nop
	nop
	nop
	dec  de
	ld   a, d
	or   a, e
	jr   nz, .loop
	ret

; =============== IsSGBHardware ===============
; Detects if the system is a Super Game Boy.
; OUT
; - C flag: If set, the system is a SGB.
IsSGBHardware:
	;
	; Send out a MLT_REQ packet to enable the SNES second controller, then
	; check if any of the two controllers returns the proper controller ID.
	;
	; If we get the ID we're looking for, it means we're running under the SGB.
	;
	
	; Enable 2-player multicontroller support
	ld   hl, SGBPacket_EnableMultiJoy_2Pl
	call SGB_SendPackets
	call SGB_DelayAfterPacketSend
	
	; Check if this is the Player 2 controller, in case
	ldh  a, [rJOYP]		; Read the joypad status
	and  a, $03			
	cp   $03			; Is the second controller active? (rJOYP == $*E)
	jr   nz, .isSGB		; If so, we're running under the SGB
	
	; If it failed, it could be because the first controller may have been active.
	; Check the next one, hopefully turning the $*F return value (1P) into $*E (2P).
	
	; Switch to next controller (set bit 0, then 1)
	ld   a, SGB_BIT_0
	ldh  [rJOYP], a
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ld   a, SGB_BIT_SEP
	ldh  [rJOYP], a
	ld   a, SGB_BIT_1
	ldh  [rJOYP], a
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ld   a, SGB_BIT_SEP
	ldh  [rJOYP], a
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	
	; Do the same check again.
	and  a, $03
	cp   $03			; Is the second controller active?
	jr   nz, .isSGB		; If so, we're running under the SGB
.noSGB:
	; Otherwise, both controllers didn't report themselves as Controller 2.
	; This means there's no SGB.

	; Disable multicontroller support, just in case
	ld   hl, SGBPacket_DisableMultiJoy
	call SGB_SendPackets
	call SGB_DelayAfterPacketSend
	sub  a				; Return 0
	ret
.isSGB: 
	; Reselect back the first controller
	ld   hl, SGBPacket_DisableMultiJoy	
	call SGB_SendPackets
	call SGB_DelayAfterPacketSend
	scf  				; Return 1
	ret

; =============== SGB_DelayAfterPacketSendCustom ===============	
; Delays for the specified amount of times after sending a packet.
; IN
; - BC: Amount of times to wait $06D6 loops.
SGB_DelayAfterPacketSendCustom:
	; Total delay = BC * $06D6
	ld   de, $06D6
.loop:
	nop  
	nop  
	nop  
	dec  de
	ld   a, d
	or   e
	jr   nz, .loop
	dec  bc
	ld   a, b
	or   c
	jr   nz, SGB_DelayAfterPacketSendCustom
	ret  
; =============== OAMDMA ROUTINE ===============
; Copied in HRAM during init (don't use this directly).
OAMDMACode:
	; Wait for VBlank before continuing
	ldh  a, [rSTAT]
	bit  ST_VBLANK, a		; Are we in VBlank yet?
	jp   nz, hOAMDMA		; If not, loop

	ld   a, HIGH(wWorkOAM)	; Start DMA copy from WorkOAM ($DF00) to OAM
	ldh  [rDMA], a
	ld   a, $28				; Wait $28 ticks
.wait:
	dec  a
	jr   nz, .wait
	ret
.end:
; =============== DEFAULT SETTINGS ===============
DefaultSettings:
	db DIFFICULTY_NORMAL ; Difficulty: Normal
IF INF_TIMER == 1
	db TIMER_INFINITE ; Timer: inf.
ELSE
	db $90 ; Timer: 90 secs
ENDC
	db DEFAULT_DIPS ; Dip Switch: None
.end:

; =============== START OF TASK MANAGER ===============

; =============== Task_GetNext ===============
; Executes the main task cycle.
; See also: Task_PassControl for the routine calling this.
Task_GetNext:
	ld   sp, $DC00					; Set the standard stack pointer for taskman
.reloop:
	; Always search for tasks starting from the first one.
	; Since they get marked after execution, this won't cause double exec.
	ld   hl, hTaskTbl				; HL = Ptr to start ot task table
	ld   de, TASK_SIZE				; DE = Size of a task struct
	ld   bc, $0301					; B = Number of tasks; C = Current Task ID
.nextTask:
	ld   a, [wMisc_C026]			; Mark this since we should unset this later
	set  MISCB_LAG_FRAME, a
	ld   [wMisc_C026], a
	
	ld   a, [wMisc_C025]			
	bit  MISCB_SERIAL_LAG, a			; Is everything frozen?
	jp   nz, .execCommon			; If so, skip executing all tasks
	
	; If we can execute the task (marked as TASK_EXEC_TODO or TASK_EXEC_NEW), then do it
	ld   a, [hl]
	cp   TASK_EXEC_TODO				; taskType >= $04?
	jp   nc, .exec					; If so, execute it
	
	; Seek to the next task struct
	add  hl, de						; TaskPtr += sizeof(Task)
	inc  c							; TaskID++
	dec  b							; TasksLeft--; Any tasks left?
	jp   nz, .nextTask				; If so, loop.
.execCommon:
	; After all task are executed, run the common code and re-enable tasks
	call Task_ExecCommon
	; Recycle through them all
	jp   .reloop
	
.exec:
	ld   a, c						; Save the current task ID for later comparison
	ldh  [hCurTaskId], a			; Mark it as current task. This has an effect when the code we're executing calls the taskman back.
	
	ld   a, [hl]					; Read the task type

	ld   [hl], TASK_EXEC_CUR 		; Mark the task as executing
	inc  hl
	ld   [hl], $00
	inc  hl
	
	ld   e, [hl]					; Read out the task/stack ptr
	inc  hl
	ld   d, [hl]
	
	push de							; HL = DE
	pop  hl
	
	cp   TASK_EXEC_NEW				; Is this a new task?
	jp   nz, .oldTask				; If not, jump
.newTask:
	jp   hl							; Otherwise jump to (presumably) the task's init code
.oldTask:

	; Restore the state from when this task was created.
	ld   sp, hl						; Restore the stack pointer
	
	; The stack ptr was saved after pushing all regs into the stack in Task_PassControl.
	; Pop them all out to restore the original state and return safely.
	pop  af
	pop  bc
	pop  de
	pop  hl
	
	ret

; =============== Task_CreateAt ===============
; Writes a new task at the specified ID.
; IN
; - A = Task ID ($01 - $03)
; - BC = Ptr to init code of the task / module entry point
Task_CreateAt:
	di
	push af
	push bc
	push de
	push hl
	call Task_IndexTask
	ld   [hl], TASK_EXEC_NEW
	inc  hl
	ld   [hl], $00
	inc  hl
	ld   [hl], c
	inc  hl
	ld   [hl], b
	pop  hl
	pop  de
	pop  bc
	pop  af
	ei
	ret
; =============== Task_RemoveAt ===============
; Removes the task at the specified ID.
; IN
; - A = Task ID
Task_RemoveAt:
	di
	push af
	push bc
	push de
	push hl
	call Task_IndexTask
	ld   [hl], TASK_EXEC_NONE
	inc  hl
	ld   [hl], $00
	pop  hl
	pop  de
	pop  bc
	pop  af
	ei
	ret
; =============== Task_PassControlCustom ===============
; Pauses the current task and gives back control to the task system.
;
; HOW IT WORKS
;
; The task system is used to execute custom subroutines/multiple main loops with separate stacks in a cycle, as well
; as shared code which must always run on any main loop, like the sound engine and OBJLst writer.
;
; There are three task slots and two different ways to execute subroutines:
; TASK_EXEC_NEW -> Used for init code, when the task pointer points to code.
; TASK_EXEC_TODO -> Used for loop code, when the task pointer points to a stack.
;
; *ANY* time the task system is run through Task_PassControl, current slot is overwritten with an entry used
; to restore the original registers/SP, and is set to execute after all of the next slots + the common code is executed.
; This is important to allow cycling the same subroutine pointers if they aren't explicitly changed.
;
; Then the task table is iterated from the beginning until it finds an entry which can be executed.
; If one is found, the task is marked as being executed, the current slot is set to that, and the code is run. 
; This prevents the task from being executed again.
;
; To continue the cycle, the code which is called must manually call this subroutine again (or one of its stubs).
; 
; The same thing is done as before, until the entire task table is iterated. The common code which also waits for VBLANK
; is executed when that happens.
;
; The VBLANK handler also re-enables every task marked as TASK_EXEC_DONE as TASK_EXEC_TODO, and the task table is iterated again.
; This WILL lead to the first task being executed again, which returns to the original state from before the task handler was
; called for the first time, and so on.
;
; IN
; - A: How many frames to pause the task after it's executed. If $01, it won't be paused.
Task_PassControlCustom:

	; By calling this subroutine, we have to set the current stack location as a task, which
	; will replace the current one. Most of the time it does nothing but mark the task as executed,
	; but this also does replace the init task (TASK_EXEC_NEW) with the one for the main loop.

	
	;
	; Save all the status of all registers to the stack.
	;
	push hl
	push de
	push bc
	push af
	
	;
	; Replace current task with a new one (for the main loop) marked as executed.
	;
	push af
		call Task_IndexTaskAuto		; Get ptr for current task
		ld   [hl], TASK_EXEC_DONE	; Set it as type $01
		inc  hl
	pop  af
	
	ldi  [hl], a		; Set pause timer
	
	;
	; Copy SP to DE, then write it to the iTaskCodePtr fields.
	;
	push hl
		ld   hl, sp+$02	; +$02 since we just pushed hl, which moved the stack down by $02
		push hl
		pop  de
	pop  hl
	ld   [hl], e	; Write it out
	inc  hl
	ld   [hl], d
	
	; The task has been set, now execute the next ones with IDs higher than the current one
	jp   Task_GetNext

; =============== Task_PassControlFar ===============
; Wrapper for Task_PassControl_NoDelay which also saves the current bank number.
; Use when passing control from code in BANK $00 that needs a specific bank loaded.
Task_PassControlFar:
	ldh  a, [hROMBank]		; Save bank for when we're returning
	push af
	call Task_PassControl_NoDelay
	pop  af					; Restore bank
	ld   [MBC1RomBank], a	
	ldh  [hROMBank], a
	ret
	
; =============== Task_PassControl_* ===============
; Sets of wrappers to Task_PassControl with different pause timers.
Task_PassControl_NoDelay:
	ld   a, $01				; Delay for $01-1 frames before next exec
	jr   Task_PassControlCustom
; [TCRF] Unused.
Task_Unused_PassControl_Delay01: 
	ld   a, $02				; Delay for $02-1 frames before next exec
	jr   Task_PassControlCustom
Task_Unused_PassControl_Delay04:
	ld   a, $05				; ...
	jr   Task_PassControlCustom
Task_Unused_PassControl_Delay09:
	ld   a, $0A
	jr   Task_PassControlCustom
Task_PassControl_Delay1D:
	ld   a, $1E
	jr   Task_PassControlCustom
Task_PassControl_Delay3B:
	ld   a, $3C
	jr   Task_PassControlCustom
	
; =============== Task_RemoveCurAndPassControl ===============	
; Like Task_PassControl, except the current task is removed before passing control.
; Only used when the round ends, to remove player tasks.
Task_RemoveCurAndPassControl:
	di							; Pointless
	call Task_IndexTaskAuto		; Index current task
	ld   [hl], TASK_EXEC_NONE	; Disable it
	jp   Task_GetNext
	
; =============== Task_IndexTaskAuto ===============
; Indexes the task struct of the currently executing task.
Task_IndexTaskAuto:
	ldh  a, [hCurTaskId]	; A = Index to current task
	
; =============== Task_IndexTask ===============
; Indexes the specified task struct by ID.
; IN
; - A: Index to task ID (must be between $01 and $03)
; OUT
; - HL: Ptr to task struct
Task_IndexTask:
	; -$08 is due to the side effect of the first task ID starting at $01, and not $00.
	; ie: The task with ID $01 should point to the first entry of hTaskTbl, not at the second entry (and so on).
	ld   hl, hTaskTbl-$08	; HL = Start of task table - $08
	rlca			; Index = A * 8 (size of task info)
	rlca
	rlca
	ld   e, a
	ld   d, $00
	add  hl, de		; Seek to the entry
	ret

; =============== Task_SkipAllAndWaitVBlank ===============
; Waits for VBlank without executing any of the tasks or common code.
; Generally used for "paused" frames, where the game should stop animating
; sprites and playing music.
Task_SkipAllAndWaitVBlank:
	ld   a, $01
	ld   [wVBlankNotDone], a
	jp   Task_EndOfFrame
	
; =============== Task_Unused_SkipAllAndWaitVBlank_Copy ===============
; [TCRF] Unused copy of the above.
Task_Unused_SkipAllAndWaitVBlank_Copy:
	ld   a, $01
	ld   [wVBlankNotDone], a
	jp   Task_EndOfFrame
	
; =============== Task_ExecCommon ===============
; Executes the common tasks before waiting for VBLANK.
Task_ExecCommon:

	; Mark frame as executed -- wait for the VBlank handler below
	ld   a, $01
	ld   [wVBlankNotDone], a
	
	; If game is frozen, skip over these ones too
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_LAG, a			; Is it set?
	jp   nz, Task_EndOfFrame		; If so, skip
	
	call OBJLstS_WriteAll
	call SGB_SendSoundPacketAtFrameEnd
	call HomeCall_Sound_Do
	; Fall-through
	
; =============== Task_EndOfFrame ===============
Task_EndOfFrame:

	; Clear the lag frame marker since we made it in time.
	push hl
	ld   hl, wMisc_C026
	res  MISCB_LAG_FRAME, [hl]
	pop  hl
	
	; Wait in a loop until the VBlank handler triggers, which clears the flag
	; and marks all tasks for execution.
	; If we get here too late, the flag ends up not being cleared and we wait
	; for an extra frame.
	ei
	
.waitVBlank:
IF CPU_USAGE
	ld   a, [wVBlankNotDone]
	and  a
	ret  z
	halt
	jr   .waitVBlank		; In case something other than VBLANK occurred
ELSE
	ld   a, [wVBlankNotDone]
	or   a						; VBlank done yet?
	jp   nz, .waitVBlank		; If not, loop
	ret
ENDC

; =============== LCDCHandler ===============
; Handles parallax effects and screen sections.
LCDCHandler:
	push af
		ld   a, [wMisc_C028]
		bit  MISCB_USE_SECT, a		; Using the three-section HUD mode?
		jp   z, LCDCHandler_Title	; If not, jump (assume title screen)
	; Fall-through
	
; =============== LCDCHandler_Sect ===============
; Standard 3-section mode for the HUD.
;
; In this game it's only used to draw the HUD during gameplay by enabling and disabling the WINDOW
; (alongside setting other things) at fixed scanlines.
; Unlike KOF96, the same palette is used for both the HUD and main playfield.
LCDCHandler_Sect:
	
		ld   a, [wLCDCSectId]
		or   a						; SectId == 0?
		jp   nz, .sect3				; If not, jump
		
		;
		; Section 1 - Playfield
		;
	.sect2:
		; Wait in a loop before continuing, probably because HBlank time is short.
		; This should be using mWaitForNewHBlank to make it compatible with double speed mode.
		ld   a, $28
	.wait2:
		dec  a
		jp   nz, .wait2
		
		; Disable the WINDOW
		ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
		ldh  [rLCDC], a		
		; Set next section ID
		ld   [wLCDCSectId], a			; It just needs to be != 0
		
		; Set next trigger (hardcoded)
		ld   a, $6E
		ldh  [rLYC], a
	pop  af
	reti
	
		;
		; Section 2 - HUD
		;
	.sect3:
		; Wait in a loop, shorter likely because there are less sprites here.
		ld   a, $0A
	.wait3:
		dec  a
		jp   nz, .wait3
		
		; Enable the WINDOW
		; Due to how the WINDOW works, this resumes drawing from the point in the tilemap
		; we were when it got disabled. No need to touch the scroll registers.
		ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
		ldh  [rLCDC], a
	pop  af
	reti

; =============== LCDCHandler_Title ===============
; Handles the sections for the title screen.
LCDCHandler_Title:

		ld   a, [wLCDCSectId]
		or   a					; SectId == 0?
		jp   nz, .sect2			; If not, jump
	.sect1:
		;
		; Flash the fire palette depending off a timer.
		;
		
		; Do not do the effect if the screen is soft-disabled by a fully black palette.
		; This is the case while moving to the options/mode select screens.
		ldh  a, [rBGP]
		cp   $FF			; Is the fire palette completely black?
		jp   z, .setPal		; If so, don't change it
		
		; Since this goes off an incrementing timer, check bits in a way
		; to set palettes in a specific order.
		ld   a, [wTimer]
		bit  4, a				; Timer & $10 != 0?
		jp   nz, .chkSetPalT23	; If so, jump
		bit  3, a				; Timer & $08 != 0?
		jp   nz, .setPalT1		; If so, jump
	.setPalT0:
		ld   a, $1B				; #0
		jp   .setPal
	.setPalT1:
		ld   a, $2B				; #1
		jp   .setPal
	.chkSetPalT23:
		bit  3, a				; Timer & $08 != 0?
		jp   nz, .setPalT3		; If so, jump
	.setPalT2:
		ld   a, $0B				; #2
		jp   .setPal
	.setPalT3:
		ld   a, $17				; #3
	.setPal:
		ldh  [rBGP], a
		
		; Disable the WINDOW to show the scrolling fire on the BG layer
		ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
		ldh  [rLCDC], a		
		; Set next section ID
		ld   [wLCDCSectId], a			; It just needs to be != 0
		; Resume WINDOW on here.
		; The English version does this earlier because of the taller copyright box.
	IF VER_EN
		ld   a, $77
	ELSE
		ld   a, $87
	ENDC
		ldh  [rLYC], a
	pop  af
	reti

	.sect2:
		ld   a, $0A
	.wait2:
		dec  a
		jp   nz, .wait2
		; Enable the WINDOW
		ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
		ldh  [rLCDC], a
	pop  af
	reti
	
; =============== VBlankHandler ===============
; Long VBLANK handler.
VBlankHandler:
	di	
	
	push af
	push bc
	push de
	push hl
	
	ldh  a, [hROMBank]
	push af
	;--
	
	ld   hl, wMisc_C025
	bit  MISCB_SERIAL_MODE, [hl]	; Is serial mode enabled?
	jp   z, VBlank_ChkCopyPlTiles	; If not, skip
.serialVS:
	res  MISCB_SERIAL_LAG, [hl]			; Default to an unfrozen game
	
	;
	; Peculiar logic for resetting the "transfer complete" flag.
	;
	; If wSerialInputMode isn't set, it means buffered serial input mode isn't enabled.
	; The only point we get here where this is ever the case is when ModeSelect_SerialHandler is being used,
	; as it doesn't treat serial input the standard way -- instead, it treats single received bytes as commands.
	;
	; For some reason, the mode select screen never resets wSerialTransferDone on the *master* side,
	; and instead relies on the VBlank handler to clear it. Which is what we're checking now.
	;
	ld   a, [wSerialInputMode]
	or   a							; Buffered serial input enabled?
	jp   z, .resetSerialDone		; If not, jump
	
	;
	; In buffered input mode, never reset wSerialTransferDone to the master.
	;
	bit  MISCB_SERIAL_SLAVE, [hl]	; Are we set as slave?
	jp   nz, .slaveDelayChk			; If so, jump
	jp   VBlank_ChkCopyPlTiles		; Otherwise, skip
.slaveDelayChk:
	;
	; Panic scenario.
	; If there are no more inputs currently left to process, it means the master
	; hasn't managed to send out a new byte yet.
	; In that case, force the slave to wait/freeze until other bytes come in, otherwise
	; the GBs would desync.
	;
	ld   a, [wSerialReceivedLeft]
	or   a									; Is the balance of received/processed inputs 0?
	jp   nz, .resetSerialDone				; If not, jump
	ld   hl, wMisc_C025						; Freeze game while waiting for serial
	set  MISCB_SERIAL_LAG, [hl]	
	
	; Lessen the effect of the lag by always setting the latest input to the head of the send buffer.
	; (with the index staying as-is)
	ld   a, START_TRANSFER_EXTERNAL_CLOCK		; Force start listening
	ldh  [rSC], a					
	ld   hl, wSerialLagCounter					; PauseTimer++
	inc  [hl]
	ld   hl, wSerialPendingJoyKeys2				; Poll for 2P inputs (since only 2P is slave)
	call JoyKeys_Get_Standard
	call JoyKeys_Serial_SetNextTransfer			; Save those into the send buffer
	jp   VBlank_ChkCopyPlTiles
.resetSerialDone:
	xor  a
	ld   [wSerialTransferDone], a
	
; =============== VBlank_ChkCopyPlTiles ===============
; Determines if the player graphics should be copied to VRAM.
VBlank_ChkCopyPlTiles:
	ld   a, [wMisc_C026]
	bit  MISCB_LAG_FRAME, a			; Is this a lag frame?
	jp   nz, VBlank_SetInitialSect	; If so, don't update player gfx
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_LAG, a		; Is everything frozen?
	jp   nz, VBlank_SetInitialSect	; If so, also skip copying GFX
	ld   a, [wNoCopyGFXBuf]
	or   a							; Is the GFX copying outright disabled?
	jp   nz, VBlank_SetInitialSect	; If so, skip			

; =============== VBlank_CopyPl*Tiles ===============
; Set of subroutines for copying the player graphics across multiple frames during VBLANK.
;
; Each frame, at most 3 tiles get copied for each character.
; The player graphics are double buffered at two different VRAM slots.
;
; Note that the game always waits for a buffer to be filled before switching buffers
; and before continuing with the player animation/move. This also has the side effect
; that the amount of frames it takes to copy the graphics directly determines the anim speed.
;
; If the tiles were not being copied, the player would be stuck.

MAX_TILE_BUFFER_COPY EQU $03

; =============== mVBlank_CopyPlTiles ===============
; Generates code to copy a player's graphics to VRAM.
; IN
; - 1: Ptr to wPlInfo structure
; - 2: Ptr to wOBJInfo structure
; - 3: Ptr to wGFXBufInfo structure
MACRO mVBlank_CopyPlTiles

IF HITSTOP_FULL_DAMAGE == 0
	;
	; Deal less damage during hitstop by default.
	;
	; This is accomplished by preventing the animation frame from updating if hitstop
	; is enabled, which in turn prevents the next damage value from being set.
	; In practice, this has effect on the looping damage frames for air moves,
	; since the gravity continues to get applied while no damage is being dealt.
	;
	; Note that hitstop isn't enabled for counter hits.
	; Also, 96 still has this code, but it's skipped over and unreferenced.
	;

	ld   a, [\1+iPlInfo_Flags1]
	bit  PF1B_HITRECV, a			; Are we the player being hit?
	jp   nz, .canCopy				; If so, skip
	
	; PF2B_NODAMAGERATE is only set when special canceling a move after hitting the opponent,
	; and reset the frame after dealing damage.
	; Presumably this is here in case of canceling from a damage frame during hitstop, to force
	; the player's frame to update to the one for the new move.
	ld   a, [\1+iPlInfo_Flags2]
	bit  PF2B_NODAMAGERATE, a		; Did we *not* hit the opponent yet?
	jp   nz, .canCopy				; If so, jump
	ld   a, [wPlayHitstop]
	or   a							; Is hitstop enabled?
	jp   nz, .end					; If so, skip the GFX update for this player
ENDC

.canCopy:
	ld   a, [\3+iGFXBufInfo_TilesLeftA]
	or   a					; Any tiles left to transfer to buffer 0?
	jp   nz, .copyTo0		; If so, jump
	ld   a, [\3+iGFXBufInfo_TilesLeftB]
	or   a					; Any tiles left to transfer to buffer 1?
	jp   nz, .copyTo1		; If so, jump
	jp   .end				; If there's nothing, we're done
		
.copyTo0:
	;
	; Prepare the call to CopyTiles
	;

	; B = How many tiles to copy (+ update stat)
	ld   b, MAX_TILE_BUFFER_COPY	; B = MaxTiles
	cp   a, b						; TilesLeft >= MaxTiles?
	jp   nc, .notLast0				; If so, jump
	ld   b, a						; Otherwise, B = TilesLeft
									; Reaching this means this is the last set of tiles
.notLast0:
	sub  a, b								; TilesLeft -= TilesToCopy
	ld   [\3+iGFXBufInfo_TilesLeftA], a		; Update stat
	
	ld   a, [\3+iGFXBufInfo_DestPtr_Low]	; DE = Destination Ptr
	ld   e, a
	ld   a, [\3+iGFXBufInfo_DestPtr_High]
	ld   d, a
	ld   a, [\3+iGFXBufInfo_SrcPtrA_Low]	; HL = Source unc. gfx ptr
	ld   l, a
	ld   a, [\3+iGFXBufInfo_SrcPtrA_High]
	ld   h, a
	ld   a, [\3+iGFXBufInfo_BankA]			; A = Bank number the graphics are in
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call CopyTiles
	; Save the updated stats back, to resume next time
	ld   a, e
	ld   [\3+iGFXBufInfo_DestPtr_Low], a
	ld   a, d
	ld   [\3+iGFXBufInfo_DestPtr_High], a
	ld   a, l
	ld   [\3+iGFXBufInfo_SrcPtrA_Low], a
	ld   a, h
	ld   [\3+iGFXBufInfo_SrcPtrA_High], a
	jp   .chkCopyEnd
	
.copyTo1:
	; Same thing as before, but with the other buffer
	ld   b, MAX_TILE_BUFFER_COPY
	cp   a, b
	jp   nc, .notLast1
	ld   b, a
.notLast1:
	sub  a, b
	ld   [\3+iGFXBufInfo_TilesLeftB], a
	ld   a, [\3+iGFXBufInfo_DestPtr_Low]
	ld   e, a
	ld   a, [\3+iGFXBufInfo_DestPtr_High]
	ld   d, a
	ld   a, [\3+iGFXBufInfo_SrcPtrB_Low]
	ld   l, a
	ld   a, [\3+iGFXBufInfo_SrcPtrB_High]
	ld   h, a
	ld   a, [\3+iGFXBufInfo_BankB]
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call CopyTiles
	ld   a, e
	ld   [\3+iGFXBufInfo_DestPtr_Low], a
	ld   a, d
	ld   [\3+iGFXBufInfo_DestPtr_High], a
	ld   a, l
	ld   [\3+iGFXBufInfo_SrcPtrB_Low], a
	ld   a, h
	ld   [\3+iGFXBufInfo_SrcPtrB_High], a
	
.chkCopyEnd:

	; If there aren't any tiles left to copy in the buffer,
	; flag the copy as done so the game can actually decrement the frame timer.
	ld   a, [\3+iGFXBufInfo_TilesLeftA]
	or   a								; TilesLeft != 0?
	jp   nz, .end						; If so, skip
	ld   a, [\3+iGFXBufInfo_TilesLeftB]
	or   a								; TilesLeft != 0?
	jp   nz, .end						; If so, skip
	
.flagEnd:

	; Mark that the buffer operation is complete
	ld   hl, \2+iOBJInfo_Status
	res  OSTB_GFXLOAD, [hl]		; Buffer copied
	set  OSTB_GFXNEWLOAD, [hl]	; It got loaded this frame (gets reset when calling animation func)
	
	;--------
	; 
	; Used in conjunction with Play_Pl_SetMoveDamageNext to update the move damage settings mid-move,
	; syncronized to when the visible frame updates.
	;
	; Note that this is *NOT* used to update the damage values when a new move starts.
	; That's instead handled by Play_Pl_IsMoveLoading, which if needed has to be called manually at the start
	; of a move (MoveC_*), likely because there are special cases for updating those.
	;
	ld   hl, \1+iPlInfo_Flags2
	bit  PF2B_MOVESTART, [hl]		; Was a move started?
	jp   nz, .copySetKey			; If so, skip
	
	;
	; Copy the set of pending fields to the current ones if we were told to, and clear the former range.
	;
	; As long as iPlInfo_MoveDamageValNext is != 0, it means there are new values to copy over.
	; Any time the pending move damage fields are copied to the current set they get cleared,
	; so if they are still 0 it means no new value was set.
	; 
	ld   hl, \1+iPlInfo_MoveDamageValNext	; HL = Source
	ld   de, \1+iPlInfo_MoveDamageVal		; DE = Destination
	ld   a, [hl]
	or   a				; iPlInfo_MoveDamageValNext == 0?
	jp   z, .copySetKey	; If so, skip
	
.copyMoveOpt:
	ld   [de], a	; Copy iPlInfo_MoveDamageValNext to iPlInfo_MoveDamageVal	
	ld   [hl], $00	; Clear iPlInfo_MoveDamageValNext
	inc  de			; SrcPtr++
	inc  hl			; DestPtr++
	
	ld   a, [hl]	; A = iPlInfo_MoveDamageHitTypeIdNext
	ld   [de], a	; Copy iPlInfo_MoveDamageHitTypeIdNext to iPlInfo_MoveDamageHitTypeId	
	ld   [hl], $00	; Clear iPlInfo_MoveDamageHitTypeIdNext
	inc  de			; SrcPtr++
	inc  hl			; DestPtr++
	
	ld   a, [hl]	; A = iPlInfo_MoveDamageFlags3Next
	ld   [de], a	; Copy iPlInfo_MoveDamageFlags3Next to iPlInfo_MoveDamageFlags3	
	ld   [hl], $00	; Clear iPlInfo_MoveDamageFlags3Next
	
	;--------
.copySetKey:
	
	;
	; Sync the sprite mapping settings and unique identifier from the current/pending to displayed fields.
	;
	
	; Set key.
	; This unique identifier tells the wGFXBufInfo init code which settings were the last to be completely applied.
	; There's a special case there if we're switching to a new sprite mapping that's the same as
	; the last one we've loaded (read: it will skip the loading part).
	;
	ld   hl, \3+iGFXBufInfo_SetKey 		; HL = Source
	ld   de, \3+iGFXBufInfo_SetKeyView 	; DE = Destination
	
REPT 5
	ldi  a, [hl]
	ld   [de], a
	inc  de
ENDR
	ld   a, [hl]
	ld   [de], a
	
	; Sprite mapping settings.
	; This isn't necessary for the routine to draw sprite mappings, since it stops using the "*View" fields
	; when the graphics finish loading.
	; However, it is important for the move code since it tends to execute specific code depending on
	; the sprite mapping ID that's currently *visible*.
	ld   a, [\2+iOBJInfo_OBJLstFlags]
	ld   [\2+iOBJInfo_OBJLstFlagsView], a
	ld   a, [\2+iOBJInfo_BankNum]
	ld   [\2+iOBJInfo_BankNumView], a
	ld   a, [\2+iOBJInfo_OBJLstPtrTbl_Low]
	ld   [\2+iOBJInfo_OBJLstPtrTbl_LowView], a
	ld   a, [\2+iOBJInfo_OBJLstPtrTbl_High]
	ld   [\2+iOBJInfo_OBJLstPtrTbl_HighView], a
	ld   a, [\2+iOBJInfo_OBJLstPtrTblOffset]
	ld   [\2+iOBJInfo_OBJLstPtrTblOffsetView], a
.end:
ENDM


;
; 1P
;
VBlank_CopyPl1Tiles:
	mVBlank_CopyPlTiles wPlInfo_Pl1, wOBJInfo_Pl1, wGFXBufInfo_Pl1
;
; 2P
;
VBlank_CopyPl2Tiles:
	mVBlank_CopyPlTiles wPlInfo_Pl2, wOBJInfo_Pl2, wGFXBufInfo_Pl2

; =============== VBlank_SetInitialSect ===============
; Initializes the topmost screen section (which starts at LY $00), which may
; or may not be the only one depending if sections are enabled.
VBlank_SetInitialSect:
	ld   a, [wMisc_C028]
	bit  MISCB_USE_SECT, a		; Using HUD screen sections?
	jp   nz, .stdSect			; If so, jump
	bit  MISCB_TITLE_SECT, a	; In the title screen?
	jp   nz, .titleSect			; If so, jump
	jp   .singleSect			; Otherwise, we don't do anything special. Skip ahead.
	
.stdSect:
	;
	; Standard 3-section mode for the HUD.
	;
	ldh  a, [rSTAT]
	and  a, STAT_LYC			; LYC enabled?
	jp   z, .noScanlineInt		; If not, ignore this
	
	; Enable all
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	ldh  [rLCDC], a
	
	ld   a, $16					; Set starting point for second section 
	ldh  [rLYC], a
	xor  a						; Reset wLCDCSectId
	ld   [wLCDCSectId], a
	
	; If we have a lag frame or game is frozen, don't update sprites.
	; This avoids inconsistencies, even though it doesn't really matter as it's all purely visual.
	ld   a, [wMisc_C026]
	bit  MISCB_LAG_FRAME, a				
	jp   nz, .stdSect_noDMA
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_LAG, a
	jp   nz, .stdSect_noDMA
	call hOAMDMA
.stdSect_noDMA:
	jp   .setFirstSect			; Skip ahead
	
.titleSect:
	;
	; Title screen mode.
	; Like the single section mode, except there's a LYC trigger.
	;
	ldh  a, [rSTAT]
	and  a, STAT_LYC		; LYC enabled?
	jp   z, .noScanlineInt	; If not, ignore this
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	ldh  [rLCDC], a
IF VER_EN
	; It starts 1 tile higher in the English version to make space for the extended copyright.
	ld   a, $57
ELSE
	ld   a, $5F				; Line where the parallax effect starts
ENDC	
	ldh  [rLYC], a
	ld   a, $1B
	ldh  [rBGP], a
.noScanlineInt:
	;
	; LYC was disabled
	;
	xor  a
	ld   [wLCDCSectId], a
.singleSect:
	;
	; No sections
	;
	call hOAMDMA
	
.setFirstSect:
	;
	; Shared code for setting up the first section
	;
	ldh  a, [hScrollY]			; Set X and Y pos
	ldh  [rSCY], a
	ldh  a, [hScrollX]
	ldh  [rSCX], a
	
; =============== VBlank_LastPart ===============
VBlank_LastPart:
	
	; If the current or other GB is lagging, skip directly to the end.
	; This prevents unsetting wVBlankNotDone or reading new inputs.

	; This is especially important for serial syncronization purposes,
	; as we don't want to set new inputs if we're lagging or if the
	; other is lagging and not sending us inputs to reply with fast enough.
	ld   a, [wMisc_C026]
	bit  MISCB_LAG_FRAME, a		; Are we lagging?
	jp   nz, .end				; If so, skip
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_LAG, a	; Did the other send at least one byte not yet processed?
	jp   nz, .end				; If not, skip
	
	call JoyKeys_Get			; Get player input
	ld   hl, wTimer				; GlobalTimer++
	inc  [hl]
	
	; Clear wVBlankNotDone. 
	; (why is this check even here -- it could be using "xor a" directly)
	ld   a, [wVBlankNotDone]
	or   a						; Status == 0?
	jr   z, .resetTasks			; If so, jump
	dec  a
	ld   [wVBlankNotDone], a
	
.resetTasks:

	;
	; Mark for execution all of the previously executed tasks with no pause timer
	;
	ld   hl, hTaskTbl		; HL = Start of task table
	ld   de, TASK_SIZE		; DE = Task size
	ld   b, $03				; B = Tasks left
.loop:
	bit  0, [hl]			; Type == TASK_EXEC_DONE?
	jp   z, .nextTask		; If not, skip
	
	inc  hl					; Seek to iTaskPauseTimer
	dec  [hl]				; PauseTimer--
	dec  hl					; Seek back
	
	jp   nz, .nextTask		; Is the PauseTimer != 0? If so, skip
	ld   [hl], TASK_EXEC_TODO	; Otherwise, mark it for execution
.nextTask:
	add  hl, de				; HL += TASK_SIZE
	dec  b					; All tasks checked?
	jp   nz, .loop			; If not, loop
.end:
	
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a	
	pop  hl
	pop  de
	pop  bc
	pop  af
	reti

; =============== OBJLstS_WriteAll ===============
; Handles the sprites.
OBJLstS_WriteAll:
	push af
	push bc
	push de
	push hl
	
	; Save the current ROM bank since we'll be bankswitching for sprite mappings
	ldh  a, [hROMBank]
	push af
	
	; Initialize the pointer to the start of WorkOAM
	ld   a, LOW(wWorkOAM)
	ld   [wWorkOAMCurPtr_Low], a
	ld   a, HIGH(wWorkOAM)
	ld   [wWorkOAMCurPtr_High], a
	
	; If we're outside of gameplay, the priority checks and especially the player range enforcement should not be done.
	ld   a, [wMisc_C028]
	bit  MISCB_PL_RANGE_CHECK, a	; Is the bit set (checks enabled)?
	jp   z, .noGameplay				; If not, jump
	
.inGameplay:
	;
	; Switch player draw order every frame.
	; (so players flicker instead of being erased by the OBJ limit)
	;
	ld   a, [wTimer]
	bit  0, a						; wTimer % 2 != 0?
	jp   nz, .pl2Priority			; If so, jump
	
.pl1Priority:
	call Pl1_KeepInScreenRange
	call Pl2_KeepInScreenRange
	ld   hl, wOBJInfo2
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo3
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo4
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo5
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo_Pl1
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo_Pl2
	call OBJLstS_DoOBJInfoSlot
	jp   .finalizeOAM
.pl2Priority:
	call Pl2_KeepInScreenRange
	call Pl1_KeepInScreenRange
	ld   hl, wOBJInfo3
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo2
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo5
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo4
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo_Pl2
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo_Pl1
	call OBJLstS_DoOBJInfoSlot
.finalizeOAM:

	;
	; Clear the rest of the OAM entries, to avoid keeping unused OBJ from the previous frame.
	;
	
	ld   a, [wWorkOAMCurPtr_Low]	; HL = Current location of the OBJ writer	
	ld   l, a
	ld   a, [wWorkOAMCurPtr_High]
	ld   h, a
	ld   a, LOW(wWorkOAM_End)		; A = End of WorkOAM
.clrLoop:
	cp   l							; wWorkOAM_End < HL?
	jp   c, .end					; If so, jump
	ld   [hl], $00					; Clear first byte, which hides the sprite
	inc  hl							; HL += 4 (next entry)
	inc  hl
	inc  hl
	inc  hl
	jp   .clrLoop
	
.end:
	; Restore the previous bank
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	
	pop  hl
	pop  de
	pop  bc
	pop  af
	ret
	
.noGameplay:
	ld   hl, wOBJInfo0
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo1
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo2
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo3
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo4
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo5
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo6
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo7
	call OBJLstS_DoOBJInfoSlot
	ld   hl, wOBJInfo8
	call OBJLstS_DoOBJInfoSlot
	jp   .finalizeOAM

; =============== mPL_KeepInScreenRange ===============
; Generates code to keep a player in the viewport's range.
; The viewport range is considered to be the area between $10-$A0 (+$08)
; IN
; - 1: Ptr to start of OBJInfo
MACRO mPL_KeepInScreenRange
	; Ignore if the player isn't visible
	ld   a, [\1+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a	; Visibility flag set?
	ret  z					; If not, return
	
	xor  a					; Clear movement amount
	ld   [\1+iOBJInfo_RangeMoveAmount], a
	
	;
	; Determine the distance between the player position and the viewport's (left) position.
	; If the distance is too small (player near the left border of the screen) or too large (near the right border),
	; forcefully try to keep it in range.
	;
	; These checks go off the player positions as they would appear on-screen, therefore the hardware offset
	; is taken into account. (+$08px horizontally)
	;
	
	; Take the relative X position into account, since that's outside of iOBJInfo_X
	; B = -OBJScrollX
	ld   a, [wOBJScrollX]	; Invert as it simulates wScrollX behaviour
	cpl
	inc  a
	ld   b, a
	
	; Diff = PlayerX + $08 - ScrollX
	ld   a, [\1+iOBJInfo_X]
	add  b					; -= ScrollX
	add  a, OBJ_OFFSET_X	; + $08
	
	cp   $10				; Diff < $10?
	jp   c, .forceRangeL	; If so, jump
	cp   SCREEN_H			; Diff >= $A0?
	jp   nc, .forceRangeR	; If so, jump
	ret						; Otherwise, nothing to do
	
.forceRangeL:
	; Determine how many pixels the player is off-screen.
	; MoveAmount = -(Diff - $10)
	sub  a, $10			; Subtract $10 to determine how many off-screen pixels
	cpl					; (Diff - $10) will be always negative, so force it back to positive
	inc  a
	ld   [\1+iOBJInfo_RangeMoveAmount], a		; Save it here
	ld   b, a
	
	; PlayerX += MoveAmount
	ld   a, [\1+iOBJInfo_X]
	add  b			; Add that positive value here to force it to the left border
	ld   [\1+iOBJInfo_X], a
	ret
	
.forceRangeR:
	; Determine how many pixels the player is off-screen.
	; MoveAmount = -(Diff - $A0)
	sub  a, SCREEN_H	; Subtract $A0 to determine how many off-screen pixels
	cpl					; (Diff - $A0) will always be positive, so force the value to negative
	inc  a
	ld   [\1+iOBJInfo_RangeMoveAmount], a		; Save it here
	ld   b, a
	
	; PlayerX -= MoveAmount
	ld   a, [\1+iOBJInfo_X]
	add  b			; Add that negative value here to force it to the right border
	ld   [\1+iOBJInfo_X], a
	ret
ENDM

; =============== Pl1_KeepInScreenRange ===============
; Keeps Player 1 in the viewport's range.
Pl1_KeepInScreenRange: mPL_KeepInScreenRange wOBJInfo_Pl1
; =============== Pl2_KeepInScreenRange ===============
; Keeps Player 2 in the viewport's range.
Pl2_KeepInScreenRange: mPL_KeepInScreenRange wOBJInfo_Pl2

OBJLstS_DoOBJInfoSlot:

	; If the sprite is hidden, don't draw it to OAM
	ldi  a, [hl]				; Read iOBJInfo_Status
	bit  OSTB_VISIBLE, a		; Visibility flag set?
	ret  z						; If not, return
	
	ld   b, a						
	ld   [wOBJLstTmpROMFlags], a	
	ld   [wOBJLstCurStatus], a	; Copy iOBJInfo_Status here
	
	;
	; This game uses double buffering, meaning two sets of GFX buffers are used, as well as two copies of the sprite mapping info.
	; The GFX buffer to use is determined by the flag OST_GFXBUF2, and the buffers work as you'd expect by alternating between
	; buffer every other sprite mapping frame.
	; The two sprite mapping sets instead have a specific role:
	; - The first one (unnamed) always contains the info for the current/new sprite mapping,
	;   which MAY or MAY NOT be still loading GFX.
	; - The second one ("Old") contains a copy of the info for the last fully rendered sprite mapping
	;   which is ONLY used to display the old sprite mapping while the GFX in the first set are still being loaded.
	;
	; The global flag OST_GFXLOAD determines if the graphics for the first set are still being loaded.
	; If it is, the sprite mapping in the second set must be used. Also, since OST_GFXBUF2 always points to the new buffer,
	; that flag must be inverted before being used to make it point to the old buffer (see .chkBuf).
	;
		
	; 
	; If GFX are loading, use the old user-defined sprite mapping flags.
	; This value will not be changed again in this subroutine -- and will be later xor'd over with wOBJLstCurStatus.
	; 
	bit  OSTB_GFXLOAD, a		; GFX loading for new sprite mapping?
	jp   nz, .useOldStatus		; If so, jump
.useCurStatus:	
	ldi  a, [hl]				; Read iOBJInfo_OBJLstFlags	
	ld   [wOBJLstOrigFlags], a
	inc  hl						; Seek to iOBJInfo_X
	jp   .calcRelX
.useOldStatus:
	inc  hl
	ldi  a, [hl]				; Read iOBJInfo_OBJLstFlagsView, seek to iOBJInfo_X
	ld   [wOBJLstOrigFlags], a

.calcRelX:
	;--
	;
	; Determine the relative X position of the sprite mapping.
	; RelX = AbsoluteX - BaseX + OBJ_OFFSET_X
	;
	; The wOBJScroll* values are "inverted", to simulate how scrolling the screen right would move the BG left.
	; So here, setting wOBJScrollX to 5 will move the sprites left by 5px.
	;
	; This is done this way to allow easy sync with the BG scrolling during gameplay -- as one of the
	; main purposes of these values is to move all sprites accordingly when the playfield scrolls.
	;

	; C = Sprite X position
	ld   c, [hl]				; Read iOBJInfo_X
	; A = -BaseX
	ld   a, [wOBJScrollX]
	cpl
	inc  a
	
	add  c						; A = XPos - BaseX
	add  a, OBJ_OFFSET_X		; A += OBJ_OFFSET_X
	
	; Seek to next entry (this has 2 bytes assigned?)
	inc  hl						; HL += 2
	inc  hl
	ld   [wOBJLstCurRelX], a	; Save the result here
	
	
.calcRelY:
	;--
	;
	; Determine the relative Y position of the sprite mapping.
	; RelY = AbsoluteY - BaseY
	;
	
	; C = Sprite Y position
	ld   c, [hl]				; Read iOBJInfo_Y
	; A = -BaseY
	ld   a, [wOBJScrollY]
	cpl
	inc  a
	
	add  c						; A = YPos - BaseY
	; Seek to next entry (this has 2 bytes assigned?)
	inc  hl						; HL += 2
	inc  hl
	ld   [wOBJLstCurRelY], a
	
.setRelPos:
	;--
	;
	; Save the relative positions to the sprite info
	;
	; $07
	inc  hl					; HL += 4
	inc  hl
	inc  hl
	inc  hl
	
	; $0B
	ld   a, [wOBJLstCurRelX]
	ldi  [hl], a			; Save to iOBJInfo_RelX
	; $0C
	ld   a, [wOBJLstCurRelY]
	ldi  [hl], a			; Save to iOBJInfo_RelY
	
	;--
	;
	; Get the base tile ID number for the sprite mapping and store it to C.
	; All sprites in the sprite mapping have the tileID number relative to this,
	; since the graphics can be potentially loaded at any position in VRAM.
	;
	
	ld   c, [hl]			; Read iOBJInfo_TileIDBase
	inc  hl
	
.chkBuf:
	;
	; Pick the additional tileID offset depending on the current GFX buffer.
	; The two buffers are $20 tiles large, and if we're using the second one,
	; add $20 to the tileID.
	; 
	; Additionally, if GFX are still loading use the old buffer.
	;
	
	ld   a, b				; Read back status
	bit  OSTB_GFXLOAD, a	; GFX loading for new sprite mapping?
	jr   z, .noInvTileBit	; If not, skip
	xor  OST_GFXBUF2		; Otherwise, use old buffer
.noInvTileBit:

	
	bit  OSTB_GFXBUF2, a	; Are we using the second *GFX* buffer?
	jp   z, .noAdd20		; If not, skip
	ld   a, $20				; A = iOBJInfo_TileIDBase + $20
	add  c
	ld   c, a
.noAdd20:
	inc  hl
	inc  hl
	
	;--
	; If GFX are still loading display the old sprite mapping.
	;
	; The sprite mapping offset (iOBJInfo_OBJLstPtrTblOffset*) is always a multiple of $04,
	; because each entry in the table has space for 2 sprite mapping pointers (parts A and B).
	;
	; Note that, even though the Current set gets copied to the Old one, the check with
	; OSTB_GFXLOAD still needs to be made, as *NOT* all sprite mappings load their graphics dynamically.
	; Some of those that don't (and therefore, never have OSTB_GFXLOAD set), only have
	; the current set info specified, while having unusable garbage in the old set.
	;
;----------
	; $10 
	push bc
		bit  OSTB_GFXLOAD, b	; GFX loading for new sprite mapping?
		jr   nz, .useOldOBJLst	; If so, jump
		
	.useCurOBJLst:
		ldi  a, [hl]			; Read iOBJInfo_BankNum
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		; $11
		ld   e, [hl]			; Read iOBJInfo_OBJLstPtrTbl_Low
		inc  hl
		; $12
		ld   d, [hl]			; Read iOBJInfo_OBJLstPtrTbl_High
		inc  hl
		; $13
		ld   c, [hl]			; Read iOBJInfo_OBJLstPtrTblOffset
		inc  hl
		
		; Skip to byte18
		inc  hl
		inc  hl
		inc  hl
		inc  hl
		; $18
		jr   .drawMainOBJ
	.useOldOBJLst:
		; Use the secondary set
		
		; Skip to byte14
		inc  hl
		inc  hl
		inc  hl
		inc  hl
		; $14
		ldi  a, [hl]			; Read iOBJInfo_BankNumView
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		; $15
		ld   e, [hl]			; Read iOBJInfo_OBJLstPtrTbl_LowView
		inc  hl
		; $16
		ld   d, [hl]			; Read iOBJInfo_OBJLstPtrTbl_HighView
		inc  hl
		; $17
		ld   c, [hl]			; Read iOBJInfo_OBJLstPtrTblOffsetView
		inc  hl
		; $18
		
	.drawMainOBJ:

		; Switch HL and DE
		push de
		push hl
		pop  de
		pop  hl
		
		;
		; Index the sprite mapping table
		;
		
		; HL = Start of OBJLstPtrTable (animation/sprite mappings table)
		ld   b, $00		; BC = Index
		add  hl, bc		; Offset it
	pop  bc
;----------


	;
	; To build the full sprite, *up to* two different OBJLst are copied (marked as parts A and B).
	; The reasoning behind this is to save space by reusing half of the sprites for different frames,
	; with B usually being used for the legs and A for the upper part.
	;

	; The first sprite mapping is always defined
	push hl	
	call OBJLstS_DoOBJLstHeaderA
	pop  hl
	
.chkDrawSecOBJ:
	;
	; Try to draw the secondary sprite mapping, if it's defined.
	; If it isn't defined, its pointer in the animation table will be set to $FFFF.
	;
	
	; Seek to the next sprite mapping pointer.
	inc  hl
	inc  hl
	; Read it out to DE
	ld   e, [hl]
	inc  hl
	ld   a, [hl]
	
	cp   HIGH(OBJLSTPTR_NONE) ; Is the high byte $FF? ($FFFF)
	ret  z                    ; If so, there's nothing else to draw
	ld   d, a
	
	; HL = DE
	push de
	pop  hl
	
	jp   OBJLstS_DoOBJLstHeaderB

; =============== OBJLstS_DoOBJLstHeaderA ===============
; Parses out the header for the primary sprite mapping before writing it to the OAM mirror.
; IN
; - HL: Ptr to OBJLstPtrTable entry
; - DE: Ptr to actor/wOBJInfo struct byte18
; - C : Tile ID base
OBJLstS_DoOBJLstHeaderA:

	;--
	;
	; Read out to HL the pointer off the animation table.
	; This will point to the header of the actual sprite mapping (OBJLst).
	;
	push de
		; Read ptr to DE
		ld   e, [hl]	
		inc  hl
		ld   d, [hl]	
		; HL = DE
		push de			
		pop  hl
	pop  de
	;--
	
	; Now HL points to the start of a sprite mapping, at the header.
	
	;
	; BYTE 0 - Flags
	;
	
	; wOBJLstTmpROMFlags |= (iOBJLstHdrA_Flags & OLF_XFLIP|OLF_YFLIP)
	; Note that it's doing |=, so it's AND'ed over iOBJInfo_Status.
	
	; Get sprite mapping flags from ROM
	ldi  a, [hl]					; Read iOBJLstHdrA_Flags
	
	; Add the current X/Y flip flags on top of the existing ones
	and  a, OLF_XFLIP|OLF_YFLIP		; B = iOBJLstHdrA_Flags & OLF_XFLIP|OLF_YFLIP
	ld   b, a
	ld   a, [wOBJLstTmpROMFlags]	; wOBJLstTmpROMFlags |= B
	or   b
	ld   [wOBJLstTmpROMFlags], a
	
	;
	; BYTE 1 - Collision Box ID
	;
	
	; Copy over item1 to byte18
	ldi  a, [hl]	; Read iOBJLstHdrA_ColiBoxId
	ld   [de], a	; Write to iOBJInfo_ColiBoxId
	inc  de
	
	;
	; BYTE 2 - Hitbox ID
	;
	
	; Copy over item2 to byte19
	ldi  a, [hl]	; Read iOBJLstHdrA_HitBoxId
	ld   [de], a	; Write to iOBJInfo_HitboxId
	
	; $03
	inc  hl
	; $04
	inc  hl
	; $05
	inc  hl
	
	;
	; BYTE 6-7 - Sprite data pointer (iOBJLst_OBJCount)
	;
	
	; Save it to DE for OBJLstS_WriteToWorkOAM
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	
	; No X Offset in this game.
	
	;
	; BYTE 8 - Y Offset
	;
	ld   a, [hl]				; Read iOBJLstHdrA_YOffset
	ld   [wOBJLstCurYOffset], a
	
	jp   OBJLstS_WriteToWorkOAM
	
; =============== OBJLstS_DoOBJLstHeaderB ===============
; Parses out the header for the secondary sprite mapping before writing it to the OAM mirror.
; Compared to the primary sprite mapping, this seems to use a different format for the header.
; IN
; - HL: Ptr to start of second OBJLst (at the header)
; - C : Tile ID base (always after the one from the primary header)
OBJLstS_DoOBJLstHeaderB:

	;
	; BYTE 0 - Flags
	;
	
	; wOBJLstTmpROMFlags = iOBJInfo_Status | (iOBJLstHdrB_Flags & OLF_XFLIP|OLF_YFLIP)
	; The value of wOBJLstTmpROMFlags is contaminated with iOBJLstHdrA_Flags by the time we get here,
	; which is why it's using the untouched copy of iOBJInfo_Status in wOBJLstCurStatus.
	; 
	
	; Get sprite mapping flags from ROM
	ldi  a, [hl]					; Read iOBJLstHdrB_Flags
	
	; Add the X/Y flip flags on top of the existing ones
	and  a, OLF_XFLIP|OLF_YFLIP		
	ld   b, a
	ld   a, [wOBJLstCurStatus]
	or   b
	ld   [wOBJLstTmpROMFlags], a
	
	; $01
	inc  hl
	; $02
	inc  hl
	; $03
	inc  hl
	
	;
	; BYTE 4-5 - Sprite data pointer (iOBJLst_OBJCount)
	;
	; DE = Ptr at item4-5
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	
	; No X Offset in this game.
	
	;
	; BYTE 6 - Y Offset
	;
	ld   a, [hl]
	ld   [wOBJLstCurYOffset], a
; =============== OBJLstS_WriteToWorkOAM ===============
; IN
; - DE: Ptr to OBJLst data
; -  C: Tile ID base
OBJLstS_WriteToWorkOAM:

	; Move over the actual OBJ list from DE to HL
	; HL = Ptr to start of OBJLst (tile count, then table of "OBJ")
	push de
	pop  hl
	
	;
	; Read the cursor position for writing to OAM
	;
	ld   a, [wWorkOAMCurPtr_Low]	; DE = OAMPtr
	ld   e, a
	ld   a, [wWorkOAMCurPtr_High]
	ld   d, a
	
	;--
	;
	; Calculate the effective flags value for the sprite mapping.
	; Merge the sprite mapping X/Y flip options from ROM with the hardware OBJ flags in iOBJInfo_OBJLstFlags
	;
	
	; B = Default flip flags for the sprite mapping from ROM*.
	;     *after some merging with iOBJInfo_Status.
	ld   a, [wOBJLstTmpROMFlags]		
	and  a, OLF_XFLIP|OLF_YFLIP
	ld   b, a
	
	; A = User-controlled OBJ flags from iOBJInfo_OBJLstFlags*
	ld   a, [wOBJLstOrigFlags]		
	and  a, SPR_OBP1|SPR_XFLIP|SPR_YFLIP|SPR_BGPRIORITY
	
	; Xor the flags over
	xor  b			
	ld   [wOBJLstCurFlags], a
	
	;--
	;
	; Depending on the X/Y flipping combinations, offset the sprite mappings in a particular way,
	;
	
	and  a, OLF_XFLIP|OLF_YFLIP		; Filter X/Y flip options
	cp   OLF_XFLIP					; Flipped horizontally?
	jp   z, OBJLstS_Draw_XFlip		; If so, jump
	cp   OLF_YFLIP					; Flipped vertically?
	jp   z, OBJLstS_Draw_YFlip		; If so, jump
	cp   OLF_XFLIP|OLF_YFLIP		; Flipped horizontally + vertically?
	jp   z, OBJLstS_Draw_XYFlip		; If so, jump
									; Otherwise, no flipping
	
; =============== OBJLstS_Draw_*Flip ===============
; Set of subroutines to draw the individual sprites of a sprite mapping to WorkOAM.
; These are almost identical to each other -- the only differences involve the offsetting of the X/Y positions
; to account for the sprite mapping flipping.
;
; IN
; - HL: Ptr to OBJLst data
; -  C: Tile ID base

; =============== OBJLstS_Draw_NoFlip ===============
; XOffset: Normal
; YOffset: Normal
OBJLstS_Draw_NoFlip:	
	; Read the first byte of the OBJLst, which marks how many 8x16 sprites the sprite mapping contains.
	; After that the rest is a table of 3 byte structs:
	; - 0: XPos
	; - 1: YPos
	; - 2: TileID + Flags
	
	; B = Number of OBJ left
	; DE = WorkOAM Target
	; HL = Source OBJ list
	ld   b, [hl]	; Read iOBJLst_OBJCount
	inc  hl
	push bc			; Save total count for later
.loop:
	; The actual array of OBJ data follows
	
	push bc			; Save remaining count
	
	; Byte0: wOBJLstCurDispY + OBJYPos
	ld   b, [hl]				; Read out relative Y pos of the current OBJ
	inc  hl						; SrcPtr++
	;--
	; B = Calculated Y offset of the OBJ (wOBJLstCurYOffset + wOBJLstCurRelY, aka wOBJLstCurDispY)
	ld   a, [wOBJLstCurYOffset]	; Read the relative sprite mapping-specific Y offset
	add  b						; Add the relative Y position of the current OBJ
	ld   b, a
	;--
	ld   a, [wOBJLstCurRelY]	; Read Y origin
	add  b						; Add them together
	ld   [de], a				; Write it out
	inc  de						; OAMPtr++
	
	; Byte1: wOBJLstCurDispX + OBJXPos
	ld   b, [hl]				; Read out relative X pos
	inc  hl						; SrcPtr++
	ld   a, [wOBJLstCurRelX]	; Read X origin
	add  b						; Add them together
	ld   [de], a				; Write it out
	inc  de						; OAMPtr++
	
	;--
	; byte2 = (OBJTileId & $3F) + TileIDBase
	; The upper two bits of the byte always contain flags.
	; These must be removed from the tile ID.
	ldi  a, [hl]				; Read Tile ID
	push af
	and  a, $3F					; Remove upper two bits
	add  c						; Add tile ID base
	ld   [de], a
	inc  de
	pop  af
	
	;--
	; byte3 = wOBJLstCurFlags ^ (OBJTileId >> 1)
	; >> 1 because these are shifted by that amount from the proper values of OLFB_XFLIP and OLFB_YFLIP
	and  a, $C0						; Filter the upper two bits
	srl  a							; Shift flag bits to correct location
	ld   b, a						; B = Tile-specific flags
	ld   a, [wOBJLstCurFlags]		; A = Calculated flags
	xor  b							; Merge the flags
	ld   [de], a					; Save the result
	inc  de
	
	pop  bc				; Restore remaining count
	dec  b				; OBJLeft == 0?
	jr   nz, .loop		; If not, loop
	pop  bc				; Restore total OBJ count
	jp   OBJLstS_UpdateOAMPos		; Add it over to the stats

; =============== OBJLstS_Draw_XFlip ===============
; XOffset: -$08
; YOffset: Normal
OBJLstS_Draw_XFlip:
	ld   b, [hl]
	inc  hl
	push bc
.loop:
	push bc
	; Byte0: wOBJLstCurRelY + OBJYPos
	ld   b, [hl]
	inc  hl
	ld   a, [wOBJLstCurYOffset]
	add  b
	ld   b, a
	ld   a, [wOBJLstCurRelY]
	add  b
	ld   [de], a
	inc  de
	
	; Byte1: wOBJLstCurRelX - OBJXPos - $08
	ldi  a, [hl]				; Read out relative X pos
	cpl							; Invert bits (A = -A-1)
	sub  a, $07					; A -= 7
	ld   b, a
	ld   a, [wOBJLstCurRelX]
	add  b
	ld   [de], a
	inc  de
	
	;--
	; byte2 = (OBJTileId & $3F) + TileIDBase
	; The upper two bits of the byte always contain flags.
	; These must be removed from the tile ID.
	ldi  a, [hl]
	push af
	and  a, $3F
	add  c
	ld   [de], a
	inc  de
	pop  af
	
	;--
	; byte3 = wOBJLstCurFlags ^ (OBJTileId >> 1)
	and  a, $C0
	srl  a
	ld   b, a
	ld   a, [wOBJLstCurFlags]
	xor  b
	ld   [de], a
	inc  de
	;--
	
	pop  bc
	dec  b
	jr   nz, .loop
	pop  bc
	jp   OBJLstS_UpdateOAMPos
	
; =============== OBJLstS_Draw_YFlip ===============
; XOffset: Normal
; YOffset: +$50
OBJLstS_Draw_YFlip:
	ld   b, [hl]
	inc  hl
	push bc
.loop:
	push bc
	; Byte0: wOBJLstCurRelY - OBJYPos + $50 
	; To not break the sprite, this inverts the relative position of the single OBJ.
	; Because the Y positions of the individual OBJ are positive and never start at 0,
	; flipping them moves the sprite considerably up.
	; Moving them down by $50 happens to align them to the ground again.
	ldi  a, [hl]		; A = -OBJYPos 
	cpl
	sub  a, $AF			; A += $50
	ld   b, a			; B = A
	ld   a, [wOBJLstCurYOffset]
	add  b
	ld   b, a
	ld   a, [wOBJLstCurRelY]
	add  b				; byte0 = wOBJLstCurRelY + ($50 - OBJYPos)
	ld   [de], a
	inc  de
	
	; Byte1: OBJXPos + wOBJLstCurRelX
	ld   b, [hl]
	inc  hl
	ld   a, [wOBJLstCurRelX]
	add  b
	ld   [de], a
	inc  de
	
	;--
	; byte2 = (OBJTileId & $3F) + TileIDBase
	; The upper two bits of the byte always contain flags.
	; These must be removed from the tile ID.
	ldi  a, [hl]
	push af
	and  a, $3F
	add  c
	ld   [de], a
	inc  de
	pop  af
	
	;--
	; byte3 = wOBJLstCurFlags ^ (OBJTileId >> 1)
	and  a, $C0
	srl  a
	ld   b, a
	ld   a, [wOBJLstCurFlags]
	xor  b
	ld   [de], a
	inc  de
	;--
	
	pop  bc
	dec  b
	jr   nz, .loop
	pop  bc
	jp   OBJLstS_UpdateOAMPos
; =============== OBJLstS_Draw_YFlip ===============
; XOffset: -$08
; YOffset: +$50
OBJLstS_Draw_XYFlip:
	ld   b, [hl]
	inc  hl
	push bc
.loop:
	push bc
	
	; Byte0: wOBJLstCurRelY - OBJYPos + $50 
	ldi  a, [hl]
	cpl
	sub  a, $AF
	ld   b, a
	ld   a, [wOBJLstCurYOffset]
	add  b
	ld   b, a
	ld   a, [wOBJLstCurRelY]
	add  b
	ld   [de], a
	inc  de
	
	; Byte1: wOBJLstCurRelX - OBJXPos - $08
	ldi  a, [hl]
	cpl
	sub  a, $07
	ld   b, a
	ld   a, [wOBJLstCurRelX]
	add  b
	ld   [de], a
	inc  de
	
	;--
	; byte2 = (OBJTileId & $3F) + TileIDBase
	; The upper two bits of the byte always contain flags.
	; These must be removed from the tile ID.
	ldi  a, [hl]
	push af
	and  a, $3F
	add  c
	ld   [de], a
	inc  de
	pop  af
	
	;--
	; byte3 = wOBJLstCurFlags ^ (OBJTileId >> 1)
	and  a, $C0
	srl  a
	ld   b, a
	ld   a, [wOBJLstCurFlags]
	xor  b
	ld   [de], a
	inc  de
	;--
	
	pop  bc
	dec  b
	jr   nz, .loop
	pop  bc
	; Fall-through
	
; =============== OBJLstS_UpdateOAMPos ===============
OBJLstS_UpdateOAMPos:
	; Save new WorkOAM position
	ld   a, e						
	ld   [wWorkOAMCurPtr_Low], a
	ld   a, d
	ld   [wWorkOAMCurPtr_High], a
	
	; Update the tile ID base, in case there's a secondary sprite mapping at this slot.
	; C += B*2 (*2 since we're in 8x16 tile mode)
	ld   a, c	
	add  b
	add  b
	ld   c, a
	ret

; =============== OBJLstS_DoAnimTiming_Initial ===============
; Initializes the current animation frame.
; Essentially sets up the arguments for OBJLstS_UpdateGFXBufInfo without doing anything else.
; IN
; - HL: Ptr to wOBJInfo struct
OBJLstS_DoAnimTiming_Initial:
	ldh  a, [hROMBank]					; Save current bank
	push af
		res  OSTB_GFXNEWLOAD, [hl]		; Reset when processing
		push hl
			; Switch to the bank number
			ld   de, iOBJInfo_BankNum
			add  hl, de					; Seek to iOBJInfo_BankNum
			ldi  a, [hl]				; Get bank num
			ld   [MBC1RomBank], a		; Go there
			ldh  [hROMBank], a			
			
			; Get args
			ld   e, [hl]				; DE = Ptr to OBJLstPtrTable
			inc  hl
			ld   d, [hl]
			inc  hl
			ld   c, [hl]				; BC = Offset
			ld   b, $00
			
			; Switch DE and HL
			push de
			push hl
			pop  de						; DE = iOBJInfo_OBJLstPtrTblOffset
			pop  hl						; HL = Ptr to OBJLstPtrTable
			
			add  hl, bc					; Index it
										; HL = OBJLstPtrTable entry to OBJLstHdrA_*
			jp   OBJLstS_UpdateGFXBufInfo

; =============== OBJLstS_DoAnimTiming_Loop ===============
; Handles the timing for the current animation for the specified OBJInfo.
; When the animation ends, the animation loops back to the first frame.
;
; See also: OBJLstS_DoAnimTiming_NoLoop
;           Essentially identical except the section of code in .finished is different.
; IN
; - HL: Ptr to wOBJInfo struct				
OBJLstS_DoAnimTiming_Loop:
	ldh  a, [hROMBank]
	push af
		res  OSTB_GFXNEWLOAD, [hl]			; Reset when processing
			
		;
		; If the animation is marked as ended or GFX are still being copied to the other buffer,
		; don't even decrement the frame counter.
		;
		ld   a, [hl]
		and  a, OST_ANIMEND|OST_GFXLOAD		; Any of the two bits set?
		jp   nz, OBJLstS_CommonAnim_End		; If so, return immediately
		
		;
		; Continue showing the current animation frame until iOBJInfo_FrameLeft elapses.
		;
		push hl
			ld   de, iOBJInfo_FrameLeft		; Seek to anim timer iOBJInfo_FrameLeft
			add  hl, de
			ld   a, [hl]
			or   a							; Is it $00?
			jp   z, .setNextFrame			; If so, jump
			dec  a							; Otherwise, decrement the timer		
			ld   [hl], a					; And save it back
		pop  hl								; HL = Ptr to wOBJInfo
		jp   OBJLstS_CommonAnim_End			; We're done for now
		
		.setNextFrame:
			;
			; Set the anim timer to the animation speed value.
			;
			inc  hl							; Seek to iOBJInfo_FrameTotal
			ldd  a, [hl]					; Read total frame length; seek back to iOBJInfo_FrameLeft
			ld   [hl], a					; Set it to the anim timer
		pop  hl								; HL = Ptr to wOBJInfo
		
		;
		; Set the next sprite mapping in the list, according to the current OBJLstPtrTbl
		;
		push hl
			ld   de, iOBJInfo_BankNum		; Seek to bank number
			add  hl, de
			
			ldi  a, [hl]					; Read it
			ld   [MBC1RomBank], a			; Switch banks there
			ldh  [hROMBank], a
			
			; Gets args
			ld   e, [hl]				; DE = Ptr to OBJLstPtrTable
			inc  hl
			ld   d, [hl]
			inc  hl
			
			; Seek to the next entry in the table, and also save back the updated value
			ld   a, [hl]				; A = Offset + $04
			add  a, OBJLSTPTR_ENTRYSIZE
			ld   [hl], a
			ld   b, $00					; BC = New offset
			ld   c, a
			
			; Switch DE and HL
			push de
			push hl
			pop  de						; DE = iOBJInfo_OBJLstPtrTblOffset
			pop  hl						; HL = Ptr to OBJLstPtrTable entry
			
			;
			; Determine if the OBJLstHdrA_* pointer is "null" ($FFFF).
			; If it is, the animation has ended and should loop.
			; Otherwise, continue normally with the updated iOBJInfo_OBJLstPtrTblOffset.
			;
			push hl
				add  hl, bc				; Seek to current OBJLst ptr
				inc  hl					; Seek to high byte of ptr (since it can't happen to be $FF for valid pointers)
				ld   a, [hl]			; Read high byte of ptr
				cp   HIGH(OBJLSTPTR_NONE); Is it $FF?
				jp   nz, .nextOk		; If not, jump (this is a valid pointer)
			.finished:
			;------------------------
				; Otherwise, reset the offset
				xor  a
				ld   [de], a			; iOBJInfo_OBJLstPtrTblOffset = 0
			pop  hl						; HL = Ptr to OBJLstPtrTable entry
			jp   OBJLstS_UpdateGFXBufInfo
			;------------------------
			.nextOk:
				dec  hl					; Seek back to the low byte of the OBJLstHdrA_* ptr		
			pop  de						; Don't pop to hl, keep the OBJLstPtrTable entry 
; =============== OBJLstS_UpdateGFXBufInfo ===============
; Common code for setting up the initial state of new GFX buffer info.
;
; POP BEFORE RET: 2
; IN
; - HL: OBJLstPtrTable entry to OBJLstHdrA_*
; - (SP+2): Ptr to wOBJInfo struct
OBJLstS_UpdateGFXBufInfo:
		pop  bc				; BC = Ptr to wOBJInfo struct
		
		;
		; Seek to the first byte of OBJLstHdrA_*
		;
		
		; DE = Ptr to OBJLstHdrA_*
		ld   e, [hl]
		inc  hl
		ld   d, [hl]
		inc  hl				; To second ptr
		
		; Switch pointers
		push de
		push hl
		pop  de		; DE = OBJLstPtrTable entry to OBJLstHdrB_*
		pop  hl		; HL = Ptr to OBJLstHdrA_*
		
		;
		; If this sprite mapping doesn't use the GFX buffer system, we're done.
		;
		bit  OLFB_NOBUF, [hl]			; Is the flag set?
		jp   nz, OBJLstS_CommonAnim_End	; If so, return
		
	.useBuf:
		push bc
			
			;
			; Determine if the buffer should be switched or not.
			;
			; When following animations normally, we won't get here until the other GFX buffer is fully written to (OSTB_GFXLOAD clear).
			; In that case, switch the buffers and set back the OSTB_GFXLOAD flag, saving the result back.
			;
			; However, if we got here with an incomplete buffer, keep using it, so the new GFX will be written at its start.
			; 

			; Save the original iOBJInfo_Status value to a temp location.
			ld   a, [bc]
			ld   [wOBJLstTmpStatusOld], a
			
			bit  OSTB_GFXLOAD, a		; Is the buffer ready yet?
			jp   nz, .gfxNotDone		; If not, jump
		.gfxDone:
			xor  OST_GFXBUF2			; Use other buffer
			or   a, OST_GFXLOAD			; Set loading flag
			ld   [bc], a				; Save to iOBJInfo_Status
			
			; Also save to the temp copy we're checking against to determine the buffer's VRAM ptr
			ld   [wOBJLstTmpStatusNew], a	
			jp   .getArgs
		.gfxNotDone:
			; Nothing to change here, just copy it over.
			ld   [wOBJLstTmpStatusNew], a
			
			; Invert just in case we get to .identical (by interrupting moves in a certain way).
			; wOBJLstTmpStatusOld should always point to the opposite buffer of iOBJInfo_Status.
			xor  OST_GFXBUF2			
			ld   [wOBJLstTmpStatusOld], a	
		.getArgs:
			push de						; DE = OBJLstPtrTable entry to OBJLstHdrB_*
			
				;
				; Get the data off the wOBJInfo we need later for writing to the wGFXBufInfo
				;
			
				; DE = Ptr to start of wGFXBufInfo
				push hl
					ld   hl, iOBJInfo_BufInfoPtr_Low
					add  hl, bc						; Seek to iOBJInfo_BufInfoPtr_Low
					ld   e, [hl]					; Read low byte
					inc  hl
					ld   d, [hl]					; Read high byte
				pop  hl
				
				; Seek to iOBJLstHdrA_GFXPtr_Low
				inc  hl		; Seek to iOBJLstHdrA_ColiBoxId
				inc  hl     ; ...
				inc  hl
				
				; BC = Ptr to location in VRAM for copying tiles
				push hl
					ld   hl, iOBJInfo_VRAMPtr_Low ; Seek to iOBJInfo_VRAMPtr_Low
					add  hl, bc
					ld   c, [hl]					; Read low byte
					inc  hl
					ld   b, [hl]					; Read high byte
				pop  hl
				
				
				;
				; If we're using the second buffer, make the VRAM location point $20 tiles ahead,
				; which is the size of a single buffer.
				;
				; NOTE: If we didn't finish copying the tiles to the previous buffer,
				;       the old buffer will be used.
				;
				ld   a, [wOBJLstTmpStatusNew]
				bit  OSTB_GFXBUF2, a				; Using the second buffer?
				jp   z, .setBufInfo					; If not, skip
			.buf2:
				; B += $02
				ld   a, HIGH(TILESIZE * GFXBUF_TILECOUNT)						; BC += $0200
				add  b
				ld   b, a
				
			.setBufInfo:
			
				;
				; Write the data to the current wGFXBufInfo structure.
				;
			
				
				; VRAM destination ptr
				ld   a, c		; A = iOBJInfo_VRAMPtr_Low
				ld   [de], a	; Write to iGFXBufInfo_DestPtr_Low
				inc  de			; Seek to iGFXBufInfo_DestPtr_High
				ld   a, b		; A = iOBJInfo_VRAMPtr_High
				ld   [de], a	; Write to iGFXBufInfo_DestPtr_High
				inc  de			; Seek to iGFXBufInfo_SrcPtrA_Low
				
				; Source GFX ptr - Set A
				; HL = Source (iOBJLstHdrA_GFXPtr_Low)
				; DE = Destination (iGFXBufInfo_SrcPtrA_Low)
REPT 3
				ldi  a, [hl]	; Read from HL
				ld   [de], a	; Copy to DL
				inc  de			; Next
ENDR
				;--
				
				; BC = Ptr to OBJLst - Set A
				ld   c, [hl]	; C = iOBJLstHdrA_DataPtr_Low
				inc  hl
				ld   b, [hl]	; B = iOBJLstHdrA_DataPtr_High
				
				; Tiles remaining - Set A
				; Multiplied by 2 because OBJ are always 8x16 (so 2 tiles/OBJ)
				ld   a, [bc]	; A = iOBJLst_OBJCount
				add  a, a		; A *= 2
				ld   [de], a	; iGFXBufInfo_TilesLeftA = A
				
				inc  de			; Seek to iGFXBufInfo_SrcPtrB_Low
			pop  hl 			; HL = OBJLstPtrTable entry to OBJLstHdrB_*
			
			; Source GFX ptr - Set B
			; If high byte is $FF, there's no set B and we can skip this.
			ld   c, [hl]		; BC = Ptr to OBJLstHdrB_*
			inc  hl
			ld   b, [hl]
			ld   a, b
			cp   HIGH(OBJLSTPTR_NONE)	; B != $FF?
			jp   nz, .hasSetB			; If so, jump
			
		.noSetB:
			; Otherwise, null out the Set B info.
			xor  a
			ld   [de], a	; iGFXBufInfo_SrcPtrB_Low
			inc  de
			ld   [de], a	; iGFXBufInfo_SrcPtrB_High
			inc  de
			inc  de			; Ignore iGFXBufInfo_BankB, who cares
			ld   [de], a	; iGFXBufInfo_TilesLeftB
			inc  de			; Seek to iGFXBufInfo_SetKey
			jp   .chkMatches
			
		.hasSetB:
		
			; Source GFX ptr - Set B
			push bc
			pop  hl		; HL = iOBJLstHdrB_Flags
			inc  hl		; HL = Source (iOBJLstHdrB_GFXPtr_Low)
						; DE = Destination (iGFXBufInfo_SrcPtrB_Low)
REPT 3
			ldi  a, [hl]	; Read from HL
			ld   [de], a	; Copy to DL
			inc  de			; Next
ENDR
			;--
			
			; BC = Ptr to OBJLst - Set B
			ld   c, [hl]	; C = iOBJLstHdrB_DataPtr_Low
			inc  hl
			ld   b, [hl]	; B = iOBJLstHdrB_DataPtr_High
			
			; Tiles remaining - Set B
			ld   a, [bc]	; A = iOBJLst_OBJCount
			add  a, a		; A *= 2
			ld   [de], a	; iGFXBufInfo_TilesLeftB = A
			inc  de			; Seek to iGFXBufInfo_SetKey
			
		;------------------	
		.chkMatches:
		
			;
			; Check if the buffer set settings we just wrote are identical to the last one we fully applied in VBlankHandler.
			; If this is the case, treat the new frame as a continuation of this one, which also means to keep using
			; the old buffer info (and so, the old buffer flag from wOBJLstTmpStatusOld).
			;
			; A side effect of this is that the new frame will animate much faster -- since normally the game has to
			; wait for the graphics to load before decrementing the frame timer, but here the graphics are already loaded.
			;
			; Otherwise the settings identifier at iGFXBufInfo_SetKey is updated and we're done. 
			;
			
			; BC = Ptr to start of wGFXBufInfo struct
			ld   hl, -(iGFXBufInfo_SetKey-iGFXBufInfo_DestPtr_Low)
			add  hl, de
			push hl
			pop  bc
			
			; DE = Ptr to iGFXBufInfo_SetKeyView
			ld   hl, iGFXBufInfo_SetKeyView
			add  hl, bc
			push hl
			pop  de
			
			; HL = Ptr to iGFXBufInfo_SrcPtrA_Low
			ld   hl, iGFXBufInfo_SrcPtrA_Low
			add  hl, bc
			
			; Check if these match:
			; - iGFXBufInfo_SrcPtrA_Low  with iGFXBufInfo_SetKeyView
			; - iGFXBufInfo_SrcPtrA_High with iGFXBufInfo_SetKeyView+1
			; - iGFXBufInfo_BankA        with iGFXBufInfo_SetKeyView+2
			; If they don't take the jump
REPT 3
			ld   a, [de]		; A = CompInfo byte
			cp   a, [hl]		; Does it match the source Set A info?
			jp   nz, .different	; If not, jump
			inc  de				
			inc  hl
ENDR
			inc  hl				; Skip comparing iGFXBufInfo_TilesLeftA
			
			; Check if these match:
			; - iGFXBufInfo_SrcPtrB_Low  with iGFXBufInfo_SetKeyView+3
			; - iGFXBufInfo_SrcPtrB_High with iGFXBufInfo_SetKeyView+4
			; - iGFXBufInfo_BankB        with iGFXBufInfo_SetKeyView+5
			; If they don't take the jump			
REPT 2
			ld   a, [de]		; A = CompInfo byte
			cp   a, [hl]		; Does it match the source Set A info?
			jp   nz, .different	; If not, jump
			inc  de
			inc  hl
ENDR
			ld   a, [de]		; A = iGFXBufInfo_SetKeyView+5
			cp   a, [hl]		; Does it match with iGFXBufInfo_BankB?
			jp   nz, .different	; If not, jump
			
		.identical:
			; The new settings match the old settings.
			; There's no need to double buffer this.
			
			; Wipe them out for both sets (iGFXBufInfo_SrcPtrA_Low-iGFXBufInfo_TilesLeftB)
			ld   hl, iGFXBufInfo_SrcPtrA_Low
			add  hl, bc
			xor  a
REPT 8
			ldi  [hl], a
ENDR
		pop  bc			; BC = Ptr to wOBJInfo struct
		
		
		
		;
		; Act as if we were in VBLANK and just finished copying the GFX to a buffer.
		; Except that here both player wOBJInfo slots are handled instead of having two
		; different code paths.
		; See also: VBlank_CopyPl1Tiles.move1
		;
		
		
		; Reload old copy of iOBJInfo_Status with old OSTB_GFXBUF2 flag.
		ld   a, [wOBJLstTmpStatusOld]	; Get copy of iOBJInfo_Status
		res  OSTB_GFXLOAD, a			; Mark GFX as already loaded
		set  OSTB_GFXNEWLOAD, a				
		ld   [bc], a
		
		;
		; The buffer info is identical if we got here so there's no need to copy the set keys,
		; but the sprite mapping info in wOBJInfo could still be different.
		;
		
		; Copy over the current wOBJInfo slot info to the old one
		
		; Copy iOBJInfo_OBJLstFlags to iOBJInfo_OBJLstFlagsView
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, bc
		ldi  a, [hl]
		ld   [hl], a
		
		; Copy iOBJInfo_BankNum-iOBJInfo_OBJLstPtrTblOffset to the old fields
		ld   hl, iOBJInfo_BankNum	; DE = iOBJInfo_BankNum
		add  hl, bc					
		push hl
		pop  de
		ld   hl, iOBJInfo_BankNumView	; BC = iOBJInfo_BankNumView
		add  hl, bc
REPT 4
		ld   a, [de]				; Read from current data
		ldi  [hl], a				; Write to old data
		inc  de						; 
ENDR
		jp   OBJLstS_CommonAnim_End
		
		.different:
			; BC = Ptr to iGFXBufInfo_DestPtr_Low
			
			;
			; Update the current settings identifier (iGFXBufInfo_SetKey) by copying over the untouched Set settings we just wrote.
			;
			
			ld   hl, iGFXBufInfo_SetKey	; DE = iGFXBufInfo_SetKey
			add  hl, bc
			push hl
			pop  de
			ld   hl, iGFXBufInfo_SrcPtrA_Low	; HL = iGFXBufInfo_SrcPtrA_Low
			add  hl, bc
			
			; iGFXBufInfo_SrcPtrA_Low  -> iGFXBufInfo_SetKey
			; iGFXBufInfo_SrcPtrA_High -> iGFXBufInfo_SetKey+1
			; iGFXBufInfo_BankA        -> iGFXBufInfo_SetKey+2
REPT 3
			ldi  a, [hl]
			ld   [de], a
			inc  de
ENDR
			inc  hl
			
			; iGFXBufInfo_SrcPtrB_Low  with iGFXBufInfo_SetKey+3
			; iGFXBufInfo_SrcPtrB_High with iGFXBufInfo_SetKey+4
			; iGFXBufInfo_BankB        with iGFXBufInfo_SetKey+5
REPT 2
			ldi  a, [hl]
			ld   [de], a
			inc  de
ENDR
			ld   a, [hl]
			ld   [de], a
		pop  bc
		
	OBJLstS_CommonAnim_End:
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	
; =============== OBJLstS_InitFrom ===============
; Initializes an wOBJInfo structure.
; - HL: Ptr to start of wOBJInfo struct (destination)
; - DE: Ptr to wOBJInfo data (source)
OBJLstS_InitFrom:
	; Copy the first $1F bytes over, which are the main fields
	ld   b, iOBJInfo_RangeMoveAmount
.loopCp:
	ld   a, [de]				; Read from ROM
	inc  de						; SrcPtr++
	ldi  [hl], a				; Write to RAM, DestPtr++
	dec  b						; Copied all bytes?
	jr   nz, .loopCp			; If not, loop
	
	; Clear bytes $1F-$33
	ld   b, $14
	xor  a
.loopClr:
	ldi  [hl], a
	dec  b
	jr   nz, .loopClr
	ret
	
; =============== ClearOBJInfo ===============
; Zeroes out all of the nine wOBJInfo structures.
ClearOBJInfo:
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status			; HL = Initial addr
	ld   de, OBJINFO_SIZE * 9	; DE = Bytes to clear
	ld   b, $00					; B = Overwrite with
.loop:
	ld   a, b					; Write $00
	ldi  [hl], a
	dec  de						; BytesLeft--
	ld   a, d
	or   a, e					; BytesLeft == 0?
	jr   nz, .loop				; If not, loop
	ret
	
; =============== Clear*Map ===============
; Sets of subroutines for clearing tilemaps.

; =============== ClearBGMap ===============
ClearBGMap:
	ld   hl, BGMap_Begin			; HL = Tilemap Ptr
	ld   d, $00						; D  = Write $00
	jp   ClearTilemapCustom
; =============== ClearWINDOWMap ===============
ClearWINDOWMap:
	ld   hl, WINDOWMap_Begin		; HL = Tilemap Ptr
	ld   d, $00						; D  = Write $00
	jp   ClearTilemapCustom
; =============== Unused_ClearBGMapCustom ===============
; [TCRF] Not used in this game.
; IN
; - D: Value to set
Unused_ClearBGMapCustom:
	ld   hl, BGMap_Begin			; HL = Tilemap Ptr
	jp   ClearTilemapCustom
; =============== Unused_ClearWINDOWMapCustom ===============
; [TCRF] Not used in this game.
; IN
; - D: Value to set
Unused_ClearWINDOWMapCustom:
	ld   hl, WINDOWMap_Begin		; HL = Tilemap Ptr

; =============== ClearWINDOWMapCustom ===============
; IN
; - HL: Tilemap ptr
; -  D: Value to set	
ClearTilemapCustom:
	ld   bc, $0400					; BC = Bytes to clear
	
; =============== MemSetOnHBlankOrVBlank ===============
; Fills a memory range during HBlank or VBlank.
; Use for clearing VRAM.
; IN
; - HL: Starting address
; - BC: Bytes to overwrite
; -  D: Value to be set
MemSetOnHBlankOrVBlank:
	mWaitForVBlankOrHBlank
	ld   a, d			; Write D to HL 
	ldi  [hl], a		; HL++
	dec  bc				; BytesLeft--
	ld   a, b			; BC == 0?
	or   a, c
	jp   nz, MemSetOnHBlankOrVBlank	; If not, loop
	ret

; =============== CopyBGToRectWithBase ===============
; Copies a partial tilemap to a location in VRAM,
; with tile IDs offset by the specified value.
; IN
; - DE: Ptr to uncompressed tilemap
; - HL: Destination Ptr in VRAM
; - B: Rect Width
; - C: Rect Height
; - A: Tile ID base offset
CopyBGToRectWithBase:
	push bc			; Save height
		push hl			; Save tilemap ptr
		
		.rowLoop:
			push bc			; Save width
				push af			; Save tile ID base
					push af
						ld   a, [de]	; B = Relative tile ID
						ld   b, a
					pop  af
					
					add  b			; A = tile ID base + relative tile ID
					inc  de			; Next tile in tilemap
					
					push af			
					mWaitForVBlankOrHBlank	; In case we're calling it in the middle of the frame
					pop  af
					
					ldi  [hl], a
				pop  af 		; Restore tile ID base
			pop  bc			; Restore width
			dec  b				; Printed all tiles in the row?
			jp   nz, .rowLoop	; If not, jump
			
		pop  hl					; Rewind ptr to initial X value
		ld   bc, BG_TILECOUNT_H	; Move down by 1 tile
		add  hl, bc
	pop  bc			; Restore height
	dec  c							; Printed all rows?
	jr   nz, CopyBGToRectWithBase	; If not, jump
	ret
	
; =============== CopyBGToRect ===============
; Copies a partial tilemap to a location in VRAM.
; IN
; - DE: Ptr to uncompressed tilemap
; - HL: Destination Ptr in VRAM
; - B: Rect Width
; - C: Rect Height
CopyBGToRect:
	push bc						; Save rect dimensions
		push hl					; Save main destination ptr since we're moving down later
.loop:	
			mWaitForVBlankOrHBlank	; Since we're copying to VRAM
			
			ld   a, [de]		; Copy the tile over
			ldi  [hl], a		
			inc  de				; Dest++, Src++
			dec  b				; Copied the entire row?
			jp   nz, .loop		; If not, jump
		pop  hl					; Restore dest ptr
		ld   bc, BG_TILECOUNT_H	; Move down 1 tile
		add  hl, bc
	pop  bc						; Restore rect dimensions
	dec  c						; HeightLeft--
	jr   nz, CopyBGToRect		; Copied all rows? If not, jump
	ret

; =============== TextPrinter_MultiFrame_WithAbort ===============
; Prints a string across multiple frames, taking exclusive control of the current task until it finishes.
;
; This version of the subroutine allows early aborting, but not speeding up.
;
; Because of how this and the other TextPrinter_MultiFrame_* routine works, it's not possible
; to specify manual newlines. Every line must have the same number of characters.
; This got thrown out in 96, replaced by a completely different subroutine.
;
; IN
; - DE: Ptr to text data (list of tile IDs)
; - HL: Ptr to tilemap (Destination)
; - A: Delay between letter printing
; - B: Text width (number of characters in a line)
; - C: Text height (number of lines)
; OUT
; - C flag: If set, the printing was aborted early
TextPrinter_MultiFrame_WithAbort:
	push bc
		push hl
		.printLoop:
			;
			; Write the next letter to the tilemap, when HBlank hits.
			;
			push af
				mWaitForVBlankOrHBlank
				ld   a, [de]	; Read tile ID
				ldi  [hl], a	; Write to tilemap, move right
			pop  af
			
			;
			; Wait for the specified number of frames before printing the next letter.
			; 
			push af
			.delayLoop:
				push af
					; If either player pressed START, abort this early.
					ldh  a, [hJoyNewKeys]
					bit  KEYB_START, a		; Pressed START?
					jp   nz, .abort			; If so, jump
					ldh  a, [hJoyNewKeys2]
					bit  KEYB_START, a		; Pressed START?
					jp   nz, .abort			; If so, jump
					
					call Task_PassControl_NoDelay	; Wait frame
				pop  af
				dec  a					; Done waiting?
				jp   nz, .delayLoop		; If not, loop
			pop  af
			
			; Seek to next source tile
			inc  de
			dec  b				; Copied all characters in the line?
			jp   nz, .printLoop	; If not, loop
		
		; Seek to the next row
		pop  hl						; Restore ptr to start of row
		ld   bc, BG_TILECOUNT_H		; Move down by one tile
		add  hl, bc
	pop  bc
	dec  c							; Copied all rows?
	jr   nz, TextPrinter_MultiFrame_WithAbort	; If not, loop
	
	scf
	ccf		; C flag clear
	ret

				.abort:
				pop  af
			pop  af
		pop  hl
	pop  bc
	scf		; C flag set
	ret
	
; =============== TextPrinter_MultiFrame_WithSpeedup ===============
; Prints a string across multiple frames, taking exclusive control of the current task until it finishes.
;
; This version of the subroutine allows speeding it up by holding a button.
; This was improved in 96, becoming the base for its TextPrinter.
;
; IN
; - DE: Ptr to text data (list of tile IDs)
; - HL: Ptr to tilemap (Destination)
; - A: Delay between letter printing
; - B: Text width (number of characters in a line)
; - C: Text height (number of lines)
TextPrinter_MultiFrame_WithSpeedup:
	push bc
		push hl
		.printLoop:
			;
			; Write the next letter to the tilemap, when HBlank hits.
			;
			push af
				mWaitForVBlankOrHBlank
				ld   a, [de]	; Read tile ID
				ldi  [hl], a	; Write to tilemap, move right
			pop  af
	
			;
			; Handle speedup controls
			;
			
			; If we enabled the line skipping mode in the delay counter, that's it.
			; Instantly print text as fast as possible (but still delay for a bit when the line ends).
			bit  TXCB_INSTANT, a		; Instant print enabled?
			jp   nz, .chkStringEnd		; If so, skip and immediately write the next char
			push af	
			.delayLoop:
				push af
					ldh  a, [hJoyNewKeys]
					bit  KEYB_START, a			; Pressed START?
					jp   nz, .actInstant		; If so, jump
					ldh  a, [hJoyKeys]
					bit  KEYB_A, a				; Holding A?
					jp   nz, .actSpeedup		; If so, jump
					; Check the same for controller 2
					ldh  a, [hJoyNewKeys2]
					bit  KEYB_START, a			
					jp   nz, .actInstant			
					ldh  a, [hJoyKeys2]
					bit  KEYB_A, a
					jp   nz, .actSpeedup
					jp   .actNone				; Otherwise, no action

					;
					; Action: Instant text 
					; Enable instant text mode permanently
					;
					.actInstant:
					pop  af
				pop  af					; Extra pop to apply the changes permanently
				set  TXCB_INSTANT, a 	; here
				jp   .chkStringEnd
				;--
					;
					; Action: Speed up
					; Sets the text printing delay to 1 frame temporarily
					;
					.actSpeedup:
					pop  af
					ld   a, $01			; A = Frames to wait (temp copy)
					jp   .waitFrame
				;--	
					;
					; Action: None
					; ...well
					;
					.actNone:
					pop  af				; Restore delay counter
				;--	
				; Common wait between text printing
				.waitFrame:
					push af
						call Task_PassControl_NoDelay
					pop  af				
					dec  a				; Waited all frames?
					jp   nz, .delayLoop	; If not, loop
				pop  af					; Restore original text speed
			.chkStringEnd:
				inc  de
				dec  b				; Finished writing the line?
				jp   nz, .printLoop	; If not, loop
	

		; Seek to the next row
		pop  hl						; Restore ptr to start of row
		ld   bc, BG_TILECOUNT_H		; Move down by one tile
		add  hl, bc
	pop  bc
	dec  c							; Copied all rows?
	jr   nz, TextPrinter_MultiFrame_WithSpeedup	; If not, loop
	call Task_PassControl_NoDelay
	ret

; =============== FillBGRect ===============
; Draws a rectangle in the tilemap.
; IN
; - HL: Destination tilemap ptr (top left corner of rectangle)
; - B: Rect Width
; - C: Rect Height
; - D: Tile ID to use, generally a completely white or black tile
FillBGRect:
	ld   a, d					
.loopV:
	push bc
		push hl
		.loopH:
			push af				; Write the tile during HBlank
				mWaitForVBlankOrHBlank
			pop  af
			ldi  [hl], a
			dec  b				; Filled the row?
			jp   nz, .loopH		; If not, loop
		pop  hl					; Restore starting row position
		ld   bc, BG_TILECOUNT_H	; Move down 1 row
		add  hl, bc
	pop  bc
	dec  c				; Filled all rows?
	jr   nz, .loopV		; If not, loop
	ret
	
; =============== FillGFX ===============
; Writes the specified number of tiles to the GFX area consting of the same line pattern repeated vertically.
;       
; IN
; - DE: Ptr to GFX in VRAM
; - B: Number of tiles to overwrite
; - HL: 2bpp Line to repeat across the tiles.
FillGFX:
	push bc
		; Write a full tile / Write $10 tiles horizontally
		ld   b, TILESIZE / 2
	.loopH:
		; Write tile H to DE
		mWaitForVBlankOrHBlank
		ld   a, h
		ld   [de], a
		inc  de	
		; Write tile L to DE
		mWaitForVBlankOrHBlank
		ld   a, l
		ld   [de], a
		inc  de
		
		dec  b				; Finished overwriting the tile? / Filled the $10 tile strip?
		jp   nz, .loopH		; If not, loop
	pop  bc
	dec  b					; Are we done repeating it?
	jp   nz, FillGFX		; If not, loop
	ret

; =============== CopyTilesAuto ===============
; Tile copy function.
;
; IN
; - HL: Ptr to VRAM destination ptr, followed by the number of tiles to copy.
CopyTilesAuto:
	ld   e, [hl]	; Read out destination ptr to DE
	inc  hl
	ld   d, [hl]
	inc  hl
	; Fall-through

; =============== CopyTilesAutoNum ===============
; Tile copy function.
;
; IN
; - HL: Ptr to the number of tiles to copy, followed by uncompressed GFX.
; - DE: Ptr to destination in VRAM
CopyTilesAutoNum:
	ld   b, [hl]	; Read number of tiles to copy
	inc  hl			; DestPtr++
	
; =============== CopyTiles ===============
; Tile copy function.
; Could be used for other purposes maybe.
;
; IN
; - HL: Ptr to uncompressed GFX
; - DE: Ptr to destination in VRAM
; -  B: Number of tiles to copy
CopyTiles:
	; Copy a single tile ($10 bytes) at a tune
REPT TILESIZE
	ldi  a, [hl]		; Read byte, SourcePtr++
	ld   [de], a		; Copy it over
	inc  de				; DestPtr++
ENDR
	dec  b				; Have we copied all tiles?
	jp   nz, CopyTiles	; If not, loop
	ret

; =============== Unused_CopyTilesHBlankAuto ===============
; [TCRF] Unreferenced code.
; Tile copy function during HBlank.
; IN
; - HL: Ptr to a GFXDef-like structure followed by uncompressed GFX.
;       This structure has two extra bytes at the beginning.
Unused_CopyTilesHBlankAuto:
	; byte0-1 -> Ptr to destination in VRAM
	ld   e, [hl]	; Read out to DE
	inc  hl
	ld   d, [hl]
	inc  hl
	; Fall-through

; =============== CopyTilesHBlank ===============
; Tile copy function during HBlank.
; IN
; - HL: Ptr to a GFXDef structure
; - DE: Ptr to destination in VRAM
; -  B: Number of tiles to copy
CopyTilesHBlankAutoNum:
	; byte2 -> Number of tiles to copy
	ld   b, [hl]	; Read to B
	inc  hl
	; byte3+ -> Uncompressed GFX
	
	; Fall-through

; =============== CopyTilesHBlank ===============
; Tile copy function during HBlank.
; IN
; - HL: Ptr to uncompressed GFX
; - DE: Ptr to destination in VRAM
; -  B: Number of tiles to copy
CopyTilesHBlank:
	push bc
		ld   b, TILESIZE		; B = Bytes in tile
	.loop:
		mWaitForVBlankOrHBlank
		ldi  a, [hl]			; Read byte, SourcePtr++
		ld   [de], a			; Copy it over
		inc  de					; DestPtr++
		dec  b					; Copied all bytes in the tile?
		jp   nz, .loop			; If not, loop
	pop  bc
	dec  b						; Copied all tiles?
	jp   nz, CopyTilesHBlank	; If not, loop
	ret

; =============== Unused_CopyTilesOverAuto ===============
; [TCRF] Unreferenced code.
; IN
; - HL: Ptr to GFXDef-like structure, like Unused_CopyTilesHBlankAuto.
Unused_CopyTilesOverAuto:
	; byte0-1 -> Ptr to destination in VRAM
	ld   e, [hl]	; Read out to DE
	inc  hl
	ld   d, [hl]
	inc  hl
	; byte2 -> Number of tiles to copy
	
	; Fall-through
; =============== CopyTilesOver ===============
; Draws a transparent GFX on top of an existing one.
;
; IN
; - HL: Ptr to GFX to copy over
; - BC: Ptr to GFX with transparency mask
; - DE: Ptr to destination in VRAM.
CopyTilesOver:
	; The GFXDef structure starts with the number of tiles to process
	ld   a, [hl]			; A = Number of tiles
	inc  hl
	; Fall-through
; =============== CopyTilesOver_Custom ===============
; IN
; - HL: Ptr to GFX to copy over
; - BC: Ptr to GFX with transparency mask
; - DE: Ptr to destination in VRAM.
; - A: Number of tiles
CopyTilesOver_Custom:

	;
	; Apply the transparency mask.
	;
	; The transparency mask is simply a 2bpp GFX which marks with set/black pixels (0b11)
	; the portion of the original GFX to keep.
	;
	; Since all of these graphics are already in 2bpp format, there's no conversion
	; involved, just a straight AND operation to remove all of the bits not set in the mask.
	;
	push af
		push de
			push hl
				;--
				push bc				; HL = BC
				pop  hl
			.nextTile:
				push af				; Save tiles remaining
					ld   a, TILESIZE	; A = Bytes remaining in tile
				.tileLoop:
					push af				; Save bytes left
						
						ld   a, [de]	; Read GFX from VRAM
						and  a, [hl]	; Filter with mask
						ld   [de], a	; Save back
						inc  de			; Next byte in VRAM
						inc  hl			; Next byte in mask
					pop  af				; A = Bytes left
					dec  a				; Masked all bytes in the tile?
					jp   nz, .tileLoop	; If not, loop
				pop  af				; Restore tiles remaining
				dec  a				; Masked all tiles?
				jp   nz, .nextTile	; If not, loop
				;--
			pop  hl
		pop  de
	pop  af
	
	;
	; Apply the actual GFX now that the transparency mask cleared away pixels.
	; This is the same as the above, except this other graphic is OR'd over.
	;
	; The new GFX shouldn't have pixels in the transparent area.
	;
.nextOrTile:
	push af					; Save tiles remaining
		ld   a, TILESIZE		; A = Bytes remaining in tile
	.tileOrLoop:
		push af					; Save bytes left
			ld   a, [de]		; Read GFX from VRAM
			or   a, [hl]		; Merge with new graphic over
			ld   [de], a		; Save back
			inc  de				; Next byte in VRAM
			inc  hl				; Next byte in new GFX
		pop  af					; A = Bytes left
		dec  a					; Processed all bytes in the tile?
		jp   nz, .tileOrLoop	; If not, loop
	pop  af					; Restore tiles remaining
	dec  a					; Processed all tiles?
	jp   nz, .nextOrTile	; If not, loop
	ret
	
; =============== Unused_CopyTilesHBlankFlipXAuto ===============
; [TCRF] Unreferenced code.
; IN
; - HL: Ptr to GFXDef-like structure, like Unused_CopyTilesHBlankAuto.
Unused_CopyTilesHBlankFlipXAuto:
	; byte0-1 -> Ptr to destination in VRAM
	ld   e, [hl]	; Read out to DE
	inc  hl
	ld   d, [hl]
	inc  hl
	; byte2 -> Number of tiles to copy
	ld   b, [hl]	; Read to B
	inc  hl
	; byte3+ -> Uncompressed GFX
	
	; Fall-through
; =============== CopyTilesHBlankFlipX ===============
; Copies graphics to VRAM and flips them horizontally.
;
; This doesn't change their order, so when incrementing tilemaps are used,
; a special subroutine for updating the tilemap may be needed.
;
; IN
; - HL: Ptr to source GFX in ROM
; - DE: Ptr to destination in VRAM
; - B: Number of tiles
CopyTilesHBlankFlipX:
	push bc	; Save TileCount
		ld   b, TILESIZE	; B = Bytes in a tile
	.loop:
		push bc				; Save B
			
			ld   b, $00		
			ld   c, [hl]		; BC = Source GFX
			inc  hl				; SrcPtr++
			
			; Flip it by indexing the 1bpp mapping table
			push hl
				ld   hl, GFXS_XFlipTbl	; HL = Start conversion table
				add  hl, bc				; Index it
				ld   a, [hl]			; B = Flipped line
			pop  hl
			
			push af
				mWaitForVBlankOrHBlank
			pop  af
			
			ld   [de], a	; Write the byte to VRAM
			inc  de			; DestPtr++
		pop  bc				; Restore B
		dec  b				; Fully copied the tile?
		jp   nz, .loop		; If not, loop
	pop  bc	; Restore TileCount
	dec  b				; Copied all tiles?
	jp   nz, CopyTilesHBlankFlipX	; If not, loop
	ret
	
; =============== GFXS_XFlipTbl ===============
; Conversion table for CopyTilesHBlankFlipX.flipX.
; This maps every possible byte (an half-plane 1bpp line) of a GFX to its flipped version.
GFXS_XFlipTbl:
	db $00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0 ; $00
	db $08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8 ; $10
	db $04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4 ; $20
	db $0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC ; $30
	db $02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2 ; $40
	db $0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA ; $50
	db $06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6 ; $60
	db $0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE ; $70
	db $01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1 ; $80
	db $09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9 ; $90
	db $05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5 ; $A0
	db $0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD ; $B0
	db $03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3 ; $C0
	db $0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB ; $D0
	db $07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7 ; $E0
	db $0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF ; $F0
	
; =============== HomeCall_Sound_ReqPlayExId_Stub ===============
; IN
; - A: Action ID or DMG Sound ID
HomeCall_Sound_ReqPlayExId_Stub:
	jp   HomeCall_Sound_ReqPlayExId

; =============== SGB_SendSoundPacketAtFrameEnd ===============
; Sends the specified SGB sound packet previously written to RAM.
SGB_SendSoundPacketAtFrameEnd:
	; If there aren't any packets to send, return early
	ld   a, [wSGBSendPacketAtFrameEnd]
	or   a				; wSGBSendPacketAtFrameEnd == 0?
	ret  z				; If so, return
	
	; Don't do it too close to VBlank
	ldh  a, [rLY]
	cp   a, $76			; rLY >= $76?
	ret  nc				; If so, return
	
	; Send the packet containing the sound ID that was written at wSGBSoundPacket
	ld   hl, wSGBSoundPacket
	call SGB_SendPackets
	
	; Clear marker
	xor  a
	ld   [wSGBSendPacketAtFrameEnd], a
	ret
	
; =============== SGB_PrepareSoundPacketA ===============
; Sets up the SGB packet to play a sound ID from Set A.
; IN
; - H: Sound Effect A ID
; - L: Sound Effect Attributes
SGB_PrepareSoundPacketA:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a	; In SGB mode?
	jp   z, .end			; If not, return
	push bc
	push de
		push hl				; BC = HL
		pop  bc
		
		; There are 4 bytes in a sound packet, the rest are $00.
		; 1 08 SOUND    41.10.00.03 00.00.00.00 00.00.00.00 00.00.00.00
		
		; C = Attributes for Sound Effect A
		ld   a, $0F			; Filter away the upper nybble (which is for Sound Effect B)			
		and  c
		ld   c, a
		
		;
		; byte0 - command id + packet count
		;
		; (already written in HomeCall_Sound_Init)
		
		
		
		;
		; byte1 - Sound Effect A
		;
		ld   hl, wSGBSoundPacket+1		; Write out
		ld   [hl], b						
		inc  hl							
		
		;
		; byte2 - Sound Effect B (always $00)
		;
		ld   [hl], $00						
		inc  hl
		
		;
		; byte3 - Attributes
		;
		; Preserve whatever is already there involving Sound Effect B.
		; Simply replace the lower nybble with the updated attributes.
		ld   a, [hl]
		and  a, $F0				; Preserve B
		or   c					; Merge A
		ld   [hl], a
		
		; Request later packet transfer
		ld   a, $01
		ld   [wSGBSendPacketAtFrameEnd], a
	pop  de
	pop  bc
.end:
	ret
	
; =============== SGB_PrepareSoundPacketB ===============
; Sets up the SGB packet to play a sound ID from Set B.
; See also: SGB_PrepareSoundPacketA
; IN
; - H: Sound Effect B ID
; - L: Sound Effect Attributes
SGB_PrepareSoundPacketB:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a	; In SGB mode?
	jp   z, .end			; If not, return
	push bc
	push de
		push hl				; BC = HL
		pop  bc
		

		; C = Attributes for Sound Effect B
		ld   a, $0F				
		and  c
		swap a				; Move the nybble from low to high (the low nybble is for Sound Effect A)
		ld   c, a
		
		;
		; byte0 - command id + packet count
		;
		; (already written in HomeCall_Sound_Init)
		
		
		
		;
		; byte1 - Sound Effect A (always $00)
		;
		ld   hl, wSGBSoundPacket+1		
		ld   [hl], $00
		inc  hl							
		
		;
		; byte2 - Sound Effect B
		;
		ld   [hl], b					; Write out		
		inc  hl
		
		;
		; byte3 - Attributes
		;
		; Preserve whatever is already there involving Sound Effect *A*.
		; Simply replace the *high* nybble with the updated attributes.
		ld   a, [hl]
		and  a, $0F				; Preserve A
		or   c					; Merge B
		ld   [hl], a
		
		; Request later packet transfer
		ld   a, $01
		ld   [wSGBSendPacketAtFrameEnd], a
	pop  de
	pop  bc
.end:
	ret

; =============== HomeCall_Sound_ReqPlayExId ===============
; IN
; - A: Action ID or DMG Sound ID
HomeCall_Sound_ReqPlayExId:
	push hl
	push de
		ld   d, a					; Save
		ldh  a, [hROMBank]
		push af
			ld   a, BANK(Sound_ReqPlayExId)
			ld   [MBC1RomBank], a
			ldh  [hROMBank], a
			ld   a, d				; Restore
			call Sound_ReqPlayExId
		pop  af
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
	pop  de
	pop  hl
	ret
	
; =============== HomeCall_Sound_Init ===============
HomeCall_Sound_Init:
	; Set command id for the fixed sound packet location (SGB_SendSoundPacketAtFrameEnd).
	; This will never be changed again.
	ld   a, (SGB_PACKET_SOUND * 8) | $01 	; Sound packet, 1 command
	ld   [wSGBSoundPacket], a
	
	ld   a, BANK(Sound_Init) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call Sound_Init
	ret

; =============== HomeCall_Sound_Do ===============
HomeCall_Sound_Do:
	push af
	push bc
	push de
	push hl
		ldh  a, [hROMBank]
		push af
			ld   a, BANK(Sound_Do) ; BANK $1F
			ld   [MBC1RomBank], a
			ldh  [hROMBank], a
			call Sound_Do
		pop  af
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
	pop  hl
	pop  de
	pop  bc
	pop  af
	ret
	
; =============== HomeCall_SGB_ApplyScreenPalSet ===============
; IN
; - DE: Screen Palette ID
HomeCall_SGB_ApplyScreenPalSet:
	; Not applicable outside SGB mode
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]
	ret  z
	
	ldh  a, [hROMBank]
	push af
	ld   a, BANK(SGB_ApplyScreenPalSet) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call SGB_ApplyScreenPalSet
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	
; =============== HomeCall_SGB_ApplyWinPicPalSet ===============
; IN
; - D: Character ID
; - E: Pic Position ID (PIC_POS_*)
HomeCall_SGB_ApplyWinPicPalSet:
	; Not applicable outside SGB mode
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]
	ret  z
	
	ldh  a, [hROMBank]
	push af
	ld   a, BANK(SGB_ApplyWinPicPalSet) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call SGB_ApplyWinPicPalSet
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret

; =============== JoyKeys_Get ===============
; Gets the joypad input for the player.
JoyKeys_Get:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a			; Running in SGB mode?
	jp   nz, JoyKeys_Get_SGB		; If so, grab inputs for both players
	ld   hl, hJoyKeys				; For later
	ld   a, [wSerialPlayerId]
	and  a							; Playing in VS mode?
	jr   nz, JoyKeys_Get_Serial		; If so, jump
	
; =============== JoyKeys_Get_Standard ===============
; Gets the DMG joypad input for a player.
; IN
; - HL: Ptr to existing joypad input
JoyKeys_Get_Standard:
	; D = Keys not held
	ld   a, [hl]			
	cpl						
	ld   d, a					
	
	; Get the directional key status
	ld   a, HKEY_SEL_DPAD
	ldh  [rJOYP], a
	ldh  a, [rJOYP]			; Stabilize the inputs
	ldh  a, [rJOYP]
	and  a, $0F				; ----DULR | Only use the actual keypress values (stored in the lower nybble)
	ld   c, a				; Save to C
	
	; Reset (Not necessary?)
	ld   a, HKEY_SEL_BTN|HKEY_SEL_DPAD 
	ldh  [rJOYP], a
	
	; Get the button status
	ld   a, HKEY_SEL_BTN
	ldh  [rJOYP], a
	ldh  a, [rJOYP]		; Stabilize the inputs
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	and  a, $0F			; ----SCBA
	
	; Merge the nybbles and mungle them
	swap a				; Move to upper nybble
	or   a, c			; Merge with other: 
						; This creates this bitmask: SCBADULR
	cpl					; Reverse the bits as the hardware marks pressed keys as '0'. We need the opposite.
	
	; Save the result
	ldi  [hl], a		; Write it to hJoyKeys
	and  d				; hJoyNewKeys = hJoyKeys & D
	ld   [hl], a		; Write it to hJoyNewKeys
	; Reset
	ld   a, HKEY_SEL_BTN|HKEY_SEL_DPAD
	ldh  [rJOYP], a
	ret
	
; =============== JoyKeys_Get_Serial ===============
; Handles the joypad reader in serial mode.
;
; HOW IT WORKS
;
; Two buffers with looping indexes keep track of the player inputs 
; sent to the other player (current player) and those received through serial (other player);
;
; Input lifetime:
; - Frame 0, VBLANK
;  - Input is polled the standard way and stored in wSerialPendingJoyKeys*
;  - wSerialPendingJoyKeys is written to the head of the send buffer
;  - (Master Only) A transfer starts of what's currently currently in rSB (previous frame inputs).
;                  The slave is expected to have the same thing set in rSB when this happens.
; - Frame 0, INT
;  - The contents of rSB are stored to the head of the receive buffer.
;      Note how there's an inconsistency here:
;      - The head of the receive buffer has info for the other player's *previous* frame
;      - The head of the send buffer has info for this player's *current* frame.
;      This results in the tail index for the send buffer being set further back.
;  - The head of the send buffer (current input) is written to rSB
;  - The head index is increased
; - Frame 1, VBLANK
;  - (input for previous frame is processed)
; - Frame 1, INT
;  - Done like last time, now with the received input we need
; - Frame 2, VBLANK
;  - The value at the tail of the send buffer is copied to the current player's hJoyKeys*
;  - The value at the tail of the receive buffer is copied to the other player's hJoyKeys*
;  - Both tail indexes are increased
;
; Additionally, the head indexes always point to a free slot, so the tail indexes (used for active inputs) are at least offset by 1.
; As a result, the buffer indexes are set so that:
; - Send buffer tail is 2 values before the head
; - Receive buffer tail is 1 value before the head
;
; IN
; - A: Player ID
JoyKeys_Get_Serial:
	ld   c, a
		ld   a, [wSerialInputMode]
		and  a							; Do we allow input?
		ret  z							; If not, return
	ld   a, c
	
	; Depending on the player side, pick the correct current/remote addresses
	ld   de, hJoyKeys				; P1 Side - Current GB
	ld   hl, wSerialPendingJoyKeys 	; P1 Side - Other GB
	cp   a, SERIAL_PL1_ID			; Are we playing on the 1P side?
	jr   z, .go						; If so, jump
	ld   hl, wSerialPendingJoyKeys2	; P2 Side - Other GB
	ld   de, hJoyKeys2				; P2 Side - Current GB
.go:

	;
	; [Frame 2]
	; Get the active input for this GB.
	;

	; C = Keys not currently held on *this frame*
	ld   a, [de]			
	cpl						
	ld   c, a	
	
	; A = Held input at the tail value of the send buffer
	push de
		push hl
			; Get index to the buffer
			ld   a, [wSerialDataSendBufferIndex_Tail]
			ld   e, a									
			; Save back an incremented copy
			inc  a										; Index++
			and  a, $7F									; Size of buffer, cyles back
			ld   [wSerialDataSendBufferIndex_Tail], a	; Save the updated index
			
			; Index the buffer of sent inputs and read out its value.
			xor  a
			ld   d, a
			ld   hl, wSerialDataSendBuffer		; HL = Table
			add  hl, de							; Offset it
			ld   a, [hl]						; A = Buffer entry
			ld   [hl], $00						; Clear what was here
			
			; Decrement the counter/balance of remaining bytes to process.
			ld   hl, wSerialSentLeft
			dec  [hl]			
		pop  hl
	pop  de
	
	; Set hJoyKeys
	ld   [de], a
	inc  de		
	
	; Set hJoyNewKeys.
	; Unlike the normal joypad handler, this has the keys *RELEASED* in the last 2 frames set
	and  c					
	ld   [de], a
	
	;--
	
	;
	; [Frame 0] Poll for input to wSerialPendingJoyKeys*
	;
	call JoyKeys_Get_Standard
	
	; Part 2
	call JoyKeys_Serial_GetActiveOtherInput
	ret  
	
; =============== JoyKeys_Get_SGB ===============
; Gets input for both players through the SGB (through the joypad registers, that is).
; This is almost the same as JoyKeys_Get_Standard.
JoyKeys_Get_SGB:

	; Cycle to first controller, prepare for controller ID read
	ld   a, HKEY_SEL_BTN|HKEY_SEL_DPAD 
	ldh  [rJOYP], a
	
	ld   b, $02			; B = Joy count
.loop:
	; Pick the target address for storing the joypad info, depending on the controller ID.
	; On the first run, write PL1 info from hJoyKeys.
	; On the the second, write PL2 info from hJoyKeys2.
	
	ld   hl, hJoyKeys		
	ldh  a, [rJOYP]			; Read controller ID
	and  a, $01				; ID % 2 != 0? (will match != $*E)
	jr   nz, .go			; If so, jump (this is pad 1)
	ld   hl, hJoyKeys2		; Otherwise, this is pad 2
.go:

	; D = Keys not held
	ld   a, [hl]			
	cpl						
	ld   d, a					
	
	; Get the directional key status
	ld   a, HKEY_SEL_DPAD
	ldh  [rJOYP], a
	ldh  a, [rJOYP]			; Stabilize the inputs
	ldh  a, [rJOYP]
	and  a, $0F				; ----DULR | Only use the actual keypress values (stored in the lower nybble)
	ld   c, a				; Save to C
	
	; Reset (Not necessary?)
	ld   a, HKEY_SEL_BTN|HKEY_SEL_DPAD 
	ldh  [rJOYP], a
	
	; Get the button status
	ld   a, HKEY_SEL_BTN
	ldh  [rJOYP], a
	ldh  a, [rJOYP]		; Stabilize the inputs
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	ldh  a, [rJOYP]
	and  a, $0F			; ----SCBA
	
	; Merge the nybbles and mungle them
	swap a				; Move to upper nybble
	or   a, c			; Merge with other: 
						; This creates this bitmask: SCBADULR
	cpl					; Reverse the bits as the hardware marks pressed keys as '0'. We need the opposite.
	
	; Save the result
	ldi  [hl], a		; Write it to hJoyKeys
	and  d				; hJoyNewKeys = hJoyKeys & D
	ld   [hl], a		; Write it to hJoyNewKeys
	
	; Reset + Cycle to next controller
	ld   a, HKEY_SEL_BTN|HKEY_SEL_DPAD
	ldh  [rJOYP], a
	
	dec  b				; JoyLeft--
	jp   nz, .loop	; All pads red? If not, loop
	ret
	
; =============== JoyKeys_DoCursorDelayTimer ===============
; Handles the cursor movement delay timers, used to determine when to move the cursor.
JoyKeys_DoCursorDelayTimer:
	ld   hl, hJoyKeys
	call .calcInfo
	ld   hl, hJoyKeys2
	call .calcInfo
	ret
	
; =============== .calcInfo ===============
; IN
; - HL: Ptr to hJoyKeys*
.calcInfo:
	ld   d, [hl]	; D = hJoyKeys
	
	; Seek to hJoyKeysDelayTbl
	inc  hl			
	inc  hl			
	inc  hl			
	
	; For each KEY_* value, calculate this information, going from MSB to bit 0.
	
	ld   e, $08		; E = Bits in byte
.nextPair:

	;
	; Each entry in the hJoyKeysDelayTbl array is 2 bytes large.
	;
	; 0 -> Marks if the KEY_* value is pressed.
	;      Separated in two nybbles, with the low one containing the current info
	;      and the high one info for the previous frame.
	;      Split like this to easily determine when we just started holding a key without juggling hJoyNewKeys.
	;
	; 1 -> Countdown timer.
	;      This is set to $11 when we start holding a key, then to $06 once it reaches $00.
	;      When it reaches $00, the upper nybble of byte0 is unmarked by setting the byte to $01,
	;      which tells Title_GetMenuInput to treat the input as held.
	;      

	ld   b, [hl]	; B = Marker (byte0)
	inc  hl			; 
	ld   c, [hl]	; C = Timer (byte1)
	dec  hl			; Seek back to byte0
	
	; Move the existing keypress marker to the upper nybble.
	; If what we had here was $01 and that gets shifted to the upper nybble, it will cause
	; Title_GetMenuInput to ignore the key unless it gets set to $01 by the time we exit this function.
	sla  b		; B << 4
	sla  b
	sla  b
	sla  b
	
	; Check if the current key was pressed.
	; If not, the lower nybble will be kept at 0, and next time we get here it will be pushed out.
	rlc  d			; Push KEY_* to carry
	jp   nc, .save	; Is the bit set? If not, jump
.press:
	set  0, b		; Mark the key as presssed
	
	; Check if we just started holding a key.
	; If not, A will be $11 when we get here.
	ld   a, b
	cp   $01			; Marker == $01? (just started)
	jp   nz, .decTimer	; If not, jump
.initTimer:
	; Set the initial delay to $11 frames.
	ld   c, $11			
	jp   .save
	
.decTimer:

	; Decrement the key timer.
	; If it reaches 0, reset it.
	dec  c				; Timer--
	jp   nz, .save		; Timer == 0? If not, jump
.resetTimerNext:
	; Set the delay to $06 frames
	ld   b, $01			; Treat input as held
	ld   c, $06
	;--
.save:
	ld   [hl], b		; Save back key marker
	inc  hl
	ld   [hl], c		; Save back timer
	inc  hl				; Seek to next entry in delay table
	dec  e				; Processed all bits?
	jp   nz, .nextPair	; If not, loop
	ret
; =============== Rand ===============
; Random generator without using cycles.
; OUT
; - A: Random number
Rand:
	; wRand += wTimer + (wRand * 5) + 1
	push bc
		ld   a, [wRand]		; A = wRand
		ld   b, a			; B = wRand
		sla  a				; A *= 4
		sla  a
		add  b				; A += B + 1
		inc  a
		ld   b, a			; B = A
		ld   a, [wTimer]	; A = wTimer + B
		add  b
		ld   [wRand], a		; wRand = A
	pop  bc
	ret
; =============== RandLY ===============
; Random generator using cycles.
; OUT
; - A: Random number
RandLY:
	; wRandLY += wTimer + (wRandLY * 5) + rLY + 1 
	push bc
		ld   a, [wRandLY]	; A = wRand
		ld   b, a			; B = wRand
		sla  a				; A *= 4
		sla  a
		add  b				; A += B + 1
		inc  a
		ld   b, a			; B = A
		ld   a, [wTimer]	; A = wTimer + B
		add  b	
		;--
		ld   b, a			; B = A
		ldh  a, [rLY]		; wRand = B + rLY 
		add  b
		;--
		ld   [wRandLY], a
	pop  bc
	ret

; =============== LoadGFX_1bppFont_Default ===============
; Loads the ASCII font GFX with default settings.
LoadGFX_1bppFont_Default:
	ldh  a, [hROMBank]
	push af
	ld   a, BANK(FontDef_Default) ; BANK $1F (JPN), BANK $18 (EU)
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ld   hl, FontDef_Default
	call LoadGFX_1bppFont
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	
IF VER_EN

; =============== Cutscene_InitFont ===============
; Loads the English cutscene font GFX and its related code.
; This is still ASCII, but also includes lowercase characters.
; IN
; - A: Added to the Tile ID after the conversion from ASCII.
;      Must be consistent with the destination ptr in DE (ie: if DE is $9000, A must be $00)
; - DE: Destination ptr to VRAM.
Cutscene_InitFont:
	; Save the tile offset for when we call TextPrinter_MultiFrameFar_*
	ld   [wTextPrintTileOffset], a
	
	ldh  a, [hROMBank]
	push af
	
		;
		; Load the English cutscene font
		;
		ld   a, BANK(FontDef_Cutscene) ; BANK $1D
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		ld   hl, FontDef_Cutscene+$02 ; Start from the tile count
		call LoadGFX_1bppFont.fromTileCount
		
		;
		; Copy the text printer subroutine and the ASCII conversion table to WRAM.
		; 
		ld   a, BANK(TextPrinter_MultiFrameFarCode) ; BANK $15
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		
		; Prepare the source/destination pointers.
		; The first two bytes tell how many bytes to copy over.
		ld   hl, TextPrinter_MultiFrameFarCode	; HL = Source
		; Note how it starts writing from $CC02, not $CC00.
		; Doing so keeps the absolute pointers relatively consistent between ROM and RAM (the two lowest digits will match).
		ld   de, TextPrinter_MultiFrameFar+$02	; DE = Destination
		ldi  a, [hl]	; BC = BytesLeft
		ld   c, a
		ldi  a, [hl]
		ld   b, a
		; Start writing $4002 to $CC02, continue until we're done
	.loop:
		ldi  a, [hl]		; Read byte, SourcePtr++
		ld   [de], a		; Copy it over
		inc  de				; DestPtr++
		dec  bc				; BytesLeft--
		ld   a, b
		or   c				; Have we copied all bytes?
		jp   nz, .loop		; If not, loop
		
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
ENDC

; =============== LoadGFX_1bppFont ===============
; Loads the font graphics depending on the specified settings.
;
; IN
; - HL: Ptr to font settings
LoadGFX_1bppFont:

	;
	; Before the font data there's a header with a few settings.
	;
	
	; Read the header out

	; DE = Destination ptr in VRAM
	; In practice always $9000
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	
	;--
	; [POI] Removed alternate wrapper?
	jp   .fromTileCount
.fromTileCount:
	;--

	; B = Number of tiles to copy
	; In practice always $30, which fills the $9000-$9300 area
	ld   b, [hl]
	inc  hl
.fromColDef:
	; wFontLoadBit0Col = bit0 color map
	ldi  a, [hl]		
	ld   [wFontLoadBit0Col], a
	; wFontLoadBit1Col = bit1 color map
	ldi  a, [hl]
	ld   [wFontLoadBit1Col], a
	
.tileLoop:
	;
	; The font graphics are stored in 1bbp inside the ROM.
	; Convert them to 2bpp with the specified color values.
	;
	
	push bc
		ld   b, TILE_V		; B = Number of lines in a tile
	.lineLoop:
		; Clear 2 byte buffer for a line of pixels, which is the smallest size
		; we can work with due to bit interleaving.
		xor  a
		ld   [wFontLoadTmpGFX], a
		ld   [wFontLoadTmpGFX+1], a
		push bc
			ldi  a, [hl]		; Read 1bpp color entry
			
			; For each bit, apply a 2bpp color.
			; Start from bit0 and move up by rotating the 1bpp entry right.
			; The rotation guarantees that the current processed bit is always at bit0 of A.
			;
			; There also a mask at C which gets shifted left, and is used to apply bits to the 2bpp entries.
			
			ld   b, $08			; B = Bits left
			ld   c, $01			; C = Mask to apply current bit
		.bitLoop:
		
			; Map the 1bpp color to a 2bpp color.
			; Depending on the lowest bit in the GFX byte, pick a different color value
			rrca							; Get lowest bit + rotate others right
			jr   c, .useCol1				; Was that bit set (C flag set)? If so, jump
			;--
		.useCol0:		
			push af							
				ld   a, [wFontLoadBit0Col]	; Map to wFontLoadBit0Col color
				call .mapCol
				jp   .colDone
				
		.useCol1:
			push af
				ld   a, [wFontLoadBit1Col]	; Map to wFontLoadBit1Col color
				call .mapCol
		.colDone:
			pop  af							
			;--
			
			rlc  c							; C << 1
			dec  b							; All bits processed?
			jr   nz, .bitLoop				; If not, loop
			
			; Write over the two temporary tiles
			mWaitForVBlankOrHBlank
			ld   a, [wFontLoadTmpGFX]
			ld   [de], a
			inc  de
			mWaitForVBlankOrHBlank
			ld   a, [wFontLoadTmpGFX+1]
			ld   [de], a
			inc  de
			
		pop  bc			
		dec  b				; Processed all lines in the tile?
		jr   nz, .lineLoop	; If not, loop
	pop  bc				
	dec  b					; Processed all tiles?
	jr   nz, .tileLoop		; If not, loop
	ret
	
; =============== .mapCol ===============
; Converts a 1bpp color value to a 2bpp color.
; IN
; - A: 2bpp COL_* value (0-3)
; - C: Bitmask with current bit to process in both bytes, never $00
.mapCol:
	; The 2 bits of the color index are split across two bytes.
	; Split them into those two bytes at the same bit number.
	
	; 0 | %00 | wFontLoadTmpGFX = 0, wFontLoadTmpGFX+1 = 0
	; 1 | %01 | wFontLoadTmpGFX = 1, wFontLoadTmpGFX+1 = 0
	; 2 | %10 | wFontLoadTmpGFX = 0, wFontLoadTmpGFX+1 = 1
	; 3 | %11 | wFontLoadTmpGFX = 1, wFontLoadTmpGFX+1 = 1

	; Put the low bit into the first byte.
	bit  0, a					; Is the low bit set?
	jr   z, .other				; If not, skip
	push af
	ld   a, [wFontLoadTmpGFX]	; Otherwise, apply bit
	or   a, c
	ld   [wFontLoadTmpGFX], a
	pop  af
.other:
	; Put the high bit into the second byte
	bit  1, a					; Is the high bit set?
	jr   z, .end				; If not, skip
	ld   a, [wFontLoadTmpGFX+1]	; Otherwise, apply bit
	or   a, c
	ld   [wFontLoadTmpGFX+1], a
.end:
	ret

; =============== TextPrinter_Instant ===============
; Instantly prints a string to the screen.
; Note that newlines aren't supported for string printed this way.
; IN
; - HL: Ptr to TextDef structure
TextPrinter_Instant:
	; DE = Tilemap ptr
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
; =============== TextPrinter_Instant_CustomPos ===============
; IN
; - HL: Ptr to string length field of TextDef structure
; - DE: Tilemap ptr (Destination)
TextPrinter_Instant_CustomPos:
	; B = String length
	ld   b, [hl]
	inc  hl
.loop:
	push bc
		ldi  a, [hl]			; A = Letter
		push hl
	
			;--
			; Convert the character text to the correct tile ID.
			ld   hl, TextPrinter_CharsetToTileTbl	; HL = Ptr to conversion table
			ld   b, $00			; BC = Letter value
			ld   c, a
			add  hl, bc			; Index out to tile ID
			;--
			
			; Write it out to the tilemap
			mWaitForVBlankOrHBlank
			ld   a, [hl]	; Read Tile ID
			ld   [de], a	; Write it over
			inc  de			; Move right in tilemap
		pop  hl
	pop  bc
	dec  b				; All letters printed?
	jr   nz, .loop		; If not, loop
	ret

; =============== NumberPrinter_Instant ===============	
; Instantly prints an hex number to the screen.
; IN
; - A: Number in hex format
; - DE: Tilemap ptr
NumberPrinter_Instant:
	; Digit in the upper nybble first
	push af
		swap a
		and  a, $0F
		call .writeDigit
	pop  af
	; Then the lower one
	and  a, $0F
	call .writeDigit
	ret
	
; =============== .writeDigit ===============
; *DE = TextPrinter_DigitToTileTbl[A] + C
; IN
; - A: Digit (0-F)
; - DE: Tilemap ptr
.writeDigit:
	; Convert letter to tile ID using an alternate charmap
	ld   hl, TextPrinter_DigitToTileTbl
	ld   b, $00
	ld   c, a
	add  hl, bc
	
	; Write it to the tilemap
	mWaitForVBlankOrHBlank
	ld   a, [hl]
	ld   [de], a
	inc  de
	ret

; =============== TextPrinter_CharsetToTileTbl ===============
; Maps the 7-bit character set used for ASCII strings in the ROM to tile IDs.
; The tile IDs correspond to the standard 1bpp font (FontDef_Default).
;
; The first 128 ASCII characters are accounted for, though most point to $00, the blank space.
; Unlike 96, the standard font only contains English characters -- there's no JIS X-like format.
; The screens that display Japanese text handle it separately and load their own copy of the font.
TextPrinter_CharsetToTileTbl:
;          ; $ID ;JP 
	db $25 ; $00 ; █
	db $26 ; $01 ; ©
	db $27 ; $02 ; ►
	db $28 ; $03 ; ◄
	db $29 ; $04 ; .
	db $2A ; $05 ; ,
	db $2B ; $06 ; ?
	db $2C ; $07 ; :
	db $2D ; $08 ; -
	db $2E ; $09 ; '
	db $2F ; $0A ; !
	db $00 ; $0B ; 
	db $00 ; $0C ; 
	db $00 ; $0D ; 
	db $00 ; $0E ; 
	db $00 ; $0F ; 
	db $00 ; $10 ; 
	db $00 ; $11 ; 
	db $00 ; $12 ; 
	db $00 ; $13 ; 
	db $00 ; $14 ; 
	db $00 ; $15 ; 
	db $00 ; $16 ; 
	db $00 ; $17 ; 
	db $00 ; $18 ; 
	db $00 ; $19 ; 
	db $00 ; $1A ; 
	db $00 ; $1B ; 
	db $00 ; $1C ; 
	db $00 ; $1D ; 
	db $00 ; $1E ; 
	db $00 ; $1F ; 
	db $00 ; $20 ; (space)
	db $2F ; $21 ; ! 
	db $00 ; $22 ; 
	db $00 ; $23 ; 
	db $00 ; $24 ; 
	db $00 ; $25 ; 
	db $00 ; $26 ; 
	db $2E ; $27 ; '
	db $00 ; $28 ; 
	db $00 ; $29 ; 
	db $00 ; $2A ; 
	db $00 ; $2B ; 
	db $2A ; $2C ; ,
	db $2D ; $2D ; -
	db $29 ; $2E ; .
	db $00 ; $2F ; 
	db $01 ; $30 ; 0
	db $02 ; $31 ; 1
	db $03 ; $32 ; 2
	db $04 ; $33 ; 3
	db $05 ; $34 ; 4
	db $06 ; $35 ; 5
	db $07 ; $36 ; 6
	db $08 ; $37 ; 7
	db $09 ; $38 ; 8
	db $0A ; $39 ; 9
	db $2C ; $3A ; :
	db $00 ; $3B ; 
	db $00 ; $3C ; 
	db $00 ; $3D ; 
	db $00 ; $3E ; 
	db $2B ; $3F ; ?
	db $00 ; $40 ; 
	db $0B ; $41 ; A
	db $0C ; $42 ; B
	db $0D ; $43 ; C
	db $0E ; $44 ; D
	db $0F ; $45 ; E
	db $10 ; $46 ; F
	db $11 ; $47 ; G
	db $12 ; $48 ; H
	db $13 ; $49 ; I
	db $14 ; $4A ; J
	db $15 ; $4B ; K
	db $16 ; $4C ; L
	db $17 ; $4D ; M
	db $18 ; $4E ; N
	db $19 ; $4F ; O
	db $1A ; $50 ; P
	db $1B ; $51 ; Q
	db $1C ; $52 ; R
	db $1D ; $53 ; S
	db $1E ; $54 ; T
	db $1F ; $55 ; U
	db $20 ; $56 ; V
	db $21 ; $57 ; W
	db $22 ; $58 ; X
	db $23 ; $59 ; Y
	db $24 ; $5A ; Z
	db $00 ; $5B ; 
	db $00 ; $5C ; 
	db $00 ; $5D ; 
	db $00 ; $5E ; 
	db $00 ; $5F ; 
	db $00 ; $60 ; 
	db $00 ; $61 ; 
	db $00 ; $62 ; 
	db $00 ; $63 ; 
	db $00 ; $64 ; 
	db $00 ; $65 ; 
	db $00 ; $66 ; 
	db $00 ; $67 ; 
	db $00 ; $68 ; 
	db $00 ; $69 ; 
	db $00 ; $6A ; 
	db $00 ; $6B ; 
	db $00 ; $6C ; 
	db $00 ; $6D ; 
	db $00 ; $6E ; 
	db $00 ; $6F ; 
	db $00 ; $70 ; 
	db $00 ; $71 ; 
	db $00 ; $72 ; 
	db $00 ; $73 ; 
	db $00 ; $74 ; 
	db $00 ; $75 ; 
	db $00 ; $76 ; 
	db $00 ; $77 ; 
	db $00 ; $78 ; 
	db $00 ; $79 ; 
	db $00 ; $7A ; 
	db $00 ; $7B ; 
	db $00 ; $7C ; 
	db $00 ; $7D ; 
	db $00 ; $7E ; 
	db $00 ; $7F ; 

; =============== TextPrinter_DigitToTileTbl ===============
; Maps the number digits to tile IDs.
; The tile IDs correspond to the standard 1bpp font (FontDef_Default).
TextPrinter_DigitToTileTbl:
	db $01
	db $02
	db $03
	db $04
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0A
	db $0B
	db $0C
	db $0D
	db $0E
	db $0F
	db $10

	
; =============== Play_LoadStage ===============
; Loads the data for the stage/playfield.
Play_LoadStage:
	ldh  a, [hROMBank]
	push af
	
		;--
		;
		; The boss and extra stages use their own special stage and BGM.
		; The only difference between Nakoruru's stage and the two bosses
		; is in the BGM used.
		;
		; Every normal stage uses a single BGM though! This was thankfully improved in 96.
		;
		
		; Not applicable in VS mode
		ld   a, [wPlayMode]
		bit  MODEB_VS, a
		jp   nz, .useNorm
		
		; Check hardcoded stages
		ld   a, [wCharSeqId]
		cp   STAGESEQ_SAISYU		; In Saisyu's stage?
		jp   z, .boss				; If so, jump
		cp   STAGESEQ_RUGAL			; ...
		jp   z, .boss
		cp   STAGESEQ_NAKORURU
		jp   z, .extra
		jp   .useNorm				; Otherwise, don't override it

	.boss:
		ld   a, BGM_BOSS
		call HomeCall_Sound_ReqPlayExId_Stub
		jp   .useBossStage
	.extra:
		ld   a, BGM_NAKORURU
		call HomeCall_Sound_ReqPlayExId_Stub
	.useBossStage:
		ld   a, STAGE_ID_04
		ld   [wStageId], a
		jp   .load
		;--
	.useNorm:
		ld   a, BGM_STAGE			; Use normal stage BGM
		call HomeCall_Sound_ReqPlayExId_Stub
		
	.load:
	
		;
		; Index the stage header off the table.
		;
		ld   a, [wStageId]				; BC = StageId * 8
		sla  a
		sla  a
		sla  a
		ld   b, $00
		ld   c, a
		ld   hl, Play_StageHeaderTbl	; HL = Start of header
		add  hl, bc						; Offset it
		
		;--
		
		;
		; bytes0-2 Stage GFX
		;
		
		; Switch to the bank with both the GFX and tilemap
		ldi  a, [hl]	; byte0
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		
		; Read out the GFX ptr to BC
		ld   c, [hl]	; byte1
		inc  hl
		ld   b, [hl]	; byte2
		inc  hl
		push hl
			; Load the uncompressed GFX over to the third GFX block
			push bc
			pop  hl
			ld   de, $9000
			call CopyTilesAutoNum
		pop  hl
		
		;
		; bytes3-4 Stage tilemap
		;
		
		; Read out the BG ptr to DE
		ld   e, [hl]	; byte3
		inc  hl
		ld   d, [hl]	; byte4
		inc  hl
		push hl
			; The stage tilemaps are long, spanning the full $20 tiles of the hardware tilemap.
			; Note that they never get redrawn when scrolling, so those 20 tiles are all that's ever visible.
			ld   hl, $9840		; 2 tiles below top
			ld   b, $20			; Width
			ld   c, $0C			; Height
			call CopyBGToRect
		pop  hl
		
		;
		; byte5 - SGB palette ID
		;
		ld   d, $00
		ld   e, [hl]			; byte5
		call HomeCall_SGB_ApplyScreenPalSet
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret


; =============== Play_StageHeaderTbl ===============
; Defines the stage headers:
; FORMAT:
; - 0   : Bank number for GFX and tilemap
; - 1-2 : Ptr to GFX
; - 3-4 : Ptr to tilemap
; - 5   : SGB screen layout ID
; - 6-7 : Padding for alignment to 8-byte boundary
Play_StageHeaderTbl:

	; STAGE 0
	db BANK(GFXDef_Play_Stage_00) ; BANK $04
	dw GFXDef_Play_Stage_00
	dw BG_Play_Stage_00
	db SCRPAL_STAGE_00
	db $00 
	db $00
	
	; STAGE 1
	db BANK(GFXDef_Play_Stage_01) ; BANK $04
	dw GFXDef_Play_Stage_01
	dw BG_Play_Stage_01
	db SCRPAL_STAGE_01
	db $00 
	db $00
	
	; STAGE 2
	db BANK(GFXDef_Play_Stage_02) ; BANK $04
	dw GFXDef_Play_Stage_02
	dw BG_Play_Stage_02
	db SCRPAL_STAGE_02
	db $00 
	db $00
	
	; STAGE 3
	db BANK(GFXDef_Play_Stage_03) ; BANK $03
	dw GFXDef_Play_Stage_03
	dw BG_Play_Stage_03
	db SCRPAL_STAGE_03
	db $00 
	db $00
	
	; STAGE 4
	db BANK(GFXDef_Play_Stage_04) ; BANK $04
	dw GFXDef_Play_Stage_04
	dw BG_Play_Stage_04
	db SCRPAL_STAGE_04
	db $00 
	db $00

; =============== Cutscene_DrawPlPicScreen ===============
; Draws a scene with the three team members.
; Similar to the win screen, but used for cutscenes when displaying the player side.
Cutscene_DrawPlPicScreen:
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(Cutscene_DrawCharPicsForActivePl) ; BANK $1C
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		call ClearBGMap
		call Cutscene_DrawCharPicsForActivePl
		ld   a, $1B
		ldh  [rBGP], a
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	
; =============== Cutscene_DrawOpponentPicScreen ===============
; Draws a scene with the specified character pic in the middle.
; Similar to the win screen, but used for cutscenes when displaying the opponent.
; IN
; - A: Character ID
Cutscene_DrawOpponentPicScreen:
	ld   b, a
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(Cutscene_DrawCharPic) ; BANK $1C
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		ld   a, b
		push af
		call ClearBGMap
		pop  af
		call Cutscene_DrawCharPic
		ld   a, $1B
		ldh  [rBGP], a
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret  
; =============== Serial_DoHandshake ===============
; Performs an handshake between master and slave GBs.
; If it succeeds, the standard serial handlers (master/slave-specific) are set.
;
; For the handshake, the master sends out $43 and expects the slave to return $4C.
; Both the master and slave wait in a loop $600 times for a byte to be received, after which:
; - The master tries sending $43 again
; - The slave resets its "reply byte" and sets the listen flag again
; The same also happens if the received byte doesn't match what the master/slave is expecting.
;
; Every interrupt other than the serial one is disabled on both Game Boys while this happens,
; to give the handshake exclusive priority.
;
Serial_DoHandshake:
	ld   hl, wMisc_C025
	bit  MISCB_SERIAL_MODE, [hl]	; Are we in VS mode serial?
	ret  z							; If not, return
	;--
	
	;
	; Prepare system to give exclusive control to the handshake check.
	;
	
	di   
	; Set the serial handler used for this, which handles both master and slave.
	ld   a, LOW(SerialHandler_Handshake)
	ld   [wSerialIntPtr_Low], a
	ld   a, HIGH(SerialHandler_Handshake)
	ld   [wSerialIntPtr_High], a
	
	xor  a
	ldh  [rSB], a			; Remove sent values from queue
	ld   [wSerialInputMode], a	; Disable input processing just in case
	
	; Disable every interrupt except for serial, and discard any existing one.
	ldh  a, [rIE]
	push af					; Save rIE
		xor  a				; Stop all existing interrupts
		ldh  [rIF], a		
		ld   a, I_SERIAL	; Enable Serial interrupt only
		ldh  [rIE], a
		ei
	
	
		; Clear marker to prepare for transfer.
		xor  a							
		ld   [wSerialTransferDone], a
		
		ld   hl, wMisc_C025
		bit  MISCB_SERIAL_SLAVE, [hl]	; Are we set as slave?
		jp   nz, .slave						; If so, jump
	.master:
		;
		; MASTER
		; Sends $43 to slave and expects $4C back.
		;
		; [POI] There's a design flaw where if something goes wrong
		;       after the slave reads $43, the master will infinite loop.
		;
	
		; Wait for a bit before starting, to give time to the slave
		ld   bc, $0010
		call SGB_DelayAfterPacketSendCustom
		
		; Reset transfer flag
		xor  a
		ld   [wSerialTransferDone], a
	.trySendToSlave:
		; Perform Master->Slave transfer
		;--
		di   
		ld   a, $43								; Send $43 to slave
		ld   [wSerialDataSendBuffer], a
		ld   a, START_TRANSFER_INTERNAL_CLOCK	; Start transfer
		ldh  [rSC], a
		ei 
		;--
		; Wait $0600 times in a loop for a reply before retrying.
		; [POI] This is a point where the master can infinite loop,	as it's possible for the slave 
		;       to receive a byte but not send one back in time. This results in the slave continuing,
		;       but the master still waiting. There's no timeout here.
		ld   bc, $0600					; BC = Loop cycles before retry
	.waitSlaveReply:
		ld   a, [wSerialTransferDone]
		or   a							; Did we receive anything yet?
		jr   nz, .chkSlaveReply			; If so, jump
		dec  bc							; CyclesLeft--
		ld   a, b
		or   c							; CyclesLeft != 0?
		jp   nz, .waitSlaveReply		; If so, loop
		jp   .trySendToSlave			; Otherwise, try to send the byte again
		
	.chkSlaveReply:
		xor  a							; Reset transfer flag
		ld   [wSerialTransferDone], a
		ld   a, [wSerialDataReceiveBuffer]
		cp   a, $4C						; Did we receive $4C from the slave?
		jr   nz, .trySendToSlave		; If not, try to send the byte again
		jp   .handshakeOk				; Otherwise, we're done
		
	.slave:
		;
		; SLAVE
		; Waits to receive $43 from the master, then sends $4C back.
		;
		ld   a, $4C						; Set byte we're replying with
		ld   [wSerialDataSendBuffer], a
		ld   a, START_TRANSFER_EXTERNAL_CLOCK ; Start listening to master			
		ldh  [rSC], a
		ld   bc, $0600					; BC = Loop cycles before retry
	.waitMaster:
		ld   a, [wSerialTransferDone]
		or   a							; Did we receive anything yet?
		jr   nz, .chkMasterRecv			; If so, jump
		dec  bc							; CyclesLeft--
		ld   a, b
		or   c							; CyclesLeft != 0?
		jp   nz, .waitMaster			; If so, loop
		jp   .slave						; Otherwise, re-listen again
	.chkMasterRecv:
		xor  a							; Reset transfer flag
		ld   [wSerialTransferDone], a
		ld   a, [wSerialDataReceiveBuffer]
		cp   a, $43						; Did we receive $43 from the master?
		jr   nz, .slave					; If not, re-listen again
		; Otherwise, we're done.
		; Note that the master still has to check our response.
		
	.handshakeOk:
		;--
		di   
		
		;
		; Initialize and clear serial variables
		;
		
		; Clear entire buffer of received bytes
		xor  a
		ld   b, wSerialDataReceiveBuffer_End-wSerialDataReceiveBuffer ; B = Buffer length
		ld   hl, wSerialDataReceiveBuffer	; HL = Starting ptr
	.clrRecvBufLoop:
		ldi  [hl], a
		dec  b
		jp   nz, .clrRecvBufLoop
		
		; Clear entire buffer of sent bytes
		ld   b, wSerialDataSendBuffer_End-wSerialDataSendBuffer ; B = Buffer length
		ld   hl, wSerialDataSendBuffer		; HL = Starting ptr
	.clrSendBufLoop:
		ldi  [hl], a
		dec  b
		jp   nz, .clrSendBufLoop
		
		; Reset misc variables
		ld   [wTimer], a
		ldh  [rSB], a
		ldh  [hJoyKeys], a
		ldh  [hJoyKeys2], a
		ldh  [hJoyNewKeys], a
		ldh  [hJoyNewKeys2], a
		ld   [wSerialPendingJoyKeys], a
		ld   [wSerialPendingJoyKeys2], a
		ld   [wSerialPendingJoyNewKeys], a
		ld   [wSerialPendingJoyNewKeys2], a
		ld   [wSerialReceivedLeft], a
		ld   [wSerialSentLeft], a
		ld   [wSerial_Unknown_Unused_C144], a
		ld   [wSerialLagCounter], a
		ld   [wSerial_Unknown_Unused_C1C6], a
		
		; By default, listen to the other GB
		ld   a, START_TRANSFER_EXTERNAL_CLOCK
		ldh  [rSC], a
		; Enable input buffer processing since we're ready
		ld   a, $01
		ld   [wSerialInputMode], a
		
		; Set the proper interrupt target between master/slave
		ld   hl, wMisc_C025
		bit  MISCB_SERIAL_SLAVE, [hl]	; Are we a slave?
		jp   nz, .setSlaveInt				; If so, jump
	.setMasterInt:
		; Set master serial handler
		ld   a, LOW(SerialHandler_Master)
		ld   [wSerialIntPtr_Low], a
		ld   a, HIGH(SerialHandler_Master)
		ld   [wSerialIntPtr_High], a
		
		; Initialize head/tail buffer indexes 
		; See also: JoyKeys_Get_Serial
		
		; Receive buffer offset by 1
		ld   a, $01
		ld   [wSerialDataReceiveBufferIndex_Head], a
		ld   a, $00
		ld   [wSerialDataReceiveBufferIndex_Tail], a
		; Send buffer offset by 2
		ld   a, $02
		ld   [wSerialDataSendBufferIndex_Head], a
		ld   a, $00
		ld   [wSerialDataSendBufferIndex_Tail], a
		jp   .end
	.setSlaveInt:
		; Set slave serial handler
		ld   a, LOW(SerialHandler_Slave)
		ld   [wSerialIntPtr_Low], a
		ld   a, HIGH(SerialHandler_Slave)
		ld   [wSerialIntPtr_High], a
		; Initialize head/tail buffer indexes (same as master)
		ld   a, $01
		ld   [wSerialDataReceiveBufferIndex_Head], a
		ld   a, $00
		ld   [wSerialDataReceiveBufferIndex_Tail], a
		ld   a, $02
		ld   [wSerialDataSendBufferIndex_Head], a
		ld   a, $00
		ld   [wSerialDataSendBufferIndex_Tail], a
		call Serial_WaitAfterHandshake
	.end:
		; End all existing interrupt requests
		xor  a
		ldh  [rIF], a
	; Restore original enabled interrupts
	pop  af			
	ldh  [rIE], a
	ret
; =============== Serial_Unused_NulSend ===============
; [TCRF] Unreferenced code, probably for testing.
; Sends a null byte $10 times to the other GB.
Serial_Unused_NulSend:
	; Clear transfer flag... if it's useful
	xor  a
	ld   [wSerialTransferDone], a
	ld   a, $10
.loop:
	push af
		;--
		; Send $00 to the other GB
		di   
		xor  a
		ld   [wSerialDataSendBuffer], a
		ldh  [rSB], a
		ld   a, START_TRANSFER_INTERNAL_CLOCK
		ldh  [rSC], a
		ei 
		;--
		call Serial_WaitAfterHandshake
		;--
		; What's the point
		ld   a, [wSerialTransferDone]
		or   a
		jr   nz, .okThen
	.okThen:
		;--
	pop  af
	dec  a				; Sent it $10 times?
	jp   nz, .loop		; If not, loop
	ret  

; =============== JoyKeys_Serial_GetActiveOtherInput ===============
; Gets the active inputs for the other player in a serial match.
; Only called with input balance != 0.
JoyKeys_Serial_GetActiveOtherInput:
	; Only do this if we're accepting serial inputs and in VS mode
	ld   a, [wSerialInputMode]
	and  a						; Handshake completed yet?
	ret  z						; If not, return
	ld   a, [wSerialPlayerId]
	and  a						; Playing in serial mode?
	ret  z						; If not, return
	
	; Determine the player ID on the other side.
	; ie: if we're playing on the 1P side, get 2P's joypad inputs
	ld   hl, hJoyKeys		
	cp   a, SERIAL_PL1_ID	; Controlling 1P?
	jr   nz, .go			; If not, jump
	ld   hl, hJoyKeys2		
	
.go:

	;
	; [Frame 2]
	; Get the active input for the other GB.
	;
	
	; C = Keys not held on the other GB
	ld   a, [hl]			
	cpl  
	ld   c, a
	
	; A = Held input at the tail value of the send buffer
	; After getting the entry, increase the tail index but don't clear it (unlike JoyKeys_Get_Serial).
	push hl
	
		; Get index to the receive buffer tail
		ld   a, [wSerialDataReceiveBufferIndex_Tail]
		ld   e, a
		; Save back an incremented copy
		inc  a											; Index++
		and  a, $7F										; Size of buffer, cyles back
		ld   [wSerialDataReceiveBufferIndex_Tail], a	; Save the updated index
		
		; Index the buffer of read inputs and read out its value.
		xor  a
		ld   d, a							; Index the data
		ld   hl, wSerialDataReceiveBuffer
		add  hl, de
		ld   a, [hl]
		
		; Decrement number of remaining inputs to read.
		ld   hl, wSerialReceivedLeft
		dec  [hl]
	pop  hl
	
	; Set hJoyKeys
	ldi  [hl], a		; Write entry to hJoyKeys
	
	; Like in JoyKeys_Get_Serial, set to hJoyNewKeys the keys released since the point hJoyKeys was recorded
	and  c				; hJoyNewKeys = hJoyKeys & C
	ld   [hl], a		; Write entry to hJoyNewKeys
	
	;
	; [Frame 0]
	; Set the values to send *after* the *next* transfer completes.
	;
	; In theory it would have been more correct to put this in JoyKeys_Get_Serial.
	call JoyKeys_Serial_SetNextTransfer
	ret
	
; =============== JoyKeys_Serial_SetNextTransfer ===============
; Sets up the next values to send when the current transfer is finished.
; This also causes the master to start the transfer.
JoyKeys_Serial_SetNextTransfer: 
	ld   a, [wSerialPlayerId]
	cp   a, SERIAL_PL1_ID		; Are we player 1?
	jr   nz, .pl2				; If not, jump
.pl1:
	;
	; Write wSerialPendingJoyKeys (1P) to head send buffer entry.
	;
	ld   a, [wSerialDataSendBufferIndex_Head]	; DE = IndexTop for send buffer
	ld   e, a
	ld   d, $00
	ld   hl, wSerialDataSendBuffer				; HL = SendBuffer
	add  hl, de									; Index it
	
	ld   a, [wSerialPendingJoyKeys]				; A = Latest joypad keys	
	call JoyKeys_FixInvalidCombinations			; Fix it
	ld   [hl], a								; Write it out
	
	xor  a										; Reset key status
	ld   [wSerialPendingJoyKeys], a
	
	; Start transfering what's already set in rSB
	ld   a, START_TRANSFER_INTERNAL_CLOCK
	ldh  [rSC], a
	ret  
.pl2:
	;
	; Write wSerialPendingJoyKeys2 (2P) to head send buffer entry
	;
	ld   a, [wSerialDataSendBufferIndex_Head]	; DE = IndexTop for send buffer
	ld   e, a
	ld   d, $00
	ld   hl, wSerialDataSendBuffer				; HL = SendBuffer
	add  hl, de									; Index it
	
	ld   a, [wSerialPendingJoyKeys2]			; A = Latest joypad keys	
	call JoyKeys_FixInvalidCombinations			; Fix it
	ld   [hl], a								; Write it out
	
	xor  a										; Reset key status
	ld   [wSerialPendingJoyKeys2], a
	ret  
	
; =============== JoyKeys_FixInvalidCombinations ===============
; Removes keypresses for impossible button combinations.
; IN
; -  A: JoyNewKeys bitmask
JoyKeys_FixInvalidCombinations:
	; If we're holding L and R at the same time, remove R
	ld   b, a
	and  a, KEY_RIGHT|KEY_LEFT
	cp   a, KEY_RIGHT|KEY_LEFT
	jp   nz, .next
	res  KEYB_RIGHT, b
.next:
	; If we're holding U and D at the same time, remove U
	ld   a, b
	and  a, KEY_UP|KEY_DOWN
	cp   a, KEY_UP|KEY_DOWN
	jp   nz, .end
	res  KEYB_UP, b
.end:
	ld   a, b
	ret  

; =============== Serial_Init ===============
; Initializes serial.
Serial_Init:
	; Disabled by default
	xor  a
	ldh  [rSB], a
	ld   [wSerialInputMode], a
	ld   [wSerialDataReceiveBuffer], a
	ld   [wSerialPlayerId], a
	ld   [wSerialTransferDone], a
	ld   [wSerialDataSendBuffer], a
	; Set the initial serial mode handler.
	; The Mode Select screen is the first to enable it.
	ld   a, LOW(ModeSelect_SerialHandler)
	ld   [wSerialIntPtr_Low], a
	ld   a, HIGH(ModeSelect_SerialHandler)
	ld   [wSerialIntPtr_High], a
	ret  
	
; =============== SerialHandler ===============
; By default this isn't called.
; The handler is called when a byte is received by either the master or slave.
SerialHandler:
	push af
	push bc
	push de
	push hl
	call .main
	pop  hl
	pop  de
	pop  bc
	pop  af
	reti
.main:
	; Read out the code ptr
	ld   hl, wSerialIntPtr_Low
	ldi  a, [hl]
	ld   e, a
	ld   h, [hl]
	ld   l, e
	; Jump there
	jp   hl
	
; =============== ModeSelect_SerialHandler ===============
; Serial handler for Module_Title.
ModeSelect_SerialHandler:
	; This handler is used to make the game wait at ModeSelect_Serial_Wait
	; until both DMGs have sent a byte (MODESELECT_SBCMD_*) to each other.

	ldh  a, [rSB]						; Read byte from serial
	ld   [wSerialDataReceiveBuffer], a	; Copy it here

	; When a byte from serial is received, the transfer flag from rSC gets automatically unset
	; from both sides.
	;
	; In case of the master, that doesn't make a difference since when it starts a transfer
	; in ModeSelect_Serial_SendAndWait, the rSC value gets set to the proper value.
	;
	; That would be bad since with the slave though. If the master tries to send a byte while
	; the slave isn't listening (START_TRANSFER_EXTERNAL_CLOCK unset), ModeSelect_Serial_Wait will infinite loop.
	;
	; It's also important, at least when the ModeSelect main loop is still executing,
	; that the master doesn't get START_TRANSFER_EXTERNAL_CLOCK immediately set before the frame ends (see below).
	; Otherwise, because of how ModeSelect is programmed, the next frame it will treat the previously
	; sent MODESELECT_SBCMD_* value as what the *other* DMG sent, set itself as a slave,
	; and infinite loop in ModeSelect_Serial_Wait listening for a byte that will never be sent.
	;
	; This is only a problem here because the game treats the received data as something
	; other than joypad input.
	;
	;
	; Therefore, if we are set as slave, immediately set START_TRANSFER_EXTERNAL_CLOCK to listen for the next byte.
	; Normally START_TRANSFER_EXTERNAL_CLOCK would be set at the start of the ModeSelect main loop,
	; but the serial send and receive functions take exclusive control.
	;


	; Dumb detection of master/slave since we can't use MISCB_SERIAL_SLAVE yet.
	; Because the master is expecting the slave to reply with MODESELECT_SBCMD_IDLE, we can
	; use it to determine on which side we are.
	;
	; Because rSB is "shared" across master/slave in a delayed way, eventually the master will read
	; its own values back, but it won't matter anymore by that point.
	cp   MODESELECT_SBCMD_IDLE			; Did we receive the idle command?
	jr   z, .master						; If so, jump
.slave:
	ld   a, START_TRANSFER_EXTERNAL_CLOCK	; Allow listening for next byte immediately
	ldh  [rSC], a
	ld   a, $01							; Allow exit from ModeSelect_Serial_Wait
	ld   [wSerialTransferDone], a
	ret
.master:
	; Stop listening for bytes
	ld   a, $01							; Allow exit from ModeSelect_Serial_Wait
	ld   [wSerialTransferDone], a
	ret

; =============== SerialHandler_Handshake ===============
; Simple serial handler used when doing the handshake between master and slave,
; typically when a module is initializing.
SerialHandler_Handshake:

	; Handle Send/Receive (single byte, no buffer)
	ldh  a, [rSB]						; Read received byte from serial
	ld   [wSerialDataReceiveBuffer], a	; Save to receive buffer
	ld   a, [wSerialDataSendBuffer]		; Read from send buffer
	ldh  [rSB], a						; Send it out
	ld   a, $01							; Mark transfer as done since we're received the byte
	ld   [wSerialTransferDone], a

	; If we're set as slave, listen to the next received byte.
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_SLAVE, a			; Are we set as slave?
	ret  z									; If not, return
	ld   a, START_TRANSFER_EXTERNAL_CLOCK	; Listen for new byte
	ldh  [rSC], a
	ret

; =============== SerialHandler_Master ===============
; Serial handler for buffered input mode.
SerialHandler_Master:
	call SerialHandler_HeadBufferSet
	; The master only starts a transfer when it gets to send more data in JoyKeys_Serial_SetNextTransfer
	ld   a, $01
	ld   [wSerialTransferDone], a
	ret
; =============== SerialHandler_Slave ===============
; Serial handler for buffered input mode.
SerialHandler_Slave:
	call SerialHandler_HeadBufferSet
	; The slave always needs to listen to new transfers
	ld   a, START_TRANSFER_EXTERNAL_CLOCK
	ldh  [rSC], a
	ld   a, $01
	ld   [wSerialTransferDone], a
	ret

; =============== SerialHandler_HeadBufferSet ===============
; Sets the next serial data to the top of the receive and send buffers.
SerialHandler_HeadBufferSet:

	;
	; Write the current byte from rSB to the head index of the receive buffer.
	; Increase the index as well, wrapping back to $00 when it reaches the end.
	;

	ld   a, [wSerialDataReceiveBufferIndex_Head]
	ld   e, a										; E = Copy of RecvHeadIdx for indexing
	inc  a											; Increase RecvHeadIdx
	and  a, $7F										; Wrap around to $00 if past the buffer
	ld   [wSerialDataReceiveBufferIndex_Head], a	; Save back the increased index

	ld   d, $00										; DE = RecvHeadIdx
	ld   hl, wSerialDataReceiveBuffer				; HL = RecvBuffer
	add  hl, de										; Index the receive buffer table
	ldh  a, [rSB]									; Read the received byte from the other GB
	ld   [hl], a									; Write it in the buffer

	ld   hl, wSerialReceivedLeft			; Mark that a byte was received
	inc  [hl]

	;
	; Write the current byte from the head index of the send buffer to rSB.
	; Update its index the same way.
	;
	ld   a, [wSerialDataSendBufferIndex_Head]
	ld   e, a										; E = Copy of SentHeadIdx for indexing
	inc  a											; Increase SentHeadIdx
	and  a, $7F										; Wrap around to $00 if past the buffer
	ld   [wSerialDataSendBufferIndex_Head], a		; Save back the increased index

	ld   d, $00										; DE = SentHeadIdx
	ld   hl, wSerialDataSendBuffer					; HL = SentBuffer
	add  hl, de										; Index the send buffer table
	ld   a, [hl]									; Read the newest byte to send
	ldh  [rSB], a									; Send it out

	ld   hl, wSerialSentLeft				; Mark that a byte was sent
	inc  [hl]
	ret

; =============== Serial_WaitAfterHandshake ===============
; Waits for a bit after the slave finishes the handshake.
Serial_WaitAfterHandshake:
	ld   bc, $0600		; BC = Loop count
.loop:
	nop  				; Waste some cycles
	nop
	dec  bc				; LoopCount--
	ld   a, b
	or   c				; LoopCount == 0?
	jp   nz, .loop		; If not, loop
	ret

; =============== Serial_Unused_Jp4380 ===============
; [TCRF] Unreferenced code.
Serial_Unused_Jp4000:
	jp   $4000
	
; =============== Play_DoPl_1P ===============
; Task for handling Player 1.
Play_DoPl_1P:
	; Set unique stack pointer for 1P handler
	ld   sp, $DE00
	ei
	; Set wPlInfo & wOBJInfo combination for 1P
	ld   bc, wPlInfo_Pl1
	ld   de, wOBJInfo_Pl1
	jr   Play_DoPl

; =============== Play_DoPl_2P ===============
; Task for handling Player 2.
Play_DoPl_2P:
	; Set unique stack pointer for 2P handler
	ld   sp, $DF00
	ei
	; Set wPlInfo & wOBJInfo combination for 2P
	ld   bc, wPlInfo_Pl2
	ld   de, wOBJInfo_Pl2

; =============== Play_DoPl ===============
; Common task code for handling a player.
; Mostly to run the move code.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Play_DoPl:
	ld   a, $02 ; BANK $02
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
.mainLoop:
	; Preserve the parameters across calls, allowing this to be generic
	push bc
		push de
			call .go
		pop  de
	pop  bc
	call Task_PassControlFar
	jp   .mainLoop

.go:
	call Play_Pl_CreateJoyKeysLH
	call Play_Pl_ChkHitstop
	jp   c, .execMoveCode
	; Perform the special input reader check (character-specific)
	call Play_Pl_ExecSpecMoveInputCode	; Did we start a new special/super?
	jp   c, .chkHit						; If so, skip checking for normal movement
	; Perform the standard input reader for basic moves
	call Play_Pl_DoBasicMoveInput		; Check normal moves
.chkHit:
	call Play_Pl_DoHit					; Handle attacks that collided with us
.execMoveCode:
	;
	; Execute the code for the currently set move.
	; The move code primarily is used to perform actions when the move animation
	; reaches a certain point. This can be anything from updating the player's movement speed,
	; spawning a projectile, etc...
	; Some moves also transition to a different move depending on the logic, sometimes at the beginning.
	; This is how, for example, neutral jumps set by Play_Pl_DoBasicMoveInput can turn into forward jumps.
	;
	; The same move code can be reused for multiple moves across multiple characters,
	; so labeling them can be tricky.
	;
	push de
	
		; All of the move ptr tables are in BANK $06
		ld   a, BANK(MoveCodePtrTbl_Marker) ; BANK $06
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		
		; Read out to DE the move pointer table for the current player.
		ld   hl, iPlInfo_MoveCodePtrTbl_High
		add  hl, bc		
		ld   d, [hl]
		inc  hl
		ld   e, [hl]
		
		; Index the current move entry from the move ptr table.
		; As each entry is 4 bytes long and move IDs are multiplied by 2 already
		; (like character IDs), generate the table offset like this:
		; DE = A * 2
		push de
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   l, [hl]		; HL = Move ID * 2
			ld   h, $00
			add  hl, hl
		pop  de
		; Add the offset
		add  hl, de
		
		; DE = Move code ptr (bytes0-1)
		ld   e, [hl]
		inc  hl
		ld   d, [hl]
		inc  hl
		; A = Bank number (byte2)
		ld   a, [hl]
		ld   [MBC1RomBank], a	; Switch bank
		ldh  [hROMBank], a
		push de
		pop  hl					; Move ptr to HL
	pop  de						; Restore ptr to wOBJInfo
	
	;
	; Every move code (Move_*) uses these parameters:
	; IN
	; - BC: Ptr to wPlInfo structure
	; - DE: Ptr to respective wOBJInfo structure
	jp   hl
; =============== HomeCall_Play_CPU_Do ===============
HomeCall_Play_CPU_Do:
	ldh  a, [hROMBank]
	push af
	ld   a, BANK(Play_CPU_Do) ; BANK $1F
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	call Play_CPU_Do
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	
; =============== Pl_SetNewMove ===============
; Shared code for updating the wPlInfo when starting a new move.
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
Pl_SetNewMove:
	push bc
		push de
			; Set that we started a new move
			ld   hl, iPlInfo_Flags2
			add  hl, bc
			set  PF2B_MOVESTART, [hl]

			; Set the new move ID
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   [hl], a

			; Blank out iPlInfo_JoyBufKeysLH in case it was used to check for inputs
			ld   hl, iPlInfo_JoyBufKeysLH
			add  hl, bc
			ld   [hl], $00

			;
			; Update the wOBJInfo fields depending on the move we selected.
			;
			; This will index iPlInfo_MoveAnimTblPtr by MoveId, and copy the valuses
			; from there to the wOBJInfo and wPlInfo.
			;
			; Most importantly, the sprite mapping pointer gets updated among these.
			;

			;--
			;
			; HL = Ptr to move animation table ptr
			;
			ld   hl, iPlInfo_MoveAnimTblPtr_High
			add  hl, bc
			push hl	; Save HL

				; BC = Starting destination for wPlInfo fields
				ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
				add  hl, bc
				push hl
				pop  bc

				; DE = Starting destination for wOBJInfo fields
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				push hl
				pop  de
			pop  hl

			push de ; Restore HL

				;
				; Switch to BANK $05, as all move animation tables are stored there.
				; [POI] Unsafe ROM bank switch, will break if VBLANK triggers here.
				;
				push af
					ld   a, BANK(MoveAnimTbl_Marker) ; BANK $05
					ld   [MBC1RomBank], a
				pop  af

				;
				; DE = Ptr to start of the move animation table for this player.
				;
				ld   d, [hl]	; D = iPlInfo_MoveAnimTblPtr_High
				inc  hl
				ld   e, [hl]	; E = iPlInfo_MoveAnimTblPtr_Low

				;
				; Generate the offset to the table entry from the Move Id.
				;
				; Each entry in the table is 8 bytes long.
				; Considering MoveId is already multiplied by 2 for easy indexing,
				; this means we have to multiply it by 4.
				;
				ld   h, $00
				ld   l, a		; HL = MoveId (*2)
				add  hl, hl		; * 2
				add  hl, hl		; * 2

				; HL = Ptr to table entry
				add  hl, de
			pop  de

			; Copy the data over

			; byte0 -> iOBJInfo_BankNum
			ldi  a, [hl]
			ld   [de], a
			inc  de

			; byte1 -> iOBJInfo_OBJLstPtrTbl_Low
			ldi  a, [hl]
			ld   [de], a
			inc  de

			; byte2 -> iOBJInfo_OBJLstPtrTbl_High
			ldi  a, [hl]
			ld   [de], a
			inc  de

			; byte3 -> iPlInfo_OBJLstPtrTblOffsetMoveEnd
			ldi  a, [hl]
			ld   [bc], a
			inc  bc			; Seek to iPlInfo_MoveDamageVal

			; Always reset the animation from the beginning
			xor  a
			ld   [de], a	; iOBJInfo_OBJLstPtrTblOffset = 0
			inc  de			; Seek to iOBJInfo_BankNumView

			; Seek the wOBJInfo destination ptr (DE) to iOBJInfo_FrameLeft.
			; As we're currently on iOBJInfo_BankNumView...
			push hl
				ld   hl, iOBJInfo_FrameLeft-iOBJInfo_BankNumView
				add  hl, de		; HL = DE + 7
				push hl
				pop  de			; DE = HL
			pop  hl


			; Initialize animation speed

			; byte4 -> iOBJInfo_FrameLeft
			ldi  a, [hl]
			ld   [de], a
			inc  de

			; byte4 -> iOBJInfo_FrameTotal
			ld   [de], a


			; Prepare the damage-related fields for the new move.
			; While the graphics for the first sprite mapping in the animation load, prevent the visible
			; one ("Old Set"), from dealing further damage to avoid inconsistencies.
			; The move code (MoveC_*) may decide to manually call Play_Pl_IsMoveLoading to check
			; and copy over the pending damage fields to the visible set when it's ready.

			; Clear current damage fields
			xor  a
			ld   [bc], a	; iPlInfo_MoveDamageVal
			inc  bc
			ld   [bc], a	; iPlInfo_MoveDamageHitTypeId
			inc  bc
			ld   [bc], a	; iPlInfo_MoveDamageFlags3
			inc  bc

			; Set pending damage fields

			; byte5 -> iPlInfo_MoveDamageValNext
			ldi  a, [hl]
			ld   [bc], a
			inc  bc

			; byte6 -> iPlInfo_MoveDamageHitTypeIdNext
			ldi  a, [hl]
			ld   [bc], a
			inc  bc

			; byte7 -> iPlInfo_MoveDamageFlags3Next
			ld   a, [hl]
			ld   [bc], a

			; Restore original ROM bank
			ldh  a, [hROMBank]
			ld   [MBC1RomBank], a
		pop  de
	pop  bc
	ret
	
; =============== ExOBJS_Play_ChkHitModeAndMoveH ===============
; Moves the specified projectile horizontally and handles its hit mode.
; IN
; - DE: Ptr to wOBJInfo
; OUT
; - C flag; If set, the OBJInfo can be despawned
ExOBJS_Play_ChkHitModeAndMoveH:

	;
	; If the sprite goes past the edges of the screen, it can be despawned.
	;
	ld   hl, iOBJInfo_RelX
	add  hl, de
	ld   a, [hl]
	cp   OBJ_OFFSET_X+$00		; A < 0?
	jp   c, .retSet				; If so, jump
	cp   OBJ_OFFSET_X+SCREEN_H	; A >= screen width?
	jp   nc, .retSet			; If so, jump

	;
	; Despawn the projectiles only if it has its priority value != $02.
	; Undespawnable projectiles that deal continuous damage or those for special effects use this value.
	;
	ld   hl, iOBJInfo_Play_Priority
	add  hl, de
	ld   a, [hl]
	cp   PROJ_PRIORITY_NODESPAWN	; iOBJInfo_Play_Priority == $02?
	jp   z, .move					; If so, jump
	
	;
	; Handle sprite hit modes, applicable to projectiles only.
	; These are related to the collision detection against the opponent.
	;
	ld   hl, iOBJInfo_Play_HitMode
	add  hl, de
	ld   a, [hl]
	cp   PHM_REMOVE		; Did it get removed? (ie: projectile hit the target)
	jp   z, .retSet		; If so, jump
	cp   PHM_REFLECT	; Did it get reflected?
	jp   z, .chkReflect	; If so, jump

	; Otherwise, just move the sprite horizontally
.move:
	call OBJLstS_ApplyXSpeed
.retClear:
	xor  a	; C flag clear
	ret
.retSet:
	scf		; C flag set
	ret
.chkReflect:
	;
	; Reflecting projectiles moves their OBJInfo to the opponent's slot,
	; effectively turning it into the opponent's projectile.
	;
	; This is due to several hardcoded assumptions with the projectile slots.
	; For example, wOBJInfo_Pl1Projectile is always "owned" by 1P and can only ever hit wOBJInfo_Pl2
	; while wOBJInfo_Pl2Projectile is always 2P's and can only ever hit wOBJInfo_Pl1,
	; so if 2P were to reflect 1P's projectile, the only way to make it work
	; would be to move wOBJInfo_Pl1Projectile over to wOBJInfo_Pl2Projectile
	; and changing some of its fields.
	;

	; Detect which projectile slot got reflected, depending on the wOBJInfo address.
	ld   a, e
	cp   a, LOW(wOBJInfo_Pl2Projectile)	; Are we 2P's projectile?
	jp   z, .reflect2P					; If so, jump
.reflect1P:
	;
	; 2P reflected 1P's projectile.
	;

	; Don't reflect the projectile if 2P's projectile is visible.
	; Otherwise the one on screen would visibly disappear.
	; In that case, just flag the projectile for removal (return through .retClear).
	ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Status	; HL = Ptr to target projectile
	bit  OSTB_VISIBLE, [hl]		; Is 2P's projectile already visible?
	jp   nz, .retClear			; If so, ignore

	; Reflect it
	call Play_Proj_Reflect

	; Hide 1P's projectile
	ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	; And disable its hitbox
	ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_HitboxId
	ld   [hl], COLIBOX_00
	jp   .retClear
.reflect2P:
	;
	; 1P reflected 2P's projectile.
	;

	; Don't reflect if 1P's slot is already used
	ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Status	; HL = Ptr to target projectile
	bit  OSTB_VISIBLE, [hl]
	jp   nz, .retClear

	; Reflect it
	call Play_Proj_Reflect

	; Hide 2P's projectile
	ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	; And disable its hitbox
	ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_HitboxId
	ld   [hl], COLIBOX_00
	jp   .retClear
; =============== Play_Proj_Reflect ===============
; Reflects a projectile.
; See .chkReflect from the subroutine above.
; IN
; - DE: Ptr to source wOBJInfo (projectile that got reflected)
; - HL: Ptr to destination wOBJInfo (whereto copy it over)
Play_Proj_Reflect:
	push bc
		push de

			;
			; Copy the full wOBJInfo to the opponent's slot
			;
			push hl
				ld   b, OBJINFO_SIZE	; B = Bytes to copy
			.cpLoop:
				ld   a, [de]
				ldi  [hl], a
				inc  de
				dec  b					; Are we done?
				jp   nz, .cpLoop		; If not, loop
			pop  bc	; BC = Ptr to destination slot

			; Reset its hit mode, so it won't try to reflect it again
			ld   hl, iOBJInfo_Play_HitMode
			add  hl, bc
			ld   [hl], PHM_NONE

			; Flip it horizontally and switch its palette (1P & 2P have different palettes)
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, bc
			ld   a, [hl]
			xor  a, SPR_OBP1|SPR_XFLIP
			ld   [hl], a

			;
			; Invert its horizontal speed to make it return back.
			;
			push de
				ld   hl, iOBJInfo_SpeedX
				add  hl, bc
				ld   d, [hl]	; D = iOBJInfo_SpeedX
				inc  hl
				ld   e, [hl]	; E = iOBJInfo_SpeedXSub
				ld   a, d		; Invert high byte
				cpl
				ld   d, a
				ld   a, e		; Invert low byte
				cpl
				ld   e, a
				inc  e			; Account for bitflip
				jp   nz, .saveSpd
				inc  d
			.saveSpd:
				ld   [hl], e	; Save it back
				dec  hl
				ld   [hl], d
			pop  de

			; Play SGB/DMG SFX
			ld   a, SCT_REFLECT
			call HomeCall_Sound_ReqPlayExId
		pop  de
	pop  bc
	ret

; =============== OBJLstS_Hide ===============
; Hides/disables the specified sprite mapping.
; IN
; - DE: Ptr to wOBJInfo
OBJLstS_Hide:
	xor  a
	ld   hl, iOBJInfo_Status
	add  hl, de		; Seek to status flags
	ld   [hl], a	; Erase them to hide the sprite mapping
	ret

; =============== MoveC_Base_Jump ===============
; Move code handler for all jump types.
;
; This move is one of the many that takes manual control of its animation timing.
; In this case, it's done because there are several ways to influence the jump,
; so rather than wasting space with different animations, the frames advance only
; when the player's Y Speed becomes > some value.
;
; To do this, the game checks which frame of the animation we're on (iOBJInfo_OBJLstPtrTblOffsetView)
; and jumps to the appropriate ".obj*". Each of these defines its own target
; speed to check, calling OBJLstS_ReqAnimOnGtYSpeed to request advancing the animation once.
MoveC_Base_Jump:
	call Play_Pl_MoveByColiBoxOverlapX
	call Play_Pl_AddToJoyBufKeysLH
	mMvC_ValLoaded .ret
	
	; Moves use iOBJInfo_OBJLstPtrTblOffsetView to always execute code relevant to the visible frame.
	; This has the nice result of OSTB_GFXNEWLOAD being only set the very first time we
	; execute the code for any given .obj*, allowing an easy way to execute code code once.
	;
	; For the same reason, OBJLstS_IsInternalFrameAboutToEnd can't be used to determine if we're about
	; to switch frames since it goes off the *internal* frame ID.
	
	; Don't allow executing normals when displaying the first and last frame.
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0_init
		mMvC_ChkFrame $07, .obj7_landed
	
	;
	; Move Input Reader
	;
	
	; If we've landed, skip this
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   a, [hl]
	cp   PL_FLOOR_POS	; iOBJInfo_Y == PL_FLOOR_POS?
	jr   z, .chkAct		; If so, skip

	; Check if we're starting normals in the middle of the jump
	ld   hl, iPlInfo_JoyBufKeysLH
	add  hl, bc
	; Normals (air)
	bit  KEPB_A_LIGHT, [hl]		; Light kick?
	jp   nz, .startAirKickL		; If so, jump
	bit  KEPB_B_LIGHT, [hl]		; Light punch?
	jp   nz, .startAirPunchL	; If so, jump
	bit  KEPB_A_HEAVY, [hl]		; Heavy kick?
	jp   nz, .startAirKickH		; If so, jump
	bit  KEPB_B_HEAVY, [hl]		; Heavy punch?
	jp   nz, .startAirPunchH	; If so, jump
	
.chkAct:
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1_setJumpType
		mMvC_ChkFrame $02, .obj2_air
		mMvC_ChkFrame $03, .obj3_air
		mMvC_ChkFrame $04, .obj4_air
		mMvC_ChkFrame $05, .obj5_air
		mMvC_ChkFrame $06, .chkWallJump
	jp   .move ; We never get here
	
; Starts the A+B air attack.
.startAirAttack:
	ld   a, MOVE_SHARED_ATTACK_A
	call Pl_SetMove_Simple
	jp   .move
; Starts the downwards heavy air punch
.startAirPunchD:
	ld   a, MOVE_SHARED_PUNCH_AHD
	call Pl_SetMove_Simple
	jp   .move
; Starts the downwards heavy air kick
.startAirKickD:
	ld   a, MOVE_SHARED_KICK_AHD
	call Pl_SetMove_Simple
	jp   .ret
; Starts the backwards heavy air kick
.startAirKickB:
	ld   a, MOVE_SHARED_KICK_AHB
	call Pl_SetMove_Simple
	jp   .move
	
; Generates code to start an air attack from a jump.
; IN
; - 1: Move to start if doing a neutral jump
; - 2: Move to start with other jumps
MACRO mStartAirJumpMove
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_JUMP_N	; Doing a neutral jump?
	jp   z, .setAirN_\@		; If so, jump
.setAirX_\@:
	ld   a, \2				; Non-neutral attack
	jp   .setAirMove_\@
.setAirN_\@:
	ld   a, \1				; Neutral attack
.setAirMove_\@:
	call Pl_SetMove_Simple
	jp   .move
ENDM
	
; Starts a light air punch.
.startAirPunchL:
	; If A+B are held, start that attack instead
	call Play_Pl_AreBothBtnHeld
	jp   c, .startAirAttack
	; New move
	mStartAirJumpMove MOVE_SHARED_PUNCH_ALI, MOVE_SHARED_PUNCH_ALX
	
; Starts a light air kick.
.startAirKickL:
	; If A+B are held, start that attack instead
	call Play_Pl_AreBothBtnHeld
	jp   c, .startAirAttack
	; New move
	mStartAirJumpMove MOVE_SHARED_KICK_ALI, MOVE_SHARED_KICK_ALX
	
; Starts an heavy air punch.
.startAirPunchH:
	; If A+B are held, start that attack instead
	call Play_Pl_AreBothBtnHeld
	jp   c, .startAirAttack
	; If DOWN is held, start that variation instead
	call Play_Pl_ChkPunchAHD
	jp   c, .startAirPunchD
	; New move
	mStartAirJumpMove MOVE_SHARED_PUNCH_AHI, MOVE_SHARED_PUNCH_AHX
	
; Starts an heavy air kick.	
.startAirKickH:
	; If A+B are held, start that attack instead
	call Play_Pl_AreBothBtnHeld
	jp   c, .startAirAttack
	; If DOWN is held, start that variation instead
	call Play_Pl_ChkKickAHD
	jp   c, .startAirKickD
	; If BACK is held, start that variation instead
	call Play_Pl_ChkKickAHB
	jp   c, .startAirKickB
	; New move
	mStartAirJumpMove MOVE_SHARED_KICK_AHI, MOVE_SHARED_KICK_AHX
	
; --------------- frame #0 ---------------
; Preparing to jump.
;
; Get manual control of the animation timing as soon as the internal frame
; is about to change (iOBJInfo_FrameLeft == 0, as checked by OBJLstS_IsInternalFrameAboutToEnd).
; Since the graphics for the new frame have to load, this will still be called a few times after that.
.obj0_init:
	mMvC_ValFrameEnd .anim
	mMvC_SetAnimSpeed ANIMSPEED_NONE
	jp   .anim

; --------------- frame #1 ---------------
; Starting the jump, and determines its "type".
;
; Jump "types" don't really exist though.
; What actually happens is that, through a series of checks that mostly depend
; on player input, the vertical and horizontal speed are updated, then the movement physics do the rest.
;
.obj1_setJumpType:

	; Set the jump settings only the first time we get here.
	; Every time after, jump to .obj1_chkEnd to check if we're done.
	mMvC_ValFrameStartFast .obj1_chkEnd

.chkSettings:
	; Play SFX for it
	ld   a, SFX_JUMP
	call HomeCall_Sound_ReqPlayExId
	
	; We're in the air now
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	
	;
	; JUMP DIRECTION
	;

	; Decide the jump direction depending on the input we were holding right before starting the jump move.
	ld   hl, iPlInfo_JoyKeysPreJump
	add  hl, bc
	bit  KEYB_LEFT, [hl]	; Did we hold left?
	jr   nz, .chkJumpL		; If so, jump
	bit  KEYB_RIGHT, [hl]	; Did we hold right?
	jr   nz, .chkJumpR		; If so, jump

	; Otherwise, it's neutral, and we can skip ahead.
	; The movement speed and move ID (MOVE_SHARED_JUMP_N) we currently have set
	; are already correct, as it's not possible to do fast neutral jumps.
	jr   .neutral
	;--
.chkJumpL:

	;
	; HORIZONTAL JUMP SPEED
	; This is hardcoded to be 1.5px/frame.
	; With hyper jumps, which in this game is performed by tapping up rather than holding it,
	; this is doubled to 3px/frame.
	;
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ld   a, [hl]		; A = Held keys
	ld   hl, -$0180		; HSpeed = -1.5px/frame
	bit  KEYB_UP, a		; Currently holding up?
	jr   nz, .setSpeedL	; If so, skip
	sla  l				; Otherwise, HSpeed *= 2
	rl   h
.setSpeedL:
	; Set the jump speed
	call Play_OBJLstS_SetSpeedH
	
	; Pick the appropriate jump move depending on the direction we're facing.
	ld   a, MOVE_SHARED_JUMP_B		; A = Default with backwards jump
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de						; Seek to flags
	bit  OSTB_XFLIP, [hl]			; Are we visually facing left (1P side)?
	jr   nz, .setDiagJump			; If so, jump (L is backwards on 1P side)
	ld   a, MOVE_SHARED_JUMP_F		; While it's forwards on 2P side
	jr   .setDiagJump
	
.chkJumpR:
	; Just like .chkJumpL, except the jump speed is positive.
	; and with move IDs the other way around.
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ld   a, [hl]
	ld   hl, +$0180
	bit  KEYB_UP, a
	jr   nz, .setSpeedR
	sla  l
	rl   h
.setSpeedR:
	call Play_OBJLstS_SetSpeedH
	
	ld   a, MOVE_SHARED_JUMP_F
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  OSTB_XFLIP, [hl]
	jr   nz, .setDiagJump
	ld   a, MOVE_SHARED_JUMP_B
	;--
.setDiagJump:

	;
	; Update the move ID
	;
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   [hl], a

	;
	; Update the ptr for this animation, reading it from the MoveAnimTbl_* similarly to Pl_SetNewMove.
	;
	push de
		; DE = Ptr to destination iOBJInfo_OBJLstPtrTbl_Low
		ld   hl, iOBJInfo_OBJLstPtrTbl_Low
		add  hl, de
		push hl
		pop  de

		push de
			;
			; Switch to BANK $05, as all move animation tables are stored there.
			; [POI] Unsafe ROM bank switch, will break if VBLANK triggers here.
			;
			push af
				ld   a, BANK(MoveAnimTbl_Marker) ; BANK $05
				ld   [MBC1RomBank], a
			pop  af

			;
			; DE = Ptr to start of the move animation table for this player.
			;
			ld   hl, iPlInfo_MoveAnimTblPtr_High
			add  hl, bc
			ld   d, [hl]	; D = iPlInfo_MoveAnimTblPtr_High
			inc  hl
			ld   e, [hl]	; E = iPlInfo_MoveAnimTblPtr_Low

			;
			; Generate the offset to the table entry from the Move Id.
			;
			; Each entry in the table is 8 bytes long.
			; Considering MoveId is already multiplied by 2 for easy indexing,
			; this means we have to multiply it by 4.
			;
			ld   h, $00
			ld   l, a		; HL = MoveId (*2)
			add  hl, hl		; * 2
			add  hl, hl		; * 2

			; HL = Ptr to table entry
			add  hl, de
		pop  de

		;
		; Update both sets of iOBJInfo_OBJLstPtrTbl.
		;

		; Since the bank number iOBJInfo_BankNum isn't updated, it means
		; the sprite mappings for the three jump moves must be in the same bank.
		; In practice, all sprite mappings for any given character are stored in the same bank anyway.

		; byte0 -> (skipped)
		inc  hl		; Seek to byte1

		; byte1 -> iOBJInfo_OBJLstPtrTbl_Low
		ldi  a, [hl]
		ld   [de], a
		inc  de		; Seek to iOBJInfo_OBJLstPtrTbl_High

		; byte1 -> iOBJInfo_OBJLstPtrTbl_LowView
		inc  de		; Seek to iOBJInfo_OBJLstPtrTblOffset
		inc  de		; ...iOBJInfo_BankNumView
		inc  de		; ...iOBJInfo_OBJLstPtrTbl_LowView
		ld   [de], a
		dec  de		; and back
		dec  de
		dec  de

		; byte2 -> iOBJInfo_OBJLstPtrTbl_High
		ldi  a, [hl]
		ld   [de], a
		inc  de		; Seek to iOBJInfo_OBJLstPtrTblOffset
		inc  de		; ...iOBJInfo_BankNumView
		inc  de		; ...iOBJInfo_OBJLstPtrTbl_LowView
		inc  de		; ...iOBJInfo_OBJLstPtrTbl_HighView
		ld   [de], a

		; Restore original bank number
		ldh  a, [hROMBank]
		ld   [MBC1RomBank], a
	pop  de
.neutral:
	;
	; VERTICAL JUMP SPEED
	;
	; Hardcoded to 7px/frame
	;
	mMvC_SetSpeedV -$0700
	jp   .move
.obj1_chkEnd:
	; Advance to frame#2 when reaching YSpeed > -7
	mMvC_NextFrameOnGtYSpeed -$07, ANIMSPEED_NONE
	jp   .chkWallJump

; --------------- frames #2-5 ---------------
; Advance to the next frame when reaching the targets.
.obj2_air:
	mMvC_NextFrameOnGtYSpeed -$05, ANIMSPEED_NONE
	jp   .chkWallJump
.obj3_air:
	mMvC_NextFrameOnGtYSpeed -$03, ANIMSPEED_NONE
	jp   .chkWallJump
.obj4_air:
	mMvC_NextFrameOnGtYSpeed -$01, ANIMSPEED_NONE
	jp   .chkWallJump
.obj5_air:
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	jp   .chkWallJump
	

; --------------- common frames #2-6 ---------------
; Handle the wall jump.
;
; This is allowed for any of the sprite mappings used when we're in the air (#2-6)
.chkWallJump:
	call Play_Pl_ChkWallJumpInput
	jp   nc, .move
	jp   .ret
; --------------- common frames #1-6 ---------------
; Move the player in the air, applying gravity.
.move:
	; Gravity is hardcoded to 0.375px/frame
	mMvC_ChkGravityHV $0060, .anim
	; Switch to the landing phase.
	mMvC_SetLandFrame $07, ANIMSPEED_INSTANT
	jp   .ret

; --------------- frame #7 ---------------
; Landing frame
;
; Just waits for the frame to end before ending the move.
.obj7_landed:
	mMvC_ValFrameEnd .anim				; Is the frame about to finish? ; If not, continue
	call Play_Pl_EndMove				; Otherwise, we're done
	jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

	
; =============== Play_Pl_ChkWallJumpInput ===============
; Handles the input for performing a wall jump.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a new jump was started
Play_Pl_ChkWallJumpInput:
	; Only these characters can wall jump.
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_MAI		; Playing as Mai?
	jp   z, .chkEdge		; If so, jump
	cp   CHAR_ID_ATHENA		; ...
	jp   z, .chkEdge
	cp   CHAR_ID_EIJI
	jp   z, .chkEdge
	cp   CHAR_ID_NAKORURU
	jp   z, .chkEdge
	jp   .retClear			; Otherwise, return
.chkEdge:
	; The player must be on the edge of the screen.
	; If iOBJInfo_RangeMoveAmount
	ld   hl, iOBJInfo_RangeMoveAmount
	add  hl, de
	ld   a, [hl]
	or   a				; RangeMoveAmount == 0?
	jp   z, .retClear	; If so, return

	; Check if we held the direction towards the wall.
	; This changes depending the side of the screen, and RangeMoveAmount can be used to determine it.
	; If RangeMoveAmount < 0, it means we got pushed to the left when hugging the right border.
	bit  7, a			; RangeMoveAmount < 0?
	jp   nz, .chkRWall	; If so, jump
.chkLWall:
	; Must hold right if we're on the left wall
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	bit  KEYB_RIGHT, [hl]
	jp   z, .retClear

	; OK - Jump can start

	; The jump should move us to the right
	ld   hl, iPlInfo_JoyKeysPreJump
	add  hl, bc
	set  KEYB_RIGHT, [hl]
	res  KEYB_LEFT, [hl]
	jp   .turn
.chkRWall:
	; Must hold left if we're on the left wall
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	bit  KEYB_LEFT, [hl]
	jp   z, .retClear

	; OK - Jump can start

	; The jump should move us to the left
	ld   hl, iPlInfo_JoyKeysPreJump
	add  hl, bc
	set  KEYB_LEFT, [hl]
	res  KEYB_RIGHT, [hl]
	jp   .turn
.retClear:
	scf
	ccf		; C flag cleared
	ret

.turn:
	; Flip the player sprite horizontally to jump the other way
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRXB_PLDIR_R, [hl]	; Internally facing right?
	jp   z, .turnR				; If not, jump
.turnL:
	set  SPRB_XFLIP, [hl]	; Face left
	jp   .jumpOk
.turnR:
	res  SPRB_XFLIP, [hl]	; Face right
.jumpOk:
	; Restart the jump sequence by starting a new one.
	ld   a, MOVE_SHARED_JUMP_N
	call Pl_SetMove_StopSpeed
	scf		; C flag set
	ret
	
; =============== Play_Pl_ChkPunchAHD ===============
; Handles the input for performing the alternate heavy air punch.
; Performed by holding DOWN while performing one, but only few characters have one.
;
; This subroutine is meant to be called after the heavy air punch input is already checked.
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, the input is performed
Play_Pl_ChkPunchAHD:
	; Only if playing as Kyo or Mai
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_KYO
	jp   z, .chkInput
	cp   CHAR_ID_MAI
	jp   z, .chkInput
	jp   .retClear
.chkInput:
	; Check for the DOWN input
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ld   a, [hl]
	bit  KEYB_DOWN, a
	jp   nz, .retSet
.retClear:
	scf  
	ccf  	; C flag cleared
	ret  
.retSet:
	scf  	; C flag set
	ret
	
; =============== Play_Pl_ChkKickAHD ===============
; Handles the input for performing the alternate heavy air kick, which bounces off
; the opponent on hit.
; Performed by holding DOWN while performing one, but only few characters have one.
;
; See also: Play_Pl_ChkPunchAHD
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, the input is performed
Play_Pl_ChkKickAHD:
	; Only if playing as Benimaru or Athena
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_BENIMARU
	jp   z, .chkInput
	cp   CHAR_ID_ATHENA
	jp   z, .chkInput
	jp   .retClear
.chkInput:
	; Check for the DOWN input
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ld   a, [hl]
	bit  KEYB_DOWN, a
	jp   nz, .retSet
.retClear:
	scf  
	ccf  	; C flag cleared
	ret  
.retSet:
	scf  	; C flag set
	ret  

; =============== Play_Pl_ChkKickAHB ===============
; Checks the input for performing a backwards heavy air kick.
; Performed by holding BACKWARD while performing one, but only Iori has one.
;
; See also: Play_Pl_ChkPunchAHD
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, the input is performed
Play_Pl_ChkKickAHB:
	; Only if playing as Iori
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_IORI
	jp   z, .chkInput
	jp   .ne
.chkInput:
	;--
	; Check if holding backwards.
	; This is the same code inside Play_Pl_IsFwdHeld, except the other way around.

	; Which direction we're holding?
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc				
	ld   a, [hl]
	bit  KEYB_LEFT, a		; Holding left?
	jp   nz, .chkL			; If so, jump
	bit  KEYB_RIGHT, a		; Holding right?
	jp   nz, .chkR			; If so, jump
	
	; Can't be holding backwards if we aren't holding anything.
	jp   .ne
.chkL:
	; Holding backwards only if facing right (SPRB_XFLIP set)
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Player facing right?
	jp   nz, .eq			; If so, jump
	jp   .ne
.chkR:
	; Holding backwards only if facing left (SPRB_XFLIP clear)
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Player facing left?
	jp   z, .eq				; If so, jump
.ne:
	scf
	ccf  			; Clear C flag
	ret  
.eq:
	scf  			; Set C flag
	ret 

; =============== MOVE INPUTS ===============
; Remember that these inputs are relative to the 2P side!
; These inputs are frustratingly strict compared to 96 and later
; games -- the fault lies into extremely greedy "Include" values
; that will make inputs not count

; Down  -> D
; Up    -> U
; Left  -> F(front)
; Right -> B(ack)
; A     -> K(ick)
; B     -> P(unch)
; None  -> N
;

; Declares a fixable include key
MACRO gi
	IF GOOD_INPUTS == 1
		db \1
	ELSE
		db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN
	ENDC
ENDM

MoveInput_DF:
	db $02                                   ; Number of inputs
.i2:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BD:
	db $02                                   ; Number of inputs
.i2:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DFBF:
	db $04                                   ; Number of inputs
.i4:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DB:
	db $02                                   ; Number of inputs
.i2:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DU_Charge:
	db $02                                   ; Number of inputs
.i2:
	db KEY_UP                                ; Key
	db KEY_UP                                ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $1E                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DU:
	db $02                                   ; Number of inputs
.i2:
	db KEY_UP                                ; Key
	db KEY_UP                                ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len
	
MoveInput_DBDF:
	db $04                                   ; Number of inputs
.i4:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DFDF:
	db $04                                   ; Number of inputs
.i4:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BF:
	db $02                                   ; Number of inputs
.i2:                                         
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:                                         
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len
				                             
MoveInput_BF_Charge:                                     
	db $02                                   ; Number of inputs
.i2:                                         
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i1:                                         
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $1E                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BDF:
	db $03                                   ; Number of inputs
.i3:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FDB:
	db $03                                   ; Number of inputs
.i3:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_PPP:
	db $06                                   ; Number of inputs
.i6:
	db KEY_B                                 ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i5:
	db KEY_NONE                              ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i4:
	db KEY_B                                 ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i3:
	db KEY_NONE                              ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i2:
	db KEY_B                                 ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i1:
	db KEY_NONE                              ; Key
	db KEY_B                                 ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len

MoveInput_FBDF:
	db $04                                   ; Number of inputs
.i4:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FBF:
	db $03                                   ; Number of inputs
.i3:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FDBFDB:
	db $06                                   ; Number of inputs
.i6:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i5:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i4:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i3:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_DFDB:
	db $04                                   ; Number of inputs
.i4:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FBFDB:
	db $05                                   ; Number of inputs
.i5:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i4:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i3:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BDFB:
	db $04                                   ; Number of inputs
.i4:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BFDB:
	db $04                                   ; Number of inputs
.i4:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i3:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i2:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BDU_Charge:
	db $03                                   ; Number of inputs
.i3:
	db KEY_UP                                ; Key
	db KEY_UP                                ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	db KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $1E                                   ; Min len
	db $FF                                   ; Max len

MoveInput_1BF_Charge:
	db $03                                   ; Number of inputs
.i3:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT|KEY_DOWN                    ; Key
	gi KEY_RIGHT|KEY_DOWN                    ; Include
	db $1E                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FDF:
	db $03                                   ; Number of inputs
.i3:
	db KEY_LEFT                              ; Key
	db KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_LEFT                              ; Key
	gi KEY_LEFT                              ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BDB:
	db $03                                   ; Number of inputs
.i3:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $14                                   ; Max len
.i2:
	db KEY_DOWN                              ; Key
	gi KEY_DOWN                              ; Include
	db $01                                   ; Min len
	db $0A                                   ; Max len
.i1:
	db KEY_RIGHT                             ; Key
	gi KEY_RIGHT                             ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_BB:
	db $04                                   ; Number of inputs
.i4:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i3:
	db KEY_NONE                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i2:
	db KEY_RIGHT                             ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i1:
	db KEY_NONE                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

MoveInput_FF:
	db $04                                   ; Number of inputs
.i4:
	db KEY_LEFT                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i3:
	db KEY_NONE                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i2:
	db KEY_LEFT                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $08                                   ; Max len
.i1:
	db KEY_NONE                              ; Key
	db KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN    ; Include
	db $01                                   ; Min len
	db $FF                                   ; Max len

; =============== Pl_InitBeforeStageLoad ===============
; Initializes parts of the player struct (before the first round starts) outside gameplay for both players.
Pl_InitBeforeStageLoad:
	; Initialize the round number to -1.
	; At the start of a round, it always gets increased by 1.
	ld   a, -$01
	ld   [wRoundNum], a
	
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_TeamLossCount], a
	ld   [wPlInfo_Pl2+iPlInfo_TeamLossCount], a
	ld   [wPlInfo_Pl1+iPlInfo_SingleWinCount], a
	ld   [wPlInfo_Pl2+iPlInfo_SingleWinCount], a
	
	; Set initial health values.
	ld   a, PLAY_HEALTH_MAX
	ld   [wPlInfo_Pl1+iPlInfo_Health], a
	ld   [wPlInfo_Pl2+iPlInfo_Health], a
	ret
	
; =============== Module_Play ===============
; Initializes the module where actual gameplay takes place.
Module_Play:
	ld   sp, $DD00
	di
	; Load the bank with various init data
	ld   a, $01
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	;-----------------------------------
	rst  $10				; Stop LCD
		
	; Lock controls & timer since the intro plays first
	ld   hl, wMisc_C027
	set  MISCB_PLAY_STOP, [hl]
	
	; Prevent players from moving off-screen
	inc  hl ; Seek to wMisc_C028
	set  MISCB_PL_RANGE_CHECK, [hl]
	
	; Reset DMG pal
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Clear out any leftover in the tilemap.
	; This is being done at the start of every round, meaning the game wastes time by reloading the tilemaps.
	; 96 would improve this by only loading the data at the start of the first round.
	call ClearBGMap
	call ClearWINDOWMap
	
	; Start the round at the center of the playfield.
	; At the start of a round, it should be possible to scroll the screen to either direction.
	ld   a, (TILEMAP_H - SCREEN_H) / 2	; $30
	ldh  [hScrollX], a
	ld   [wOBJScrollX], a
	xor  a
	ldh  [hScrollY], a
	ld   a, $40
	ld   [wOBJScrollY], a
	
	; Completely clear both GFX buffers
	ld   hl, wGFXBufInfo_Pl1	; HL = Starting point
	ld   b, $40					; B = Bytes to clear
	xor  a						; A = Clear with
.bufClrLoop:
	ldi  [hl], a
	dec  b
	jp   nz, .bufClrLoop
	
	call ClearOBJInfo
	call Play_LoadPreRoundTextAndIncRound
	call Play_DrawHUDBaseAndInitTimer
	call Play_InitRound
	call Play_DrawHUDEmptyBars
	call Play_HUD_DrawCharNames
	call Play_DrawCharIcons
	call Play_LoadStage
	
	; Display the WINDOW at the top, as that's where the status bar is.
	xor  a
	ldh  [rWY], a
	ld   a, $07
	ldh  [rWX], a
	
	; Initialize serial connection
	call Serial_DoHandshake
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18
	
	; Enable VBLANK & LYC interrupts
	ldh  a, [rSTAT]		; Enable scanline triggers
	or   a, STAT_LYC
	ldh  [rSTAT], a
	; [POI] Leftover value fron KOF95, which used a smaller HUD at the top. 
	;       This doesn't have any real effect as the screen is still black,
	;       and by the next frame it will get reset to what was previously set in SetSectLYC.
	ld   a, $16			
	ldh  [rLYC], a	
	ldh  a, [rIE]
	or   a, I_VBLANK|I_STAT
	ldh  [rIE], a
	
	; Create two separate tasks for handling the two players
	ld   a, $02
	ld   bc, Play_DoPl_1P
	call Task_CreateAt
	
	ld   a, $03
	ld   bc, Play_DoPl_2P
	call Task_CreateAt
	
	; Set intro move for characters that don't start in their idle anim
	call Play_Char_SetIntroAnimInstant
	ei
	
	; Pass control to initialize the other tasks
	call Task_PassControlFar
	call Task_PassControlFar
	
	;
	; In single mode, the bosses and extra stages play a sound effect
	; on the SGB side when a round starts.
	;
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; Is this the Saisyu boss stage?
	jp   z, .sndSaisyu		; If so, jump
	cp   STAGESEQ_RUGAL		; Rugal boss stage?
	jp   z, .sndRugal		; If so, jump
	cp   STAGESEQ_NAKORURU	; Nakoruru extra stage?
	jp   z, .sndNakoruru	; If so, jump
	jp   .noSnd				; Otherwise, it's a normal round

.sndSaisyu:
	ld   hl, (SGB_SND_B_JET << 8)|$00
	jr   .playSnd
.sndRugal:
	ld   hl, (SGB_SND_B_JET << 8)|$01
	jr   .playSnd
.sndNakoruru:
	ld   hl, (SGB_SND_B_UFO << 8)|$00
	jr   .playSnd
.playSnd:
	call SGB_PrepareSoundPacketB
.noSnd:

	;
	; Wait $0A frames for the player graphics to load while the DMG palette is black
	;
	; The reason this is done like this is because the player graphics are copied at VBlank,
	; meaning the screen has to be enabled for them to be copied.
	;
	; fun fact: the GBC bootlegs neglect to set a completely black GBC palette before this point
	; so the aforemented glitched graphics do show up there in GBC mode.
	;
	ld   b, $0A
.waitLoad:
	call Task_PassControlFar
	dec  b
	jp   nz, .waitLoad
	
	; Show the screen by setting the real DMG palettes
	ld   a, $8C				; 1P palette
	ldh  [rOBP0], a
	ld   a, $4C				; 2P palette
	ldh  [rOBP1], a
	ld   a, $1B				; BG palette
	ldh  [rBGP], a
	
	; Set intro move for characters that start in their idle anim.
	call Play_Char_SetIntroAnimDelayed
	; Execute the main intro part
	call Play_DoPreRoundText
	; Load projectile graphics over
	call Play_LoadProjectileOBJInfo
	
	; Start the main gameplay loop
	ld   a, BANK(Play_Main) ; BANK $01
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	jp   Play_Main

; =============== Play_InitRound ===============
; Initializes the round variables, including both players.
Play_InitRound:

	; Load character-specific settings
	ld   bc, wPlInfo_Pl1
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call Play_LoadChar
	ld   bc, wPlInfo_Pl2
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call Play_LoadChar
	
	; Initialize other fields
	xor  a
	ld   [wPlayHitstop], a
	ld   [wPlayPlThrowActId], a
	ld   [wPlaySlowdownTimer], a
	ld   [wPlaySlowdownSpeed], a
	ld   [wScreenShakeY], a
	
	; Set player numbers, mostly used so projectiles know from which players they come from
	xor  a ; PL1
	ld   [wPlInfo_Pl1+iPlInfo_PlId], a
	ld   a, PL2
	ld   [wPlInfo_Pl2+iPlInfo_PlId], a
	
	; Remove every status flag except for the CPU marker
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	and  a, PF0_CPU
	ld   [wPlInfo_Pl1+iPlInfo_Flags0], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	and  a, PF0_CPU
	ld   [wPlInfo_Pl2+iPlInfo_Flags0], a
	
	; Initialize other player fields
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_Flags1], a
	ld   [wPlInfo_Pl1+iPlInfo_Flags2], a
	ld   [wPlInfo_Pl2+iPlInfo_Flags1], a
	ld   [wPlInfo_Pl2+iPlInfo_Flags2], a
	ld   [wPlInfo_Pl1+iPlInfo_MoveId], a
	ld   [wPlInfo_Pl2+iPlInfo_MoveId], a
	ld   [wPlInfo_Pl1+iPlInfo_IntroMoveId], a
	ld   [wPlInfo_Pl2+iPlInfo_IntroMoveId], a
	ld   [wPlInfo_Pl1+iPlInfo_ColiFlags], a
	ld   [wPlInfo_Pl2+iPlInfo_ColiFlags], a
	ld   [wPlInfo_Pl1+iPlInfo_ColiBoxOverlapX], a
	ld   [wPlInfo_Pl2+iPlInfo_ColiBoxOverlapX], a
	ld   [wPlInfo_Pl1+iPlInfo_DizzyHitCount], a
	ld   [wPlInfo_Pl2+iPlInfo_DizzyHitCount], a
	ld   [wPlInfo_Pl1+iPlInfo_DizzyTimeLeft], a
	ld   [wPlInfo_Pl2+iPlInfo_DizzyTimeLeft], a
	ld   a, $FF
	ld   [wPlInfo_Pl1+iPlInfo_PlDistance], a
	ld   [wPlInfo_Pl2+iPlInfo_PlDistance], a
	
	;--
	; Initialize dizzy counter.
	; By default, characters need to receive 12 hits in quick succession to get dizzy.
	ld   a, $0C
	ld   [wPlInfo_Pl1+iPlInfo_DizzyHitTarget], a
	ld   [wPlInfo_Pl2+iPlInfo_DizzyHitTarget], a
	;--
	
	; Give visibility to the other player's character id
	ld   a, [wPlInfo_Pl1+iPlInfo_CharId]
	ld   [wPlInfo_Pl2+iPlInfo_CharIdOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_CharId]
	ld   [wPlInfo_Pl1+iPlInfo_CharIdOther], a
	
	;##
	
	;
	; Determine two things here:
	; - How much health to assign to players
	; - If this is the final round
	;
	; Both have different rules depending on which mode we're in (single or team).
	;
	call IsInTeamMode			; Are we in team mode?
	jp   nc, .chkHealthSingle	; If not, jump
	
	;--
.chkHealthTeam:
	;
	; TEAM MODE - HEALTH SETUP
	;
	; At the end of a round, the winner got some health back.
	; Here, at the start of the round, the loser gets his health completely refilled.
	;
	; Note that, before the first round starts, the initial health values are set in Pl_InitBeforeStageLoad.
	; That's needed as wLastWinner doesn't get reset between stages.
	;
	
	; If 1P didn't win last round
	ld   a, [wLastWinner]
	bit  PLB1, a				; Did 1P win the last round?
	jp   nz, .chkLastWin2P		; If so, skip
	ld   a, PLAY_HEALTH_MAX		; Otherwise, reset 1P health
	ld   [wPlInfo_Pl1+iPlInfo_Health], a
.chkLastWin2P:
	ld   a, [wLastWinner]
	bit  PLB2, a				; Did 2P win the last round?
	jp   nz, .chkFinalTeam		; If so, skip
	ld   a, PLAY_HEALTH_MAX		; Otherwise, reset 2P health
	ld   [wPlInfo_Pl2+iPlInfo_Health], a
.chkFinalTeam:
	
	;
	; TEAM MODE - FINAL ROUND CHECK
	;
	; If any team has 3 characters defeated, this is the final round.
	;
	
	; Note that it's not necessary to check both -- if the first team 
	; doesn't have 3 losses, the second one doesn't either.
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamLossCount]
	cp   $03					; Is 1P's team defeated?
	jp   z, .setFinalRoundTeam		; If so, jump
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamLossCount]
	cp   $03					; Is 2P's team defeated?
	jp   z, .setFinalRoundTeam		; If so, jump
	jp   .end

.setFinalRoundTeam:
	; Set low health meter for both players.
	; Not needed, could have jumped to .setFinalRound (what 96 did)
	ld   a, $17
	ld   [wPlInfo_Pl1+iPlInfo_Health], a
	ld   [wPlInfo_Pl2+iPlInfo_Health], a
	jp   .end

.chkHealthSingle:

	;
	; SINGLE MODE
	;
	; Rounds are isolated in single mode, so a FINAL!! round check is all that's needed.
	;
	; In Single mode, the final round is the 4th one.
	;
	ld   a, [wRoundNum]
	cp   $03				; wRoundNum == $03? (4th)
	jp   nz, .setNormRound	; If not, jump
.setFinalRound:
	; Set low health meter for both players
	ld   a, $17
	ld   [wPlInfo_Pl1+iPlInfo_Health], a
	ld   [wPlInfo_Pl2+iPlInfo_Health], a
	jp   .end

.setNormRound:
	; Set max health for both players
	ld   a, PLAY_HEALTH_MAX
	ld   [wPlInfo_Pl1+iPlInfo_Health], a
	ld   [wPlInfo_Pl2+iPlInfo_Health], a
.end:
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_HealthVisual], a
	ld   [wPlInfo_Pl2+iPlInfo_HealthVisual], a
	ld   [wPlInfo_Pl1+iPlInfo_Pow], a
	ld   [wPlInfo_Pl2+iPlInfo_Pow], a
	ld   [wPlInfo_Pl1+iPlInfo_PowVisual], a
	ld   [wPlInfo_Pl2+iPlInfo_PowVisual], a
	ld   [wPlInfo_Pl1+iPlInfo_MaxPow], a
	ld   [wPlInfo_Pl2+iPlInfo_MaxPow], a
	
	;--
	; [POI] If the powerup cheat is enabled, both players are perpetually at Max Meter.
	; Gone in 96, since there the meter starts empty and grows on its own.
	ld   a, [wDipSwitch]
	bit  DIPB_POWERUP, a				; In Powerup mode?
	jp   z, .loadPlOBJ					; If not, skip
	ld   a, PLAY_POW_MAX				; Set MAX Pow mode
	ld   [wPlInfo_Pl1+iPlInfo_Pow], a
	ld   [wPlInfo_Pl2+iPlInfo_Pow], a
	ld   a, PLAY_POW_MAXPOW_INF			; Make it last forever
	ld   [wPlInfo_Pl1+iPlInfo_MaxPow], a
	ld   [wPlInfo_Pl2+iPlInfo_MaxPow], a
	;--
	
.loadPlOBJ:
	; Load default player sprite mappings.
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	ld   de, OBJInfoInit_Pl1
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_Pl2+iOBJInfo_Status
	ld   de, OBJInfoInit_Pl2
	call OBJLstS_InitFrom
	ret

; =============== Play_LoadChar ===============
; Loads the settings for the current character in the specfied player struct.
; IN
; - BC: Ptr to wPlInfo struct
Play_LoadChar:

	;
	; In team mode, update the current character ID based on how many team members lost already.
	; CharId = iPlInfo_TeamCharId0 + LossCount
	;
	; This isn't needed in single mode since the character ID already contains a copy of iPlInfo_TeamCharId0 there.
	;
	call IsInTeamMode		; In Team mode?
	jp   nc, .loadCharInfo	; If not, skip

	; A = Loss Count
	ld   hl, iPlInfo_TeamLossCount
	add  hl, bc						; Seek to loss count
	ld   a, [hl]
	
	; In case this is the final round, use the 3rd character
	cp   $03						; Did all three characters lose? (final round only)
	jp   nz, .seekToActive			; If not, skip
	ld   a, $02						; Otherwise, use third member
	
.seekToActive:
	; Index the player struct from iPlInfo_TeamCharId0, where the team member IDs are stored in order.
	ld   hl, iPlInfo_TeamCharId0	
	add  hl, bc						; Seek to first member
	; Offset to the active one
	add  a, l						; HL += A
	jp   nc, .noInc					; Just in case (this always jumps)
	inc  h 							; We never get here
.noInc:
	ld   l, a							
	ld   a, [hl]					; A = CharId from team def
.setActiveChar:
	; Set what we read out as current character
	ld   hl, iPlInfo_CharId
	add  hl, bc				; Seek to char ID
	ld   [hl], a			
	
.loadCharInfo:

	;
	; Load the character-specific settings into the player struct.
	;
	; These settings are stored into a table with $10 byte entries, ordered by character ID.
	; As CharId is already multiplied by 2, multiply the value by $08 to generate the table offset.
	;
	
	; HL = CharId * $08
	ld   hl, iPlInfo_CharId
	add  hl, bc			; Seek to CharId * 2
	ld   l, [hl]		; HL = CharId
	ld   h, $00
REPT 3
	sla  l				; HL <<= 3
	rl   h
ENDR

	; DE = Ptr to table entry
	ld   de, Play_CharHeaderTbl		; HL = Ptr to start of table
	add  hl, de						; Offset to entry
	push hl							; Move ptr to DE
	pop  de
	
	; Load the settings two bytes at a time.
	ld   hl, iPlInfo_MoveAnimTblPtr_Low	; byte0-1
	call .copyPtr
	ld   hl, iPlInfo_MoveCodePtrTbl_Low	; byte2-3
	call .copyPtr
	ld   hl, iPlInfo_MoveInputCodePtr_Low	; byte4-5
	call .copyPtr
	ld   hl, iPlInfo_MoveInputCodePtr_Bank	; byte6
	call .copyByte
	; [TCRF?] These aren't used for moves, hardcoded speed/gravity values get used instead.
	ld   hl, iPlInfo_SpeedX_Sub		; byte8-9
	call .copyPtr
	ld   hl, iPlInfo_BackSpeedX_Sub	; byteA-B
	call .copyPtr
	ld   hl, iPlInfo_JumpSpeed_Sub	; byteC-D
	call .copyPtr
	ld   hl, iPlInfo_Gravity_Sub	; byteE-F
	call .copyPtr
	ret

; =============== .copyPtr ===============
; Copies a word value from the header to the player struct.
;
; Note that words are stored in the player struct in *big-endian* format,
; while in the header they are stored as standard little-endian.
;
; For this reason, the player struct pointer initially points to the low byte,
; and then is decremented to point to the high byte.
;
; IN
; - DE: Ptr to table entry byte
; - BC: Ptr to low byte of wPlInfo field
; - HL: iPlInfo field
.copyPtr:
	add  hl, bc		; Seek to the specified field
	
	ld   a, [de]	; A = Low byte of ptr
	inc  de			; TablePtr++
	ldd  [hl], a	; Write it to player struct byte1; PlInfoPtr--
	
	ld   a, [de]	; A = High byte of ptr
	inc  de			; TablePtr++
	ld   [hl], a	; Write it to player struct byte0
	ret
	
; =============== .copyByte ===============
; Copies a byte from the header to the player struct.
; For alignment purposes (to avoid having to use a separate ptr table), the header pads
; out 1-byte entries to two bytes, so the second byte gets skipped over before returning.
; IN
; - DE: Ptr to table entry byte
; - BC: Ptr to base wPlInfo struct
; - HL: iPlInfo field
.copyByte:
	add  hl, bc		; Seek to the specified field
	ld   a, [de]	; Read byte from table
	inc  de			; TablePtr++
	ld   [hl], a	; Write it to player struct
	inc  de			; TablePtr++ (skip padding)
	ret

; =============== Play_CharHeaderTbl ===============
; Parent table with character-specific settings.
Play_CharHeaderTbl:
	; CHAR_ID_KYO
	dw MoveAnimTbl_Kyo ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Kyo ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Kyo ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_BENIMARU
	dw MoveAnimTbl_Benimaru ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Benimaru ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Benimaru ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_RYO
	dw MoveAnimTbl_Ryo ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Ryo ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Ryo ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_YURI
	dw MoveAnimTbl_Yuri ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Yuri ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Yuri ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_TERRY
	dw MoveAnimTbl_Terry ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Terry ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Terry ; iPlInfo_MoveInputCodePtr | BANK $03
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_JOE
	dw MoveAnimTbl_Joe ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Joe ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Joe ; iPlInfo_MoveInputCodePtr | BANK $05
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_HEIDERN
	dw MoveAnimTbl_Heidern ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Heidern ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Heidern ; iPlInfo_MoveInputCodePtr | BANK $18
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_RALF
	dw MoveAnimTbl_Ralf ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Ralf ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Ralf ; iPlInfo_MoveInputCodePtr | BANK $19
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_ATHENA
	dw MoveAnimTbl_Athena ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Athena ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Athena ; iPlInfo_MoveInputCodePtr | BANK $18
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_KENSOU
	dw MoveAnimTbl_Kensou ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Kensou ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Kensou ; iPlInfo_MoveInputCodePtr | BANK $18
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_KIM
	dw MoveAnimTbl_Kim ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Kim ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Kim ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_MAI
	dw MoveAnimTbl_Mai ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Mai ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Mai ; iPlInfo_MoveInputCodePtr | BANK $18
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_IORI
	dw MoveAnimTbl_Iori ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Iori ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Iori ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_EIJI
	dw MoveAnimTbl_Eiji ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Eiji ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Eiji ; iPlInfo_MoveInputCodePtr | BANK $1E
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_BILLY
	dw MoveAnimTbl_Billy ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Billy ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Billy ; iPlInfo_MoveInputCodePtr | BANK $08
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_SAISYU
	dw MoveAnimTbl_Saisyu ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Saisyu ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Saisyu ; iPlInfo_MoveInputCodePtr | BANK $02
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_RUGAL
	dw MoveAnimTbl_Rugal ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Rugal ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Rugal ; iPlInfo_MoveInputCodePtr | BANK $18
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

	; CHAR_ID_NAKORURU
	dw MoveAnimTbl_Nakoruru ; iPlInfo_MoveAnimTblPtr
	dw MoveCodePtrTbl_Nakoruru ; iPlInfo_MoveCodePtrTable
	dpr MoveInputReader_Nakoruru ; iPlInfo_MoveInputCodePtr | BANK $16
	db $00 ; Padding
	dw +$0180 ; iPlInfo_SpeedX
	dw -$0100 ; iPlInfo_BackSpeedX
	dw -$0700 ; iPlInfo_JumpSpeed
	dw +$0060 ; iPlInfo_Gravity

; =============== Play_LoadProjectileOBJInfo ===============
; Loads the OBJInfo for the projectile (including graphics).
; This expects an uncompressed copy of GFXLZ_Projectiles to be in the LZSS buffer,
; as the graphics are copied from there.
Play_LoadProjectileOBJInfo:
	call Task_PassControlFar
	
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(OBJInfoInit_Projectile) ; BANK $01
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		
		;
		; The sprite mappings for these don't use dynamic buffered graphics.
		; Instead, they are all loaded to VRAM at the start of the round, loading
		; over the pre-round text.
		;
		
		; Load 1P projectile graphics for current player to $8800
		ld   a, [wPlInfo_Pl1+iPlInfo_CharId]
		ld   de, $8800 ; Tile $00
		call Play_LoadProjectileGFXFromDef
		
		; Load 1P projectile sprite mapping
		ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Status
		ld   de, OBJInfoInit_Projectile
		call OBJLstS_InitFrom
		; Graphics were copied to $8800, leave default $80 as iOBJInfo_TileIDBase
		call Task_PassControlFar
				
		; Load 2P projectile graphics for current player to $8A40
		ld   a, [wPlInfo_Pl2+iPlInfo_CharId]
		ld   de, $8A40 ; Tile $A4
		call Play_LoadProjectileGFXFromDef
		call Task_PassControlFar
		
		; Load 2P projectile sprite mapping
		ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Status
		ld   de, OBJInfoInit_Projectile
		call OBJLstS_InitFrom
		ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_TileIDBase
		ld   [hl], $A4 ; Graphics were copied to $8A40
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret

; =============== Play_LoadProjectileGFXFromDef ===============
; Copies the projectile graphics from ROM to VRAM.
; IN
; -  A: Character ID
; - DE: Ptr to GFX destination in VRAM
Play_LoadProjectileGFXFromDef:

	;
	; Each character has a set of projectile graphics assigned to it.
	; 
	; The assigmnents are stored into Play_ProjGFXDefPtrTbl, so index that
	; by character ID and read out its pointer to the GFXAutoNum.
	; This points to graphics data with a 1-byte header telling how many
	; tiles must be copied over.
	;

	; Index the ptr table for those GFXAutoNum structures by character id.
	ld   hl, Play_ProjGFXDefPtrTbl
	add  a, l
	jp   nc, .noInc
	inc  h ; We never get here
.noInc:
	ld   l, a
	
	; Read out ptr to the GFXAutoNum structure
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	push bc
	pop  hl
	
	; The first 2 tiles are always empty.
	push hl
		ld   hl, $0000
		ld   b, $02
		call FillGFX
	pop  hl
	
	; Load the graphics over
	call Play_LoadProjectileOBJInfo_CopyGFX
	ret

; =============== Play_LoadProjectileOBJInfo_CopyGFX ===============
; Copies the projectile/sparkle graphics during HBlank 1 tile/frame.
; IN
; - HL: Ptr to a GFXAutoNum structure
; - DE: Ptr to destination in VRAM
Play_LoadProjectileOBJInfo_CopyGFX:
	ld   b, [hl]	; B = Number of tiles
	inc  hl			; Seek to start of GFX data
.loopTiles:
	push bc
		; Copy 1 tile/frame ($10 bytes total)
		ld   b, $04
	.loop:

		; Copy over 4 bytes
	REPT 4
		di
		mWaitForVBlankOrHBlank
		ldi  a, [hl]
		ld   [de], a
		ei
		inc  de
	ENDR
	
		dec  b			; Copied the single tile?
		jp   nz, .loop	; If not, loop
		
		; After copying 1 tile, wait for the next frame
		call Task_PassControlFar
	pop  bc
	dec  b				; Copied all tiles?
	jp   nz, .loopTiles	; If not, loop
	ret

; =============== Play_ProjGFXDefPtrTbl ===============
; Maps characters to their projectile graphics.
; All of these pointers point to BANK $01.
; Because this table can't contain null pointers, characters with
; no projectile/effect graphics just reuse someone else's.
; (ie: Kim using Nakoruru's projectile GFX).
Play_ProjGFXDefPtrTbl:
	dw GFXDef_Proj_KyoIoriSaisyu	; CHAR_ID_KYO     
	dw GFXDef_Proj_Benimaru			; CHAR_ID_BENIMARU
	dw GFXDef_Proj_Ryo				; CHAR_ID_RYO     
	dw GFXDef_Proj_Yuri 			; CHAR_ID_YURI    
	dw GFXDef_Proj_TerryRalf 		; CHAR_ID_TERRY   
	dw GFXDef_Proj_Joe 				; CHAR_ID_JOE     
	dw GFXDef_Proj_Heidern 			; CHAR_ID_HEIDERN 
	dw GFXDef_Proj_TerryRalf 		; CHAR_ID_RALF    
	dw GFXDef_Proj_AthenaKensou 	; CHAR_ID_ATHENA  
	dw GFXDef_Proj_AthenaKensou 	; CHAR_ID_KENSOU  
	dw GFXDef_Proj_KimNakoruru 		; CHAR_ID_KIM     
	dw GFXDef_Proj_Mai 				; CHAR_ID_MAI     
	dw GFXDef_Proj_KyoIoriSaisyu 	; CHAR_ID_IORI    
	dw GFXDef_Proj_Eiji 			; CHAR_ID_EIJI    
	dw GFXDef_Proj_Billy 			; CHAR_ID_BILLY   
	dw GFXDef_Proj_KyoIoriSaisyu	; CHAR_ID_SAISYU  
	dw GFXDef_Proj_Rugal 			; CHAR_ID_RUGAL   
	dw GFXDef_Proj_KimNakoruru 		; CHAR_ID_NAKORURU

; =============== Play_DrawHUDBaseAndInitTimer ===============
; Draws the base tilemap (without health bars) for the HUD in the upper section.
; It also loads the HUD graphics to VRAM.
Play_DrawHUDBaseAndInitTimer:
	; Initialize round timer from settings
	ld   a, [wMatchStartTime]
	ld   [wRoundTime], a
	
	; Load the shared HUD graphics every single time.
	; This is unnecessary (96 only loads them on the first round).
	ld   hl, GFXAuto_Play_HUD
	call CopyTilesAuto
	
	; If the timer is set to infinite, load and draw the infinity symbol.
	ld   a, [wRoundTime]
	cp   TIMER_INFINITE		; Is it infinite?
	jp   nz, .setSubSec		; If not, jump
	
.timerInf:
	; Load the special graphics for this.
	ld   hl, GFXAuto_Play_HUD_TimerInfinite
	call CopyTilesAuto
	
	; Write them over to the hud.
	ld   de, BG_Play_HUD_TimerInfinite
	ld   hl, $9C29
	ld   b, $02		; 2 tiles wide
	ld   c, $01		; 1 tile high
	call CopyBGToRect
	jp   .drawOther

.setSubSec:
	; Since the timer will decrement, initialize the subsecond timer to 60 frames.
	; This makes the timer tick down every second.
	ld   a, 60
	ld   [wRoundTimeSub], a
	call HomeCall_Play_DrawTime
	
	; Also load the number GFX, since they aren't part of the shared HUD graphics in this game.
	ld   hl, GFXAuto_Play_HUD_TimerNum
	call CopyTilesAuto
	
.drawOther:
	;
	; Write the other elements of the HUD, which is in the WINDOW
	;
	
	; "TIME" string
	ld   de, BG_Play_HUD_Time
	ld   hl, $9C09
	ld   b, $02
	ld   c, $01
	call CopyBGToRect
	
	; Large "VS" graphic
	ld   de, BG_Play_HUD_VS
	ld   hl, $9C89
	ld   b, $02
	ld   c, $02
	call CopyBGToRect
	
	; 1P Pow Bar - left border
	ld   de, BG_Play_HUD_HealthBarL
	ld   hl, $9C60
	ld   b, $01
	ld   c, $01
	call CopyBGToRect
	
	; 1P Pow Bar - right border
	ld   de, BG_Play_HUD_HealthBarR
	ld   hl, $9C68
	ld   b, $01
	ld   c, $01
	call CopyBGToRect
	
	; 2P Pow Bar - left border
	ld   de, BG_Play_HUD_HealthBarL
	ld   hl, $9C6B
	ld   b, $01
	ld   c, $01
	call CopyBGToRect
	
	; 2P Pow Bar - right border
	ld   de, BG_Play_HUD_HealthBarR
	ld   hl, $9C73
	ld   b, $01
	ld   c, $01
	call CopyBGToRect
	
	; 1P Marker (tiles)
	ld   de, BG_Play_HUD_1PMarker
	ld   hl, $9CC1
	ld   b, $02
	ld   c, $01
	call CopyBGToRect
	
	; 2P Marker (tiles)
	ld   de, BG_Play_HUD_2PMarker
	ld   hl, $9CD1
	ld   b, $02
	ld   c, $01
	call CopyBGToRect
	
	;
	; Determine the graphics to copy for the player markers.
	; These are copied to the locations BG_Play_HUD_1PMarker and BG_Play_HUD_2PMarker expect them.
	;
.p1Draw:	
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	bit  PF0B_CPU, a		; Is 1P a CPU player?
	jp   nz, .p1CPU			; If so, jump
.p1Pl:
	; Copy 1P marker GFX
	ld   hl, GFXDef_Play_HUD_1PHuman
	ld   de, $8D00
	call CopyTilesAutoNum
	jp   .p2Draw
.p1CPU:
	; Copy 1P CPU marker GFX
	ld   hl, GFXDef_Play_HUD_1PCPU
	ld   de, $8D00
	call CopyTilesAutoNum
	
.p2Draw:
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	bit  PF0B_CPU, a		; Is 2P a CPU player?
	jp   nz, .p2CPU			; If so, jump
.p2Pl
	; Copy 2P marker GFX
	ld   hl, GFXDef_Play_HUD_2PHuman
	ld   de, $8D20
	call CopyTilesAutoNum
	jp   .loadPauseGFX
.p2CPU:
	; Copy 1P CPU marker GFX
	ld   hl, GFXDef_Play_HUD_2PCPU
	ld   de, $8D20
	call CopyTilesAutoNum
	
.loadPauseGFX:
	; The PAUSE graphic isn't part of the shared GFX set, for some reason.
	ld   hl, GFXAuto_Play_HUD_Pause
	call CopyTilesAuto
	ret

; =============== Play_DrawCharIcons ===============
; Draws the character icons in the HUD.
Play_DrawCharIcons:
	;
	; Team mode and single mode handle the character icons and win markers differently.
	;
	call IsInTeamMode				; In team mode?
	jp   c, Play_DrawCharIcons_Team	; If so, jump
	; Fall-through
	
; =============== Play_DrawCharIcons_Single ===============
Play_DrawCharIcons_Single:

	;
	; In single mode, the player portraits are drawn, and to their
	; side there are dots representing won rounds.
	;
	
	; Load GFX for round markers
	ld   hl, GFX_Play_HUD_SingleWinMarker
	ld   de, $9700
	ld   b, $08
	call CopyTiles
	
	;
	; PLAYER 1
	;
.s1P:
	; Draw 1P's character icon
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId0]
	ld   de, $8E90
	ld   hl, $9C82
	ld   c, $E9
	call Char_DrawIconFlipX
	
	;
	; Determine what to draw in the box for the first round.
	;
	; Note that Play_DrawWinBox is used, meaning that, on the final round,
	; none of the win markers show up.
	;
	; Which makes sense, considering who wins the round wins the stage.
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_SingleWinCount]
	cp   $01			; WinCount < $01?
	jp   c, .noS1PWin1	; If so, draw the empty box
.okS1PWin1:
	ld   hl, vBGBoxWin1P0		; Otherwise, draw the filled box
	ld   c, PLAY_TID_BOX_FILL
	call Play_DrawWinBox
	jp   .chkS1PWin2
.noS1PWin1:
	ld   hl, vBGBoxWin1P0
	ld   c, PLAY_TID_BOX_BLANK
	call Play_DrawWinBox
	
	;
	; Determine what to draw in the box for the second round.
	; Same Play_DrawWinBox usage applies.
	; [TCRF] It's impossible to draw a filled second box here, as 2 wins end the round.
	;
.chkS1PWin2:
	ld   a, [wPlInfo_Pl1+iPlInfo_SingleWinCount]
	cp   $02			; WinCount < $02?
	jp   c, .noS1PWin2	; If so, draw the empty box
.unreachable_okS1PWin2:	
	ld   hl, vBGBoxWin1P1		; Otherwise, draw the filled box
	ld   c, PLAY_TID_BOX_FILL
	call Play_DrawWinBox
	jp   .s2P
.noS1PWin2:
	ld   hl, vBGBoxWin1P1
	ld   c, PLAY_TID_BOX_BLANK
	call Play_DrawWinBox
	
	
	;
	; PLAYER 2
	;
.s2P:
	; Identical checks to the player 1 side.
	
	; Draw 2P's character icon
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId0]
	ld   de, $8ED0
	ld   hl, $9C91
	ld   c, $ED
	call Char_DrawIcon
	
	ld   a, [wPlInfo_Pl2+iPlInfo_SingleWinCount]
	cp   $01			; WinCount < $01?
	jp   c, .noS2PWin1	; If so, draw the empty box
.okS2PWin1:
	ld   hl, vBGBoxWin2P0
	ld   c, PLAY_TID_BOX_FILL
	call Play_DrawWinBox
	jp   .chkS2PWin2
.noS2PWin1:
	ld   hl, vBGBoxWin2P0
	ld   c, PLAY_TID_BOX_BLANK
	call Play_DrawWinBox
	
.chkS2PWin2:
	ld   a, [wPlInfo_Pl2+iPlInfo_SingleWinCount]
	cp   $02			; WinCount < $02?
	jp   c, .noS2PWin2	; If so, draw the empty box
	; [TCRF] For the same reason as 1P.
.unreachable_okS2PWin2:
	ld   hl, vBGBoxWin2P1
	ld   c, PLAY_TID_BOX_FILL
	call Play_DrawWinBox
	jp   .s1P_ret
.noS2PWin2:
	ld   hl, vBGBoxWin2P1
	ld   c, PLAY_TID_BOX_BLANK
	call Play_DrawWinBox
.s1P_ret:
	jp   Play_DrawCharIcons_Ret
	
; =============== Play_DrawCharIcons_Team ===============
; Draws the character icons for a team.
; As team members are defeated, their icons get crossed out (but not visually rearranged, unlike 96).
Play_DrawCharIcons_Team:

	;###
	;
	; 1P SIDE
	;
	
	;
	; Draw 1st team member icon.
	;
	; The code to draw the icons is similar between the three, however
	; each one has its own validations.
	;

	; If the character died (iPlInfo_TeamLossCount > 0), draw a cross instead of the icon.
	;--
	; What a weird way to check for it.
	ld   a, $00									; A = 0			
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamLossCount	; HL = Defeated team members
	cp   [hl]									; A < HL?
	jp   c, .t1PLoss0							; If so, jump (draw cross)
	;--
.t1PDraw0:
	; Draw 1st icon normally
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId0]
	ld   de, $8E90
	ld   hl, $9C82
	ld   c, $E9
	call Char_DrawIconFlipX
	jp   .t1PChk1
.t1PLoss0:
	; Draw cross over 1st icon slot
	ld   de, $8E90
	ld   hl, $9C82
	ld   c, $E9
	call Char_DrawCrossFlipX
	
	;
	; Draw 2nd team member icon, immediately to the right of the previous one.
	;
	; This adds extra validation for 1-vs-1 matches.
	;
.t1PChk1:
	;--
	; If the character died (iPlInfo_TeamLossCount > 1), draw a cross instead of the icon.
	ld   a, $01
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamLossCount
	cp   [hl]
	jp   c, .t1PLoss1
	;--
	
	;--
	; Force the boss rounds to not draw the 2nd and 3rd character slots.
	; This is a bit shit, 96 opted for the much better solution of skipping
	; blank character slots, which made it more flexible.
	;
	; There's peculiar logic with the stage check here, since it skips drawing
	; the second icon *only* in Saisyu's boss stage, but not Rugal's.
	; This is done to hide Rugal's icon until fighting him.
	;
	; Meanwhile, Rugal's stage check is done before drawing the 3rd character
	; icon, so it will only draw two icons (cross for Saisyu, then normal for Rugal).
	;
	; Nakoruru's stage check is missing since that gets forcibly treated as a Single Mode battle,
	; so we won't get here anyway.
	;
		
	; Not applicable in VS Mode, since there are no boss rounds there
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS Mode?
	jp   nz, .t1PDraw1		; If so, skip (draw)
	
	; Only if 1P is the CPU opponent
	ld   a, [wJoyActivePl]
	or   a					; Playing as 1P?
	jp   z, .t1PDraw1		; If so, skip (draw)
	
	; Only on the first boss round
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; On Saisyu's stage?
	jp   z, .t2PChk0		; If so, jump to the 2P drawing code (don't draw)
	;--
.t1PDraw1:
	; Draw the icon normally, to the right of the 1st one
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId1]
	ld   de, $9700
	ld   hl, vBGBoxWin1P0
	ld   c, PLAY_TID_BOX_FILL
	call Char_DrawIconFlipX
	jp   .t1PChk2
.t1PLoss1:
	; Draw a cross
	ld   de, $9700
	ld   hl, vBGBoxWin1P0
	ld   c, PLAY_TID_BOX_FILL
	call Char_DrawCrossFlipX
.t1PChk2:

	;
	; Draw 3rd team member icon, immediately to the right of the previous one.
	;
	; This icon is never crossed out, so there's no loss check.
	;
	
	;--
	; Boss round check
	
	; Not applicable in VS Mode, since there are no boss rounds there
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS Mode?
	jp   nz, .t1PDraw2		; If so, skip (draw)
	
	; Only if 1P is the CPU opponent
	ld   a, [wJoyActivePl]
	or   a					; Playing as 1P?
	jp   z, .t1PDraw2		; If so, skip (draw)
	
	; Only on the second boss round
	ld   a, [wCharSeqId]
	cp   STAGESEQ_RUGAL		; On Rugal's stage?
	jp   z, .t2PChk0		; If so, jump to the 2P drawing code (don't draw)
	;--
.t1PDraw2:
	; Draw the icon normally, to the right of the 2nd one
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId2]
	ld   de, $9740
	ld   hl, vBGBoxWin1P1
	ld   c, PLAY_TID_BOX_BLANK
	call Char_DrawIconFlipX
	jp   .t2PChk0
	
	;###
	;
	; 2P SIDE
	;
	; Exactly the same thing as what we did for 1P's side, except icons are drawn
	; right to left.
	;
	
	; 1st member - always draw
.t2PChk0:
	;--
	ld   a, $00
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount
	cp   [hl]				; 1st member defeated?
	jp   c, .t2PLoss0		; If so, jump
	;--
.t2PDraw0:
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId0]
	ld   de, $8ED0
	ld   hl, $9C91
	ld   c, $ED
	call Char_DrawIcon
	jp   .t2PChk1
.t2PLoss0:
	ld   de, $8ED0
	ld   hl, $9C91
	ld   c, $ED
	call Char_DrawCross
	
	; 2nd member - not in Saisyu's stage
.t2PChk1:
	;--
	ld   a, $01
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount
	cp   [hl]				; 2nd member defeated?
	jp   c, .t2PLoss1		; If so, jump
	;--
	; Boss stage check
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS Mode?
	jp   nz, .t2PDraw1		; If so, skip (draw)
	ld   a, [wJoyActivePl]
	or   a					; Playing as 2P?
	jp   nz, .t2PDraw1		; If so, skip (draw)
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; On Saisyu's stage?
	jp   z, Play_DrawCharIcons_Ret	; If so, return (don't draw)
.t2PDraw1:
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId1]
	ld   de, $9780
	ld   hl, $9C8F
	ld   c, $78
	call Char_DrawIcon
	jp   .t2PChk2
.t2PLoss1:
	ld   de, $9780
	ld   hl, $9C8F
	ld   c, $78
	call Char_DrawCross
	
	; 3rd member - not in boss stages
.t2PChk2:
	; Boss stage check
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS Mode?
	jp   nz, .t2PDraw2		; If so, skip (draw)
	ld   a, [wJoyActivePl]
	or   a					; Playing as 2P?
	jp   nz, .t2PDraw2		; If so, skip (draw)
	ld   a, [wCharSeqId]
	cp   STAGESEQ_RUGAL		; On Rugal's stage?
	jp   z, Play_DrawCharIcons_Ret	; If so, return (don't draw)
.t2PDraw2:
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId2]
	ld   de, $97C0
	ld   hl, $9C8D
	ld   c, $7C
	call Char_DrawIcon
	jp   Play_DrawCharIcons_Ret

Play_DrawCharIcons_Ret:
	ret
	
; =============== IsInTeamMode ===============
; OUT
; - C flag: If set, Team mode is enabled
IsInTeamMode:
	ld   a, [wPlayMode]
	bit  MODEB_TEAM, a		; Playing in Team mode?
	jp   z, .no				; If not, jump
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   nz, .yes			; If so, jump
	ld   a, [wCharSeqId]
	cp   STAGESEQ_NAKORURU	; Are we on Nakoruru's stage?
	jp   nz, .yes			; If not, jump (her stage is forced into Single mode)
.no:
	scf
	ccf		; C = 0
	ret
.yes:
	scf		; C = 1
	ret
	
; =============== Play_DrawWinBox ===============
; Draws a round/victory marker to the tilemap.
; As the markers are 16x16 dots in this game, four tiles gets written.
; This can only be used in Single mode.
; IN
; - C: Initial Tile ID (top left corner).
;      The Tile IDs of the other corners are assumed to come right after.
; - HL: Destination ptr to the tilemap. Where to draw the top-left corner.    
Play_DrawWinBox:
	; The check this uses is only applicable to Single mode.
	ld   a, [wRoundNum]
	cp   $03				; wRoundNum == 3? (4th round, the "final!!" round in single mode)
	jp   z, .ret			; If so, return
	
	; Otherwise, draw the dot
	;--
	; Top-left corner, Tile ID "C"
	mWaitForVBlankOrHBlank
	ld   a, c				; A = Starting tile ID
	ldi  [hl], a			; Write TileID at the top-left, move right 1 tile
	
	;--
	; Top-right corner, Tile ID "C+1"
	inc  a					; TileId++
	push af
	mWaitForVBlankOrHBlank
	pop  af
	ldd [hl], a				; Write TileID at the top-right, move back left 1 tile
	
	; Bottom-left corner, Tile ID "C+2"
	inc  a					; TileId++
	ld   de, BG_TILECOUNT_H	; Move down 1 tile
	add  hl, de
	push af
	mWaitForVBlankOrHBlank
	pop  af
	ldi  [hl], a			; Write TileID at the bottom-left, move right 1 tile
	
	; Bottom-right corner, Tile ID "C+3"
	inc  a					; TileId++
	push af
	mWaitForVBlankOrHBlank
	pop  af
	ld   [hl], a			; Write TileID at the bottom-right
.ret:
	ret
; =============== Char_DrawIconFlipX ===============
; Draws a 16x16 icon for a character flipped horizontally.
; This is used to draw icons on the P1 side, which face right.
; IN	
; - DE: Ptr to GFX ptr in VRAM
; - HL: Ptr to top-*right* corner of the icon in the tilemap
; - C: Tile number DE points to
; - A: Character ID
Char_DrawIconFlipX:

	push bc
	
		;
		; Generate offset to GFX_Char_Icons.
		; Each "entry" in the table contains 4 tiles ($40 bytes), and the entries
		; are ordered by character ID.
		;
		; Because A is already multiplied by 2 already when calling this function,
		; BC = A * $20
		ld   b, $00
		ld   c, a		; BC = A
REPT 5
		sla  c		 	; << 1  5 times
		rl   b
ENDR
		;--
		; Switch to the bank with icons
		ldh  a, [hROMBank]
		push af
			ld   a, BANK(GFX_Char_Icons) ; BANK $1D
			ld   [MBC1RomBank], a
			ldh  [hROMBank], a
			push hl
				; Offset the GFX table to the location of the needed icon
				ld   hl, GFX_Char_Icons	
				add  hl, bc			; HL = GFX_Char_Icons[BC]
				
				; Copy the next 4 tiles to VRAM flipped horizontally, from *HL to *DE
				ld   b, $04			; B = 4
				call CopyTilesHBlankFlipX	; Copy the tiles over
			pop  hl
		pop  af
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
	pop  bc
	
	;
	; Update the tilemap to point to the newly copied tiles.
	;
	; As a side effect of the icon GFX being horizontally flipped but still keeping
	; their tile order, now tiles are stored *right* to *left*, then top to bottom.
	;
	; To account for it, the tilemap must be updated in that order, using incrementing tile IDs as needed.
	; 
	
	mWaitForVBlankOrHBlank
	ld   a, c						; A = Starting TileID
	ldd  [hl], a					; Write top-right corner, move left 1 tile
	inc  a							; TileId++
	ldi  [hl], a					; Write top-left corner, move right 1 tile
	inc  a							; TileId++
	ld   de, BG_TILECOUNT_H			; Move down 1 tile
	add  hl, de
	push af
	mWaitForVBlankOrHBlank			; Wait
	pop  af
	ldd  [hl], a					; Write bottom-right corner, move left 1 tile
	inc  a							; TileId++
	ld   [hl], a					; Write bottom-left corner
	ret

; =============== Char_DrawIcon ===============
; Draws a 16x16 icon for a character.
; This is used to draw icons on the P2 side, which face left.
; See also: Char_DrawIconFlipX
; IN	
; - DE: Ptr to GFX ptr in VRAM
; - HL: Ptr to top-left corner of the icon in the tilemap
; - C: Tile number DE points to
; - A: Character ID
Char_DrawIcon:
	push bc
	
		; BC = Offset to GFX_Char_Icons.
		ld   b, $00
		ld   c, a		; BC = A
REPT 5
		sla  c		 	; << 1  5 times
		rl   b
ENDR

		; Switch to the bank with icons
		ldh  a, [hROMBank]
		push af
			ld   a, BANK(GFX_Char_Icons) ; BANK $1D
			ld   [MBC1RomBank], a
			ldh  [hROMBank], a
			push hl
				; HL = GFX_Char_Icons[BC]
				ld   hl, GFX_Char_Icons	
				add  hl, bc			
				
				; Copy the next 4 tiles to VRAM from *HL to *DE
				ld   b, $04				; B = Tile count
				call CopyTilesHBlank	
			pop  hl
		pop  af
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
	pop  bc
	
	;
	; Update the tilemap to point to the newly copied tiles, left to right.
	;
	mWaitForVBlankOrHBlank
	ld   a, c						; A = Starting TileID
	ldi  [hl], a					; Write top-left corner, move right 1 tile
	inc  a							; TileId++
	ldd  [hl], a					; Write top-right corner, move left 1 tile
	inc  a							; TileId++
	ld   de, BG_TILECOUNT_H			; Move down 1 tile
	add  hl, de
	push af
	mWaitForVBlankOrHBlank			; Wait
	pop  af
	ldi  [hl], a					; Write bottom-left corner, move right 1 tile
	inc  a							; TileId++
	ld   [hl], a					; Write bottom-right corner
	ret
	
; =============== Char_DrawCrossFlipX ===============
; Draws a 16x16 icon for a cross flipped horizontally.
; This is used to draw a cross on the P1 side, which faces right (but you can't notice it, since it's symmetrical).
; IN	
; - HL: Destination ptr to the tilemap
Char_DrawCrossFlipX:
	push bc
		push hl
			ld   hl, GFX_Char_Cross
			ld   b, $04
			call CopyTilesHBlankFlipX
		pop  hl
	pop  bc
	
	ld   a, c						; A = Starting TileID
	ldd  [hl], a					; Write top-right corner, move left 1 tile
	inc  a							; TileId++
	ldi  [hl], a					; Write top-left corner, move right 1 tile
	inc  a							; TileId++
	ld   de, BG_TILECOUNT_H			; Move down 1 tile
	add  hl, de
	ldd  [hl], a					; Write bottom-right corner, move left 1 tile
	inc  a							; TileId++
	ld   [hl], a					; Write bottom-left corner
	ret
	
; =============== Char_DrawCross ===============
; Draws a 16x16 icon for a cross.
; This is used to draw a cross on the P2 side, which faces left.
; IN	
; - HL: Destination ptr to the tilemap
Char_DrawCross:
	push bc
		push hl
			ld   hl, GFX_Char_Cross
			ld   b, $04
			call CopyTiles
		pop  hl
	pop  bc
	
	ld   a, c						; A = Starting TileID
	ldi  [hl], a					; Write top-left corner, move right 1 tile
	inc  a							; TileId++
	ldd  [hl], a					; Write top-right corner, move left 1 tile
	inc  a							; TileId++
	ld   de, BG_TILECOUNT_H			; Move down 1 tile
	add  hl, de
	ldi  [hl], a					; Write bottom-left corner, move right 1 tile
	inc  a							; TileId++
	ld   [hl], a					; Write bottom-right corner
	ret

; =============== Play_HUD_DrawCharNames ===============
; Draws the character names to the HUD.
;
; The names are 8 characters long at most and use their own font, one tile/letter.
;
; To avoid having to keep the entire font in memory, two 8-tile buffers are allocated
; in VRAM (one for each player), and only the necessary font graphics are copied there.
;
; The font graphics themselves only contain the letters needed to display the character
; names and aren't ordered alphabetically.
;
Play_HUD_DrawCharNames:

	; Clear out both VRAM GFX buffers with black tiles
	ld   hl, $0000 ; Black line
	ld   b, $08
	ld   de, $9600	; 1P buffer
	call FillGFX
	
	ld   hl, $0000 ; Black line
	ld   b, $08
	ld   de, $9680 ; 2P buffer
	call FillGFX
	
	; Copy the needed GFX from ROM into the VRAM buffers.
	ld   a, [wPlInfo_Pl1+iPlInfo_CharId]
	call Play_HUD_Draw1PCharName
	ld   a, [wPlInfo_Pl2+iPlInfo_CharId]
	call Play_HUD_Draw2PCharName
	ret

; =============== Play_HUD_Draw1PCharName ===============
; Draws the character name on the 1P side.
; IN
; - A: Character ID * 2
Play_HUD_Draw1PCharName:

	;
	; HL = Ptr to character name text entry 
	;      (name length + tile IDs relative to GFXLZ_Play_HUD_CharNames).
	;
	
	; Seek to ptr table entry
	ld   b, $00							; BC = CharId * 2
	ld   c, a
	ld   hl, Play_HUD_CharNamesPtrTable ; HL = Ptr table with BGX tilemaps
	add  hl, bc							; Seek to entry
	; Read out the ptr to DE
	ld   e, [hl]	
	inc  hl
	ld   d, [hl]
	; And move it to HL
	push de
	pop  hl
	
	;--
	;
	; The 1P side has the character name aligned to the right.
	;
	; With names being 8 tiles long, this results into a padding at the start of (8 - NameLength) tiles.
	; To account for it, the destination ptr is offset by that amount:
	;   DestPtr = $9600 + (PadCount * TILESIZE)
	;
	; This will leave the skipped tiles black, as the buffer was blanked out before getting here.
	;
	
	ld   b, [hl]		; B = Name length
	inc  hl				; HL = Ptr to "BGX" tilemap
	
	ld   a, $08			; A = Pad tile count (8 - B)
	sub  a, b			
	ld   de, $9600		; DE = Ptr to start of VRAM destination buffer
	
	; Seek the VRAM dest buffer past the padding.
	; DE += A * $10 (TILESIZE)
	push hl		; Save "tilemap" ptr
REPT 4				
		sla  a			; A << 4
ENDR
		ld   h, $00		; HL = A
		ld   l, a
		add  hl, de		; HL += DE
		
		push hl			; Move to DE
		pop  de
	pop  hl		; Restore "tilemap" ptr
	;--
	
	; Copy the GFX to VRAM, according to the "BGX" tilemap HL points to.
	call Play_HUD_CopyCharNameGFX
	
	; Copy the standard tilemap for 1P names
	ld   de, BG_Play_HUD_CharName1P
	ld   hl, $9C00
	ld   b, $08
	ld   c, $01
	call CopyBGToRect
	ret
	
; =============== Play_HUD_Draw2PCharName ===============
; Draws the character name on the 2P side.
; See also: Play_HUD_Draw1PCharName
Play_HUD_Draw2PCharName:

	;
	; HL = Ptr to character name text entry 
	;      (name length + tile IDs relative to GFXLZ_Play_HUD_CharNames).
	;
	
	; Seek to ptr table entry
	ld   b, $00							; BC = CharId * 2
	ld   c, a
	ld   hl, Play_HUD_CharNamesPtrTable ; HL = Ptr table with BGX tilemaps
	add  hl, bc							; Seek to entry
	; Read out the ptr to DE
	ld   e, [hl]	
	inc  hl
	ld   d, [hl]
	; And move it to HL
	push de
	pop  hl
	
	;--
	ldi  a, [hl]		; Read name length; HL = Ptr to "BGX" tilemap
	ld   b, a			; B = Name length
	
	; Copy the GFX to VRAM, according to the "BGX" tilemap HL points to.
	; The 2P side has the character name aligned to the left, so no special handling is needed.
	ld   de, $9680
	call Play_HUD_CopyCharNameGFX
	
	; Copy the standard tilemap for 2P names
	ld   de, BG_Play_HUD_CharName2P
	ld   hl, $9C0C
	ld   b, $08
	ld   c, $01
	call CopyBGToRect
	ret

; =============== Play_HUD_CopyCharNameGFX ===============
; Copies the tile graphics for the character name to VRAM.
;
; IN
; - DE: VRAM GFX destination ptr
; - HL: Ptr to source "tilemap", with tile IDs relative to the start of GFX_Play_HUD_CharNames.
; -  B: Number of tiles to copy
Play_HUD_CopyCharNameGFX:
	; Copy 1 tile at a time
	push bc		; Save length
	
		; A = Tile ID
		ldi  a, [hl]
		; Multiply the tile ID by TILESIZE.
		; BC = A * $10
		ld   b, $00
		ld   c, a
	REPT 4			
		sla  c
		rl   b
	ENDR
	
		push hl
			; Seek to the tile to copy
			ld   hl, GFX_Play_HUD_CharNames
			add  hl, bc
			; And copy it over to VRAM
			ld   b, $01
			call CopyTiles
		pop  hl
	pop  bc		; Restore length
	dec  b								; Copied all tiles?
	jp   nz, Play_HUD_CopyCharNameGFX	; If not, loop
	ret

BG_Play_HUD_CharName1P: INCBIN "data/bg/play_hud_charname1p.bin"
BG_Play_HUD_CharName2P: INCBIN "data/bg/play_hud_charname2p.bin"
Play_HUD_CharNamesPtrTable:
	dw BGXDef_Play_HUD_CharName_Kyo
	dw BGXDef_Play_HUD_CharName_Benimaru
	dw BGXDef_Play_HUD_CharName_Ryo
	dw BGXDef_Play_HUD_CharName_Yuri
	dw BGXDef_Play_HUD_CharName_Terry
	dw BGXDef_Play_HUD_CharName_Joe
	dw BGXDef_Play_HUD_CharName_Heidern
	dw BGXDef_Play_HUD_CharName_Ralf
	dw BGXDef_Play_HUD_CharName_Athena
	dw BGXDef_Play_HUD_CharName_Kensou
	dw BGXDef_Play_HUD_CharName_Kim
	dw BGXDef_Play_HUD_CharName_Mai
	dw BGXDef_Play_HUD_CharName_Iori
	dw BGXDef_Play_HUD_CharName_Eiji
	dw BGXDef_Play_HUD_CharName_Billy
	dw BGXDef_Play_HUD_CharName_Saisyu
	dw BGXDef_Play_HUD_CharName_Rugal
	dw BGXDef_Play_HUD_CharName_Nakoruru

; =============== Play_DrawHUDEmptyBars ===============
; Draws the tilemaps for all empty bars in the HUD.
Play_DrawHUDEmptyBars:
	;
	; Load bar graphics
	;
	ld   hl, GFXAuto_Play_HUD_Bar
	call CopyTilesAuto
	
	;
	; Load the default tilemaps for all bars.
	;
	
	; 1P Health bar
	ld   de, BG_Play_HUD_BlankHealthBar
	ld   hl, $9C20
	ld   b, $09
	ld   c, $01
	call CopyBGToRect
	
	; 2P Health bar
	ld   de, BG_Play_HUD_BlankHealthBar
	ld   hl, $9C2B
	ld   b, $09
	ld   c, $01
	call CopyBGToRect
	
	; 1P Pow bar
	ld   de, BG_Play_HUD_BlankPowBar
	ld   hl, $9C61
	ld   b, $07
	ld   c, $01
	call CopyBGToRect
	
	; 2P Pow bar
	ld   de, BG_Play_HUD_BlankPowBar
	ld   hl, $9C6C
	ld   b, $07
	ld   c, $01
	call CopyBGToRect
	ret

BG_Play_HUD_BlankHealthBar: INCBIN "data/bg/play_hud_blankhealthbar.bin"
BG_Play_HUD_BlankPowBar: INCBIN "data/bg/play_hud_blankpowbar.bin"
; =============== Play_LoadPreRoundTextAndIncRound ===============
; Loads the initial sprite mapping + all graphics for the pre-round text (ie: ROUND 1, FIGHT!).
Play_LoadPreRoundTextAndIncRound:
	; RoundNum++
	ld   a, [wRoundNum]
	inc  a
	ld   [wRoundNum], a
	
	; Load the special font graphics for this text.
	ld   hl, GFXAuto_Play_RoundFont
	call CopyTilesAuto
	
	; Load the sprite mapping
	ld   hl, wOBJInfo_RoundText
	ld   de, OBJInfoInit_Play_RoundText
	call OBJLstS_InitFrom
	ret
	
; =============== Play_DoPreRoundText ===============
; Handles the pre-round text display while the characters continue their intro animations.
; The same wOBJInfo is used with different sprite mappings for the text.
Play_DoPreRoundText:
	; Display the sprite mapping
	ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
	ld   [hl], OST_VISIBLE
	
	;
	; These mappings are displayed in sequence.
	; The game does nothing else other than animate the sprites.
	;
	; Additionally, in this game, the sprite mappings displayed are completely different
	; between Single and Team mode.
	;
	
	
	call IsInTeamMode
	jp   c, .team
	;--
.single:
	; "ROUND *" or "FINAL ROUND".
	; Unlike 96, there are separate sprite mappings for each round.	
	ld   hl, wOBJInfo_RoundText+iOBJInfo_OBJLstPtrTblOffset	; Seek to sprite mapping ID
	ld   a, [wRoundNum]
	and  $03			; Not necessary
	cp   $00			; On the 1st round?
	jp   z, .r1			; If so, jump
	cp   $01			; On the 2nd round?
	jp   z, .r2			; If so, jump
	cp   $02			; On the 3rd round?
	jp   z, .r3			; If so, jump
	cp   $03			; On the final round?
	jp   z, .rFinal		; If so, jump
	; We never get here
.r1:
	ld   a, PLAY_OBJ_ROUNDTEXT_ROUND1	; Use "ROUND 1"
	jp   .singleRest
.r2:
	ld   a, PLAY_OBJ_ROUNDTEXT_ROUND2	; Use "ROUND 2"
	jp   .singleRest
.r3:
	ld   a, PLAY_OBJ_ROUNDTEXT_ROUND3	; Use "ROUND 3"
	jp   .singleRest
.rFinal:
	ld   a, PLAY_OBJ_ROUNDTEXT_FINAL		; Use "FINAL ROUND"
.singleRest:
	ld   [hl], a
	ld   b, 60							; Display for 1 second
	call Play_DoIntro
	
	; "FIGHT!"
	ld   [hl], PLAY_OBJ_ROUNDTEXT_FIGHT
	ld   b, 60
	call Play_DoIntro
	
	jp   .hide
	;--
	
.team:
	ld   hl, wOBJInfo_RoundText+iOBJInfo_OBJLstPtrTblOffset	; Seek to sprite mapping ID
	
	; "READY"
	ld   [hl], PLAY_OBJ_ROUNDTEXT_READY
	ld   b, 60
	call Play_DoIntro
	
	; "GO!"
	ld   [hl], PLAY_OBJ_ROUNDTEXT_GO
	ld   b, 60
	call Play_DoIntro
	;--
	
.hide:
	; Hide the sprite mapping.
	ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
	ld   [hl], $00
	call Task_PassControlFar
	ret

; =============== Play_DoIntro ===============
; Executes the intro code for the specified amount of frames.
; IN
; - B: Number of frames
Play_DoIntro:
	push hl
	.loop:
		push bc
			; Exec shared subs
			call Play_Intro_Shared
			; Wait frame end
			call Task_PassControlFar
		pop  bc
		dec  b
		jp   nz, .loop
	pop  hl
	ret
	
	
; =============== Play_Char_SetIntroAnimInstant ===============
; Sets the intro animation for characters where it should begin immediately.
;
; Other characters (like Kyo), first spend 1 second in the normal idle
; pose before starting the intro animation.
; That is instead handled by Play_Char_SetIntroAnimDelayed (separate since the screen isn't fully setup yet).
Play_Char_SetIntroAnimInstant:
	; Try to set 1P's intro move
	ld   bc, wPlInfo_Pl1	
	call .chk
	; Try to set 2P's intro move
	ld   bc, wPlInfo_Pl2
	call .chk
	ret
; =============== .chk ===============
; IN
; - BC: wPlInfo for currently handled player
.chk:
	;
	; All of these characters start their intro animation immediately.
	; 
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_ATHENA				; Playing as Athena?
	jp   z, Play_Char_SetIntroAnim	; If so, jump
	cp   CHAR_ID_RUGAL				; ...
	jp   z, Play_Char_SetIntroAnim
	; Otherwise, don't set the anim yet.
	ret
	
; =============== Play_Char_SetIntroAnim ===============
; Sets the intro animation for the player passed throguh BC.
; IN
; - BC: wPlInfo for currently handled player
Play_Char_SetIntroAnim:
	ld   hl, iPlInfo_IntroMoveId
	add  hl, bc						; Seek to iPlInfo_IntroMoveId
	ld   [hl], MOVE_SHARED_INTRO	; Write it there
	ret

; =============== Play_Char_SetIntroAnimDelayed ===============
; Sets the intro animation for characters that initially start out in their idle anim.
; See also: Play_Char_SetIntroAnimInstant.
Play_Char_SetIntroAnimDelayed:
	; Wait a second in the idle pose before the intro
	ld   b, 60
	call Play_DoIntro
	
	; Try to set 1P's intro move
	ld   bc, wPlInfo_Pl1	
	call .chk
	; Try to set 2P's intro move
	ld   bc, wPlInfo_Pl2
	call .chk
	ret
; =============== .chk ===============
; IN
; - BC: wPlInfo for currently handled player
.chk:
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]			; A = CharId
	
	; For all of these characters, we have already set the intro move in Play_Char_SetIntroAnimInstant,
	; so leave the move value intact.
	cp   CHAR_ID_ATHENA
	jp   z, .ret
	cp   CHAR_ID_RUGAL
	jp   z, .ret
	
	; Ok, can set the move ID
	jp   Play_Char_SetIntroAnim
	
.ret:
	ret

; =============== Play_Intro_Shared ===============
; Executes the subroutines called by the intro that are part of the main gameplay code.
Play_Intro_Shared:
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(Play_UpdateHealthBars) ; BANK $01 
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		call Play_UpdateHealthBars
		call Play_UpdatePowBars
		call Play_DoTime
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret  
	
; =============== HomeCall_Play_DrawTime ===============
HomeCall_Play_DrawTime:
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(Play_DrawTime) ; BANK $01
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		call Play_DrawTime
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret

OBJInfoInit_Pl1: 
	db OST_VISIBLE ; iOBJInfo_Status
	db SPR_XFLIP ; iOBJInfo_OBJLstFlags
	db SPR_XFLIP ; iOBJInfo_OBJLstFlagsView
	db $60 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db PL_FLOOR_POS ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $00 ; iOBJInfo_TileIDBase
	db LOW($8000) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8000) ; iOBJInfo_VRAMPtr_High
	db BANK(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_BankNum (BANK $09)
	db LOW(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db BANK(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_BankNumView (BANK $09)
	db LOW(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High
OBJInfoInit_Pl2:
	db OST_VISIBLE ; iOBJInfo_Status
	db SPR_OBP1 ; iOBJInfo_OBJLstFlags
	db SPR_OBP1 ; iOBJInfo_OBJLstFlagsView
	db $A0 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db PL_FLOOR_POS ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $40 ; iOBJInfo_TileIDBase
	db LOW($8400) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8400) ; iOBJInfo_VRAMPtr_High
	db BANK(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_BankNum (BANK $08)
	db LOW(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db BANK(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_BankNumView (BANK $08)
	db LOW(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_Terry_WalkF) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl2) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl2) ; iOBJInfo_BufInfoPtr_High


; =============== Play_ExecExOBJCode ===============
; Executes the custom code for the four extra sprite mappings at slots 2-6.
; These are for the two projectiles, Terry's hat and Mamahaha.
Play_ExecExOBJCode:
	; The bank num will jump all over the place when doing this
	ldh  a, [hROMBank]
	push af

		ld   bc, wPlInfo_Pl1							; BC = Ptr to starting player
		ld   de, wOBJInfo_Pl1Projectile+iOBJInfo_Status	; DE = Ptr to respective OBJInfo
		ld   a, $04										; A = Number of loops
	.loop:
		push af
			; If the sprite mapping isn't visible, ignore this
			ld   a, [de]		; Seek to status
			and  a, OST_VISIBLE	; Is the visibility flag set?
			jp   z, .nextObj	; If not, skip
		.ok:
			; Read out the code pointer.
			; All of these expect the code pointer to be at the same location.
			ASSERT(iOBJInfo_Play_CodePtr_Low == iOBJInfo_Play_CodePtr_Low)

			xor  a
			; Read out ptr to HL
			ld   hl, iOBJInfo_Play_CodePtr_Low
			add  hl, de			; Seek to code ptr
			push bc
				ld   c, [hl]	; C = iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   b, [hl]	; B = iOBJInfo_Play_CodePtr_High
				push bc
				pop  hl			; Move to HL
			pop  bc
			; Execute it if isn't null
			or   a, l			; Low byte != 0?
			jp   nz, .exec		; If so, execute it
			or   a, h			; High byte != 0?
			jp   nz, .exec		; If so, execute it
			; Otherwise, it's a null pointer.
			; Ignore it and move on.

		.nextObj:
			; Seek to the next OBJInfo
			; DE += OBJINFO_SIZE
			ld   hl, OBJINFO_SIZE
			add  hl, de
			push hl
			pop  de
			; Seek to the next PlInfo.
			; BC += PLINFO_SIZE
			; Note this makes the wPlInfo ptr go out of range when moving to wOBJInfo_Pl1Bird (into a nonexisting wPlInfo_Pl3 at $DB00).
			; The code that gets executed for the super sparkle offsets it anyway to seek back to the actual wPlInfo
			; associated with the sparkle.
			ld   hl, PLINFO_SIZE
			add  hl, bc
			push hl
			pop  bc

		pop  af			; Restore left count
		dec  a			; Processed all OBJInfo?
		jp   nz, .loop	; If not, loop
.end:
	; Restore bank num
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	ret
	.exec:
		push bc			; Save wPlInfo
			push de		; Save wOBJInfo
				call .farJump
			pop  de
		pop  bc
		jp   .nextObj
; =============== .farJump ===============
; Jumps to the specified code at bank iOBJInfo_Play_CodeBank
; IN
; - HL: Code ptr
; - DE: Ptr to wOBJInfo
.farJump:
	push hl		; Save code ptr
		ld   hl, iOBJInfo_Play_CodeBank
		add  hl, de		; Seek to bank num
		ld   a, [hl]	; Set it as current one
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
	pop  hl		; Restore code ptr
	jp   hl		; Execute it
	ret ; We never get here

; =============== MoveInputS_ChkInputBtnStrict ===============
; Handler for button input reading that provides no leeway.
; (ie: unlike MoveInputS_ChkInputDir, blank inputs in the buffer aren't skipped)
; See also: MoveInputS_ChkInputDir
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; - HL: Ptr to button move input list. (MoveInput_*)
; OUT
; - C flag: If set, the move input was triggered
MoveInputS_ChkInputBtnStrict:
	push bc
		push de
			push hl
				; A = Button Buffer Offset ($00-$0F)
				ld   hl, iPlInfo_JoyBtnBufferOffset
				add  hl, bc
				ld   a, [hl]

				; HL = Ptr to start of Button Buffer
				ld   hl, iPlInfo_JoyBtnBuffer
				add  hl, bc

				; Offset it by OR'ing the low nybble over
				or   a, l
				ld   l, a

				jp   MoveInputS_ChkInputStrict

; =============== MoveInputS_ChkInputDirStrict ===============
; Alternate handler for d-pad input reading that provides no leeway.
; (ie: unlike MoveInputS_ChkInputDir, blank inputs in the buffer aren't skipped)
; See also: MoveInputS_ChkInputDir
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; - HL: Ptr to d-pad move input list. (MoveInput_*)
; OUT
; - C flag: If set, the move input was triggered
MoveInputS_ChkInputDirStrict:
	push bc
		push de
			push hl
				; A = D-Pad Buffer Offset ($00-$0F)
				ld   hl, iPlInfo_JoyDirBufferOffset
				add  hl, bc
				ld   a, [hl]

				; HL = Ptr to start of D-Pad Buffer
				ld   hl, iPlInfo_JoyDirBuffer
				add  hl, bc
				; Offset it by OR'ing the low nybble over
				or   a, l
				ld   l, a
				;--
				; Fall-through

; =============== MoveInputS_ChkInputStrict ===============
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; - HL: Ptr to d-pad move input list. (MoveInput_*)
; OUT
; - C flag: If set, the move input was triggered
MoveInputS_ChkInputStrict:
				; Save result to DE
				push hl
				pop  de
			pop  hl

			;
			; B = Number of separate inputs (iMoveInputItem_*) to check
			;
			ldi  a, [hl]
			ld   b, a		; B = iMoveInput_Length

			; As there's no skipping of blank inputs, the loop is much simpler
			; and doesn't attempt to detect if we ran out of input buffer.
		.chkKeyVal:
			;
			; KEY CHECK
			;
			; The input in the current buffer entry must match the one from the move
			ld   a, [de]	; A = Held d-pad keys (KeyValue)
			ld   c, [hl]	; C = Required d-pad keys (iMoveInputItem_JoyKeys)
			inc  hl
			and  a, [hl]	; A = A & iMoveInputItem_JoyMaskKeys

			; Check for an exact match between filtered input and required keypress
			cp   a, c		; A == C?
			jp   nz, .retNg

		.chkKeyLen:
			;
			; HELD TIMER CHECK
			;
			; The input must be held for a range of frames
			inc  de			; Seek to buffer KeyTimer
			ld   a, [de]	; A = KeyTimer

			; KeyTimer must be >= MinLength
			inc  hl			; Seek to iMoveInputItem_MinLength
			cp   a, [hl]	; KeyTimer < iMoveInputItem_MinLength?
			jp   c, .retNg	; If so, return

			; KeyTimer must be <= MaxLength
			inc  hl			; Seek to iMoveInputItem_MaxLength
			cp   a, [hl]
			jp   z, .chkEnd	; KeyTimer == iMoveInput_MaxKeyLen? If so, continue
			jp   nc, .retNg	; KeyTimer >= iMoveInput_MaxKeyLen? If so, return

		.chkEnd:
			;
			; Check if this is the end of the move input.
			; If it isn't, prepare to check for the next input
			; by seeking to the next iMoveInputItem and to the previous buffer entry.
			;

			; Seek to iMoveInputItem_JoyKeys of the next MoveInputItem
			inc  hl

			; Seek back to the previous buffer entry.
			; As each entry is 2 bytes long, decrement the buffer ptr (DE) by 2 + 1
			; (as we're currently on the second byte of the current entry)
			; and making sure to wrap the offset from $00 to $0E if needed.
			ld   a, e
			dec  a		; DE -= 3
			dec  a
			dec  a
			; Force valid range, wrapping back from $00 to $0E if needed
			and  a, $0F

			; Apply the new offset to DE.
			push af
				; Get rid of low nybble in E
				ld   a, $F0	; E |= $F0
				and  a, e
				ld   e, a
			pop  af
			; And merge the new nybble over.
			or   a, e
			ld   e, a
			;--
			; DE now points at the start of the previous entry

			dec  b				; Did we process all iMoveInputItem?
			jp   nz, .chkKeyVal	; If not, loop

		.retOk:
			scf	; Set carry
		pop  de
	pop  bc
	ret
		.retNg:
			xor  a ; Clear carry
		pop  de
	pop  bc
	ret

; =============== MoveInputS_ChkInputDir ===============
; Checks if the directional keys for a move input were pressed correctly in order.
; Most moves use this subroutine to check for d-pad input.
;
; This boils down to checking a list of inputs in order.
;
; The input lists in ROM are stored in backwards order (from last to first input), which simplifies the handling
; of the joypad buffer -- as we can directly start checking from the latest buffer entry and move down from there.
;
; Each input "item" checks:
; - If the required keys were held
; - How long they were held (must be between the checked range)
;
; Blank inputs in the buffer are skipped if they last less than a certain value.
;
; NOTE: The MoveInput* structs have the keys relative to a player facing left (on the 2P side).
;       On the 1P side, the inputs are flipped as needed before writing them to iPlInfo_JoyDirBuffer.
;
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; - HL: Ptr to d-pad move input list. (MoveInput_*)
; OUT
; - C flag: If set, the move input was triggered
MoveInputS_ChkInputDir:
	push bc
		push de

			;
			; DE = Ptr to current D-Pad buffer offset entry
			;
			push hl
				; A = D-Pad Buffer Offset ($00-$0F)
				ld   hl, iPlInfo_JoyDirBufferOffset
				add  hl, bc
				ld   a, [hl]

				; HL = Ptr to start of D-Pad Buffer
				ld   hl, iPlInfo_JoyDirBuffer
				add  hl, bc
				; Offset it by OR'ing the low nybble over
				or   a, l
				ld   l, a
				; Save result to DE
				push hl
				pop  de
			pop  hl

			;
			; B = Number of separate inputs (iMoveInputItem_*) to check
			;
			ldi  a, [hl]
			ld   b, a

			;
			; Keep a count of the remaining buffer size before we "underflow"
			; from the 8th (earliest) entry to the 1st one (lestest).
			;
			; This value can decrease when checking for moves that require
			; a sequence of inputs (ie: DP motion) or when ignoring a bad input.
			; If this reaches 0 and the move isn't complete, we return immediately
			; and the move won't start.
			;

			; [BUG] This value is intended to decrement twice every time we seek back to the previous iPlInfo_JoyDirBuffer entry.
			;       It should keep a count of the remaining buffer size to avoid looping multiple times.
			;		Problem is, most of the time this is decremented *once*.
			ld   c, $10			; Size of buffer

			;--
			;
			; GET LATEST INPUT
			;
			; This rule (or its minor variation at .tryUseKeyNext) is used to determine the initial buffer entry to use.
			; The latest possible iPlInfo_JoyDirBuffer entry is used, unless no keys were pressed.
			; If no keys were pressed for more than $0E frames, we return immediately, otherwise
			; we use the previous buffer entry.
			;
			; The variation in .tryUseKeyNext, used for inputs checked after this one, instead returns when no keys
			; are pressed for more than $04 frames.
			;
		.tryUseLatestKey:
			; Attempt to use the latest D-Pad entry if present.
			ld   a, [de]		; A = Held d-pad keys
			or   a				; Were any keys held?
			jp   nz, .chkKeyValInitial	; If so, skip

			; If we didn't press any keys on the d-pad for $0F frames or more, return.
			inc  de				; Seek to key length
			ld   a, [de]		; A = Key length
			cp   $0F			; A >= $0F?
			jp   nc, .retNg		; If so, return

			; Otherwise, seek back to the previous buffer entry.
			; As each entry is 2 bytes long, this requires:
			; - Decreasing the bytes left (C) by 2
			; - Decreasing the buffer ptr (DE) by 2 + 1 (as we're currently on the second byte of the current entry)
			;   and making sure to wrap the offset from $00 to $0E if needed.

			; This is the only time C is decremented correctly.
			; Even then, there's one "dec c" at the start and one at the end.

			dec  c				; Decrease buffer size remaining (1/2)
			; Decrease buffer offset by 3
			ld   a, e			; A = Key offset
			dec  a				; -= 1, seek back to first byte of current entry
			dec  a				; -= 2, seek to the start of the previous entry
			dec  a
			; Force valid range, wrapping back from $00 to $0E if needed
			and  a, $0F

			; Apply the new offset to DE, the d-pad buffer ptr.
			; This replaces the low nybble of E with the value currently in A,
			; which works due to the buffer size ($10 bytes) and its alignment.
			push af
				; Get rid of low nybble in E
				ld   a, $F0	; E |= $F0
				and  a, e
				ld   e, a
			pop  af
			; And merge the new nybble over.
			or   a, e
			ld   e, a

			; A = Buffer entry from previous frame
			ld   a, [de]
			dec  c				; Decrease buffer size remaining (2/2)
			;--

		.chkKeyValInitial:

			;
			; KEY CHECK (INITIAL)
			;
			; This initial input check verifies if the input from the buffer matches the last d-pad input for the move,
			; therefore checking the first KEY_* bitmask in the MoveInput_* data.
			;
			; A very similar check is used in .chkKeyValNext for the other inputs.
			;

			push bc
				; C = Required d-pad keys
				ld   c, [hl]	; C = iMoveInputItem_JoyKeys
				inc  hl

				;
				; Filter away inputs excluded from the check.
				; The second byte ("include filter") dictates which inputs from the buffer can be compared
				; with the required keys.
				;
				; [POI] In 96, this is almost always the same as the required keypress,
				;       meaning it's equivalent of doing "and c".
				;       This allows fat-fingering half/quarter-circles, since you don't have to
				;       press the exact key (ie: RIGHT can be successfully input by DOWN+RIGHT).
				;       But it wasn't always the case! In 95, the code for this is identical,
				;       but the filter wouldn't remove all of the extra keypresses.
				;       This meant that, usually, if the game required pressing RIGHT, it wouldn't
				;       accept DOWN+RIGHT, making them trickier to perform.
				;
				and  a, [hl]	; A = A & iMoveInputItem_JoyMaskKeys

				; Check for an exact match between filtered input and required keypress
				cp   a, c		; A == C?
			pop  bc
			jp   z, .chkKeyLen		; If so, jump

			; Unlike .chkKeyValNext, if the last input isn't correct, return immediately.
			jp   .retNg

		.tryUseKeyNext:
			;
			; GET NEXT INPUT
			;
			; See also .tryUseLatestKey

			; Attempt to use the current D-Pad entry if there's something here.
			; (as we've just decremented it)
			ld   a, [de]
			or   a
			jp   nz, .chkKeyValNext

			;--

			; If we didn't press any keys on the d-pad for *$05* frames or more, return.
			inc  de
			ld   a, [de]
			cp   $05
			jp   nc, .retNg

			; If we ran out of buffer, return
			dec  c				; [BUG] Should be "dec c" twice
			jp   z, .retNg

			; Otherwise, seek back to the previous buffer entry.
			; Decrease buffer offset by 3
			ld   a, e
			dec  a
			dec  a
			dec  a
			; Force valid range, wrapping back from $00 to $0E if needed
			and  a, $0F

			; Replace low nybble of DE with it
			push af
				; Get rid of low nybble in E
				ld   a, $F0	; E |= $F0
				and  a, e
				ld   e, a
			pop  af
			or   a, e	; Merge the new nybble over.
			ld   e, a
			;--
			; DE now points at the start of the previous entry

			jp   .tryUseKeyNext

		.chkKeyValNext:
			;
			; KEY CHECK (NEXT)
			;
			; This verifies if the input (KeyValue) from the buffer matches the d-pad input for the move.
			; The difference here compared to .chkKeyValInitial is that, if the input doesn't match,
			; the previous buffer entry is always checked, until the buffer runs out.
			;
			; See also: .chkKeyValInitial

			push bc
				; C = Required d-pad keys
				ld   c, [hl]	; C = iMoveInputItem_JoyKeys
				inc  hl			; Seek to iMoveInputItem_JoyMaskKeys (byte1)

				; Filter away inputs excluded from the check.
				; [POI] Same note applies here.
				and  a, [hl]	; A = A & iMoveInputItem_JoyMaskKeys

				; Check for an exact match between filtered input and required keypress
				cp   a, c		; A == C?
			pop  bc
			jp   z, .chkKeyLen	; If so, jump

			;--
			;
			; Otherwise, decrease the buffer offset by 2, and move back the
			; iMoveInfo offset to the start of the entry.
			; See also: .chkEnd
			;

			dec  hl				; Seek back to iMoveInputItem_JoyKeys (byte0)
			dec  c				; [BUG] Should be "dec c" twice
			jp   z, .retNg

			; Seek to previous input buffer entry.
			; As we're currently on the first byte of the current entry, decrease it by 2.
			ld   a, e
			dec  a
			dec  a
			; Force valid range, wrapping back from $00 to $0E if needed
			and  a, $0F

			; Replace low nybble of DE with it
			push af
				; Get rid of low nybble in E
				ld   a, $F0	; E |= $F0
				and  a, e
				ld   e, a
			pop  af
			or   a, e	; Merge the new nybble over.
			ld   e, a
			;--

			jp   .tryUseKeyNext
		.chkKeyLen:

			;
			; HELD TIMER CHECK
			;
			; Each input in a move can be held for a specific range of frames.
			; If it's outside this range, return.
			;
			; Note that moves tend to have the initial input (meaning the last one we check)
			; with the upper limit set as $FF.
			; This means that, assuming the move starts by pressing RIGHT, we could hold that
			; button for an indefinite amount of time before continuing with the input.
			;
			inc  de			; Seek to buffer KeyTimer
			ld   a, [de]	; A = KeyTimer

			; KeyTimer must be >= MinLength
			inc  hl			; Seek to iMoveInputItem_MinLength
			cp   a, [hl]	; KeyTimer < iMoveInputItem_MinLength?
			jp   c, .retNg	; If so, return

			; KeyTimer must be <= MaxLength
			inc  hl			; Seek to iMoveInputItem_MaxLength
			cp   a, [hl]
			jp   z, .chkEnd	; KeyTimer == iMoveInput_MaxKeyLen? If so, continue
			jp   nc, .retNg	; KeyTimer >= iMoveInput_MaxKeyLen? If so, return

		.chkEnd:

			;
			; Check if this is the end of the input.
			; Like last time, seek from the current entry to the previous one while
			; we're currently on the second byte of the entry (requiring to seek back 3 bytes).
			;
			; For reference, the first time we get here, the current buffer entry may point
			; to the latest one.
			;

			; Seek to iMoveInputItem_JoyKeys of the next MoveInputItem
			inc  hl


			; Seek back to the previous buffer entry, exactly like last time
			dec  c			; [BUG] Should be "dec c" twice
			jp   z, .retNg	; End of buffer? If so, return

			; Seek to previous input buffer entry.
			ld   a, e
			dec  a		; A = E - 3
			dec  a
			dec  a
			; Force valid range, wrapping back from $00 to $0E if needed
			and  a, $0F

			; Replace low nybble of DE with it
			push af
				; Get rid of low nybble in E
				ld   a, $F0	; E |= $F0
				and  a, e
				ld   e, a
			pop  af
			or   a, e	; Merge the new nybble over.
			ld   e, a
			;--
			; DE now points at the start of the previous entry

			dec  b					; Did we process all iMoveInputItem?
			jp   nz, .tryUseKeyNext	; If not, loop
		.retOk:
			scf ; Set carry
		pop  de
	pop  bc
	ret
		.retNg:
			xor  a ; Clear carry
		pop  de
	pop  bc
	ret

; =============== Play_Pl_ClearJoyDirBuffer ===============
; Clears the d-pad input buffer for the specified player.
; Meant to be used after successfully completing a move input.
; IN
; - BC: Ptr to wPlInfo structure
Play_Pl_ClearJoyDirBuffer:
	push bc
		; Fill the $10 bytes of iPlInfo_JoyDirBuffer with $00
		xor  a			; A = Overwrite with
		ld   hl, iPlInfo_JoyDirBuffer
		add  hl, bc		; Seek to d-pad buffer
		ld   b, $10		; B = Bytes to clear
	.loop:
		ldi  [hl], a	; Write
		dec  b			; Finished filling it?
		jp   nz, .loop	; If not, loop
	pop  bc
	ret

; =============== Play_Pl_ClearJoyBtnBuffer ===============
; Clears the button input buffer for the specified player.
; Meant to be used after successfully completing a move input that uses MoveInputS_ChkInputBtnStrict.
; (so, not many)
; IN
; - BC: Ptr to wPlInfo structure
Play_Pl_ClearJoyBtnBuffer:
	push bc
		; Fill the $10 bytes of iPlInfo_JoyBtnBuffer with $00
		xor  a			; A = Overwrite with
		ld   hl, iPlInfo_JoyBtnBuffer
		add  hl, bc		; Seek to d-pad buffer
		ld   b, $10		; B = Bytes to clear
	.loop:
		ldi  [hl], a	; Write
		dec  b			; Finished filling it?
		jp   nz, .loop	; If not, loop
	pop  bc
	ret
; =============== Play_Pl_CreateJoyKeysLH ===============
; Generates the field iPlInfo_JoyKeysLH for the specified player.
;
; This merges the held directional keys from iPlInfo_JoyKeys with the light/heavy flags.
; The value generated is the main one used by the input readers to detect if a punch/kick button
; was pressed, so it should be run before those.
;
; Note that *nothing* is read from the existing iPlInfo_JoyKeysLH value, meaning that by
; default the LH info is only valid for one frame.
; For that purpose, iPlInfo_JoyBufKeysLH is also OR'd over, which is a separate field
; that contains the buffer of previous LH values, but that only gets updated manually
; by calling Play_Pl_AddToJoyBufKeysLH.
;
; IN
; - BC: Ptr to wPlInfo structure
Play_Pl_CreateJoyKeysLH:
	; Seek to iPlInfo_JoyKeys
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	push bc
		; B = Currently held D-Pad keys
		ldi  a, [hl]
		and  a, KEY_RIGHT|KEY_LEFT|KEY_UP|KEY_DOWN
		ld   b, a
		; A = Light/Heavy button info with everything merged.
		;    (iPlInfo_JoyNewKeysLH | iPlInfo_JoyBufKeysLH) & $F0
		;     Note that the LH info doesn't persist by default
		ldi  a, [hl]	; A = iPlInfo_JoyNewKeysLH
		inc  hl			; Seek to iPlInfo_JoyNewKeysLHPreJump
		inc  hl			; Seek to iPlInfo_JoyBufKeysLH
		or   a, [hl]
		and  a, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY ; Filter valid LK bits
		or   b ; Merge both variables
	pop  bc
	; Store the result to iPlInfo_JoyKeysLH
	ld   hl, iPlInfo_JoyKeysLH
	add  hl, bc
	ld   [hl], a
	ret
; =============== Play_Pl_AddToJoyBufKeysLH ===============
; OR's iPlInfo_JoyNewKeysLH to iPlInfo_JoyBufKeysLH, which will
; keep every value until something clears it manually (ie: starting a new move).
;
; This is typically used when checking inputs for submoves.
; Why doesn't this directly write to iPlInfo_JoyKeysLH? Likely to avoid having
; the previously held buttons (from before starting the move) to count.
; Note that iPlInfo_JoyBufKeysLH always gets wiped when starting a new move.
;
; IN
; - BC: Ptr to wPlInfo structure
; OUT
; - C flag: If set, iPlInfo_JoyBufKeysLH was updated
Play_Pl_AddToJoyBufKeysLH:
	; Read flags
	ld   hl, iPlInfo_JoyNewKeysLH
	add  hl, bc		; Seek to iPlInfo_JoyNewKeysLH
	ld   a, [hl]	; A = iPlInfo_JoyNewKeysLH
	; If the updated flags are blank, there's no need to update anything
	and  a, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY ; Filter valid LH bits
	jr   z, .retClear
.update:
	; Otherwise, OR them over
	; iPlInfo_JoyBufKeysLH
	ld   hl, iPlInfo_JoyBufKeysLH
	add  hl, bc
	or   a, [hl]	; A |= iPlInfo_JoyBufKeysLH
	ld   [hl], a	; Save it there
.retSet:
	scf
	ret
.retClear:
	or   a
	ret

; =============== Play_Pl_AreBothBtnHeld ===============
; Checks if we're holding both the punch and kick buttons at the same time.
; IN
; - BC: Ptr to wPlInfo structure
; OUT
; - C flag: If set, we're holding A and B
Play_Pl_AreBothBtnHeld:
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc			; Seek to iPlInfo_JoyKeys
	ld   l, [hl]		; L = Currently held keys
	bit  KEYB_A, l		; Are we holding A?
	jp   z, .retClear	; If not, jump
	; We're holding A
	bit  KEYB_B, l		; Are we also holding B?
	jp   nz, .retSet	; If so, jump (success)
	; If not, return 0
.retClear:
	or   a	; Clear carry
	ret
.retSet:
	scf		; Set carry
	ret

; =============== Play_Pl_IsStrikeInputHeld ===============
; Checks if the player is holding forwards and A+B.
; This is the input for the Strike attack.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - Z flag: If clear, we're doing the Strike attack input  (holding forward and A+B).
; - C flag: If set, we're doing the Dodge input (holding A+B).
;           If it's clear, the Z flag value should be ignored.
Play_Pl_IsStrikeInputHeld:
	call Play_Pl_AreBothBtnHeld				; Holding A+B?
	jp   nc, Play_Pl_IsFwdHeld.unchecked	; If not, return
	; Fall-through
	
; =============== Play_Pl_IsFwdHeld ===============
; Checks if the player is holding forwards.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - Z flag: If clear, we are holding forwards.
; - C flag: Always set (see above).
Play_Pl_IsFwdHeld:
	; Which direction we're holding?
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc				
	ld   a, [hl]
	bit  KEYB_LEFT, a		; Holding left?
	jp   nz, .chkL			; If so, jump
	bit  KEYB_RIGHT, a		; Holding right?
	jp   nz, .chkR			; If so, jump
	
	; Can't be holding forwards if we aren't holding anything.
	jp   .ne
.chkL:
	; Holding forwards only if facing left (SPRB_XFLIP clear)
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Player facing right?
	jp   nz, .ne			; If so, jump
	jp   .eq
.chkR:
	; Holding forwards only if facing right (SPRB_XFLIP set)
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Player facing right?
	jp   nz, .eq			; If so, jump
.ne:
	ld   l, $00		; Set Z flag
	bit  0, l
	scf  			; Set C flag
	ret  
.eq:
	ld   l, $01		; Clear Z flag
	bit  0, l
	scf  			; Set C flag
	ret 
.unchecked:
	ret  			; No C flag set
	
; =============== OBJLST ANIMATION HELPERS ===============

; =============== OBJLstS_IsGFXLoadDone ===============
; Determines if the graphics for the specified wOBJInfo have finished loading.
; IN
; - DE: Ptr to wOBJInfo
; OUT
; - Z flag: If set, the graphics have loaded
OBJLstS_IsGFXLoadDone:
	ld   hl, iOBJInfo_Status
	add  hl, de
	bit  OSTB_GFXLOAD, [hl]	; Is the flag set?
	ret

; =============== OBJLstS_IsInternalFrameAboutToEnd ===============
; Determines if the current sprite mapping ID is about to be updated later on this frame.
;
; The purpose of this is to syncronize certain actions in the move code, like spawning projectiles
; or checking if the move should autorestart, to the animation *internally* switching between
; frames when the move code manually calls OBJLstS_DoAnimTiming_Loop*.
;
; *Internally* emphasized, as the graphics for the new frame of course have to load,
; making the last frame visually linger for a bit.
;
; IN
; - DE: Ptr to wOBJInfo
; OUT
; - HL: Ptr to iOBJInfo_FrameLeft
;       Code actually relies on this.
; - C flag: If set, the animation frame will change by the end of the frame
OBJLstS_IsInternalFrameAboutToEnd:
	; If the GFX aren't fully loaded yet, the animation can't continue
	call OBJLstS_IsGFXLoadDone
	jp   nz, .retClear

	; Otherwise, the frame switches when iOBJInfo_FrameLeft reaches 0.
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]		; A = iOBJInfo_FrameLeft
	or   a				; A != 0?
	jp   nz, .retClear	; If so, jump
.retSet:
	scf		; Set carry (ending)
	ret
.retClear:
	xor  a	; Clear carry (not ending)
	ret
	
; =============== Play_Pl_SetJumpLandAnimFrame ===============
; Sets the animation frame/SFX for landing on the ground.
; This is meant to be used when landing on the ground during an air move.
; IN
; - A: OBJLst Id
; - H: Animation speed (iOBJInfo_FrameTotal)
; - DE: Ptr to wOBJInfo
Play_Pl_SetJumpLandAnimFrame:
	push bc
		ld   b, h		; B = Animation speed

		; Only do this if we're requesting a different animation frame
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de		; Seek to OBJLstId
		cp   a, [hl]	; A == OBJLstId?
		jp   z, .end	; If so, return

		; Otherwise, write the new sprite mapping
		ld   [hl], a

		; Reset the animation speed to the specified value
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de		; Seek iOBJInfo_FrameLeft
		ld   [hl], b	; Frames remaining before change
		inc  hl			; Seek to iOBJInfo_FrameTotal
		ld   [hl], b	; Total count when switching frames
		
		;
		; Play a sound effect whenever we land on the ground.
		; 
		ld   a, SFX_STEP
		call HomeCall_Sound_ReqPlayExId
		; Apply the changes
		call OBJLstS_DoAnimTiming_Initial_by_DE
		
	.end:
	pop  bc
	ret
	
; =============== Play_Pl_SetAnimFrame ===============
; Sets a custom sprite mapping ID for the current animation.
; See also: Play_Pl_SetJumpLandAnimFrame
; IN
; - A: OBJLst Id
; - H: Animation speed (iOBJInfo_FrameTotal)
; - DE: Ptr to wOBJInfo
Play_Pl_SetAnimFrame:
	push bc
		ld   b, h		; B = Animation speed

		; Only do this if we're requesting a different animation frame
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de		; Seek to OBJLstId
		cp   a, [hl]	; A == OBJLstId?
		jp   z, .end	; If so, return

		; Otherwise, write the new sprite mapping
		ld   [hl], a

		; Reset the animation speed to the specified value
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de		; Seek iOBJInfo_FrameLeft
		ld   [hl], b	; Frames remaining before change
		inc  hl			; Seek to iOBJInfo_FrameTotal
		ld   [hl], b	; Total count when switching frames

		; Apply the changes
		call OBJLstS_DoAnimTiming_Initial_by_DE
	.end:
	pop  bc
	ret
	
; =============== OBJLstS_ReqAnimOnGtYSpeed ===============
; Requests a switch to the next animation frame when passing the Y speed threshold.
;
; This also sets a new animation speed (iOBJInfo_FrameTotal), but since this is mostly used
; to have manual control of the animation during jump-like moves, it almost always gets set
; to ANIMSPEED_NONE.
;
; It may also be set to ANIMSPEED_INSTANT or some other value when
; ending manual control of the animation.
;
; For an example, the basic jumps use this subroutine, meaning the animation
; switches to the next sprite mapping (+$04) only when the player reaches a specific Y speed.
; The sprite mapping ID itself determines the "submode"/"act" of the jump, where
; each one is set to have own threshold before switching.
;
; IN
; - A: Y Speed Threshold
; - H: Animation speed to set
; - DE: Ptr to wOBJInfo
; OUT
; - C flag: If set, the request was successful.
;           That means calling the animation routine will switch to the next sprite mapping ID in the animation.
OBJLstS_ReqAnimOnGtYSpeed:
	push bc
		; Save this for later
		ld   b, h		; B = AnimSpeed

		;
		; The current Y Speed must be larger than the threshold.
		;

		; Add $40 to both of them to avoid unintented results with the
		; unsigned comparison on signed values that tend to be close to 0.
		DEF PADVAL = $40
		add  a, PADVAL	; A = YSpeedNew + Pad
		push af
			; C = YSpeedCur + Pad
			ld   hl, iOBJInfo_SpeedY
			add  hl, de
			ld   a, [hl]
			add  a, PADVAL
			ld   c, a
		pop  af

		cp   a, c			; YSpeedCur > YSpeedNew?
		jp   c, .chkChange	; If so, jump
		jp   .retClear		; Otherwise, return

	.chkChange:
		; As a side effect of the move code going off the visible frame, this will get called multiple times
		; even after we successfully request the frame to advance.
		; Avoid accidentally erasing iOBJInfo_FrameLeft on next calls to this while the same frame is visible.
		call OBJLstS_IsGFXLoadDone	; Have the frame graphics loaded?
		jp   nz, .retClear			; If not, return

		; Set iOBJInfo_FrameLeft to 0 to force advance the animation once
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00	; iOBJInfo_FrameLeft = 0
		; Set the new animation speed
		inc  hl
		ld   [hl], b	; iOBJInfo_FrameTotal = B
	.retSet:
		scf		; C flag set
	pop  bc
	ret
	.retClear:
		or   a	; C flag clear
	pop  bc
	ret
	
; =============== Play_Pl_EmptyPowOnSuperEnd ===============
; Called at the end of most moves to empty the POW meter when a super move finishes.
; IN
; - BC: Ptr to wPlInfo structure
Play_Pl_EmptyPowOnSuperEnd:

	; Super move required
	ld   hl, iPlInfo_Flags0
	add  hl, bc					; Seek to iPlInfo_Flags0
	bit  PF0B_SUPERMOVE, [hl]	; Were we just doing a super move?
	jp   z, .ret				; If not, return

	; Powerup mode has an infinite meter
	ld   a, [wDipSwitch]
	bit  DIPB_POWERUP, a		; Powerup cheat active?
	jp   nz, .ret			; If so, return

	; Max meter required
	; It's very possible to have the MAX Power meter run out during
	; the super move, which is why we must check this.
	ld   hl, iPlInfo_Pow
	add  hl, bc					; Seek to iPlInfo_Pow
	ld   a, [hl]
	cp   PLAY_POW_MAX			; Are we at max power?
	jp   nz, .ret				; If not, return

	; All ok, empty the POW meter
	ld   [hl], $00
.ret:
	ret
	
; =============== Play_Pl_EndMove ===============
; Handles what happens when any move with fixed length ends.
; Note this needs to be manually called by the move code.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Play_Pl_EndMove:
	; In case we ended a super move
	call Play_Pl_EmptyPowOnSuperEnd
	xor  a

	; Force align player to floor
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS
	inc  hl
	ldi  [hl], a	; Clear Y subpixels

	; Reset speed
	ldi  [hl], a	; iOBJInfo_SpeedX
	ldi  [hl], a	; iOBJInfo_SpeedXSub
	ldi  [hl], a	; iOBJInfo_SpeedY
	ld   [hl], a	; iOBJInfo_SpeedYSub

	ld   hl, iPlInfo_Flags0
	add  hl, bc
	; Reset everything from the flags except:
	; - PF0B_PROJ: It's independent from the player
	; - PF0B_CPU: Fixed
	; - PF1B_GUARD: Preserve to avoid "holes" in the guard when changing moves.
	; - PF1B_CROUCH: In case we ended crouch-based attacks
	; - PF2B_MOVESTART: It's already reset.
	; - PF2B_HEAVY: Doesn't matter.
	res  PF0B_SPECMOVE, [hl]
	res  PF0B_AIR, [hl] 
	res  PF0B_PROJHIT, [hl]
	res  PF0B_PROJREM, [hl]
	res  PF0B_PROJREFLECT, [hl]
	res  PF0B_SUPERMOVE, [hl]
	inc  hl	; Seek to iPlInfo_Flags1
	res  PF1B_NOBASICINPUT, [hl] ; Since we're resetting to MOVE_SHARED_NONE
	res  PF1B_XFLIPLOCK, [hl]
	res  PF1B_NOSPECSTART, [hl]
	res  PF1B_HITRECV, [hl]
	res  PF1B_ALLOWHITCANCEL, [hl]
	res  PF1B_INVULN, [hl]
	inc  hl	; Seek to iPlInfo_Flags2
	res  PF2B_NODAMAGERATE, [hl]
	res  PF2B_NOHURTBOX, [hl]
	res  PF2B_NOCOLIBOX, [hl]

	; Clear damage flags
	inc  hl	; Seek to iPlInfo_Flags3
	ld   [hl], $00

	; Reset the current move to MOVE_SHARED_NONE.
	; In practice, since PF1B_NOBASICINPUT just got cleared, the basic move handler
	; will replace it with something else (ie: MOVE_SHARED_IDLE).
	; Of course this won't happen at the end of the match, where the player tasks get removed
	; right after this returns.
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   [hl], MOVE_SHARED_NONE
	; In case the intro/outro move ended, reset this too.
	ld   hl, iPlInfo_IntroMoveId
	add  hl, bc
	ld   [hl], MOVE_SHARED_NONE
	ret

; =============== OBJLstS_SyncXFlip ===============
; Syncronizes the sprite's visual X direction with the internal one.
; IN
; - DE: Ptr to wOBJInfo structure
OBJLstS_SyncXFlip:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de					; Seek to flags
	bit  SPRXB_PLDIR_R, [hl]	; Is the sprite mapping internally flipped?
	jp   z, .noFlip				; If not, jump
.flip:
	set  SPRB_XFLIP, [hl]		; Flip the sprite
	jp   .ret
.noFlip:
	res  SPRB_XFLIP, [hl]		; Visually unflip the sprite
.ret:
	ret

; =============== OBJLstS_DoAnimTiming_Loop_by_DE ===============
; Handles the timing for the current animation for the specified OBJInfo.
; Wrapper for OBJLstS_DoAnimTiming_Loop.
; IN
; - DE: Ptr to wOBJInfo struct
OBJLstS_DoAnimTiming_Loop_by_DE:
	push bc
		push de
			push de	; HL = DE
			pop  hl
			call OBJLstS_DoAnimTiming_Loop
		pop  de
	pop  bc
	ret

; =============== OBJLstS_DoAnimTiming_Initial_by_DE ===============
; Initializes the current animation frame.
; Wrapper for OBJLstS_DoAnimTiming_Initial.
; IN
; - DE: Ptr to wOBJInfo struct
OBJLstS_DoAnimTiming_Initial_by_DE:
	push bc
		push de
			push de	; HL = DE
			pop  hl
			call OBJLstS_DoAnimTiming_Initial
		pop  de
	pop  bc
	ret  
; =============== Play_Pl_ExecSpecMoveInputCode ===============
; Executes the character-specific special move input reader code, as defined in iPlInfo_MoveInputCodePtr.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C flag: If set, a move was started
Play_Pl_ExecSpecMoveInputCode:

	ldh  a, [hROMBank]	; Save current bank
	push af
		call .exec		; Run the code. Was a new move started?
		jp   c, .retSet	; If so, jump
.retClear:
	pop  af
	ld   [MBC1RomBank], a	; Restore bank
	ldh  [hROMBank], a
	xor  a	; Clear carry
	ret
.retSet:
	pop  af
	ld   [MBC1RomBank], a	; Restore bank
	ldh  [hROMBank], a
	scf		; Set carry
	ret
.exec:
	; Run the code for it
	ld   hl, iPlInfo_MoveInputCodePtr_High
	add  hl, bc
	push de
		; DE = Code ptr
		ld   d, [hl]	; iPlInfo_MoveInputCodePtr_High
		inc  hl
		ld   e, [hl]	; iPlInfo_MoveInputCodePtr_Low

		; Switch to the bank for it
		inc  hl
		ld   a, [hl]			; iPlInfo_MoveInputCodePtr_Bank
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a

		push de			; Move code ptr to HL
		pop  hl
	pop  de

	;
	; Every input reader code (MoveInputS_*) uses these parameters:
	; IN
	; - BC: Ptr to wPlInfo structure
	; - DE: Ptr to respective wOBJInfo structure
	; OUT
	; - C flag: If set, a move was started
	jp   hl				; Execute it

; =============== Play_Pl_DoBasicMoveInput ===============
; Handles basic player movement, basic attacks, and setting moves
; when getting attacked.
; This updates player flags and can set a MOVE_SHARED_* move.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Play_Pl_DoBasicMoveInput:
	push bc
		push de

		;
		; Handle starting throws
		;
		BasicInput_ChkThrowStart:

			call Play_Pl_ChkThrowInput			; Started a throw?
			jp   nc, .end						; If not, jump
			cp   PLAY_THROWOP_GROUND			; Ground throw?
			jp   z, BasicInput_StartGroundThrow	; If so, jump
			cp   PLAY_THROWOP_AIR				; Air throw?
			jp   z, BasicInput_StartAirThrow	; If so, jump
			; PLAY_THROWOP_UNUSED_BOTH not handled as a throw, it's for command throws only.
		.end:

		BasicInput_ChkBaseInput:
			; If basic input is disabled, return.
			;
			; This is important to prevent moves or the intro/outro moves from being
			; interrupted by the basic movement actions.
			; ie: normally, the game returns to the idle move when nothing is pressed,
			;     but that shouldn't happen while performing another move.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			bit  PF1B_NOBASICINPUT, [hl]
			jp   nz, BasicInput_End
			
			; If an intro/outro animation is playing, which is straight up a MoveId
			; overriding whatever we're doing, display that.
			ld   hl, iPlInfo_IntroMoveId
			add  hl, bc
			ld   a, [hl]
			or   a					; Any move set?
			jp   z, .chkMain		; If not, skip
			
			; Which move is it?
			cp   MOVE_SHARED_WIN
			jp   z, BasicInput_StartWinMove
			cp   MOVE_SHARED_LOST_TIMEOVER
			jp   z, BasicInput_StartLostMove
			cp   MOVE_SHARED_INTRO
			jp   z, BasicInput_StartIntroMove
			; (We should never get here)
	
			;
			; Main input reader
			;

		.chkMain:
			ld   hl, iPlInfo_JoyKeysLH
			add  hl, bc
			ld   a, [hl]
			; Note: jumpkicks are handled by the jump move code, not here.
			bit  KEYB_UP, a						; Holding up?
			jp   nz, BasicInput_StartJump		; If so, jump
			bit  KEYB_DOWN, a					; Holding down?
			jp   nz, BasicInput_ChkDown			; If so, jump
			; Normals (ground only)
			bit  KEPB_A_LIGHT, a				; Light kick?
			jp   nz, BasicInput_StartLightKick	; If so, jump
			bit  KEPB_B_LIGHT, a				; Light punch?
			jp   nz, BasicInput_StartLightPunch	; If so, jump
			bit  KEPB_A_HEAVY, a				; Heavy kick?
			jp   nz, BasicInput_ChkHeavyA		; If so, jump
			bit  KEPB_B_HEAVY, a				; Heavy punch?
			jp   nz, BasicInput_ChkHeavyB		; If so, jump
			; Horizontal movement
			bit  KEYB_LEFT, a					; Holding left?
			jp   nz, .chkWalkL					; If so, jump
			bit  KEYB_RIGHT, a					; Holding right?
			jp   nz, .chkWalkR					; If so, jump
			
			; Taunt
			ld   hl, iPlInfo_JoyNewKeys
			add  hl, bc
			bit  KEYB_SELECT, [hl]				; Did we press SELECT?
			jp   nz, BasicInput_ChkTaunt		; If so, jump

			;--
			; [POI] Not necessary
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			;--
			
			jp   BasicInput_StartIdle

			; Determine if we're walking forwards or backwards
		.chkWalkL:
			; Left is backwards on the 1P side
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			bit  SPRB_XFLIP, [hl]				; Facing right / 1P side? (so L -> backward)
			jp   nz, BasicInput_ChkWalkBack		; If so, jump
			jp   BasicInput_ChkWalkForward		; Otherwise, skip ahead
		.chkWalkR:
			; Right is backwards on the 2P side
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			bit  SPRB_XFLIP, [hl]				; Facing right / 1P side? (so R -> forward)
			jp   nz, BasicInput_ChkWalkForward	; If so, skip ahead
			; Fall-through
			
		;
		; Checks for moves triggered by walking backwards
		;
		BasicInput_ChkWalkBack:
			; Walking back cancels the crouching state
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_CROUCH, [hl]

			; B+B -> Hop Back
			mMvIn_ChkDirStrict MoveInput_BB, BasicInput_StartHopBack

			; If the other player is attacking, attempting to walk backwards will block instead.
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc
			bit  PF0B_PROJ, [hl]					; Is the other player throwing a projectile?
			jp   nz, BasicInput_StartGroundBlock	; If so, jump
			ld   hl, iPlInfo_MoveDamageValOther
			add  hl, bc
			ld   a, [hl]
			or   a									; Is the other player performing an attack?
			jp   nz, BasicInput_StartGroundBlock	; If so, jump

			; Otherwise, just walk back
			jp   BasicInput_StartWalkBack

		;
		; Checks for moves triggered when holding down.
		;
		BasicInput_ChkDown:

			;
			; D+PK -> Charge POW meter
			;

			; Ignore if fully charged
			ld   hl, iPlInfo_Pow
			add  hl, bc
			push af
				ld   a, PLAY_POW_MAX
				cp   a, [hl]			; Are we at max power?
				jp   z, .noCharge		; If so, skip
			pop  af
			; Check for A+B input
			call Play_Pl_AreBothBtnHeld			; Holding A+B?
			jp   c, BasicInput_StartChargeMeter	; If so, jump
			jp   .chkNormals
			.noCharge:
			pop  af

		.chkNormals:
			; For everything else, holding down means crouching
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			set  PF1B_CROUCH, [hl]

			; Check normals
			bit  KEPB_A_LIGHT, a
			jp   nz, BasicInput_StartCrouchLightKick
			bit  KEPB_B_LIGHT, a
			jp   nz, BasicInput_StartCrouchLightPunch
			bit  KEPB_A_HEAVY, a
			jp   nz, BasicInput_ChkFwdCrouchHeavyKick
			bit  KEPB_B_HEAVY, a
			jp   nz, BasicInput_StartCrouchHeavyPunch

			; Check crouch block
			bit  KEYB_LEFT, a
			jp   nz, .chkL
			bit  KEYB_RIGHT, a
			jp   nz, .chkR

			; D -> Idle crouching
			jp   BasicInput_StartCrouchIdle


			;
			; Determine if we're holding forwards or backwards, depending on the side we're in.
			;
		.chkL:
			; Left is backwards on the 1P side
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			bit  SPRB_XFLIP, [hl]					; Facing right / 1P side? (so L -> backward)
			jp   nz, BasicInput_ChkCrouchBack		; If so, jump
			
			; Since we're trying to move forward, check if we're allowed to crouch-walk.
			jp   BasicInput_ChkCrouchWalk

		.chkR:
			; Right is backwards on the 2P side
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			bit  SPRB_XFLIP, [hl]					; Facing right / 1P side? (so R -> forward)
			jp   nz, BasicInput_ChkCrouchWalk		; If so, skip ahead
													; Otherwise, we're holding back
		;
		; Checks for blocking while crouching
		;
		BasicInput_ChkCrouchBack:
			; We can only block if the other player is attacking.
			; Otherwise, fall-through into the idle crouch code.
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc
			bit  PF0B_PROJ, [hl]					; Is there an enemy projectile?
			jp   nz, BasicInput_StartGroundBlock	; If so, block

			ld   hl, iPlInfo_MoveDamageValOther
			add  hl, bc
			ld   a, [hl]
			or   a									; Is the other player attacking?
			jp   nz, BasicInput_StartGroundBlock	; If so, block
	
		;
		; Starts the crouch idle move.
		;
		BasicInput_StartCrouchIdle:
			; Don't start crouching if we're already doing so
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]
			cp   MOVE_SHARED_CROUCH		; iPlInfo_MoveId == MOVE_SHARED_CROUCH
			jp   z, BasicInput_End		; If so, return

			; Set flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]		; Don't guard
										; PF1B_CROUCH got already set before
			; New move
			ld   a, MOVE_SHARED_CROUCH
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
		
		;
		; Starts the standing idle move.
		;
		BasicInput_StartIdle:
			; Don't start idling if we're already doing so
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]
			cp   MOVE_SHARED_IDLE
			jp   z, BasicInput_End

			; Set flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]

			; New move
			ld   a, MOVE_SHARED_IDLE
			call Pl_SetMove_StopSpeed

			jp   BasicInput_End

		BasicInput_ChkWalkForward:
			; F+F -> Hop forwards
			mMvIn_ChkDirStrict MoveInput_FF, BasicInput_StartHopForward
			; Fall-through

		;
		; Starts walking forwards.
		;
		BasicInput_StartForward:
			; Don't start if we're doing it already
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]				; A = MoveId
			cp   MOVE_SHARED_WALK_F		; MoveId == forwards walking?
			jp   z, BasicInput_End		; If so, return

			; Update flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]		; Only set when switching to the actual block move
			res  PF1B_CROUCH, [hl]		; Walking is not crouching

			; New move
			ld   a, MOVE_SHARED_WALK_F
			call Pl_SetMove_StopSpeed

			; Apply continuous movement speed since we just nuked it
			ld   hl, +$0180							; HL = Hardcoded forwards speed (1.5px/frame)
			call Play_OBJLstS_SetSpeedH_ByXFlipR	; Move horizontally by that
			jp   BasicInput_End

		;
		; Starts walking backwards.
		;
		BasicInput_StartWalkBack:
			; Don't start if we're doing it already
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]				; A = MoveId
			cp   MOVE_SHARED_WALK_B		; MoveId == backwards walking?
			jp   z, BasicInput_End		; If so, return

			; Update flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]		; Only set when switching to the actual block move
			res  PF1B_CROUCH, [hl]		; Walking is not crouching

			; New move
			ld   a, MOVE_SHARED_WALK_B
			call Pl_SetMove_StopSpeed

			; Apply continuous movement speed since we just nuked it
			ld   hl, -$0100							; HL = Hardcoded backwards speed (1px/frame)
			call Play_OBJLstS_SetSpeedH_ByXFlipR	; Move horizontally by that
			jp   BasicInput_End

		;
		; Crouch-walking check.
		; This is specific to this game, this block of code is gone in 96.
		;
		BasicInput_ChkCrouchWalk:
			; Only the Fatal Fury characters are allowed to perform this move.
			; Note that characters that can't crouch-walk reuse the walking anim if forced to do so.
			ld   hl, iPlInfo_CharId
			add  hl, bc
			ld   a, [hl]
			cp   CHAR_ID_TERRY					; Playing as Terry?
			jp   z, BasicInput_StartCrouchWalk	; If so, jump
			cp   CHAR_ID_JOE					; ...
			jp   z, BasicInput_StartCrouchWalk
			cp   CHAR_ID_KIM
			jp   z, BasicInput_StartCrouchWalk
			cp   CHAR_ID_MAI
			jp   z, BasicInput_StartCrouchWalk
			cp   CHAR_ID_BILLY
			jp   z, BasicInput_StartCrouchWalk
			; Otherwise, pretend we are idle
			jp   BasicInput_StartCrouchIdle

		;
		; Starts crouch-walking forwards.
		;
		BasicInput_StartCrouchWalk:
			; Don't start if we're doing it already
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]					; A = MoveId
			cp   MOVE_SHARED_CROUCHWALK_F	; MoveId == crouch walking?
			jp   z, BasicInput_End			; If so, return
			
			; Update flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]		; Can't block when moving forwards
			set  PF1B_CROUCH, [hl]		; We are crouching
			
			; New move
			ld   a, MOVE_SHARED_CROUCHWALK_F
			call Pl_SetMove_StopSpeed
			
			; Apply continuous movement speed since we just nuked it
			ld   hl, +$00C0							; HL = Hardcoded backwards speed (0.75px/frame)
			call Play_OBJLstS_SetSpeedH_ByXFlipR	; Move horizontally by that
			jp   BasicInput_End
			
		;
		; Starts any kind of jump.
		;
		BasicInput_StartJump:
			; Backup the joypad info from before the jump to here.
			; It will be used during the jump when deciding which direction/speed to use.
			ld   hl, iPlInfo_JoyKeys
			add  hl, bc			; Seek to iPlInfo_JoyKeys
			push de
				ldi  a, [hl]	; A = iPlInfo_JoyKeys
				ld   d, [hl]	; D = iPlInfo_JoyNewKeysLH
				inc  hl			; Seek to iPlInfo_JoyKeysPreJump
				ldi  [hl], a	; iPlInfo_JoyKeysPreJump = iPlInfo_JoyKeys
				ld   [hl], d	; iPlInfo_JoyNewKeysLHPreJump = iPlInfo_JoyNewKeysLH
			pop  de

			; Set standard flags except PF1B_NOSPECSTART, otherwise we
			; couldn't start air specials.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]

			; Always start a neutral jump by default.
			; The code for it will then detect if it should switch to
			; either the backwards or forwards jumps.
			ld   a, MOVE_SHARED_JUMP_N
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End

		;
		; Starts a ground block if we weren't performing one already.
		;
		BasicInput_StartGroundBlock:
			; Check if we're doing low/crouch or mid/standing block
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]				; A = MoveId
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			bit  PF1B_CROUCH, [hl]		; Are we crouching?
			jr   nz, .crouch			; If so, jump
		.stand:
			cp   MOVE_SHARED_BLOCK_G	; Are we mid blocking already?
			jp   z, BasicInput_End		; If so, return
			ld   a, MOVE_SHARED_BLOCK_G	; Otherwise, start the mid block
			jr   .start
		.crouch:
			cp   MOVE_SHARED_BLOCK_C	; Are we low blocking already?
			jp   z, BasicInput_End		; If so, return
			ld   a, MOVE_SHARED_BLOCK_C	; Otherwise, start the low block
		.start:
			; Set the block flag and switch to the appropriate move.
			; For obvious reasons, this is done before execution gets to HomeCall_Play_Pl_DoHit.
			set  PF1B_GUARD, [hl]		; Do the block
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Starts charging meter.
		;
		BasicInput_StartChargeMeter:
			; Play DMG SFX
			ld   a, SFX_CHARGEMETER
			call HomeCall_Sound_ReqPlayExId

			; Set standard flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]			; Player is vulnerable
			res  PF1B_CROUCH, [hl]			; and standing
			set  PF1B_NOBASICINPUT, [hl]	; Not cancellable by movement
			set  PF1B_XFLIPLOCK, [hl]		; Doesn't turn if opponent jumps over
			set  PF1B_NOSPECSTART, [hl]		; Not cancellable by specials

			; New move
			ld   a, MOVE_SHARED_CHARGEMETER
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End

		;
		; Starts a standing light punch.
		;
		BasicInput_StartLightPunch:
			; Set flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]	; Normals not guarded
			res  PF1B_CROUCH, [hl]	; From standing
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			; Normals can't be cancelled into specials (unless special cancels are allowed, PF1B_ALLOWHITCANCEL)
			set  PF1B_NOSPECSTART, [hl] ; Can't cancel into special
	
			; New move
			; There are two variations of the light punch depending on how far we are from the opponent.
			; This is a purely visual effect, as both moves have different animations
			; but point to the same code, with no move-specific differences.
			ld   hl, iPlInfo_PlDistance
			add  hl, bc
			ld   a, [hl]
			cp   $14				; iPlInfo_PlDistance >= $14?
			jp   nc, .far			; If so, jump
		.near:
			ld   a, MOVE_SHARED_PUNCH_LN
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
		.far:
			ld   a, MOVE_SHARED_PUNCH_LM
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
			
		;
		; Checks for input requiring an heavy punch.
		;
		BasicInput_ChkHeavyB:
			; A+B+Forward -> Heavy Attack
			; A+B         -> Dodge
			call Play_Pl_IsStrikeInputHeld 			; Check for A+B+F Input
			jp   nc, BasicInput_ChkFwdHeavyPunch	; Holding A+B? If not, jump
			jp   nz, BasicInput_StartStrikeAttack	; Holding A+B+F? If so, jump
			jp   BasicInput_StartDodge				; Otherwise, we're just holding A+B
			
		;
		; A few characters have an unique heavy punch when holding forward.
		; B+Forward -> Forward Heavy Attack
		;
		BasicInput_ChkFwdHeavyPunch:
			ld   hl, iPlInfo_CharId
			add  hl, bc
			ld   a, [hl]
			cp   CHAR_ID_RYO				; Playing as RYO?
			jp   z, .chkInput				; If so, jump
			cp   CHAR_ID_TERRY				; ...
			jp   z, .chkInput
			cp   CHAR_ID_KENSOU
			jp   z, .chkInput
			cp   CHAR_ID_IORI
			jp   z, .chkInput
			cp   CHAR_ID_SAISYU
			jp   z, .chkInput
			jp   BasicInput_StartHeavyPunch	; Otherwise, skip
		.chkInput:
			call Play_Pl_IsFwdHeld					; Holding forwards?
			jp   nz, BasicInput_StartFwdHeavyPunch	; If so, jump
			; Fall-through

		;
		; Starts a standing heavy punch.
		;
		BasicInput_StartHeavyPunch:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard attack flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			; New move, by distance
			ld   hl, iPlInfo_PlDistance
			add  hl, bc
			ld   a, [hl]
			cp   $14				; iPlInfo_PlDistance >= $14?
			jp   nc, .far			; If so, jump
		.near:
			ld   a, MOVE_SHARED_PUNCH_HN
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
		.far:
			ld   a, MOVE_SHARED_PUNCH_HM
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
	
		;
		; Starts a standing light kick.
		;
		BasicInput_StartLightKick:
			; Set standard attack flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
	
			; New move, by distance
			ld   hl, iPlInfo_PlDistance
			add  hl, bc
			ld   a, [hl]
			cp   $14				; iPlInfo_PlDistance >= $14?
			jp   nc, .far			; If so, jump
		.near:
			ld   a, MOVE_SHARED_KICK_LN
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
		.far:
			ld   a, MOVE_SHARED_KICK_LM
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End

		;
		; Checks for input requiring an heavy kick.
		; See also: BasicInput_ChkHeavyB
		;
		BasicInput_ChkHeavyA:
		
			; A+B+Forward -> Heavy Attack
			; A+B         -> Dodge
			call Play_Pl_IsStrikeInputHeld 			; Check for A+B+F Input
			jp   nc, BasicInput_ChkFwdHeavyKick		; Holding A+B? If not, jump
			jp   nz, BasicInput_StartStrikeAttack	; Holding A+B+F? If so, jump
			jp   BasicInput_StartDodge				; Otherwise, we're just holding A+B
			
		BasicInput_ChkFwdHeavyKick:
			ld   hl, iPlInfo_CharId
			add  hl, bc
			ld   a, [hl]
			cp   CHAR_ID_KYO
			jp   z, .chkInput
			cp   CHAR_ID_KENSOU
			jp   z, .chkInput
			cp   CHAR_ID_YURI
			jp   z, .chkInput
			cp   CHAR_ID_IORI
			jp   z, .chkInput
			cp   CHAR_ID_BILLY
			jp   z, .chkInput
			jp   BasicInput_StartHeavyKick
		.chkInput:
			call Play_Pl_IsFwdHeld					; Holding forwards?
			jp   nz, BasicInput_StartFwdHeavyKick	; If so, jump
			; Fall-through
	
		;
		; Starts a standing heavy kick.
		;
		BasicInput_StartHeavyKick:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId
			
			; Set standard attack flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
	
			; New move, by distance
			ld   hl, iPlInfo_PlDistance
			add  hl, bc
			ld   a, [hl]
			cp   $14				; iPlInfo_PlDistance >= $14?
			jp   nc, .far			; If so, jump
		.near:
			ld   a, MOVE_SHARED_KICK_HN
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
		.far:
			ld   a, MOVE_SHARED_KICK_HM
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End

		;
		; Starts a crouching light punch.
		;
		BasicInput_StartCrouchLightPunch:
			; [POI] If the easy moves cheat is enabled, crouching lps reflect projectiles.
			ld   a, [wDipSwitch]
			bit  DIPB_EASY_MOVES, a		; Is the cheat set?
			jp   z, .go					; If not, skip
			ld   hl, iPlInfo_Flags0
			add  hl, bc					; Otherwise, make it reflect projectiles
			set  PF0B_PROJREFLECT, [hl]
		.go:
			; Set standard crouching attack flags.
			; Same as normal, except without resetting PF1B_CROUCH.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_PUNCH_CL
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End

		;
		; Starts a crouching heavy punch.
		;
		BasicInput_StartCrouchHeavyPunch:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; [POI] If the easy moves cheat is enabled, crouching hps erase projectiles.
			ld   a, [wDipSwitch]
			bit  DIPB_EASY_MOVES, a		; Is the cheat set?
			jp   z, .go					; If not, skip
			ld   hl, iPlInfo_Flags0
			add  hl, bc					; Otherwise, make it delete projectiles
			set  PF0B_PROJREM, [hl]
		.go:

			; Set standard crouching attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_PUNCH_CH
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End

		;
		; Starts a crouching light kick.
		;
		BasicInput_StartCrouchLightKick:
			; Set standard crouching attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			; New move
			ld   a, MOVE_SHARED_KICK_CL
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End

		;
		; A few characters have an unique crouching heavy kick when holding forward.
		; B+Forward -> Forward Heavy Attack
		;
		BasicInput_ChkFwdCrouchHeavyKick:
			ld   hl, iPlInfo_CharId
			add  hl, bc
			ld   a, [hl]
			cp   CHAR_ID_KYO
			jp   z, .chkInput
			cp   CHAR_ID_JOE
			jp   z, .chkInput
			jp   BasicInput_StartCrouchHeavyKick
		.chkInput:
			call Play_Pl_IsFwdHeld						; Holding forwards?
			jp   nz, BasicInput_StartFwdCrouchHeavyKick	; If so, jump
		
		;
		; Starts a crouching heavy kick.
		;		
		BasicInput_StartCrouchHeavyKick:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard crouching attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_KICK_CH
			call Pl_SetMove_ResetNewKeysLH
			jp   BasicInput_End
			
		;
		; Starts the dodge move.
		;	
		BasicInput_StartDodge:
			; Set standard flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			
			; No collision while dodging
			inc  hl ; Seek to iPlInfo_Flags1
			set  PF2B_NOHURTBOX, [hl]
			set  PF2B_NOCOLIBOX, [hl]

			; New move
			ld   a, MOVE_SHARED_DODGE
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Starts a Strike Attack.
		;
		BasicInput_StartStrikeAttack:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_STRIKE
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Starts a forward heavy punch.
		;
		BasicInput_StartFwdHeavyPunch:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_PUNCH_FH
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Starts a forward heavy kick.
		;
		BasicInput_StartFwdHeavyKick:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_KICK_FH
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Starts a forward crouching heavy kick.
		;		
		BasicInput_StartFwdCrouchHeavyKick:
			; Play DMG SFX
			ld   a, SFX_HEAVY
			call HomeCall_Sound_ReqPlayExId

			; Set standard crouching attack flags.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]

			; New move
			ld   a, MOVE_SHARED_KICK_FCH
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
	
		;
		; Starts a forward hop.
		;
		BasicInput_StartHopForward:
			; Clear input buffer so only newly pressed inputs count
			; for starting a special in the middle of the run.
			call Play_Pl_ClearJoyDirBuffer

			; Standard flags except for PF1B_NOSPECSTART, as it's possible
			; to cancel the run into a special move.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]

			; New move
			ld   a, MOVE_SHARED_HOP_F
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
	
		;
		; Starts a backwards hop.
		;
		BasicInput_StartHopBack:
			; Like with the forwards run
			call Play_Pl_ClearJoyDirBuffer

			; Standard flags except for PF1B_NOSPECSTART, as it's possible
			; to cancel the run into a special move.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]

			; New move
			ld   a, MOVE_SHARED_HOP_B
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
	
		;
		; Starts a taunt, which reduces meter.
		;
		BasicInput_ChkTaunt:
			; Play SGB/DMG SFX.
			ld   a, SCT_TAUNT
			call HomeCall_Sound_ReqPlayExId

			; Set standard flags except for PF1B_NOSPECSTART.
			; It's possible to cancel it into a special, though unlike other
			; versions the meter stops decreasing once that's done.
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]

			; New move
			ld   a, MOVE_SHARED_TAUNT
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
	
		;
		; These three are for the moves set to iPlInfo_IntroMoveId
		;
		BasicInput_StartWinMove:
			ld   a, MOVE_SHARED_WIN
			jp   BasicInput_StartIntroOutroMove
		BasicInput_StartLostMove:
			ld   a, MOVE_SHARED_LOST_TIMEOVER
			jp   BasicInput_StartIntroOutroMove
		BasicInput_StartIntroMove:
			ld   a, MOVE_SHARED_INTRO
	
		;
		; Starts the intro/outro move to be executed/displayed over whatever
		; we would normally display (the idle animation).
		; IN
		; - A: iPlInfo_IntroMoveId
		;
		BasicInput_StartIntroOutroMove:
			; Set standard flags
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			set  PF1B_INVULN, [hl]
			
			; New move
			call Pl_SetMove_StopSpeed
			jp   BasicInput_End
			
		;
		; Handles the second part of a ground throw.
		;
		BasicInput_StartGroundThrow:
			;
			; Ground throws in this game are simpler in this game, as there's no way to throw tech.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			; Set standard flags
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			res  PF1B_XFLIPLOCK, [hl]	; What
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			; Completely invulnerable while throwing
			set  PF1B_INVULN, [hl]

			; New move
			ld   a, MOVE_SHARED_THROW_G
			call Pl_SetMove_StopSpeed
			; Wait 1 frame
			call Task_PassControlFar
			; Switch to the next part of the throw.
			ld   a, PLAY_THROWACT_NEXT03
			ld   [wPlayPlThrowActId], a
			jp   BasicInput_End
		;
		; Handles the second part of an air throw.
		;
		BasicInput_StartAirThrow:
			;
			; Identical to BasicInput_StartGroundThrow, except it sets a different move ID.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			; Set standard flags
			res  PF1B_GUARD, [hl]
			res  PF1B_CROUCH, [hl]
			set  PF1B_NOBASICINPUT, [hl]
			res  PF1B_XFLIPLOCK, [hl]	; What
			set  PF1B_XFLIPLOCK, [hl]
			set  PF1B_NOSPECSTART, [hl]
			; Completely invulnerable while throwing
			set  PF1B_INVULN, [hl]

			; New move
			ld   a, MOVE_SHARED_THROW_A
			call Pl_SetMove_StopSpeed
			; Wait 1 frame
			call Task_PassControlFar
			; Switch to the next part of the throw.
			ld   a, PLAY_THROWACT_NEXT03
			ld   [wPlayPlThrowActId], a
			jp   BasicInput_End

		BasicInput_End:
		pop  de
	pop  bc
	ret 

; =============== Pl_SetMove_* ===============
; Set of subroutines that start a new move, initialize its animation, and optionally cause a specific effect.
; Moves use one of these rather than directly calling Pl_SetNewMove.

; =============== Pl_SetMove_StopSpeed ===============
; Starts a new move and initializes its animation.
; This is for continuous moves that kill the player momentum when used (ie: most of them).
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Pl_SetMove_StopSpeed:
	push bc
		push de
			call Pl_SetNewMove

			; Reset player speed when starting the move
			ld   hl, iOBJInfo_SpeedX
			add  hl, de		; Seek to iOBJInfo_SpeedX
			xor  a			; Clear...
			ldi  [hl], a	; ...iOBJInfo_SpeedX
			ldi  [hl], a	; ...iOBJInfo_SpeedXSub
			ldi  [hl], a	; ...iOBJInfo_SpeedY
			ld   [hl], a	; ...iOBJInfo_SpeedYSub

			; Set up initial GFX buffer info settings for the animation
			push de
			pop  hl
			call OBJLstS_DoAnimTiming_Initial
		pop  de
	pop  bc
	ret

; =============== Pl_SetMove_ResetNewKeysLH ===============
; Starts a new move and initializes its animation.
; This is used for starting basic moves (BasicInput_ChkBaseInput) that depend on the light/heavy status.
;
; These basic inputs don't kill the player's momentum, but do unmark any other newly pressed key,
; in case we're starting a move that calls Play_Pl_AddToJoyBufKeysLH to do something
; (ie: start chained move, end the move early, ...)
;
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Pl_SetMove_ResetNewKeysLH:
	push bc
		push de
			call Pl_SetNewMove

			; Reset iPlInfo_JoyNewKeysLH
			ld   hl, iPlInfo_JoyNewKeysLH
			add  hl, bc
			ld   [hl], $00

			; Set up initial GFX buffer info settings for the animation
			push de
			pop  hl
			call OBJLstS_DoAnimTiming_Initial
		pop  de
	pop  bc
	ret

; =============== Pl_SetMove_Simple ===============
; Starts a new move and initializes its animation.
; This has no special effect.
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Pl_SetMove_Simple:
	push bc
		push de
			call Pl_SetNewMove

			; Set up initial GFX buffer info settings for the animation
			push de
			pop  hl
			call OBJLstS_DoAnimTiming_Initial
		pop  de
	pop  bc
	ret

; =============== Pl_SetMove_ShakeScreenReset ===============
; [TCRF] In this game, this subroutine is identical to Pl_SetMove_StopSpeed.
;        The fact that it still exists here though probably says something.
;
; Starts a new move and initializes its animation.
; This one was probably supposed to reset the earthquake effect like 96 does, but it doesn't.
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
Pl_SetMove_ShakeScreenReset:
	push bc
		push de
			call Pl_SetNewMove

			; Reset player speed when starting the move
			ld   hl, iOBJInfo_SpeedX
			add  hl, de		; Seek to iOBJInfo_SpeedX
			xor  a			; Clear...
			ldi  [hl], a	; ...iOBJInfo_SpeedX
			ldi  [hl], a	; ...iOBJInfo_SpeedXSub
			ldi  [hl], a	; ...iOBJInfo_SpeedY
			ld   [hl], a	; ...iOBJInfo_SpeedYSub

			; Set up initial GFX buffer info settings for the animation
			push de
			pop  hl
			call OBJLstS_DoAnimTiming_Initial
		pop  de
	pop  bc
	ret
	
; =============== Play_Pl_MoveByColiBoxOverlapX ===============
; Pushes the player backwards when the collision box overlaps with the opponent's.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
Play_Pl_MoveByColiBoxOverlapX:
	; If we're being thrown, ignore this
	ld   a, [wPlayPlThrowActId]
	or   a
	ret  nz

	; When the main task processed the collision boxes earlier this frame,
	; it set iPlInfo_ColiBoxOverlapX with the amount we're inside the opponent.

	; We get pushed backwards by half that amount.
	; This means the movement gradually slows down over time as we get moved out further.

	push bc
		; A = Overlap amount
		ld   hl, iPlInfo_ColiBoxOverlapX
		add  hl, bc
		ld   a, [hl]
		; If there's no overlap, return
		cp   $00
		jr   z, .end

		; The overlap amount is an absolute (positive) number.
		; That would cause us to move right -- and if we are facing left (2P side), that's correct.
		; If we're facing right however (1P side) we want to be pushed left instead.
		;
		; So, if we're facing left invert the number.

		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de
		ld   b, [hl]		; B = iOBJInfo_OBJLstFlags
		ld   h, a			; HL = iPlInfo_ColiBoxOverlapX
		ld   l, $00
		bit  SPRXB_PLDIR_R, b	; Is the player internally facing right?
		jr   z, .move			; If not, skip
		; Otherwise, invert HL
		ld   a, h	; H = -H
		cpl
		ld   h, a
		ld   a, l	; L = -L
		cpl
		ld   l, a
		inc  hl		; Account for bitflip
	.move:
		sra  h		; HL = HL / 2
		rr   l
		call Play_OBJLstS_MoveH
	.end:
	pop  bc
	ret

; =============== Play_OBJLstS_Move* ===============
; Set of movement routines used by the move code.
; There are also a few wrappers to the horizontal movement one that invert
; the movement amount depending on a condition.

; =============== Play_OBJLstS_MoveH ===============
; Moves the sprite mapping horizontally by the specified amount.
; - DE: Ptr to wOBJInfo structure
; - HL: Movement amount (pixels + subpixels), can be negative
Play_OBJLstS_MoveH:
	push bc
		push de
			; BC = Movement amount
			push hl
			pop  bc

			; DE = Ptr to player X pos
			ld   hl, iOBJInfo_X
			add  hl, de
			push hl
			pop  de

			push de				; Save X pos ptr

				; H = iOBJInfo_X
				ld   a, [de]
				ld   h, a
				inc  de
				; L = iOBJInfo_XSub
				ld   a, [de]
				ld   l, a

				;
				; Determine if we're moving left or right, as there are different cap checks between sides.
				;
				bit  7, b			; MSB of high byte set? (BC < 0?)
				jp   nz, .moveL		; If so, jump
			.moveR:
				; BC > 0
				; XPos = MIN(XPos + BC, $FF00)
				; The largest allowed value is at $FF pixels, $00 subpixels.
				add  hl, bc			; HL += BC
				jp   nc, .saveX		; Did it overflow? If not, jump
				ld   hl, $FF00		; Otherwise, cap to $FF00
				jp   .saveX
			.moveL:
				; BC < 0
				; XPos = MAX(XPos + BC, $0000)

				ld   a, h		; Save original iOBJInfo_X for underflow check

				; Move the OBJ left by BC
				add  hl, bc		; HL +-= BC

				; The above instruction doesn't trigger the carry flag like we'd like since we're
				; using it to subtract words.
				; So we have to check for the underflow manually:
				; If the original iOBJInfo_X value is less than the X movement amount, then
				; we underflowed and should cap at $0000.

				push af			; Save orig iOBJInfo_X
					; Force the negative movement speed to positive
					ld   a, b	; XMove = -B
					cpl
					inc  a
					ld   b, a
				pop  af			; A = orig iOBJInfo_X
				sub  a, b		; iOBJInfo_X >= XMoveAbs?
				jp   nc, .saveX	; If so, skip (no underflow)
				ld   hl, $0000	; Otherwise, cap to $0000

			.saveX:

			; Save back the updated X position
			pop  de			; DE = Ptr to iOBJInfo_X
			ld   a, h
			ld   [de], a	; Save pixel count
			inc  de			; Seek to iOBJInfo_XSub
			ld   a, l
			ld   [de], a	; Save subpixel count
		pop  de
	pop  bc
	ret

; =============== Play_OBJLstS_MoveV ===============
; Moves the sprite mapping vertically by the specified amount.
; - DE: Ptr to wOBJInfo structure
; - HL: Movement amount (pixels + subpixels), can be negative
Play_OBJLstS_MoveV:
	; This is similar to Play_OBJLstS_MoveH, except it performs no underflow/overflow checks at all.

	push bc
		push de
			; BC = Movement amount
			push hl
			pop  bc

			; DE = Ptr to player Y pos
			ld   hl, iOBJInfo_Y
			add  hl, de
			push hl
			pop  de

			push de				; Save Y pos ptr

				; H = iOBJInfo_Y
				ld   a, [de]
				ld   h, a
				inc  de
				; L = iOBJInfo_YSub
				ld   a, [de]
				ld   l, a

				; YPos += YMove
				add  hl, bc

			; Save back the updated Y position
			pop  de				; DE = Ptr to iOBJInfo_Y

			ld   a, h
			ld   [de], a		; Save pixel count
			inc  de				; Seek to iOBJInfo_YSub
			ld   a, l
			ld   [de], a		; Save subpixel count
		pop  de
	pop  bc
	ret

; =============== Play_OBJLstS_MoveH_ByXFlipR ===============
; Moves the specified sprite mapping horizontally, relative to the current player *visually* facing right.
; If we're visually facing left, the movement amount is inverted.
; Most moves use this for horizontal movement.
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement amount (pixels + subpixels), can be negative
Play_OBJLstS_MoveH_ByXFlipR:
	push bc
		push de
			; BC = Movement amount
			push hl
			pop  bc

			; Invert movement when facing left.
			; Unlike the sprite display which uses the left-facing sprites as base value (SPRB_XFLIP clear),
			; movement amounts use the right-facing sprites as base (SPRB_XFLIP set).
			; (ie: if a move makes us move right, we'll go right when facing right)
			; This is also the case for similar subroutines using related flags, like Play_OBJLstS_MoveH_ByXDirR.
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de				; Seek to iOBJInfo_OBJLstFlags
			bit  SPRB_XFLIP, [hl]	; Is the XFlip flag set? (visually facing right)
			jp   nz, .moveH			; If so, jump

			; Otherwise, BC = -BC
			ld   a, b	; Invert high byte
			cpl
			ld   b, a
			ld   a, c	; Invert low byte
			cpl
			ld   c, a
			inc  bc		; Account for cpl
		.moveH:

			; HL = Updated movement amount
			push bc
			pop  hl

			; Perform the movement
			call Play_OBJLstS_MoveH
		pop  de
	pop  bc
	ret

; =============== Play_OBJLstS_MoveH_ByXDirR ===============
; Moves the specified sprite mapping horizontally, relative to the current player *internally* facing right.
; See also: Play_OBJLstS_MoveH_ByXFlipR
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement amount (pixels + subpixels), can be negative
Play_OBJLstS_MoveH_ByXDirR:
	push bc
		push de
			; BC = Movement amount
			push hl
			pop  bc

			; Invert movement when internally facing left.
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de					; Seek to iOBJInfo_OBJLstFlags
			bit  SPRXB_PLDIR_R, [hl]	; Is the R direction flag set? (internally facing right)
			jp   nz, .moveH				; If so, jump

			; Otherwise, BC = -BC
			ld   a, b	; Invert high byte
			cpl
			ld   b, a
			ld   a, c	; Invert low byte
			cpl
			ld   c, a
			inc  bc		; Account for cpl
		.moveH:

			; HL = Updated movement amount
			push bc
			pop  hl

			; Perform the movement
			call Play_OBJLstS_MoveH
		pop  de
	pop  bc
	ret

; =============== Play_OBJLstS_MoveH_ByOtherProjOnR ===============
; Moves the specified sprite mapping horizontally, relative to an enemy projectile being on the right.
; See also: Play_OBJLstS_MoveH_ByXFlipR
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; - HL: Movement amount (pixels + subpixels), can be negative
Play_OBJLstS_MoveH_ByOtherProjOnR:
	push bc
		push de
			; BC = Movement amount
			push hl
			pop  bc

			; Invert the movement speed when the enemy projectile is on the left
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de					; Seek to iOBJInfo_OBJLstFlags
			bit  SPRXB_OTHERPROJR, [hl]	; Is the flag set? (Is an enemy projectile on the right?)
			jp   nz, .moveH				; If so, jump

			; Otherwise, BC = -BC
			ld   a, b
			cpl
			ld   b, a
			ld   a, c
			cpl
			ld   c, a
			inc  bc
		.moveH:
			; HL = Updated movement amount
			push bc
			pop  hl

			call Play_OBJLstS_MoveH
		pop  de
	pop  bc
	ret

; =============== Play_OBJLstS_SetSpeed* ===============
; Counterparts of Play_OBJLstS_Move* that, instead of moving the player immediately once,
; they only write to the speed field in the OBJInfo, resulting in continuous speed across frames.
; These subroutines follow the same set of rules when it comes to inverting the movement speed.


; =============== Play_OBJLstS_SetSpeedH_ByXFlipR ===============
; Sets the horizontal movement speed for the specified sprite mapping, relative to the current player *visually* facing right.
; Most moves use this in their code.
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement speed (pixels + subpixels), can be negative
Play_OBJLstS_SetSpeedH_ByXFlipR:
	push bc

		; Handle movement amount exactly like in Play_OBJLstS_MoveH_ByXFlipR

		; BC = Speed
		push hl
		pop  bc

		; Invert the speed when visually facing left.
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de				; Seek to iOBJInfo_OBJLstFlags
		bit  SPRB_XFLIP, [hl]	; Is the XFlip flag set? (visually facing right)
		jp   nz, .setSpd		; If so, jump

		; Otherwise, BC = -BC
		ld   a, b
		cpl
		ld   b, a
		ld   a, c
		cpl
		ld   c, a
		inc  bc

	.setSpd:
		; Save updated speed value
		ld   hl, iOBJInfo_SpeedX
		add  hl, de		; Seek to X speed
		ld   [hl], b	; Write iOBJInfo_SpeedX
		inc  hl			; Seek to X subpixel speed
		ld   [hl], c	; Write iOBJInfo_SpeedXSub
	pop  bc
	ret

; =============== Play_OBJLstS_SetSpeedH_ByXDirL ===============
; Sets the horizontal movement speed for the specified sprite mapping, relative to the current player *internally* facing *left*.
; There's no reason to have inconsistencies with the other SetSpeedH routines but oh well.
; See also: Play_OBJLstS_SetSpeedH_ByXFlipR
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement speed (pixels + subpixels), can be negative
Play_OBJLstS_SetSpeedH_ByXDirL:
	push bc
		; BC = Speed
		push hl
		pop  bc

		; Invert the speed when internally facing right
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de					; Seek to iOBJInfo_OBJLstFlags
		bit  SPRXB_PLDIR_R, [hl]	; Is the R direction flag *clear*? (internally facing left)
		jp   z, .setSpd				; If so, jump

		; Otherwise, BC = -BC
		ld   a, b
		cpl
		ld   b, a
		ld   a, c
		cpl
		ld   c, a
		inc  bc

	.setSpd:
		; Save updated speed value
		ld   hl, iOBJInfo_SpeedX
		add  hl, de
		ld   [hl], b
		inc  hl
		ld   [hl], c
	pop  bc
	ret

; =============== Play_OBJLstS_SetSpeedH ===============
; Sets the horizontal movement speed as-is for the specified sprite mapping.
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement speed (pixels + subpixels), can be negative
Play_OBJLstS_SetSpeedH:
	push bc
		; BC = Speed
		push hl
		pop  bc
		; Seek to iOBJInfo_SpeedX
		ld   hl, iOBJInfo_SpeedX
		add  hl, de
		; Replace it
		ld   [hl], b
		inc  hl
		ld   [hl], c
	pop  bc
	ret
; =============== Play_OBJLstS_SetSpeedV ===============
; Sets the vertical movement speed as-is for the specified sprite mapping.
; IN
; - DE: Ptr to wOBJInfo structure
; - HL: Movement speed (pixels + subpixels), can be negative
Play_OBJLstS_SetSpeedV:
	push bc
		; BC = Speed
		push hl
		pop  bc
		; Seek to iOBJInfo_SpeedY
		ld   hl, iOBJInfo_SpeedY
		add  hl, de
		; Replace it
		ld   [hl], b
		inc  hl
		ld   [hl], c
	pop  bc
	ret
; =============== OBJLstS_ApplyXSpeed ===============
; Moves the sprite horizontally as specified in iOBJInfo_SpeedX and iOBJInfo_SpeedXSub.
; iOBJInfo_X += iOBJInfo_SpeedX
;
; IN
; - HL: Ptr to wOBJInfo
OBJLstS_ApplyXSpeed:
	push bc
		push de

			; DE = Ptr to iOBJInfo_X
			ld   hl, iOBJInfo_X
			add  hl, de				; Seek to X position
			push hl
			pop  de

			push de
				; H = X position
				ld   a, [de]
				ld   h, a
				inc  de				; iOBJInfo_XSub
				; L = X subpixel position
				ld   a, [de]
				ld   l, a

				inc  de				; iOBJInfo_Y
				inc  de				; iOBJInfo_YSub
				inc  de				; iOBJInfo_SpeedX

				; B = H speed
				ld   a, [de]
				ld   b, a
				inc  de				; iOBJInfo_SpeedXSub
				; C = H subpixel speed
				ld   a, [de]
				ld   c, a

				; Add the speed values to the X position
				add  hl, bc
			pop  de

			; Write the updated result to X & XSub
			ld   a, h		; Write iOBJInfo_X
			ld   [de], a
			inc  de
			ld   a, l		; Write iOBJInfo_XSub
			ld   [de], a
		pop  de
	pop  bc
	ret

; =============== OBJLstS_ApplyFrictionHAndMoveH ===============
; Moves the sprite horizontally while under the effect of horizontal friction.
;
; Friction is just a fixed value that gets either added
; or subtracted to the player's speed, depending on the direction he's moving.
;
; This causes the horizontal speed to gradually reach 0.
;
; It's very similar to the subroutines for applying vertical gravity, and it follows
; the same structure, but those are "uncapped" and only end when touching the ground.
;
; IN
; - HL: Friction value, always positive.
; - DE: Ptr to wOBJInfo
; OUT
; - C flag: If set, our horz. speed was 0 already.
;           As long as we get here with iOBJInfo_SpeedX > 0, this will be cleared.
OBJLstS_ApplyFrictionHAndMoveH:
	push bc
		push de

			; BC = Friction value
			push hl
			pop  bc

			;
			; If our speed is already 0, we don't need to do anything.
			;
			ld   hl, iOBJInfo_SpeedX
			add  hl, de
			ld   a, [hl]		; A = iOBJInfo_SpeedX
			or   a				; SpeedX == 0?
			jp   z, .moveEnd	; If so, return

			;
			; If our speed is positive (we're moving right), invert the friction
			; from positive to negative, otherwise we'd be increasing the speed.
			;
			bit  7, a			; SpeedX < 0? (MSB set)
			jp   nz, .saveSpeed	; If so, skip
			; Otherwise, BC = -BC
			ld   a, b			; Invert high byte
			cpl
			ld   b, a
			ld   a, c			; Invert low byte
			cpl
			ld   c, a
			inc  bc				; Account for bitflip

		.saveSpeed:

			;
			; Update the horizontal movement speed.
			;
			push hl	; Save ptr to iOBJInfo_SpeedX
				; DE = X Speed
				ld   d, [hl]	; D = iOBJInfo_SpeedX
				inc  hl
				ld   e, [hl]	; E = iOBJInfo_SpeedXSub

				; Add the friction over to reduce it
				; DE += Friction
				push de			; HL = DE
				pop  hl
				add  hl, bc		; HL += BC
				push hl			; DE = HL
				pop  de
			pop  hl	; Restore ptr to iOBJInfo_SpeedX

			; Write back the updated speed
			ld   [hl], d	; iOBJInfo_SpeedX = D
			inc  hl
			ld   [hl], e	; iOBJInfo_SpeedXSub = E
			jp   .moveOk

		.moveEnd:
		pop  de
	pop  bc

	; Force reset pixel and subpixel speed values
	ld   hl, iOBJInfo_SpeedX
	add  hl, de
	xor  a
	ldi  [hl], a	; iOBJInfo_SpeedX = 0
	ld   [hl], a	; iOBJInfo_SpeedXSub = 0
	scf				; C flag set
	ret
		.moveOk:
		pop  de
	pop  bc
	; Move horizontally with the recently updated speed value
	call OBJLstS_ApplyXSpeed
	or   a			; C flag clear
	ret

; =============== OBJLstS_ApplyGravityVAndMoveHV ===============
; Moves the sprite horizontally and vertically while under the effect of vertical gravity.
;
; Gravity is just a fixed value that gets added to the player's speed.
; This causes the speed to gradually increase, making it go from negative (moving up)
; to positive (moving down), and since the speed dictates how much the player moves,
; the player will move slower at the peak of the jump.
;
; IN
; - HL: Gravity value
; - DE: Ptr to wOBJInfo
; OUT
; - C flag: If set, we touched the ground.
OBJLstS_ApplyGravityVAndMoveHV:
	push bc
		; BC = Gravity value
		push hl
		pop  bc

		push de

			;
			; Update the vertical movement speed.
			;

			; DE = HL = Ptr to Y speed
			ld   hl, iOBJInfo_SpeedY
			add  hl, de
			push hl
			pop  de

			; HL = SpeedY + Gravity
			push de
				ld   a, [de]	; H = iOBJInfo_SpeedY
				ld   h, a
				inc  de
				ld   a, [de]	; L = iOBJInfo_SpeedYSub
				ld   l, a
				add  hl, bc		; += Gravity
			pop  de

			; Write back the updated speed
			push de
				ld   a, h		; iOBJInfo_SpeedY = H
				ld   [de], a
				inc  de
				ld   a, l		; iOBJInfo_SpeedYSub = L
				ld   [de], a
			pop  de

			;
			; Apply the newly updated speed to the player's Y position.
			;

			push hl	; Save Y Speed
				; DE = Ptr to Y Position
				dec  de		; iOBJInfo_SpeedXSub
				dec  de		; iOBJInfo_SpeedX
				dec  de		; iOBJInfo_YSub
				dec  de		; iOBJInfo_Y

				; Y += SpeedY
				push de
					ld   a, [de]	; B = iOBJInfo_Y
					ld   b, a
					inc  de
					ld   a, [de]	; C = iOBJInfo_YSub
					ld   c, a
					add  hl, bc		; += SpeedY
				pop  de

				; Write back the updated Y position
				ld   a, h		; iOBJInfo_Y = H
				ld   [de], a
				inc  de			; Seek to iOBJInfo_YSub
				ld   a, l		; iOBJInfo_YSub = L
				ld   [de], a
			pop  hl	; Restore Y Speed

			;
			; Validate the new Y position.
			; We always want to be above the ground, and not underflow it.
			;

			bit  7, h				; MSB set? (YSpeed < 0)
			jp   z, .chkMoveDown	; If not, jump
		.chkMoveUp:
			;
			; When moving up, prevent underflowing the Y position.
			; If it did, snap it back to the topmost position.
			;
			dec  de				; Seek back to iOBJInfo_Y
			ld   a, [de]
			bit  7, a			; iOBJInfo_Y < 0? (MSB set)
			jp   z, .moveOk		; If so, jump
			; Otherwise, force it back to $0000
			xor  a
			ld   [de], a		; iOBJInfo_Y = 0
			inc  de
			ld   [de], a		; iOBJInfo_YSub = 0
			jp   .moveOk
		.chkMoveDown:
			;
			; When moving down, prevent moving below the floor.
			; If we are, snap back to it and signal that we've touched the ground.
			;
			dec  de
			ld   a, [de]
			cp   PL_FLOOR_POS	; iOBJInfo_Y < $88?
			jp   c, .moveOk		; If so, jump (we're above the ground)

		.jumpEnd:
		pop  de
	pop  bc
	; Otherwise, force the player to be on the ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS	; iOBJInfo_Y = $88
	inc  hl
	xor  a			; iOBJInfo_YSub = 0
	ldi  [hl], a
	; And reset the Y speed
	inc  hl
	inc  hl
	ldi  [hl], a	; iOBJInfo_SpeedY = 0
	ldi  [hl], a	; iOBJInfo_SpeedYSub = 0
	; Not necessary
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	res  PF0B_AIR, [hl]
	scf			; C flag set
	ret

		.moveOk:
		pop  de
	pop  bc
	; Move horizontally as well
	call OBJLstS_ApplyXSpeed
	xor  a		; C flag clear
	ret

; =============== OBJLstS_ApplyGravityVAndMoveV ===============
; Moves the sprite vertically while under the effect of vertical gravity.
;
; Exactly like OBJLstS_ApplyGravityVAndMoveHV, but without moving horizontally.
;
; IN
; - HL: Gravity value
; - DE: Ptr to wOBJInfo
; OUT
; - C flag: If set, we touched the ground.
OBJLstS_ApplyGravityVAndMoveV:
	push bc
		; BC = Gravity value
		push hl
		pop  bc

		push de

			;
			; Update the vertical movement speed.
			;

			; DE = HL = Ptr to Y speed
			ld   hl, iOBJInfo_SpeedY
			add  hl, de
			push hl
			pop  de

			; HL = SpeedY + Gravity
			push de
				ld   a, [de]	; H = iOBJInfo_SpeedY
				ld   h, a
				inc  de
				ld   a, [de]	; L = iOBJInfo_SpeedYSub
				ld   l, a
				add  hl, bc		; += Gravity
			pop  de

			; Write back the updated speed
			push de
				ld   a, h		; iOBJInfo_SpeedY = H
				ld   [de], a
				inc  de
				ld   a, l		; iOBJInfo_SpeedYSub = L
				ld   [de], a
			pop  de

			;
			; Apply the newly updated speed to the player's Y position.
			;

			push hl	; Save Y Speed
				; DE = Ptr to Y Position
				dec  de		; iOBJInfo_SpeedXSub
				dec  de		; iOBJInfo_SpeedX
				dec  de		; iOBJInfo_YSub
				dec  de		; iOBJInfo_Y

				; Y += SpeedY
				push de
					ld   a, [de]	; B = iOBJInfo_Y
					ld   b, a
					inc  de
					ld   a, [de]	; C = iOBJInfo_YSub
					ld   c, a
					add  hl, bc		; += SpeedY
				pop  de

				; Write back the updated Y position
				ld   a, h		; iOBJInfo_Y = H
				ld   [de], a
				inc  de			; Seek to iOBJInfo_YSub
				ld   a, l		; iOBJInfo_YSub = L
				ld   [de], a
			pop  hl	; Restore Y Speed

			;
			; Validate the new Y position.
			; We always want to be above the ground, and not underflow it.
			;

			bit  7, h				; MSB set? (YSpeed < 0)
			jp   z, .chkMoveDown	; If not, jump
		.chkMoveUp:
			;
			; When moving up, prevent underflowing the Y position.
			; If it did, snap it back to the topmost position.
			;
			dec  de				; Seek back to iOBJInfo_Y
			ld   a, [de]
			bit  7, a			; iOBJInfo_Y < 0? (MSB set)
			jp   z, .moveOk		; If so, jump
			; Otherwise, force it back to $0000
			xor  a
			ld   [de], a		; iOBJInfo_Y = 0
			inc  de
			ld   [de], a		; iOBJInfo_YSub = 0
			jp   .moveOk
		.chkMoveDown:
			;
			; When moving down, prevent moving below the floor.
			; If we are, snap back to it and signal that we've touched the ground.
			;
			dec  de
			ld   a, [de]
			cp   PL_FLOOR_POS	; iOBJInfo_Y < $88?
			jp   c, .moveOk		; If so, jump (we're above the ground)

		.jumpEnd:
		pop  de
	pop  bc
	; Otherwise, force the player to be on the ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS	; iOBJInfo_Y = $88
	inc  hl
	xor  a			; iOBJInfo_YSub = 0
	ldi  [hl], a
	; And reset the Y speed
	inc  hl
	inc  hl
	ldi  [hl], a	; iOBJInfo_SpeedY = 0
	ldi  [hl], a	; iOBJInfo_SpeedYSub = 0
	scf			; C flag set
	ret

		.moveOk:
		pop  de
	pop  bc
	xor  a		; C flag clear
	ret
	
; =============== MoveInputS_CanStartSpecialMove ===============
; Validates if it's possible to perform a new special move.
; This also returns if we're on the ground.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C flag: If set, validation failed
MoveInputS_CanStartSpecialMove:
	;
	; If a special move is being executed already (PF0_SPECMOVE set), don't allow executing a new one
	;
	ld   hl, iPlInfo_Flags0
	add  hl, bc				; Seek to iPlInfo_Flags0
	bit  PF0B_SPECMOVE, [hl]	; Is the bit set?
	jp   nz, .retNoMove		; If so, return
	
	
	ld   hl, iPlInfo_Flags1
	add  hl, bc				; Seek to iPlInfo_Flags1
	
	;
	; If the player is in a damage string, no special moves can be input...
	; ...except when blocking, as it's possible to cancel blockstun.
	; Note that all of the guard cancel validation already happened
	; by the time we get here.
	;
	bit  PF1B_GUARD, [hl]
	jp   nz, .chkMoveId
	bit  PF1B_HITRECV, [hl]
	jp   nz, .retNoMove
.chkMoveId:

	;
	; Can't cancel throws into specials.
	;
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_THROW_G
	jp   z, .retNoMove
	cp   MOVE_SHARED_THROW_A
	jp   z, .retNoMove
.retOk:
	xor  a	; No carry
	ret  
.retNoMove:
	scf  	; Set carry
	ret
	
; =============== MoveInputS_SetSpecMove_StopSpeed ===============
; Makes the specified player start a new special or super move.
; Most special moves use this subroutine to start them, and as a result
; of using Pl_SetMove_StopSpeed, they cancel the player's momentum.
; IN
; - A: Move ID
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
MoveInputS_SetSpecMove_StopSpeed:
	; Force syncronize the player's direction before starting the move
	call OBJLstS_SyncXFlip

	; HL = Ptr to status flag
	ld   hl, iPlInfo_Flags0
	add  hl, bc

	;
	; Only move $80 is flagged as a super move in this game.
	;
	cp   MOVE_SHARED_SUPER		; MoveId != $80?
	jp   nz, .setFlags			; If so, skip
	set  PF0B_SUPERMOVE, [hl]

.setFlags:
	;
	; Set all of the default flags for starting a move.
	;

	; iPlInfo_Flags0
	; Mark that a special move is in progress.
	set  PF0B_SPECMOVE, [hl]

	inc  hl			; Seek to iPlInfo_Flags1
	set  PF1B_NOBASICINPUT, [hl] 	; Special moves can't be cancelled by normal movement
	set  PF1B_XFLIPLOCK, [hl] 		; Lock the player's direction until the move is over
	set  PF1B_NOSPECSTART, [hl] 	; For consistency (PF0B_SPECMOVE takes care of this already)
	res  PF1B_GUARD, [hl]			; Receive full damage by default if hit out of the special
	res  PF1B_CROUCH, [hl]			; Remove crouch flag in case we performed the move while crouching
	res  PF1B_INVULN, [hl] 			; Disable invulnerability in case we got here from guard cancels

	;
	; Actually start the move, stopping the player momentum
	;
	push hl
		call Pl_SetMove_StopSpeed
	pop  hl

	;
	; If we started a new move off another hit, set the initial animation speed to be as fast as possible.
	;
	bit  PF1B_ALLOWHITCANCEL, [hl]	; Did we combo the move off a previous hit?
	jp   z, .ret					; If not, return
	; Force GFX load for the new frame even during hitstop
	inc  hl
	set  PF2B_NODAMAGERATE, [hl]
	; Animate it very fast
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], $01 ; iOBJInfo_FrameLeft
	inc  hl
	ld   [hl], $01 ; iOBJInfo_FrameTotal
.ret:
	ret
	
; =============== Play_Pl_SetMoveDamage ===============
; Instantly changes the damage values, without waiting for the next frame to display.
; This is meant to be used to update the damage mid-animation, not when the move starts
; as that's handled by Pl_SetNewMove.
; IN
; - H: Damage amount
; - L: Hit effect ID (HITTYPE_*)
; - A: Damage flags
; - BC: Ptr to wPlInfo
Play_Pl_SetMoveDamage:
	push de
		; DE = HL
		push hl
		pop  de
		; BC = Ptr to start of current move damage info
		ld   hl, iPlInfo_MoveDamageVal
		add  hl, bc
		; Copy the data over
		ld   [hl], d	; iPlInfo_MoveDamageVal = D
		inc  hl
		ld   [hl], e	; iPlInfo_MoveDamageHitTypeId = E
		inc  hl
		ld   [hl], a	; iPlInfo_MoveDamageFlags3 = A
	pop  de
	ret

; =============== Play_Pl_SetMoveDamageNext ===============
; Updates the pending damage values, which get applied when the next frame is displayed.
; This works in conjunction with the VBlank Handler, since that's what copies the
; iPlInfo_MoveDamage*Next fields to iPlInfo_MoveDamage*.
;
; Because iPlInfo_MoveDamageValNext gets cleared when it gets applied, and the VBlank Handler
; detects if there's any pending value by checking iPlInfo_MoveDamageValNext != 0, the
; amount of damage specified *MUST* be > 0.
; To erase the damage, either call Play_Pl_SetMoveDamage manually or wait for
; a new move to be set, since Pl_SetNewMove zeroes out all damage-related fields
; in preparation of the move code setting new ones through Play_Pl_IsMoveLoading.
;
; This is meant to be used to update the damage mid-animation, not when the move starts
; as that's handled by Pl_SetNewMove.
;
; This is one of the two subroutines used to update the damage mid-animation,
; and by using this one VBlankHandler will apply the changes.
; IN
; - H: Damage amount
; - L: Hit effect ID (HITTYPE_*)
; - A: Damage flags
; - BC: Ptr to wPlInfo
Play_Pl_SetMoveDamageNext:
	push de
		; DE = HL
		push hl
		pop  de
		; BC = Ptr to start of pending move damage info
		ld   hl, iPlInfo_MoveDamageValNext
		add  hl, bc
		; Copy the data over
		ld   [hl], d	; iPlInfo_MoveDamageValNext = D
		inc  hl
		ld   [hl], e	; iPlInfo_MoveDamageHitTypeIdNext = E
		inc  hl
		ld   [hl], a	; iPlInfo_MoveDamageFlags3Next = A
	pop  de
	ret

; =============== Play_Proj_CopyMoveDamageFromPl ===============
; Copies the pending move damage fields from the current player over to its respective projectile.
; Typically called after mMvC_SetDamageNext.
;
; This is called for moves where the projectile is what deals damage --
; which includes actual projectiles and special effects that are animated independently from the player (see: Power Geyser).
;
; This is needed because the game only copies the damage info from MoveAnimTbl_* to
; the player when starting a new move, even when it's meant for projectiles.
; Moves that call this use animation frames/sprite mappings for the player that don't
; have an hitbox set, preventing the same damage from being also dealt physically.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
Play_Proj_CopyMoveDamageFromPl:
	push bc
		; Copy over the three bytes.
		; This works because the move damage fields are stored contiguously
		; in the same order between player and projectile info.

		; BC = Ptr to source
		ld   hl, iPlInfo_MoveDamageValNext
		add  hl, bc
		push hl
		pop  bc

		; DE = Ptr to destination
		; The OBJInfo for the projectile is always 2 slots ahead
		; of one used by its respective player.
		ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Play_DamageVal
		add  hl, de

		; Copy the data over
		ld   a, [bc]	; Read iPlInfo_MoveDamageValNext
		inc  bc
		ldi  [hl], a	; Copy to iOBJInfo_Play_DamageVal
		ld   a, [bc]	; Read iPlInfo_MoveDamageHitTypeIdNext
		inc  bc
		ldi  [hl], a	; Copy to iOBJInfo_Play_DamageHitTypeId
		ld   a, [bc]	; Read iPlInfo_MoveDamageFlags3Next
		ld   [hl], a	; Copy to iOBJInfo_Play_DamageFlags3
	pop  bc
	ret

; =============== Play_Pl_IsMoveLoading ===============
; Checks if the move is "ready", which is when move-specific code is allowed to run (as checked manually in many MoveC_*).
;
; This also has the secondary purpose of updating the move damage field as soon as the move
; is detected to be ready. It will only happen once, the first frame the move is ready.
;
; See also: VBlankHandler, which does the same thing only if a move *wasn't* started this frame.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, move isn't ready yet.
Play_Pl_IsMoveLoading:

	;--
	;
	; Verify that the visible and pending sprite mapping table pointers are identical.
	; If they aren't, the move isn't ready, since it means the move animation
	; was recently changed (ie: new move) but the graphics for them haven't been
	; fully loaded yet.
	;
	; This is the equivalent of checking (PF2B_MOVESTART && !OSTB_GFXLOAD),
	; so why wasn't it done that way?
	;
	push de
		push bc
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   b, [hl]		; B = iOBJInfo_BankNum
			inc  hl
			ld   c, [hl]		; C = iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   d, [hl]		; D = iOBJInfo_OBJLstPtrTbl_High
			inc  hl				; Seek to iOBJInfo_OBJLstPtrTblOffset
			inc  hl				; Seek to iOBJInfo_BankNumView
			ldi  a, [hl]
			cp   a, b			; iOBJInfo_BankNumView == iOBJInfo_BankNum?
			jr   nz, .retNotReadyPop	; If not, return
			ldi  a, [hl]
			cp   a, c			; iOBJInfo_OBJLstPtrTbl_LowView == iOBJInfo_OBJLstPtrTbl_Low?
			jr   nz, .retNotReadyPop	; If not, return
			ldi  a, [hl]
			cp   a, d			; iOBJInfo_OBJLstPtrTbl_HighView == iOBJInfo_OBJLstPtrTbl_High?
			jr   nz, .retNotReadyPop	; If not, return
		pop  bc
	pop  de
	;--

	; If we didn't start a new move and the above check passed, then it means we're ready
	; but we shouldn't update the move damage info since we've already done it.
	ld   hl, iPlInfo_Flags2
	add  hl, bc
	bit  PF2B_MOVESTART, [hl]
	jr   z, .retReady

	; If the graphics are loading and all previous validations passed, it means the first
	; frame is still loading, therefore the move isn't ready yet.
	ld   hl, iOBJInfo_Status
	add  hl, de
	bit  OSTB_GFXLOAD, [hl]
	jp   nz, .retNotReady

	;--

	; If we got here, the first frame has just loaded, so we can update the move damage fields
	; as long as they've been set.
	;
	; The previous validation is all there because the move damage fields come from the MoveAnimTbl table,
	; meaning they are associated with a specific move animation.
	; As the animation won't start until the graphics for the first frame are loaded,
	; (it will wait on the last visible frame), wait for that first before copying the
	; fields over from their pending slots.
	; This avoids having the old frame visible with the new damage settings applied.

	;--

	; Unmark that we're starting a new move.
	; This allows the VBlank Handler to perform mid-move damage changes between frames,
	; and cuts off getting here another time until another move is started.
	ld   hl, iPlInfo_Flags2
	add  hl, bc
	res  PF2B_MOVESTART, [hl]

	;
	; Copy the set of pending fields to the current ones, and clear the former range.
	;
	; This avoids updating the move damage when set to 0, as there's no point to update
	; the fields when damage was already initialized to 0 when we went though Pl_SetNewMove.
	;

	; HL = Source
	ld   hl, iPlInfo_MoveDamageValNext
	add  hl, bc
	ld   a, [hl]		; A = iPlInfo_MoveDamageValNext
	or   a				; iPlInfo_MoveDamageValNext == 0?
	jp   z, .retReady	; If so, skip

	;
	; Copy over the pending move damage info to the current one.
	;
	push de
		; DE = Destination
		push hl
			ld   hl, iPlInfo_MoveDamageVal
			add  hl, bc
			push hl
			pop  de
		pop  hl

		ld   [de], a	; Copy iPlInfo_MoveDamageValNext to iPlInfo_MoveDamageVal
		ld   [hl], $00	; Clear iPlInfo_MoveDamageValNext
		inc  de			; SrcPtr++
		inc  hl			; DestPtr++

		ld   a, [hl]	; A = iPlInfo_MoveDamageHitTypeIdNext
		ld   [de], a	; Copy iPlInfo_MoveDamageHitTypeIdNext to iPlInfo_MoveDamageHitTypeId
		ld   [hl], $00	; Clear iPlInfo_MoveDamageHitTypeIdNext
		inc  de			; SrcPtr++
		inc  hl			; DestPtr++

		ld   a, [hl]	; A = iPlInfo_MoveDamageFlags3Next
		ld   [de], a	; Copy iPlInfo_MoveDamageFlags3Next to iPlInfo_MoveDamageFlags3
		ld   [hl], $00	; Clear iPlInfo_MoveDamageFlags3Next
	pop  de
.retReady:
	or   a	; C flag clear
	ret
		.retNotReadyPop:
		pop  bc
	pop  de
.retNotReady:
	scf		; C flag set
	ret

; =============== Play_Pl_ChkThrowInput ===============
; Handles the input for throwing the opponent.
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - A: wPlayPlThrowOpMode value, if a throw was started
; - C flag: If set, a throw was started
Play_Pl_ChkThrowInput:

	;--
	;
	; Validate if we can start the throw to begin with
	;

	; Not applicable if we're getting thrown
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_NONE		; ThrowActId == 0?
	jp   nz, .retClear			; If not, return

	; Not applicable when the opponent is waking up
	ld   hl, iPlInfo_NoThrowTimerOther
	add  hl, bc
	ld   a, [hl]
	or   a						; iPlInfo_NoThrowTimerOther > 0?
	jp   nz, .retClear			; If so, return
	
	;
	; Check for the throw input.
	;
	; Normal input:             HP/HK + L/R
	; For KYO, KENSOU and IORI: HP    + L/R
	;
	push de
		ld   d, KEP_A_HEAVY|KEP_B_HEAVY	; D = Normal button input
		
		ld   hl, iPlInfo_CharId
		add  hl, bc
		ld   a, [hl]				; A = CharId
		cp   CHAR_ID_KYO			; Playing as KYO?
		jp   z, .hpOnly				; If so, jump
		cp   CHAR_ID_KENSOU			; ...
		jp   z, .hpOnly
		cp   CHAR_ID_IORI
		jp   z, .hpOnly
		jp   .chkInpt				; Otherwise, keep the normal input
	.unused_hkOnly:
		ld   d, KEP_A_HEAVY			; [TCRF] No character uses this.
		jp   .chkInpt
	.hpOnly:
		ld   d, KEP_B_HEAVY			; D = Punch-only input
	.chkInpt:
	
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc

		; Must be holding Left or Right
		; E = iPlInfo_JoyKeys & (KEY_RIGHT|KEY_LEFT)
		ld   a, [hl]
		and  a, KEY_RIGHT|KEY_LEFT ; Filter L/R keys
		jp   z, .noPk		; Any of them held? If not, return
		ld   e, a			; Save L/R keys

		; Must be an heavy attack, with the previously set keys on D
		; A = iPlInfo_JoyNewKeysLH & D
		inc  hl				; Seek to iPlInfo_JoyNewKeysLH
		ld   a, [hl]
		and  a, d			; Filter out non-heavy flags
		jp   z, .noPk		; Any heavy done? If not, return
		ld   a, e			; Restore L/R keys
	pop  de
	
	; Success.
	; We started the throw successfully, now determine its type.

	; Determine the throw's direction.
	; Holding forwards throws the opponent forwards.
	; Holding back throws the opponent backwards.
	bit  KEYB_RIGHT, a		; Holding right?
	jp   nz, .chkBackR		; If so, jump
.chkBackL:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Facing left? (SPRB_XFLIP clear)
	jp   z, .setThrowFwd	; If so, throw forwards
	jp   .setThrowBack		; Otherwise, throw backwards
.chkBackR:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Facing right? (SPRB_XFLIP set)
	jp   nz, .setThrowFwd	; If so, throw forwards
	jp   .setThrowBack		; Otherwise, throw backwards
.setThrowBack:
	xor  a ; PLAY_THROWDIR_B
	ld   [wPlayPlThrowDir], a
	jp   .chkAir
.setThrowFwd:
	ld   a, PLAY_THROWDIR_F
	ld   [wPlayPlThrowDir], a
.chkAir:

	; Determine if we're in the air or not
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_AIR, [hl]	; Are we in the air?
	jp   nz, .air	; If so, jump
	jp   .ground
	
	.noPk:
	pop  de
	jp   .retClear
.ground:

	; When crouching or performing moves not allowing basic movement, throwing will be ignored.
	inc  hl							; Seek to iPlInfo_Flags1
	bit  PF1B_NOBASICINPUT, [hl]	; Is basic input denied?
	jp   nz, .noThrow				; If so, return
	bit  PF1B_CROUCH, [hl] 			; Crouching?
	jp   nz, .noThrow				; If so, return

.groundOk:

	; Set ground throw type
	xor  a ; PLAY_THROWOP_GROUND
	ld   [wPlayPlThrowOpMode], a
	; Set temporary hitbox $04 for throw range, overriding whatever hitbox is set by the visible frame.
	ld   a, COLIBOX_04
	jp   .tryStart
.air:
	; Only when performing a jump move
	ld   hl, iPlInfo_MoveId
	add  hl, bc				; Seek to iPlInfo_MoveId
	ld   a, [hl]
	cp   MOVE_SHARED_JUMP_N
	jp   z, .airChkChar
	cp   MOVE_SHARED_JUMP_F
	jp   z, .airChkChar
	cp   MOVE_SHARED_JUMP_B
	jp   z, .airChkChar
	jp   .noThrow
.airChkChar:
	; Only few characters can do air throws
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_BENIMARU	; Playing as BENIMARU?
	jp   z, .airOk			; If so, jump
	cp   CHAR_ID_YURI		; ...
	jp   z, .airOk
	cp   CHAR_ID_HEIDERN
	jp   z, .airOk
	cp   CHAR_ID_ATHENA
	jp   z, .airOk
	cp   CHAR_ID_MAI
	jp   z, .airOk
	jp   .noThrow			; Otherwise, return
.airOk:
	; Set air throw type
	ld   a, PLAY_THROWOP_AIR
	ld   [wPlayPlThrowOpMode], a
	; Set temporary hitbox $04, same as ground throws.
	ld   a, COLIBOX_04
	;--

.tryStart:

	;
	; Setup the throw, and see the opponent's response.
	;

	; Write the temporary hitbox, used to determine throw range.
	; This will be active for exactly one frame (see below).
	ld   hl, iOBJInfo_ForceHitboxId
	add  hl, de
	ld   [hl], a

	; Start the throw sequence, mandatory to let the other player know we're ready.
	ld   a, PLAY_THROWACT_START
	ld   [wPlayPlThrowActId], a

	; All throws do $0C lines of damage.
	; The damage is dealt when the opponent gets thrown at the *end*.
	; Meaning that if it gets aborted early, no damage is dealt.
	; Note that, in the MoveAnimTbl_* entries, the damage fields are all $00 anyway.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	ld   a, $0C						; 12 lines of damage
	ld   [hl], a

	; If the grab occurres, the opponent will use hit effect HITTYPE_GRAB_START (HitTypeC_GrabStart)
	inc  hl							; Seek to iPlInfo_MoveDamageHitTypeId
	ld   a, HITTYPE_GRAB_START
	ld   [hl], a					; Save value

	; Pass control once with the throw hitbox enabled (+ an extra one to disable it)
	; and determine if the opponent got grabbed successfully (in range + passed validation).
	;
	; If it went all right, the opponent should have gone through Play_Pl_SetHitType.chkThrow
	; (which required us to set wPlayPlThrowActId to PLAY_THROWACT_START first), which will
	; cause the hit effect HitTypeC_GrabStart to update wPlayPlThrowActId to PLAY_THROWACT_NEXT02.

	; Preserve iPlInfo_JoyKeys and iPlInfo_JoyNewKeys while this happens
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ldi  a, [hl]
	push af				; Save iPlInfo_JoyKeys
		ld   a, [hl]
		push af			; Save iPlInfo_JoyNewKeys
			push hl
				;--
				; Pass control, activating the temporary throw hitbox
				call Task_PassControlFar

				; Disable the throw hitbox and save changes again
				ld   hl, iOBJInfo_ForceHitboxId
				add  hl, de
				xor  a
				ld   [hl], a
				call Task_PassControlFar
				;--
			pop  hl
		pop  af
		ldd  [hl], a	; Restore iPlInfo_JoyNewKeys
	pop  af
	ld   [hl], a	; Restore iPlInfo_JoyKeys

	; If the opponent didn't get grabbed, return
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_NEXT02		; On the second part of the throw?
	jp   nz, .noThrow				; If not, return

	;
	; Determine if the throw direction gets inverted
	;

	; Non-ground throws always get inverted
	ld   a, [wPlayPlThrowOpMode]
	or   a							; wPlayPlThrowOpMode != PLAY_THROWOP_GROUND?
	jp   nz, .invThrow				; If so, jump
	
	; A few characters have inverted throws.
	; Curiously, none of these survived into 96 so the actual comparisons are gone there,
	; but the part that gets the character ID was kept.
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_JOE
	jp   z, .invThrow
	cp   CHAR_ID_KENSOU
	jp   z, .invThrow
	cp   CHAR_ID_RUGAL
	jp   z, .invThrow
	cp   CHAR_ID_EIJI
	jp   z, .invThrow
	cp   CHAR_ID_NAKORURU
	jp   z, .invThrow
	
	; No inversion
	jp   .chkDir
.invThrow:
	ld   a, [wPlayPlThrowDir]
	xor  a, $01					; Switch PLAY_THROWDIR_F / PLAY_THROWDIR_B
	ld   [wPlayPlThrowDir], a

.chkDir:

	; If the opponent is being thrown "backwards", first switch the player's positions
	; before starting the normal throw.
	ld   a, [wPlayPlThrowDir]
	or   a 					; wPlayPlThrowDir == PLAY_THROWDIR_F
	jp   z, .retSet			; If so, skip
	; Switch X positions
	push bc
		ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
		ld   b, a							; B = 2P X
		ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; A = 1P X
		ld   [wOBJInfo_Pl2+iOBJInfo_X], a	; 2P X = A
		ld   a, b							; 1P X = B
		ld   [wOBJInfo_Pl1+iOBJInfo_X], a
	pop  bc
	; Invert direction for current player only. It doesn't matter to the opponent.
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	ld   a, [hl]
	xor  SPR_XFLIP
	ld   [hl], a
.retSet:
	ld   a, [wPlayPlThrowOpMode]
	scf		; Set carry flag
	jp   .ret
.noThrow:
	xor  a
	ld   [wPlayPlThrowActId], a
.retClear:
	xor  a	; Clear carry flag
.ret:
	ret
	
; =============== MoveInputS_TryStartCommandThrow_StdColi ===============
; Attempts to start a command throw that:
; - Uses collision box $04 as throw range
;   This is the same box used by normal throws to check for range.
; - Can't be done if the opponent is getting up
;
; See also: MoveInputS_TryStartCommandThrow_Coli05
;
; IN
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C: If set, the command throw can start
MoveInputS_TryStartCommandThrow_StdColi:
	; If a throw is in progress, return
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_NONE								; ThrowActId != NONE?
	jp   nz, MoveInputS_TryStartCommandThrow.noThrow	; If so, jump

	; If the opponent is waking up, return
	ld   hl, iPlInfo_NoThrowTimerOther
	add  hl, bc
	ld   a, [hl]
	or   a												; iPlInfo_NoThrowTimerOther != 0?
	jp   nz, MoveInputS_TryStartCommandThrow.noThrow	; If so, return

	; Throw forward
	xor  a ; PLAY_THROWDIR_F
	ld   [wPlayPlThrowDir], a
	; [POI] Doesn't matter. This is ignored for command throws
	xor  a ; PLAY_THROWOP_GROUND
	ld   [wPlayPlThrowOpMode], a

	; Use hitbox $04
	ld   a, COLIBOX_04
	; Fall-through

; =============== MoveInputS_TryStartCommandThrow ===============
; Attempts to starts a command throw.
; The code for this is identical to Play_Pl_ChkThrowInput.tryStart.
; IN
; - A: Collision box ID for throw range
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C: If set, the command throw can start
MoveInputS_TryStartCommandThrow:
	;
	; Setup the throw, and see the opponent's response.
	;

	; Write the temporary hitbox, used to determine throw range.
	; This will be active for exactly one frame (see below).
	ld   hl, iOBJInfo_ForceHitboxId
	add  hl, de
	ld   [hl], a

	; Start the throw sequence, mandatory to let the other player know we're ready.
	ld   a, PLAY_THROWACT_START
	ld   [wPlayPlThrowActId], a

	; All command throws do $0C lines of damage, like normal throws.
	; The damage is taken when the opponent gets thrown at the *end*.
	; Meaning that if it gets aborted early, no damage is dealt.
	; Note that, in the MoveAnimTbl_* entries, the damage fields are all $00 anyway.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	ld   a, $0C						; 12 lines of damage
	ld   [hl], a

	; If the grab occurres, the opponent will use hit effect HITTYPE_GRAB_START
	inc  hl							; Seek to iPlInfo_MoveDamageHitTypeId
	ld   a, HITTYPE_GRAB_START
	ld   [hl], a					; Save value

	; Pass control once with the throw hitbox enabled (+ an extra one to disable it)
	; and determine if the opponent got grabbed successfully (in range + passed validation).
	;
	; If it went all right, the opponent should have gone through Play_Pl_SetHitType.chkThrow
	; (which required us to set wPlayPlThrowActId to PLAY_THROWACT_START first), which will
	; cause the hit effect HitTypeC_GrabStart to update wPlayPlThrowActId to PLAY_THROWACT_NEXT02.

	; Preserve iPlInfo_JoyKeys and iPlInfo_JoyNewKeys while this happens
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ldi  a, [hl]
	push af				; Save iPlInfo_JoyKeys
		ld   a, [hl]
		push af			; Save iPlInfo_JoyNewKeys
			push hl
				;--
				; Pass control, activating the temporary throw hitbox
				call Task_PassControlFar

				; Disable the throw hitbox and save changes again
				ld   hl, iOBJInfo_ForceHitboxId
				add  hl, de
				xor  a
				ld   [hl], a
				call Task_PassControlFar
				;--
			pop  hl
		pop  af
		ldd  [hl], a	; Restore iPlInfo_JoyNewKeys
	pop  af
	ld   [hl], a	; Restore iPlInfo_JoyKeys

	; If the opponent didn't get grabbed, return
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_NEXT02		; On the second part of the throw?
	jp   nz, .noThrow				; If not, return

	;##

	; The move can start
	scf			; C flag set
	jp   .ret
.noThrow:
	; Can't start move
	; Also force the current throw to end
	xor  a
	ld   [wPlayPlThrowActId], a
.ret:
	ret
	
; =============== Play_Pl_ChkHitstop ===============
; Applies hitstop if enabled, as well as other effects induced by the other player.
;
; IN:
; - BC: Ptr to wPlInfo structure
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C: If set, a new move was started (and interrupted hitstop early)
Play_Pl_ChkHitstop:

	;
	; Handle the horizontal push speed we received from the other player.
	; Note that if we get into the hitstop loop, the movement gets delayed until
	; the hitstop ends.
	;

	; By default, don't push the other player.
	; The move code will take care of setting this as needed.
	ld   hl, iPlInfo_PushSpeedHReq
	add  hl, bc
	xor  a
	ld   [hl], a

	;
	; If the other player requested us to move out of the way (ie: after a hit when cornered)
	; do that accordingly.
	;
	ld   hl, iPlInfo_PushSpeedHRecv
	add  hl, bc
	ld   a, [hl]		; A = Received horz. push speed
	or   a				; PushSpeed == 0?
	jp   z, .chkHitstop	; If so, skip
	; Otherwise, push horizontally by iPlInfo_PushSpeedHRecv
	ld   h, a			; H = iPlInfo_PushSpeedHRecv
	ld   l, $00
	call Play_OBJLstS_MoveH

.chkHitstop:

	;
	; If hitstop is enabled, we get "frozen" until either:
	; - Hitstop naturally ends (see below)
	; - Getting guard cancelled
	; - "Canceling" hitstop to another special move.
	;   This also increases the combo counter in the opponent's Play_Pl_DoHit,
	;   as the other player task won't manage to execute it at least once before getting hit again.
	;   Note that Play_Pl_DoHit is part of the primary main loop (executed every frame) for player tasks
	;   since it's what handles getting hit, but on the frame that happens it will execute the hit
	;   animation code, which ends up calling hitstun/blockstun routines that take exclusive control,
	;   meaning Play_Pl_DoHit won't be executed for a number of frames.
	;
	; We also don't change the hitstop flag directly -- this is done ONLY by the other player task when it gets hit.
	; Specifically, the aforemented hitstuns/blockstun subroutines enable hitstop for the entire
	; duration of their shake effect (ie: see Play_Pl_DoBlockstun). Since they take exclusive control, only the
	; player who attacked can get here while hitstop is enabled.
	;
	ld   a, [wPlayHitstop]
	or   a				; Is hitstop enabled?
	jp   z, .noStart	; If not, return
.loop:
	; Generate the light/heavy button info
	call Play_Pl_CreateJoyKeysLH

	; Check for special move inputs (character-specific)
	call Play_Pl_ExecSpecMoveInputCode	; Was a special move started?
	jp   c, .moveSet				; If so, return
	; Guard cancel variant
	; If we get attacked, Play_Pl_DoHit will call an HitTypeC_* and take exclusive control for a bit.
	; In case of blocking, we can start a new special move (or a roll) when guard canceling.
	call Play_Pl_DoHit				; Did we get attacked and guard cancelled?
	jp   c, .moveSet				; If so, return

	call Task_PassControlFar

	; If still locked, loop
	ld   a, [wPlayHitstop]
	or   a					; Is hitstop still enabled?
	jp   nz, .loop			; If so, loop
.noStart:
	xor  a	; C flag was clear
	ret
.moveSet:
	ret		; C flag was set
	
; =============== Play_Pl_GiveKnockbackCornered ===============
; Pushes the other player away when hit while cornered.
;
; This replaces any existing pushback from overlapping collision boxes, and it's what
; causes players to get pushed away when hitting a cornered opponent.
;
; The reasoning behind this is that the game tries to push players away
; by a certain distance when recovering from an attack.
; Normally, the player that gets hit receives a knockback, but if cornered,
; this subroutine gives that knockback to the other player.
;
; IN:
; - BC: Ptr to wPlInfo for the player who got hit
; - DE: Ptr to respective wOBJInfo structure
Play_Pl_GiveKnockbackCornered:

	;
	; Knockback transfer isn't applicable if we got hit by a projectile,
	; as the player could be anywhere on the screen.
	;
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_PROJHIT, [hl]		; Is the flag set?
	jp   nz, .ret				; If so, return

	; Copy iOBJInfo_RangeMoveAmount to iPlInfo_PushSpeedHReq.
	;
	; iOBJInfo_RangeMoveAmount is set when the knockback attempts to move us off-screen.
	; The game doesn't want that, so we get pushed back to the visible screen range, and
	; how much we were moved is saved to iOBJInfo_RangeMoveAmount.
	; That is essentially the knockback we would have received in the frame, and as we can't move
	; any further, we instead push the other player by that amount.
	ld   hl, iOBJInfo_RangeMoveAmount
	add  hl, de						; Seek to iOBJInfo_RangeMoveAmount
	ld   a, [hl]					; A = iOBJInfo_RangeMoveAmount
	ld   hl, iPlInfo_PushSpeedHReq
	add  hl, bc						; Seek to iPlInfo_PushSpeedHReq
	ld   [hl], a					; iPlInfo_PushSpeedHReq = A
.ret:
	ret
	
; =============== Play_Pl_DoHitstun ===============
; Generic hitstun handler that doesn't allow guard cancels.
;
; Handles the effect for the player shaking when coming in contact with an hit.
; This can happen both when blocking the attack or getting hit.
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo structure
; OUT
; - C flag: Always clear, as there's no guard cancel.
;           Return value required by Play_Pl_DoBlockstun jumping to here.
Play_Pl_DoHitstun:

	;
	; If we haven't been hit by a projectile, mark that we received a physical hit
	; and enable hitstop to the opponent.
	;
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_PROJHIT, [hl]			; Did we get hit by a projectile?
	jp   nz, .go					; If so, skip
	; Enable opponent hitstop next frame
	ld   a, $01
	ld   [wPlayHitstopSet], a
	; Remove the physical damage source next frame.
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], a

.go:

	;
	; Shake the player by 1px for the required amount of frames.
	; While this happens, the player is completely blocked and input is ignored.
	;

	; Save iPlInfo_Flags1 value
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   a, [hl]
	push af
		;--
		; Can't be hit during blockstun
		set  PF1B_INVULN, [hl]
		
		; =============== Play_Pl_GetShakeCount ===============
		; Determines how many times to shake the player after receiving/blocking an hit.
		; Extracted to Play_Pl_GetShakeCount in 96. 
		; IN:
		; - BC: Ptr to wPlInfo
		; OUT
		; - A: How many times to perform the effect.
		;      Multiply it by 2 to get the number of frames the shake lasts.
		
	.chkHealth:
		;
		; If the player has no health left, always perform the effect $0C times.
		;
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a				; Health == 0?
		jp   z, .base0C		; If so, jump
		
		;
		; By default, shake the player 8 times.
		; If we didn't get hit by a projectile, add 2 more.
		;
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		bit  PF0B_PROJHIT, [hl]	; Did we get hit by a projectile?
		jp   nz, .base08		; If so, jump
	.base0A:
		ld   a, $08+$02			; ShakeCnt = $0A
		jp   .chkSuper
	.base08:
		ld   a, $08				; ShakeCnt = $08
	.chkSuper:
	
	;
	; The shake count can be affected by the move we got attacked with.
	;

		ld   hl, iPlInfo_Flags3
		add  hl, bc
		; Heavy ones *don't* halve the amount of shakes
		bit  PF3B_HEAVYHIT, [hl]
		jp   nz, .shakeSet
	.shakeHalf:
		srl  a					; ShakeCnt = ShakeCnt / 2
		jp   .shakeSet
	.base0C:
		ld   a, $0C				; ShakeCnt = $08
	.shakeSet:
		; ==============================
	
		; =============== Play_Pl_ShakeFor ===============
		; Shakes the player sprite by 1px for the specified amount of frames,
		; by moving back and forth the sprite horizontally.
		;
		; This takes control for the entire duration of the normal blockstun.
		; As this ignores player input, it should't be used when the player
		; is allowed to guard cancel.
		;
		; Extracted to Play_Pl_ShakeFor in 96.
		;
		; IN:
		; - A: Number of frames (*2) the effect is performed
		; - DE: Ptr to wOBJInfo for the player
	.shakeFor:
		push bc
			;
			; Set up the variables
			;
			ld   b, a			; B = Loop count
			ld   hl, iOBJInfo_X
			add  hl, de			; HL = Ptr to iOBJInfo_X

			;
			; If the player is facing right (1P side, with SPRB_XFLIP),
			; move the sprite 1px to the right, then move it back.
			;
		.shakeR:
			
			ld   a, +$01				; Move right 1px
			add  a, [hl]
			ld   [hl], a				
			call Task_PassControlFar	; Wait next frame
			ld   a, -$01				; Move left 1px
			add  a, [hl]
			ld   [hl], a
			call Task_PassControlFar	; Wait next frame
			dec  b						; Are we done?
			jp   nz, .shakeR			; If not, loop
										; Otherwise, we're done				
		pop  bc
		; ==============================
	pop  af
	; Restore iPlInfo_Flags1 and disable opponent hitstop
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   [hl], a
	ld   a, $00
	ld   [wPlayHitstopSet], a
	ret
	
; =============== Play_Pl_DoHitstunOnce ===============
; Performs the normal hit shake effect once, for two frames.
; For physical hits only.
; IN:
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo structure
Play_Pl_DoHitstunOnce:
	; Always enable hitstop to the opponent while this happens,
	; since this is only called for physical hits.
	ld   a, $01
	ld   [wPlayHitstopSet], a

	; Mark that the other player attempted to hit us with a physical move,
	; to remove the damage source next frame.
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], a

	;
	; Shake the player for 2 frames.
	;

	; Save flags
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   a, [hl]
	push af
		; Can't be hit while this happens, as usual for blockstun
		set  PF1B_INVULN, [hl]
		; Perform effect
		ld   a, $01				; 1(*2) frames
		; =============== Play_Pl_ShakeFor ===============
		; Shakes the player sprite by 1px for the specified amount of frames,
		; by moving back and forth the sprite horizontally.
		;
		; This takes control for the entire duration of the normal blockstun.
		; As this ignores player input, it should't be used when the player
		; is allowed to guard cancel.
		;
		; Extracted to Play_Pl_ShakeFor in 96.
		;
		; IN:
		; - A: Number of frames (*2) the effect is performed
		; - DE: Ptr to wOBJInfo for the player
	.shakeFor:
		push bc
			;
			; Set up the variables
			;
			ld   b, a			; B = Loop count
			ld   hl, iOBJInfo_X
			add  hl, de			; HL = Ptr to iOBJInfo_X

			;
			; If the player is facing right (1P side, with SPRB_XFLIP),
			; move the sprite 1px to the right, then move it back.
			;
		.shakeR:
			
			ld   a, +$01				; Move right 1px
			add  a, [hl]
			ld   [hl], a				
			call Task_PassControlFar	; Wait next frame
			ld   a, -$01				; Move left 1px
			add  a, [hl]
			ld   [hl], a
			call Task_PassControlFar	; Wait next frame
			dec  b						; Are we done?
			jp   nz, .shakeR			; If not, loop
										; Otherwise, we're done				
		pop  bc
		; ==============================
	pop  af
	; Restore flags
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   [hl], a

	; Disable opponent hitstop next frame
	ld   a, $00
	ld   [wPlayHitstopSet], a
	ret
	
; =============== Play_Pl_DoGroundScreenShake ===============
; Shakes the playfield vertically based on the specified OBJInfo animation timer.
; The shaken player MUST be on the ground to use this, while
; the other player is left unchanged and can be anywhere.
;
; This is mostly used to make an hitstun'd player and the screen shake when
; being thrown on the ground by certain super moves (ie: Daimon's super throw).
;
; IN:
; - DE: Ptr to wOBJInfo for player
Play_Pl_DoGroundScreenShake:

	;
	; Don't do anything other than forcing the player at ground level if
	; the player graphics (for the next frame) are being copied to VRAM.
	; Otherwise there would be an issue with the way the earthquake effect
	; is disabled (guarded by a mMvC_ValFrameEnd ).
	;
	call OBJLstS_IsGFXLoadDone	; Loading finished?
	jp   nz, .resetGround		; If not, skip

	;
	; The shake effect uses a gradual offset that fades out over time:
	; Offset = -(iOBJInfo_FrameLeft % $10)
	;
	; When the offset is decremented from 0, it returns to $0F.
	;
	; Alternating between every 2 frames, said offset gets added to one value,
	; and the other gets reset to default.
	;

	; When (iOBJInfo_FrameLeft % $10) becomes 0, both values are essentially reset to default.
	; Continue to .resetGround to save time and make sure both values are reset properly.
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]		; A = iOBJInfo_FrameLeft
	and  a, $0F			; FrameLeft & $0F == 0?
	jp   nz, .setShake	; If not, jump

.resetGround:
	; Reset the Y screen offset at normal levels
	ld   hl, wScreenShakeY
	ld   [hl], $00		; wScreenShakeY = 0

	; Reset player vertical position to ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS		; iOBJInfo_Y = $88
	jp   .ret
.setShake:

	;
	; This will be called for at most $0F frames continuously.
	; Alternate between offsetting/resetting wScreenShakeY and iOBJInfo_Y every 2 frames,
	;
	ld   hl, wScreenShakeY		; HL = iOBJInfo_FrameLeft
	bit  1, a					; iOBJInfo_FrameLeft & $02 != 0?
	jp   nz, .setShakeScrn		; If so, jump

.setShakeOBJ:
	; Reset the screen scroll offset
	; wScreenShakeY = $00
	ld   [hl], $00

	; Move player sprite up by A
	; iOBJInfo_Y -= A
	ld   hl, iOBJInfo_Y
	add  hl, de		; HL = Ptr to iOBJInfo_Y
	cpl				; A = -A
	inc  a
	add  a, [hl]	; A += iOBJInfo_Y
	ld   [hl], a	; Save it back
	jp   .ret

.setShakeScrn:

	; Scroll screen up by A
	; wScreenShakeY = -A
	push af
		cpl				; A = -A
		inc  a
		ld   [hl], a	; wScreenShakeY = A
	pop  af

	; Reset player sprite to ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS
.ret:
	ret
	
; =============== Play_Pl_DoBlockstun ===============
; Main handler for blockstun.
; IN:
; - BC: Ptr to wPlInfo
; OUT:
; - C flag: If set, blockstun ended early as a new move was started
;           (ie: guard cancel happened)
Play_Pl_DoBlockstun:

	; (in 96, this code is executed only at max power, it jumps to the hitstun code otherwise)

	;
	; If we haven't been hit by a projectile, mark that we received a physical hit
	; and enable hitstop to the opponent from the next frame.
	;
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_PROJHIT, [hl]				; Did we get hit by a projectile?
	jp   nz, .setFlags1					; If so, skip
	; Enable (opponent) hitstop next frame
	ld   a, $01
	ld   [wPlayHitstopSet], a
	; Remove the physical damage source next frame.
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], a

.setFlags1:
	; Save flags
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   a, [hl]
	push af
		; Can't be hit during blockstun
		set  PF1B_INVULN, [hl]
		
		; =============== Play_Pl_GetShakeCount ===============
		; Determines how many times to shake the player after receiving/blocking an hit.
		; Extracted to Play_Pl_GetShakeCount in 96. 
		; IN:
		; - BC: Ptr to wPlInfo
		; OUT
		; - A: How many times to perform the effect.
		;      Multiply it by 2 to get the number of frames the shake lasts.
		
	.chkHealth:
		;
		; If the player has no health left, always perform the effect $0C times.
		;
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a				; Health == 0?
		jp   z, .base0C		; If so, jump
		
		;
		; By default, shake the player 8 times.
		; If we didn't get hit by a projectile, add 2 more.
		;
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		bit  PF0B_PROJHIT, [hl]	; Did we get hit by a projectile?
		jp   nz, .base08		; If so, jump
	.base0A:
		ld   a, $08+$02			; ShakeCnt = $0A
		jp   .chkSuper
	.base08:
		ld   a, $08				; ShakeCnt = $08
	.chkSuper:
	
		;
		; If we got hit out of a super, cut in half the shake count
		;
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		bit  PF0B_SUPERMOVE, [hl]
		jp   nz, .shakeSet
	.shakeHalf:
		srl  a					; ShakeCnt = ShakeCnt / 2
		jp   .shakeSet
	.base0C:
		ld   a, $0C				; ShakeCnt = $08
	.shakeSet:
		; ==============================

		;
		; Shake 2px at a time A times.
		; This will take A*2 frames.
		;
		; While that happens, check if the player has performed a guard cancel,
		; and if so, break out of the loop.
		;

		; HL = Ptr to player X position
		ld   hl, iOBJInfo_X
		add  hl, de
	.loop:
		push af
			; Move right 2px
			ld   a, +$02
			add  a, [hl]	; A += iOBJInfo_X
			ld   [hl], a	; iOBJInfo_X = A
			call Task_PassControlFar
			
			; Check for input
			push hl
				; Generate the light/heavy button info
				call Play_Pl_CreateJoyKeysLH
				call Play_Pl_ExecSpecMoveInputCode	; Performed any special move input?
			pop  hl
			jp   c, .endEarly						; If so, return (guard cancel to move)
			
			; Move left 2px
			ld   a, -$02
			add  a, [hl]
			ld   [hl], a
			call Task_PassControlFar
			
			; Check for inputs like before
			push hl
				call Play_Pl_CreateJoyKeysLH
				call Play_Pl_ExecSpecMoveInputCode
			pop  hl
			jp   c, .endEarly
		pop  af
		dec  a			; Done this all times?
		jp   nz, .loop	; If not, loop
.endNorm:
	; Restore flags
	pop  af
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	ld   [hl], a
	; Disable opponent hitstop next frame
	ld   a, $00
	ld   [wPlayHitstopSet], a
	xor  a		; C flag clear
	ret
		.endEarly:
		; Restore regs
		pop  af
	pop  af
	; Note that the flags aren't restored, as starting a new move
	; set new values for many fields, including iPlInfo_Flags1.

	; Disable opponent hitstop next frame
	ld   a, $00
	ld   [wPlayHitstopSet], a
	scf			; C flag set
	ret
	
; =============== Play_Pl_IncPowOnHit ===============
; Increments the POW Meter, meant to be called when the player gets hit.
; IN
; - BC: Ptr to wPlInfo
; - D: Base damage received
Play_Pl_IncPowOnHit:
	push de
	
		; Don't receive POW meter when the attack deals no damage.
		ld   a, d
		or   a				; Was an initial penalty set?
		jp   z, .ret		; If not, return
		
		; Can't increment it if we're already at MAX Power
		ld   hl, iPlInfo_Pow
		add  hl, bc			; Seek to iPlInfo_Pow
		ld   a, PLAY_POW_MAX
		cp   a, [hl]		; iPlInfo_Pow == $28?
		jp   z, .ret		; If so, return
		
		;--
		
		; Increment the POW Meter by 4.
		ld   a, $04
		add  a, [hl]		; A = iPlInfo_Pow + 4
		
		; If we filled the meter just now, we got into MAX Power mode.
		cp   PLAY_POW_MAX	; iPlInfo_Pow >= $28?
		jp   nc, .setMax	; If so, jump
		
		; Otherwise, just save back the updated value
		jp   .savePow
		
	.setMax:
		; Cap the meter at $28
		ld   a, PLAY_POW_MAX
		; Enable MAX Power mode for 8 seconds.
		; This is significantly less compared to the amount you get
		; when charging it manually.
		ld   hl, iPlInfo_MaxPow
		add  hl, bc				; Seek to Max Pow timer
		ld   [hl], $3C			; 60 frames to decrement (every 8 frames)
		
	.savePow:
		ld   hl, iPlInfo_Pow
		add  hl, bc				; Seek to iPlInfo_Pow
		ld   [hl], a			; Save the value back
	.ret:
	pop  de
	ret
	
; =============== Play_Pl_DecStunTimer ===============
; Updates the counters for the dizzy state after getting hit.
;
; See also: Play_DoMisc_IncDizzyTimer
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; - D: Base damage received.
;      This will get processed, then subtracted as "penalty" to a stun timer.
Play_Pl_DecStunTimer:
	push de
		;
		; If we blocked the attack, don't influence the dizzy counters.
		;
		ld   hl, iPlInfo_Flags1
		add  hl, bc					; Seek to iPlInfo_Flags1
		bit  PF1B_GUARD, [hl]		; Is the flag set?
		jp   nz, .ret				; If so, return
		
		;
		; Add a penalty to the dizzy hit counter.
		; Penalty = Damage / 4
		;
		ld   a, d						
		srl  a							; A = D >> 2
		srl  a
		ld   hl, iPlInfo_DizzyHitCount
		add  hl, bc
		add  a, [hl]					; HitCount += A
		jp   nc, .setHitCount			; Overflowed? If so, cap it back
		ld   a, $FF
	.setHitCount:
		ld   [hl], a
		
		;
		; Extend the time before iPlInfo_DizzyHitCount resets itself.
		; TimeExtend = Damage * 2
		;
		ld   a, d
		sla  a							; A = D << 1
		ld   hl, iPlInfo_DizzyTimeLeft
		add  hl, bc
		add  a, [hl]					; TimeLeft += A
		jp   nc, .setTimeLeft			; Overflowed? If so, cap it back
		ld   a, $FF
	.setTimeLeft:
		ld   [hl], a
	.ret:
	pop  de
	ret  
	
; =============== Play_Pl_DecStunTimerOnNoKey ===============
; Decrements the dizzy timer if not pressing any key.
;
; IN
; - BC: Ptr to wPlInfo
Play_Pl_DecDizzyTime:
	
	; On time over, the dizzy state ends abruptly
	ld   a, [wRoundTime]
	or   a				; Is there time left?
	jp   nz, .chkKeys	; If so, jump
	; Otherwise, clear the countdown, which will end the move (see above)
	xor  a				
	ld   hl, iPlInfo_DizzyTimeLeft
	add  hl, bc
	ld   [hl], a		; iPlInfo_DizzyTimeLeft = 0
	jp   .ret
	
.chkKeys:
	; Any time a new key is pressed, the timer decrements by 3.
	; Note that the timer is already decremented once every frame in Play_DoMisc_DecDizzyTimer*,
	; so the most the timer can decrement/frame is 4.
	; As there's no CPU-specific logic here, CPU dizzies last for a long time.
	ld   hl, iPlInfo_JoyNewKeys
	add  hl, bc
	ld   a, [hl]			; A = Newly pressed keys
	and  a, $FF^KEY_START	; Pressed anything except START?
	jp   nz, .decTimer		; If so, jump
	jp   .ret
.decTimer:

	; Decrement the timer by 3
	ld   hl, iPlInfo_DizzyTimeLeft
	add  hl, bc
	ld   a, [hl]		; A = iPlInfo_DizzyTimeLeft
	sub  a, $03			; A -= 3
	jp   nc, .saveTimer	; Did we underflow?
	xor  a				; If so, force it back to 0
.saveTimer:
	ld   [hl], a		; Save it back
.ret:
	ret
	
; =============== Play_Pl_Unused_DecThrowKeyTimer ===============
; [TCRF] Weird unreferenced code that decrements a counter related to throws
;        when any of these conditions pass:
;        - Time Over
;        - Died
;        - Pressed any button
; The counter itself is set to $08 by HitTypeC_GrabStart and read by nothing else,
; except for giving it visibility to the opponent.
; IN
; - BC: Ptr to wPlInfo
Play_Pl_Unused_DecThrowKeyTimer:
	; If we time over'd, decrement the counter
	ld   a, [wRoundTime]
	or   a					; wRoundTime == 0?
	jp   z, .decTimer		; If so, jump
	
	; If we have no health, decrement the counter
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]
	or   a					; iPlInfo_Health == 0?
	jp   z, .decTimer		; If so, jump
	
	; If we pressed any button, decrement the counter
	ld   hl, iPlInfo_JoyNewKeys
	add  hl, bc
	ld   a, [hl]
	and  a, $FF^KEY_START	; Pressed any key other than START?
	jp   z, .ret			; If not, return
	
.decTimer:
	; iPlInfo_Unused_ThrowKeyTimer = MAX(iPlInfo_Unused_ThrowKeyTimer - 1, 0)
	ld   hl, iPlInfo_Unused_ThrowKeyTimer
	add  hl, bc				; HL = Ptr to iPlInfo_Unused_ThrowKeyTimer
	ld   a, [hl]			; A = iPlInfo_Unused_ThrowKeyTimer - 1
	sub  a, $01
	jp   nc, .save			; Did we underflow? If not, jump
	xor  a					; Otherwise, A = 0
.save:
	ld   [hl], a
.ret:
	ret

; =============== MoveS_ChkHalfSpeedHit ===============
; Runs the game at half speed for the specified amount of frames if the move allows for it.
; IN
; - A: How many frames to perform the effect
; - BC: Ptr to wPlInfo
MoveS_ChkHalfSpeedHit:

	push af	; Save frame count
	
		;
		; Validate that we can actually start slowdown mode
		;
		
		; Not applicable when dead, as getting killed already sets its own slowdown. don't interfere
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a			; iPlInfo_Health == 0?
		jp   z, .ret	; If so, jump
		
		; All projectiles cause slowdown in this game.
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		bit  PF0B_PROJHIT, [hl]
		jp   nz, .setSlowdown
			
		; Only do it if the move we got hit with has the slowdown flag set.
		ld   hl, iPlInfo_Flags3
		add  hl, bc
		bit  PF3B_HALFSPEED, [hl]	; Is the move tagged with halfspeed?
		jp   nz, .setSlowdown		; If so, jump
		jp   .ret					; Otherwise, don't do anything
		
	.setSlowdown:
		;
		; All OK. Initialize that mode
		;
	pop  af							; Slow down for A frames
	ld   [wPlaySlowdownTimer], a
	ld   a, $01						; Run gameplay every other frame
	ld   [wPlaySlowdownSpeed], a
	ret
	.ret:
		;
		; Validation failed.
		;
	pop  af
	ret
; =============== Play_Pl_StartWakeUp ===============
; Initializes the wake up move, meant to be used after a player falls on the ground
; (see: HitTypeC_Drop* and MoveC_Hit_Drop*).
;
; If the player has no health left (what hit the player killed him), he will instead
; stay on the ground forever, by setting MOVE_SHARED_NONE.
;
; IN:
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
Play_Pl_StartWakeUp:
	; Empty Max POW is possible
	call Play_Pl_EmptyPowOnSuperEnd

	;
	; If the player has no health, stop player movement/animations by setting MOVE_SHARED_NONE.
	; This is also important for Play_LoadPostRoundText0, since the game waits for both characters
	; to be in either this or the idle move before showing the KO text.
	;
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]
	or   a				; Health != 0?
	jp   nz, .alive		; If so, jump
.setDead:
	; Otherwise, stop player movement / animations.
	; The move ID won't be changed anymore from here.
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   [hl], MOVE_SHARED_NONE		; iPlInfo_MoveId = 0
	jp   .ret

.alive:
	; Can't be thrown for 1 sec from here.
	; This covers waking up and a few frames after.
	ld   hl, iPlInfo_NoThrowTimer
	add  hl, bc
	ld   [hl], 60

	; Update flags
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	; Player is on the ground if rolling
	res  PF0B_AIR, [hl]

	; Reset this for the next time we get hit
	res  PF0B_PROJHIT, [hl]
	; On the ground we can't attack indirectly
	res  PF0B_PROJREM, [hl]
	res  PF0B_PROJREFLECT, [hl]

	inc  hl							; Seek to iPlInfo_Flags1
	res  PF1B_NOSPECSTART, [hl]     ; For next time
	res  PF1B_HITRECV, [hl] 		; Falling to the ground ends the opponent's combo
	res  PF1B_ALLOWHITCANCEL, [hl]	; In case of a trade
	; The player can't be hit on the ground
	set  PF1B_INVULN, [hl]

	; Set move for getting up
	ld   a, MOVE_SHARED_WAKEUP
	call Pl_SetMove_StopSpeed
.ret:
	ret
	
; =============== MoveC_Base_WakeUp_End ===============
; Ends the wake up animation, handling the switch to the dizzy state if needed.
MoveC_Base_WakeUp_End:
	; HL = Ptr to iPlInfo_DizzyHitCount
	; A = iPlInfo_DizzyHitTarget
	call Play_Pl_IsDizzy	; Are we supposed to get dizzy when waking up?
	jp   nc, .noDizzy		; If not, just end the wakeup move
.dizzy:
	; Every time we get dizzy, increase its target by 2.
	; This means the opponent needs to deal more damage to dizzy us again.
	; Also reset the dizzy hit counter.
	ld   [hl], $00		; Reset dizzy hit counter
	add  a, $02			; Increment target by 2
	jp   nc, .setCap	; Did it overflow?
	ld   a, $FF			; Is so, cap it at $FF, just in case (this can never happen though)
.setCap:
	; Save back updated target
	ld   hl, iPlInfo_DizzyHitTarget
	add  hl, bc
	ld   [hl], a
	
	; We can be thrown immediately in the dizzy state
	ld   hl, iPlInfo_NoThrowTimer
	add  hl, bc
	ld   [hl], $00
	
	; Clear various flags
	ld   hl, $0020
	add  hl, bc
	res  PF0B_AIR, [hl] ; Grounded while dizzy
	res  PF0B_PROJHIT, [hl] ; Remove the three projectile flags
	res  PF0B_PROJREM, [hl]
	res  PF0B_PROJREFLECT, [hl]
	inc  hl		; Seek to iPlInfo_Flags1
	set  PF1B_NOSPECSTART, [hl] ; Can't cancel dizzies into specials (and since the dizzy state is a move, can't start normals either)
	res  PF1B_HITRECV, [hl]	; Damage string ended
	res  PF1B_ALLOWHITCANCEL, [hl] ; In case of a trade
	res  PF1B_INVULN, [hl] ; Not invulnerable
	
	; New move
	ld   a, MOVE_SHARED_DIZZY
	call Pl_SetMove_StopSpeed
	ret  
.noDizzy:
	call Play_Pl_EndMove
	ret 
	
; =============== Play_Pl_IsDizzy ===============
; Determines if the specified player is dizzy.
; IN
; - BC: Ptr to wPlInfo
; OUT
; - A: iPlInfo_DizzyHitTarget
; - HL: Ptr to iPlInfo_DizzyHitCount
; - C flag: If set, the player is dizzy
Play_Pl_IsDizzy:
	ld   hl, iPlInfo_DizzyHitTarget
	add  hl, bc
	ld   a, [hl]					; A = Target
	ld   hl, iPlInfo_DizzyHitCount	; HL = Ptr to Count
	add  hl, bc
	cp   a, [hl]					; Target < Count?
	ret  							; If so, (C flag set)
	
; =============== Play_Pl_DoHit ===============
; Handles the hit/block state and its animations.
; Note that this is called every frame by the player tasks.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started (by guard cancelling)
;           Only used by Play_Pl_ChkHitstop, and it makes hitstop end early.
Play_Pl_DoHit:

	; For all intents and purposes Play_Pl_DoHit is a direct continuation of Play_Pl_SetHitType.
	; Set up everything, update counters, damage player, (...) if it's applicable.
	; A = HitEffect ID * 2
	call Play_Pl_SetHitType
	jp   nc, .end
	
	;
	; We got hit, so handle the hit effect (HitTypeC_*).
	;
	; This is move-like code executed once, when we get hit. Each type of hit has its own code.
	; Typically it handles the hitstun/blockstun effect (player shaking), hit sound effects, flashing and knockback speed (a backjump, usually).
	; If hitstun is actviated, the code takes exclusive control of the player task while it is active.
	;
	; They also switch to another, actual move to handle the "next"/"post-hitstun" part of the hit
	; so that it won't take exclusive control.
	; This move is almost always part of the third group of moves (MoveC_Hit_*).
	;
	; Before getting there, first perform some common tasks:
	;
	
	; Empty the pow meter in case we got hit out of a super
	push af
		call Play_Pl_EmptyPowOnSuperEnd
	pop  af
	
	;
	; If we didn't block the hit, we definitely got hit out of a special or super move.
	;
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	res  PF0B_SPECMOVE, [hl]		
	res  PF0B_SUPERMOVE, [hl]
	inc  hl
.updateFlags1:
	; Don't override hitstun/blockstun with basic moves/normals
	set  PF1B_NOBASICINPUT, [hl]
	; Prevent the player from autoswitching direction during hitstun or blockstun
	set  PF1B_XFLIPLOCK, [hl]	
	; Mark that the opponent's attack made contact.
	; This a few effects, like making any next hit in the combo deal less penalty to the dizzy counters.
	set  PF1B_HITRECV, [hl]
	
	;
	; Prevent cancelling out of hitstun.
	; (though there's a special override in PF1B_ALLOWHITCANCEL)
	;
	cp   HITTYPE_BLOCKED			; Are we in the blockstun anim?
	jp   z, .execCode				; If so, skip
	set  PF1B_NOSPECSTART, [hl]		; Otherwise, we got hit. Prevent specials from starting.
.execCode:
	;
	; Execute the code for the currently set Hit effect/type.
	;
	
	push bc
		; Index Play_HitTypePtrTable by HitTypeId
		ld   hl, Play_HitTypePtrTable	; HL = Ptr to start of table
		ld   b, $00		; BC = HitTypeId (* 2)
		ld   c, a
		add  hl, bc		; Index it
		; Read it out to BC
		ld   c, [hl]
		inc  hl
		ld   b, [hl]
		push bc
		; Move to HL
		pop  hl			
	pop  bc
	jp   hl	; And jump there
.end:
	xor  a	; C flag clear
	ret
Play_HitTypePtrTable:
	dw HitTypeC_Blocked
	dw HitTypeC_HitMid0
	dw HitTypeC_HitMid1
	dw HitTypeC_HitLow
	dw HitTypeC_Sweep
	dw HitTypeC_HitA
	dw HitTypeC_LaunchHighUB
	dw HitTypeC_Hit_Multi0
	dw HitTypeC_Hit_Multi1
	dw HitTypeC_LaunchFastDB
	dw HitTypeC_Launch_SwoopUp
	dw HitTypeC_LaunchMidUB_NoStun
	dw HitTypeC_GrabStart
	dw HitTypeC_Grab_UB_NoSync
	dw HitTypeC_Grab_FG_NoSync
	dw HitTypeC_Grab_UB_Sync
	
; =============== HitTypeC_Blocked ===============
; ID: HITTYPE_BLOCKED
;
; Hit effect used when blocking, called for every blocked hit.
; OUT
; - C: If set, hitstop should end early (if applicable)
HitTypeC_Blocked:
	;
	; Play a DMG SFX
	;
	ld   a, SFX_BLOCK
	call HomeCall_Sound_ReqPlayExId
	
	;
	; Set up the player variables before starting blockstun.
	;	
	
	; Confirm that we're blocking
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_GUARD, [hl]
	
	; Blocking a move prevents it from using its flashing effects, if any
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	res  PF3B_FIRE, [hl]
	res  PF3B_SUPERALT, [hl]
	
	; Reset the frame timer to 5, which is used for timing the knockback (MOVE_SHARED_POST_BLOCKSTUN).
	; Reinitializing this while the knockback is being already executed effectively
	; extends the amount of time we stay in the knockback state.
	; (This won't be decremented until we get there because blockstun doesn't animate the player.)
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], $05
	
.doBlockStun:
	;
	; Perform the blockstun effect, and handle what happens once it ends.
	; Blockstun lasts until it either ends normally (nc) or we guard canceled (c).
	;
	call Play_Pl_DoBlockstun		; Did we start a move out of blockstun?
	jp   c, .retMoveStart			; If so, jump
	
	;
	; Now that blockstun is over, switch to the post-blocktun move.
	; This move deals knockback, pushing away the player.
	;

	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   [hl], MOVE_SHARED_POST_BLOCKSTUN
	
	; Also move out of the way of the other player's collision box
	call Play_Pl_MoveByColiBoxOverlapX
	
.retNoStart:
	scf		; C flag set
	ret
.retMoveStart:
	; We pulled off a special move out of blockstun, so we're no longer blocking
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	res  PF1B_GUARD, [hl]
	
	scf
	ccf		; C flag clear
	ret

; =============== HitTypeC_HitGeneric group ===============
; These next few ones that call HitTypeC_HitGeneric are basically the same hit type,
; a generic hit that can be used by any type of move (normals, specials, supers).
; Even though they set different move IDs, they point to the same code.
;
; The only difference between these is the animation associated to the move, most
; obvious for MOVE_SHARED_HITLOW which has the player getting hit while crouching.
	
; =============== HitTypeC_HitMid0 ===============
; ID: HITTYPE_HIT_MID0
;
; Hit logic used for generic mid hit #0.
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_HitMid0:
	ld   a, MOVE_SHARED_HIT0MID
	jp   HitTypeC_HitGeneric
; =============== HitTypeC_HitMid1 ===============
; ID: HITTYPE_HIT_MID1
;
; Hit logic used for generic mid hit #1.
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_HitMid1:
	ld   a, MOVE_SHARED_HIT1MID
	jp   HitTypeC_HitGeneric
; =============== HitTypeC_HitLow ===============
; ID: HITTYPE_HIT_LOW
;
; Hit logic used for generic low hit.
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_HitLow:
	ld   a, MOVE_SHARED_HITLOW
	; Fall-through
; =============== HitTypeC_HitGeneric ===============
; Hit logic used for generic mid hit #0.
; IN
; - A: Move ID to set
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: Always set (ends hitstop)	
HitTypeC_HitGeneric:

	; Play hit sound effect (normal or fire)
	push af	; Save MoveID
		call MoveS_PlayHitSFX

	; Switch to new move
	pop  af	; Restore MoveID
	call Pl_SetMove_ShakeScreenReset
	
	; Run gameplay at half speed for the next $0F frames, if applicable.
	; This will at least cover part of the hitstun effect.
	ld   a, $0F
	call MoveS_ChkHalfSpeedHit
	
	; Do the hitstun effect for multiple frames
	call Play_Pl_DoHitstun
	
	;
	; After the hitstun finishes
	;
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Cancel out the active hitbox.
	; What's the point of this? These are already reset when getting hit...
	; (all hit types do this)
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	
	scf	; Return set
	ret

; =============== HitTypeC_Launch* ===============
; These hit effects cause the player to be thrown at various jump arcs, depending
; on the hit type or any hardcoded player/move checks.
;
; As expected, they are used to end throws, but can be used by normal special moves too.
;
; The directions in the labels are relative to the opponent's movement.
; (ie: moving Backwards when the opponent throws you forwards)
	
; =============== HitTypeC_LaunchHighUB ===============
; ID: HITTYPE_LAUNCH_HIGH_UB
;
; High backjump (default: 4-6px/frame up, 1.25-1.5px/frame back) 
;
; Features:
; - Can optionally end a damage string.
; - Gameplay runs at half speed for $1E frames.
; - After hitstun ends, the player WILL get knocked back with an high backjump.
; - Backjump height is high, but at low horizontal speed
; - Player can't recover mid-air
; - Can be used when the player gets KO'd
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_LaunchHighUB:

	;
	; Invulnerability check.
	;
	; If the hit does not have PF3B_CONTHIT set, it will be the last one for the combo string.
	; This is accomplished by making the player invulnerable during the drop, preventing
	; further hits until waking up.
	;

	; Ignore this if the player is already dead
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]				; A = Player Health
	ld   hl, iPlInfo_Flags0
	add  hl, bc					; HL = Ptr to iPlInfo_Flags0
	set  PF0B_AIR, [hl]			; Mark player as in the air (not necessary)
	or   a						; iPlInfo_Health == 0?
	jp   z, .main				; If so, skip
	
	; Seek to damage flags
	inc  hl					; Seek to iPlInfo_Flags1
	inc  hl					; Seek to iPlInfo_Flags2
	inc  hl					; Seek to iPlInfo_Flags3
	
	; Enable invulnerability if the flag is not set
	bit  PF3B_CONTHIT, [hl]	; Is the flag set?
	jp   nz, .main			; If so, skip
	dec  hl					; Seek back to iPlInfo_Flags2
	dec  hl					; Seek back to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]	; Enable invulnerability
.main:
	;
	; Main hitstun part.
	;
	call MoveS_PlayHitSFX
	
	; Switch to default backjump move
	ld   a, MOVE_SHARED_LAUNCH_UB
	call Pl_SetMove_ShakeScreenReset
	
	; Run gameplay at half speed for the next $1E frames, if applicable
	ld   a, $1E
	call MoveS_ChkHalfSpeedHit
	
	; Do it
	call Play_Pl_DoHitstun
	
	; Once the hitstun is over, prevent the collision boxes from overlapping
	call Play_Pl_MoveByColiBoxOverlapX
	
	;
	; This knockback effect causes the player to optionally drop with a back jump.
	; Set the initial jump settings.
	;
	
	;--
	; Getting hit by Benimaru's Shinkuu Katate Goma quickly throws the opponent forwards.
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc						; Seek to opponent CharId
	ld   a, [hl]					
	cp   CHAR_ID_BENIMARU			; Is Benimaru the opponent?
	jp   nz, .chkJumpNorm			; If not, skip
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc						; Seek to opponent MoveId
	ld   a, [hl]
	cp   MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L			; Hit by the light version?
	jp   z, .setJumpBenimaru		; If so, jump
	cp   MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H			; Hit by the heavy version?
	jp   z, .setJumpBenimaru		; If so, jump
	jp   .chkJumpNorm				; Otherwise, do the normal case
.setJumpBenimaru:
	mMvC_SetSpeedHInt -$0600		; 6px/frame forward
	mMvC_SetSpeedV -$0600			; 6px/frame up
	jp   .retSet
	;--
	
.chkJumpNorm:

	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Is this a heavy hit?
	jp   nz, .setJumpH			; If so, use higher jump speed
.setJumpN:
	; Normal hit
	mMvC_SetSpeedHInt +$0140	; 1.25px/frame back
	mMvC_SetSpeedV -$0400		; 4px/frame up
	jp   .retSet
.setJumpH:
	; Heavy hit
	mMvC_SetSpeedHInt +$0180	; 1.5px/frame back
	mMvC_SetSpeedV -$0600		; 6px/frame up
.retSet:
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf  
	ret
	
; =============== HitTypeC_LaunchFastDB ===============
; ID: HITTYPE_LAUNCH_FAST_DB
;
; Fast backwards drop to the ground. (6px/frame down, 5-6px/frame back) 
;
; Features:
; - Can optionally end a damage string
; - Normal hitstun time
; - After hitstun ends, the player always gets thrown diagonally down backwards
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_LaunchFastDB:
	;
	; Invulnerability check.
	;
	; If the hit has PF3B_CONTHIT set, this will be the last one for the combo string.
	;
	
	; Ignore this if the player is already dead
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]				; A = Player Health
	ld   hl, iPlInfo_Flags0
	add  hl, bc					; HL = Ptr to iPlInfo_Flags0
	set  PF0B_AIR, [hl]			; Mark player as in the air (not necessary)
	or   a						; iPlInfo_Health == 0?
	jp   z, .main				; If so, skip
	
	; Seek to damage flags
	inc  hl					; Seek to iPlInfo_Flags1
	inc  hl					; Seek to iPlInfo_Flags2
	inc  hl					; Seek to iPlInfo_Flags3
	
	; Enable invulnerability if the flag is not set
	bit  PF3B_CONTHIT, [hl]	; Is the flag set?
	jp   nz, .main			; If so, skip
	dec  hl					; Seek back to iPlInfo_Flags2
	dec  hl					; Seek back to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]	; Enable invulnerability
.main:
	; Play hit SFX, with fire support
	call MoveS_PlayHitSFX
	
	; This is like an air throw, so set this as continuation code
	ld   a, MOVE_SHARED_LAUNCH_DB_SHAKE
	call Pl_SetMove_ShakeScreenReset
	
	; Do it
	call Play_Pl_DoHitstun
	
	; Once the hitstun is over, prevent the collision boxes from overlapping
	call Play_Pl_MoveByColiBoxOverlapX
	
	;
	; This knockback effect causes the player to drop diagonally down.
	;
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Is this a heavy hit?
	jp   nz, .setJumpH			; If so, use higher jump speed
.setJumpL:
	ld   hl, +$0500				; 5px/frame back
	jp   .setJump
.setJumpH:
	ld   hl, +$0600				; 6px/frame back
.setJump:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	mMvC_SetSpeedV +$0600		; 6px/frame down

	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf	; C flag set
	ret
	
; =============== HitTypeC_LaunchMidUB_NoStun ===============
; ID: HITTYPE_LAUNCH_MID_UB_NOSTUN
;
; Medium backjump (default: 4px/frame up, 2-3px/frame back) 
;
; Features:
; - Can optionally end a damage string.
; - No hitstun, the backjump starts immediately
; - Backjump height is medium, and moves horizontally about as much
; - Player can't recover mid-air
; - Can be used when the player gets KO'd
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_LaunchMidUB_NoStun:
	;
	; Invulnerability check.
	;
	; If the hit has PF3B_CONTHIT set, this will be the last one for the combo string.
	;
	
	; Ignore this if the player is already dead
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]				; A = Player Health
	ld   hl, iPlInfo_Flags0
	add  hl, bc					; HL = Ptr to iPlInfo_Flags0
	set  PF0B_AIR, [hl]			; Mark player as in the air (not necessary)
	or   a						; iPlInfo_Health == 0?
	jp   z, .main				; If so, skip
	
	; Seek to damage flags
	inc  hl					; Seek to iPlInfo_Flags1
	inc  hl					; Seek to iPlInfo_Flags2
	inc  hl					; Seek to iPlInfo_Flags3
	
	; Enable invulnerability if the flag is not set
	bit  PF3B_CONTHIT, [hl]	; Is the flag set?
	jp   nz, .main			; If so, skip
	dec  hl					; Seek back to iPlInfo_Flags2
	dec  hl					; Seek back to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]	; Enable invulnerability
.main:

	; Remove the physical damage source next frame.
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], $01
	
	; Switch to throw animation
	ld   a, MOVE_SHARED_LAUNCH_UB_SHAKE
	call Pl_SetMove_ShakeScreenReset
	
	; Move $10px above
	mMvC_SetMoveV -$1000
	
	;
	; Set knockback.
	;
	; This is pretty much the same as many other knockback jumps.
	; This knockback effect causes the player to drop with a back jump, away from the opponent.
	; Set the initial jump settings.
	;
	ld   hl, iPlInfo_Flags3
	add  hl, bc							
	bit  PF3B_HEAVYHIT, [hl]	; Is this a heavy hit?
	jp   nz, .setJumpH			; If so, use higher jump speed
.setJumpN:
	; Normal hit
	ld   hl, +$0200				; 2px/frame back
	jp   .setJump
.setJumpH:
	; Heavy hit
	ld   hl, +$0300				; 3px/frame back
.setJump:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	mMvC_SetSpeedV -$0400		; 4px/frame up

	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf	; C flag set
	ret
	
; =============== HitTypeC_Launch_SwoopUp ===============
; ID: HITTYPE_LAUNCH_SWOOPUP
;
; Used by hits that end up causing the player to move really high up, to off-screen above.
;
; There are two different kinds of hit types in this one:
; - Projectile-based. Used by Joe and Rugal's supers, when they spawn a very tall projectile
;   that covers the entire playfield's height. The projectile hits the player and they move off-screen above.
;   These projectile hit multiple times, which will progressively decrease the gravity.
; - Physical throw. Used by Ralf's back breaker, that launches the opponent really high up.
;
; Their effect is the same, as they both set the move MOVE_SHARED_LAUNCH_SWOOPUP: the player keeps moving up. It then starts falling down.
HitTypeC_Launch_SwoopUp:
	; There's special code for getting hit by Ralf
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RALF						; Did we get hit by Ralf?
	jp   nz, HitTypeC_Launch_SwoopUp_ToProj	; If not, jump
	
; =============== HitTypeC_Launch_SwoopUp_Ralf ===============
; Command throw version for Ralf's Back Breaker.
HitTypeC_Launch_SwoopUp_Ralf:

	; Set continuation
	ld   a, MOVE_SHARED_LAUNCH_SWOOPUP
	call Pl_SetMove_ShakeScreenReset
	
	; Y Position -> Same as opponent
	; X Position -> 4px behind opponent
	call HitTypeS_SyncPlPosFromOtherPos
	ld   hl, -$0400
	call Play_OBJLstS_MoveH_ByXDirR
	
	; Push opponent in case we are cornered
	call Play_Pl_GiveKnockbackCornered
	
	mMvC_SetSpeedV -$0700	; 7px/frame up
	
	; Make player invulnerable while this happens
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	
	jp   HitTypeC_Launch_SwoopUp_RetSet
	
; =============== HitTypeC_Launch_SwoopUp_ToProj ===============
; Projectile version for other characters.
HitTypeC_Launch_SwoopUp_ToProj:
	;--
	;
	; [POI] Pointless Invulnerability check, since we're always setting PF1B_INVULN later.
	;
	
	; Ignore this if the player is already dead
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]				; A = Player Health
	ld   hl, iPlInfo_Flags0
	add  hl, bc					; HL = Ptr to iPlInfo_Flags0
	set  PF0B_AIR, [hl]			; Mark player as in the air (not necessary)
	or   a						; iPlInfo_Health == 0?
	jp   z, .main				; If so, skip
	
	; Seek to damage flags
	inc  hl					; Seek to iPlInfo_Flags1
	inc  hl					; Seek to iPlInfo_Flags2
	inc  hl					; Seek to iPlInfo_Flags3
	
	; Enable invulnerability if the flag is not set
	bit  PF3B_CONTHIT, [hl]	; Is the flag set?
	jp   nz, .main			; If so, skip
	dec  hl					; Seek back to iPlInfo_Flags2
	dec  hl					; Seek back to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]	; Enable invulnerability
.main:
	;--

	; Make player invulnerable for a short while to avoid receiving hits every frame.
	; MOVE_SHARED_LAUNCH_SWOOPUP will reset this for us after a while.
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	
	; Set continuation code
	ld   a, MOVE_SHARED_LAUNCH_SWOOPUP
	call Pl_SetMove_ShakeScreenReset
	
	; Prevent overlapping with player
	call Play_Pl_MoveByColiBoxOverlapX
	
	
	;
	; Handle movement.
	;
	
	; Move 1.5px towards the enemy projectile (the "wall")
	; As the projectile hits multiple times, the player will move horizontally back and forth.
	ld   hl, +$0180
	call Play_OBJLstS_MoveH_ByOtherProjOnR
	
	; Reset the horizontal speed.
	;--
	; [POI] This check is pointless, both conditions are the same.
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]
	jp   nz, .setSpeedH
.setSpeedN:
	ld   hl, +$0000
	jp   .setSpeed
.setSpeedH:
	;--
	ld   hl, +$0000
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	; Subtract 2 to the current vertical speed, and move the player with the updated speed settings.
	; As the projectile hits multiple times, the player will progressively move quicker upwards.
	mMvC_DoGravityHV -$0200
	; Fall-through
	
HitTypeC_Launch_SwoopUp_RetSet:
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf  
	ret
	
; =============== HitTypeC_Sweep ===============
; ID: HITTYPE_SWEEP
;
; Hit effect that causes the player to drop on the ground with a low jump.
; Exclusively used by crouching heavy kicks.
;
; Features:
; - Always ends a damage string
; - After hitstun ends, the player always gets knocked back with a backjump
; - Backjump height is medium and doesn't vary 
; - Player can't recover mid-air
; - Can be used in the air or on the ground
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_Sweep:
	; The player is *always* invulnerable with this hit type.
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	inc  hl	; Seek to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]
	
.main:
	;
	; Main hitstun part.
	;
	call MoveS_PlayHitSFX
	ld   a, MOVE_SHARED_HIT_SWEEP
	call Pl_SetMove_ShakeScreenReset
	call Play_Pl_DoHitstun
	
	; Once the hitstun is over, prevent the collision boxes from overlapping
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Move 1.5px/frame backwards
	; [POI] Useless check, as the same value gets used.
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]
	jp   nz, .setSpeedH
.setSpeedL:
	ld   hl, +$0180
	jp   .setSpeed
.setSpeedH:
	ld   hl, +$0180
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	; Move 3px/frame up
	mMvC_SetSpeedV -$0300
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf  ; C Flag set
	ret
	
; =============== HitTypeC_HitA ===============
; ID: HITTYPE_HIT_A
;
; All normals that hit an airborne player that don't use the whitelisted hit types (see Play_Pl_SetHitTypeC_SetHitType) 
; are silently replaced with this instead.
; Not used directly.
;
; Features:
; - Only makes sense to use in the air
; - Always ends a damage string
; - After hitstun ends, the player always gets knocked back with a backjump
; - Backjump height is high and doesn't vary
; - Player recovers in the air
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_HitA:
	; The player is *always* invulnerable with this hit type, likely to avoid juggles.
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	inc  hl	; Seek to iPlInfo_Flags1
	set  PF1B_INVULN, [hl]
	
.main:
	;
	; Main hitstun part.
	;
	call MoveS_PlayHitSFX
	ld   a, MOVE_SHARED_LAUNCH_UB_REC
	call Pl_SetMove_ShakeScreenReset
	call Play_Pl_DoHitstun
	
	; Once the hitstun is over, prevent the collision boxes from overlapping
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Move 1.5px/frame backwards
	; [POI] Useless check, as the same value gets used.
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]
	jp   nz, .setSpeedH
.setSpeedL:
	ld   hl, +$0180
	jp   .setSpeed
.setSpeedH:
	ld   hl, +$0180
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	; Move 4px/frame up
	mMvC_SetSpeedV -$0400
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf  ; C Flag set
	ret
	
; =============== MoveS_PlayHitSFX ===============
; Plays a generic SFX for the player getting hit.
; IN
; - BC: Ptr to wPlInfo
MoveS_PlayHitSFX:
	; The sound effect used is different for "firey" moves (those with PF3B_FIRE set).
	ld   hl, iPlInfo_Flags3
	add  hl, bc						; Seek to iPlInfo_Flags3
	bit  PF3B_FIRE, [hl]			; Is this a firey move?
	jp   nz, .slowFlash				; If so, jump
.noFlash:
	ld   a, SFX_HIT					; A = SFX ID for normal hits
	call HomeCall_Sound_ReqPlayExId
	jp   .ret
.slowFlash:
	ld   a, SCT_FIREHIT				; A = SFX ID for firey hits
	call HomeCall_Sound_ReqPlayExId
.ret:
	ret
	
; =============== HitTypeC_Hit_Multi* ===============	
; Hit types used by special moves that hit multiple times, for hits outside of the last one.
; Moves tend to alternate hits betweeen this and HitTypeC_Hit_Multi1.
;
; Some super moves may also use HitTypeC_Hit_MultiGS, which pushes the player on the ground
; and forces them there.
;
; Specifically made to prevent the opponent from getting out of the damage string,
; though it's not impossible with a well timed projectile.
;
; =============== HitTypeC_Hit_Multi0 ===============
; ID: HITTYPE_HIT_MULTI0
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_Hit_Multi0:
	ld   a, MOVE_SHARED_HIT_MULTIMID0
	jp   HitTypeC_Hit_Multi1.main
; =============== HitTypeC_Hit_Multi1 ===============
; ID: HITTYPE_HIT_MULTI1
; OUT
; - C flag: Always set (ends hitstop)
HitTypeC_Hit_Multi1:
	ld   a, MOVE_SHARED_HIT_MULTIMID1
	; Fall-through
	
; =============== .main ===============
; - Hitstun lasts very little
; - Player gets stuck and placed in front of the opponent.
; - Ground-only
; IN
; - A: Move ID
; OUT
; - C flag: Always set (ends hitstop)
.main:
	; Play SGB/DMG drop SFX
	push af
		ld   a, SCT_MULTIHIT
		call HomeCall_Sound_ReqPlayExId
	pop  af
	; Switch to move A
	call Pl_SetMove_ShakeScreenReset
	
	; Force position to be in front of opponent
	call HitTypeS_MovePlToOpFront
	
	; Hitstun time is very short since hits should come quickly
	call Play_Pl_DoHitstunOnce
	
	; Push opponent if we're cornered
	call Play_Pl_GiveKnockbackCornered
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	scf  
	ret
	
; =============== HitTypeS_MovePlToOpFront ===============
; Forces the player to be placed in front of the opponent, on the ground.
; This is meant to be used by "intermediate" hits for special moves that hit
; multiple times, so that the player won't manage to escape.
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
HitTypeS_MovePlToOpFront:

	;
	; Some moves have special handling for this.
	;
	
	; Perform the character check
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RYO		; Opponent is RYO?
	jp   z, .chkRyoMove		; If so, jump
	cp   CHAR_ID_HEIDERN	; Opponent is HEIDERN?
	jp   z, .chkHeidernMove	; If so, jump
	cp   CHAR_ID_RUGAL		; Opponent is RYO?
	jp   z, .chkRugalMove	; If so, jump
	jp   .norm				; Otherwise, skip
.chkRyoMove:

	;
	; RYO - Zanretsuken
	;
	; Vertically shift the player position on each of Ryo's Zanretsuken hits.
	;
	
	; Perform the move check
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_RYO_ZENRETSUKEN_L	; Got hit by the light version of Zanretsuken?
	jp   z, .ryo				; If so, jump
	cp   MOVE_RYO_ZENRETSUKEN_H	; Got hit by the heavy version of Zanretsuken?
	jp   z, .ryo				; If so, jump
	jp   .norm					; Otherwise, skip
.ryo:
	; Y Position -> Snap to the ground, but offset by the opponent's iPlInfo_Ryo_Zanretsuken_VShift
	; iOBJInfo_Y = PL_FLOOR_POS - (opponent's)iPlInfo_Ryo_Zanretsuken_VShift
	
	; Determine which player we're playing as, and read to A the opponent's iPlInfo_Ryo_Zanretsuken_VShift
	ld   hl, iPlInfo_PlId
	add  hl, bc
	bit  0, [hl]		; iPlInfo_PlId != PL1?
	jp   nz, .ryo_pl2	; If so, jump
.ryo_pl1:
	ld   a, [wPlInfo_Pl2+iPlInfo_Ryo_Zanretsuken_VShift]	; Use 2P's value when we're 1P
	jp   .ryo_setY
.ryo_pl2:
	ld   a, [wPlInfo_Pl1+iPlInfo_Ryo_Zanretsuken_VShift]	; Use 1P's value when we're 2P
.ryo_setY:
	; A = -A for subtraction
	cpl  				
	inc  a
	; Add the base floor position
	add  PL_FLOOR_POS
	; Save the result to iOBJInfo_Y
	ld   hl, iOBJInfo_Y
	add  hl, de		; Seek to Y position
	ld   [hl], a	; Save A here
	
	; X Position -> $18px in front of the opponent (like in .norm)
	call HitTypeS_SyncPlXFromOtherX	; Sync to opponent X
	ld   hl, -$1800 				; Move back $18px
	call Play_OBJLstS_MoveH_ByXDirR
	jp   .ret
	
	
.chkHeidernMove:

	;
	; HEIDERN - Neck Roller / Final Bringer
	;
	; These moves have Heidern jump on top of the opponent, so their
	; position is barely altered.
	;
	
	; Perform the move check
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_HEIDERN_NECK_ROLLER_L			; Got hit by the light version of Neck Roller?
	jp   z, .heidern				; If so, jump
	cp   MOVE_HEIDERN_NECK_ROLLER_H			; Got hit by the heavy version of Neck Roller?
	jp   z, .heidern				; If so, jump
	cp   MOVE_HEIDERN_FINAL_BRINGER_S			; Got hit by Final Bringer? (super)
	jp   z, .heidern				; If so, jump
	jp   .norm						; Otherwise, skip
.heidern:
	; Y Position -> Untouched
	call HitTypeS_SyncPlXFromOtherX
	; X Position -> $03px in front of the opponent
	ld   hl, -$0300
	call Play_OBJLstS_MoveH_ByXDirR
	jp   .ret
	
	
.chkRugalMove:
	;
	; RUGAL - Throw
	;
	; Rugal's throw has him holding the opponent off the ground, near him.
	;
	
	; Perform the move check
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_THROW_G	; Got hit by the throw?
	jp   nz, .norm				; If not, skip
.rugal:
	; Y Position -> 8px off the ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS - $08
	call HitTypeS_SyncPlXFromOtherX
	; X Position -> $10px in front of the opponent
	ld   hl, -$1000
	call Play_OBJLstS_MoveH_ByXDirR
	jp   .ret
	
.norm:

	;
	; DEFAULT
	;

	; Y Position -> Snap to the ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS
	
	; X Position -> $18px in front of the opponent
	call HitTypeS_SyncPlXFromOtherX	; Sync to opponent X
	ld   hl, -$1800 				; Move back $18px
	call Play_OBJLstS_MoveH_ByXDirR
.ret:
	ret
	
; =============== HitTypeS_SyncPlXFromOtherX ===============
; Makes the player use the same X pixel position as the opponent.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
HitTypeS_SyncPlXFromOtherX:
	push bc
		; BC = Ptr to opponent's X Position
		ld   hl, iPlInfo_OBJInfoXOther
		add  hl, bc
		push hl
		pop  bc
		
		; HL = Ptr to player X Position
		ld   hl, iOBJInfo_X
		add  hl, de
		
		; Copy iPlInfo_OBJInfoXOther to iOBJInfo_X
		ld   a, [bc]
		inc  bc			; Not needed
		ldi  [hl], a
	pop  bc
	ret
; =============== HitTypeS_SyncPlPosFromOtherPos ===============
; Makes the player use the same X and Y positions as the opponent.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
HitTypeS_SyncPlPosFromOtherPos:
	push bc
		; BC = Ptr to opponent's X Position
		ld   hl, iPlInfo_OBJInfoXOther
		add  hl, bc
		push hl
		pop  bc
		
		; HL = Ptr to player X Position
		ld   hl, iOBJInfo_X
		add  hl, de
		
		; Copy iPlInfo_OBJInfoXOther to iOBJInfo_X
		ld   a, [bc]
		inc  bc			; Seek to iPlInfo_OBJInfoYOther	
		ldi  [hl], a	; Save value, seek to iOBJInfo_XSub
		inc  hl			; Seek to iOBJInfo_Y
		
		; Copy iPlInfo_OBJInfoYOther to iOBJInfo_Y
		ld   a, [bc]
		ld   [hl], a
	pop  bc
	ret
	
; =============== HitTypeC_GrabStart ===============
; ID: HITTYPE_GRAB_START
;
; Handler for getting "hit" successfully by the opponent's throw range hitbox.
; This is the second part of getting thrown.
;
; The important part this does is setting wPlayPlThrowActId to PLAY_THROWACT_NEXT02, then
; wait forever until the opponent responds (aka: changes it from PLAY_THROWACT_NEXT02).
;
; The opponent code passed control from Play_Pl_SetHitType.chkThrow, which checks for PLAY_THROWACT_NEXT02
; to continue the throw sequence, either to BasicInput_StartGroundThrow or BasicInput_StartAirThrow.
; When doing so, it also increments the throw sequence again, allowing us to continue execution.
;
; Note that if we never get here (the throw didn't "hit" successfully), PLAY_THROWACT_NEXT02 wouldn't be set,
; so the opponent code would just end the throw (PLAY_THROWACT_NONE).
; 
; OUT
; - C flag: If set, the throw continued successfully
HitTypeC_GrabStart:

	; Not applicable if we're getting thrown
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_START		; wPlayPlThrowActId == PLAY_THROWACT_START?
	jp   nz, .retClear				; If not, jump
	
	; [TCRF] Require 15 button presses to do something... but nothing checks for this.
	ld   hl, iPlInfo_Unused_ThrowKeyTimer
	add  hl, bc
	ld   [hl], $0F
	
	; We're not invulnerable during throws, since the opponent uses hurtboxes to
	; continue the throw sequence.
	ld   hl, iPlInfo_Flags1
	
	; [BUG] Forgot the indexing!
	IF FIX_BUGS == 1
		add  hl, bc
	ENDC
	res  PF1B_INVULN, [hl]
	; Can't start specials when grabbed.
	set  PF1B_NOSPECSTART, [hl]
	; Can't switch direction since it wouldn't make sense
	res  PF1B_XFLIPLOCK, [hl]

	; Switch to the next part of the throw sequence.
	ld   a, PLAY_THROWACT_NEXT02
	ld   [wPlayPlThrowActId], a
	
	;
	; Wait until the opponent task sets a new value for wPlayPlThrowActId.
	;
.waitCont:
	call Task_PassControlFar		; Pass out to opponent task
	ld   a, [wPlayPlThrowActId]
	cp   PLAY_THROWACT_NONE			; Did he reset the value to PLAY_THROWACT_NONE?
	jp   z, .retClear				; If so, the throw is aborted
	cp   PLAY_THROWACT_NEXT03		; Did he set it to PLAY_THROWACT_NEXT03 yet?
	jp   nz, .waitCont				; If not, loop
	
	;
	; If we got here, the opponent got into the second part of the throw.
	; Prepare for the continuation code to start.
	;
	
	; Face the opponent and lock the direction again
	call OBJLstS_SyncXFlip
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_XFLIPLOCK, [hl]
	
	; Set the continuation code
	ld   a, MOVE_SHARED_HIT_MULTIMID1
	call Pl_SetMove_ShakeScreenReset	
	
	; Freeze the player while doing MOVE_SHARED_HIT_MULTIMID1.
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], ANIMSPEED_NONE
	inc  hl
	ld   [hl], ANIMSPEED_NONE
	
	; Reposition 16px in front of the opponent.
	; Because we're facing the opponent, moving backwards places us there.
	call HitTypeS_SyncPlXFromOtherX	; over opponent X
	ld   hl, -$1000					; move back $10px
	call Play_OBJLstS_MoveH_ByXDirR
	
	; Remove throw range hitbox next frame
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], $01
	
	; Prevent collision box overlapping
	call Play_Pl_MoveByColiBoxOverlapX
	; and push the opponent if we couldn't
	call Play_Pl_GiveKnockbackCornered
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	
	; C flag set - throw continued
	scf
	ret
.retClear:
	; C flag clear - throw aborted
	xor  a
	ret
	
; =============== HitTypeC_Grab_* ===============
; Hit effects requested by the opponent's move code after the grab is fully confirmed 
; and before the actual throw happens.
;
; Their main purpose is to reposition the player relative to the opponent in various
; ways, then switch to their respective move code.
;
; 96 completely redid these for greater flexibility, allowing the move code itself
; to specify the player's relative position and orientation during a throw.
;
; OUT
; - C flag: Always set

; =============== HitTypeC_Grab_UB_NoSync ===============
; ID: HITTYPE_GRAB_UB_NOSYNC
;
; Reposition once:
; - 8px above opponent
; - 8px behind the opponent
HitTypeC_Grab_UB_NoSync:
	; Set continuation code.
	ld   a, MOVE_SHARED_GRAB_UB_NOSYNC
	call Pl_SetMove_ShakeScreenReset

	; Force player in the air
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	
	; Reposition relative to the opponent.
	call HitTypeS_SyncPlPosFromOtherPos

	; Y Position -> $08px above opponent
	mMvC_SetMoveV -$0800
	
	;
	; X Position -> $08px behind the opponent('s origin)
	;               ...except if hit by Ralf's Back Breaker.
	;               In that case, it's only 1px because we're being held close.
	;
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RALF				; Opponent is RALF?
	jp   nz, .norm					; If not, jump
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_RALF_BACK_BREAKER_L	; Being thrown by the Back Breaker?
	jp   z, .ralf					; If so, jump
	cp   MOVE_RALF_BACK_BREAKER_H	; Being thrown by the Back Breaker?
	jp   z, .ralf					; If so, jump
	jp   .norm						; Otherwise, use the normal offset
.ralf:
	mMvC_SetMoveH +$0100			; Move forward 1px
	jp   .setPhys
.norm:
	mMvC_SetMoveH +$0800			; Move forward 8px
	
.setPhys:
	; Remove throw rotation range hitbox next frame
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], $01
	; Push the opponent if we couldn't fully reposition (ie: attempted to move off-screen)
	call Play_Pl_GiveKnockbackCornered
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	
	scf	; C flag set
	ret  
	
; =============== HitTypeC_Grab_FG_NoSync ===============
; ID: HITTYPE_GRAB_FG_NOSYNC
;
; Reposition once:
; - 1px above *ground*
; - 16px behind the opponent
HitTypeC_Grab_FG_NoSync:
	; Set continuation code.
	ld   a, MOVE_SHARED_GRAB_FG_NOSYNC
	call Pl_SetMove_ShakeScreenReset
	
	; Y Position -> $01px above ground
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   [hl], PL_FLOOR_POS-$01

	; Force player in the air
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	
	; X Position -> 16px in behind the opponent
	call HitTypeS_SyncPlXFromOtherX
	mMvC_SetMoveH +$1000
	
	; Remove throw rotation range hitbox next frame
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], $01
	
	; Push the opponent if we couldn't fully reposition (ie: attempted to move off-screen)
	call Play_Pl_GiveKnockbackCornered
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	
	scf	; C flag set
	ret  
	
; =============== HitTypeC_Grab_UB_Sync ===============
; ID: HITTYPE_GRAB_UB_SYNC
;
; Reposition always:
; - Same Y position as opponent (or 16px above, for Rugal)
; - 4px behind the opponent (see below)
HitTypeC_Grab_UB_Sync:
	; Set continuation code.
	ld   a, MOVE_SHARED_GRAB_UB_SYNC
	call Pl_SetMove_ShakeScreenReset

	; Force player in the air
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_AIR, [hl]
	
	;--
	; X Position -> 16px behind the opponent
	; [POI] This is *inconsistent* with the continuation code in MoveC_Hit_GrabSync.
	;       That repositions the player to be only 4px in front of the opponent, and overrides
	;       immediately the 16px position.
	call HitTypeS_SyncPlPosFromOtherPos
	mMvC_SetMoveH +$1000
	;--
	
	;
	; Y Position -> If hit by Rugal's command grabs, it's 16px above the opponent
	;               Otherwise, it's the opponent's Y position.
	;
	; This is consistent with the continuation code in MoveC_Hit_GrabSync.
	;
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RUGAL			; Opponent is RUGAL?
	jp   nz, .setPhys			; If not, skip
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_RUGAL_GOD_PRESS_L			; Grabbed by the light God Press?
	jp   z, .rugal				; If so, jump
	cp   MOVE_RUGAL_GOD_PRESS_H			; Grabbed by the heavy God Press?
	jp   z, .rugal				; If so, jump
	cp   MOVE_RUGAL_GIGANTIC_PRESSURE_S		; Grabbed by Rugal's super?
	jp   z, .rugal				; If so, jump
	jp   .setPhys				; Otherwise, skip
.rugal:
	mMvC_SetMoveV -$1000
.setPhys:
	
	; Remove throw rotation range hitbox next frame
	ld   hl, iPlInfo_PhysHitRecv
	add  hl, bc
	ld   [hl], $01
	
	; Push the opponent if we couldn't fully reposition (ie: attempted to move off-screen)
	call Play_Pl_GiveKnockbackCornered
	
	; Cancel out the active hitbox.
	ld   hl, iPlInfo_MoveDamageVal
	add  hl, bc
	xor  a
	ldi  [hl], a ; iPlInfo_MoveDamageVal
	ldi  [hl], a ; iPlInfo_MoveDamageHitTypeId
	ld   [hl], a ; iPlInfo_MoveDamageFlags3
	
	scf	; C flag set
	ret
	
; =============== Play_Pl_SetHitType ===============
; Handles the player status and damage-related fields when getting hit.
; This does a lot of setup for Play_Pl_DoHit to do the final adjustments
; and execute the HitType code.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - A: Hit effect ID that was set, * 2 (HITTYPE_*)
; - C flag: If set, we got hit or blocked the attack. The return value in A can be used.
;           If cleared, the hit didn't have any effect.
Play_Pl_SetHitType:
	push bc
		push de
		
		;--------------------------------
		;
		; Update the airborne flag on the player status,
		; since it's used later on when validating hit effects.
		; (As some hit effects are switched when in the air or on the ground)
		;
		; [POI] Because this is called every frame, this never *ever* needs to be set elsewhere.
		;       the air flag, but in this game they tend to do it anyway, which is pointless!
		;       It suggests that the check was "tacked on" at a later time, especially its
		;       location in the middle of damage-related code.
		;
		;       96 removed almost all instances of useless PF0B_AIR sets.
		;
		Play_Pl_SetHitTypeC_SetAirFlag:
			ld   hl, iOBJInfo_Y
			add  hl, de
			ld   a, [hl]		; A = iOBJInfo_Y
			ld   hl, iPlInfo_Flags0
			add  hl, bc			; HL = Ptr to iPlInfo_Flags0
			cp   PL_FLOOR_POS	; Are we on the ground?
			jp   nz, .setAir	; If not, set PF0B_AIR
		.setGround:
			res  PF0B_AIR, [hl]	; Otherwise, reset it
			jp   .end
		.setAir:
			set  PF0B_AIR, [hl]
		.end:
		
		;--------------------------------
		;
		; Start by dividing between projectile hits and physical hits.
		; 
		; There are significant differences between the handling of those, though the code paths later
		; converge back at Play_Pl_SetHitTypeC_ChkBlock (but not before setting the PF0B_PROJHIT flag)
		; when it comes to applying the damage and hit effect.
		;
		Play_Pl_SetHitTypeC_ChkHitType:		
			; The flags checked here were previously set this frame during collision detection by the main task.
			ld   hl, iPlInfo_ColiFlags
			add  hl, bc
			bit  PCFB_PROJHIT, [hl]				; Were we hit by a projectile?
			jp   nz, .proj						; If so, jump
			; Both PCFB_PUSHED and PCFB_HIT must be set for it to count as a physical hit.
			; Checking PCFB_HIT isn't enough, because PCFB_HIT is also used alongside PCFB_PROJREMOTHER
			; when the opponent reflects/removes a projectile.
			bit  PCFB_PUSHED, [hl]				; Did we get knockback'd or pushed by the other player?			
			jp   nz, .phys						; If so, jump
			
			; Otherwise, we definitely didn't get hit. Return.
			jp   Play_Pl_SetHitType_RetClear
			
		;--------------------------------
		;
		; PROJECTILE HIT
		; [POI] This contains a bunch of checks that don't matter, probably as it was based on .phys,
		;       which had to account for getting called across multiple frames even when it's not needed.
		;       This one though is only called once, for the single frame the projectile hits.
		;
		.proj:
			;
			; Can't get hit when we're invincible.
			; Curiously, of all code in the subroutine for checking collision, the projectile checks
			; are the only ones that check this flag beforehand, making the check here pointless.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc							; Seek to iPlInfo_Flags1
			bit  PF1B_INVULN, [hl]				; Can we get hit?
			jp   nz, Play_Pl_SetHitType_RetClear	; If not, return
			
			;
			; Throws have more priority than projectiles.
			;
			; If the projectile hit us while being/attempting to get thrown by the opponent, ignore the hit
			; and continue to the physical hit code, where we'll continue to handle the throw.
			;
			ld   a, [wPlayPlThrowActId]
			or   a								; Is a throw in progress (wPlayPlThrowActId != 0)?
			jp   z, .getProjDamage				; If not, jump
			
			;
			; [POI] This check is pointless, as if a throw is in progress PCFB_PUSHED is always set
			;       for the duration of the throw until we are actually thrown.
			;
			ld   hl, iPlInfo_ColiFlags
			add  hl, bc							; Seek to iPlInfo_ColiFlags
			bit  PCFB_PUSHED, [hl]				; Did we push another player?	
			jp   nz, .phys						; If so, jump (always happens)
			
			jp   Play_Pl_SetHitType_RetClear	; We never get here
			
		.getProjDamage:
		
			;
			; Seek to the move damage fields from the opponent's projectile.
			;
			ld   hl, iPlInfo_PlId
			add  hl, bc							; Seek to iPlInfo_PlId
			bit  0, [hl]						; iPlInfo_PlId == PL2? ($01)
			jp   nz, .useProj1P					; If so, use 1P's projectile damage value
		.useProj2P:							
			ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Play_DamageVal		 
			jp   .chkProjDamage
		.useProj1P:
			ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Play_DamageVal		
		.chkProjDamage:
			; 
			; Just like the PF1B_INVULN check, this was checked beforehand in the box check code.
			; This is structured like the code checking iPlInfo_MoveDamageValOther in .phys,
			; but the damage check in there has a real purpose.
			;
			ld   a, [hl]
			or   a								; Is there damage assigned to the projectile?
			jp   z, Play_Pl_SetHitType_RetClear	; If not, return
			
			;
			; Retrieve the move damage fields from the projectile.
			;
			ld   d, [hl]	; D = iOBJInfo_Play_DamageVal
			inc  hl
			ld   e, [hl]	; E = iOBJInfo_Play_DamageHitTypeId
			inc  hl
			ld   a, [hl]	; A = iOBJInfo_Play_DamageFlags3
			
			; Set that we were hit by a projectile
			ld   hl, iPlInfo_Flags0
			add  hl, bc							; Seek to iPlInfo_Flags0
			set  PF0B_PROJHIT, [hl]
			
			inc  hl								; Seek to iPlInfo_Flags1
			inc  hl								; Seek to iPlInfo_Flags2
			; Since it should be possible to combo off a projectile hit, restore collision boxes.
			res  PF2B_NOHURTBOX, [hl]
			res  PF2B_NOCOLIBOX, [hl]
			
			; Apply the opponent's iOBJInfo_Play_DamageFlags3
			inc  hl								; Seek to iPlInfo_Flags3
			ld   [hl], a						; Copy iOBJInfo_Play_DamageFlags3 there
			
			; There's nothing else to check here, skip to the shared code
			jp   Play_Pl_SetHitTypeC_ChkBlock
			
			
		;--------------------------------
		;
		; PHYSICAL HIT ("Player Hit")
		;
		.phys:

			;
			; Make sure we actually got hit, as we can get here just by pushing another player.
			;
			ld   hl, iPlInfo_ColiFlags
			add  hl, bc							
			bit  PCFB_HIT, [hl]					; Did we get hit?
			jp   z, Play_Pl_SetHitType_RetClear	; If not, return
			
			;
			; Make sure the opponent can damage the player.
			;
			; We're checking this because of what the game does to prevent a move from dealing
			; damage for multiple continuous frames.
			; 
			; To ensure that, the main task at Play_DoMisc_ResetDamage blanks the damage field
			; for the opponent if it detects that a physical hit happened the previous frame.
			; Right after that, we're given visibility to those updated damage fields, so the opponent's
			; iPlInfo_MoveDamageVal gets copied to our iPlInfo_MoveDamageValOther.
			;
			; So, if that is empty, return immediately.
			;
			ld   hl, iPlInfo_MoveDamageValOther
			add  hl, bc							; Seek to iPlInfo_MoveDamageValOther
			ld   a, [hl]
			or   a								; iPlInfo_MoveDamageValOther == 0?
			jp   z, Play_Pl_SetHitType_RetClear	; If so, return
			
			;
			; Retrieve the move damage fields from the other player.
			;
			ld   d, [hl]				; D = iPlInfo_MoveDamageValOther
			inc  hl
			ld   e, [hl]				; E = iPlInfo_MoveDamageHitTypeIdOther
			inc  hl
			ld   a, [hl]				; A = iPlInfo_MoveDamageFlags3Other
			
			; Set that we weren't hit by a projectile
			ld   hl, iPlInfo_Flags0
			add  hl, bc					; Seek to iPlInfo_Flags0
			res  PF0B_PROJHIT, [hl]
			
			inc  hl						; Seek to iPlInfo_Flags1
			inc  hl						; Seek to iPlInfo_Flags2
			
			; Restore collision boxes to allow combo hits.
			res  PF2B_NOHURTBOX, [hl]
			res  PF2B_NOCOLIBOX, [hl]
			
			; Copy the opponent's iPlInfo_MoveDamageFlags3Other to our iPlInfo_Flags3 value
			inc  hl						; Seek to iPlInfo_Flags3
			ld   [hl], a				
			
			ld   a, e		; A = HitTypeId
			
			;
			; Perform extra validation before registering that we got damaged.
			;
			; First determine what type of damage move (set hit effect ID) this was, as set by the move code.
			; The hit effect IDs are grouped in a specific order:
			; - All standard hit/drop effects (including the end of a throw) use IDs < $0C
			; - ID $0C is used when starting a throw
			; - IDs > $0C are the rotation frames used for the "next" parts of a throw.
			;         Each character decides how to cycle between them.
			;
			; All of the validation to check if we can be grabbed happens at the start of the throw (HITTYPE_GRAB_START).
			; If the throw was already started (HitTypeId >= $0C) then we're definitely allowed to continue it.
			; (as long as we don't get throw tech, but that's handled elsewhere).
			;
			; The throws are also special since they never cause damage directly (read: as long as HitTypeId >= $10),
			; so when they are confirmed (.setThrowFlags) they just set some flags to force the throw state and jump 
			; directly to the end, skipping the damage evaluator. After returning, the HitTypeC for the throw will
			; then be executed, continuing the throw sequence.
			; The actual damage only happens the when the code for the throw sets HitTypeId < $0C, which makes
			; it count as a normal hit.
			;
			cp   HITTYPE_GRAB_START	; HitTypeId == $0C?
			jp   z, .chkThrow			; If so, jump
			cp   HITTYPE_GRAB_START	; HitTypeId >= $0C?
			jp   nc, .setThrowFlags		; If so, jump
			; Otherwise, iPlInfo_MoveDamageHitTypeIdOther < $0C, meaning it's a generic hit.
			jp   .chkHit
			
			;################
			;
			; THROWS
			;
		.chkThrow:
			;
			; Return immediately if the other player didn't start yet a throw.
			; Note this works in conjunction with the other player currently "waiting" in Play_Pl_ChkThrowInput.tryStart
			; or in MoveInputS_TryStartCommandThrow when starting a throw, which is when wPlayPlThrowActId got set 
			; to PLAY_THROWACT_START.
			;
			ld   a, [wPlayPlThrowActId]
			cp   PLAY_THROWACT_START				; wPlayPlThrowActId == $01?
			jp   nz, Play_Pl_SetHitType_RetClear	; If not, return
			
			;
			; If we got thrown by a special move (command throw), always allow the throw to continue.
			; The air/ground and invulnerability checks (PF1B_INVULN) also get ignored.
			;
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc					; Seek to iPlInfo_Flags0Other
			bit  PF0B_SPECMOVE, [hl]	; Is PF0B_SPECMOVE set?
			jp   nz, .setThrowFlags		; If so, jump
			
			;
			; Throws can either work for opponents in the air or on the ground.
			; Verify that we can be thrown depending on what was set as "opponent throw mode" (wPlayPlThrowOpMode).
			; 
			ld   a, [wPlayPlThrowOpMode]
			cp   PLAY_THROWOP_AIR		; Is it against airborne players?
			jr   z, .chkThrowForAir		; If so, jump
			jp   .chkThrowForGround		; Otherwise, it's against grounded players
			
			; [TCRF] Unreferenced broken code for a type that's only used for command throws. 
			; [BUG]  Broken indexing. "add  hl, bc" is missing, so it reads garbage value at address $0021.
			;        This is $FF, causing the check to always return.			
		.chkThrow_Unused_ForBoth:
			ld   hl, iPlInfo_Flags1
			bit  PF1B_INVULN, [hl]		; Are we invulnerable against throws?
			jp   nz, Play_Pl_SetHitType_RetClear	; If so, return
			jp   .setThrowFlags			; Otherwise, jump
			
		.chkThrowForGround:
		
			;
			; We must be on the ground for the throw to start.
			;
			ld   hl, iPlInfo_Flags0
			add  hl, bc					
			bit  PF0B_AIR, [hl]						; Are we in the air?
			jp   nz, Play_Pl_SetHitType_RetClear	; If so, return
			
			;
			; Standard invulnerability check.
			;
			inc  hl									; Seek to iPlInfo_Flags1
			bit  PF1B_INVULN, [hl]					; Are we invulnerable?
			jp   nz, Play_Pl_SetHitType_RetClear	; If so, return
			
			; OK
			jp   .setThrowFlags
	
		.chkThrowForAir:
		
			;
			; We must be in the air for the throw to start.
			;
			ld   hl, iPlInfo_Flags0
			add  hl, bc							; Seek to iPlInfo_Flags0
			bit  PF0B_AIR, [hl]					; Are we in the air?
			jp   z, Play_Pl_SetHitType_RetClear	; If not, return
			
		IF AIRTHROW_CPU == 0
			;
			; [POI] The CPU can't be thrown in the air.
			;
			bit  PF0B_CPU, [hl]						; Are we a CPU player?
			jp   nz, Play_Pl_SetHitType_RetClear	; If so, return
		ENDC
		
		.setThrowFlags:
			;
			; When the throw is confirmed, we can't block the hit at all
			; to reduce the damage.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc				; Seek to iPlInfo_Flags1
			res  PF1B_GUARD, [hl]	; Clear main guard flag
			
			; Throws don't cause damage directly.
			; Just set the updated hit effect ID from E and return.
			; After returning, the updated hit effect code will be executed:
			; - The first time we get here, it will be for HITTYPE_GRAB_START, which executes HitTypeC_GrabStart.
			;   That will handle the next part of the throw, from PLAY_THROWACT_START to PLAY_THROWACT_NEXT03.
			; - The next times are as part of the rotation frames, which is past the point throw tech is allowed.
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
			
			;################
			;
			; HIT
			;
		.chkHit:	
			;
			; If we're invulnerable we can't get damaged.
			; This also clears out the damage flashing effect, in case it was enabled when
			; the opponent's iPlInfo_MoveDamageFlags3Other was copied over to our iPlInfo_Flags3.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc								; Seek to iPlInfo_Flags1
			bit  PF1B_INVULN, [hl]					; Are we fully invulnerable?
			jp   z, Play_Pl_SetHitTypeC_ChkBlock	; If not, jump
			
			inc  hl			; Seek to iPlInfo_Flags2
			inc  hl			; Seek to iPlInfo_Flags3
			; Stop flashing 
			res  PF3B_FIRE, [hl]
			res  PF3B_SUPERALT, [hl]
			; Exit hit state
			jp   Play_Pl_SetHitType_RetClear
			;###
			
		;--------------------------------
		;
		; SHARED - Block Check.
		;
		Play_Pl_SetHitTypeC_ChkBlock:
			;
			; If we're blocking, determine if the attack was properly blocked.
			; If not, the guard is removed and we take full damage.
			; ie: blocking overheads while crouching
			;
			; Moves can be set to either require blocking low (PF3B_HITLOW) or to be overheads (PF3B_OVERHEAD).
			; Most moves don't set either flag, meaning they can be blocked in both ways.
			; The few unblockables have both PF3B_OVERHEAD and PF3B_HITLOW set at the same time.
			;
			; By default, special moves clear PF1B_GUARD, but a few moves set it.
			; The same exact logic applies when performing a special with PF1B_GUARD set.
			;
			ld   hl, iPlInfo_Flags1
			add  hl, bc									
			bit  PF1B_GUARD, [hl]					; Were we blocking the attack?
			jp   z, Play_Pl_SetHitTypeC_ApplyDamage	; If not, skip ahead
			bit  PF1B_CROUCH, [hl]					; Did we block low?
			jp   z, .onBlockMid						; If not, jump
		.onBlockLow:
			ld   hl, iPlInfo_Flags3
			add  hl, bc								; Seek to iPlInfo_Flags3
			bit  PF3B_OVERHEAD, [hl]				; Is this an overhead?
			jp   nz, Play_Pl_SetHitTypeC_BlockBypass	; If so, we got hit
			jp   Play_Pl_SetHitTypeC_Blocked			; Otherwise, we blocked it
		.onBlockMid:
			ld   hl, iPlInfo_Flags3
			add  hl, bc								; Seek to iPlInfo_Flags3
			bit  PF3B_HITLOW, [hl]					; Does the attack require blocking low?
			jp   nz, Play_Pl_SetHitTypeC_BlockBypass	; If so, we got hit
			jp   Play_Pl_SetHitTypeC_Blocked			; Otherwise, we blocked it
			
		Play_Pl_SetHitTypeC_Blocked:
			; Since we blocked the attack, remove the hit effect
			; so we can continue blocking.
			ld   e, $00
			jp   Play_Pl_SetHitTypeC_ApplyDamage
			
		Play_Pl_SetHitTypeC_BlockBypass:
			; We didn't guard the attack correctly.
			; This counts as a standard hit.
			
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			; Stop blocking the attack
			res  PF1B_GUARD, [hl]	
			
		;--------------------------------
		;
		; SHARED - Apply Damage
		;
		Play_Pl_SetHitTypeC_ApplyDamage:
			
			; Play_Pl_ApplyDamageToStats recalculates the values in DE, so save/restore it
			push de
				call Play_Pl_ApplyDamageToStats
			pop  de
			
		;--------------------------------
		;
		; SHARED - Set Hit Effect
		;
		Play_Pl_SetHitTypeC_SetHitType:
			;
			; Second pass to validate the effect to use when getting hit,
			; as it may get replaced with something else depending on the player status flags.
			; After this last series of checks in made, save it to iPlInfo_HitTypeId.
			;
			ld   a, e						; A = HitTypeId
			
			;
			; This is the first of many whitelists where some moves can't be overriden at all.
			; If a special move sets any of these, don't interfere and apply them directly.
			;
			; HITTYPE_HIT_MULTI0 and HITTYPE_HIT_MULTI1 in particular tend to be used by 
			; special moves that hit multiple times for every hit, so there's no escape
			; (unless something like a projectile hits at the right time, see the .chkOtherEscape
			; in many moves)
			;
			
			; These type IDs can always be used
			cp   HITTYPE_HIT_MULTI0
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_HIT_MULTI1
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_HIGH_UB
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_SWOOPUP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
		.chkDead:
			;
			; Getting KO'd restricts the number of allowed hit effects, as the player
			; has to visibily drop to the ground, something not all HitTypes do.
			;
			ld   hl, iPlInfo_Health
			add  hl, bc
			ld   a, [hl]
			or   a						; Do we have any health left?
			jp   nz, .notDead			; If so, jump
			
			ld   hl, iPlInfo_Flags1
			add  hl, bc					; Seek to our iPlInfo_Flags1
			res  PF1B_GUARD, [hl]		; Disable blocking
			
			; E = HitTypeId (Opponent)
			ld   hl, iPlInfo_MoveDamageHitTypeIdOther
			add  hl, bc					
			ld   a, [hl]				
			ld   e, a
			
			; There are different allowed HitTypes depending on whether we got
			; killed by a hit or a throw.
			ld   a, [wPlayPlThrowActId]
			or   a						; Did we get thrown?
			jp   nz, .deadThrown		; If so, jump
		.deadHit:
			; Getting KO'd by a normal always sets HITTYPE_LAUNCH_HIGH_UB.
			; For specials there's a whitelist.
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc					; Seek to opponent's status
			bit  PF0B_SPECMOVE, [hl]	; Did we get killed by a special move?
			jp   nz, .deadSpecHit		; If so, jump
			jp   .useStdDrop			; Otherwise, use HITTYPE_LAUNCH_HIGH_UB
		.deadThrown:
			; There are three allowed effects when getting KO's by a throw.
			; Otherwise, default to HITTYPE_LAUNCH_HIGH_UB.
			ld   a, e
			cp   HITTYPE_LAUNCH_FAST_DB						; HitTypeId == $09?
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId	; If so, jump
			cp   HITTYPE_LAUNCH_MID_UB_NOSTUN					; ...
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_SWOOPUP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			jp   .useStdDrop
		.deadSpecHit:
			; Whitelist of allowed hit effects when getting KO'd by a hit.
			; Otherwise, default to HITTYPE_LAUNCH_HIGH_UB.
			ld   a, e
			cp   HITTYPE_HIT_MULTI0
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_HIT_MULTI1
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_FAST_DB
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_MID_UB_NOSTUN
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_SWOOPUP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			jp   .useStdDrop
		.notDead:
			ld   a, e
			; If we didn't block the hit, determine if that got us dizzy.
			; Note that HITTYPE_BLOCKED got set previously by the subroutine, overriding
			; whatever the attack set when blocking it successfully.
			cp   HITTYPE_BLOCKED
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			
		.noBlock:
			call Play_Pl_IsDizzy	; Are we supposed to get dizzy on this hit?
			jp   nc, .noDizzy		; If not, jump
		.dizzy:
			; Handle the type blacklist when getting hit "right before getting" dizzy.
			; When getting dizzy, the player will drop to the ground regardless of the hit effect,
			; by overriding whatever effect was set with HITTYPE_LAUNCH_HIGH_UB (by reaching .useStdDrop).
			; However, the effects checked below can't be overridden.
			ld   a, e
			cp   HITTYPE_HIT_MULTI0
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_HIT_MULTI1
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_FAST_DB
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_MID_UB_NOSTUN
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_SWOOPUP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			jp   .useStdDrop
		.noDizzy:
		
			; Air and ground use different validations
			ld   a, e
			ld   hl, iPlInfo_Flags0
			add  hl, bc
			bit  PF0B_AIR, [hl]		; Are we in the air?
			jp   z, .noAir			; If not, jump
			
			;##
		.air:
			; HITTYPE_LAUNCH_SWOOPUP is always allowed when getting hit in the air
			; (alongside HITTYPE_LAUNCH_FAST_DB and HITTYPE_LAUNCH_MID_UB_NOSTUN...)
			cp   HITTYPE_LAUNCH_SWOOPUP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			
			;
			; When getting hit by a normal (but not a projectile here) in the air, the player recovers before touching the ground.
			; Otherwise, it's an hard drop.
			;
			bit  PF0B_PROJHIT, [hl]		; Did we get hit by a projectile?
			jp   nz, .useStdDrop		; If so, jump
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc				
			bit  PF0B_SPECMOVE, [hl]	; Did we get hit by a special move?
			jp   nz, .airSpec			; If so, jump
		.airNorm:
			;--
			; [POI] This is the same between .noAirNoSpec and .noAirSpec.
			;       It could have been moved before the PF0B_PROJHIT check.
			cp   HITTYPE_LAUNCH_FAST_DB
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_MID_UB_NOSTUN
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			;--
			jp   .useFarDrop		; Use HITTYPE_HIT_A
		.airSpec:
			;--
			; [POI] See above
			cp   HITTYPE_LAUNCH_FAST_DB
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			cp   HITTYPE_LAUNCH_MID_UB_NOSTUN
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			;--
			jp   .useStdDrop		; Use HITTYPE_LAUNCH_HIGH_UB
			;##
		.noAir:
			;
			; This is the only part that doesn't define default values.
			; When getting hit on the ground without getting dizzy or blocking,
			; every HitType value is valid as long as it doesn't get replaced
			; by the crouching checks.
			;
			
			; Projectiles force a normal mid hit
			bit  PF0B_PROJHIT, [hl]	; Did we get hit by a projectile?
			jp   nz, .useHitMid0	; If so, jump
			ld   hl, iPlInfo_Flags0Other
			add  hl, bc				
			bit  PF0B_SPECMOVE, [hl]	; Did we get hit by a special move?
			jp   nz, .setHit		; If so, jump
		.noAirNorm:
			; HITTYPE_SWEEP is always allowed
			cp   HITTYPE_SWEEP
			jp   z, Play_Pl_SetHitTypeC_SetHitTypeId
			
			; If we got hit by a normal while crouching, force use HITTYPE_HIT_LOW
			ld   hl, iPlInfo_Flags1
			add  hl, bc
			bit  PF1B_CROUCH, [hl]		; Are we crouching?
			jp   nz, .useHitLow			; If so, jump
			
			; Since we aren't in the air, we can't use the air drop hit (HITTYPE_LAUNCH_FAST_DB).
			; This game has no ground drop, so redirect it to a standard hit.
			cp   HITTYPE_LAUNCH_FAST_DB
			jp   z, .useHitMid1
			
			; Otherwise, use the existing value
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
		.setHit:
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
			
		.useHitMid0:
			ld   e, HITTYPE_HIT_MID0
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
		.useHitMid1:
			ld   e, HITTYPE_HIT_MID1
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
		.useStdDrop:
			ld   e, HITTYPE_LAUNCH_HIGH_UB
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
		.useFarDrop:
			ld   e, HITTYPE_HIT_A
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
		.useHitLow:
			ld   e, HITTYPE_HIT_LOW
			jp   Play_Pl_SetHitTypeC_SetHitTypeId
	
			
		Play_Pl_SetHitTypeC_SetHitTypeId:
			; Save the updated hit effect ID.
			; iPlInfo_HitTypeId = E
			ld   a, e			; A = E
			ld   hl, iPlInfo_HitTypeId
			add  hl, bc			; Seek to iPlInfo_HitTypeId
			ld   [hl], a		; Write it over
			
			; Return the same value to A, except multiplied by 2.
			; A = E * 2
			sla  a
			scf		; C flag set
		pop  de
	pop  bc
	ret
		Play_Pl_SetHitType_RetClear:
			or   a	; A = 0, C flag clear
		pop  de
	pop  bc
	ret
	
; =============== Play_Pl_ApplyDamageToStats ===============
; Applies the damage values and its related effects to the specified player.
; This is for specifically applying the stats, not the move, so:
; - Dizzy
; - POW meter
; - Special effects
; - Health
; IN
; - BC: Ptr to wPlInfo
Play_Pl_ApplyDamageToStats:

	;
	; D = Base damage value.
	;
	; Pick the correct damage field:
	; - If we got hit by a projectile, use the damage from the opponent's projectile.
	; - Otherwise, use the damage from the opponent we were given visibility to.
	;

	ld   hl, iPlInfo_Flags0
	add  hl, bc					; Seek to iPlInfo_Flags0
	bit  PF0B_PROJHIT, [hl]		; Did we get hit by a projectile?
	jr   nz, .chkDamageProj		; If so, jump
	
.getDamagePl:
	; We received a physical hit. 
	; Use the opponent damage we were given visibility to at iPlInfo_MoveDamageValOther.
	ld   hl, iPlInfo_MoveDamageValOther
	add  hl, bc				; Seek to iPlInfo_MoveDamageValOther
	ld   d, [hl]			; D = iPlInfo_MoveDamageValOther
	jr   .applyDamage
	
.chkDamageProj:
	; We got hit by a projectile.
	; Determine which wOBJInfo_Pl*Projectile struct to use, and use iOBJInfo_Play_DamageVal from there.
	ld   hl, iPlInfo_PlId
	add  hl, bc					; Seek to iPlInfo_PlId
	bit  0, [hl]				; wPlInfo_Pl == 2P?
	jp   nz, .use1P				; If so, 1P is the opponent. Use 1P's projectile's damage
.use2P:							; Otherwise, use 2P's one
	ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Play_DamageVal		 
	jp   .getDamageProj
.use1P:
	ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Play_DamageVal		
.getDamageProj:
	ld   d, [hl]				; D = iOBJInfo_Play_DamageVal
	;--
	
.applyDamage:

	; Don't do this when the time runs out
	ld   a, [wRoundTime]
	or   a
	jp   z, .ret
	
	; Apply a penalty to the appropriate stun timer, which is directly proportional to the damage received
	call Play_Pl_DecStunTimer
	
	; Increment POW meter by 3 lines
	call Play_Pl_IncPowOnHit
	;--
	
	; Finally, decrement the health.
	;
	; There is damage scaling done here:
	; Health $30-MAX -> Full damage
	; Health $18-$2F -> 3/4 damage
	; Health $00-$17 -> 1/2 damage
	;
	; Modify the damage value in D if we're doing the scaling.
	;
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]
	cp   $30			; Health >= $30?
	jp   nc, .chkBlock	; If so, jump
	cp   $18			; Health >= $18?
	jp   nc, .hLow	; If so, jump
	; Otherwise, health is < $18 (critical)
.hCritical:
	; 1/2
	srl  d		; D = D / 2
	jp   .chkBlock
.hLow:
	; 3/4
	ld   a, d
	srl  a		; A = Damage / 4
	srl  a
	srl  d		; D = Damage / 2
	add  a, d	; A += D
	ld   d, a
.chkBlock:

	;
	; If we blocked the attack, determine by how much damage should be reduced.
	;
	
	; Not applicable if we didn't block it
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	bit  PF1B_GUARD, [hl]	; Did we block the attack?
	jp   z, .chkPow			; If not, skip
	
	; Blocking a projectile, special or super move divides the damage by 8.
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_PROJHIT, [hl]	; Were we hit by a projectile?
	jr   nz, .damageDiv8	; If so, jump
	ld   hl, iPlInfo_Flags0Other
	add  hl, bc
	bit  PF0B_SPECMOVE, [hl]	; Were we hit by a special or super move?
	jp   nz, .damageDiv8	; If so, jump
	
	; Otherwise, we got hit by a normal.
	; Blocking a normal doesn't deal damage, so return.
	jp   .ret
	
.damageDiv8:
	srl  d	; D = D / 8
	srl  d
	srl  d
	
.chkPow:
	;
	; Moves deal 1/4th more damage at Max Power.
	;
	ld   hl, iPlInfo_PowOther
	add  hl, bc			; Seek to opponent POW meter
	ld   a, [hl]
	cp   PLAY_POW_MAX	; iPlInfo_PowOther == $28?
	jp   nz, .minCap	; If not, skip
	ld   a, d
	srl  a				; A = Damage / 4
	srl  a
	add  a, d			; A += Damage
	ld   d, a			; Damage = A
	
.minCap:
	;
	; If we got here, the minimum amount of damage received must be 1.
	;
	ld   a, d
	or   a				; Damage != 0?
	jr   nz, .subHealth	; If so, skip
	ld   d, $01			; Otherwise, Damage = 1
.subHealth:

	;
	; Finally, subtract the resulting damage to the health value.
	; If we underflow it, force it back to 0.
	;
	ld   hl, iPlInfo_Health
	add  hl, bc			; Seek to health
	ld   a, [hl]		; A = Health
	sub  a, d			; Health -= Damage
	jp   nc, .weird		; Health >= 0? If so, skip
	xor  a				; Otherwise, force it back in range
.weird:
	;--
	; [POI] Why
	cp   $00
	jp   nz, .setHealth
	;--
.setHealth:
	ld   [hl], a		; Save the health.
	
	;
	; If we just died, run the game at 33% for gameplay 40 frames.
	;
	or   a					; Health != 0?
	jp   nz, .ret			; If so, return
IF LESS_SLOWDOWN == 1
	ld   a, $0A				; For 10 frames...
	ld   [wPlaySlowdownTimer], a
	ld   a, $01				; Run gameplay every other frame
	ld   [wPlaySlowdownSpeed], a
ELSE
	ld   a, $28				; For 10 frames...
	ld   [wPlaySlowdownTimer], a
	ld   a, $02				; Run gameplay every three frames
	ld   [wPlaySlowdownSpeed], a
ENDC
.ret:
	ret
	
; =============== MoveInputS_CheckEasyMoveKeys ===============
; Checks if the player is holding a button combination used for the "Easy Moves" cheat.
; These combinations are activated by holding exactly either:
; - SELECT + A
; - SELECT + B
; And any character is assigned a move for each.
;
; IN
; - BC: Ptr to wPlInfo structure
; OUT
; - Z flag: If set, SELECT + A was pressed
; - C flag: If set, SELECT + B was pressed
MoveInputS_CheckEasyMoveKeys:
	; Only if the cheat is enabled
	ld   a, [wDipSwitch]
	bit  DIPB_EASY_MOVES, a
	jp   z, .none

	; Determine which key combination are holding
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc

	; SELECT + B
	ld   a, [hl]				; A = Held player keys
	and  a, KEY_SELECT|KEY_B	; Filter the required keys
	cp   KEY_SELECT|KEY_B		; Are we holding exactly SELECT+B (and nothing else)?
	jp   z, .selectB			; If so, jump

	; SELECT + A
	ld   a, [hl]				; A = Held player keys
	and  a, KEY_SELECT|KEY_A	; Filter the required keys
	cp   KEY_SELECT|KEY_A		; Are we holding exactly SELECT+A (and nothing else)?
	jp   z, .selectA			; If so, jump
.none:							; Otherwise, there's nothing here
	xor  a	; C flag clear, Z flag clear
	inc  a
	ret
.selectB:
	xor  a	; C flag set, Z flag clear
	inc  a
	scf
	ret
.selectA:
	xor  a	; C flag clear, Z flag set
	ret
	
; =============== END OF BANK ===============
; Junk area below.
IF REV_VER == VER_EU
	mIncJunk "L003F93"
ELSE
	; Contains various duplicates of the last few subroutines in the bank.
	mIncJunk "L003F5F"
ENDC
