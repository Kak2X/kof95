
; =============== mWaitHBlankEnd ===============
; Waits for the current HBlank to finish, if we're in one.
MACRO mWaitForHBlankEnd
.waitHBlankEnd_\@:
	ldh  a, [rSTAT]
	and  a, $03
	jp   z, .waitHBlankEnd_\@
ENDM
; =============== mWaitHBlank ===============
; Waits for the HBlank period.
MACRO mWaitForHBlank
.waitHBlank_\@:
	ldh  a, [rSTAT]
	and  a, $03
	jp   nz, .waitHBlank_\@
ENDM
; =============== mWaitForNewHBlank ===============
; Waits for the start of a new HBlank period.
MACRO mWaitForNewHBlank
	; If we're in HBlank already, wait for it to finish
	mWaitForHBlankEnd
	; Then wait for the HBlank proper
	mWaitForHBlank
ENDM

; =============== mWaitForVBlankOrHBlank ===============
; Waits for the VBlank or HBlank period.
MACRO mWaitForVBlankOrHBlank
.waitVBlankOrHBlank_\@:
	ldh  a, [rSTAT]
	bit  1, a
	jp   nz, .waitVBlankOrHBlank_\@
ENDM

; =============== mWaitForVBlankOrHBlankFast ===============
; Waits for the VBlank or HBlank period.
MACRO mWaitForVBlankOrHBlankFast
.waitVBlankOrHBlank_\@:
	ldh  a, [rSTAT]
	bit  1, a
	jr   nz, .waitVBlankOrHBlank_\@
ENDM

; =============== mBinDef ===============
; Generates an include for a binary *Def structure, where the data 
; is prepended with its length in bytes.
; IN
; - \1: Path to file to INCBIN
MACRO mBinDef
	db (.end-.bin)	; Size of data
.bin:
	INCBIN \1		; Data itself
.end:
ENDM

; =============== mGfxDef ===============
; Generates an include for a binary GfxDef structure.
; This is like mBinDef, except the size is expressed in tiles.
; IN
; - \1: Path to file to INCBIN
MACRO mGfxDef
	db (.end-.bin)/TILESIZE ; Number of tiles
.bin:
	INCBIN \1		; Data itself
.end:
ENDM

; =============== mTxtDef ===============
; Generates a counted string.
; IN
; - \1: A string
MACRO mTxtDef
	db (.end-.bin) ; Number of letters
.bin:
	db \1		   ; Text string
.end:
ENDM

; =============== mIncJunk ===============
; Generates an include for junk padding data.
; IN
; - \1: Filename without extension
MACRO mIncJunk

IF LABEL_JUNK
Padding_\@:
ENDC
	IF !SKIP_JUNK
		IF VER_EN
			INCBIN STRCAT("padding_en/", \1, ".bin")
		ELSE
			INCBIN STRCAT("padding/", \1, ".bin")
		ENDC
	ENDC
ENDM

; =============== dp ===============
; Shorthand for far pointers in standard order.
MACRO dp
	db BANK(\1)
	dw \1
ENDM
; =============== dpr ===============
; Shorthand for far pointers in reverse order.
MACRO dpr
	dw \1
	db BANK(\1)
ENDM

; =============== pkg ===============
; Shorthand for the header of a (set of) SGB Packets
; IN
; - 1: Packet ID
; - 2: Number of packets
MACRO pkg
	db (\1 * 8) | \2
ENDM

; =============== ads ===============
; Data set byte 2 for a SGB_PACKET_ATTR_BLK command.
; IN
; - 1: Palette ID (inside)
; - 2: Palette ID (border)
; - 3: Palette ID (outside)
MACRO ads
	db (\1)|(\1 << 2)|(\1 << 4)
ENDM

; =============== mkhl ===============
; Generates a generic HL parameter.
; IN
; - 1: H
; - 2: L
; OUT
; - CHL: Calculated result
MACRO mkhl
DEF CHL = (LOW(\1) << 8)|LOW(\2)
ENDM

; =============== mktid ===============
; Generates a tile ID from a VRAM (GFX) pointer.
; IN
; - 1: VRAM Pointer
; OUT
; - TID: Calculated result
MACRO mktid
DEF TID = LOW(\1 >> 4)
ENDM

; =============== Special move list definition macros ===============
; For MoveInputReader_*
;
; However, some are also used by the move code itself.

; =============== mMvIn_Validate ===============
; Performs initial validation at the start of an input reader,
; and determines if we should go to the air or ground list.
; IN
; - 1: Char key
; - 2: If set, air moves are allowed
MACRO mMvIn_Validate
	call MoveInputS_CanStartSpecialMove	; Can we start a new special/super?
	jp   c, MoveInputReader_\<1>_NoMove	; If not, return
	
	; If air moves aren't allowed, return immediately if we're in the air
	IF \<2> >= 1 ; Air moves allowed
		ld   hl, iPlInfo_Flags1
		add  hl, bc								; Seek to iPlInfo_Flags1
	ELSE
		ld   hl, iPlInfo_Flags0
		add  hl, bc								; Seek to iPlInfo_Flags0
		bit  PF0B_AIR, [hl]						; Are we in the air?
		jp   nz, MoveInputReader_\<1>_NoMove	; If so, return
		inc  hl 								; Seek to iPlInfo_Flags1
	ENDC
	
	; MoveInputS_CanStartSpecialMove doesn't check for these in this game,
	; every input reader has to do it manually.
	bit  PF1B_ALLOWHITCANCEL, [hl]			; Can we cancel the current move into a special/super? (off the previous hit)
	jp   nz, .valid							; If so, skip (ok)
	bit  PF1B_NOSPECSTART, [hl]				; Are we explicitly disallowed to start a new special/super?
	jp   nz, MoveInputReader_\<1>_NoMove	; If so, return
.valid:

	; If air moves are allowed, jump to the appropriate "move list" (code path)
	IF \<2> == 1 ; Air moves allowed
		dec  hl					; Seek back to iPlInfo_Flags1
		bit  PF0B_AIR, [hl]		; Are we in the air?
		jp   z, .chkGround		; If not, jump
	ELIF \<2> == 2 ; Anything that uses this is dumb and should have used 0 instead
		dec  hl					; Seek back to iPlInfo_Flags1
		bit  PF0B_AIR, [hl]		; Are we in the air?
		jp   nz,  MoveInputReader_\<1>_NoMove	; If so, jump
	ENDC
ENDM

; =============== mMvIn_ChkEasy ===============
; Checks for move shortcuts (requires the easy moves cheat).
; IN
; - 1: Move key for SELECT + B
; - 2: Move key for SELECT + A
MACRO mMvIn_ChkEasy
	call MoveInputS_CheckEasyMoveKeys
	jp   c, \1 ; SELECT + B pressed? If so, jump
	jp   z, \2 ; SELECT + A pressed? If so, jump
ENDM

; =============== mMvIn_ChkGA ===============
; Determines if the punch or kick move inputs should be checked.
; IN
; - 1: Char key
; - 2: Label to punch list
; - 3: Label to kick list
; - 4: Visibility flags
DEF CHKGA_KICK  EQU %1
DEF CHKGA_PUNCH EQU %10
MACRO mMvIn_ChkGA
	; Determine the attack type/strength.
	; This narrows down the list of special moves to check.
	
	ld   hl, iPlInfo_JoyKeysLH
	add  hl, bc					; Seek to LH info
	ld   a, [hl]				; A = Light/Heavy attack info
	
	IF (\<4> & CHKGA_KICK)
		bit  KEPB_A_LIGHT, a	; Was the light kick button pressed?
		jr   nz, \3				; If so, jump
	ENDC
	IF (\<4> & CHKGA_PUNCH)
		bit  KEPB_B_LIGHT, a	; Was the light punch button pressed?
		jr   nz, \2				; If so, jump
	ENDC
	IF (\<4> & CHKGA_KICK)
		bit  KEPB_A_HEAVY, a	; Was the heavy kick button pressed?
		jr   nz, \3				; If so, jump
	ENDC
	IF (\<4> & CHKGA_PUNCH)
		bit  KEPB_B_HEAVY, a	; Was the heavy punch button pressed?
		jr   nz, \2				; If so, jump
	ENDC
	
	; No attack button was pressed, return
	jp   MoveInputReader_\<1>_NoMove
ENDM

; =============== mMvIn_ValSuper ===============
; Guards against checking super move inputs if we can't start super moves.
; IN
; - 1: Label to skip the super move inputs
MACRO mMvIn_ValSuper
	; Can perform the move if at MAX power
	mMvC_ChkMaxPow .super_\@
	; Otherwise, the player must be at critical health
	ld   hl, iPlInfo_Health
	add  hl, bc
	ld   a, [hl]
	cp   PLAY_HEALTH_CRITICAL	; iPlInfo_Health >= $18?
	jp   nc, \1					; If so, skip
	
.super_\@:
ENDM

; =============== mMvIn_ValProjActive ===============
; Guards against starting moves that spawn projectiles if another
; projectile associated to the same player is still active.
; IN
; - 1: Char Key or Label to skip the input
MACRO mMvIn_ValProjActive
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	bit  PF0B_PROJ, [hl]	; Is a projectile active on-screen?
	IF DEF(MoveInputReader_\<1>_NoMove)
		jp   nz, MoveInputReader_\<1>_NoMove	; If so, skip
	ELSE
		jp   nz, \<1>							; If so, skip
	ENDC
ENDM

; =============== mMvIn_ValProjVisible ===============
; Guards against starting moves that spawn projectiles if another
; projectile associated to the same player is still *visible*.
; IN
; - 1: Char Key
MACRO mMvIn_ValProjVisible
	; Seek to the status field of the projectile associated to this player.
	; This is always 2 slots after the one for the current player.
	ld   hl, (OBJINFO_SIZE * 2)+iOBJInfo_Status
	add  hl, de	
	; If the sprite mapping is visible, don't start the move
	bit  OSTB_VISIBLE, [hl]	
	jp   nz, MoveInputReader_\<1>_NoMove
ENDM

; =============== mMvIn_ValClose ===============
; Verifies that the move is performed close to the opponent.
; IN
; - 1: Label to skip the input
; - 2: [OPTIONAL] Player distance threshold. By default, it's $18
MACRO mMvIn_ValClose
	; The move must be done within $18px of the other player
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
IF _NARG > 1
	cp   \2			; iPlInfo_PlDistance >= \2?
ELSE
	cp   $18		; iPlInfo_PlDistance >= $18?
ENDC
	jp   nc, \1		; If so, jump
	; If we got here, we can continue
ENDM

; =============== mMvIn_ValClose_jr ===============
; Verifies that the move is performed close to the opponent.
; IN
; - 1: Label to skip the input
; - 2: [OPTIONAL] Player distance threshold. By default, it's $18
MACRO mMvIn_ValClose_jr
	; The move must be done within $18px of the other player
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
IF _NARG > 1
	cp   \2			; iPlInfo_PlDistance >= \2?
ELSE
	cp   $18		; iPlInfo_PlDistance >= $18?
ENDC
	jr   nc, \1		; If so, jump
	; If we got here, we can continue
ENDM

; =============== mMvIn_ValSkipWithChar ===============
; Prevents the move input from being checked when playing as the specified character.
; Used to prevent characters from starting moves exclusive to their alternate form,
; since both forms reuse the same MoveInputReader_* code (ie: Iori/O.Iori)
; IN
; - 1: Character ID that can't use the move
; - 1: Label to skip the move inputs
MACRO mMvIn_ValSkipWithChar
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   \1		; Playing as this character?
	jp   z, \2	; If so, skip
ENDM

; =============== mMvIn_ValStartCmdThrow_StdColi ===============
; Verifies that the command throw grabbed the opponent successfully using standard throw range collision.
; This will take a few frames to complete.
; IN
; - 1: Char Key or Ptr to target if validation fails.
MACRO mMvIn_ValStartCmdThrow_StdColi
	; Throw validation / try to start it
	call MoveInputS_TryStartCommandThrow_StdColi	; Did the command throw grab the other player successfully?
	IF DEF(MoveInputReader_\<1>_NoMove)
		jp   nc, MoveInputReader_\<1>_NoMove		; If so, jump
	ELSE
		jp   nc, \<1>								; If so, jump
	ENDC
	call Task_PassControlFar
	ld   a, PLAY_THROWACT_NEXT03					; Otherwise, the command throw is confirmed
	ld   [wPlayPlThrowActId], a
ENDM

; =============== mMvIn_JpIfStartCmdThrow_StdColi ===============
; Jumps to the specified location if the command throw grabbed the opponent successfully using standard throw range collision.
; IN
; - 1: Ptr to target
MACRO mMvIn_JpIfStartCmdThrow_StdColi
	call MoveInputS_TryStartCommandThrow_StdColi	; Did we grab the opponent?
	jp   c, \1										; If so, jump
ENDM

; =============== mMvIn_ChkDir ===============
; Checks for a directional button-based move input.
; Almost every super move uses this.
; IN
; - 1: Ptr to MoveInput_*
; - 2: Ptr to MoveInit_* 
MACRO mMvIn_ChkDir
	ld   hl, \1					; HL = Ptr to move input
	call MoveInputS_ChkInputDir	; Did we press it?
	jp   c, \2					; If so, jump
ENDM

; =============== mMvIn_ChkDirStrict ===============
; Checks for a directional button-based move input that allows no input leeway.
; IN
; - 1: Ptr to MoveInput_*
; - 2: Ptr to MoveInit_* 
MACRO mMvIn_ChkDirStrict
	ld   hl, \1							; HL = Ptr to move input
	call MoveInputS_ChkInputDirStrict	; Did we press it?
	jp   c, \2							; If so, jump
ENDM

; =============== mMvIn_ChkBtnStrict ===============
; Checks for a punch/kick button-based move input that allows no input leeway.
; IN
; - 1: Ptr to MoveInput_*
; - 2: Ptr to MoveInit_* 
MACRO mMvIn_ChkBtnStrict
	ld   hl, \1							; HL = Ptr to move input
	call MoveInputS_ChkInputBtnStrict	; Did we press it?
	jp   c, \2							; If so, jump
ENDM

; =============== mMvIn_ChkBtnStrict ===============
; Checks if we did *NOT* input the specified directional button-based move input.
; IN
; - 1: Ptr to MoveInput_*
; - 2: Ptr to MoveInit_* 
MACRO mMvIn_ChkBtnStrictNot
	ld   hl, \1							; HL = Ptr to move input
	call MoveInputS_ChkInputBtnStrict	; Did we press it?
	jp   nc, \2							; If not, jump
ENDM

; =============== mMvIn_ChkLHK ===============
; Checks if the attack is a light or heavy kick.
; IN
; - 1: Ptr to code for the heavy version.
MACRO mMvIn_ChkLHK
	ld   hl, iPlInfo_JoyKeysLH
	add  hl, bc
	ld   a, [hl]			; Read Light/Heavy status
	bit  KEPB_A_HEAVY, a
	jr   nz, \1				; Heavy version? If so, jump
ENDM

; =============== mMvIn_ChkLHP ===============
; Checks if the attack is a light or heavy punch.
; IN
; - 1: Ptr to code for the heavy version.
MACRO mMvIn_ChkLHP
	ld   hl, iPlInfo_JoyKeysLH
	add  hl, bc
	ld   a, [hl]			; Read Light/Heavy status
	bit  KEPB_B_HEAVY, a
	jr   nz, \1				; Heavy version? If so, jump
ENDM

; =============== mMvIn_GetLHK ===============
; Gets a move ID depending on the attack being light or heavy kick.
; IN
; - 1: Move ID for Light
; - 2: Move ID for Heavy
; OUT
; - A: Move ID to use
MACRO mMvIn_GetLHK
	mMvIn_ChkLHK .heavy
.light:
	ld   a, \1
	jp   .setMove
.heavy:
	ld   a, \2
.setMove:
ENDM


; =============== mMvIn_GetLHP ===============
; Gets a move ID depending on the attack being light or heavy punch.
; IN
; - 1: Move ID for Light
; - 2: Move ID for Heavy
; OUT
; - A: Move ID to use
MACRO mMvIn_GetLHP
	mMvIn_ChkLHP .heavy
.light:
	ld   a, \1
	jp   .setMove
.heavy:
	ld   a, \2
.setMove:
ENDM

; =============== mMvC_SetMoveHAbs ===============
; Moves the player horizontally.
; IN
; - 1: Horizontal movement (pixels + subpixels)
MACRO mMvC_SetMoveHAbs
	ld   hl, \1
	call Play_OBJLstS_MoveH
ENDM

; =============== mMvC_SetMoveH ===============
; Moves the player horizontally, relative to the 1P side (negative values move backwards).
; IN
; - 1: Horizontal movement (pixels + subpixels)
MACRO mMvC_SetMoveH
	ld   hl, \1
	call Play_OBJLstS_MoveH_ByXFlipR
ENDM

; =============== mMvC_SetMoveV ===============
; Moves the player vertically.
; IN
; - 1: Vertical movement (pixels + subpixels)
MACRO mMvC_SetMoveV
	ld   hl, \1
	call Play_OBJLstS_MoveV
ENDM

; =============== mMvC_SetSpeedHAbs ===============
; Sets the horizontal movement speed for the current player, absolute.
; IN
; - 1: Speed value (pixels + subpixels), as px/frame
MACRO mMvC_SetSpeedHRaw
	ld   hl, \1
	call Play_OBJLstS_SetSpeedH
ENDM


; =============== mMvC_SetSpeedH ===============
; Sets the horizontal movement speed for (usually) the current player,
; relative to the 1P side (negative values move backwards).
; If something else was set to DE, that OBJInfo will get its speed set.
; IN
; - 1: Speed value (pixels + subpixels), as px/frame
MACRO mMvC_SetSpeedH
	ld   hl, \1
	call Play_OBJLstS_SetSpeedH_ByXFlipR
ENDM

; =============== mMvC_SetSpeedHInt ===============
; Sets the horizontal movement speed for (usually) the current player,
; relative to the internal flip flag being for the *2P* side (negative values move forwards).
; Used to move relative to the opponent's position, since the internal
; flip flag is always updated.
; IN
; - 1: Speed value (pixels + subpixels), as px/frame
MACRO mMvC_SetSpeedHInt
	ld   hl, \1
	call Play_OBJLstS_SetSpeedH_ByXDirL
ENDM

; =============== mMvC_SetSpeedV ===============
; Sets the vertical movement speed for (usually) the current player.
; If something else was set to DE, that OBJInfo will get its speed set.
; IN
; - 1: Player speed (pixels + subpixels), as px/frame
MACRO mMvC_SetSpeedV
	ld   hl, \1
	call Play_OBJLstS_SetSpeedV
ENDM

; =============== mMvC_SetAnimSpeed ===============
; Sets the animation speed.
; Generally done before the animation advances internally. 
; IN
; - 1: Animation speed
; - HL: Ptr to iOBJInfo_FrameLeft. Done automatically when calling mMvC_ValFrameEnd.
; OUT
; - HL: Ptr to iOBJInfo_FrameTotal
MACRO mMvC_SetAnimSpeed
	inc  hl			; Seek to iOBJInfo_FrameTotal
	ld   [hl], \1	; Set new anim speed
ENDM

; =============== mMvC_NextFrameOnGtYSpeed ===============
; Advances the animation if the YSpeed is > than the specified threshold.
; Used when manual control is enabled, so \2 is generally ANIMSPEED_NONE to continue the manual control.
; IN
; - 1: Y Speed threshold
; - 2: Animation speed for next frame
; OUT
; - C flag: If set, the request was successful.
MACRO mMvC_NextFrameOnGtYSpeed
	ld   a, \1
	ld   h, \2
	call OBJLstS_ReqAnimOnGtYSpeed
ENDM

; =============== mMvC_ValNextFrameOnGtYSpeed ===============
; Like mMvC_NextFrameOnGtYSpeed, and jumps to the specified label if we didn't advance the animation yet.
; IN
; - 1: Y Speed threshold
; - 2: Animation speed for next frame
; - 3: Target if we didn't animate.
MACRO mMvC_ValNextFrameOnGtYSpeed
	mMvC_NextFrameOnGtYSpeed \1, \2	; Did we switch to the next frame?
	jp   nc, \3						; If not, jump
ENDM

; =============== mMvC_SetLandFrame ===============
; Sets the animation frame used when landing on the ground (typically the last one).
; IN
; - 1: Sprite mapping ID
; - 2: Animation speed (iOBJInfo_FrameTotal)
; OUT
; - Z flag: If set, the new animation frame wasn't set
MACRO mMvC_SetLandFrame
	ld   a, \1*OBJLSTPTR_ENTRYSIZE
	ld   h, \2
	call Play_Pl_SetJumpLandAnimFrame
ENDM

; =============== mMvC_SetFrame ===============
; Sets a custom animation frame.
; Calling this also calls the animation routine, so the changes get applied.
; This means that, if the frame is set and the move code executes code depending
; on the visible frame, it's possible to skip calling the animation function for
; the rest of that frame.
; IN
; - 1: Sprite mapping ID
; - 2: Animation speed (iOBJInfo_FrameTotal)
; OUT
; - Z flag: If set, the new animation frame wasn't set
MACRO mMvC_SetFrame
	ld   a, \1*OBJLSTPTR_ENTRYSIZE
	ld   h, \2
	call Play_Pl_SetAnimFrame
ENDM

; =============== mMvC_StartChkFrame ===============
; Starts a list of mMvC_ChkFrame declarations. (Going off the internal/updated frame)
; OUT
; - HL: Ptr to iOBJInfo_OBJLstPtrTblOffset
; - A: Currently visible sprite mapping ID
MACRO mMvC_StartChkFrameInt
	ld   hl, iOBJInfo_OBJLstPtrTblOffset
	add  hl, de
	ld   a, [hl]
ENDM

; =============== mMvC_StartChkFrame ===============
; Starts a list of mMvC_ChkFrame declarations. (Going off the visible frame)
; OUT
; - HL: Ptr to iOBJInfo_OBJLstPtrTblOffsetView
; - A: Currently visible sprite mapping ID
MACRO mMvC_StartChkFrame
	ld   hl, iOBJInfo_OBJLstPtrTblOffsetView
	add  hl, de
	ld   a, [hl]
ENDM

; =============== mMvC_ChkFrame ===============
; Executes the specified code if the current sprite mapping ID matches what's specified.
; IN
; - 1: Sprite mapping ID
; - 2: Ptr to code for it.
; - A: Current sprite mapping ID
MACRO mMvC_ChkFrame
	cp   \1*OBJLSTPTR_ENTRYSIZE
	jp   z, \2
ENDM

; =============== mMvC_SetFrameOnEnd ===============
; A faster version of mMvC_SetFrame used inside mMvC_ValFrameEnd branches.
; IN
; - 1: Sprite mapping ID
MACRO mMvC_SetFrameOnEnd
	ld   hl, iOBJInfo_OBJLstPtrTblOffset
	add  hl, de
	; Offset by 1, because the animation routine will immediately increment it.
	ld   [hl], (\1 - 1)*OBJLSTPTR_ENTRYSIZE
ENDM

; =============== mMvC_SetDamageNext ===============
; Sets the pending move damage values, which get applied when the graphics for the next frame are loaded.
; These take effect on the opponent side if it gets successfully hit (not blocked).
; IN
; - 1: Damage dealt (iPlInfo_MoveDamageValNext)
; - 2: Hit effect (iPlInfo_MoveDamageHitTypeIdNext)
; - 3: Hit flags (iPlInfo_MoveDamageFlags3Next)
MACRO mMvC_SetDamageNext
	mkhl \1, \2
	ld   hl, CHL	
	ld   a, \3
	call Play_Pl_SetMoveDamageNext
ENDM

; =============== mMvC_SetDamage ===============
; Sets the current move damage values, which take effect immediately.
; Generally used the first time logic for an animation frame is executed, for consistency (OBJLstS_IsFrameNewLoad).
; These take effect on the opponent side if it gets successfully hit (not blocked).
; IN
; - 1: Damage dealt (iPlInfo_MoveDamageVal)
; - 2: Hit effect (iPlInfo_MoveDamageHitTypeId)
; - 3: Hit flags (iPlInfo_MoveDamageFlags3)
MACRO mMvC_SetDamage
	mkhl \1, \2
	ld   hl, CHL	
	ld   a, \3
	call Play_Pl_SetMoveDamage
ENDM

; =============== mMvC_PlaySound ===============
; Plays a sound effect.
; IN
; - 1: Sound ID
MACRO mMvC_PlaySound
	ld   a, \1
	call HomeCall_Sound_ReqPlayExId
ENDM

; =============== mMvC_ChkTarget ===============
; Executes the specified code when the target animation frame is reached.
; IN
; - 1: Ptr to where to jump
; - A: Current OBJLst ID (either internal or visible)
MACRO mMvC_ChkTarget
	ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
	add  hl, bc		; HL = Ptr to target OBJLst ID
	cp   a, [hl]	; Do they match?
	jp   z, \1		; If so, jump
ENDM

; =============== mMvC_ChkTarget_jr ===============
; Executes the specified code when the target animation frame is reached.
; IN
; - 1: Ptr to where to jump
; - A: Current OBJLst ID (either internal or visible)
MACRO mMvC_ChkTarget_jr
	ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
	add  hl, bc		; HL = Ptr to target OBJLst ID
	cp   a, [hl]	; Do they match?
	jr   z, \1		; If so, jump
ENDM

; =============== mMvC_ChkGravityV ===============
; Handles gravity, which increases the player speed.
; The player is moved only vertically until the ground is reached.
; IN
; - 1: Gravity value
; - 2: Where to jump if we *touched* ground
MACRO mMvC_ChkGravityV
	ld   hl, \1
	call OBJLstS_ApplyGravityVAndMoveV
	jp   c, \2
ENDM

; =============== mMvC_ChkGravityHV ===============
; Handles gravity, which increases the player speed.
; The player is moved both horizontally and vertically until the ground is reached.
; IN
; - 1: Gravity value
; - 2: Where to jump if we did *not* touch ground yet
MACRO mMvC_ChkGravityHV
	ld   hl, \1
	call OBJLstS_ApplyGravityVAndMoveHV
	jp   nc, \2
ENDM

; =============== mMvC_ChkFrictionH ===============
; Handles friction and moves the player horizontally until he stops.
; IN
; - 1: Friction value
; - 2: Where to jump if the player hasn't stopped moving yet.
MACRO mMvC_ChkFrictionH
	ld   hl, \1
	call OBJLstS_ApplyFrictionHAndMoveH
	jp   nc, \2
ENDM

; =============== mMvC_DoGravityV ===============
; Handles gravity and moves the OBJInfo vertically.
; IN
; - 1: Gravity value
MACRO mMvC_DoGravityV
	ld   hl, \1
	call OBJLstS_ApplyGravityVAndMoveV
ENDM

; =============== mMvC_DoGravityHV ===============
; Handles gravity and moves the OBJInfo horizontally and vertically.
; IN
; - 1: Gravity value
MACRO mMvC_DoGravityHV
	ld   hl, \1
	call OBJLstS_ApplyGravityVAndMoveHV
ENDM


; =============== mMvC_DoFrictionH ===============
; Handles friction and moves the player horizontally.
; IN
; - 1: Friction value
; OUT
; - C: If set, the h speed was 0 already
MACRO mMvC_DoFrictionH
	ld   hl, \1
	call OBJLstS_ApplyFrictionHAndMoveH
ENDM

; =============== mMvC_ChkMaxPow ===============
; Executes the specified code when the player is at max power.
; IN
; - 1: Where to jump if we're at max power
MACRO mMvC_ChkMaxPow
	ld   hl, iPlInfo_Pow
	add  hl, bc
	ld   a, [hl]		; A = Pow
	cp   PLAY_POW_MAX	; Pow == MAX?
	jp   z, \1			; If so, jump
ENDM

; =============== mMvC_ChkNotMaxPow ===============
; Executes the specified code when the player is *NOT* at max power.
; IN
; - 1: Where to jump if we're not at max power
MACRO mMvC_ChkNotMaxPow
	ld   hl, iPlInfo_Pow
	add  hl, bc
	ld   a, [hl]		; A = Pow
	cp   PLAY_POW_MAX	; Pow != MAX?
	jp   nz, \1			; If so, jump
ENDM

; =============== mMvC_ChkMove ===============
; Checks if the move ID matches the specified value.
; This is mostly used to determine if the move is a light or heavy.
; IN
; - 1: Move ID (for the heavy)
; - 2: Where to jump if it matches (for the heavy)
MACRO mMvC_ChkMove
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   \1
	jp   z, \2
ENDM

; =============== mMvC_ChkNotMove ===============
; Checks if the move ID does *NOT* match the specified value.
; IN
; - 1: Move ID (for the heavy)
; - 2: Where to jump if it does not match (the heavy)
MACRO mMvC_ChkNotMove
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   \1
	jp   nz, \2
ENDM

; =============== mMvC_ValHit ===============
; Executes code below only if the opponent got hit in the damage string.
; IN
; - 1: Ptr to code for not hitting yet
MACRO mMvC_ValHit
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]	; Did the opponent get hit yet?
	jp   z, \1				; If not, jump
ENDM

; =============== mMvC_ValNotInvuln ===============
; Executes code below only if the opponent is not invulnerable.
; IN
; - 1: Ptr to code when invulnerable
MACRO mMvC_ValNotInvuln
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]	; Is the opponent invulnerable?
	jp   nz, \1				; If so, jump
ENDM

; =============== mMvC_ValLoaded ===============
; Executes the code below only if the graphics for the first animation frame finished loading.
; This prevents problems when displaying frames from the previous move animation.
; IN
; - 1: Where to jump if validation fails
MACRO mMvC_ValLoaded
	call Play_Pl_IsMoveLoading
	jp   c, \1
ENDM

; =============== mMvC_ValFrameStart ===============
; Executes the code below only when the graphics for the frame have just finished loading
; (animation frame visible for the first time).
; When code for a move is executed depending on the visible frame, it's used to execute
; code once, only the first time we get there.
; IN
; - 1: Where to jump if validation fails
MACRO mMvC_ValFrameStart
	ld   hl, iOBJInfo_Status
	add  hl, de					; Seek to iOBJInfo_Status
	bit  OSTB_GFXNEWLOAD, [hl]	; Have the graphics for the frame just finished loading?
	jp   z, \1					; If not, jump
ENDM

; =============== mMvC_ValFrameStartFast ===============
; Wrapper.
; IN
; - 1: Where to jump if validation fails
MACRO mMvC_ValFrameStartFast
	mMvC_ValFrameStart \1
ENDM

; =============== mMvC_ValFrameNotStart ===============
; Opposite of mMvC_ValFrameStart.
; IN
; - 1: Where to jump if validation fails
MACRO mMvC_ValFrameNotStart
	call OBJLstS_IsFrameNewLoad
	jp   nz, \1
ENDM

; =============== mMvC_ValFrameEnd ===============
; Executes the code below only if the internal sprite mapping ID is about to change.
; For code to be executed once, near the end of the animation frame.
; IN
; - 1: Where to jump if validation fails
; OUT
; - HL: Ptr to iOBJInfo_FrameLeft
MACRO mMvC_ValFrameEnd
	call OBJLstS_IsInternalFrameAboutToEnd
	jp   nc, \1
ENDM

; =============== mMvC_ValEscape ===============
; Executes the code below only if the opponent escaped from a multi-hit special move.
; English version only.
; IN
; - 1: Where to jump if validation fails
MACRO mMvC_ValEscape
	call Play_Pl_IsMoveEscape
	jp   nc, \1
ENDM

; =============== mMvC_EndThrow ===============
; Ends a throw move.
MACRO mMvC_EndThrow
	call Play_Pl_EndMove
	xor  a ; PLAY_THROWACT_NONE
	ld   [wPlayPlThrowActId], a
ENDM

; =============== mMvC_EndThrow_Slow ===============
; Ends a throw move. Do not use.
MACRO mMvC_EndThrow_Slow
	call Play_Pl_EndMove
	ld   a, PLAY_THROWACT_NONE
	ld   [wPlayPlThrowActId], a
ENDM

; =============== Sound driver macros ===============
; For command IDs, their code will be specified in a comment.


; =============== snd_err ===============
; Placeholder for invalid or dummy commands. Do not use.
; Code: Sound_DecDataPtr
; IN
; - 1: Full command byte
MACRO snd_err
	db \1
ENDM

; =============== chan_stop ===============
; Stops channel playback.
; Code: Sound_Cmd_ChanStop
MACRO chan_stop
	db SNDCMD_BASE + $14
ENDM

; =============== envelope ===============
; Sets volume & envelope data to NRx2.
; Use for all channels except Wave, which lacks envelope functionality.
; Code: Sound_Cmd_WriteToNRx2
; IN:
; - 1: Raw NRx2 data
MACRO envelope
	db SNDCMD_BASE + $04, \1
ENDM

; =============== wave_vol ===============
; Sets the wave channel's volume to NR32.
; Code: Sound_Cmd_WriteToNRx2
; IN:
; - 1: Raw NR32 data, shifted left once and cycled.
;      This is to make the volume representation consistent with envelope command.
MACRO wave_vol
	db SNDCMD_BASE + $04, (((((\1 >> 6) ^ 3) + 1) & 3) << 5)
ENDM

; =============== snd_loop ===============
; Jumps to the specified target in the song data.
; It can loop for a specified amount of times, after which the loop is ignored and the song continues. 
; Code: Sound_Cmd_JpFromLoop / Sound_Cmd_JpFromLoopByTimer
; IN:
; - 1: Ptr to song data
; - 2: [Optional] Timer ID (should be unique as to not overwrite other loops)
; - 3: [Optional] Times to loop (Initial timer value)
MACRO snd_loop
	IF _NARG > 1
		; Conditional
		db SNDCMD_BASE + $07
		db \2, \3
		dw \1
	ELSE
		; Always
		db SNDCMD_BASE + $05
		dw \1
	ENDC
ENDM

; =============== fine_tune ===============
; Adjusts the pitch offset for the track.
; Note IDs will be shifted by this amount relative to the current offset.
; Code: Sound_Cmd_AddToBaseFreqId
; IN:
; - 1: Tune offsets
MACRO fine_tune
	db SNDCMD_BASE + $06, \1
ENDM

; =============== sweep ===============
; Sets Pulse 1 sweep settings.
; Code: Sound_Cmd_WriteToNR10
; IN:
; - 1: Raw NR10 data
MACRO sweep
	db SNDCMD_BASE + $08, \1
ENDM

; =============== panning ===============
; Sets the channel's stereo panning.
; Code: Sound_Cmd_SetPanning
; IN:
; - 1: NR51 bits. 
;      Only the bits for the current channel should be set.
MACRO panning
	db SNDCMD_BASE + $09, \1
ENDM

; =============== snd_call ===============
; Like calling a subroutine, but for the sound data ptr.
; Code: Sound_Cmd_Call
; IN:
; - 1: Ptr to song data
MACRO snd_call
	db SNDCMD_BASE + $0C
	dw \1
ENDM

; =============== snd_ret ===============
; Like returning from a subroutine, but for the sound data ptr.
; Code: Sound_Cmd_Ret
MACRO snd_ret
	db SNDCMD_BASE + $0D
ENDM

; =============== duty_cycle ===============
; Writes data to NRx1. Pulse channels only.
; Code: Sound_Cmd_WriteToNRx1
; IN:
; - 1: Wave pattern duty
; - 2: [Optional] Sound length
MACRO duty_cycle
	ASSERT \1 <= %11, "Pat duty too high"
	IF _NARG > 1
		ASSERT \2 <= %111111, "Sound length too high"
		DEF CLEN = \2
	ELSE
		DEF CLEN = 0
	ENDC
	db SNDCMD_BASE + $0E
	db (\1 << 6)|CLEN
ENDM

; =============== lock_envelope ===============
; Prevents the channel's envelope from being updated.
; Code: Sound_Cmd_LockNRx2
MACRO lock_envelope
	db SNDCMD_BASE + $0F
ENDM

; =============== unlock_envelope ===============
; Enables writes to the channel's envelope.
; Code: Sound_Cmd_UnlockNRx2
MACRO unlock_envelope
	db SNDCMD_BASE + $10
ENDM

; =============== vibrato_on ===============
; Enables vibrato.
; Code: Sound_Cmd_SetVibrato
MACRO vibrato_on
	db SNDCMD_BASE + $11
ENDM

; =============== vibrato_off ===============
; Disables vibrato.
; Code: Sound_Cmd_ClrVibrato
MACRO vibrato_off
	db SNDCMD_BASE + $12
ENDM

; =============== wave_id ===============
; Writes a new set of wave data.
; Code: Sound_Cmd_SetWaveData
; IN:
; - 1: Wave set ID
MACRO wave_id
	db SNDCMD_BASE + $13, \1
ENDM

; =============== wave_cutoff ===============
; Writes data to NR31 and immediately applies it to the register.
; Code: Sound_Cmd_WriteToNR31
; IN:
; - 1: Channel length timer
MACRO wave_cutoff
	db SNDCMD_BASE + $15, \1
ENDM

; =============== speed ===============
; Sets a new song speed.
; Code: Sound_Cmd_SetSpeed
; IN:
; - 1: Song speed
MACRO speed
	db SNDCMD_BASE + $16
	dw \1
ENDM

; =============== continue ===============
; Extends the current note without restarting it.
; Useful at the start of a subroutine.
; Code: Sound_Cmd_ExtendNote
; IN:
; - 1: Length value
MACRO continue
	db SNDCMD_BASE + $1A
	db \1
ENDM

; =============== pitch_slide ===============
; Starts a pitch slide.
; Code: Sound_Cmd_Unused_StartSlide
; IN:
; - 1: Note (C_ to B)
; - 2: Octave (2-8)
; - 3: Length value
MACRO pitch_slide
	_mknote \#
	db SNDCMD_BASE + $1C
	db \3, DNOTE
ENDM

; =============== wait ===============
; Extends the current note's length.
; Usually bundled together with note & note4 to set the new note's length.
; Code: N/A
; IN:
; - 1: Length ($00-$7F)
MACRO wait
	db \1
ENDM

; =============== note4 ===============
; Sets a note in SPN format. Channel 4 only.
; Code: N/A
; IN:
; - 1: Note (C_ to B)
; - 2: Octave (2-6)
; - 3: Step width (0: 15-bit LFSR, 1: 7-bit LFSR)
; - 4: New Length [Optional]
MACRO note4
	; Convert the SPN to respective values in the tbm noise frequency table
	DEF HI_P1 = (6 - \2) * 3
	DEF NOTE_INV = 11 - \1
	IF (\2 == 6 && NOTE_INV < 4)
		DEF DNOTE = (NOTE_INV & 3)
	ELSE
		DEF LOW_SUB = (NOTE_INV % 4) + 4
		DEF LOW_BASE = NOTE_INV / 4
		DEF DNOTE = ((HI_P1 + 1) << 4) + LOW_SUB - ($20 - (LOW_BASE * $10))
	ENDC
	
	db DNOTE|(\3 << 3)
	IF _NARG > 3
		db \4
	ENDC
ENDM

; =============== note4x ===============
; Sets a custom note unrepresentable with tbm.
; Code: N/A
; IN:
; - 1: NR43 data
; - 2: New Length [Optional]
MACRO note4x
	db \1
	IF _NARG > 1
		db \2
	ENDC
ENDM

; =============== note4p ===============
; Sets a note preset, for BGM Noise channels only
; Code: N/A
; IN:
; - 1: Preset ID
; - 2: New Length [Optional]
MACRO note4p
	db $80 + \1
	IF _NARG > 1
		db \2
	ENDC
ENDM

; =============== note ===============
; Sets a note in SPN format. Channels 1-2-3 only.
; Code: N/A
; IN:
; - 1: Note (C_ to B)
; - 2: Octave (2-8)
; - 3: New Length [Optional]
MACRO note
	_mknote \#
	db SNDNOTE_BASE + DNOTE
	IF _NARG > 2
		db \3
	ENDC
ENDM

; =============== silence ===============
; Sets a no-frequency note.
; Code: N/A
; IN:
; - 1: New Length [Optional]
MACRO silence
	db SNDNOTE_BASE
	IF _NARG > 0
		db \1
	ENDC
ENDM

; =============== dnote ===============
; Formats a raw note ID.
; IN:
; - 1: Note (C_ to B)
; - 2: Octave (2-8)
MACRO dnote
	IF _NARG > 1
		_mknote \#
		db DNOTE
	ELSE
		db 0
	ENDC
ENDM

; =============== _mknote ===============
; Formats a raw note ID.
; IN:
; - 1: Note (C_ to B)
; - 2: Octave (2-8)
; OUT
; - DNOTE: Result
MACRO _mknote
	ASSERT \1 >= C_, "Note too low"
	ASSERT \1 <= B_, "Note too high"

	ASSERT \2 >= 0, "Octave too low"
	ASSERT \2 <= 8, "Octave too high"
	DEF DNOTE = (12*(\2-2)) + \1
	; Offset by 1 for positive ones, as $00 is no frequency.
	IF DNOTE >= 0
		DEF DNOTE = DNOTE + 1
	ENDC
ENDM