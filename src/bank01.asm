; =============== Play_Main ===============
; The main gameplay loop.
; Should be executed alongside the two other tasks Play_DoPl_1P and Play_DoPl_2P.
Play_Main:
	ld   sp, $DD00
	; Initialize subsecond timer to 60 frames
	ld   a, 60
	ld   [wRoundTimeSub], a
	ei
	; Here we go
.mainLoop:
	call Play_ChkEnd
	call Play_DoPlInput
	call Play_ChkPause
	call Play_DoHUD
	call Play_DoMisc
	call Play_DoPlColi
	call Play_WriteKeysToBuffer
	call Play_DoScrollPos
	call Play_ExecExOBJCode
	call Task_PassControlFar
	jp   .mainLoop
	
; =============== Play_DoPlInput ===============
; Handles input for both players during gameplay.
; Essentially does some processing to the hJoyKeys fields before
; copying them to the player struct.
Play_DoPlInput:

	;
	; PLAYER 1
	;
	
	;
	; CPU inputs are faked separately by the AI.
	; This part handles only inputs read from the joypad (so, for human players).
	;
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	bit  PF0B_CPU, [hl]		; Is 1P CPU controlled?
	jp   nz, .cpu1P			; If so, jump ahead
	
	;
	; Copy over the raw joypad inputs to the player 1 struct
	;
	ldh  a, [hJoyKeys]
	ld   [wPlInfo_Pl1+iPlInfo_JoyKeys], a
	ldh  a, [hJoyNewKeys]
	ld   [wPlInfo_Pl1+iPlInfo_JoyNewKeys], a
	
	;--
	;
	; Generate a special version of iPlInfo_JoyNewKeys which keeps the directional keys bits,
	; and tells if the Punch (A) or Kick (B) buttons are for the light or heavy attacks.
	;
	; Effectively this removes the START and SELECT bits, but they aren't used for moves anyway
	; so who cares.
	;
	; The punch/kick is treated as heavy if the button is pressed, then held for 6 frames.
	; If it's released before 6 frames, it instead counts as a light.
	;
	
	; The lower nybble with directional keys is identical to what's in iPlInfo_JoyNewKeys.
	and  a, $0F
	ld   [wPlInfo_Pl1+iPlInfo_JoyNewKeysLH], a
	
	;
	; A Button - Check light/heavy counter for punches
	;
.aBufChk1P:

	; If we've started counting held frames already, jump
	ld   a, [wPlInfo_Pl1+iPlInfo_JoyHeavyCountA]
	or   a					; iPlInfo_JoyHeavyCountA != 0?
	jp   nz, .aBufNext1P	; If so, jump
	
	; Otherwise, check for having started to press A.
	; This prevents starting another punch if we were still holding A continuously.
	ldh  a, [hJoyNewKeys]
	bit  KEYB_A, a			; Pressed A just now?
	jp   z, .bBufChk1P		; If not, don't do anything
.aBufNext1P:
	; If we released A, reset the counter and set the LIGHT bit
	ldh  a, [hJoyKeys]
	bit  KEYB_A, a			; Holding A?
	jp   z, .aLight1P		; If not, jump
	
	; Otherwise, increase the held key timer.
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyHeavyCountA
	inc  [hl]
	
	; If we held it for less than 6 frames, don't do anything
	ld   a, $06			
	cp   a, [hl]			; iPlInfo_JoyHeavyCountA < 6?
	jp   nc, .bBufChk1P		; If so, jump
	
.aHeavy1P:
	; Set the heavy attack on A
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyNewKeysLH
	res  KEPB_A_LIGHT, [hl]
	set  KEPB_A_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_JoyHeavyCountA], a
	jp   .bBufChk1P
.aLight1P:
	; Set the light attack on A
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyNewKeysLH
	set  KEPB_A_LIGHT, [hl]
	res  KEPB_A_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_JoyHeavyCountA], a
	
.bBufChk1P:

	;
	; B Button - Check light/heavy counter for kicks.
	;

	; Check new/current
	ld   a, [wPlInfo_Pl1+iPlInfo_JoyHeavyCountB]
	or   a					
	jp   nz, .bBufNext1P
	
	ldh  a, [hJoyNewKeys]
	bit  KEYB_B, a
	jp   z, .endBufChk1P
.bBufNext1P:
	; Check if premature stop (LIGHT)
	ldh  a, [hJoyKeys]
	bit  KEYB_B, a
	jp   z, .bLight1P
	
	; Increase counter and check for 6 frames (HEAVY)
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyHeavyCountB
	inc  [hl]
	
	ld   a, $06			
	cp   a, [hl]
	jp   nc, .endBufChk1P
.bHeavy1P:
	; Set HEAVY B press
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyNewKeysLH
	res  KEPB_B_LIGHT, [hl]
	set  KEPB_B_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_JoyHeavyCountB], a
	jp   .endBufChk1P
.bLight1P:
	; Set LIGHT B press
	ld   hl, wPlInfo_Pl1+iPlInfo_JoyNewKeysLH
	set  KEPB_B_LIGHT, [hl]
	res  KEPB_B_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_JoyHeavyCountB], a
	
.endBufChk1P:
	jp   .do2P
	
.cpu1P:
	; Generate inputs for the CPU
	ld   bc, wPlInfo_Pl1
	ld   de, wOBJInfo_Pl1
	call HomeCall_Play_CPU_Do
	
.do2P:

	;
	; PLAYER 2
	; Do the same.
	;
	
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	bit  PF0B_CPU, [hl]		; Is 2P CPU controlled?
	jp   nz, .cpu2P			; If so, jump ahead
	
	;
	; Copy over the raw joypad inputs to the player 1 struct
	;
	ldh  a, [hJoyKeys2]
	ld   [wPlInfo_Pl2+iPlInfo_JoyKeys], a
	ldh  a, [hJoyNewKeys2]
	ld   [wPlInfo_Pl2+iPlInfo_JoyNewKeys], a

	;--
	; The lower nybble with directional keys is identical to what's in iPlInfo_JoyNewKeys.
	and  a, $0F
	ld   [wPlInfo_Pl2+iPlInfo_JoyNewKeysLH], a
	
	;
	; A Button - Check light/heavy counter for punches
	;
.aBufChk2P:

	; If we've started counting held frames already, jump
	ld   a, [wPlInfo_Pl2+iPlInfo_JoyHeavyCountA]
	or   a					; iPlInfo_JoyHeavyCountA != 0?
	jp   nz, .aBufNext2P	; If so, jump
	
	; Otherwise, check for having started to press A.
	; This prevents starting another punch if we were still holding A continuously.
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_A, a			; Pressed A just now?
	jp   z, .bBufChk2P		; If not, don't do anything
.aBufNext2P:
	; If we released A, reset the counter and set the LIGHT bit
	ldh  a, [hJoyKeys2]
	bit  KEYB_A, a			; Holding A?
	jp   z, .aLight2P		; If not, jump
	
	; Otherwise, increase the held key timer.
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyHeavyCountA
	inc  [hl]
	
	; If we held it for less than 6 frames, don't do anything
	ld   a, $06			
	cp   a, [hl]		; iPlInfo_JoyHeavyCountA < 6?
	jp   nc, .bBufChk2P	; If so, jump
	
.aHeavy2P:
	; Set the heavy attack on A
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyNewKeysLH
	res  KEPB_A_LIGHT, [hl]
	set  KEPB_A_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_JoyHeavyCountA], a
	jp   .bBufChk2P
.aLight2P:
	; Set the light attack on A
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyNewKeysLH
	set  KEPB_A_LIGHT, [hl]
	res  KEPB_A_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_JoyHeavyCountA], a
	
.bBufChk2P:

	;
	; B Button - Check light/heavy counter for kicks.
	;

	; Check new/current
	ld   a, [wPlInfo_Pl2+iPlInfo_JoyHeavyCountB]
	or   a					
	jp   nz, .bBufNext2P
	
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_B, a
	jp   z, .endBufChk2P
.bBufNext2P:
	; Check if premature stop (LIGHT)
	ldh  a, [hJoyKeys2]
	bit  KEYB_B, a
	jp   z, .bLight2P
	
	; Increase counter and check for 6 frames (HEAVY)
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyHeavyCountB
	inc  [hl]
	
	ld   a, $06			
	cp   a, [hl]
	jp   nc, .endBufChk2P
.bHeavy2P:
	; Set HEAVY B press
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyNewKeysLH
	res  KEPB_B_LIGHT, [hl]
	set  KEPB_B_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_JoyHeavyCountB], a
	jp   .endBufChk2P
.bLight2P:
	; Set LIGHT B press
	ld   hl, wPlInfo_Pl2+iPlInfo_JoyNewKeysLH
	set  KEPB_B_LIGHT, [hl]
	res  KEPB_B_HEAVY, [hl]
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_JoyHeavyCountB], a
.endBufChk2P:
	jp   .end
	
.cpu2P:
	; Generate inputs for the CPU
	ld   bc, wPlInfo_Pl2
	ld   de, wOBJInfo_Pl2
	call HomeCall_Play_CPU_Do
.end:
	ret
	 
; =============== Play_ChkPause ===============
; Handles pausing during gameplay.
;
; Any player can pause the game.
; However, only the player that paused the game can unpause it,
; as there are separate main loops for each player.
Play_ChkPause:

	; When pressing START, enter the paused state.
	ldh  a, [hJoyNewKeys]
	and  a, KEY_START		; Did 1P press START?
	jp   z, .chk2P			; If not, skip
	
	;
	; As long as the game is paused, this main loop takes exclusive control.
	;
	ld   hl, wPauseFlags
	set  PLB1, [hl]		; Set pause flag
	call Play_Pause
.mainLoop1P:
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a		; Pressed START?
	jp   nz, .unpause1P		; If so, unpause the game
	bit  KEYB_SELECT, a		; Pressed SELECT?
	jp   nz, .frameAdv1P	; If so, frame advance
	; Skip other tasks to freeze players and pause the music
	call Task_SkipAllAndWaitVBlank
	jp   .mainLoop1P
.frameAdv1P:
	call Play_FrameAdv
	jp   .mainLoop1P
.unpause1P:
	call Play_Unpause
	ld   hl, wPauseFlags
	res  PLB1, [hl]		; Unset pause flag
	ret
	
.chk2P:
	ldh  a, [hJoyNewKeys2]
	and  a, KEY_START		; Did 2P press START?
	jp   z, .ret			; If not, return
	;
	; As long as the game is paused, this main loop takes exclusive control.
	;
	ld   hl, wPauseFlags
	set  PLB2, [hl]		; Set pause flag
	call Play_Pause
.mainLoop2P:
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a		; Pressed START?
	jp   nz, .unpause2P		; If so, unpause the game
	bit  KEYB_SELECT, a		; Pressed SELECT?
	jp   nz, .frameAdv2P	; If so, frame advance
	; Skip other tasks to freeze players and pause the music
	call Task_SkipAllAndWaitVBlank
	jp   .mainLoop2P
.frameAdv2P:
	call Play_FrameAdv
	jp   .mainLoop2P
.unpause2P:
	call Play_Unpause
	ld   hl, wPauseFlags
	res  PLB2, [hl]		; Unset pause flag
	ret
.ret:
	ret
	
; =============== Play_Pause ===============
; Pauses the game.
Play_Pause:
	; Stop player animations
	ld   a, $01
	ld   [wNoCopyGFXBuf], a
	
	; Draw "PAUSE" on the HUD.
	; This gets drawn to the side of the player that paused the game.
	ld   a, [wPauseFlags]
	bit  PLB1, a		; Did 1P pause the game?
	jp   z, .bg2P		; If not, jump
.bg1P:
	ld   hl, vBGPause1P	; HL = Tilemap ptr for 1P side
	jp   .drawBG
.bg2P:
	ld   hl, vBGPause2P	; HL = Tilemap ptr for 2P side
.drawBG:
	; This uses tile IDs $FB-$FF.
	ld   b, $05			; B = Number of tiles
	ld   a, $FB			; A = Initial tile ID	
.loop:
	push af
	di
	mWaitForVBlankOrHBlank
	pop  af
	ldi  [hl], a		; Write tile ID, VRAMPtr++
	ei
	inc  a				; TileID++
	dec  b				; Drawn all tiles?
	jp   nz, .loop		; If not, loop
	
	call Task_PassControlFar
	ret
	
; =============== Play_Unpause ===============
; Unpauses the game.
Play_Unpause:
	; Resume player animations
	xor  a
	ld   [wNoCopyGFXBuf], a
	
	; Blank out "PAUSE" from the HUD
	ld   a, [wPauseFlags]
	bit  PLB1, a		; Did 1P pause the game?
	jp   z, .bg2P		; If not, jump
.bg1P:
	ld   hl, vBGPause1P	; HL = Tilemap ptr for 1P side
	jp   .drawBG
.bg2P:
	ld   hl, vBGPause2P	; HL = Tilemap ptr for 2P side
.drawBG:
	; Fill with blank ($00) tiles
	ld   b, $05			; B = Number of tiles
.loop:
	di
	mWaitForVBlankOrHBlank
	xor  a				
	ldi  [hl], a		; Write blank tile, VRAMPtr++
	ei
	dec  b				; Drawn all tiles?
	jp   nz, .loop		; If not, loop
	ret
	
; =============== Play_FrameAdv ===============
; Advances the game by a single frame.
Play_FrameAdv:
	; This unpauses the game, and executes gameplay code for a frame.
	; After it's done, the game is repaused.
	xor  a					; Enable player animations
	ld   [wNoCopyGFXBuf], a
	ld   a, [wPauseFlags]	; Save pause info
	push af
		xor  a					; Unpause the game
		ld   [wPauseFlags], a
		; Execute gameplay routines
		call Play_DoPlInput
		call Play_DoHUD
		call Play_DoMisc
		call Play_DoPlColi
		call Play_WriteKeysToBuffer
		call Play_DoScrollPos
		call Play_ExecExOBJCode
		call Task_PassControlFar
	pop  af					; Repause the game
	ld   [wPauseFlags], a
	ld   a, $01				; Pause player animations
	ld   [wNoCopyGFXBuf], a
	ret
	
; =============== Play_DoMisc ===============
; Handles miscelanneous actions related to gameplay / moves.
Play_DoMisc:

;
; OBJ FLASHING
;

; =============== mFlashPlPal ===============
; Generates code to handle the palette flashing/cycling effects for sprites.
; This is a palette cycle effect based off wPlayTimer and an incrementing internal counter.
; wPlayTimer is used as we want the effect to pause while the game is paused.
;
; There are 4 different ways the palette is cycled:
; - Palette Set A:
;   - Super Move -> Hit by any super move
; - Palette Set B:
;   - Hit by fire
;   - Super Move -> A few super moves use the second palette cycle
;
; IN
; - 1: Ptr to wPlInfo struct
; - 2: Ptr to wOBJInfo struct
; - 3: Ptr to target palette
; - 4: Normal palette
; - 5: Set A, Id 0 color
; - 6: Set A, Id 1 color
; - 7: Set A, Id 2 color
; - 8: Set A, Id 3 color
; - 9: Set B, Id 0 color
; - 10: Set B, Id 1 color
; - 11: Set B, Id 2 color
; - 12: Set B, Id 3 color
MACRO mFlashPlPal
	; These two use palette set B
	ld   a, [\1+iPlInfo_Flags3]
	bit  PF3B_FIRE, a		; bit1 set?	
	jp   nz, .flashSlowB	; If so, jump
	bit  PF3B_SUPERALT, a	; bit6 set?	
	jp   nz, .flashSuperB	; If so, jump
	
	jp   .flashSuperA
	
.flashSlowB:
	;
	; OBJ FLASHING (Set B) - HIT BY FIRE
	; When hit by a fire attack, cycle the palette slowly.
	; 
	
	; PalId = (++iOBJInfo_Play_FlashTimer & $0F) / 4) % 4
	ld   a, [\2+iOBJInfo_Play_FlashTimer]
	inc  a
	ld   [\2+iOBJInfo_Play_FlashTimer], a
	and  a, $0F
	srl  a
	srl  a
	jp   .flashB
	
.flashSuperB:
	;
	; OBJ FLASHING (Set B) - SUPER MOVE
	; The player flashes at max speed when hit by some special moves, quickly cycle the palette.
	; Like .flashSuperA, the player flashes at max speed for the duration of the super move.
	; However, individual hits can set PF3_SUPERALT to make them use the alternate palette.
	; 
	; PalId = ++iOBJInfo_Play_FlashTimer % 4
	;
	ld   a, [\2+iOBJInfo_Play_FlashTimer]
	inc  a
	ld   [\2+iOBJInfo_Play_FlashTimer], a
	and  a, $03
.flashB:
	; Palette cycle B.
	; Pick the palette by ID
	cp   $01			; PalId == 1?
	jp   z, .flashB1	; If so, jump
	cp   $02			; ...
	jp   z, .flashB2
	cp   $03
	jp   z, .flashB3
.flashB0:				; Otherwise, PalId == 0
	ld   a, \9
	jp   .setPalB
.flashB1:
	ld   a, \<10>
	jp   .setPalB
.flashB2:
	ld   a, \<11>
	jp   .setPalB
.flashB3:
	ld   a, \<12>
.setPalB:
	ldh  [\3], a
	jp   .endFlash
	
.flashSuperA:
	;
	; OBJ FLASHING (Set A) - SUPER MOVE
	;
	; The player flashes at max speed for the duration of the super move.
	;
	; PalId = ++wPlayTimer % 4
	; 
	ld   a, [\1+iPlInfo_Flags0]
	bit  PF0B_SUPERMOVE, a
	jp   z, .useNormPal
	ld   a, [\2+iOBJInfo_Play_FlashTimer]
	inc  a
	ld   [\2+iOBJInfo_Play_FlashTimer], a
	and  a, $03
.flashA:
	; Palette cycle A
	; Pick the palette by ID
	cp   $01			; PalId == 1?
	jp   z, .flashA1	; If so, jump
	cp   $02			; ...
	jp   z, .flashA2
	cp   $03
	jp   z, .flashA3
.flashA0:				; Otherwise, PalId == 0
	ld   a, \5
	jp   .setPalA
.flashA1:
	ld   a, \6
	jp   .setPalA
.flashA2:
	ld   a, \7
	jp   .setPalA
.flashA3:
	ld   a, \8
.setPalA:
	ldh  [\3], a
	jp   .endFlash
.useNormPal:
	ld   a, \4
	ldh  [\3], a
.endFlash:
ENDM

;                                                                   NORM | SET A          | SET B	
Play_DoMisc_FlashOBJ1P: mFlashPlPal wPlInfo_Pl1, wOBJInfo_Pl1, rOBP0, $8C, $8C,$0C,$8C,$80, $4C,$D0,$34,$54
; Fall-through
Play_DoMisc_FlashOBJ2P: mFlashPlPal wPlInfo_Pl2, wOBJInfo_Pl2, rOBP1, $4C, $4C,$0C,$4C,$40, $8C,$E0,$38,$A8
; Fall-through

Play_DoMisc_ApplyHitstop:
	; Copy over value
	ld   a, [wPlayHitstopSet]
	ld   [wPlayHitstop], a
	
Play_DoMisc_ClearInputProcOnStop:	
	; If inputs aren't processed, clear out the existing fields from both players
	ld   a, [wMisc_C027]
	bit  MISCB_PLAY_STOP, a
	jr   z, .end
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_JoyKeys], a
	ld   [wPlInfo_Pl1+iPlInfo_JoyNewKeysLH], a
	ld   [wPlInfo_Pl1+iPlInfo_JoyNewKeys], a
	ld   [wPlInfo_Pl2+iPlInfo_JoyKeys], a
	ld   [wPlInfo_Pl2+iPlInfo_JoyNewKeysLH], a
	ld   [wPlInfo_Pl2+iPlInfo_JoyNewKeys], a
.end:
	
Play_DoMisc_CalcDistance:
	call Play_CalcPlDistanceAndXFlip
	
Play_DoMisc_SetPlProjFlag:

	;
	; Update the player status flag marking if a projectile is visible & active on-screen.
	; This flag will be used as a shortcut to avoid checking two different fields every time
	;
	
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	res  PF0B_PROJ, [hl]		; Reset the flag to zero
	
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Status]
	and  a, OST_VISIBLE		; Is the projectile visible?
	jr   z, .do2P			; If not, skip
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Play_DamageVal]
	or   a					; Is there a penalty assigned to it (ie: it was thrown)?
	jr   z, .do2P			; If not, skip
	
	set  PF0B_PROJ, [hl] 	; Otherwise, don
	
.do2P:
	; Do the same for 2P
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	res  PF0B_PROJ, [hl]
	
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Status]
	and  a, OST_VISIBLE
	jr   z, .end
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Play_DamageVal]
	or   a
	jr   z, .end
	set  PF0B_PROJ, [hl]
.end:
	
Play_DoMisc_ShareVars:
	; Give visibility to some of the other player's variables.
	; This gives functions receiving the player struct known locations
	; to read data for the other player without having to do manual offset checks.
	
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]		; Copy 1P status...
	ld   [wPlInfo_Pl2+iPlInfo_Flags0Other], a	; ...to 2P player's struct
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags1]		; And so on
	ld   [wPlInfo_Pl2+iPlInfo_Flags1Other], a
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags2]
	ld   [wPlInfo_Pl2+iPlInfo_Flags2Other], a
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags3]
	ld   [wPlInfo_Pl2+iPlInfo_Flags3Other], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	ld   [wPlInfo_Pl1+iPlInfo_Flags0Other], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags1]
	ld   [wPlInfo_Pl1+iPlInfo_Flags1Other], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags2]
	ld   [wPlInfo_Pl1+iPlInfo_Flags2Other], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags3]
	ld   [wPlInfo_Pl1+iPlInfo_Flags3Other], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlags]
	ld   [wPlInfo_Pl2+iPlInfo_OBJInfoFlagsOther], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlags]
	ld   [wPlInfo_Pl1+iPlInfo_OBJInfoFlagsOther], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	ld   [wPlInfo_Pl2+iPlInfo_OBJInfoXOther], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   [wPlInfo_Pl1+iPlInfo_OBJInfoXOther], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   [wPlInfo_Pl2+iPlInfo_OBJInfoYOther], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   [wPlInfo_Pl1+iPlInfo_OBJInfoYOther], a
	ld   a, [wPlInfo_Pl1+iPlInfo_Pow]
	ld   [wPlInfo_Pl2+iPlInfo_PowOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Pow]
	ld   [wPlInfo_Pl1+iPlInfo_PowOther], a
	ld   a, [wPlInfo_Pl1+iPlInfo_MoveId]
	ld   [wPlInfo_Pl2+iPlInfo_MoveIdOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_MoveId]
	ld   [wPlInfo_Pl1+iPlInfo_MoveIdOther], a
	ld   a, [wPlInfo_Pl1+iPlInfo_HitTypeId]
	ld   [wPlInfo_Pl2+iPlInfo_HitTypeIdOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_HitTypeId]
	ld   [wPlInfo_Pl1+iPlInfo_HitTypeIdOther], a
	
Play_DoMisc_ResetDamage:
	;
	; If we got hit *DIRECTLY* by the opponent the last frame (doesn't matter if we blocked it):
	; - Reset physical damage-related variables to prevent the move from causing continuous damage every frame
	; - Allow the opponent to combo off the hit.
	;
	; Note this isn't applicable to projectile hits, they are handled by the collision check code.
	; This is, however, applicable to parts of the throw sequence.
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_PhysHitRecv]
	or   a										; Did we get hit by the opponent?
	jr   z, .chkHit2P							; If not, skip
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_MoveDamageVal], a	; Prevent the move from dealing further damage
	ld   [wPlInfo_Pl1+iPlInfo_PhysHitRecv], a	; Unmark damage received flag
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags1
	set  PF1B_ALLOWHITCANCEL, [hl] 				; Allow the opponent to start a new special off the hit
	inc  hl
	res  PF2B_NODAMAGERATE, [hl]				; Clear on first hit
.chkHit2P:
	; Same for the 2P side
	ld   a, [wPlInfo_Pl2+iPlInfo_PhysHitRecv]
	or   a					; Did we get hit by the opponent?
	jr   z, .copyDamageVars	; If not, skip
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_MoveDamageVal], a
	ld   [wPlInfo_Pl2+iPlInfo_PhysHitRecv], a
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags1
	set  PF1B_ALLOWHITCANCEL, [hl]
	inc  hl
	res  PF2B_NODAMAGERATE, [hl]
	
.copyDamageVars:
	; Give visibility to the player-to-player push request
	ld   a, [wPlInfo_Pl1+iPlInfo_PushSpeedHReq]
	ld   [wPlInfo_Pl2+iPlInfo_PushSpeedHRecv], a
	ld   a, [wPlInfo_Pl2+iPlInfo_PushSpeedHReq]
	ld   [wPlInfo_Pl1+iPlInfo_PushSpeedHRecv], a
	
	; Give visibility to the move damage fields, which get copied over in the VBlank GFX Buffer handler.
	ld   hl, wPlInfo_Pl1+iPlInfo_MoveDamageVal
	ld   bc, wPlInfo_Pl2+iPlInfo_MoveDamageValOther
	call Play_CopyHLtoBC_3
	ld   hl, wPlInfo_Pl1+iPlInfo_MoveDamageValNext
	ld   bc, wPlInfo_Pl2+iPlInfo_MoveDamageValNextOther
	call Play_CopyHLtoBC_3
	ld   hl, wPlInfo_Pl2+iPlInfo_MoveDamageVal
	ld   bc, wPlInfo_Pl1+iPlInfo_MoveDamageValOther
	call Play_CopyHLtoBC_3
	ld   hl, wPlInfo_Pl2+iPlInfo_MoveDamageValNext
	ld   bc, wPlInfo_Pl1+iPlInfo_MoveDamageValNextOther
	call Play_CopyHLtoBC_3
	
; =============== Play_DoMisc_DecMaxPow1P ===============
; Automatically decrement the Max Power meter over time.
; Unlike 96, this is exclusively where Max Pow mode is decremented.
Play_DoMisc_DecMaxPow1P: 
	; Pass the gauntlet of checks before checking if the bar should be decremented.
	ld   a, [wPlInfo_Pl1+iPlInfo_Pow]
	; If our POW Meter got zeroed out, immediately disable MAX Power mode.
	cp   $00			; iPlInfo_Pow == 0?
	jp   z, .powEmpty	; If so, jump
	; The bar must be full, otherwise this can't be MAX Power mode.
	cp   PLAY_POW_MAX	; Is the POW bar full?
	jp   nz, .end		; If not, skip
	; Decrement the Max Mode timer if it's != 0.
	; Otherwise, end MAX mode and reset the Pow meter.
	ld   a, [wPlInfo_Pl1+iPlInfo_MaxPow]
	cp   $00			; Are we in MAX Power mode (!= 0)?
	jp   nz, .tryDec	; If so, jump (decrement it)
.powEmpty:
	; Empty the MAX Power meter
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_Pow], a
	ld   [wPlInfo_Pl1+iPlInfo_MaxPow], a
	jp   .end
.tryDec:
	;
	; Decrement the Max Power meter timer every 8 frames.
	;
	
	; The meter never decrements in powerup mode
	ld   hl, wDipSwitch
	bit  DIPB_POWERUP, [hl]
	jp   nz, .end
	
	; Every 8 frames...
	ld   a, [wTimer]
	and  a, $07
	jp   nz, .end
	
	; ...tick it down.
	ld   hl, wPlInfo_Pl1+iPlInfo_MaxPow
	dec  [hl]
.end:

; =============== Play_DoMisc_DecMaxPow1P ===============
; Automatically decrement the Max Power meter over time.
Play_DoMisc_DecMaxPow2P: 
	; Pass the gauntlet of checks before checking if the bar should be decremented.
	ld   a, [wPlInfo_Pl2+iPlInfo_Pow]
	
	; If our POW Meter got zeroed out, immediately disable MAX Power mode.
	cp   $00			; iPlInfo_Pow == 0?
	jp   z, .powEmpty	; If so, jump
	; The bar must be full, otherwise this can't be MAX Power mode.
	cp   PLAY_POW_MAX	; Is the POW bar full?
	jp   nz, .end		; If not, skip
	
	;--
	; [POI] For some bizzare reason, Max POW mode for 2P ends when the timer gets to 1.
	;       This means it lasts 8 less frames compared to 1P.
	;       
	; Decrement the Max Mode timer if it's *>* 1.
	; Otherwise, end MAX mode and reset the Pow meter.
	ld   a, [wPlInfo_Pl2+iPlInfo_MaxPow]
	cp   $00			; MaxPowTimer == 0?
	jp   z, .end		; If so, don't do anything
	cp   $01			; MaxPowTimer != 1?
	jp   nz, .tryDec	; If so, jump
	;--
.powEmpty:
	; Empty the MAX Power meter
	xor  a
	ld   [wPlInfo_Pl2+iPlInfo_Pow], a
	ld   [wPlInfo_Pl2+iPlInfo_MaxPow], a
	jp   .end
.tryDec:
	;
	; Decrement the Max Power meter timer every 8 frames.
	;
	
	; The meter never decrements in powerup mode
	ld   hl, wDipSwitch
	bit  DIPB_POWERUP, [hl]
	jp   nz, .end
	
	; Every 8 frames...
	ld   a, [wTimer]
	and  a, $07
	jp   nz, .end
	
	; ...tick it down.
	ld   hl, wPlInfo_Pl2+iPlInfo_MaxPow
	dec  [hl]
.end:

; =============== mIncPlPow ===============
; Generates code to increment the normal POW meter if possible.
; This also handles the cheat for the meter powerup.
; If that cheat is enabled, the meters increment automatically and increments/decrements slower.
;
; IN
; - 1: Ptr to player struct
MACRO mIncPlPow
	; Don't increment if the meter is at max value already
	ld   a, [\1+iPlInfo_Pow]
	cp   PLAY_POW_MAX		; Pow meter at max value?
	jp   z, .end			; If so, skip
	
	; When charging meter, increment at 0.5px/frame
	ld   a, [\1+iPlInfo_MoveId]
	cp   MOVE_SHARED_CHARGEMETER	; In the charge move?
	jp   nz, .end					; If not, jump
	
	; Try to increment the pow meter
	ld   a, [wTimer]
	and  a, $01						; wPlayTimer & 1 != 0?
	jp   nz, .end					; If so, skip
	; Otherwise, iPlInfo_Pow++
	ld   hl, \1+iPlInfo_Pow
	inc  [hl]
	
	; If we reached the max value for the power bar, set the Max Power Timer
	ld   a, [hl]
	cp   PLAY_POW_MAX		; Max power reached?
	jp   nz, .end			; If not, skip
	; Otherwise, init iPlInfo_MaxPow
	ld   hl, \1+iPlInfo_MaxPow
	ld   [hl], $78
.end:
ENDM
	
Play_DoMisc_IncPow1P: mIncPlPow wPlInfo_Pl1
Play_DoMisc_IncPow2P: mIncPlPow wPlInfo_Pl2

; =============== mDecPlPow ===============
; Generates code to decrement the normal POW meter when the other player is taunting.
; IN
; - 1: Ptr to player struct
; - 2: Ptr to other player struct
MACRO mDecPlPow
	; Only applicable if we're not at Max Power and there's something in the bar
	ld   a, [\1+iPlInfo_Pow]
	cp   PLAY_POW_MAX	; Is the current player at max power?
	jp   z, .end		; If so, skip
	cp   $00			; Is the current player's power bar empty?
	jp   z, .end		; If so, skip
	
	; If the other player is taunting, decrease the meter at 0.25px/frame
	ld   a, [\2+iPlInfo_MoveId]
	cp   MOVE_SHARED_TAUNT	; Is the other player taunting?
	jp   nz, .end			; If not, skip
	ld   a, [wTimer]
	and  a, $03				; wTimer % 4 != 0?
	jp   nz, .end			; If so, skip
	
.doDec:
	ld   hl, \1+iPlInfo_Pow	; Otherwise, Pow--
	dec  [hl]
.end:
ENDM

Play_DoMisc_DecPowOnTaunt1P: mDecPlPow wPlInfo_Pl1, wPlInfo_Pl2
Play_DoMisc_DecPowOnTaunt2P: mDecPlPow wPlInfo_Pl2, wPlInfo_Pl1

; =============== mDecDizzy ===============
; Generates code to decrement the dizzy timer.
; IN
; - 1: Ptr to player struct
MACRO mDecDizzy
	; The dizzy timer has two purposes here:
	; - If the player is dizzy, it's how much time before the player snaps out of it.
	; - If the player isn't dizzy, it's how much time before the hit counter is reset.
	;   Each hit received increments the counter, and whenever it reaches the target,
	;   the player gets dizzy.
	
	; If the dizzy timer is fully elapsed, reset the counter.
	; This is something to do for both of the aforemented purposes.
	ld   a, [\1+iPlInfo_DizzyTimeLeft]
	or   a				; DizzyTimer != 0?
	jp   nz, .isDizzy	; If so, jump
.clrDizzy:
	; Otherwise, we either snapped out, or we didn't hit for a while.
	; Reset the counter.
	ld   [\1+iPlInfo_DizzyHitCount], a
	jp   .end
.isDizzy:
	; The dizzy timer is paused until the player is vulnerable.
	ld   a, [\1+iPlInfo_Flags1]
	bit  PF1B_INVULN, a		; Invulnerable?
	jp   nz, .end			; If so, skip
	; Decrement it once every 8 frames
	ld   a, [wTimer]
	and  a, $07
	jp   nz, .end
	ld   hl, \1+iPlInfo_DizzyTimeLeft
	dec  [hl]
.end:
ENDM

Play_DoMisc_DecDizzyTimer1P: mDecDizzy wPlInfo_Pl1
Play_DoMisc_DecDizzyTimer2P: mDecDizzy wPlInfo_Pl2
	
Play_DoMisc_DecNoThrowTimers:
	; Decrement the wake up timer if it's not 0 already
	; iPlInfo_NoThrowTimer = MAX(iPlInfo_NoThrowTimer - 1, 0)
	ld   a, [wPlInfo_Pl1+iPlInfo_NoThrowTimer]
	or   a				; Timer == 0?
	jr   z, .chk2P		; If so, jump
	ld   hl, wPlInfo_Pl1+iPlInfo_NoThrowTimer
	dec  [hl]
.chk2P:
	; Do the same for 2P
	ld   a, [wPlInfo_Pl2+iPlInfo_NoThrowTimer]
	or   a
	jr   z, .end
	ld   hl, wPlInfo_Pl2+iPlInfo_NoThrowTimer
	dec  [hl]
.end:

Play_DoMisc_ShareThrowTimerVars:
	; Give visibility to throw-related timers
	ld   a, [wPlInfo_Pl1+iPlInfo_NoThrowTimer]
	ld   [wPlInfo_Pl2+iPlInfo_NoThrowTimerOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_NoThrowTimer]
	ld   [wPlInfo_Pl1+iPlInfo_NoThrowTimerOther], a
	; [TCRF] This one too
	ld   a, [wPlInfo_Pl1+iPlInfo_Unused_ThrowKeyTimer]
	ld   [wPlInfo_Pl2+iPlInfo_Unused_ThrowKeyTimerOther], a
	ld   a, [wPlInfo_Pl2+iPlInfo_Unused_ThrowKeyTimer]
	ld   [wPlInfo_Pl1+iPlInfo_Unused_ThrowKeyTimerOther], a
	ret
	
; =============== Play_CopyHLtoBC_3 ===============
; Copies three bytes from HL to BC in sequence, used to copy sets of
; data across the two player structs. 
; IN
; - HL: Ptr to source (wPlInfo entry)
; - BC: Ptr to destination (wPlInfo entry for the other player)
Play_CopyHLtoBC_3:
	ldi  a, [hl]	; Read from current player
	ld   [bc], a	; Write to other player
	inc  bc			; ...
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	ld   a, [hl]
	ld   [bc], a
	ret
	
; =============== Play_CalcPlDistanceAndXFlip ===============
; Calculates the distance between players, and between player and projectile.
; This also sets additional properties related to distances.
Play_CalcPlDistanceAndXFlip:

	;
	; 1P CHAR - 2P CHAR DISTANCE
	;
	; These related flags which are related to each other are also updated:
	; - SPRB_XFLIP
	; - SPRXB_PLDIR_R
	;
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   b, a							; B = Player 2 X position
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; A = Player 1 X position
	sub  a, b				; A = Distance between players (1P - 2P)	
	jp   z, .setDistance	; Are they the same? If so, skip ahead
	jp   nc, .onRight		; Is 1P on the right of 2P? If so, jump (1P > 2P)
	; 
.onLeft:

	;
	; Player 1 is on the left of Player 2.
	;
	push af		; Save distance
	
	.onLeftChk1P:
		; The other player (2P) internally faces right
		ld   hl, wOBJInfo_Pl1+iOBJInfo_OBJLstFlags
		set  SPRXB_PLDIR_R, [hl]
		
		; Sometimes, the horizontal flip flag may get locked.
		; ie: when jumping over another player, we don't want to change direction
		ld   a, [wPlInfo_Pl1+iPlInfo_Flags1]
		bit  PF1B_XFLIPLOCK, a	; X Flip lock flag set?
		jp   nz, .onLeftChk2P	; If so, skip
		
		; Like the icons, character sprites face left by default.
		; Set the XFlip flag to make 1P face right.
		set  SPRB_XFLIP, [hl]
		
		;
		; Save the settings to iOBJInfo_OBJLstFlagsView as well, if possible.
		; This can be done only after the GFX finish loading (which also copies
		; iOBJInfo_OBJLstFlags to iOBJInfo_OBJLstFlagsView, but as we updated it just now, we resave it again)
		;
		ld   a, [wOBJInfo_Pl1+iOBJInfo_Status]
		bit  OSTB_GFXLOAD, a		; Are the GFX loading for this character?
		jp   nz, .onLeftChk2P		; If so, skip
		ld   a, [wPlInfo_Pl1+iPlInfo_MoveId]
		or   a						; Is there a move ID defined?
		jp   z, .onLeftChk2P		; If not, skip
		ldi  a, [hl]				; Read iOBJInfo_OBJLstFlags
		ld   [hl], a				; Write to iOBJInfo_OBJLstFlagsView
		
	.onLeftChk2P:
		; The other player (1P) internally faces left
		ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstFlags
		res  SPRXB_PLDIR_R, [hl]
		
		; Don't make the character face left if the direction is locked
		ld   a, [wPlInfo_Pl2+iPlInfo_Flags1]
		bit  PF1B_XFLIPLOCK, a
		jr   nz, .onLeftChkEnd
		
		; Make 2P face left
		res  SPRB_XFLIP, [hl]
		
		; Save the settings to the visible set, if possible.
		ld   a, [wOBJInfo_Pl2+iOBJInfo_Status]
		bit  OSTB_GFXLOAD, a		; Are the GFX loading for this character?
		jp   nz, .onLeftChkEnd		; If so, skip
		ld   a, [wPlInfo_Pl2+iPlInfo_MoveId]
		or   a						; Is there a move ID defined?
		jp   z, .onLeftChkEnd		; If not, skip
		ldi  a, [hl]				; Read iOBJInfo_OBJLstFlags
		ld   [hl], a				; Write to iOBJInfo_OBJLstFlagsView
	.onLeftChkEnd:
	
	pop  af		; Restore distance
	
	; Since 1P is on the left of 2P, the 1P - 2P calculation returned a negative value.
	; iPlInfo_PlDistance must be a positive value, so:
	cpl			; A = -A
	inc  a
	jr   .setDistance
	
.onRight:
	;
	; Player 1 is on the right of Player 2.
	;
	push af
	
	.onRightChk1P:
		; The current player (2P) internally faces left
		ld   hl, wOBJInfo_Pl1+iOBJInfo_OBJLstFlags
		res  SPRXB_PLDIR_R, [hl]
		
		; Don't make the character face left if the direction is locked
		ld   a, [wPlInfo_Pl1+iPlInfo_Flags1]
		bit  PF1B_XFLIPLOCK, a		; X Flip lock flag set?
		jr   nz, .onRightChk2P		; If so, skip
		;--
		; [POI] Broken code.
		bit  0, c
		jr   nz, .onRightChk2P
		;--
		; Make 1P face left
		res  SPRB_XFLIP, [hl]
		
		; Save the settings to the visible set, if possible.
		ld   a, [wOBJInfo_Pl1+iOBJInfo_Status]
		bit  OSTB_GFXLOAD, a		; Are the GFX loading for this character?
		jp   nz, .onRightChk2P		; If so, skip
		ld   a, [wPlInfo_Pl1+iPlInfo_MoveId]
		or   a						; Is there a move ID defined?
		jp   z, .onRightChk2P		; If not, skip
		ldi  a, [hl]				; Read iOBJInfo_OBJLstFlags
		ld   [hl], a				; Write to iOBJInfo_OBJLstFlagsView
	.onRightChk2P:
		; The other player (1P) internally faces right
		ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstFlags
		set  SPRXB_PLDIR_R, [hl]
		
		; Don't make the character face right if the direction is locked
		ld   a, [wPlInfo_Pl2+iPlInfo_Flags1]
		bit  PF1B_XFLIPLOCK, a
		jr   nz, .onRightChkEnd
		;--
		; [POI] Broken code.
		bit  0, c
		jr   nz, .onRightChkEnd
		;--
		; Make 2P face right
		set  SPRB_XFLIP, [hl]
		
		; Save the settings to the visible set, if possible.
		ld   a, [wOBJInfo_Pl2+iOBJInfo_Status]
		bit  OSTB_GFXLOAD, a		; Are the GFX loading for this character?
		jp   nz, .onRightChkEnd		; If so, skip
		ld   a, [wPlInfo_Pl2+iPlInfo_MoveId]
		or   a						; Is there a move ID defined?
		jp   z, .onRightChkEnd		; If not, skip
		ldi  a, [hl]				; Read iOBJInfo_OBJLstFlags
		ld   [hl], a				; Write to iOBJInfo_OBJLstFlagsView
	.onRightChkEnd:
	pop  af
	
.setDistance:
	; Save the calculated player distance
	ld   [wPlInfo_Pl1+iPlInfo_PlDistance], a
	ld   [wPlInfo_Pl2+iPlInfo_PlDistance], a
	;--

	;
	; 1P CHAR - 2P PROJECTILE DISTANCE
	;
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_X]
	ld   b, a							; B = 2P Projectile X
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a				; Is the projectile visible?
	jp   nz, .chkProjDir1P				; If so, jump
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]	; Otherwise, use 2P's X position
	ld   b, a
	
.chkProjDir1P:
	; By default, set that 2P's projectile is on the left of Player 1.
	ld   hl, wOBJInfo_Pl1+iOBJInfo_OBJLstFlags
	res  SPRXB_OTHERPROJR, [hl]
	
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; A = 1P X Position
	sub  a, b							; A = Distance between 1P Char - 2P Projectile
	jp   z, .setProjDistance1P			; Are they the same? If so, jump
	jp   nc, .setProjDistance1P			; Is 1P on the right of 2P's projectile? If so, jump (1P > 2P)
	; Otherwise, 2P's projectile is on the right of Player 1.
	; Set that flag and force the negative distance to positive.
	set  SPRXB_OTHERPROJR, [hl]
	cpl		; A = -A
	inc  a
.setProjDistance1P:
	ld   [wPlInfo_Pl1+iPlInfo_ProjDistance], a
	;--	
	
	;
	; 2P CHAR - 1P PROJECTILE DISTANCE
	;
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_X]
	ld   b, a							; B = 1P Projectile X
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a				; Is the projectile visible?
	jp   nz, .chkProjDir2P				; If so, jump
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; Otherwise, use 1P's X position
	ld   b, a
	
.chkProjDir2P:
	; By default, set that 1P's projectile is on the left of Player 2.
	ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstFlags
	res  SPRXB_OTHERPROJR, [hl]
	
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]	; A = 2P X Position
	sub  a, b							; A = Distance between 2P Char - 1P Projectile
	jp   z, .setProjDistance2P			; Are they the same? If so, jump
	jp   nc, .setProjDistance2P			; Is 2P on the right of 1P's projectile? If so, jump (2P > 1P)
	; Otherwise, 1P's projectile is on the right of Player 1.
	; Set that flag and force the negative distance to positive.
	set  SPRXB_OTHERPROJR, [hl]
	cpl		; A = -A
	inc  a
.setProjDistance2P:
	ld   [wPlInfo_Pl2+iPlInfo_ProjDistance], a
	ret
	
; =============== Play_DoPlColi ===============
; Handles collision detection between players/projectile combinations.
; This subroutine sets up the flags/fields which tell if the player are overlapping
; with something and with what.
; How this is actually used is something that the hit code (Pl_DoHit) decides.
Play_DoPlColi:
	; Start by clearing out the collision flags from the last frame
	xor  a
	ld   [wPlInfo_Pl1+iPlInfo_ColiFlags], a
	ld   [wPlInfo_Pl2+iPlInfo_ColiFlags], a
	ld   [wPlInfo_Pl1+iPlInfo_ColiBoxOverlapX], a
	ld   [wPlInfo_Pl2+iPlInfo_ColiBoxOverlapX], a
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a

	;
	; Handle collision detection between players.
	; This is a chain of subroutines which follow the same pattern.
	; When something is detected that would cause a player to not have collision,
	; the check is skipped, leaving blank the values in the collision flags for both players.
	;
	
Play_DoPlColi_1PChar2PChar:
	;
	; 1P Character Hurtbox - 2P Character Hurtbox
	; This is a bounds check against the generic collision box of both characters,
	; used for things like preventing two characters from overlapping.
	;


	; If any of the players has the "no hurtbox" flag get, skip this
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags2]
	bit  PF2B_NOCOLIBOX, a
	jp   nz, .end
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags2]
	bit  PF2B_NOCOLIBOX, a
	jp   nz, .end
	
	;
	; Get the variables for Player 1 used for the calculation.
	;
	
	; If Player 1 isn't using a collision box, skip this
	ld   a, [wOBJInfo_Pl1+iOBJInfo_ColiBoxId]
	or   a				; Collision box ID == 0?
	jr   z, .end		; If so, skip
	
	; Otherwise, get the variables for Player 1.
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox				; wPlayTmpColiA_* = 1P collision box sizes
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; B = 1P X position
	ld   b, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]	; C = 1P Y position
	ld   c, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlagsView]	; wPlayTmpColiA_OBJLstFlags = 1P Flags
	ld   [wPlayTmpColiA_OBJLstFlags], a				; Not enough registers to hold this
	
	;
	; Get the variables for Player 2 used for the calculation.
	;
	
	; If Player 2 isn't using a collision box, skip this
	ld   a, [wOBJInfo_Pl2+iOBJInfo_ColiBoxId]
	or   a				; Collision box ID == 0?
	jr   z, .end		; If so, skip
	
	; Otherwise, get the variables for Player 2.
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox				; wPlayTmpColiB_* = 2P collision box sizes
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]	; D = 2P X position
	ld   d, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]	; E = 2P Y position
	ld   e, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a	; wPlayTmpColiA_OBJLstFlags = 1P Flags
	
	; 
	; Perform the collision checks between those boxes.
	;
	call Play_CheckColi	; Did a collision occur?
	jr   nc, .end		; If not, skip
	
.coliOk:
	; Make both players push each other, by having both
	; send and receive the outwards push.
	
	; This also saves the the amount of how much the collision boxes overlap horizontally.
	; How this is actually used depends on the move code. 
	; The various MoveC_* subroutines may optionally decide to call Play_Pl_MoveByColiBoxOverlapX
	; to push the player out based on it.
		
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
	inc  hl			; Seek to iPlInfo_ColiBoxOverlapX
	ld   [hl], b	; Save overlap amount
	
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
	inc  hl			
	ld   [hl], b
.end:

Play_DoPlColi_1PCharHitbox2PChar:
	;
	; 1P Character Hitbox - 2P Character Hurtbox
	; If the 1P Hitbox overlaps with the generic 2P collision box.
	;
	
	; Temporary hitboxes like the one for throw range can do collision
	; with moves that otherwise disable the hurtbox.
	; (this still would need to pass the guard check if it were a physical hit, but throws don't check that to begin with)
	ld   a, [wOBJInfo_Pl1+iOBJInfo_ForceHitboxId]
	or   a					; Is there a forced hitbox overriding the other two checks?
	jr   nz, .check			; If so, jump	
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags2]
	bit  PF2B_NOHURTBOX, a	; Can the other player be hit?
	jp   nz, .end			; If not, skip
	ld   a, [wOBJInfo_Pl1+iOBJInfo_HitboxId]
	or   a					; Is there an actual hitbox defined?
	jr   z, .end			; If not, skip
.check:
	;
	; Get 1P Hitbox data
	;
	; A = Hitbox ID
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	
	;
	; Get 2P Hurtbox data
	;
	ld   a, [wOBJInfo_Pl2+iOBJInfo_ColiBoxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	
	;
	; Perform the collision check
	;
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	; A common detail across these hit handlers is that when a player is hit, it receives knockback (PCFB_PUSHED).
	; It's also mandatory when receiving physical damage, as both PCFB_PUSHED and PCFB_HIT must be set.
	
	; Signal that 1P has hit the other player.	
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_HITOTHER, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
	
	; Signal that 2P has received a hit and is being pushed out.
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_HIT, [hl]
.end:

Play_DoPlColi_1PChar2PCharHitbox:
	;
	; 2P Character Hitbox - 1P Character Hurtbox
	; Like the other one, but the other way around.
	;

	ld   a, [wOBJInfo_Pl2+iOBJInfo_ForceHitboxId]
	or   a					; Is there a forced hitbox overriding the other two checks?
	jr   nz, .check			; If so, jump	
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags2]
	bit  PF2B_NOHURTBOX, a	; Can the other player be hit?
	jp   nz, .end			; If not, skip
	ld   a, [wOBJInfo_Pl2+iOBJInfo_HitboxId]
	or   a					; Is there an actual hitbox defined?
	jr   z, .end			; If not, skip
.check:
	;
	; Get 2P Hitbox data
	;
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	
	;
	; Get 1P Hurtbox data
	;
	ld   a, [wOBJInfo_Pl1+iOBJInfo_ColiBoxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	
	;
	; Perform the collision check
	;
	call Play_CheckColi
	jr   nc, .end
.coliOk:

	; Signal that 1P has received a hit
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_HIT, [hl]
	
	; Signal that 2P has hit the other player
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_HITOTHER, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
.end:

Play_DoPlColi_1PProj2PChar:
	;
	; 1P Projectile Hitbox - 2P Character Hurtbox
	;
	
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags1]
	bit  PF1B_INVULN, a	; Is the other player invulnerable?
	jp   nz, .end			; If so, skip
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags2]
	bit  PF2B_NOHURTBOX, a	; Can the other player be hit in general?
	jp   nz, .end			; If not, skip
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a	; Is the projectile visible?
	jp   z, .end			; If not, skip
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_HitboxId]
	or   a					; Does the projectile have an hitbox?
	jp   z, .end			; If not, skip
.check:

	;
	; Get 1P Projectile data
	;
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	
	;
	; Get 2P Hurtbox data
	;
	ld   a, [wOBJInfo_Pl2+iOBJInfo_ColiBoxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	
	;
	; Perform the collision check
	;
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	; 1P projectile hit the other player, so remove it
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	; 1P hit the other player with a projectile
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_PROJHITOTHER, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
	; 2P received a hit by a projectile
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_PROJHIT, [hl]
.end:

Play_DoPlColi_1PChar2PProj:
	;
	; 2P Projectile Hitbox - 1P Character Hurtbox
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags1]
	bit  PF1B_INVULN, a	; Is the other player invulnerable?
	jp   nz, .end			; If so, skip
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags2]
	bit  PF2B_NOHURTBOX, a	; Can the other player be hit in general?
	jp   nz, .end			; If not, skip
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a	; Is the projectile visible?
	jp   z, .end			; If not, skip
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_HitboxId]
	or   a					; Does the projectile have an hitbox?
	jp   z, .end			; If not, skip
.check:
	;
	; Get 2P Projectile data
	;
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	
	;
	; Get 1P Hurtbox data
	;
	ld   a, [wOBJInfo_Pl1+iOBJInfo_ColiBoxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	
	;
	; Perform the collision check
	;
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	; 2P projectile hit the other player, so remove it
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
	; 2P hit the other player with a projectile
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_PROJHITOTHER, [hl]
	set  PCFB_PUSHEDOTHER, [hl]
	; 1P received a hit by a projectile
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_PUSHED, [hl]
	set  PCFB_PROJHIT, [hl]
.end:

Play_DoPlColi_1PProj2PCharHitbox:
	;
	; 1P Projectile Hitbox - 2P Character Hitbox
	;
	; This is used when a move from 2P with an hitbox that can influence a projectile thrown by 1P.
	; 
	; Moves can set the player status bit PF0_PROJREM or PF0_PROJREFLECT, and this happens:
	; - PF0_PROJREM -> The projectile is deleted (as if it hit the target)
	; - PF0_PROJREFLECT -> The projectile is reflected
	;

	; If neiher of those bits is set, this collision check is skipped.
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	and  a, PF0_PROJREM|PF0_PROJREFLECT		; Is 2P currently able to hit or reflect projectiles?
	jp   z, .end							; If not, skip
	
	; If there's no active projectile, skip
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a		; Is the projectile visible?
	jp   z, .end				; If not, skip
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_HitboxId]
	or   a						; Does the projectile have an hitbox?
	jp   z, .end				; If not, skip
.check:
	;
	; Get 1P Projectile data
	;
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_HitboxId]
	or   a
	jr   z, .end
	
	;
	; Get 2P Hitbox data
	;
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	;
	; Determine what to do if the hitbox and projectile collide
	;
	
	; If 2P can reflect projectiles, do just that.
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	bit  PF0B_PROJREFLECT, a		; Is the flag set?
	jp   nz, .reflectProj		; If so, jump
	
	; If 2P is performing a super move that can remove projectiles (ie: Chizuru's),
	; any type of projectile can be erased, even from super moves.
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	bit  PF0B_SUPERMOVE, a		; Flashing at max speed?
	jp   nz, .removeProj		; If so, jump
	
	; Otherwise, don't allow erasing projectiles with high priority.
	; (ie: 1P did one in his super)
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Play_Priority]
	or   a						; Does the projectile have high priority?
	jp   nz, .end				; If so, skip
.removeProj:
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	jp   .setFlags
.reflectProj:
	ld   a, PHM_REFLECT
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
.setFlags:
	; [POI] Set the flags for both players... which aren't actually used.
	;       Only the value at iOBJInfo_Play_HitMode matters.
	;       Also, inexplicably, this is also setting PCFB_HIT/PCFB_HITOTHER, which is only
	;       intended for physical hits that reach the opponent.
	;       But because this is being set, code like Play_Pl_SetHitTypeC_ChkHitType still has to account for this.
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_PROJREMOTHER, [hl]
	set  PCFB_HIT, [hl]
	
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_HITOTHER, [hl]
	set  PCFB_PROJREM, [hl]
.end:

Play_DoPlColi_1PCharHitbox2PProj:
	;
	; 2P Projectile Hitbox - 1P Character Hitbox
	;
	; Same thing, but for the other player
	
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	and  a, PF0_PROJREM|PF0_PROJREFLECT
	jp   z, .end
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a
	jp   z, .end
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_HitboxId]
	or   a
	jr   z, .end
.check:
	;
	; Get 2P Projectile data
	;
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_HitboxId]
	or   a
	jr   z, .end
	
	;
	; Get 1P Hitbox data
	;
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	;
	; Determine what to do if the hitbox and projectile collide
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	bit  PF0B_PROJREFLECT, a
	jp   nz, .reflectProj
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	bit  PF0B_SUPERMOVE, a
	jp   nz, .removeProj
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Play_Priority]
	or   a
	jp   nz, .end
.removeProj:
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
	jp   .setFlags
.reflectProj:
	ld   a, PHM_REFLECT
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
.setFlags:
	ld   hl, wPlInfo_Pl2+iPlInfo_ColiFlags
	set  PCFB_PROJREMOTHER, [hl]
	set  PCFB_HIT, [hl]
	ld   hl, wPlInfo_Pl1+iPlInfo_ColiFlags
	set  PCFB_HITOTHER, [hl]
	set  PCFB_PROJREM, [hl]
.end:

Play_DoPlColi_1PProj2PProj:
	;
	; 1P Projectile Hitbox - 2P Projectile Hitbox
	;
	; In general, they cancel each other out.
	
	; Both projectiles must be visible
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a
	jp   z, .end
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Status]
	bit  OSTB_VISIBLE, a
	jp   z, .end
.check:
	;
	; Get 1P Projectile data
	;
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_HitboxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiA
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_X]
	ld   b, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Y]
	ld   c, a
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiA_OBJLstFlags], a
	;
	; Get 2P Projectile data
	;
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_HitboxId]
	or   a
	jr   z, .end
	ld   de, wPlayTmpColiB
	call Play_GetPlColiBox
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_X]
	ld   d, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Y]
	ld   e, a
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_OBJLstFlagsView]
	ld   [wPlayTmpColiB_OBJLstFlags], a
	call Play_CheckColi
	jr   nc, .end
.coliOk:
	; Check projectile priority.
	; The one with higher priority value erases the other, or both cancel each
	; other out when they have same priority.
	; Note that, generally, super move projectiles have the higher priority.
	ld   a, [wOBJInfo_Pl2Projectile+iOBJInfo_Play_Priority]
	ld   b, a												; B = 2P Projectile Priority
	ld   a, [wOBJInfo_Pl1Projectile+iOBJInfo_Play_Priority]	; A = 1P Projectile Priority
	cp   b				
	jp   z, .remAllProj	; 1P == 2P? If so, jump
	jp   c, .remProj1P	; 1P < 2P? If so, jump
.remProj2P:
	; Otherwise, 1P > 2P.
	; 1P Projectile stays, 2P removed
	ld   a, PHM_NONE
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
	jp   .end
.remProj1P:
	; 2P Projectile stays, 1P removed
	ld   a, PHM_NONE
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	jp   .end
.remAllProj:
	; Both projectiles removed
	ld   a, PHM_REMOVE
	ld   [wOBJInfo_Pl1Projectile+iOBJInfo_Play_HitMode], a
	ld   [wOBJInfo_Pl2Projectile+iOBJInfo_Play_HitMode], a
.end:
	ret 
	
; =============== Play_GetPlColiBox ===============
; Gets the length of the collision boxes.
; This copies 4 bytes from the indexed wColiBoxTbl entry to DE.
; IN
; - A: Collision box ID
; - DE: Ptr to destination
Play_GetPlColiBox:

	; Index the table with collision boxes (4 byte entries)
	; HL = A * 4
	ld   h, $00
	ld   l, a		; HL = A
	add  hl, hl		; HL * 2
	add  hl, hl		; HL * 2
	push de
		; Offset the table
		ld   de, wColiBoxTbl
		add  hl, de
	pop  de
	
	; Read out the entries to DE
	ldi  a, [hl]	; byte0 - X Origin
	ld   [de], a
	inc  de
	ldi  a, [hl]	; byte1 - Y Origin
	ld   [de], a
	inc  de
	ldi  a, [hl]	; byte2 - H Radius
	ld   [de], a
	inc  de
	ld   a, [hl]	; byte3 - V Radius
	ld   [de], a
	ret
	
; =============== Play_CheckColi ===============
; Checks if the specified collision boxes overlap.
;
; Note that player sprites don't get V-flipped, so the only special checks are made against SPRB_XFLIP.
;
; IN:
; - B: 1P X position
; - C: 1P Y position
; - D: 2P X position
; - E: 2P Y position
; OUT
; - C flag: If set, the collision boxes overlap
; - B: X Box Overlapping (how much the collision boxes overlap horizontally)
; - C: Y Box Overlapping (...)
; - D: 1P Absolute X Box Origin
; - E: 1P Absolute Y Box Origin
Play_CheckColi:
	
	;--
	;
	; X BOUNDS CHECK
	;
	; In this one, we have to deal with the sprite being X flipped.
	; When a sprite is flipped, the collision box origin is flipped relative to the player's absolute X position.
	; (which, in practice, means A = -A)
	; ie: the negative value (left of origin) becomes positive (right of origin).
	;
	; Note that it won't change the box width at all, as it's a radius that always extends equally
	; to both the left and right sides of the box origin.
	;
	
	
	;##
	;
	; B = H = 1P Absolute H Origin
	; 
	; Convert the relative origin in wPlayTmpColiA_OriginH to absolute,
	; by adding the X player position to it.
	;
	
	; H = OBJLst flags (for the X flip flag)
	ld   a, [wPlayTmpColiA_OBJLstFlags]
	ld   h, a
	; A = Relative X Origin (accounting for X flip)
	ld   a, [wPlayTmpColiA_OriginH]
	bit  SPRB_XFLIP, h		; Is the player X flipped?
	jr   z, .setHOrigin1P	; If not, jump
	cpl						; Otherwise, A = -A
	inc  a
.setHOrigin1P:
	; Convert the relative origin to absolute.
	add  b					; AbsXOrg = RelXOrg + AbsPlX
	; Save the result to B and H
	ld   b, a ; Why save it to B?
	ld   h, a
	

.getHOrigin2P:
	;##
	;
	; A = 2P Absolute H Origin
	;
	
	; L = OBJLst flags (for the X flip flag)
	ld   a, [wPlayTmpColiB_OBJLstFlags]
	ld   l, a
	; A = Relative X origin (accounting for X flip)
	ld   a, [wPlayTmpColiB_OriginH]
	bit  SPRB_XFLIP, l
	jr   z, .setHOrigin2P
	cpl
	inc  a
.setHOrigin2P:
	; Convert the relative origin to absolute.
	add  a, d				; AbsXOrg = RelXOrg + AbsPlX
	
	
.getHDist:
	;##
	;
	; B = Distance between collision box origins.
	;     
	sub  a, b			; A = 2P - 1P
	jp   nc, .setHDist	; Is that >= 0 (2P to the right of 1P)? If so, jump
	cpl					; Otherwise, A = -A
	inc  a
.setHDist:
	ld   b, a

.getLimitH:
	;##
	;
	; Determine the range threshold (max distance for collision).
	;
	; As the widths are radiuses that extend to both sides equally, this is always the 
	; sum of the two players' horizontal widths, regardless of a player's position or X flip.
	;
	; A = wPlayTmpColiA_RadH + wPlayTmpColiB_RadH
	push bc
		;
		ld   a, [wPlayTmpColiA_RadH]	; B = 1P Box Width
		ld   b, a
		ld   a, [wPlayTmpColiB_RadH]	; A = 2P Box Width
		add  b							; Add those together
	pop  bc
	
.chkBoundsH:
	;##
	;
	; Perform the bounds check.
	; If the distance between box origins is larger than the threshold, the boxes aren't overlapping.
	; so we can return.
	;
	; Otherwise, save to B by how much they overlap
	sub  a, b			; A -= DistanceH
	jp   c, .retClear	; A < 0? If so, return
	ld   b, a			; Otherwise, save the result to B
	
	;---
	
.doV:

	;--
	;
	; Y BOUNDS CHECK
	;
	; This is essentially the same, except there's no Y flip here.
	;
	
	;
	; C = L = 1P Absolute V Origin
	;
	ld   a, [wPlayTmpColiA_OriginV]
	add  c
	ld   c, a	; Why save a copy here?
	ld   l, a
.getVOrigin2P:
	;##
	;
	; A = 2P Absolute V Origin
	;
	ld   a, [wPlayTmpColiB_OriginV]
	add  a, e
	
.getVDist:
	;##
	;
	; C = Distance between collision box origins.
	;   
	sub  a, c			; A = 2P - 1P
	jp   nc, .setVDist	; Is that >= 0 (2P to the right of 1P)? If so, jump
	cpl					; Otherwise, A = -A
	inc  a
.setVDist:
	ld   c, a
	
	;##
	;
	; Determine threshold
	;
	; A = wPlayTmpColiA_RadV + wPlayTmpColiB_RadV
	push bc
		ld   a, [wPlayTmpColiA_RadV]
		ld   b, a
		ld   a, [wPlayTmpColiB_RadV]
		add  b
	pop  bc
	
.chkBoundsV:
	;##
	;
	; Perform the bounds check.
	;
	
	; Distance must be positive
	sub  a, c						; A -= DistanceV
	jp   c, .retClear				; A < 0? If so, jump
	ld   c, a						; Otherwise, save the result to C
	
	; Move the 1P/2P distances to DE
	push hl
	pop  de
	
.retSet:
	scf			; Set carry
	ret
.retClear:
	or   a		; Clear carry
	ret
	
; =============== Play_ChkEnd ===============
; Series of checks that handle the triggers that can end a round.
Play_ChkEnd:
	;
	; Enable input processing as long as the round isn't over.
	; There are a few different triggers that cause the round to end,
	; which will be checked for now.
	;
	ld   hl, wMisc_C027			; Enable by default
	res  MISCB_PLAY_STOP, [hl]
	; Fall-through
	
; =============== Play_ChkEnd_TimeOver ===============
Play_ChkEnd_TimeOver:
	;
	; TIME OVER CHECK
	;
	ld   a, [wRoundTime]
	or   a							; wRoundTime != 0?
	jp   nz, Play_ChkEnd_Slowdown	; If so, jump
.timeOver:							; Otherwise...
	ld   hl, wMisc_C027				; Lock controls
	set  MISCB_PLAY_STOP, [hl]
	call Play_LoadPostRoundText0	; Prepare text set
	call Play_DoTimeOverText		; 
	jp   Play_ChkEnd_KO.chkWaitPost	; Continue to the standard post-round handler
	
; =============== Play_ChkEnd_Slowdown ===============
Play_ChkEnd_Slowdown:
	;
	; Handles the slowdown effect.
	; As long as slowdown is active, this takes control as main gameplay loop.
	;
	; This is here because the game slows down for a moment when KO'ing an opponent,
	; through it's also used occasionally for other parts.
	;
	
	; Do the slowdown until wPlaySlowdownTimer elapses.
	ld   a, [wPlaySlowdownTimer]
	or   a						; wPlaySlowdownTimer == 0?
	jp   z, Play_ChkEnd_KO		; If so, skip
	; Otherwise, execute the slowdown
	dec  a						; wPlaySlowdownTimer--
	ld   [wPlaySlowdownTimer], a
	
	; Count down from wPlaySlowdownSpeed.
	; When it reaches 0, execute once a complete gameplay loop.
	ld   a, [wPlaySlowdownSpeed]	; A = TickLeft
.loop:
	or   a				; TickLeft == 0?
	jp   z, .execNorm	; If so, execute a normal gameplay loop
.execBlank:				; Otherwise, execute a simplified one that essentially doesn't process OBJInfo
	push af				; Save TickLeft				
		; Keep GFX buffer intact, as copying tiles to the buffer influences the animation timing.
		ld   a, $01					
		ld   [wNoCopyGFXBuf], a
		call Play_DoPlInput
		call Play_DoHUD
		call Play_DoMisc
		call Play_WriteKeysToBuffer
		; Calling this is the main key behind how the slowdown works.
		; This will skip processing the two other tasks, which are used
		; to handle player movement.
		call Task_SkipAllAndWaitVBlank
		xor  a
		ld   [wNoCopyGFXBuf], a
	pop  af				; Restore TickLeft
	dec  a				; TickLeft--
	jp   .loop			; Go check if we're done "waiting"
.execNorm:
	call Play_DoPlInput
	call Play_DoHUD
	call Play_DoMisc
	call Play_DoPlColi
	call Play_WriteKeysToBuffer
	call Play_DoScrollPos
	call Play_ExecExOBJCode
	call Task_PassControlFar
	jp   Play_ChkEnd_Slowdown
	
; =============== Play_ChkEnd_KO ===============
Play_ChkEnd_KO:
	;
	; KO CHECK
	;
	; If any player has no health, handle the KO display
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]
	or   a				; 1P Health == 0?
	jr   z, .showKO		; If so, round's over
	ld   a, [wPlInfo_Pl2+iPlInfo_Health]
	or   a				; 2P Health == 0?
	jp   nz, Play_ChkEnd_Ret		; If not, return
.showKO:
	ld   hl, wMisc_C027
	set  MISCB_PLAY_STOP, [hl]
	call Play_LoadPostRoundText0
	
	;--
	; [POI] Checking if the players were ready was already done in Play_LoadPostRoundText0.
	;       What's the point of checking this again? (note it's also an oddity in 95).
	;       Players can only be in the moves MOVE_SHARED_NONE or MOVE_SHARED_IDLE when we get here.
.chkWaitPost:
	; Execute main loop
	ld   b, $01
	call Play_MainLoop_PostRound
.chkWaitPost1P:
	; Players must be either in the idle move (winner/draw) or have no move (lost).
	; This is to allow any currently executing move to finish.
	ld   a, [wPlInfo_Pl1+iPlInfo_MoveId]
	cp   MOVE_SHARED_NONE	; MoveId == 0?
	jr   z, .chkWaitPost2P	; If so, jump
	cp   MOVE_SHARED_IDLE	; MoveId == 2?
	jr   nz, .chkWaitPost	; If not, wait again
.chkWaitPost2P:
	ld   a, [wPlInfo_Pl2+iPlInfo_MoveId]
	cp   MOVE_SHARED_NONE	; MoveId == 0?
	jr   z, .chkEndType; If so, jump
	cp   MOVE_SHARED_IDLE	; MoveId == 2?
	jr   nz, .chkWaitPost	; If not, wait again
	;--
.chkEndType:
	;
	; Determine what kind of text to follow up the "KO" or "TIME OVER" with.
	; Decide depending on the player health.
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]	; A = 1P Health
	ld   hl, wPlInfo_Pl2+iPlInfo_Health		; B = Ptr to 2P Health
	cp   a, [hl]		; Compare them
	jr   z, .draw		; Do they match? If so, it's a DRAW GAME
	jr   c, .won2P		; 1P < 2P? If so, 2P Won
	; Otherwise, 1P Won
.won1P:
	call Play_Set1PWin
	ld   bc, wPlInfo_Pl1		; Winner
	ld   de, wPlInfo_Pl2		; Loser
	call Play_SetWinLoseMoves
	jr   .showPostRoundText
.won2P:
	call Play_Set2PWin
	ld   bc, wPlInfo_Pl2		; Winner
	ld   de, wPlInfo_Pl1		; Loser
	call Play_SetWinLoseMoves
	jr   .showPostRoundText
.draw:
	call Play_SetDraw
	call Play_SetDrawMoves
	
	
.showPostRoundText:

	;
	; Wait until both player tasks are deleted. 
	; The win/lose/draw move code we just set will do this.
	;
	; 96 opted to wait for a fixed amount of time, while allowing to abort
	; it through a keypress.
	;
	ld   b, $01
	call Play_MainLoop_PostRound
	ldh  a, [hTaskPl1+iTaskType]	; A = 1P Task Status
	ld   hl, hTaskPl2+iTaskType		; HL = Ptr to 2P Task Status
	or   a, [hl]
	cp   TASK_EXEC_NONE				; Are they both gone?
	jr   nz, .showPostRoundText		; If not, loop
	
	; Wait some more after that
	ld   b, $78
	call Play_MainLoop_PostRound
	
	
Play_ChkEnd_ChkNewRound:

	;
	; Determines if a new round should start.
	;
	
	xor  a
	ld   [wStageDraw], a

	call IsInTeamMode	; Playing in team mode?
	jp   c, .team		; If so, jump
	
	
.single:
	;
	; SINGLE MODE
	; 
	
	; The final round uses its own set of rules.
	ld   a, [wRoundNum]
	cp   $03					; Is this the FINAL!! round? (round 4)
	jp   z, .chkFinalRoundRes	; If so, jump
	
	; If any player won two rounds in single mode, the stage is over.
	ld   a, [wPlInfo_Pl1+iPlInfo_SingleWinCount]
	cp   $02				; Did 1P win two rounds?
	jp   z, .win1P_setLast	; If so, jump
	ld   a, [wPlInfo_Pl2+iPlInfo_SingleWinCount]
	cp   $02				; Did 2P win two rounds?
	jp   z, .win2P_setLast	; If so, jump
	
	; Otherwise, start a new round.
	jp   .startNewRound
	
.team:
	;
	; TEAM MODE - BOSS CHECK
	;
	; Saisyu and Rugal's stages count as 3-1 and 3-2 matches respectively that
	; continue directly one from the other.
	; Therefore, they count as beaten when the CPU loss count is 1 and 2 respectively.
	;
	; Note that Nakoruru's match is forced to Single Mode, so we don't get here.
	;
	
	; No boss stages in VS mode. 
	ld   a, [wPlayMode]
	bit  MODEB_VS, a			; Playing a VS battle?		
	jp   nz, .chkTeamNormal		; If so, jump
	
	;--
	; DE = Player Loss Count
	; HL = CPU Loss Count
	ld   a, [wJoyActivePl]
	or   a						; wJoyActivePl == PL2?
	jp   nz, .team2P			; If so, jump
.team1P:
	ld   de, wPlInfo_Pl1+iPlInfo_TeamLossCount
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount
	jp   .chkBossLoss
.team2P:
	ld   de, wPlInfo_Pl2+iPlInfo_TeamLossCount
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamLossCount
	;--
	
.chkBossLoss:

	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; Is this Saisyu's stage?
	jp   z, .teamSaisyu		; If so, jump
	cp   STAGESEQ_RUGAL		; Is this Rugal's stage?
	jp   z, .teamRugal		; If so, jump
	jp   .chkTeamNormal		; Otherwise, this is a normal team stage
.teamSaisyu:
	;
	; TEAM MODE - SAISYU
	;
	
	; To win the match, this boss "team" must lose once.
	; If not, jump to the normal case so it will handle the player losing the round.
	ld   a, [hl]			
	cp   $01				; CPU lost once?
	jp   nz, .chkTeamNormal	; If not, jump
	
	; Otherwise, determine if we actually won or if it's a draw,
	; as draws mark both teams as having lost.
	ld   a, [wLastWinner]
	or   a					; Did anyone win the round?
	jp   nz, .teamBossPlWon	; If so, the player won.
	
.teamSaisyuDraw:
	; [BUG] The intention here was probably that as long as the player has one remaining 
	;       team member, the draw would count as a win regardless.
	;       Instead, there's very confused logic that always counts a draw as a victory, 
	;       *except* on the first round.
	;
	ld   a, [de]
	; If the player lost twice, count it as a victory (ok)
	cp   $02					; Player lost twice?
	jp   z, .teamBossPlWon		; If so, we won anyway
	; If the player *didn't* lose three times, count it as a defeat (bad)
	; This means a draw on the first round triggers a loss/2nd round.
	cp   $03					; Player lost three times?
	jp   nz, .teamBossPlLost	; If not, jump
	; Meanwhile, if we lost three times (draw on the last round), count it as a victory (bad)
	; and decrement the player's loss count because we're using the same character for the Rugal match (ok)
	push de
	pop  hl
	dec  [hl]
	jp   .teamBossPlWon
.teamBossPlLost:
	; Treat the draw as a player loss, so decrement the loss count for the CPU 
	; (but not for the player, because this logic makes no sense)
	dec  [hl]
	jp   .startNewRound

	
.teamRugal:
	;
	; TEAM MODE - RUGAL
	;
	;
	; This is a 3 vs 2 battle *continued* from the Saisyu match.
	; To win the match, this boss "team" must a second time, as the CPU
	; team already has a loss from Saisyu's defeat.
	;
	; Unlike Saisyu's stage, you have to defeat Rugal. 
	; Draws always lead to the next round.
	;
	ld   a, [hl]			
	cp   $02				; CPU lost twice?
	jp   nz, .chkTeamNormal	; If not, jump (player lost)
	
	; Otherwise, determine if we actually won or if it's a draw,
	; as draws mark both teams as having lost.
	ld   a, [wLastWinner]
	or   a					; Did anyone win the round?
	jp   nz, .teamBossPlWon	; If so, jump (player won)
	
.teamRugalDraw:
	;
	; This is a draw, so we go to the next round.
	;
	ld   a, [de]
	cp   $04					; Does the player have 4 losses set?
	jp   z, .chkFinalRoundRes	; If so, jump (show "DRAW" screen)
	dec  [hl]					; Otherwise, just decrement the boss loss counter
	jp   .startNewRound			; to treat it as a normal loss
.teamBossPlWon:
	; The boss was defeated.
	ld   a, [wJoyActivePl]
	or   a					; wJoyActivePl == PL1?
	jp   z, .win1P_setLast	; If so, jump (1P Won)
	jp   .win2P_setLast		; Otherwise 2P Won
	
.chkTeamNormal:
	;
	; TEAM MODE - NORMAL CASE
	; 
	; The team with at least 3 losses loses.
	;
	
	; Check if the player with the largest amount of losses has iPlInfo_TeamLossCount >= $03.
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamLossCount]	; A = 1P Loss count
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount	; HL = Ptr to 2P Loss count
	cp   a, [hl]		
	jp   z, .teamLossEq		; Do they match? If so, jump
	jp   nc, .chkLossCnt1P	; 1P >= 2P? If so, jump
.chkLossCnt2P:				; Otherwise 1P < 2P. Check for 2P losses.
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamLossCount]
	cp   $03				; Did 2P lose at least 3 times?
	jp   nc, .win1P_setLast	; If so, 1P won
	jp   .startNewRound		; Otherwise, start the next round
.chkLossCnt1P:
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamLossCount]
	cp   $03				; Did 1P lose at least 3 times?
	jp   nc, .win2P_setLast	; If so, 2P won
	jp   .startNewRound		; Otherwise, start the next round
.teamLossEq:
	; If we've finished the final round, skip this as a shortcut
	cp   $04					; Do both players have 4 losses set?
	jp   z, .chkFinalRoundRes	; If so, jump (show "DRAW" screen)
	jp   .startNewRound			; Otherwise, start the next round
.startNewRound:
	; Wait for it
	call Play_ClearAfterRound
	jp   Module_Play
	
.chkFinalRoundRes:
	;
	; FINAL ROUND CHECK
	;
	; After the FINAL!! round is over, there's no starting a new round.
	; The stage forcefully ends, and the win screen code decides how to handle it.
	; 
	xor  a
	ld   [wStageDraw], a
	
	;
	; Because there is no stage progression in VS mode, the win screen
	; is handled differently and there's no need for wStageDraw.
	;
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing a VS battle?	
	jp   nz, .endStage		; If so, jump
	
	;
	; If anyone won the FINAL!! round, the stage can end as normal
	;
	ld   a, [wLastWinner]
	or   a					; Is 2P the winner?
	jp   nz, .endStage		; If so, jump
	
	;
	; Otherwise, show the DRAW screen.
	;
	; As this is single mode, we also need to fake the wLastWinner data to make
	; the game think the CPU opponent won. This will cause the continue prompt to show up
	; instead of the game continuing anyway to the next stage.
	;
	; yep.
	;
	ld   a, $01				; Show DRAW screen
	ld   [wStageDraw], a
	
	; Make the CPU opponent win
	ld   a, [wJoyActivePl]
	or   a					; wJoyActivePl == PL1? (2P is opponent)
	jp   z, .win2P_setLast	; If so, 2P won
.win1P_setLast:				; Otherwise, 1P won
	; Set 1P as the last winner.
	; This is what determines if the stage sequence should continue or not,
	; even in case of the "DRAW" screen showing up.
	ld   hl, wLastWinner
	set  PLB1, [hl]
	res  PLB2, [hl]
	jp   .endStage
	
.win2P_setLast:
	ld   hl, wLastWinner
	res  PLB1, [hl]
	set  PLB2, [hl]
	jp   .endStage
	
.endStage:
	; Stop SGB SFX
	ld   hl, (SGB_SND_B_STOP << 8)|$00
	call SGB_PrepareSoundPacketB
	call Task_PassControlFar
	
	; Cleanup the screen
	call Play_ClearAfterRound
	
	; Initialize the win screen
	ld   b, BANK(Module_Win) ; BANK $1C
	ld   hl, Module_Win
	jp   FarJump
Play_ChkEnd_Ret:
	ret
	ret ; We never get here
	
; =============== Play_SetWinLoseMoves ===============
; Sets the win and lose moves to the specified players.
; This shouldn't be called when there are no winning players (ie: a draw).
; IN
; - BC: Ptr to winner wPlInfo
; - DE: Ptr to loser wPlInfo
Play_SetWinLoseMoves:
	;
	; Additionally...
	; In team mode, the winner recovers health between rounds.
	;
	call IsInTeamMode		; Are we in team mode?
	jp   nc, .chkWinMove	; If not, skip
	
	; The health recovered is 4 + (wRoundTime / 10).
	ld   a, [wRoundTime]
	srl  a				; A = A / 10
	srl  a
	srl  a
	srl  a
	add  a, $04			; + 4
	ld   h, a			; Save it to H
	
	; A = Current health
	push hl
		ld   hl, iPlInfo_Health
		add  hl, bc				; Seek to iPlInfo_Health
		ld   a, [hl]
	pop  hl
	
	; Add the health over, capping it at the standard value
	add  a, h				; iPlInfo_Health += H
	cp   PLAY_HEALTH_MAX	; Is it still < $48?
	jp   c, .saveHealthInc	; If so, jump
	ld   a, PLAY_HEALTH_MAX	; Otherwise, cap it
.saveHealthInc:
	; Save the new health value
	ld   hl, iPlInfo_Health
	add  hl, bc				; Seek to iPlInfo_Health
	ld   [hl], a			; Save new value
	
	
.chkWinMove:
	;
	; WINNING PLAYER -> Set the win move.
	;
	ld   a, MOVE_SHARED_WIN	; A = Move ID to use
	ld   hl, iPlInfo_IntroMoveId
	add  hl, bc				; Seek to iPlInfo_IntroMoveId
	ld   [hl], a			; Save it here
	
.chkLoseMove:
	;
	; LOSING PLAYER -> Set the lose move if possible.
	; This is only applicable with time overs -- as otherwise the
	; opponent stays dead on the ground.
	;
	ld   hl, iPlInfo_Health
	add  hl, de
	ld   a, [hl]			; A = iPlInfo_Health
	or   a					; iPlInfo_Health != 0?
	jr   nz, .loseTimeOver	; If so, jump
.loseNorm:
	; Otherwise, signal out to the current move (MOVE_SHARED_NONE) to kill the player task.
	ld   a, MOVE_TASK_REMOVE			; A = Move ID to use
	jr   .setLoseMove
.loseTimeOver:
	ld   a, MOVE_SHARED_LOST_TIMEOVER	; A = Move ID to use
.setLoseMove:
	ld   hl, iPlInfo_IntroMoveId
	add  hl, de		; Seek to iPlInfo_IntroMoveId
	ld   [hl], a	; Save it here
	ret 
	
; =============== Play_SetDrawMoves ===============
; Sets the move for draws to both players
Play_SetDrawMoves:
	;
	; BOTH PLAYERS -> Set the lose move *if* possible.
	; This is because it has to handle Double KOs as well, and with
	; those both players lie dead on the ground.
	;
	
	; Since both players have the same health, checking 1P is enough.
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]
	or   a					; iPlInfo_Health == 0?
	jr   z, .doubleKo		; If so, it's a double KO (set dummy move)
.timeOver:					; Otherwise, set a real move
	ld   a, MOVE_SHARED_LOST_TIMEOVER
	jr   .setMove
.doubleKo:
	; Signal out to the move code (MOVE_SHARED_NONE) to kill the task
	ld   a, MOVE_TASK_REMOVE
.setMove:
	ld   [wPlInfo_Pl1+iPlInfo_IntroMoveId], a
	ld   [wPlInfo_Pl2+iPlInfo_IntroMoveId], a
	ret 
	
; =============== Play_ClearAfterRound ===============
; Performs cleanup after a round is over.
; This became Play_PrepForWinScreen in 96.
Play_ClearAfterRound:
	; Blank all DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reset screen scroll
	xor  a
	ldh  [rWY], a
	ldh  [rWX], a
	ldh  [rSTAT], a
	
	; Disabke screen sections
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	
	; Remove the two player tasks
	ld   a, $02
	call Task_RemoveAt
	ld   a, $03
	call Task_RemoveAt
	
	call Task_PassControlFar
	ret
	
; =============== Play_LoadPostRoundText0 ===============
; Loads the sprite mappings + graphics for the first set of post-round text.
; See also: Play_LoadPreRoundTextAndIncRound
Play_LoadPostRoundText0:

	;
	; Wait for the players / objects to be ready before finishing the round.
	; This is the state the game is in after defeating an opponent / timer runs out
	; before the WIN/LOST/DRAW text appears.
	;
	; IMPORTANT: There's no timeout implemented, so if players or projectiles
	;            get "stuck", the game softlocks.
	;

	; Execute once a cut down version of the gameplay loop without the joypad reader.
	ld   b, $01
	call Play_MainLoop_PostRound
	
.chkWait1P:
	; Players must be either in the idle move (winner/draw) or have no move (lost).
	; This is to allow any currently executing move to finish.
	ld   a, [wPlInfo_Pl1+iPlInfo_MoveId]
	cp   MOVE_SHARED_NONE		; MoveId == 0?
	jr   z, .chkWait2P			; If so, jump
	cp   MOVE_SHARED_IDLE		; MoveId == 2?
	jr   nz, Play_LoadPostRoundText0	; If not, wait again
.chkWait2P:
	ld   a, [wPlInfo_Pl2+iPlInfo_MoveId]
	cp   MOVE_SHARED_NONE		; MoveId == 0?
	jr   z, .chkWaitEx			; If so, jump
	cp   MOVE_SHARED_IDLE		; MoveId == 2?
	jr   nz, Play_LoadPostRoundText0	; If not, wait again
.chkWaitEx:

	; Also wait for the extra sprites to become invisible, as their
	; graphics are getting overwritten with new ones.
	xor  a
	; Merge the status bits of all OBJinfo
	ld   hl, wOBJInfo_Pl1Projectile+iOBJInfo_Status
	or   a, [hl]
	ld   hl, wOBJInfo_Pl2Projectile+iOBJInfo_Status
	or   a, [hl]
	ld   hl, wOBJInfo_Pl1Bird+iOBJInfo_Status
	or   a, [hl]
	ld   hl, wOBJInfo_Pl2Bird+iOBJInfo_Status
	or   a, [hl]
	and  a, OST_VISIBLE						; Are any of these visible?
	jr   nz, Play_LoadPostRoundText0		; If so, wait again
	
	; Wait for 2 more frames
	ld   b, $02
	call Play_MainLoop_PostRound
	
.loadGFX:
	
	;
	; Load the set of post-round graphics to VRAM.
	; This is done exactly the same way as CopyTilesAuto, except it waits for HBlank 
	; since the screen is turned on. 
	;
	ldh  a, [hROMBank]
	push af
		ld   a, BANK(GFXAuto_Play_RoundFont) ; BANK $01
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		ld   hl, GFXAuto_Play_RoundFont
		ld   e, [hl]	; Read out destination ptr to DE
		inc  hl
		ld   d, [hl]
		inc  hl
		ld   b, [hl]	; Read number of tiles to copy
		inc  hl			
	
	; =============== mWaitVBlankOrHBlankWeird ===============
	; ...
MACRO mWaitVBlankOrHBlankWeird
.waitVH_\@:
	ldh  a, [rSTAT]
	and  a, I_VBLANK|I_STAT
	jp   z, .next_\@
	jp   .waitVH_\@
.next_\@
ENDM

	; =============== .cpGFXLoop ===============
	; Extracted to Play_CopyPostRoundGFXToVRAM in 96.
	;
	; Copies the specified block of graphics to VRAM, during HBlank.
	; This is used specifically for the "post round text" (ie: KO, YOU WON, ...)
	; IN
	; - HL: Ptr to source uncompressed GFX
	; - DE: Ptr to destination in VRAM
	; - B: Tiles to copy from HL ($10*B bytes)
	.cpGFXLoop:
		push bc
			; Copy a tile at a time every frame
			REPT TILESIZE			; Bytes to copy ($10)
				di   
				mWaitVBlankOrHBlankWeird
				ldi  a, [hl]		; Read from source, SrcPtr++
				ld   [de], a		; Copy it to destination
				ei
				inc  de				; DestPtr++
			ENDR
			call Task_PassControlFar
		pop  bc
		dec  b				; Finished copying all tiles?
		jp   nz, .cpGFXLoop	; If not, loop
	;==
		
		;
		; Load the OBJInfo for the round text, with the sprite mapping
		; table for the KO text.
		;
		
		ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
		ld   de, OBJInfoInit_Play_RoundText
		call OBJLstS_InitFrom
	
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	
	call Task_PassControlFar
	ret
	
; =============== Play_DoTimeOverText ===============
; Handles the TIME OVER text display while the characters continue their animations.
Play_DoTimeOverText:
	; Display the text horizontally centered...
	ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
	ld   [hl], OST_VISIBLE
	ld   hl, wOBJInfo_RoundText+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], PLAY_OBJ_ROUNDTEXT_TIMEOVER
	call Play_CenterRoundText
	call Task_PassControlFar
	
	; ...for $78 frames
	ld   b, $78
	call Play_MainLoop_PostRound
	ret
	
; =============== Play_Set1PWin ===============
; Sets 1P as the winner of the current round.
; This updates all of the needed variables across the two players and
; handles the text display.
Play_Set1PWin:
	;
	; The "win counters" are handled differently in single and team mode.
	;
	call IsInTeamMode	; In team mode?
	jp   c, .team		; If so, jump
.single:
	; 
	; SINGLE MODE
	; In single mode, iPlInfo_SingleWinCount is incremented
	; and a round marker is filled on the winner side.
	;
	ld   hl, wPlInfo_Pl1+iPlInfo_SingleWinCount
	inc  [hl]	; 1P Win Count++
	
	; Determine which of the two markers/boxes in the HUD to draw.
	ld   a, [hl]			; Read counter
	cp   $02				; Is this the second win?
	jp   z, .boxWin2		; If so, jump
.boxWin1:
	ld   hl, vBGBoxWin1P0	; Leftmost box for first win
	jp   .drawBox
.boxWin2:
	ld   hl, vBGBoxWin1P1	; The one on its right for the second
.drawBox:
	ld   c, PLAY_TID_BOX_FILL	; C = Tile ID for filled box
	call Play_DrawWinBox
	jp   .chkTextType
	
.team:
	; 
	; TEAM MODE
	; In team mode, the loss counter on the losing team is incremented.
	;
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount
	inc  [hl]	; 2P Loss Count++
	
.chkTextType:
	;
	; Determine which text to display.
	;
	
	ld   a, [wPlayMode]
	bit  MODEB_VS, a	; Playing in VS mode?
	jp   nz, .chkVS		; If so, jump
.chkSingle:
	
	; In single mode, if the CPU opponent wins, "YOU LOST".
	; Otherwise we win.
	
	ld   a, [wJoyActivePl]
	or   a				; Is 1P the active player? (not CPU opponent)
	jp   z, .won		; If so, we won
	jp   .lost			; Otherwise, the CPU opponent is on the 1P side.
.chkVS:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a	; Running on the SGB?
	jp   z, .chkVS_serial	; If not, jump
	jp   .chkVS_sgb
.chkVS_serial:
	; On a VS serial battle, show "YOU WIN" on the master side (as it's always 1P)
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_SLAVE, a	; Are we a slave?
	jr   nz, .vsSerialLost		; If not, we lost
	jp   .won
.vsSerialLost:
	jp   .lost
.lost:
	ld   a, PLAY_OBJ_ROUNDTEXT_YOULOST
	jp   .showText
.won:
	ld   a, PLAY_OBJ_ROUNDTEXT_YOUWON
	jp   .showText
.chkVS_sgb:
	; On a SGB VS battle, explicitly say that 1P won (since there's a single screen).
	ld   a, PLAY_OBJ_ROUNDTEXT_1PWON
	jp   .showText
.chkVS_sgb_unused:
	; [TCRF] Unreachable code "leftover" from Play_Set2PWin.
	ld   a, PLAY_OBJ_ROUNDTEXT_2PWON
.showText:
	ld   bc, wPlInfo_Pl1
	call Play_DoPostRoundText1PreWin
	
	; Set only 1P as last winner
	ld   hl, wLastWinner
	set  PLB1, [hl]
	res  PLB2, [hl]
	ret
	
; =============== Play_Set2PWin ===============
; Sets 2P as the winner of the current round.
; This updates all of the needed variables across the two players and
; handles the text display.
; See also: Play_Set1PWin
Play_Set2PWin:
	;
	; The "win counters" are handled differently in single and team mode.
	;
	call IsInTeamMode	; In team mode?
	jp   c, .team		; If so, jump
.single:
	; 
	; SINGLE MODE
	; In single mode, iPlInfo_SingleWinCount is incremented
	; and a round marker is filled on the winner side.
	;
	ld   hl, wPlInfo_Pl2+iPlInfo_SingleWinCount
	inc  [hl]		; 2P Win Count++
	
	; Determine which of the two markers/boxes in the HUD to draw.
	ld   a, [hl]		; Read counter
	cp   $02			; Is this the second win?
	jp   z, .boxWin2	; If so, jump
.boxWin1:
	ld   hl, vBGBoxWin2P0	; Leftmost box for first win
	jp   .drawBox
.boxWin2:
	ld   hl, vBGBoxWin2P1	; The one on its right for the second
.drawBox:
	ld   c, PLAY_TID_BOX_FILL	; C = Tile ID for filled box
	call Play_DrawWinBox
	jp   .chkTextType
	
.team:
	; 
	; TEAM MODE
	; In team mode, the loss counter on the losing team is incremented.
	;
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamLossCount
	inc  [hl]	; 1P Loss Count++
	
.chkTextType:
	;
	; Determine which text to display.
	;
	
	ld   a, [wPlayMode]
	bit  MODEB_VS, a	; Playing in VS mode?
	jp   nz, .chkVS		; If so, jump
.chkSingle:
	; In single mode, if the CPU opponent wins, "YOU LOST".
	; Otherwise we win.
	
	ld   a, [wJoyActivePl]
	or   a				; Is 2P the active player? (not CPU opponent)
	jp   nz, .won		; If so, we won
	jp   .lost			; Otherwise, the CPU opponent is on the 2P side.
.chkVS:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a	; Running on the SGB?
	jp   z, .chkVS_serial	; If not, jump
	jp   .chkVS_sgb
.chkVS_serial:
	; On a VS serial battle, show "YOU WIN" on the slave side (as it's always 2P)
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_SLAVE, a	; Are we a slave?
	jr   nz, .vsSerialWon		; If so, we won
	jp   .lost
.vsSerialWon:
	jp   .won
.lost:
	ld   a, PLAY_OBJ_ROUNDTEXT_YOULOST
	jp   .showText
.won:
	ld   a, PLAY_OBJ_ROUNDTEXT_YOUWON
	jp   .showText
.chkVS_sgb_unused:
	; [TCRF] Unreachable code "leftover" from Play_Set1PWin
	ld   a, PLAY_OBJ_ROUNDTEXT_1PWON
	jp   .showText
.chkVS_sgb:
	; On a SGB VS battle, explicitly say that 2P won (since there's a single screen).
	ld   a, PLAY_OBJ_ROUNDTEXT_2PWON
.showText:
	ld   bc, wPlInfo_Pl2
	call Play_DoPostRoundText1PreWin
	
	; Set only 2P as last winner
	ld   hl, wLastWinner
	res  PLB1, [hl]
	set  PLB2, [hl]
	ret
	
; =============== Play_DoPostRoundText1PreWin ===============
; Displays the post-round text for a second.
; Note that this doesn't start the win pose -- that's set elsewhere
; and has to wait for this to return first.
; IN
; - A: Sprite mapping ID for the text (PLAY_OBJ_ROUNDTEXT_*)
; - BC: Ptr to wPlInfo
Play_DoPostRoundText1PreWin:
	; Display the text
	ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
	ld   [hl], OST_VISIBLE
	; Set the sprite mapping ID
	ld   [wOBJInfo_RoundText+iOBJInfo_OBJLstPtrTblOffset], a
	; Center it and update the display
	call Play_CenterRoundText
	call Task_PassControlFar
	
	; Display the text for one second
	ld   b, 60
	call Play_MainLoop_PostRound
	ret
	
; =============== Play_SetDraw ===============
; Sets the round result as a Draw, making both players lose.
; This updates all of the needed variables across the two players and
; handles the text display.
Play_SetDraw:
	; Display the round text centered
	ld   hl, wOBJInfo_RoundText+iOBJInfo_Status
	ld   [hl], OST_VISIBLE
	call Play_CenterRoundText
	
	; Set the sprite mapping, there's a special one when both players are dead.
	; (since this is a draw, if we get here both players must have the same health)
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]
	or   a								; Health == 0?
	jp   z, .setTextDKO					; If so, jump
.setTextDraw:
	ld   a, PLAY_OBJ_ROUNDTEXT_DRAWGAME
	jp   .setObj
.setTextDKO:
	ld   a, PLAY_OBJ_ROUNDTEXT_DOUBLEKO
.setObj:
	ld   [wOBJInfo_RoundText+iOBJInfo_OBJLstPtrTblOffset], a
	call Task_PassControlFar
	
	; Display text for a second
	; After exiting, other code will set the draw pose to both players
	ld   b, 60
	call Play_MainLoop_PostRound
	
	;
	; If we're in team mode, set its specific variables.
	;
	call IsInTeamMode
	jp   nc, .clrWinner
	
	; Both players lost
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamLossCount
	inc  [hl]
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamLossCount
	inc  [hl]
.clrWinner:
	; There's no last winner
	ld   hl, wLastWinner
	res  PLB1, [hl]
	res  PLB2, [hl]
	ret  
; =============== Play_MainLoop_PostRound ===============
; Version of the main loop used post-round.
; IN
; - B: Frames of execution (usually short)
Play_MainLoop_PostRound:
	push bc
		call Play_DoPlInput
		call Play_DoHUD
		call Play_DoMisc
		call Play_DoPlColi
		call Play_WriteKeysToBuffer
		call Play_DoScrollPos
		call Play_ExecExOBJCode
		call Task_PassControlFar
	pop  bc
	dec  b								; Done all frames?	
	jp   nz, Play_MainLoop_PostRound	; If not, loop
	ret
; =============== Play_CenterRoundText ===============
; Aligns the round text to the center of the screen.
Play_CenterRoundText:
	ld   a, [wOBJScrollX]
	add  a, $30 ; Add half a screen
	ld   [wOBJInfo_RoundText+iOBJInfo_X], a
	ret
	
; =============== Play_DoScrollPos ===============
; Updates the screen scroll positions for playfield and sprites.
Play_DoScrollPos:

	;
	; HORIZONTAL SCROLLING
	;
	; Moving too close to the edge of the screen ($20px in practice) will cause the screen to scroll,
	; but if both players are far enough to trigger the opposite screen edges, there's special handling involved.
	;
	; Note that, while we're updating wOBJScrollX and the checks are performed there
	; this value will be directly copied to hScrollX.
	;
SCROLL_BORDER_H EQU $20
	
	;
	; If both players aren't far enough (distance < $60), a simple border check can be made.
	;
	; Note that $60 is the largest applicable value before the $20px border would kick in
	; on both sides. ($60 + $20*2 = SCREEN_H)
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_PlDistance]
	cp   SCREEN_H-(SCROLL_BORDER_H*2)		; PlDistance < $60?
	jp   c, .chkNearX					; If so, jump
	
.chkFarX:
	;
	; Otherwise, the screen should be positioned so both players are
	; equally far to the edge of the screen, as long as the edge of the playfield isn't reached.
	;
	
	; Calculate the new target position.
	; This is the absolute "center point" between the two players, and the screen
	; should be positioned so the center of the screen points to that coordinate.
	; B = (X2 + X1) / 2
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	ld   b, a							; B = 2P X Pos
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]	; A = 1P X Pos
	srl  a		; A = A / 2
	srl  b		; B = B / 2
	add  b		; B += A
	ld   b, a
	
	; However, wOBJScrollX points to the left corner of the screen, not the center.
	; Additionally, checks are needed to prevent the camera from moving past the edge.
	; To satisfy those conditions the calculation will be done by .moveL and .moveR.
	;
	; Those subroutines though scroll the screen by a specified amount and don't accept
	; an absolute value. For this, convert the absolute value to relative (to the center of the screen):
	
	; Calculate absolute position currently at the center of the screen
	ld   a, [wOBJScrollX]	; A = Absolute left corner position
	add  a, SCREEN_H/2		; Add half a screen
	
	; The offset will be the distance between the center and target.
	; Add or remove it depending on whether it's on the left or right of the screen center.
	cp   a, b				
	jp   z, .setScrollX	; MidPoint == Target? If so, don't change anything
	jp   c, .moveFarR 	; MidPoint < Target? If so, move it right
.moveFarL:				; Otherwise, move it left
	; The target is on the left of the midpoint.
	; Move left by:
	; B = Target - MidPoint
	sub  a, b		; A = MidPoint - Target
	cpl				; Convert to negative
	inc  a
	ld   b, a
	
.moveL:
	;
	; Scroll the playfield left by B. Force it back to $00 if it underflows.
	;
	
	; wOBJScrollX = MAX(wOBJScrollX + B, 0)
	; B must be a negative value.
	ld   a, [wOBJScrollX]	; wOBJScrollX += B
	add  b
	ld   [wOBJScrollX], a
	bit  7, a				; wOBJScrollX < 0?
	jp   z, .setScrollX		; If so, jump
	ld   a, $00				; Otherwise, force it back to 0
	ld   [wOBJScrollX], a
	jp   .setScrollX
.moveFarR:
	; The target is on the right side of the screen.
	; Move right by:
	; B = Target - MidPoint
	sub  a, b		; A = MidPoint - Target
	cpl				; Convert to positive
	inc  a
	ld   b, a
.moveR:

	;
	; Scroll the playfield right by B. Force it back to $60 if it goes past that.
	;
	
	; As wOBJScrollX/hScrollX point to the left corner of the screen,
	; subtracting the screen width from the tilemap width will give the max value as $60.
	
	; wOBJScrollX = MIN(wOBJScrollX + B, $60)
	ld   a, [wOBJScrollX]
	add  b
	ld   [wOBJScrollX], a
	cp   TILEMAP_H-SCREEN_H	; $60
	jp   c, .setScrollX
	ld   a, TILEMAP_H-SCREEN_H ; $60
	ld   [wOBJScrollX], a
	jp   .setScrollX
.chkNearX:
	;
	; If any player is $20px (SCROLL_BORDER_H) near the edge of the screen, scroll it accordingly.
	; As the players are close to each other, no special checks are needed.
	;
	; However, the thresholds checked aren't directly $20px, since this is going off iOBJInfo_RelX.
	; That value is offset to the right by OBJ_OFFSET_X, and as a result: 
	;
SCROLL_THRESHOLD_L EQU SCROLL_BORDER_H+OBJ_OFFSET_X
SCROLL_THRESHOLD_R EQU SCREEN_H-(SCROLL_BORDER_H-OBJ_OFFSET_X)
	
	ld   a, [wOBJInfo_Pl1+iOBJInfo_RelX]
	cp   SCROLL_THRESHOLD_L			; iOBJInfo_RelX < $28?
	jp   c, .moveNearL				; If so, scroll left
	cp   SCROLL_THRESHOLD_R+1		; iOBJInfo_RelX >= $89? (> $88?)
	jp   nc, .moveNearR				; If so, scroll right
	; Same for 2P
	ld   a, [wOBJInfo_Pl2+iOBJInfo_RelX]
	cp   SCROLL_THRESHOLD_L
	jp   c, .moveNearL
	cp   SCROLL_THRESHOLD_R+1
	jp   nc, .moveNearR
	jp   .setScrollX
.moveNearL:
	; Scroll the screen left by how much the threshold was passed.
	; ie: if currently at position SCROLL_THRESHOLD_L-2, scroll left by 2px
	sub  a, SCROLL_THRESHOLD_L	; B = iOBJInfo_RelX - SCROLL_THRESHOLD_L
	ld   b, a
	jp   .moveL
.moveNearR:
	; Scroll the screen right by how much the threshold was passed, like in .moveNearL
	sub  a, SCROLL_THRESHOLD_R ; B = iOBJInfo_RelX - SCROLL_THRESHOLD_R
	ld   b, a
	jp   .moveR
.setScrollX:
	; Save the same result to the playfield scroll position
	ld   a, [wOBJScrollX]
	ldh  [hScrollX], a
	
.doY:
	;
	; VERTICAL SCROLLING
	;
	
	;
	; Calculate the base hScrollY position.
	;
	; On the floor, characters have the internal Y position $88 (PL_FLOOR_POS).
	; It will never be higher than that, and jumping decreases the value.
	;
	; As characters move jump up, the screen scrolls up slowly, so:
	;
	; hScrollY = -MAX((PL_FLOOR_POS - Y1) + (PL_FLOOR_POS - Y2)) / $10, 8)
	;
	; Note the negative sign.
	; When both characters stand on the floor, the Y scrolling is set up so
	; it's at coordinate 0, and jumping makes it underflow.
	; The tilemap of course accounts for this.
	;
	;
	
	; Get how much the 1P has jumped up
	; H = $88 - iOBJInfo_Y (1P)
	ld   a, [wOBJInfo_Pl1+iOBJInfo_Y]
	ld   b, a
	ld   a, PL_FLOOR_POS
	sub  a, b		
	ld   h, a
	; Get how much the 2P has jumped up
	; A = $88 - iOBJInfo_Y (2P)
	ld   a, [wOBJInfo_Pl2+iOBJInfo_Y]
	ld   b, a
	ld   a, PL_FLOOR_POS
	sub  a, b
	; Sum those together, so that if both players jump if makes it go even higher
	add  a, h
	; Slow down vertical movement as much as possible
	; A /= $10
	srl  a
	srl  a
	srl  a
	srl  a
	
	; Cap the result at 8.
	; This prevents scrolling the screen in a way that would make the characters
	; move below the bottom HUD, or scroll into the blank part of the tilemap.
	cp   $08			; A < $08?
	jp   c, .invY		; If so, jump
	ld   a, $08			; Otherwise, A = $08
.invY:
	; Invert the result since we're scrolling up from coord 0
	cpl		; A -= A
	inc  a
	; Save the result for now
	ldh  [hScrollY], a
	
	; The sprites are always have their origins least $40px from the bottom of the screen
	add  a, $40
	ld   [wOBJScrollY], a
	
	;
	; Screen shake support.
	;
	; If the optional offset is specified, add it exclusively to hScrollY without affecting sprites.
	; Note that the value is relative to the inverted version of hScrollY, so we must flip that back first.
	;
	ld   a, [wScreenShakeY]
	or   a					; wScreenShakeY == 0?
	jp   z, .ret			; If so, skip
	
	; Otherwise...
	; hScrollY = MIN(hScrollY - wScreenShakeY
	ld   b, a			; B = wScreenShakeY
	ldh  a, [hScrollY]	; A = -hScrollY
	cpl
	inc  a
	add  b				; A += B
	
	; Perform the same cap as above
	cp   $08			; A < $08?
	jp   c, .inv2Y		; If so, jump
	ld   a, $08			; Otherwise, A = $08
.inv2Y:
	cpl					; A = -A
	inc  a
	
	; Save the result
	ldh  [hScrollY], a
.ret:
	ret
	
; =============== Play_DoHUD ===============
; Updates the HUD and the related variables during gameplay.
; This includes decrementing the timer, as that's part of the subroutine
; that draws it to the HUD.
Play_DoHUD:
	call Play_UpdateHealthBars
	call Play_UpdatePowBars
	call Play_DoTime
	ret
	
; =============== Play_UpdateHealthBars ===============
; Draws/updates the health bar display for both players.
;
; This subroutine keeps the visual health value (what's displayed in the health bar) 
; synched up with the actual health (the target).
;
; The health bar increases or decreases 1px/frame, until the target value is reached.
;
Play_UpdateHealthBars:


; =============== mDrawHealthBarTile ===============
; Generates the common code used to write to the health bar tilemap when flashing.
; IN
; - HL: Ptr to tilemap
; - B: Tile ID
MACRO mDrawHealthBarTile
	push af
		di
		mWaitForVBlankOrHBlank
		ld   [hl], b
		ei
	pop  af
ENDM
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]
	ld   b, a									; B = Target health
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual]	; A = Visual Health
	cp   a, b				; Do they match?
	; If they match, skip ahead.
	jp   z, .eqTarget1P		; Health == Target?
	; If the visual health is less than the target, increase the bar.
	jp   c, .ltTarget1P		; Health < Target?
	; Otherwise, Health > Target. Decrease the bar.
.gtTarget1P:
	; Bar decreases to the left
	ld   hl, vBGHealthBar1P					; HL = Ptr to start of health bar in tilemap
	ld   bc, Play_Bar_TileIdTbl_LGrow		; BC = Tile ID table (bytes 7-0)
	ld   de, Play_Bar_BGOffsetTbl_LGrow		; DE = Tilemap offset table
	
	; VisualHealth--
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual] ; (not necessary, already in A)
	dec  a
	ld   [wPlInfo_Pl1+iPlInfo_HealthVisual], a
	; Update health bar
	call Play_DrawBarTip
	jp   .eqTarget1P
	
.ltTarget1P:
	; Bar grows to the right
	ld   hl, vBGHealthBar1P				; HL = Ptr to start of health bar in tilemap
	ld   bc, Play_Bar_TileIdTbl_LGrow+1	; BC = Tile ID table (bytes 1-8)
	ld   de, Play_Bar_BGOffsetTbl_LGrow	; DE = Tilemap offset table
	; VisualHealth++
	inc  a
	ld   [wPlInfo_Pl1+iPlInfo_HealthVisual], a
	; When the bar grows, it should always update the tile for the previous health value.
	; If we didn't, there'd be an empty gap between tiles when the modulo'd health goes from 7 to 8.
	;
	; ie:
	; -> 7 % 8 = 7 -> Tile+0 set at 7 filled pixels, 1 empty
	; -> 8 % 8 = 0 -> NG Tile+1 set at 8 empty pixels, leaving the previous value at Tile+0
	;                 OK Tile+0 set at 8 filled pixels
	; -> (then continuing as normal with 1 filled pixel on Tile+1)
	;
	; The VisualHealth being offset by -1 is also the reason behind the +1 offset
	; to Play_Bar_TileIdTbl_LGrow, as it shifts the tile IDs down by 1 too.
	dec  a
	call Play_DrawBarTip
	
	;--
	
.chkFixFlash1P:
	;
	; When the health increases from critical to fine, force replace
	; the blank bar graphics with the filled ones.
	;
	; This is because the flashing is done by alternating between empty and filled bar,
	; and it's very possible to switch while the bar is using the empty tiles.
	;
	
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual]
	cp   PLAY_HEALTH_CRITICAL		; VisualHealth != $18?
	jp   nz, .eqTarget1P			; If so, jump
	ld   hl, vBGHealthBar1P			; Start at lowest tile (matches origin in 1P)
	
	; Write filled bar to lowest tile
	di
	mWaitForVBlankOrHBlank
	ld   a, PLAY_TID_BAR_FILLED			; Tile ID for filled bar.	
	ldi  [hl], a
	ei
	
	; Write filled bar to 2nd-lowest tile
	push af	; Save PLAY_TID_BAR_FILLED
		di
		mWaitForVBlankOrHBlank
	pop  af	; Restore PLAY_TID_BAR_FILLED
	ldi  [hl], a			
	ei
	; No need to write it to the 3rd-lowest tile, as it's already seen done when the tip
	; was drawn due to the -1 offset.
	
.eqTarget1P:
	;
	; Handle the aforemented health bar flashing at critical health.
	; This is handled by alternating between blank and filled tiles every 4 frames
	; when the health is lower than 18 (meaning 3 tiles at most do the effect)
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual]
	cp   PLAY_HEALTH_CRITICAL	; VisualHealth >= $18?
	jp   nc, .do2P				; If so, skip
	
	; Every 4 frames...
	ld   a, [wTimer]
	and  a, $04				; wTimer % 4 != 0?	
	jp   nz, .flashShow1P	; If so, fill the bar
	
.flashBlank1P:
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual]	; A = Current health
	ld   b, PLAY_TID_BAR_EMPTY			; B = Tile ID for empty bar
	ld   hl, vBGHealthBar1P			; HL = Lowest tile of 1P health bar
	
	; To save time, only write to the non-empty tiles.	
	; Decrease the health by 8 every time, until it goes negative or we updated all 3 tiles.
	
	;
	; Lowest tile
	;
	mDrawHealthBarTile
	
	;
	; 2nd-lowest tile
	;
	sub  a, $08		; VisualHealth < $08?
	jp   c, .do2P	; If so, skip (2nd-lowest tile is already empty)
	inc  hl			; Move right in tilemap
	mDrawHealthBarTile
	
	;
	; 3rd-lowest tile
	;
	sub  a, $08		; VisualHealth < $10?
	jp   c, .do2P	; If so, skip
	inc  hl
	mDrawHealthBarTile
	
	jp   .do2P
	
.flashShow1P:
	; Display the bar
	ld   a, [wPlInfo_Pl1+iPlInfo_HealthVisual]	; A = Current health
	ld   b, PLAY_TID_BAR_FILLED			; B = Tile ID for filled bar
	ld   hl, vBGHealthBar1P			; HL = Lowest tile of 1P health bar
	
	; Move right from the lowest tile of the health bar, drawing completely filled tiles.
	; Stop when reaching the tip as that doesn't always use the filled tile.
	
	;
	; Lowest tile
	;
	sub  a, $08				; VisualHealth < $08?
	jp   c, .flashTip1P		; If so, jump (tip already reached)
	mDrawHealthBarTile
	inc  hl					; Move right in tilemap
	
	;
	; 2nd-lowest tile
	;
	sub  a, $08				; VisualHealth < $10?
	jp   c, .flashTip1P		; If so, jump 
	mDrawHealthBarTile
	inc  hl					; Move right in tilemap
	
	;
	; 3rd-lowest tile
	;
	sub  a, $08				; VisualHealth < $18?
	jp   c, .flashTip1P		; If so, jump (always)
	;--
	; [TCRF] Unreachable code, as the health bar only flashes at VisualHealth < 18.
	mDrawHealthBarTile
	jp   .do2P
	;--
.flashTip1P:
	;
	; Draw the tip of the health bar.
	; This is a simplified version of Play_DrawBarTip with somewhat hardcoded values.
	;
	
	; TileId = $D5 + (Health % 8)
	and  a, $07					; A = VisualHealth % 8
	or   a						; This check is unnecessary for the 1P tilemap
	jp   z, .flashTipEmpty1P	; as the empty bar and tile ID base are the same
	add  a, PLAY_TID_BAR_BASE+1
	; Write TileId to the tilemap
	push af
		di
		mWaitForVBlankOrHBlank
	pop  af
	ld   [hl], a
	ei
	jp   .do2P
.flashTipEmpty1P:
	; Write $D5 to the tilemap
	di
	mWaitForVBlankOrHBlank
	ld   a, PLAY_TID_BAR_EMPTY
	ld   [hl], a
	ei
	 
.do2P:
	;
	; Same thing for the 2P Health Bar
	;
	
	ld   a, [wPlInfo_Pl2+iPlInfo_Health]
	ld   b, a									; B = Target health
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]	; A = Visual Health
	cp   a, b										
	jp   z, .eqTarget2P		; Health == Target? If so, jump
	jp   c, .ltTarget2P 	; Health < Target?
	
.gtTarget2P:
	; Decrease the bar to the right
	ld   hl, vBGHealthBar2P						; HL = Ptr to start of health bar in tilemap
	ld   bc, Play_Bar_TileIdTbl_RGrow			; BC = Tile ID table (bytes 0-7)
	ld   de, Play_Bar_BGOffsetTbl_RGrow			; DE = Tilemap offset table
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]	; VisualHealth--
	dec  a
	ld   [wPlInfo_Pl2+iPlInfo_HealthVisual], a
	call Play_DrawBarTip
	jp   .eqTarget2P
	
.ltTarget2P:
	; Increase the bar to the left
	ld   hl, vBGHealthBar2P
	ld   bc, Play_Bar_TileIdTbl_RGrow+1
	ld   de, Play_Bar_BGOffsetTbl_RGrow
	inc  a										; VisualHealth++
	ld   [wPlInfo_Pl2+iPlInfo_HealthVisual], a
	dec  a										; Update tile for previous health value
	call Play_DrawBarTip
.chkFixFlash2P:
	; Force replace the blank bar graphics with the filled ones.
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]
	cp   PLAY_HEALTH_CRITICAL		; VisualHealth != $18?
	jp   nz, .eqTarget2P			; If so, jump
	ld   hl, vBGHealthBar2P_Last	; Start at lowest tile
	
	; Write filled bar to lowest tile
	di
	mWaitForVBlankOrHBlank
	ld   a, PLAY_TID_BAR_FILLED
	ldd  [hl], a
	ei
	
	; Write filled bar to 2nd-lowest tile
	push af
		di
		mWaitForVBlankOrHBlank
	pop  af
	ldd  [hl], a
	ei
	
.eqTarget2P:
	;
	; Handle the health bar flashing at critical health.
	;
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]
	cp   PLAY_HEALTH_CRITICAL	; VisualHealth >= $18?
	jp   nc, .ret				; If so, skip
	; Every 4 frames...
	ld   a, [wTimer]
	and  a, $04				; wTimer % 4 != 0?	
	jp   nz, .flashShow2P	; If so, show the bar
	
.flashBlank2P:
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]	; A = Current health
	ld   b, PLAY_TID_BAR_EMPTY			; B = Tile ID for empty bar
	ld   hl, vBGHealthBar2P_Last	; HL = Lowest tile of 2P health bar
	
	;
	; Lowest tile
	;
	mDrawHealthBarTile
	
	;
	; 2nd-lowest tile
	;
	sub  a, $08		; VisualHealth < $08?
	jp   c, .ret	; If so, skip (2nd-lowest tile is already empty)
	dec  hl			; Move left in tilemap
	mDrawHealthBarTile
	
	;
	; 3rd-lowest tile
	;
	sub  a, $08		; VisualHealth < $10?
	jp   c, .ret	; If so, skip
	dec  hl
	mDrawHealthBarTile
	
	jp   .ret
.flashShow2P:
	; Display the bar
	ld   a, [wPlInfo_Pl2+iPlInfo_HealthVisual]	; A = Current health
	ld   b, PLAY_TID_BAR_FILLED			; B = Tile ID for filled bar
	ld   hl, vBGHealthBar2P_Last	; HL = Lowest tile of 2P health bar
	
	; Move left from the lowest tile of the health bar, drawing completely filled tiles.
	
	ASSERT(PLAY_HEALTH_CRITICAL == $18)
	;
	; Lowest tile
	;
	sub  a, $08				; VisualHealth < $08?
	jp   c, .flashTip2P		; If so, jump (tip already reached)
	mDrawHealthBarTile
	dec  hl					; Move left in tilemap
	
	;
	; 2nd-lowest tile
	;
	sub  a, $08				; VisualHealth < $10?
	jp   c, .flashTip2P		; If so, jump 
	mDrawHealthBarTile
	dec  hl					; Move left in tilemap
	
	;
	; 3rd-lowest tile
	;
	sub  a, $08				; VisualHealth < $18?
	jp   c, .flashTip2P		; If so, jump (always)
	;--
	; [TCRF] Unreachable code, as the health bar only flashes at VisualHealth < 18.
	mDrawHealthBarTile
	jp   .ret
	;--
.flashTip2P:
	; Draw the tip of the health bar.
	; TileId = $D4 + (Health % 8)
	and  a, (PLAY_TID_BAR_SIZE-1)			; A = VisualHealth % 8
	; The tile for the empty tile is $D5, which doesn't work with the formula above
	or   a								; Is it $00?
	jp   z, .flashTipEmpty2P			; If so, skip
	add  a, PLAY_TID_BAR_BASE+PLAY_TID_BAR_SIZE	; Add tile ID base
	; Write TileId to the tilemap
	push af
		di
		mWaitForVBlankOrHBlank
	pop  af
	ld   [hl], a
	ei
	jp   .ret
.flashTipEmpty2P:
	; Write $D5 to the tilemap
	di
	mWaitForVBlankOrHBlank
	ld   a, PLAY_TID_BAR_EMPTY
	ld   [hl], a
	ei
.ret:
	ret
; =============== Play_DrawBarTip ===============
; Updates the tip tile of a bar.
; IN
; - HL: Ptr to bar in the tilemap (leftmost tile, even on 2P side)
; - BC: Ptr to tile id table. An 8 byte window of this is used.
; - DE: Ptr to tilemap offset table
; -  A: Visual bar value
Play_DrawBarTip:
	
	;
	; The bar graphics include multiple bar tiles to allow pixel-level precision.
	; Determine which tile id we're using for the tip of the bar.
	; A = TileId
	;
	push af
		; As tiles are 8px long, the tip can use 8 possible tiles (VisualHealth % 8).
		and  a, $07		; A = VisualHealth % 8
		; Use that as index to a table mapping sub-tile values to tile IDs.
		; This is different 
		add  c			; BC += A
		ld   c, a
		ld   a, [bc]	; Read value
	pop  bc
	
	;
	; Determine the tilemap ptr to the tip of the bar.
	; HL = TilemapPtr
	;
	push af
		; As tiles are 8px long...
		ld   a, b		; A = B / 8
		srl  a
		srl  a
		srl  a
		; Use that as index to a table of tilemap *offsets*.
		; The byte read out from here is added to the tilemap's origin passed in HL.
		;
		; Note that there are two different tables for the two players, as both
		; bars grow from the center of the screen.
		; Because the bar origin is always the leftmost tile for both sides, these
		; offsets are always positive.
		add  a, e		; DE += A (index table)
		ld   e, a
		ld   a, [de]	; A = TilemapOffset
		add  a, l		; HL += A (add it to tilemap ptr)
		ld   l, a
		
	;
	; Write the tile id to the tilemap
	;
		di
		mWaitForVBlankOrHBlank
	pop  af
	
	ld   [hl], a	
	ei
	
	ret 
	
; =============== Play_UpdatePowBars ===============
; Draws/updates the POW bar display for both players, including in the MAXIMUM POW mode.
; See also: Play_UpdateHealthBars
Play_UpdatePowBars:

; =============== mDrawPowBarTile ===============
; Generates the common code used to write to the pow bar tilemap.
; IN
; - HL: Ptr to tilemap
; - A: Tile ID
; OUT
; - HL: Ptr to the tilemap + 1
MACRO mDrawPowBarTile
	push af
		di   
		mWaitForVBlankOrHBlank
	pop  af
	ldi  [hl], a
	ei 
ENDM

	ld   a, [wPlInfo_Pl1+iPlInfo_Pow]
	ld   b, a								; B = Target POW
	ld   a, [wPlInfo_Pl1+iPlInfo_PowVisual]	; A = Visual POW
	cp   a, b
	; If nothing changes, skip to checking if we're in the MAX Pow state
	jp   z, .chkMaxPow1P
	; If the visual POW value is less than the target, increase the bar.
	jp   c, .ltTarget1P
	; Otherwise, POW > Target. Decrease the POW bar.
.gtTarget1P:
	; If we're decreasing the bar from $38, it means the MAXIMUM POW effect just ended.
	; That uses its own different tilemap, so replace it with the normal POW bar.
	cp   PLAY_POW_MAX			; VisualPOW == $38?
	jp   nz, .decPow1P			; If not, jump
	; Draw a fully filled bar otherwise, which will get decremented over time.
	ld   hl, vBGPowBar1P_Left
	push af
		ld   a, PLAY_TID_BAR_FILLED
		REPT 6
			mDrawPowBarTile
		ENDR
	pop  af
.decPow1P:
	
	; Decrease the POW bar
	ld   hl, vBGPowBar1P_Left
	ld   bc, Play_Bar_TileIdTbl_LGrow
	ld   de, Play_Bar_BGOffsetTbl_LGrow ; Use offsets 0-6
	; VisualPOW--
	dec  a
	ld   [wPlInfo_Pl1+iPlInfo_PowVisual], a
	call Play_DrawBarTip
	jp   .chk2P
.ltTarget1P:
	;
	; Increase the POW bar
	;
	ld   hl, vBGPowBar1P_Left
	ld   bc, Play_Bar_TileIdTbl_LGrow+1
	ld   de, Play_Bar_BGOffsetTbl_LGrow	; Use offsets 0-6
	inc  a
	ld   [wPlInfo_Pl1+iPlInfo_PowVisual], a
	; Draw the tip of the normal POW bar.
	; Like with the health bar, draw it for VisualPOW-1 for modulo reasons
	dec  a
	call Play_DrawBarTip
	jp   .chk2P
.chkMaxPow1P:
	;
	; If we've filled the POW bar, perform the MAXIMUM POW flashing effect.
	;
	; This alternates between a fully filled bar and "MAXIMUM", flashing
	; progressively quicker as MAX Pow mode elapses.
	; More priority is given to display "MAXIMUM" (since it triggers with != 0).
	;
	cp   PLAY_POW_MAX	 		; VisualPOW == $28?		
	jp   nz, .chk2P				; If so, jump
	
	; Determine what to draw
	ld   a, [wPlInfo_Pl1+iPlInfo_MaxPow]
	call Play_GetMaxPowTextFlashSpeed	; B = Animation mask
	ld   a, [wTimer]
	and  b								; wTimer & Mask != 0?
	jp   nz, .maxPowText1P				; If so, draw "MAXIMUM"
.maxPowBar1P:							; Otherwise, draw a filled MAX Power bar.
	; Skip if done already
	ld   hl, wPlayMaxPowDrawLast1P
	ld   a, [hl]
	or   a							; wPlayMaxPowDrawLast1P == PLAY_POW_LAST_BAR?
	jp   z, .chk2P					; If so, skip
	
	; Mark what's drawn
	ld   [hl], PLAY_POW_LAST_BAR
	
	; Draw the full bar
	ld   hl, vBGPowBar1P_Left
	ld   a, PLAY_TID_BAR_FILLED
	call Play_DrawFilledPowBar
	jp   .chk2P
	
.maxPowText1P:
	; Skip if done already
	ld   hl, wPlayMaxPowDrawLast1P
	ld   a, [hl]
	or   a							; wPlayMaxPowDrawLast1P == PLAY_POW_LAST_TEXT?
	jp   nz, .chk2P					; If so, skip
	
	; Mark what's drawn
	ld   [hl], PLAY_POW_LAST_TEXT
	
	; Draw "MAXIMUM"
	ld   hl, vBGPowBar1P_Left
	call Play_DrawMaximumText
	
.chk2P:
	;
	; Same thing, but for the 2P side
	;
	ld   a, [wPlInfo_Pl2+iPlInfo_Pow]
	ld   b, a								; B = Target POW
	ld   a, [wPlInfo_Pl2+iPlInfo_PowVisual]	; A = Visual POW
	cp   a, b
	; If nothing changes, skip to checking if we're in the MAX Pow state
	jp   z, .chkMaxPow2P
	; If the visual POW value is less than the target, increase the bar.
	jp   c, .ltTarget2P
	; Otherwise, POW > Target. Decrease the POW bar.
.gtTarget2P:
	;
	; Decrease the POW bar
	;
	cp   PLAY_POW_MAX			; VisualPOW == $38?
	jp   nz, .decPow2P			; If not, jump
	; Draw a fully filled bar, which will get decremented over time.
	ld   hl, vBGPowBar2P_Left+1
	push af
		ld   a, PLAY_TID_BAR_FILLED
		REPT 6
			mDrawPowBarTile
		ENDR
	pop  af
.decPow2P:
	
	; Decrease the POW bar
	ld   hl, vBGPowBar2P_Left
	ld   bc, Play_Bar_TileIdTbl_RGrow
	ld   de, Play_Bar_BGOffsetTbl_RGrow+2 ; Use offsets 2-8
	; VisualPOW--
	dec  a
	ld   [wPlInfo_Pl2+iPlInfo_PowVisual], a
	call Play_DrawBarTip
	jp   .ret
.ltTarget2P:
	;
	; Increase the POW bar
	;
	ld   hl, vBGPowBar2P_Left
	ld   bc, Play_Bar_TileIdTbl_RGrow+1
	ld   de, Play_Bar_BGOffsetTbl_RGrow+2 ; Use offsets 2-8
	inc  a
	ld   [wPlInfo_Pl2+iPlInfo_PowVisual], a
	; Draw the tip of the normal POW bar.
	dec  a
	call Play_DrawBarTip
	jp   .ret
.chkMaxPow2P:
	;
	; If we've filled the POW bar, perform the MAXIMUM POW flashing effect.
	;
	cp   PLAY_POW_MAX	 		; VisualPOW == $28?		
	jp   nz, .ret				; If so, jump
	
	; Determine what to draw
	ld   a, [wPlInfo_Pl2+iPlInfo_MaxPow]
	call Play_GetMaxPowTextFlashSpeed	; B = Animation mask
	ld   a, [wTimer]
	and  b								; wTimer & Mask != 0?
	jp   nz, .maxPowText2P				; If so, draw "MAXIMUM"
.maxPowBar2P:							; Otherwise, draw a filled MAX Power bar.
	; Skip if done already
	ld   hl, wPlayMaxPowDrawLast2P
	ld   a, [hl]
	or   a							; wPlayMaxPowDrawLast2P == PLAY_POW_LAST_BAR?
	jp   z, .ret					; If so, skip
	
	; Mark what's drawn
	ld   [hl], PLAY_POW_LAST_BAR
	
	; Draw the full bar
	ld   hl, vBGPowBar2P_Left
	ld   a, PLAY_TID_BAR_FILLED
	call Play_DrawFilledPowBar
	jp   .ret
	
.maxPowText2P:
	; Skip if done already
	ld   hl, wPlayMaxPowDrawLast2P
	ld   a, [hl]
	or   a							; wPlayMaxPowDrawLast2P == PLAY_POW_LAST_TEXT?
	jp   nz, .ret					; If so, skip
	
	; Mark what's drawn
	ld   [hl], PLAY_POW_LAST_TEXT
	
	; Draw "MAXIMUM"
	ld   hl, vBGPowBar2P_Left
	call Play_DrawMaximumText
.ret:
	ret
	
; =============== Play_GetMaxPowTextFlashSpeed ===============
; Gets the animation speed for flashing the "MAXIMUM" text, as a bitmask.
; IN
; - A: iPlInfo_MaxPow
; OUT
; - B: Bar flashing speed (bitmask)
Play_GetMaxPowTextFlashSpeed:
	; As the MAX Power mode timer ticks down, flash the text faster
	cp   $78		; Timer >= $78?
	jp   nc, .s30	; If so, jump
	cp   $3C		; ...
	jp   nc, .s18
	cp   $1E
	jp   nc, .s1E
	cp   $0F
	jp   nc, .s0F
	cp   $07
	jp   nc, .s03
.s01:
	ld   b, %00000001
	jp   .ret
.s03:
	ld   b, %00000011
	jp   .ret
.s0F:
	ld   b, %00000110
	jp   .ret
.s1E:
	ld   b, %00001100
	jp   .ret
.s18:
	ld   b, %00011000
	jp   .ret
.s30:
	ld   b, %00110000
.ret:
	ret  
	
; =============== Play_DrawFilledPowBar ===============
; Draws the contents of a completely filled POW bar.
; IN
; - A: Tile ID (always PLAY_TID_BAR_FILLED)
; - HL: Tilemap ptr to the leftmost tile of a Pow bar.
Play_DrawFilledPowBar:
	; Overwrite 7 tiles from HL to the right
	REPT 6
		mDrawPowBarTile
	ENDR
	;--
	push af
		di   
		mWaitForVBlankOrHBlank
	pop  af
	ld  [hl], a
	ei 
	;--
	ret
	
; =============== Play_DrawMaximumText ===============
; Draws the "MAXIMUM" text, replacing a normal POW bar.
; IN
; - HL: Ptr to tilemap
Play_DrawMaximumText:

; =============== mDrawPowBarTileId ===============
; IN
; - \1: Tile ID
; - \2: [OPTIONAL] Marks the last tile
; - HL: Ptr to tilemap
; OUT
; - HL: Ptr to the tilemap + 1
MACRO mDrawPowBarTileId
	mWaitForVBlankOrHBlank
	ld   a, \1
	IF _NARG > 1
		ld   [hl], a
	ELSE
		ldi  [hl], a
	ENDC
ENDM

	di
	mDrawPowBarTileId $E4    ; M
	mDrawPowBarTileId $E5    ; A
	mDrawPowBarTileId $E6    ; X
	mDrawPowBarTileId $E7    ; I
	mDrawPowBarTileId $E4    ; M
	mDrawPowBarTileId $E8    ; U
	mDrawPowBarTileId $E4, 1 ; M
	ei
	ret  
	
; =============== Play_DoTime ===============
; Handles the round timer during gameplay.
Play_DoTime:

	;
	; There's a gauntlet of checks before we're allowed to draw the timer or decrement a timer digit.
	;
	
	ld   a, [wRoundTime]
	or   a						; Time Over?
	jp   z, Play_NoDrawTime		; If so, return
	cp   TIMER_INFINITE			; Is the timer set to infinite?
	jp   z, Play_NoDrawTime		; If so, return
	
	; If any player lost (has no health), constantly redraw the current time
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]
	or   a						
	jp   z, Play_DrawTime
	ld   a, [wPlInfo_Pl2+iPlInfo_Health]
	or   a
	jp   z, Play_DrawTime
	
	; If we're in a scene with controls disabled (ie: intro), return
	ld   hl, wMisc_C027
	bit  MISCB_PLAY_STOP, [hl]
	jp   nz, Play_NoDrawTime
	
	; Decrement subsecond counter.
	; If it reaches 0, jump and decrement the seconds too.
	ld   hl, wRoundTimeSub
	dec  [hl]
	jp   z, .decTime
	
	; The rest is to handle the timer flashing with 21 or less seconds.
	ld   a, [wRoundTime]
	cp   $16				; Timer < 22?
	jp   c, .flashTime		; If so, jump
	jp   Play_NoDrawTime	; Otherwise, return
.flashTime:
	; Show/hide the timer every 4 frames.
	ld   a, [wTimer]
	bit  2, a				; wTimer & 4 == 0?
	jp   nz, .flashTimeShow	; If not, jump
.flashTimeHide:
	; Replace the two timer digits in the tilemap with blank tiles
	ld   hl, vBGRoundTime
	di
	mWaitForVBlankOrHBlank
	xor  a
	ldi  [hl], a
	mWaitForVBlankOrHBlank
	xor  a
	ld   [hl], a
	ei
	jp   Play_NoDrawTime
.flashTimeShow:
	; Redraw the timer normally
	jp   Play_DrawTime
.decTime:
	; wRoundTime--
	ld   a, [wRoundTime]
	sub  a, $01
	daa
	ld   [wRoundTime], a
	; Reset counter to 60 frames
	ld   a, 60
	ld   [wRoundTimeSub], a
	jp   Play_DrawTime
	
; =============== Play_DrawTime ===============
; Draws the round timer in the HUD.
Play_DrawTime:
	ld   hl, vBGRoundTime			; HL = Ptr to high digit in the tilemap
	
	;
	; Get the tile ID for the upper nybble.
	; As the round timer is in BCD format, it can be done by isolating the upper nybble
	; and then using it as index to a number -> tileID table.
	;
	
	ld   a, [wRoundTime]		; A  = Time
	ld   de, Play_HUDTileIdTbl	; DE = Tile ID table
	; Generate index
	swap a				; A = A >> 4
	and  a, $0F	 
	; Index the map table
	add  a, e			; DE += A
	ld   e, a
	; Write it to the tilemap
	di
	mWaitForVBlankOrHBlank
	ld   a, [de]		; Read tile ID
	ldi  [hl], a		; Write it over, VRAMPtr++
	ei
	
	;
	; Do the same for the lower digit.
	;
	ld   a, [wRoundTime]		; A  = Time
	ld   de, Play_HUDTileIdTbl	; DE = Tile ID table
	; Generate index
	and  a, $0F			; A = A & $0F
	; Index the map table
	add  a, e			; DE += A
	ld   e, a
	; Write it to the tilemap
	di
	mWaitForVBlankOrHBlank
	ld   a, [de]		; Read tile ID
	ld   [hl], a		; Write it over
	ei
	; Fall-through
	
; =============== Play_NoDrawTime ===============
; Target used to skip writing the time.
Play_NoDrawTime:
	ret

; =============== Play_WriteKeysToBuffer ===============
; Updates the input buffers for both players.
Play_WriteKeysToBuffer:
	; Human player only
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	bit  PF0B_CPU, [hl]
	jr   nz, .chk2P
	call Play_WriteDirKeysToBuffer1P
	call Play_WriteBtnKeysToBuffer1P
.chk2P:
	; Same thing for 2P
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	bit  PF0B_CPU, [hl]
	jr   nz, .ret
	call Play_WriteDirKeysToBuffer2P
	call Play_WriteBtnKeysToBuffer2P
.ret:
	ret
	
; =============== mWriteDirKeysToBuffer ===============
; Generates code to write the held directional keys to its wPlInfo joypad buffer.
; IN
; - 1: Ptr to wPlInfo
; - 2: Ptr to wOBJInfo
MACRO mWriteDirKeysToBuffer
	; DE = Offset to buffer entry
	;      This must be a multiple of 2 as each entry in this table
	;      is 2 bytes long (key, timer)
	ld   d, $00
	ld   a, [\1+iPlInfo_JoyDirBufferOffset]
	ld   e, a
	
	; Write the directional keys only
	; A = Held directional keys
	ld   a, [\1+iPlInfo_JoyKeys]
	and  a, $0F
	
	;
	; Invert the left/right inputs if we're (internally) facing right.
	; For consistency with the sprite display, move inputs are stored relative to players facing left (on the 2P side).
	; 
	ld   hl, \2+iOBJInfo_OBJLstFlags
	bit  SPRXB_PLDIR_R, [hl]	; Is 1P facing right?
	jr   z, .writeToBuf			; If not, jump
	
	; Don't invert input bits if neither L nor R are held
	ld   b, a					; Save orig inputs
	and  a, KEY_LEFT|KEY_RIGHT	; Holding either left or right?
	jr   z, .noLr				; If not, jump
	ld   a, b					; Restore input bits
	xor  KEY_LEFT|KEY_RIGHT		; Invert left/right inputs
	jr   .writeToBuf
.noLr:
	ld   a, b					; Restore orig inputs as there's nothing to invert
	
.writeToBuf:
	; Seek HL to the current buffer entry
	ld   hl, \1+iPlInfo_JoyDirBuffer
	add  hl, de			; HL = iPlInfo_JoyDirBuffer + iPlInfo_JoyDirBufferOffset
	
	; If the currently held d-pad keys are the same as what's in the buffer entry,
	; continue increasing its timer.
	cp   a, [hl]		; CurKeys == BufKeys?
	jr   z, .incTimer	; If so, jump

.newKey:	
	;
	; Seek to the next buffer entry.
	;
	
	; Generate the new buffer offset from the ptr, looping back to $00 when it goes past the buffer.
	; Index = (DE + 2) & $0F 
	;
	; This works due to the buffer being aligned to a specific address and for having a specific size.
	inc  e			; DE += 2 (next entry)
	inc  e
	push af			; E &= $0F (force in range/loop to $00 if needed)
		ld   a, e	
		and  a, $0F
		ld   e, a
	pop  af
	; Seek to the new offset 
	ld   hl, \1+iPlInfo_JoyDirBuffer
	add  hl, de
	
	; Write the new keys
	ld   [hl], a
	; Initialize the timer at 1
	inc  hl
	ld   [hl], $01
	
	; Save back the new buffer offset
	ld   a, e
	ld   [\1+iPlInfo_JoyDirBufferOffset], a
	ret
.incTimer:
	; Increase timer, maxing out at $FF
	inc  hl			; Seek to timer byte
	ld   a, [hl]	
	cp   $FF		; Timer == $FF?
	ret  z			; If so, return
	inc  [hl]		; Otherwise, Timer++
	ret
ENDM

; =============== mWriteBtnKeysToBuffer ===============
; Generates code to write the held button keys to its wPlInfo joypad buffer.
; See also: mWriteDirKeysToBuffer
; IN
; - 1: Ptr to player struct
MACRO mWriteBtnKeysToBuffer

	; This uses its own buffer, separate from the one with directional keys.

	; DE = Offset to buffer entry
	ld   d, $00
	ld   a, [\1+iPlInfo_JoyBtnBufferOffset]
	ld   e, a
	; Write the directional keys only
	ld   a, [\1+iPlInfo_JoyKeys]
	and  a, KEY_A|KEY_B
	
	; (the buttons aren't afffected by facing left/right for obvious reasons, so direct skip to .writeToBuf)
.writeToBuf:
	; Seek HL to the current buffer entry
	ld   hl, \1+iPlInfo_JoyBtnBuffer
	add  hl, de
	
	; If the currently held buttons are the same as what's in the buffer entry,
	; continue increasing its timer.
	cp   a, [hl]		; CurKeys == BufKeys?
	jr   z, .incTimer	; If so, jump
	
.newKey:	
	;
	; Seek to the next buffer entry, exactly like in the other function.
	;
	
	; Index = (DE + 2) & $0F  
	inc  e
	inc  e
	push af
		ld   a, e
		and  a, $0F
		ld   e, a
	pop  af
	
	; Seek to the new offset 
	ld   hl, \1+iPlInfo_JoyBtnBuffer
	add  hl, de
	
	; Write the new keys
	ld   [hl], a
	; Initialize the timer at 1
	inc  hl
	ld   [hl], $01
	
	; Save back the new buffer offset
	ld   a, e
	ld   [\1+iPlInfo_JoyBtnBufferOffset], a
	ret
.incTimer:
	; Increase timer, maxing out at $FF
	inc  hl			; Seek to timer byte
	ld   a, [hl]	
	cp   $FF		; Timer == $FF?
	ret  z			; If so, return
	inc  [hl]		; Otherwise, Timer++
	ret
ENDM

Play_WriteDirKeysToBuffer1P: mWriteDirKeysToBuffer wPlInfo_Pl1, wOBJInfo_Pl1
Play_WriteDirKeysToBuffer2P: mWriteDirKeysToBuffer wPlInfo_Pl2, wOBJInfo_Pl2
Play_WriteBtnKeysToBuffer1P: mWriteBtnKeysToBuffer wPlInfo_Pl1
Play_WriteBtnKeysToBuffer2P: mWriteBtnKeysToBuffer wPlInfo_Pl2

;
; HUD Graphics
;


; Character Names, GFX + Tilemaps
GFX_Play_HUD_CharNames: INCBIN "data/gfx/play_hud_charnames.bin"

PUSHC
SETCHARMAP hudchar

BGXDef_Play_HUD_CharName_Kyo:      mTxtDef "KYO"
BGXDef_Play_HUD_CharName_Benimaru: mTxtDef "BENIMARU"
BGXDef_Play_HUD_CharName_Ryo:      mTxtDef "RYO"
BGXDef_Play_HUD_CharName_Yuri:     mTxtDef "YURI"
BGXDef_Play_HUD_CharName_Terry:    mTxtDef "TERRY"
BGXDef_Play_HUD_CharName_Joe:      mTxtDef "JOE"
BGXDef_Play_HUD_CharName_Heidern:  mTxtDef "HEIDERN"
BGXDef_Play_HUD_CharName_Ralf:     mTxtDef "RALF"
BGXDef_Play_HUD_CharName_Athena:   mTxtDef "ATHENA"
BGXDef_Play_HUD_CharName_Kensou:   mTxtDef "KENSOU"
BGXDef_Play_HUD_CharName_Kim:      mTxtDef "KIM"
BGXDef_Play_HUD_CharName_Mai:      mTxtDef "MAI"
BGXDef_Play_HUD_CharName_Iori:     mTxtDef "IORI"
BGXDef_Play_HUD_CharName_Eiji:     mTxtDef "EIJI"
BGXDef_Play_HUD_CharName_Billy:    mTxtDef "BILLY"
BGXDef_Play_HUD_CharName_Saisyu:   mTxtDef "SAISYU"
BGXDef_Play_HUD_CharName_Rugal:    mTxtDef "RUGAL"
BGXDef_Play_HUD_CharName_Nakoruru: mTxtDef "NAKORURU"

POPC

; Character Icons
GFX_Char_Icons: INCBIN "data/gfx/char_icons.bin"

; Other HUD elements
GFXAuto_Play_HUD_Bar: 
	dw $8D40
IF REV_VER == 96
	mGfxDef "data/gfx/96f/play_hud_bar.bin"
ELSE
	mGfxDef "data/gfx/play_hud_bar.bin"
ENDC
GFXAuto_Play_HUD:
	dw $8C80
IF REV_VER == 96
	mGfxDef "data/gfx/96f/play_hud.bin"
ELSE
	mGfxDef "data/gfx/play_hud.bin"
ENDC
GFXDef_Play_HUD_1PHuman: mGfxDef "data/gfx/play_hud_1phuman.bin"
GFXDef_Play_HUD_2PHuman: mGfxDef "data/gfx/play_hud_2phuman.bin"
GFXDef_Play_HUD_1PCPU: mGfxDef "data/gfx/play_hud_1pcpu.bin"
GFXDef_Play_HUD_2PCPU: mGfxDef "data/gfx/play_hud_2pcpu.bin"
BG_Play_HUD_Time: INCBIN "data/bg/play_hud_time.bin"
BG_Play_HUD_VS: INCBIN "data/bg/play_hud_vs.bin"
BG_Play_HUD_1PMarker: INCBIN "data/bg/play_hud_1pmarker.bin"
BG_Play_HUD_2PMarker: INCBIN "data/bg/play_hud_2pmarker.bin"
BG_Play_HUD_HealthBarL: INCBIN "data/bg/play_hud_healthbarl.bin"
BG_Play_HUD_HealthBarR: INCBIN "data/bg/play_hud_healthbarr.bin"
IF REV_VER == 96
GFX_Play_HUD_SingleWinMarker: INCBIN "data/gfx/96f/play_hud_singlewinmarker.bin"
GFX_Char_Cross: INCBIN "data/gfx/96f/char_cross.bin"
ELSE
GFX_Play_HUD_SingleWinMarker: INCBIN "data/gfx/play_hud_singlewinmarker.bin"
GFX_Char_Cross: INCBIN "data/gfx/char_cross.bin"
ENDC

GFXAuto_Play_HUD_TimerNum:
	dw $8F10
	mGfxDef "data/gfx/play_hud_timernum.bin"
GFXAuto_Play_HUD_Pause:
	dw $8FB0
	mGfxDef "data/gfx/play_hud_pause.bin"
GFXAuto_Play_HUD_TimerInfinite:
	dw $8F10
	mGfxDef "data/gfx/play_hud_timerinfinite.bin"
BG_Play_HUD_TimerInfinite: INCBIN "data/bg/play_hud_timerinfinite.bin"
GFXAuto_Play_RoundFont:
	dw $8800
	mGfxDef "data/gfx/play_roundfont.bin"

OBJInfoInit_Play_RoundText: 
	db $00 ; iOBJInfo_Status
	db $00 ; iOBJInfo_OBJLstFlags
	db $00 ; iOBJInfo_OBJLstFlagsView
	db $60 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db $80 ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $80 ; iOBJInfo_TileIDBase
	db LOW($8800) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8800) ; iOBJInfo_VRAMPtr_High
	db BANK(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_BankNum (BANK $01)
	db LOW(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db BANK(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_BankNum (BANK $01)
	db LOW(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Play_RoundText) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db $00 ; iOBJInfo_BufInfoPtr_Low
	db $00 ; iOBJInfo_BufInfoPtr_High

INCLUDE "data/objlst/play_misc.asm"
		
; Projectile graphics
GFXDef_Proj_KyoIoriSaisyu: mGfxDef "data/gfx/proj/kyoiorisaisyu.bin"
GFXDef_Proj_Benimaru: mGfxDef "data/gfx/proj/benimaru.bin"
GFXDef_Proj_Ryo: mGfxDef "data/gfx/proj/ryo.bin"
GFXDef_Proj_Yuri: mGfxDef "data/gfx/proj/yuri.bin"
GFXDef_Proj_TerryRalf: mGfxDef "data/gfx/proj/terryralf.bin"
GFXDef_Proj_Joe: mGfxDef "data/gfx/proj/joe.bin"
GFXDef_Proj_Heidern: mGfxDef "data/gfx/proj/heidern.bin"
GFXDef_Proj_AthenaKensou: mGfxDef "data/gfx/proj/athenakensou.bin"
GFXDef_Proj_Mai: mGfxDef "data/gfx/proj/mai.bin"
GFXDef_Proj_Eiji: mGfxDef "data/gfx/proj/eiji.bin"
GFXDef_Proj_Billy: mGfxDef "data/gfx/proj/billy.bin"
GFXDef_Proj_Rugal: mGfxDef "data/gfx/proj/rugal.bin"
GFXDef_Proj_KimNakoruru: mGfxDef "data/gfx/proj/kimnakoruru.bin"

; This uses a placeholder OBJLstPtrTbl that's not pointing to a real OBJLstPtrTable.
; Those fields gets properly set when "spawning" a projectile. (MoveC_*)
OBJInfoInit_Projectile:
	db $00 ; iOBJInfo_Status
	db $00 ; iOBJInfo_OBJLstFlags
	db $00 ; iOBJInfo_OBJLstFlagsView
	db $60 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db $74 ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $80 ; iOBJInfo_TileIDBase
	db LOW($8800) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8800) ; iOBJInfo_VRAMPtr_High
	db $07 ; iOBJInfo_BankNum (BANK $07)
	db LOW($7744) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH($7744) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNum [N/A]
	db $00 ; iOBJInfo_OBJLstPtrTbl_Low
	db $00 ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db $00 ; iOBJInfo_BufInfoPtr_Low
	db $00 ; iOBJInfo_BufInfoPtr_High


INCLUDE "data/objlst/proj.asm"
; =============== END OF BANK ===============
; Junk area below.
	mIncJunk "L017E65"