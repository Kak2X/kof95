; =============== MoveC_Base_None ===============
; Used to delete the KO'd player task when a round ends.
; Set whenever a move ends, but we only get here when basic input is disabled after getting KO'd.
MoveC_Base_None:
	
	; This move waits until iPlInfo_IntroMoveId is set to something.
	; - If it's a real move ID it just ends the move (this never happens)
	; - If it's the special value MOVE_TASK_REMOVE, it kills the current player task.
	;   This is done by Play_SetWinLoseMoves / Play_SetDrawMoves
	
	ld   hl, iPlInfo_IntroMoveId
	add  hl, bc
	ld   a, [hl]
	
	; Wait until the intro/outro move is set
	or   a				; Intro/outro move set?
	jr   z, .ret		; If not, return
	
	; If it's set to MOVE_TASK_REMOVE, delete the task
	cp   MOVE_TASK_REMOVE
	jr   nz, .unused_end
	call Task_RemoveCurAndPassControl
	
.unused_end: ; We never get here
	call Play_Pl_EndMove
.ret:
	ret
	
; =============== MoveC_Base_Idle ===============
; Simple move code handler that doesn't allow box overlapping.
MoveC_Base_Idle:
	call Play_Pl_MoveByColiBoxOverlapX
	
	;
	; Weird thing this game does.
	; If too close to the opponent, stay at the first frame and don't animate.
	;
	mMvIn_ValClose_jr .anim, $14			; Distance >= $14? If so, always animate
		; Only animate until we get back to frame #0.
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de
		ld   a, [hl]
		cp   $00*OBJLSTPTR_ENTRYSIZE		; On frame #0?
		jr   z, .ret						; If so, return without animating
	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  

; =============== MoveC_Base_WalkH ===============
; Like MoveC_Base_Idle, but allowing horizontal movement.
; Used for walking horizontally.
MoveC_Base_WalkH:
	call Play_Pl_MoveByColiBoxOverlapX
	call OBJLstS_ApplyXSpeed
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
	
; =============== MoveC_Base_NoAnim ===============
; Like MoveC_Base_Idle, but without animating the player.
; Used when crouching or blocking, which don't animate the player.
MoveC_Base_NoAnim:
	call Play_Pl_MoveByColiBoxOverlapX
	ret
	
; =============== MoveC_Base_ChargeMeter ===============
; Custom code for charging meter (MOVE_BASE_CHARGEMETER).
MoveC_Base_ChargeMeter:
	call Play_Pl_MoveByColiBoxOverlapX	; Prevent box overlap
	mMvC_ValLoaded .ret						; If so, return
.main:

	;
	; Force the player to charge until visibly reaching the target animation frame.
	;
	ld   hl, iOBJInfo_OBJLstPtrTblOffsetView
	add  hl, de
	ld   a, [hl]			; A = Sprite mapping ID
	mMvC_ChkTarget .chkEnd ; Did we reach the target ID? ; If so, jump
	; Otherwise, wait and continue animating
	jp   .anim
	
.chkEnd:

	;
	; Check if the charge is ending.
	;
	
	; Syncronize to end of anim frame
	mMvC_ValFrameEnd .anim
	
	; If we reached Max Power, we can't charge anymore.
	ld   hl, iPlInfo_MaxPow
	add  hl, bc
	ld   a, [hl]
	or   a				; iPlInfo_MaxPow != 0?
	jp   nz, .end		; If so, jump
	
	; After the charge starts, only holding A+B is needed to continue it.
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ld   a, [hl]
	and  a, KEY_A|KEY_B	; Holding A+B?
	cp   KEY_A|KEY_B	
	jp   z, .anim		; If not, jump
.end:
	; If we got here, the charge is over
	call Play_Pl_EndMove
	jp   .ret
.anim:
	; Continue animating it, which means the anim can restart
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== Play_Pl_MoveByColiBoxOverlapX ===============
; Custom code for the dodge (MOVE_BASE_DODGE).
MoveC_Base_Dodge:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret

; --------------- main ---------------		
	;
	; Pressing A or B during the move triggers a counterattack.
	; Otherwise, the move will just wait for the frame to end.
	;

	; The CPU will never do it
	ld   hl, iPlInfo_Flags0
	add  hl, bc						; Seek to iPlInfo_Flags0
	bit  PF0B_CPU, [hl]				; Is this player a CPU?
	jp   nz, .chkAnim				; If so, skip
	
	; Handle the keypress
	call Play_Pl_AddToJoyBufKeysLH	; Did we just press A or B?
	jp   nc, .chkAnim				; If not, skip
	
	; If pressed, end the move early by resetting the frame counter.
	; This will allow the mMvC_ValFrameEnd below to proceed.
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], $00 ; iOBJInfo_FrameLeft = 0
	inc  hl
	ld   [hl], $00 ; iOBJInfo_FrameTotal = 0
	
.chkAnim:
	; Wait for the animation to end.
	; In this case it's not necessary since dodges are all 1-frame animations
	ld   hl, iOBJInfo_OBJLstPtrTblOffsetView
	add  hl, de
	ld   a, [hl]
	mMvC_ChkTarget .chkEnd
	jp   .anim ; We never get here
	
; --------------- end ---------------
.chkEnd:
	;
	; If we pressed A or B before, start the counterattack.
	;
	mMvC_ValFrameEnd .anim
	
		; The CPU will never do it
		ld   hl, iPlInfo_Flags0
		add  hl, bc						; Seek to iPlInfo_Flags0
		bit  PF0B_CPU, [hl]				; Is this player a CPU?
		jp   nz, .end					; If so, skip
		
		; Must have pressed A or B
		ld   hl, iPlInfo_JoyBufKeysLH
		add  hl, bc
		ld   a, [hl]
		and  a, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY
		jp   z, .end
		
		; End of the dodge = End of invulnerability
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		res  PF1B_INVULN, [hl]			
		inc  hl ; Seek to iPlInfo_Flags1
		res  PF2B_NOHURTBOX, [hl]
		res  PF2B_NOCOLIBOX, [hl]
		
		; New move
		ld   a, MOVE_SHARED_DODGE_COUNTER
		call Pl_SetMove_StopSpeed
		mMvC_PlaySound SFX_HEAVY
		jp   .ret
	
; --------------- common ---------------		
.end:
	call Play_Pl_EndMove
	jp   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveC_Base_Hop ===============
; Custom code for hopping (MOVE_SHARED_HOP_F, MOVE_SHARED_HOP_B).
MoveC_Base_Hop:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .initJump
		mMvC_ChkFrame $01, .moveDown
		mMvC_ChkFrame $02, .chkEnd
	jp   .moveDown ; We never get here
	
; [TCRF] Unreferenced code to enable manual control.
;        Not needed, since the move animation for the dash already has that set.
.unused_setManualCtrl:
	ld   hl, iOBJInfo_FrameTotal
	add  hl, de
	ld   [hl], ANIMSPEED_NONE
	jp   .anim
	
;
; In practice:
; - The first time we get here, we initialize the jump speed
; - The second we request a switch to the next frame
; - From the third we do the same thing, waiting until the graphics are loaded.
;   Once they are, the second frame is set to skip directly to the gravity code.
;
; Gravity is always applied every time.
;
; --------------- frame #0 ---------------
.initJump:
	; Initialize the jump speed the first time we get here.
	; From the next, only perform the check to switch to the next frame.
	mMvC_ValFrameStartFast .waitUp
		; [POI] Pointless, it's not possible to hop during hitstop.
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF2B_NODAMAGERATE, [hl]
		
		; Which direction are we going?
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_SHARED_HOP_B			; Doing a backwards hop?
		jr   z, .initJumpB				; If so, jump (negative SpeedH)
	.initJumpF: 
		; Forward hop
		; Set jump right 4px/frame
		mMvC_SetSpeedH +$0400
		; Set jump up 3px/frame 
		mMvC_SetSpeedV -$0300
		jr   .initJumpMoveDown
	.initJumpB:
		; Backwards hop
		; Set jump left 3px/frame
		mMvC_SetSpeedH -$0300				
		; Set jump up 3px/frame 
		mMvC_SetSpeedV -$0300
	.initJumpMoveDown:
		jp   .moveDown
.waitUp:
	mMvC_NextFrameOnGtYSpeed -$03, ANIMSPEED_NONE
	; Apply gravity
	jp   .moveDown
; --------------- common frames #0-1 ---------------
.moveDown:
	; Move down 0.6px/frame
	mMvC_ChkGravityHV $0060, .anim				; If not, jump
		; Otherwise, request the next frame to load as soon as possible
		mMvC_SetLandFrame $02, ANIMSPEED_INSTANT
		jp   .ret
; --------------- frame #2 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_Dash ===============
; Custom code for dashing, only used by Iori's forward dash (MOVE_SHARED_HOP_F).
MoveC_Base_Dash:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $08
		jp   .anim
; --------------- frame #1 ---------------
; Dash forwards at 4px/frame.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetSpeedH +$0400
		jp   .moveH
.obj1_cont:
	mMvC_ValFrameEnd .moveH
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .moveH
; --------------- common movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #2 ---------------
; Slow down 0.5px every frame, until we stop moving.
.chkEnd:
	mMvC_ChkFrictionH $0080, .ret
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_NormA ===============
; Custom code for most air normals. Most characters use this for air punches, air kicks and air A+Bs.
MoveC_Base_NormA:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .move
	
	;
	; Moves using this have a timing sequence where the first frames have different anim speed values.
	; The game then stays on frame #3 until landing on the ground, where it will jump to the landing frame (#4).
	;
	; Since the first frames also execute code for #3, if the player lands on the ground even before
	; reaching frame #3, it will skip directly to #4.
	;
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
	jp   .move
	
; Update speed for every frame
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .move
		;
		; Depending on the normal being a light / heavy, pick a different anim speed.
		;
		
		mMvC_SetAnimSpeed $20 ; Speed for light attacks (slow)
		
		; Determine light/heavy by checking all possible move IDs
		push hl
			ld   hl, iPlInfo_MoveId
			add  hl, bc
			ld   a, [hl]				; Did we do a...
			cp   MOVE_SHARED_PUNCH_ALI	; ...neutral air light punch?
			jp   z, .obj0_initL
			cp   MOVE_SHARED_KICK_ALI	; ...neutral air light kick?
			jp   z, .obj0_initL
			cp   MOVE_SHARED_PUNCH_ALX	; ...non-neutral air light punch?
			jp   z, .obj0_initL
			cp   MOVE_SHARED_KICK_ALX	; ...non-neutral air light kick?
			jp   z, .obj0_initL
			; If we didn't not do any of those, we did a heavy.
		pop  hl
	.obj0_initH:
		; Speed up the animation by 2x
		ld   [hl], $10		; mMvC_SetAnimSpeed $10
		mMvC_PlaySound SFX_HEAVY
		jp   .move
	.obj0_initL:
		pop  hl
		mMvC_PlaySound SFX_HEAVY ; Same as the other one
		jp   .move
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .move
		mMvC_SetAnimSpeed $03
		jp   .move
; --------------- frame #2 ---------------
; Manual control for #3, as it ends only when touching the ground
.obj2:
	mMvC_ValFrameEnd .move
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .move
; --------------- common frames #0-3 ---------------
.move:
	; Gradually decrease the vertical speed originally set by the jump move
	mMvC_ChkGravityHV $0060, .anim						; If not, jump
		; Switch to #4 and stay there for the least possible time
		mMvC_SetLandFrame $04, ANIMSPEED_INSTANT
		jp   .ret
; --------------- frame #4 ---------------
; Wait for the animation to advance before ending the move.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveC_Base_NormL ===============
; Generic move code used for most light normals.
MoveC_Base_NormL:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	;
	; If we're pressing/holding a new attack key, speed up
	; the rest of the animation as much as possible.
	; This is to allow "interrupting" the light attack with something else (another normal, or special).
	;
	; Something similar also happens in .obj1, except it
	; also makes the animation immediately jump to its last frame.
	;
	call Play_Pl_AddToJoyBufKeysLH	; Pressed any new LH button?
	jp   nc, .chkAnim				; If not, skip
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], $00
	mMvC_SetAnimSpeed ANIMSPEED_INSTANT
	
.chkAnim:
	;--
	; [POI] We already checked this
	mMvC_ValLoaded .ret
	;--
	
	; Depending on the visible sprite...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
; --------------- frames #2-(end) ---------------
.obj2x:
	mMvC_ChkTarget_jr .chkEnd
		jr   .anim
; --------------- frame #0 ---------------
; Play a SGB/DMG SFX when switching to #1.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_LIGHT
		jp   .anim
; --------------- frame #1 ---------------
; When switching to frame #2, check if we're pressing any punch/kick button.
; If so, make the animation immediately jump to its last frame.
.obj1:

	; If not switching yet, continue
	mMvC_ValFrameEnd .anim
	
		; If we aren't pressing a punch/kick button, continue
		ld   hl, iPlInfo_JoyBufKeysLH
		add  hl, bc
		ld   a, [hl]
		and  a, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY
		jr   z, .anim
			
		; Speed up the rest of the anim as much as possible
		; and make the next frame start immediately.
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		
		; iOBJInfo_OBJLstPtrTblOffset = iPlInfo_OBJLstPtrTblOffsetMoveEnd - 4.
		; Because iOBJInfo_FrameLeft was just set to $00, the animation function
		; will advance iOBJInfo_OBJLstPtrTblOffset by 4, making it reach the target sprite.
		; Of course the graphics still have to load for .chkEnd to be reached.
		ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
		add  hl, bc
		ld   a, [hl]						; A = iPlInfo_OBJLstPtrTblOffsetMoveEnd - 4
		sub  a, $01*OBJLSTPTR_ENTRYSIZE
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de							
		ld   [hl], a						; iOBJInfo_OBJLstPtrTblOffset = A
		jr   .anim
; --------------- common ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_NormH ===============
; Generic move code used for most heavy normals & taunting.
; Like MoveC_Base_Idle, except it ends the move (early) when the target frame is reached.
MoveC_Base_NormH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Only check when the frame is about to switch, before the
	; graphics for the next one start loading.
	mMvC_ValFrameEnd .anim
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de			
		ld   a, [hl]							; A = Internal frame ID
		ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
		add  hl, bc								; HP = Ptr to target frame ID
		cp   a, [hl]							; Do they match?
		jr   nz, .anim							; If not, jump
		; Otherwise, we're done
		call Play_Pl_EndMove
		jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_RoundStart ===============
; Custom code for moves used when the round starts (MOVE_SHARED_INTRO).
MoveC_Base_RoundStart:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible sprite...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .initAnimSpeed
	
; --------------- frames #1-(end) ---------------	
	; Check if we can end the move when the target ID is reached
	mMvC_ChkTarget .chkEnd
		jp   .anim		; Otherwise, just animate normally
	
; --------------- frame #0 ---------------
.initAnimSpeed:
	; Set the animation speed when about to switch to frame #1
	mMvC_ValFrameEnd .anim
	
		; Athena uses speed $02 from the second frame, while Rugal $03.
		; Everyone else keeps their existing speed settings.
		ld   hl, iPlInfo_CharId
		add  hl, bc
		ld   a, [hl]
		cp   CHAR_ID_ATHENA
		jp   z, .spdFast
		cp   CHAR_ID_RUGAL
		jp   z, .spdSlow
		jp   .anim
	.spdFast:
		ld   a, $02		; A = Anim speed
		jp   .setSpeed
	.spdSlow:
		ld   a, $03		; A = Anim speed
	.setSpeed:
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de
		ld   [hl], a	; Save it
		jp   .anim
; --------------- end ---------------	
.chkEnd:
	; End the move when the animation advances
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------	
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_WakeUp ===============
; Custom code for waking up (MOVE_SHARED_WAKEUP).
MoveC_Base_WakeUp:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .end
	mMvC_ValFrameEnd .anim
	
		; When the move ends, perform the end-of-wakeup logic (ie: dizzy checks)
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de
		ld   a, [hl]	; A = Cur Frame
		ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
		add  hl, bc		; Seek to last frame
		cp   a, [hl]	; Is this the last frame?
		jr   nz, .anim	; If not, jump
	
		call MoveC_Base_WakeUp_End
		jp   .end
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.end:
	ret  
	
; =============== MoveC_Base_Dizzy ===============
; Custom code for the dizzy state (MOVE_SHARED_DIZZY).
MoveC_Base_Dizzy:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Decrement the dizzy countdown
	call Play_Pl_DecDizzyTime
	
	; End the move when the dizzy countdown timer elapses
	ld   hl, iPlInfo_DizzyTimeLeft
	add  hl, bc
	ld   a, [hl]
	or   a			; iPlInfo_DizzyTimeLeft == 0?
	jp   z, .end	; If so, jump

	; Play a SFX every time the animation internally switches to the next frame
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_DIZZY
		jp   .anim
.end:
	call Play_Pl_EndMove
	jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_RoundEnd ===============
; Custom code for moves used when the round ends (MOVE_SHARED_WIN_A, MOVE_SHARED_WIN_B, MOVE_SHARED_LOST_TIMEOVER).
MoveC_Base_RoundEnd:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Ignore if not switching frames
	mMvC_ValFrameEnd .anim
	
	; Continue animating until we reach the target frame
	ld   hl, iOBJInfo_OBJLstPtrTblOffset
	add  hl, de
	ld   a, [hl]
	ld   hl, iPlInfo_OBJLstPtrTblOffsetMoveEnd
	add  hl, bc
	cp   a, [hl]
	jr   nz, .anim
	
	;
	; Terry's win animation involves him throwing his hat.
	; Spawn the hat before killing the player task, if appropriate.
	;
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_WIN		; In the win anim?
	jr   nz, .killTask			; If not, return
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_TERRY			; Playing as Terry?
	jr   nz, .killTask			; If not, jump
	
	call Play_SpawnTerryHat		; All OK, spawn the hat
.killTask:
	; End the move as normal, and kill its task.
	; This prevents the player from animating any further.
	call Play_Pl_EndMove
	call Task_RemoveCurAndPassControl
	jr   .ret ; We never get here, since the player task got destroyed
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== Play_SpawnTerryHat ===============
; Spawns Terry's hat for his second win animation.
; IN
; - DE: Ptr to the player wOBJInfo
Play_SpawnTerryHat:
	push bc
		push de
		
			; The hat is spawned relative to the player's location through (what eventually became) OBJLstS_Overlap.
			; That subroutine wants the source (player wOBJInfo) to BC.
			push de
			pop  bc
			
			; DE = Ptr to the Terry Hat object.
			; This is loaded into the player's projectile slot.
			ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
			add  hl, bc		; Seek 2 slots ahead
			push hl
			pop  de			; Move to DE
			
			; Display the sprite
			ld   [hl], OST_VISIBLE
			
			; Use $80 as fixed tile ID base.
			; The hat tiles use IDs $84-$87 (represented as $04 & $06) in the sprite mapping.
			ld   hl, iOBJInfo_TileIDBase
			add  hl, de
			ld   [hl], $80
			
			; Set the code ptr for handling its animation
			ld   hl, iOBJInfo_Play_CodeBank
			add  hl, de	; Seek to iOBJInfo_Play_CodeBank
			ld   [hl], BANK(ExOBJ_TerryHat) ; BANK $02
			inc  hl	; Seek to iOBJInfo_Play_CodePtr_Low
			ld   [hl], LOW(ExOBJ_TerryHat)
			inc  hl	; Seek to iOBJInfo_Play_CodePtr_Low
			ld   [hl], HIGH(ExOBJ_TerryHat)
			
			; Set animation table
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_TerryHat) ; BANK $01
			inc  hl	; Seek to iOBJInfo_OBJLstPtrTbl_Low
			ld   [hl], LOW(OBJLstPtrTable_TerryHat)
			inc  hl	; Seek to iOBJInfo_OBJLstPtrTbl_High
			ld   [hl], HIGH(OBJLstPtrTable_TerryHat)
			inc  hl	; Seek to iOBJInfo_OBJLstPtrTblOffset
			ld   [hl], $00	; Start from first sprite
			
			; Animate every 8 frames
			ld   hl, iOBJInfo_FrameLeft
			add  hl, de
			ld   [hl], $08
			inc  hl	; Seek to iOBJInfo_FrameTotal
			ld   [hl], $08
			
			; Set the hat's position relative to the player:
			; - $10px back
			; - $30px above
			
			; =============== OBJLstS_Overlap ===============
			; Moves an wBJInfo to exactly overlap another one.
			; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
			;
			; Extracted to OBJLstS_Overlap in 96.
			;
			; IN
			; - DE: Ptr to the wOBJInfo structure to be moved
			; - BC: Ptr to target wOBJInfo structure (the "other" one)
			push bc
				;
				; Set up source and destination pointers
				;

				; BC = Ptr to source iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, bc			; HL = BC + iOBJInfo_X
				push hl
				pop  bc				; Move back to BC

				; DE = Ptr to destination iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, de			; HL = DE + iOBJInfo_X

				;
				; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
				;
		REPT 4
				ld   a, [bc]	; A = Source byte
				inc  bc			; SrcPtr++
				ldi  [hl], a	; Write to dest; DestPtr++
		ENDR
			pop  bc

			;
			; Copy over the byte with sprite mapping flags
			;

			; A = Source iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, bc
			ld   a, [hl]
			; HL = Ptr to dest iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			; Write it over
			ld   [hl], a
			; ==============================

			mMvC_SetMoveH -$1000		; Move $10px backwards
			mMvC_SetMoveV -$3000		; Move $30px up
			
			; Set throw speed arc:
			; - 1px/frame backwards
			; - 3px/frame up
			mMvC_SetSpeedH -$0100
			mMvC_SetSpeedV -$0300
		pop  de
	pop  bc
	ret
	
; =============== ExOBJ_TerryHat ===============
; Animation code for Terry's hat.
; IN
; - DE: Ptr to wOBJInfo_TerryHat
ExOBJ_TerryHat:
	; Move horizontally
	call ExOBJS_Play_ChkHitModeAndMoveH
	; Move vertically
	mMvC_ChkGravityV $0030, .onFloor					; If so, jump
	; Continue spinning in the air
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret
.onFloor:
	; Stop movement and animation on the ground
	mMvC_SetSpeedH $0000
	ret
	
; =============== MoveC_Kyo_ThrowG ===============
; Move code for Kyo's ground throw. (MOVE_SHARED_THROW_G).
;
; Throws are character-specific and follow a similar template.
;
; These are only executed when the throw is *confirmed*, with wPlayPlThrowActId
; being initially set to PLAY_THROWACT_NEXT03 as done by BasicInput_StartGroundThrow.
;
; As the opponent is "stuck" in the grab mode waiting to get hit, it's important
; to deal damage to him at some point before he gets automatically unstuck (ANIMSPEED_NONE isn't infinite).
; Hits caused by throws should deal more damage and cause the opponent to drop to the ground.
MoveC_Kyo_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $05, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_FG_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
; When visually switching to #3, hit the opponent.
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #5 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		; And when it does, also reset the throw sequence
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_KickFH ===============
; Move code for Kyo's Far Heavy Kick (MOVE_SHARED_KICK_FH).
MoveC_Kyo_KickFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim
; --------------- frame #2 ---------------
; Move player 6px forwards, set damage at the end.
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_SetMoveH +$0600
.obj2_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID1, PF3_OVERHEAD|PF3_HEAVYHIT
		jp   .anim
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_KickFCH ===============
; Move code for Kyo's Crouching Far Heavy Kick (MOVE_SHARED_KICK_FCH).
MoveC_Kyo_KickFCH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $06, .chkEnd
	jp   MoveC_Kyo_KickFH.anim ; Copypaste error
; --------------- frame #2 ---------------
; Deal damage at the end of the frame.
; The crouching kick knocks down the opponent as usual.
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW
		mMvC_PlaySound SCT_MOVEJUMP_A
		jp   .anim
; --------------- frame #6 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_KickFCH ===============
; Move code for Kyo's Strike Attack (MOVE_SHARED_STRIKE).
MoveC_Kyo_Strike:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim ; We never get here
	
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		; Manual control for the next frame
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #2 ---------------
; Handles the forwards movement and end of move check.
.obj2:
	; The first time we get here, play a SFX and set the initial 4px/frame forwards speed.
	mMvC_ValFrameStartFast .chkEnd
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_SetSpeedH +$0400
		jp   .anim
.chkEnd:
	; Slow down at 0.25px/frame. End the move when we stop moving.
	mMvC_ChkFrictionH $0040, .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Kyo ===============
; Special move input checker for KYO.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Kyo:
	mMvIn_Validate Kyo, 0 ; NO AIR SPECIALS

; GROUND SPECIALS
.chkGround:
	;             SELECT + B                  SELECT + A
	mMvIn_ChkEasy MoveInit_Kyo_UraOrochiNagi, MoveInit_Kyo_OniYaki
	mMvIn_ChkGA Kyo, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DBDF+P -> Ura 108 Shiki Orochi Nagi
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Kyo_UraOrochiNagi
.chkPunchNoSuper:
	; FDF+P -> 100 Shiki Oni Yaki
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Kyo_OniYaki
	; DF+P -> 108 Shiki Yami Barai
	mMvIn_ChkDir MoveInput_DF, MoveInit_Kyo_YamiBarai
	; End
	jp   MoveInputReader_Kyo_NoMove
.chkKick:
	; FDB+K -> 212 Shiki Kototsuki You 
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Kyo_KototsukiYou
	; BDB+K -> 101 Shiki Oboro Guruma
	mMvIn_ChkDir MoveInput_BDB, MoveInit_Kyo_OboroGuruma
	; DF+K -> 75 Shiki Kai
	mMvIn_ChkDir MoveInput_DF, MoveInit_Kyo_Kai
	; End
	jp   MoveInputReader_Kyo_NoMove
	
; =============== MoveInit_Kyo_YamiBarai ===============
MoveInit_Kyo_YamiBarai:
	mMvIn_ValProjActive MoveInputReader_Kyo_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_KYO_YAMI_BARAI_L, MOVE_KYO_YAMI_BARAI_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Kyo_MoveSet

; =============== MoveInit_Kyo_OniYaki ===============
MoveInit_Kyo_OniYaki:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_KYO_ONI_YAKI_L, MOVE_KYO_ONI_YAKI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Kyo_MoveSet
	
; =============== MoveInit_Kyo_OboroGuruma ===============
MoveInit_Kyo_OboroGuruma:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KYO_OBORO_GURUMA_L, MOVE_KYO_OBORO_GURUMA_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Kyo_MoveSet
	
; =============== MoveInit_Kyo_KototsukiYou ===============
MoveInit_Kyo_KototsukiYou:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KYO_KOTOTSUKI_YOU_L, MOVE_KYO_KOTOTSUKI_YOU_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kyo_MoveSet
	
; =============== MoveInit_Kyo_Kai ===============
MoveInit_Kyo_Kai:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KYO_KAI_L, MOVE_KYO_KAI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kyo_MoveSet
	
; =============== MoveInit_Kyo_UraOrochiNagi ===============
MoveInit_Kyo_UraOrochiNagi:
	call Play_Pl_ClearJoyDirBuffer
	
	ld   a, MOVE_KYO_URA_OROCHI_NAGI_S
	call MoveInputS_SetSpecMove_StopSpeed
	
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	inc  hl ; iPlInfo_Flags1
	inc  hl ; iPlInfo_Flags2
	set  PF2B_NOHURTBOX, [hl]
	jp   MoveInputReader_Kyo_MoveSet
	
; =============== MoveInputReader_Kyo_MoveSet ===============
; Return value when a move was started.
; OUT
; - C flag: Set, to mark the result
MoveInputReader_Kyo_MoveSet:
	scf
	ret
; =============== MoveInputReader_Kyo_NoMove ===============
; Return value when no move was started.
; OUT
; - C flag: Clear, to mark the result
MoveInputReader_Kyo_NoMove:
	or   a
	ret
	
; =============== MoveC_Kyo_YamiBarai ===============
; Move code for Kyo's 108 Shiki Yami Barai (MOVE_KYO_YAMI_BARAI_L, MOVE_KYO_YAMI_BARAI_H).
MoveC_Kyo_YamiBarai:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .spawnProj
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
	
; --------------- frame #2 ---------------	
; Initializes the projectile.
.spawnProj:
	mMvC_ValFrameStartFast .anim
		; Spawn it
		call ProjInit_Iori_YamiBarai
		
		;
		; The heavy version keeps Kyo in the "throw" frame for longer.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; Seek to anim speed
		cp   MOVE_KYO_YAMI_BARAI_H		; Doing the heavy version?
		jp   z, .heavy					; If so, jump
	.light:
		ld   [hl], $0A					; iOBJInfo_FrameTotal = $0A
		jp   .anim
	.heavy:
		ld   [hl], $14					; iOBJInfo_FrameTotal = $14
		jp   .anim
; --------------- frame #3 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_OniYaki ===============
; Move code for Kyo's 100 Shiki Oni Yaki (MOVE_KYO_ONI_YAKI_L, MOVE_KYO_ONI_YAKI_H).
MoveC_Kyo_OniYaki:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .doGravity
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	; The first time we get here, move forward 4px
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH $0400
.obj0_cont:
	; When switching to #0, get manual control (since advancing the animation will
	; depend on the Y speed / touching the ground) and set the move damage.
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
	
		; Deal 8 lines of damage on contact.
		; Light and heavy do identical damage, there's no point in checking it.
		mMvC_ChkMove MOVE_KYO_ONI_YAKI_H, .obj0_setDamageH 
	.obj0_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
	.obj0_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
; --------------- frame #1 ---------------
; Starts the jump.
; Touching the ground at any point in this and the next few frames immediately jumps to the landing frame.
.obj1:
	; The first time we get here...
	mMvC_ValFrameStartFast .obj1_cont
		; Move 4px forward
		mMvC_SetMoveH $0400
		; Disable invulnerability
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_INVULN, [hl]
		
		; Depending on the move strength, use different jump settings.
		mMvC_ChkMove MOVE_KYO_ONI_YAKI_H, .obj1_setJumpH 
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj1_doGravity
	.obj1_setJumpH: ; Heavy
		; At MAX Power, the heavy version is even faster.
		; This got relegated to powerup mode in 96.
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj1_doGravity
	.obj1_setJumpE: ; Super
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj1_doGravity:
		jp   .doGravity
.obj1_cont:
	; YSpeed will always be > -$0A, so this advances the animation immediately.
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity ; We never take the jump
		; Deal 8 lines of damage on contact.
		mMvC_ChkMove MOVE_KYO_ONI_YAKI_H, .obj1_heavyDamage ; Pointless check, both are the same.
	.obj1_lightDamage:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
	.obj1_heavyDamage:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
	
; --------------- frame #2 ---------------
; Immediately advances the anim during the jump.
.obj2:
	mMvC_NextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------
; Set movement speed of $00.40px/frame forward while we're here.
; This is until YSpeed > 1.
.obj3:
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	mMvC_SetSpeedH $0040
	jp   .doGravity
; --------------- frame #4 / common gravity ---------------
; Move down until touching the ground. Switch to #6 on that.
.doGravity:
	; Move down $00.60px/frame
	mMvC_ChkGravityHV $0060, .anim
		; Allow canceling into specials now
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_NOSPECSTART, [hl]
		mMvC_SetLandFrame $05, $03
		jp   .ret
; --------------- frame #5 ---------------
; Landing frame.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret 
	
; =============== MoveC_Kyo_OboroGuruma ===============
; Move code for Kyo's 101 Shiki Oboro Guruma (MOVE_KYO_OBORO_GURUMA_L, MOVE_KYO_OBORO_GURUMA_H).
MoveC_Kyo_OboroGuruma:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3_jumpH0
		mMvC_ChkFrame $04, .obj4_jumpH1
		mMvC_ChkFrame $05, .obj5_jumpH2
		mMvC_ChkFrame $06, .obj6_jumpH3
		mMvC_ChkFrame $07, .obj7
		mMvC_ChkFrame $08, .chkEnd
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	; Initialize jump at the start.
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_PlaySound SFX_HEAVY
		; Remove invulnerability
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_INVULN, [hl]
		
		; Set jump speed
		mMvC_ChkMove MOVE_KYO_OBORO_GURUMA_H, .obj2_setJumpH
	.obj2_setJumpL: ; Light
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0400
		
		; Adjust the animation speed from $01 to $07.
		; Also set iOBJInfo_FrameLeft to the same value to end the frame early.
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $07
		inc  hl ; iOBJInfo_FrameTotal
		ld   [hl], $07
		jp   .obj2_doGravity
	.obj2_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0380
		jp   .obj2_doGravity
	.obj2_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0400
	.obj2_doGravity:
		jp   .doGravityLow
.obj2_cont:
	; The heavy version doesn't execute any new logic until landing on the ground.
	; This means it will continue to #4.
	mMvC_ChkMove MOVE_KYO_OBORO_GURUMA_H, .doGravityLow
.obj2_contL:
	; The light move continues to #7, where horz speed is slowed down to 0.5px/frame.
	mMvC_ValFrameEnd .doGravityLow
		; Set manual control, as #7 ends when touching the ground
		mMvC_SetAnimSpeed ANIMSPEED_NONE 
		mMvC_SetSpeedH $0080
		; Skip to #7
		mMvC_SetFrameOnEnd $07
		jp   .doGravityLow
; --------------- frame #4 ---------------
; Heavy-only, jump extend #1.
.obj4_jumpH1:
	jp   .doGravityLow
; --------------- frame #7 ---------------
; Kyo stops kicking, apply gravity until touching the ground.
; The ascent slows down and , this is timed around the peak of the jump arc, when Kyo stops kicking.
.obj7:
	mMvC_ChkMove MOVE_KYO_OBORO_GURUMA_H, .doGravityLow
	jp   .doGravityNorm
; --------------- frame #3 ---------------
; Heavy-only, jump extend #0.
.obj3_jumpH0:
	mMvC_ValFrameEnd .doGravityLow
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .doGravityLow
; --------------- frame #5 ---------------
; Heavy-only, jump extend #2.
.obj5_jumpH2:
	mMvC_ValFrameEnd .doGravityLow
		mMvC_SetAnimSpeed $08
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .doGravityLow
; --------------- frame #6 ---------------
; Heavy-only, jump extend #3.
.obj6_jumpH3:
	mMvC_ValFrameEnd .doGravityLow
		; Set manual control, as #7 ends when touching the ground
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH $0080
		jp   .doGravityLow
; --------------- common gravity ---------------
.doGravityNorm:
	; Move down $00.60px/frame
	ld   hl, $0060
	jp   .doGravity
.doGravityLow:
	; Move down $00.30px/frame
	ld   hl, $0030
.doGravity:
	; Move down until touching the ground. Switch to #8 on that.
	call OBJLstS_ApplyGravityVAndMoveHV
	jp   nc, .anim
	
		; Allow canceling into specials now
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_NOSPECSTART, [hl]
		mMvC_SetLandFrame $08, $03
		jp   .ret
	
; --------------- frame #8 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_KototsukiYou ===============
; Move code for Kyo's 212 Shiki Kototsuki You (MOVE_KYO_KOTOTSUKI_YOU_L, MOVE_KYO_KOTOTSUKI_YOU_H).
; 2-hit run move.
MoveC_Kyo_KototsukiYou:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .runStart
		mMvC_ChkFrame $01, .run1
		mMvC_ChkFrame $02, .run2
		mMvC_ChkFrame $03, .run3
		mMvC_ChkFrame $04, .runEnd
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Run startup.
.runStart:
	; Set fast anim speed at the end of the frame.
	mMvC_ValFrameEnd .chkNearPl
		mMvC_SetAnimSpeed $01
		jp   .chkNearPl
; --------------- frame #1 ---------------
; First of the three run frames.
; All of these jump to .chkNearPl, and if the player doesn't get close to the opponent
; by the end of the third one, we switch to #4, where the player slows down and the move ends.
.run1:
	; Start the run at the start of the frame.
	mMvC_ValFrameStartFast .obj1_chkNearPl
		mMvC_PlaySound SFX_STEP
		; Set different run speed depending on move strength
		mMvC_ChkMove MOVE_KYO_KOTOTSUKI_YOU_H, .obj1_setRunSpeedH
	.obj1_setRunSpeedL: ; Light
		mMvC_SetSpeedH +$0500
		jp   .moveH_anim
	.obj1_setRunSpeedH: ; Heavy
		mMvC_ChkMaxPow .obj1_setRunSpeedE
		mMvC_SetSpeedH +$0600
		jp   .moveH_anim
	.obj1_setRunSpeedE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		jp   .moveH_anim
.obj1_chkNearPl:
	jp   .chkNearPl
; --------------- frame #2 ---------------
; Run frame.
.run2:
	; Play step SFX at the start of the frame.
	mMvC_ValFrameStartFast .chkNearPl
		mMvC_PlaySound SFX_STEP
		jp   .chkNearPl
; --------------- frame #3 ---------------
; Run frame.
.run3:
	; Play step SFX at the start of the frame.
	mMvC_ValFrameStartFast .obj3_getManCtrl
		mMvC_PlaySound SFX_STEP
.obj3_getManCtrl:
	; Get manual control at the end of the frame, since it shouldn't advance to #5
	mMvC_ValFrameEnd .chkNearPl
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .moveH_anim
; --------------- frame #4 ---------------
; End of run (early abort).
; Set friction at 1px/frame, ending the move when we stop running.
.runEnd:
	mMvC_DoFrictionH +$0100
	jp   nc, .ret
	jp   .end
	
; --------------- distance check for run -> hit transition ---------------
.chkNearPl:
	; Continue running until we get close to the opponent.
	mMvIn_ValClose .moveH_anim
		mMvC_SetFrame $05, $01
		call OBJLstS_ApplyXSpeed
		jp   .ret
.moveH_anim:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #5 ---------------
; Collsion checker
.obj5:
	; Gradually slow down $00.80px/frame
	mMvC_DoFrictionH +$0080
	
	; End the run abruptly doing the second hit if, by the end of the frame, either:
	; - We didn't *attack* the opponent (ie: we got close, but our hitbox didn't overlap)
	; - The opponent is invincible
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]		; Did the opponent get hit/blocked the attack?
	jp   z, .obj5_abort			; If not, end the run
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]		; Is the opponent invulnerable?
	jp   z, .obj5_setHit2		; If not, jump
.obj5_abort:					; Otherwise, end the run
	; but only before attempting to switch to #6
	mMvC_ValFrameEnd .anim
		jp   .end
.obj5_setHit2:
	; Immediately switch to the second attack frame.
	; The second hit will deal 8 lines of damage and drop him on the ground.
	mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
	mMvC_SetFrame $06, $08
	jp   .ret
; --------------- frame #6 ---------------	
; Waits for the second hit to end. No recovery frame here.
.chkEnd:
	mMvC_ValFrameEnd .anim
	; Fall-through
; --------------- common ---------------	
.end:
	call Play_Pl_EndMove
	jp   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_Kai ===============
; Move code for Kyo's 75 Shiki Kai (MOVE_KYO_KAI_L, MOVE_KYO_KAI_H).
; Slide with small hop.
MoveC_Kyo_Kai:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .chkEnd
	
; --------------- frame #0 ---------------	
.obj0:
	mMvC_ValFrameStart .obj0_moveF
		mMvC_SetSpeedH +$0400
.obj0_moveF:
	mMvC_DoFrictionH $0070		; Did we stop moving?
	jp   nc, .anim							; If not, jump
	
	; Otherwise, switch to the next frame.
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   [hl], $00 ; Switch to next frame
	
	; And set the new animation speed.
	
	; The heavy version uses speed $01, allowing the move to animate as normal.
	; The light one instead uses ANIMSPEED_NONE. This prevents the animation from moving
	; past frame #1, and instead can only wait for the player landing on the ground.
	
	; What this means, in practice, is that the heavy version hits twice, since frame #2
	; sets new move damage values.
	
	mMvC_SetAnimSpeed $01		; Use fast anim for heavy
	
	mMvC_ChkMove MOVE_KYO_KAI_H, .anim ; Doing the heavy version? If so, jump
	; Otherwise, get manual control
	ld   hl, iOBJInfo_FrameTotal
	add  hl, de
	ld   [hl], ANIMSPEED_NONE
	jp   .anim
; --------------- frame #1 ---------------	
; Initialize the hop at the start
.obj1:
	mMvC_ValFrameStart .obj1_doGravity
		mMvC_PlaySound SFX_HEAVY
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0300
		jp   .doGravity
.obj1_doGravity:
	jp   .doGravity
; --------------- frame #4 ---------------
; Heavy attack only.
; Just waits the gravity.
.obj4:
	jp   .doGravity
; --------------- frame #2 ---------------	
; Heavy attack only.
; Set damage for 2nd hit when the frame ends.
.obj2:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .doGravity
; --------------- frame #3 ---------------
; Heavy attack only.
; Sets a slower horizontal speed for #4.
.obj3:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH +$0080
		jp   .doGravity
; --------------- frames #1-#4 / common gravity check ---------------
; Switches to the landing frame when touching the ground.
.doGravity:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow canceling on the ground.
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $05, $03
		jp   .ret
; --------------- frame #5 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kyo_UraOrochiNagi ===============
; Move code for Kyo's Ura 108 Shiki Orochi Nagi (MOVE_KYO_URA_OROCHI_NAGI_S).
MoveC_Kyo_UraOrochiNagi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
	jp   .anim
; --------------- frame #2 ---------------	
; Charge frame (along with #1)
.obj2:
	mMvC_ValFrameEnd .anim
	
		;
		; If the frame is allowed to continue animating normally, the charge will be released.
		;
		; It's possible to extend its charge time by holding B, and if so, the frame can loop
		; back to #1. There's a limit to how many times the animation can loop though, and when
		; reaching it B will be treated as released.
		;

		; If we stopped releasing B, animate normally
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		ld   a, [hl]
		and  a, KEY_B	; Holding B?
		jp   z, .anim	; If not, animate
		
		; Otherwise, loop back to #1
		mMvC_SetFrame $01, $01
		jp   .ret
; --------------- frame #4 ---------------
.obj4:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		;--
		; [POI] Where does this come from? We didn't have this set to begin with.
		ld   hl, iPlInfo_Flags2
		add  hl, bc
		res  PF2B_NOHURTBOX, [hl]
		;--
		jp   .anim
; --------------- frame #5 ---------------
; Move horizontally, slowing down gradually.
.obj5:
	; Set the initial movement speed the first time we get here.
	mMvC_ValFrameStartFast .obj5_cont
		mMvC_PlaySound SCT_PHYSFIRE
		mMvC_SetSpeedH +$07C0
		jp   .doFriction
.obj5_cont:
	mMvC_ValFrameEnd .doFriction
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doFriction
; --------------- frame #5 common friction check ---------------	
; Continue moving horizontally and slow down.
.doFriction:
	mMvC_DoFrictionH $0070
	jp   .anim
; --------------- frame #6 ---------------
; Slows down at 0.5px/frame. Move ends when we stop moving.
.chkEnd:
	mMvC_DoFrictionH $0080
	jp   nc, .ret
	call Play_Pl_EndMove
	jp   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Iori_YamiBarai ===============
; Initializes the projectile for:
; - Iori's 108 Shiki Yami Barai (MOVE_IORI_YAMI_BARAI_L, MOVE_IORI_YAMI_BARAI_H)
; - Kyo's 108 Shiki Yami Barai (MOVE_KYO_YAMI_BARAI_L, MOVE_KYO_YAMI_BARAI_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Iori_YamiBarai:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Horz)	; BANK $03 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Horz)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Horz)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Iori_YamiBarai)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Iori_YamiBarai)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Iori_YamiBarai)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $00

				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			; The heavy attack check assumes that moves using this projectile
			; always take up the first pair of special move slots.
			;

			jp   nc, .fldMaxPow			; Are we at max power? If not, jump
			cp   MOVE_SPEC_0_H			; Was this an heavy attack?
			jp   z, .fldHeavy			; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_SPEC_0_H			; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow		; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeed
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeed
		.fldHeavy:
			ld   hl, +$0400
		.setSpeed:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== MoveC_Iori_ThrowG ===============
; Move code for Iori's ground throw. (MOVE_SHARED_THROW_G).
MoveC_Iori_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $03, .chkEnd
; --------------- frames #0,2 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		; And when it does, also reset the throw sequence
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

	
; =============== MoveC_Iori_PunchFH ===============
; Move code for Iori's far heavy punch. (MOVE_SHARED_PUNCH_FH).
MoveC_Iori_PunchFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
; --------------- frame #0 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Move forwards 3px/frame
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetSpeedH +$0300
.obj1_cont:
	; Slowing down at 0.25px/frame
	mMvC_DoFrictionH $0040
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveC_Iori_KickFH ===============
; Move code for Iori's Far Heavy Kick (MOVE_SHARED_KICK_FH).
MoveC_Iori_KickFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID1, PF3_HEAVYHIT|PF3_OVERHEAD
		jp   .anim
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveInputReader_Iori ===============
; Special move input checker for IORI.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Iori:
	mMvIn_Validate Iori, 0

.chkGround:
	;             SELECT + B                SELECT + A
	mMvIn_ChkEasy MoveInit_Iori_KinYaOtome, MoveInit_Iori_OniYaki
	mMvIn_ChkGA Iori, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DBDF+P -> Kin 1211 Shiki Ya Otome
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Iori_KinYaOtome
.chkPunchNoSuper:
	; FDF+P -> 100 Shiki Oni Yaki
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Iori_OniYaki
	; DF+P -> 108 Shiki Yami-barai
	mMvIn_ChkDir MoveInput_DF, MoveInit_Iori_YamiBarai
	; DB+P -> 127 Aoi Hana
	mMvIn_ChkDir MoveInput_DB, MoveInit_Iori_AoiHana
	; End
	jp   MoveInputReader_Iori_NoMove
.chkKick:
	; FDB+K -> Shiki Koto Tsuki In
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Iori_KotoTsukiIni
	; End
	jp   MoveInputReader_Iori_NoMove
	
; =============== MoveInit_Iori_YamiBarai ===============
MoveInit_Iori_YamiBarai:
	mMvIn_ValProjActive MoveInputReader_Iori_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_IORI_YAMI_BARAI_L, MOVE_IORI_YAMI_BARAI_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Iori_SetMove
; =============== MoveInit_Iori_OniYaki ===============
MoveInit_Iori_OniYaki:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_IORI_ONI_YAKI_L, MOVE_IORI_ONI_YAKI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Iori_SetMove
; =============== MoveInit_Iori_AoiHana ===============
MoveInit_Iori_AoiHana:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_IORI_AOI_HANA_L, MOVE_IORI_AOI_HANA_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Iori_SetMove
; =============== MoveInit_Iori_KotoTsukiIni ===============
MoveInit_Iori_KotoTsukiIni:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_IORI_KOTO_TSUKI_IN_L, MOVE_IORI_KOTO_TSUKI_IN_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Iori_SetMove
; =============== MoveInit_Iori_KinYaOtome ===============
MoveInit_Iori_KinYaOtome:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_IORI_KIN_YA_OTOME_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Iori_SetMove
; =============== MoveInputReader_Iori_SetMove ===============
MoveInputReader_Iori_SetMove:
	scf
	ret
; =============== MoveInputReader_Iori_NoMove ===============
MoveInputReader_Iori_NoMove:
	or   a
	ret
	
; =============== MoveC_Iori_YamiBarai ===============
; Move code for Iori's 108 Shiki Yami Barai (MOVE_IORI_YAMI_BARAI_L, MOVE_IORI_YAMI_BARAI_H).
MoveC_Iori_YamiBarai:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	mMvC_ValFrameEnd .anim
		; Depending on the visible frame...
		mMvC_StartChkFrame
			mMvC_ChkTarget .end
			mMvC_ChkFrame $02, .spawnProj
		jp   .anim
; --------------- frame #2 ---------------
.spawnProj:
	call ProjInit_Iori_YamiBarai
	jp   .anim
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
	jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Iori_OniYaki ===============
; Move code for Iori's 100 Shiki Oni Yaki (MOVE_IORI_ONI_YAKI_L, MOVE_IORI_ONI_YAKI_H).
MoveC_Iori_OniYaki:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .doGravity
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	; Move 4px forward
	mMvC_ValFrameStart .obj0_cont
		mMvC_SetMoveH +$0400
.obj0_cont:
	; 8 lines of damage at the end
	mMvC_ValFrameEnd .anim
		; [POI] Was the damage different?
		mMvC_ChkMove MOVE_IORI_ONI_YAKI_H, .obj0_setDamageH
	.obj0_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_FIRE
		jp   .anim
	.obj0_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_FIRE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Move 8px forward
	mMvC_ValFrameStart .obj1_cont
		mMvC_SetMoveH +$0800
.obj1_cont:
	; 8 lines of damage at the end
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		
		; [POI] Was the damage different?
		mMvC_ChkMove MOVE_IORI_ONI_YAKI_H, .obj1_setDamageH
	.obj1_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
	.obj1_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
; --------------- frame #2 ---------------
; Jump setup.
.obj2:
	mMvC_ValFrameStart .obj2_cont
		mMvC_PlaySound SFX_SPECIAL
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set jump settings depending on the move strength
		mMvC_ChkMove MOVE_IORI_ONI_YAKI_H, .obj2_setJumpH
	.obj2_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj2_doGravity
	.obj2_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj2_doGravity
	.obj2_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	; Immediately switch to the next frame (YSpeed always > -$0A)
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		; [POI] Was the damage different?
		mMvC_ChkMove MOVE_IORI_ONI_YAKI_H, .obj2_setDamageH
	.obj2_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
	.obj2_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	; Immediately switch to the next frame (YSpeed always > -$0A)
	mMvC_NextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	; Switch to #5 when YSpeed > $01
	mMvC_NextFrameOnGtYSpeed $01, ANIMSPEED_NONE
	mMvC_SetSpeedH +$0040
	jp   .doGravity
; --------------- frames #2-5 / common gravity check ---------------
.doGravity:
	; Switch to #6 when we touch the ground
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $06, $03
		jp   .ret
; --------------- frame #6 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Iori_AoiHana ===============
; Move code for Iori's 127 Aoi Hana (MOVE_IORI_AOI_HANA_L, MOVE_IORI_AOI_HANA_H).
; Three-part dash that ends early in the second for the light version. 
MoveC_Iori_AoiHana:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #0 ---------------
; Forward dash #1.
.obj0:
	mMvC_ValFrameStart .obj0_cont
		mMvC_SetSpeedH +$0400
		mMvC_PlaySound SFX_LIGHT
.obj0_cont:
	jp   .moveH
; --------------- frame #1 ---------------
; Set damage for dash #2.
.obj1:
	mMvC_ValFrameEnd .moveH
	
		;
		; Set the damage for the next frame.
		;
		; The light version of the move enables manual control, preventing it from advancing from #2 to #3.
		; This means only the heavy version does the third part of the move (the small jump).
		;
		
		; Set damage for heavy version initially
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		
		mMvC_ChkMove MOVE_IORI_AOI_HANA_H, .moveH
	.obj1_setDamageL:
		; Otherwise, enable manual control
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de
		ld   [hl], ANIMSPEED_NONE
		; And shake the opponent for longer
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		jp   .moveH
; --------------- frame #2 ---------------
; Forward dash #2.
.obj2:
	; Move 4px/frame forward
	mMvC_ValFrameStart .obj2_cont
		mMvC_SetSpeedH +$0400
		mMvC_PlaySound SFX_LIGHT
.obj2_cont:

	; If we aren't doing the heavy version, slow down at $00.50px/frame.
	; The move ends if when we stop moving.
	mMvC_ChkMove MOVE_IORI_AOI_HANA_H, .moveH
	
	; This counts as our recovery for the light version, since it takes a bit to stop.
	mMvC_ChkFrictionH +$0050, .anim
		jp   .end
; --------------- frames #0-2 / common horizontal movement ---------------
.moveH:
	mMvC_DoFrictionH +$0050
	jp   .anim
; --------------- frame #3 ---------------
; Small jump start. Heavy version only.
.obj3:
	
	mMvC_ValFrameStart .obj3_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set forward jump speed
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0200
		jp   .doGravity
.unused_obj3_playJumpSFX:
	; [TCRF] Unreferenced sound playback command.
	;        Likely used to be above the .doGravity call, since we're starting a jump after all.
	mMvC_PlaySound SFX_JUMP
.obj3_cont:
	; Deal 8 lines of damage and drop the opponent on the ground when switchcing to #4.
	; This pretty much ends the combo string, so it's better to perform the light version instead.
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #4 ---------------
; Small jump, mid-jump. Heavy version only.
.obj4:
	mMvC_ValFrameStart .doGravity
		mMvC_PlaySound SFX_LIGHT
		jp   .doGravity
; --------------- frames #3-4 / common gravity check ---------------
; Switch to #5 when touching the ground.
.doGravity:
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $05, $03
		jp   .ret
; --------------- frame #5 ---------------
; Recovery after the jump.
.chkEnd:
	mMvC_ValFrameEnd .anim
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
	jr   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Iori_KotoTsukiIn ===============
; Move code for Iori's 212 Shiki Koto Tsuki In (MOVE_IORI_KOTO_TSUKI_IN_L, MOVE_IORI_KOTO_TSUKI_IN_H).
MoveC_Iori_KotoTsukiIn:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .chkNear
		mMvC_SetAnimSpeed $01
		jp   .chkNear
; --------------- frame #1 ---------------
; Run towards the opponent.
.obj1:
	mMvC_ValFrameStart .obj1_cont
		; Play step SFX at the start of this, as well as the other frames
		; for the run sequence.
		mMvC_PlaySound SFX_STEP
		; Set run speed
		mMvC_ChkMove MOVE_IORI_KOTO_TSUKI_IN_H, .obj1_setDashH
	.obj1_setDashL: ; Light
		mMvC_SetSpeedH +$0400
		jp   .moveH
	.obj1_setDashH: ; Heavy
		mMvC_ChkMaxPow .obj1_setDashE
		mMvC_SetSpeedH +$0580
		jp   .moveH
	.obj1_setDashE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		jp   .moveH
.obj1_cont:
	jp   .chkNear
; --------------- frame #2 ---------------
; Run towards the opponent.
.obj2:
	mMvC_ValFrameStart .chkNear
		mMvC_PlaySound SFX_STEP
		jp   .chkNear
; --------------- frame #3 ---------------
; Run towards the opponent.
.obj3:
	mMvC_ValFrameStart .obj3_cont
		mMvC_PlaySound SFX_STEP
.obj3_cont:
	mMvC_ValFrameEnd .chkNear
		; Disable timing for #4
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .moveH
; --------------- frame #4 ---------------
; If we got here, we didn't get close enough to the opponent.
; Slow down at 1px/frame, and end the move when we stop moving.
.obj4:
	mMvC_ChkFrictionH $0100, .ret
		jp   .end
; --------------- frames #0-3 / player distance check ---------------
.chkNear:
	; Advances to #5 if we get near
	mMvIn_ValClose .moveH
		mMvC_SetFrame $05, $01
		call OBJLstS_ApplyXSpeed
		jp   .ret
; --------------- frames #0-4 / common run movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
	
; --------------- frame #5 ---------------	
;
.obj5:
	; Slow down at 0.5px/frame while doing this
	mMvC_DoFrictionH $0080
	
	
	;
	; Don't continue to #6 until we collided with the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]				; Did we reach?
	jp   z, .obj5_chkEnd				; If not, jump
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   z, .obj5_setDamage				; If not, jump
.obj5_chkEnd:
	mMvC_ValFrameEnd .anim
		jp   .end
.obj5_setDamage:
	; Deal more damage the next frame.
	mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT|PF3_FIRE
	; Switch to #6
	mMvC_SetFrame $06, $02
	jp   .ret
; --------------- [POI] unreferenced frame ---------------
; Not in 96.
	jp   .anim
; --------------- frame #6 ---------------
; Delay after the hit.
.obj6:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $0A
		jp   .anim
; --------------- frame #7 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
	jp   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Iori_KinYaOtome ===============
; Move code for Iori's Kin 1201 Shiki Ya Otome (MOVE_IORI_KIN_YA_OTOME_S).
MoveC_Iori_KinYaOtome:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .setDamage0
		mMvC_ChkFrame $03, .setDamage1
		mMvC_ChkFrame $05, .setDamage1
		mMvC_ChkFrame $07, .setDamage1
		mMvC_ChkFrame $09, .setDamage1
		mMvC_ChkFrame $0B, .setDamage1
		mMvC_ChkFrame $0D, .setDamage1
		mMvC_ChkFrame $0F, .setDamage1
		mMvC_ChkFrame $10, .setDamage1_chkOtherBlock
		mMvC_ChkFrame $11, .setDamageFinisher
		mMvC_ChkFrame $12, .chkEnd
	jp   .setDamage0_chkOtherBlock
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameStart .obj0_cont
		mMvC_PlaySound SFX_HEAVY
.obj0_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $12
		jp   .anim
; --------------- frame #1 ---------------
; Run towards the opponent.
; We have $12 frames to hit the opponent, otherwise the move ends.
.obj1:
	mMvC_ValFrameStart .obj1_cont
		; Move forward near 8px/frame at the start
		mMvC_SetSpeedH +$07FF
		jp   .moveH
.obj1_cont:
	mMvC_ValFrameEnd .obj1_chkGuard
		jp   .end
.obj1_chkGuard:
	;
	; Continue moving forwards until we collided (last frame) with the opponent.
	; If the opponent blocked the hit, switch to #14. Otherwise, continue to #2.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]				; Did we reach?
	jp   z, .obj1_chkGuard_noHit		; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj1_chkGuard_noHit		; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj1_chkGuard_noHit		; If not, skip	
	
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .end						; If so, the move ends immediately
	
	.obj1_chkGuard_noGuard:
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_FIRE
		mMvC_SetFrame $02, $01
		jp   .ret
.obj1_chkGuard_noHit:
	jp   .moveH
	
; --------------- odd frames #3,5,7,9,B,D,F - line damage + block check ---------------
.setDamage1:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_FIRE
		jp   .chkOtherEscape
; --------------- frame #2 ---------------
.setDamage0:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_FIRE
		jp   .anim
; --------------- even frames - line damage ---------------
.setDamage0_chkOtherBlock:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_FIRE
		jp   .chkOtherEscape
; --------------- frame #10 - line damage + block check ---------------		
.setDamage1_chkOtherBlock:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
; --------------- common escape check ---------------
; Done at the start of about half of the frames.
	.chkOtherEscape:
		;
		; [POI] If the opponent somehow isn't in one of the hit effects 
		;       this move sets, hop back instead of continuing.
		;       This can happen if the opponent gets hit by a previously thrown
		;       fireball in the middle of the move.
		;
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
		jp   z, .anim			; If so, skip
		cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
		jp   z, .anim			; If so, skip
			ld   a, MOVE_SHARED_HOP_B
			call Pl_SetMove_StopSpeed
			jp   .ret
; --------------- frame #11 ---------------
; Deals the big boy damage.
.setDamageFinisher:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
; --------------- common horizontal movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #12 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
	jp   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Saisyu_ThrowG ===============
; Move code for Saisyu's ground throw. (MOVE_SHARED_THROW_G).
MoveC_Saisyu_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #3 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_FG_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_EndThrow
		jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Saisyu_PunchFH ===============
; Move code for Saisyu's far heavy punch. (MOVE_SHARED_PUNCH_FH).
MoveC_Saisyu_PunchFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0400
.obj0_cont:
	mMvC_ValFrameEnd .anim
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .chkEnd
		mMvC_SetMoveH +$0800
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_ValFrameEnd .anim ; oops
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Athena_KickHN ===============
; Move code for:
; - Athena's Near Heavy Kick. (MOVE_SHARED_KICK_HN)
; - Kim's Near Heavy Punch. (MOVE_SHARED_PUNCH_HN)
; - Saisyu's Near Heavy Punch. (MOVE_SHARED_PUNCH_HN)
MoveC_Athena_KickHN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $02, .chkEnd
; --------------- frame #1 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Saisyu ===============
; Special move input checker for SAISYU.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Saisyu:
	mMvIn_Validate Saisyu, 0

.chkGround:
	;             SELECT + B                     SELECT + A
	mMvIn_ChkEasy MoveInit_Saisyu_UraOrochiNagi, MoveInit_Saisyu_OniYaki
	mMvIn_ChkGA Saisyu, .chkPunch, 0, CHKGA_PUNCH

.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DBDF+P -> Ura 108 Shiki Orochi Nagi
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Saisyu_UraOrochiNagi
.chkPunchNoSuper:
	; FDF+P -> 100 Shiki Oni Yaki
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Saisyu_OniYaki
	; DF+P -> 108 Shiki Yami Barai
	mMvIn_ChkDir MoveInput_DF, MoveInit_Saisyu_YamiBarai
	; FDB+P -> 702 Shiki En Jou
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Saisyu_EnJou
	; End
	jp   MoveInputReader_Saisyu_NoMove
	
; =============== MoveInit_Saisyu_YamiBarai ===============
MoveInit_Saisyu_YamiBarai:
	mMvIn_ValProjActive MoveInputReader_Saisyu_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_SAISYU_YAMI_BARAI_L, MOVE_SAISYU_YAMI_BARAI_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Saisyu_MoveSet
; =============== MoveInit_Saisyu_OniYaki ===============
MoveInit_Saisyu_OniYaki:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_SAISYU_ONI_YAKI_L, MOVE_SAISYU_ONI_YAKI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Saisyu_MoveSet
; =============== MoveInit_Saisyu_EnJou ===============
MoveInit_Saisyu_EnJou:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_SAISYU_EN_JOU_L, MOVE_SAISYU_EN_JOU_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Saisyu_MoveSet
; =============== MoveInit_Saisyu_UraOrochiNagi ===============
MoveInit_Saisyu_UraOrochiNagi:
	call Play_Pl_ClearJoyDirBuffer
	
	ld   a, MOVE_SAISYU_URA_OROCHI_NAGI_S
	call MoveInputS_SetSpecMove_StopSpeed
	
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	inc  hl ; iPlInfo_Flags1
	inc  hl ; iPlInfo_Flags2
	set  PF2B_NOHURTBOX, [hl]
	jp   MoveInputReader_Saisyu_MoveSet
	
; =============== MoveInputReader_Saisyu_MoveSet ===============
MoveInputReader_Saisyu_MoveSet:
	scf
	ret
; =============== MoveInputReader_Saisyu_NoMove ===============
MoveInputReader_Saisyu_NoMove:
	or   a
	ret
	
; =============== MoveC_Saisyu_YamiBarai ===============
; Move code for Saisyu's 108 Shiki Yami Barai (MOVE_SAISYU_YAMI_BARAI_L, MOVE_SAISYU_YAMI_BARAI_H).
; Identical to MoveC_Kyo_YamiBarai
MoveC_Saisyu_YamiBarai:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .spawnProj
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
	
; --------------- frame #2 ---------------	
; Initializes the projectile.
.spawnProj:
	mMvC_ValFrameStartFast .anim
		; Spawn it
		call ProjInit_Iori_YamiBarai
		
		;
		; The heavy version keeps Kyo in the "throw" frame for longer.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; Seek to anim speed
		cp   MOVE_SAISYU_YAMI_BARAI_H	; Doing the heavy version?
		jp   z, .heavy					; If so, jump
	.light:
		ld   [hl], $0A					; iOBJInfo_FrameTotal = $0A
		jp   .anim
	.heavy:
		ld   [hl], $14					; iOBJInfo_FrameTotal = $14
		jp   .anim
; --------------- frame #3 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Saisyu_OniYaki ===============
; Move code for Saisyu's 100 Shiki Oni Yaki (MOVE_SAISYU_ONI_YAKI_L, MOVE_SAISYU_ONI_YAKI_H).
; Identical to MoveC_Kyo_OniYaki
MoveC_Saisyu_OniYaki:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .doGravity
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	; The first time we get here, move forward 4px
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH $0400
.obj0_cont:
	; When switching to #0, get manual control (since advancing the animation will
	; depend on the Y speed / touching the ground) and set the move damage.
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
	
		; Deal 8 lines of damage on contact.
		; Light and heavy do identical damage, there's no point in checking it.
		mMvC_ChkMove MOVE_SAISYU_ONI_YAKI_H, .obj0_setDamageH 
	.obj0_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
	.obj0_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .anim
; --------------- frame #1 ---------------
; Starts the jump.
; Touching the ground at any point in this and the next few frames immediately jumps to the landing frame.
.obj1:
	; The first time we get here...
	mMvC_ValFrameStartFast .obj1_cont
		; Move 4px forward
		mMvC_SetMoveH $0400
		; Disable invulnerability
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_INVULN, [hl]
		
		; Depending on the move strength, use different jump settings.
		mMvC_ChkMove MOVE_SAISYU_ONI_YAKI_H, .obj1_setJumpH 
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj1_doGravity
	.obj1_setJumpH: ; Heavy
		; At MAX Power, the heavy version is even faster.
		; This got relegated to powerup mode in 96.
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj1_doGravity
	.obj1_setJumpE: ; Super
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj1_doGravity:
		jp   .doGravity
.obj1_cont:
	; YSpeed will always be > -$0A, so this advances the animation immediately.
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity ; We never take the jump
		; Deal 8 lines of damage on contact.
		mMvC_ChkMove MOVE_SAISYU_ONI_YAKI_H, .obj1_heavyDamage ; Pointless check, both are the same.
	.obj1_lightDamage:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
	.obj1_heavyDamage:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
	
; --------------- frame #2 ---------------
; Immediately advances the anim during the jump.
.obj2:
	mMvC_NextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------
; Set movement speed of $00.40px/frame forward while we're here.
; This is until YSpeed > 1.
.obj3:
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	mMvC_SetSpeedH $0040
	jp   .doGravity
; --------------- frame #4 / common gravity ---------------
; Move down until touching the ground. Switch to #6 on that.
.doGravity:
	; Move down $00.60px/frame
	mMvC_ChkGravityHV $0060, .anim
		; Allow canceling into specials now
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl	; iPlInfo_Flags1
		res  PF1B_NOSPECSTART, [hl]
		mMvC_SetLandFrame $05, $03
		jp   .ret
; --------------- frame #5 ---------------
; Landing frame.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret 
	
; =============== MoveC_Saisyu_EnJou ===============
; Move code for Saisyu's 1702 Shiki En Jou (MOVE_SAISYU_EN_JOU_L, MOVE_SAISYU_EN_JOU_H).
MoveC_Saisyu_EnJou:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
; --------------- frame #0 ---------------
; Fast forward movement.
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0800
.obj0_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SFX_HEAVY

		;--
		; Remove invuln
		; The English version does this later, during recovery.
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
	IF !VER_EN
		inc  hl
		res  PF1B_INVULN, [hl]	
	ENDC
		;--
		; Set jump settings
		mMvC_ChkMove MOVE_SAISYU_EN_JOU_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0400
		jp   .obj1_doGravity
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0380
		jp   .obj1_doGravity
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0400
	.obj1_doGravity:
		jp   .doGravity
.obj1_cont:
	jp   .doGravity
; --------------- common gravity check / frame #1 ---------------
.doGravity:
	; Switch to #2 when landing
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $02, $01
		jp   .ret
; --------------- frame #2 ---------------
.obj2:
	; Deal knockdown hit.
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $08
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		mMvC_PlaySound SFX_HEAVY
	IF VER_EN
		; See the version check above
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		res  PF1B_INVULN, [hl]	
	ENDC
		jp   .anim

; --------------- frame #3 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Saisyu_UraOrochiNagi ===============
; Move code for Saisyu's Ura 108 Shiki Orochi Nagi (MOVE_SAISYU_URA_OROCHI_NAGI_S).
; See also: MoveC_Kyo_UraOrochiNagi
MoveC_Saisyu_UraOrochiNagi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .obj7
		mMvC_ChkFrame $08, .obj8
		mMvC_ChkFrame $09, .chkEnd
; --------------- frames #0-3 ---------------	
	jp   .anim
; --------------- frame #4 ---------------	
; Charge frame (along with #3)
.obj4:
	mMvC_ValFrameEnd .anim
		;
		; If the frame is allowed to continue animating normally, the charge will be released.
		;
		; It's possible to extend its charge time by holding B, and if so, the frame can loop
		; back to #3. There's a limit to how many times the animation can loop though, and when
		; reaching it B will be treated as released.
		;

		; If we stopped releasing B, animate normally
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		ld   a, [hl]
		and  a, KEY_B	; Holding B?
		jp   z, .anim	; If not, animate
		
		; Otherwise, loop back to #3
		mMvC_SetFrame $03, $01
		jp   .ret
; --------------- frame #6 ---------------
.obj6:
	mMvC_ValFrameStartFast .obj6_cont
		mMvC_SetMoveH $0800
.obj6_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		;--
		; [POI] Where does this come from? We didn't have this set to begin with.
		ld   hl, iPlInfo_Flags2
		add  hl, bc
		res  PF2B_NOHURTBOX, [hl]
		;--
		jp   .anim
; --------------- frame #7 ---------------
; Move horizontally, slowing down gradually.
.obj7:
	; Set the initial movement speed the first time we get here.
	mMvC_ValFrameStartFast .obj7_cont
		mMvC_PlaySound SCT_PHYSFIRE
		mMvC_SetSpeedH +$07C0
		jp   .doFriction
.obj7_cont:
	; Set manual control for friction check
	mMvC_ValFrameEnd .doFriction
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doFriction
; --------------- frame #4 ---------------
; Continue moving horizontally and slow down.
.doFriction:
	mMvC_DoFrictionH +$0070
	jp   .anim
; --------------- frame #8 ---------------
; Slows down at 0.5px/frame, then wait for 3 more frames before continuing.
.obj8:
	mMvC_ChkFrictionH +$0080, .ret
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed $03
		jp   .anim
; --------------- frame #9 ---------------
; Recovery frame #2.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Benimaru_ThrowG ===============
; Move code for Benimaru's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Benimaru_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_FG_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
; When visually switching to #3, hit the opponent.
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		; And when it does, also reset the throw sequence
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_ThrowA_DirD ===============
; Move code for air throws that grab the opponent and dive straight down.
; Used as air throw (MOVE_SHARED_THROW_A) for these characters:
; - Benimaru
; - Yuri
; - Mai
MoveC_Base_ThrowA_DirD:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		; Enable manual control since #1 lasts until touching the ground
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		; Stick opponent below us
		mMvC_SetDamage $06, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
; Holding on the opponent.
.obj1:
	; Continue gravity until touching the ground
	mMvC_ValFrameEnd .doGravity
		;--
		; [POI] If too much time has passed and we didn't touch the ground yet,
		;       throw the opponent.
		mMvC_SetDamage $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .doGravity
		;--
; --------------- frame #2 ---------------
; Holding on the opponent.
.obj2:
	mMvC_ValFrameEnd .anim
	.end:
		; End the throw
		xor  a
		ld   [wPlayPlThrowActId], a
		; New move
		ld   a, MOVE_SHARED_LAUNCH_UB_REC
		call Pl_SetMove_StopSpeed
		
		mMvC_SetSpeedHInt +$0180 ; 1.5px/frame back
		mMvC_SetSpeedV -$0400 ; 4px/frame up
		jr   .ret
; --------------- common gravity for #2 ---------------
.doGravity:
	mMvC_ChkGravityHV $0060, .anim
		; When touching the ground, throw the player downwards.
		mMvC_SetLandFrame $02, $01
		mMvC_SetDamage $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Base_NormA ===============
; Custom code for Benimaru's air dive kick (MOVE_SHARED_KICK_AHD).
MoveC_Benimaru_KickAHD:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .init
		mMvC_ChkFrame $01, .setDamage0
		mMvC_ChkFrame $02, .setDamage1
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim
	
; --------------- frame #0 ---------------
.init:
	; Initialize downwards speed first time we get here
	mMvC_ValFrameStartFast .init_cont
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV +$0200
		jp   .move
.init_cont:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_SPECIAL
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD
		jp   .anim
; --------------- frame #1 ---------------
; Damage loop.
.setDamage0:
	mMvC_ValFrameEnd .move
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT|PF3_OVERHEAD
		mMvC_PlaySound SFX_SPECIAL
		jp   .move
; --------------- frame #2 ---------------
; Damage loop.
.setDamage1:
	mMvC_ValFrameEnd .move
		ld   hl, $0060 ; [POI] Pointless
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD
		mMvC_PlaySound SFX_SPECIAL
		; Loop back to #1 until we touch the ground
		mMvC_SetFrameOnEnd $01
		jp   .move
; --------------- common gravity check ---------------
; Move down with normal gravity.
; Touching the ground ends the damage loop and continues to #4.
.move:
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $04, $02
		jp   .ret
; --------------- frame #4 ---------------
; Wait for the animation to advance before ending the move.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== MoveInputReader_Benimaru ===============
; Special move input checker for BENIMARU.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Benimaru:
	mMvIn_Validate Benimaru, 0 ; NO AIR SPECIALS
	
.chkGround:
	;             SELECT + B                   SELECT + A
	mMvIn_ChkEasy MoveInit_Benimaru_Raikouken, MoveInit_Benimaru_SuperInazumaKick
	mMvIn_ChkGA Benimaru, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DFDF+P -> Raikouken
	mMvIn_ChkDir MoveInput_DFDF, MoveInit_Benimaru_Raikouken
.chkPunchNoSuper:
	; FDF+P -> Raijinken
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Benimaru_Raijinken
	; End
	jp   MoveInputReader_Benimaru_NoMove
.chkKick:
	; DU+K -> Super Inazuma Kick
	mMvIn_ChkDir MoveInput_DU, MoveInit_Benimaru_SuperInazumaKick
	; DF+K -> Iai Geri
	mMvIn_ChkDir MoveInput_DF, MoveInit_Benimaru_IaiGeri
	; FDB+K -> Shinkuu Katate Goma
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Benimaru_ShinkuuKatateGoma
	; End
	jp   MoveInputReader_Benimaru_NoMove
	
; =============== MoveInit_Benimaru_Raijinken ===============
MoveInit_Benimaru_Raijinken:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_BENIMARU_RAIJINKEN_L, MOVE_BENIMARU_RAIJINKEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Benimaru_MoveSet
	
; =============== MoveInit_Benimaru_ShinkuuKatateGoma ===============
MoveInit_Benimaru_ShinkuuKatateGoma:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L, MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Benimaru_MoveSet
	
; =============== MoveInit_Benimaru_IaiGeri ===============
MoveInit_Benimaru_IaiGeri:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_BENIMARU_IAI_GERI_L, MOVE_BENIMARU_IAI_GERI_H
	call MoveInputS_SetSpecMove_StopSpeed
	mMvC_PlaySound SCT_MOVEJUMP_A
	jp   MoveInputReader_Benimaru_MoveSet
	
; =============== MoveInit_Benimaru_SuperInazumaKick ===============
MoveInit_Benimaru_SuperInazumaKick:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_BENIMARU_SUPER_INAZUMA_KICK_L, MOVE_BENIMARU_SUPER_INAZUMA_KICK_H
	call MoveInputS_SetSpecMove_StopSpeed
IF VER_EN
	; Invulnerable in the English version
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
ENDC
	jp   MoveInputReader_Benimaru_MoveSet
	
; =============== MoveInit_Benimaru_Raikouken ===============
MoveInit_Benimaru_Raikouken:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_BENIMARU_RAIKOUKEN_S
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	
; =============== MoveInputReader_Benimaru_MoveSet ===============
MoveInputReader_Benimaru_MoveSet:
	scf
	ret
; =============== MoveInputReader_Benimaru_NoMove ===============
MoveInputReader_Benimaru_NoMove:
	or   a
	ret
	
; =============== MoveC_Benimaru_Raijinken ===============
; Move code for Benimaru's Raijinken. (MOVE_BENIMARU_RAIJINKEN_L, MOVE_BENIMARU_RAIJINKEN_H)
MoveC_Benimaru_Raijinken:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $08, .chkEnd
; --------------- frames #0,#2-#7 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SCT_FIREHIT
		jp   .anim
; --------------- frame #8 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Benimaru_ShinkuuKatateGoma ===============
; Move code for Benimaru's Shinkuu Katate Goma. (MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L, MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H)
MoveC_Benimaru_ShinkuuKatateGoma:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .setDamage0
		mMvC_ChkFrame $02, .setDamage1
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .doGravity
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #0 ---------------
; Startup.
.obj0:
	; Move 8px forwards
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0800
.obj0_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		mMvC_PlaySound SFX_SPECIAL
		; Next frame starts dealing damage
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		
		; Set the number of attack loops.
		; The light version loops 4 times, the heavy double that.
		mMvC_ChkMove MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H, .obj0_setDelayH
	.obj0_setDelayL:
		ld   hl, iPlInfo_Benimaru_ShinkuuKatateGoma_LoopCount
		add  hl, bc
		ld   [hl], $04
		jp   .anim
	.obj0_setDelayH:
		ld   hl, iPlInfo_Benimaru_ShinkuuKatateGoma_LoopCount
		add  hl, bc
		ld   [hl], $08
		jp   .anim
; --------------- frame #1 ---------------
; Leg spin frame #0
.setDamage0:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_SPECIAL
		mMvC_SetDamage $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
; Leg spin frame #2
.setDamage1:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_SPECIAL
		mMvC_SetDamage $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		
		;
		; Check if the animation should loop.
		; If we jump to .anim, the spin ends.
		;
		
		; If the loop counter elapsed, we're done
		ld   hl, iPlInfo_Benimaru_ShinkuuKatateGoma_LoopCount
		add  hl, bc
		dec  [hl]
		jp   z, .anim
		
		; If not holding A+B, we're also done
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		ld   a, [hl]
		and  a, KEY_A|KEY_B
		cp   KEY_A|KEY_B
		jp   z, .anim
		
		; Otherwise, loop back to #1
		mMvC_SetFrame $01, $01
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .ret
; --------------- frame #3 ---------------
; Pre-backjump.
.obj3:
	mMvC_ValFrameEnd .anim
		; Set manual control for the next two frames.
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #4 ---------------
; Backjump.
.obj4:
	mMvC_ValFrameStartFast .obj4_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Initialize backjump
		mMvC_SetSpeedH -$0100
		mMvC_SetSpeedV -$0300
		jp   .doGravity
.obj4_cont:
	; Immediately switch to #5.
	; Our speed was just set to -$03, which is always > than -$08.
	mMvC_ValNextFrameOnGtYSpeed -$08, ANIMSPEED_NONE, .doGravity
		jp   .doGravity
; --------------- common gravity check for frames #4-5 ---------------
; Backjump.
.doGravity:
	; Only continue to #6 when we touch the ground.
	mMvC_ChkGravityHV $0060, .anim
		; We landed.
		
		; Allow special cancels from the ground
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		
		; Switch to #6 and re-enable anims
		mMvC_SetLandFrame $06, $03
		jp   .ret
; --------------- frame #6 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Benimaru_IaiGeri ===============
; Move code for Benimaru's Iai Geri (MOVE_BENIMARU_IAI_GERI_L, MOVE_BENIMARU_IAI_GERI_H).
MoveC_Benimaru_IaiGeri:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .obj2
		;--
		; Heavy-specific
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		; The same thunder jump from Super Inazuma Kick
		mMvC_ChkFrame $05, MoveC_Benimaru_SuperInazumaKick.obj0
		mMvC_ChkFrame $06, MoveC_Benimaru_SuperInazumaKick.obj1
		mMvC_ChkFrame $07, MoveC_Benimaru_SuperInazumaKick.obj2
		mMvC_ChkFrame $08, MoveC_Benimaru_SuperInazumaKick.obj3
		mMvC_ChkFrame $09, MoveC_Benimaru_SuperInazumaKick.doGravity
		mMvC_ChkFrame $0A, MoveC_Benimaru_SuperInazumaKick.chkEnd
		;--
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		; The light version ends early at the first kick
		mMvC_ChkMove MOVE_BENIMARU_IAI_GERI_L, .end
		; While the heavy does another kick, then the thunderstrike
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, $00
		jp   .anim
; --------------- frame #3 ---------------
; Startup for second kick.
.obj3:
	mMvC_ValFrameStartFast .obj3_cont
		mMvC_SetMoveH $0C00
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, $00
		jp   .anim
.obj3_cont:
	jp   .anim
; --------------- frame #4 ---------------
; Second kick, middle hit.
.obj4:
	mMvC_ValFrameStartFast .obj4_cont
		; Transition to the thunder attack, which knocks down the opponent.
		mMvC_SetMoveH $0C00
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		jp   .anim
.obj4_cont:
	jp   .anim
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
	jp   .ret
.end:
	call Play_Pl_EndMove
.ret:
	ret  
	
; =============== MoveC_Benimaru_SuperInazumaKick ===============
; Move code for Benimaru's Super Inazuma Kick (MOVE_BENIMARU_SUPER_INAZUMA_KICK_L, MOVE_BENIMARU_SUPER_INAZUMA_KICK_H).
MoveC_Benimaru_SuperInazumaKick:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .doGravity
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #0 ---------------		
.obj0:
	;--
	mMvC_ValFrameStartFast .obj0_cont
.obj0_cont:
	;--
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		jp   .anim
; --------------- frame #0 ---------------		
; Jump startup, until near peak.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetMoveH +$0400
		;--
		; Remove invulnerability
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		
		; Pick jump settings
		mMvC_ChkMove MOVE_BENIMARU_SUPER_INAZUMA_KICK_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH -$0080 ; 0.5px/frame backwards
		mMvC_SetSpeedV -$0500 ; 5px/frame up
		jp   .obj1_setDamage
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH -$0080 ; 0.5px/frame backwards
		mMvC_SetSpeedV -$0600 ; 6px/frame up
		jp   .obj1_setDamage
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0100 ; 1px/frame forward
		mMvC_SetSpeedV -$0700 ; 7px/frame up
	.obj1_setDamage:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		jp   .doGravity
.obj1_cont:
	; Immediately proceed to the next frame (-$0A always > than the current V speed)
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		jp   .doGravity
; --------------- frame #2 ---------------
; Jump
.obj2:
	; Spawn thunder at the start, which is the peak of the jump
	mMvC_ValFrameStartFast .obj2_cont
		call ProjInit_Benimaru_ThunderWall
.obj2_cont:
	; Immediately proceed to the next frame (-$0A always > than the current V speed) 
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	; Switch to #4 shortly after the peak of the jump
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	; Set base downwards speed at 0.25px/frame, which will be incremented by gravity
	mMvC_SetSpeedH $0040
	jp   .doGravity
; --------------- frames #2-4 / common gravity check ---------------
.doGravity:
	; Standard jump gravity
	mMvC_ChkGravityHV $0060, .anim
		;--
		; We're on the ground, allow starting specials
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		; Pick the proper landing frame if we came here from the heavy version of Iai Geri.
		mMvC_ChkMove MOVE_BENIMARU_IAI_GERI_H, .setLandIaiGeri
	.setLandNorm:
		mMvC_SetLandFrame $05, $03
		jp   .ret
	.setLandIaiGeri:
		mMvC_SetLandFrame $0A, $03
		jp   .ret
; --------------- frame #5 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Benimaru_Raikouken ===============
; Move code for Benimaru's Raikouken (MOVE_BENIMARU_RAIKOUKEN_S).
MoveC_Benimaru_Raikouken:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj1
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .chkEnd
	jp  .anim ; We never get here
; --------------- frame #0 ---------------
; Holding back punch.
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
	; Spawn thunder wall over hand, which becomes a giant ball in #1.
	; This is purely a visual effect, as all of the damage is done by the player hitbox.
	call ProjInit_Benimaru_ThunderBall
.obj0_cont:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SCT_FIREHIT
		jp   .anim
; --------------- frames #1-2 ---------------
; Forward punch, giant ball.
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_SUPERALT
		mMvC_PlaySound SCT_FIREHIT
		jp   .anim
; --------------- frame #3 ---------------
; Forward punch, giant ball.
.obj3:
	mMvC_ValFrameEnd .anim
		; Only difference is that it sets up #4 to knock down.
		mMvC_SetDamageNext $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		mMvC_PlaySound SCT_FIREHIT
		jp   .anim
; --------------- frame #4 ---------------
.obj4:
	mMvC_ValFrameEnd .anim
		; Despawn giant ball.
		mMvC_SetAnimSpeed $08
		call ProjC_Benimaru_DespawnThunderBall
		jp   .anim
; --------------- frame #5 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjC_Benimaru_DespawnThunderBall ===============
; This projectile doesn't despawn on its own unlike most others, it waits
; for the move code to call this.
ProjC_Benimaru_DespawnThunderBall:
	push bc
		push de
			
			; Seek to the projectile slot
			push de
			pop  bc
			ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
			add  hl, bc
			push hl
			pop  de
			
			; Signal the projectile to despawn itself
			ld   hl, iOBJInfo_Proj_ThunderBall_Despawn
			add  hl, de
			ld   [hl], PROJ_TB_DESPAWN
		pop  de
	pop  bc
	ret  
	
; =============== ProjInit_Benimaru_ThunderBall ===============
; Initializes the ball of thunder for Benimaru's Raikouken.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Benimaru_ThunderBall:
	mMvC_PlaySound SCT_PROJ_LG_A
	
	push bc
		push de
		
			; =============== ProjInitS_InitAndGetOBJInfo ===============
			; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
			;
			; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
			;
			; IN
			; - BC: Ptr to wPlInfo
			; - DE: Ptr to respective wOBJInfo
			; OUT
			; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
			; WIPES
			; - BC
			
			;
			; A = Player marker (for the tile ID check)
			;
			ld   hl, iPlInfo_PlId
			add  hl, bc
			ld   a, [hl]

			;
			; Seek to the wOBJInfo for the current player's projectile.
			; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
			; Save its ptr to DE and HL.
			;
			push de			; BC = Ptr to player wOBJInfo
			pop  bc
			ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
			add  hl, bc		; Seek to 2 slots after
			push hl
			pop  de			; Copy it to DE

			;
			; Show the projectile
			;
			ld   [hl], OST_VISIBLE
			
			;
			; Set the tile ID base for the projectile depending on the player we're playing as.
			; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
			;
			or   a				; iPlInfo_PlId != PL1?
			jp   nz, .tileId2P	; If so, jump
		.tileId1P:
			ld   hl, iOBJInfo_TileIDBase
			add  hl, de		; Seek to iOBJInfo_TileIDBase
			ld   [hl], $80	; Graphics from $8800
			jp   .tileIdRet
		.tileId2P:
			ld   hl, iOBJInfo_TileIDBase
			add  hl, de		; Seek to iOBJInfo_TileIDBase
			ld   [hl], $A4	; Graphics from $8A40
		.tileIdRet:
			; ==============================
			

			; --------------- main ---------------

			; Set code pointer
			ld   hl, iOBJInfo_Play_CodeBank
			add  hl, de
			ld   [hl], BANK(ProjC_Benimaru_ThunderBall)	; BANK $02 ; iOBJInfo_Play_CodeBank
			inc  hl
			ld   [hl], LOW(ProjC_Benimaru_ThunderBall)	; iOBJInfo_Play_CodePtr_Low
			inc  hl
			ld   [hl], HIGH(ProjC_Benimaru_ThunderBall)	; iOBJInfo_Play_CodePtr_High

			; Write sprite mapping ptr for this projectile.
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; BANK $01 ; iOBJInfo_BankNum
			inc  hl
			ld   [hl], LOW(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   [hl], HIGH(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; iOBJInfo_OBJLstPtrTbl_High
			inc  hl
			ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


			; Set animation speed.
			ld   hl, iOBJInfo_FrameLeft
			add  hl, de
			ld   [hl], $00	; iOBJInfo_FrameLeft
			inc  hl
			ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

			; Set priority value
			ld   hl, iOBJInfo_Play_Priority
			add  hl, de
			ld   [hl], PROJ_PRIORITY_NODESPAWN
	
			; Initialize the despawn flag
			inc  hl ; Seek to iOBJInfo_Proj_ThunderBall_Despawn
			ld   [hl], PROJ_TB_VISIBLE
		
			; Set initial position relative to the player's origin
			
			; =============== OBJLstS_Overlap ===============
			; Moves an wBJInfo to exactly overlap another one.
			; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
			;
			; Extracted to OBJLstS_Overlap in 96.
			;
			; IN
			; - DE: Ptr to the wOBJInfo structure to be moved
			; - BC: Ptr to target wOBJInfo structure (the "other" one)
			push bc
				;
				; Set up source and destination pointers
				;

				; BC = Ptr to source iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, bc			; HL = BC + iOBJInfo_X
				push hl
				pop  bc				; Move back to BC

				; DE = Ptr to destination iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, de			; HL = DE + iOBJInfo_X

				;
				; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
				;
		REPT 4
				ld   a, [bc]	; A = Source byte
				inc  bc			; SrcPtr++
				ldi  [hl], a	; Write to dest; DestPtr++
		ENDR
			pop  bc

			;
			; Copy over the byte with sprite mapping flags
			;

			; A = Source iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, bc
			ld   a, [hl]
			; HL = Ptr to dest iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			; Write it over
			ld   [hl], a
			; ==============================
			mMvC_SetMoveH +$0800
			mMvC_SetMoveV -$0800
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Benimaru_ThunderBall ===============
; Projectile code for Benimaru's Raikouken.
; This is a visual effect for a thunder that turns into a giant ball,
; it deals no actual damage.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to projectile wOBJInfo
ProjC_Benimaru_ThunderBall:
	push bc
	
		; If we're no longer doing the super (ie: got hit out of it), despawn the ball
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_BENIMARU_RAIKOUKEN_S
		jp   nz, .despawn
		
		; Despawn the ball if its explicit despawn flag is set
		ld   hl, iOBJInfo_Proj_ThunderBall_Despawn
		add  hl, de
		ld   a, [hl]
		cp   PROJ_TB_DESPAWN
		jp   z, .despawn
		
		; Loop between the last two frames when we get there
		mMvC_ValFrameEnd .syncPos
			ld   hl, iOBJInfo_OBJLstPtrTblOffset
			add  hl, de
			ld   a, [hl]							; A = Current Frame
			cp   $0C*OBJLSTPTR_ENTRYSIZE			; FrameId != #C? (the last one)
			jp   nz, .syncPos						; If so, skip
			ld   [hl], ($0B-1)*OBJLSTPTR_ENTRYSIZE	; Otherewise, restart #B (offset by -1 since it's about to be incremented)
	
	.syncPos:
		; Sync ball position relative to the player's origin
		
		; BC = Player's wOBJInfo_Pl* slot
		push de
		pop  bc
		ld   hl, -((OBJINFO_SIZE*2)+iOBJInfo_Status)
		add  hl, bc
		push hl
		pop  bc
		
		; =============== OBJLstS_Overlap ===============
		; Moves an wBJInfo to exactly overlap another one.
		; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
		;
		; Partial copy of what was extracted to OBJLstS_Overlap in 96.
		;
		; IN
		; - DE: Ptr to the wOBJInfo structure to be moved
		; - BC: Ptr to target wOBJInfo structure (the "other" one)
		push bc
			;
			; Set up source and destination pointers
			;

			; BC = Ptr to source iOBJInfo_X
			ld   hl, iOBJInfo_X
			add  hl, bc			; HL = BC + iOBJInfo_X
			push hl
			pop  bc				; Move back to BC

			; DE = Ptr to destination iOBJInfo_X
			ld   hl, iOBJInfo_X
			add  hl, de			; HL = DE + iOBJInfo_X

			;
			; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
			;
	REPT 4
			ld   a, [bc]	; A = Source byte
			inc  bc			; SrcPtr++
			ldi  [hl], a	; Write to dest; DestPtr++
	ENDR
		pop  bc
		; ==============================
		mMvC_SetMoveH +$0800 ; 8px in front of origin
		mMvC_SetMoveV -$0800 ; 8px above origin
		call OBJLstS_DoAnimTiming_Loop_by_DE
	pop  bc
	ret  
	.despawn:
		call OBJLstS_Hide
	pop  bc
	ret
	
; =============== ProjInit_Benimaru_ThunderWall ===============
; Initializes the projectile for Benimaru's Super Inazuma Kick (and by extension, Iai Geri).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Benimaru_ThunderWall:
	mMvC_PlaySound SFX_SPECIAL
	
	push bc
		push de
		
			; =============== ProjInitS_InitAndGetOBJInfo ===============
			; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
			;
			; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
			;
			; IN
			; - BC: Ptr to wPlInfo
			; - DE: Ptr to respective wOBJInfo
			; OUT
			; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
			; WIPES
			; - BC
			
			;
			; A = Player marker (for the tile ID check)
			;
			ld   hl, iPlInfo_PlId
			add  hl, bc
			ld   a, [hl]

			;
			; Seek to the wOBJInfo for the current player's projectile.
			; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
			; Save its ptr to DE and HL.
			;
			push de			; BC = Ptr to player wOBJInfo
			pop  bc
			ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
			add  hl, bc		; Seek to 2 slots after
			push hl
			pop  de			; Copy it to DE

			;
			; Show the projectile
			;
			ld   [hl], OST_VISIBLE
			
			;
			; Set the tile ID base for the projectile depending on the player we're playing as.
			; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
			;
			or   a				; iPlInfo_PlId != PL1?
			jp   nz, .tileId2P	; If so, jump
		.tileId1P:
			ld   hl, iOBJInfo_TileIDBase
			add  hl, de		; Seek to iOBJInfo_TileIDBase
			ld   [hl], $80	; Graphics from $8800
			jp   .tileIdRet
		.tileId2P:
			ld   hl, iOBJInfo_TileIDBase
			add  hl, de		; Seek to iOBJInfo_TileIDBase
			ld   [hl], $A4	; Graphics from $8A40
		.tileIdRet:
			; ==============================
			

			; --------------- main ---------------

			; Set code pointer
			ld   hl, iOBJInfo_Play_CodeBank
			add  hl, de
			ld   [hl], BANK(ProjC_Benimaru_ThunderWall)	; BANK $02 ; iOBJInfo_Play_CodeBank
			inc  hl
			ld   [hl], LOW(ProjC_Benimaru_ThunderWall)	; iOBJInfo_Play_CodePtr_Low
			inc  hl
			ld   [hl], HIGH(ProjC_Benimaru_ThunderWall)	; iOBJInfo_Play_CodePtr_High

			; Write sprite mapping ptr for this projectile.
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; BANK $01 ; iOBJInfo_BankNum
			inc  hl
			ld   [hl], LOW(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   [hl], HIGH(OBJLstPtrTable_Proj_Benimaru_ThunderBall)	; iOBJInfo_OBJLstPtrTbl_High
			inc  hl
			ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


			; Set animation speed.
			ld   hl, iOBJInfo_FrameLeft
			add  hl, de
			ld   [hl], $00	; iOBJInfo_FrameLeft
			inc  hl
			ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

			; Set priority value
			ld   hl, iOBJInfo_Play_Priority
			add  hl, de
			ld   [hl], PROJ_PRIORITY_NODESPAWN
	
			;--
			; [POI] Copypasted init code
			inc  hl ; Seek to iOBJInfo_Proj_ThunderBall_Despawn
			ld   [hl], PROJ_TB_VISIBLE
			;--
			
			; Set initial position relative to the player's origin
			
			; =============== OBJLstS_Overlap ===============
			; Moves an wBJInfo to exactly overlap another one.
			; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
			;
			; Extracted to OBJLstS_Overlap in 96.
			;
			; IN
			; - DE: Ptr to the wOBJInfo structure to be moved
			; - BC: Ptr to target wOBJInfo structure (the "other" one)
			push bc
				;
				; Set up source and destination pointers
				;

				; BC = Ptr to source iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, bc			; HL = BC + iOBJInfo_X
				push hl
				pop  bc				; Move back to BC

				; DE = Ptr to destination iOBJInfo_X
				ld   hl, iOBJInfo_X
				add  hl, de			; HL = DE + iOBJInfo_X

				;
				; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
				;
				REPT 2
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
				ENDR
				; Hardcoded Y position, aligned to the floor
				ld   a, PL_FLOOR_POS
				inc  bc
				ldi  [hl], a
				; iOBJInfo_YSub
				ld   a, [bc]	; A = Source byte
				inc  bc			; SrcPtr++
				ldi  [hl], a	; Write to dest; DestPtr++
		
			pop  bc

			;
			; Copy over the byte with sprite mapping flags
			;

			; A = Source iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, bc
			ld   a, [hl]
			; HL = Ptr to dest iOBJInfo_OBJLstFlags
			ld   hl, iOBJInfo_OBJLstFlags
			add  hl, de
			; Write it over
			ld   [hl], a
			; ==============================
			mMvC_SetMoveH +$2800
			mMvC_SetMoveV +$1000
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Benimaru_ThunderWall ===============
; Projectile code for Benimaru's Super Inazuma Kick.
; This is a thunderstrike that covers the entire height of the playfield.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to projectile wOBJInfo
ProjC_Benimaru_ThunderWall:
	; Variation of the generic projectile code that despawns at the end of #6.
	mMvC_ValFrameEnd .anim
		mMvC_StartChkFrameInt
			mMvC_ChkFrame $06, .despawn
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret  
.despawn:
	call OBJLstS_Hide
	ret
	
; =============== MoveC_Ryo_ThrowG ===============
; Move code for Ryo's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Ryo_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
; When visually switching to #2, hit the opponent.
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamage $06, HITTYPE_LAUNCH_MID_UB_NOSTUN, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		; And when it does, also reset the throw sequence
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_PunchFH ===============
; Move code for Ryo's far heavy punch. (MOVE_SHARED_PUNCH_FH).
MoveC_Ryo_PunchFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID1, PF3_HEAVYHIT|PF3_OVERHEAD
		jp   .anim
; --------------- frame #1 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Ryo ===============
; Special move input checker for RYO.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Ryo:
	mMvIn_Validate Ryo, 1
	
.chkAir:
	;             SELECT + B               SELECT + A
	mMvIn_ChkEasy MoveInit_Ryo_RyuKoRanbu, MoveInit_Ryo_KoOuKenAir
	mMvIn_ChkGA Ryo, .chkAirPunch, 0, CHKGA_PUNCH
	
.chkAirPunch:
	mMvIn_ValSuper .chkAirPunchNoSuper
	; DFDB+P -> Ryu Ko Ranbu
	mMvIn_ChkDir MoveInput_DFDB, MoveInit_Ryo_RyuKoRanbu
.chkAirPunchNoSuper:
	; DF+P -> Ko Ou Ken (Air)
	mMvIn_ChkDir MoveInput_DF, MoveInit_Ryo_KoOuKenAir
	; End
	jp   MoveInputReader_Ryo_NoMove
	
.chkGround:
	;             SELECT + B               SELECT + A
	mMvIn_ChkEasy MoveInit_Ryo_RyuKoRanbu, MoveInit_Ryo_KoHou
	mMvIn_ChkGA Ryo, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DFDB+P -> Ryu Ko Ranbu
	mMvIn_ChkDir MoveInput_DFDB, MoveInit_Ryo_RyuKoRanbu
.chkPunchNoSuper:
	; FBDF+P -> Haoh Shoukou Ken
	mMvIn_ChkDir MoveInput_FBDF, MoveInit_Ryo_HaohShoukouKen
	; FDF+P -> Ko Hou
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Ryo_KoHou
	; BDF+P (close) -> Kyokuken Ryu Renbu Ken
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Ryo_KyokukenRyuRenbuKen
	; DF+P -> Ko Ou Ken
	mMvIn_ChkDir MoveInput_DF, MoveInit_Ryo_KoOuKen
	; FDB+P -> Zanretsuken
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Ryo_Zanretsuken
	; End
	jp   MoveInputReader_Ryo_NoMove
.chkKick:
	; BF+K -> Hien Shippuu Kyaku
	mMvIn_ChkDir MoveInput_BF_Charge, MoveInit_Ryo_HienShippuuKyaku
	; End
	jp   MoveInputReader_Ryo_NoMove
	
; =============== MoveInit_Ryo_KoOuKen ===============
MoveInit_Ryo_KoOuKen:
	mMvIn_ValProjActive MoveInputReader_Ryo_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RYO_KO_OU_KEN_GL, MOVE_RYO_KO_OU_KEN_GH
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_HienShippuuKyaku ===============
MoveInit_Ryo_HienShippuuKyaku:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_RYO_HIEN_SHIPPUU_KYAKU_L, MOVE_RYO_HIEN_SHIPPUU_KYAKU_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_Zanretsuken ===============
MoveInit_Ryo_Zanretsuken:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RYO_ZENRETSUKEN_L, MOVE_RYO_ZENRETSUKEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_KoHou ===============
MoveInit_Ryo_KoHou:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RYO_KO_HOU_L, MOVE_RYO_KO_HOU_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_KoOuKenAir ===============
MoveInit_Ryo_KoOuKenAir:
	mMvIn_ValProjActive MoveInputReader_Ryo_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RYO_KO_OU_KEN_AL, MOVE_RYO_KO_OU_KEN_AH
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_HaohShoukouKen ===============
MoveInit_Ryo_HaohShoukouKen:
	mMvIn_ValProjActive MoveInputReader_Ryo_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RYO_HAOH_SHOKOU_KEN_L, MOVE_RYO_HAOH_SHOKOU_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_KyokukenRyuRenbuKen ===============
MoveInit_Ryo_KyokukenRyuRenbuKen:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_ValClose MoveInputReader_Ryo_NoMove
	mMvIn_GetLHP MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_L, MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInit_Ryo_RyuKoRanbu ===============
MoveInit_Ryo_RyuKoRanbu:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_RYO_RYU_KO_RANBU_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Ryo_MoveSet
; =============== MoveInputReader_Ryo_MoveSet ===============
MoveInputReader_Ryo_MoveSet:
	scf
	ret
; =============== MoveInputReader_Ryo_NoMove ===============
MoveInputReader_Ryo_NoMove:
	or   a
	ret
	
; =============== MoveC_Ryo_KoOuKenG ===============
; Move code for the ground version of Ryo's Ko-Ou Ken (MOVE_RYO_KO_OU_KEN_GL, MOVE_RYO_KO_OU_KEN_GH).
; Horizontal projectile.
MoveC_Ryo_KoOuKenG:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]				; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de					; HL = Ptr to anim speed
		cp   MOVE_RYO_KO_OU_KEN_GH	; Doing the heavy version?
		jp   z, .obj1_setSpeedH		; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $0A
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $14
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Ryo_KoOuKenG
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_KoOuKenA ===============
; Move code for the air version of Ryo's Ko-Ou Ken (MOVE_RYO_KO_OU_KEN_AL, MOVE_RYO_KO_OU_KEN_AH).
; Diagonal projectile.
MoveC_Ryo_KoOuKenA:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .doGravity
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		call ProjInit_Ryo_KoOuKenA
.obj1_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- common gravity check ---------------
.doGravity:
	mMvC_ChkGravityHV $0060, .anim
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $03, $03
		jp   .ret
; --------------- frame #3 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_HaohShoukouKen ===============
; Move code for Ryo's Haoh Shoukou Ken. (MOVE_RYO_HAOH_SHOUKOU_KEN_L, MOVE_RYO_HAOH_SHOUKOU_KEN_H)
; See also: MoveC_Ryo_KoOuKenG
MoveC_Ryo_HaohShoukouKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim
.obj1:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; HL = Ptr to anim speed
		cp   MOVE_RYO_HAOH_SHOKOU_KEN_H	; Doing the heavy version?
		jp   z, .obj1_setSpeedH			; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $0A
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $14
		jp   .anim
; --------------- frame #2 ---------------	
.obj2:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Ryo_HaohShoukouKen
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------	
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_HienShippuuKyaku ===============
; Move code for Ryo's Hien Shippuu Kyaku (MOVE_RYO_HIEN_SHIPPUU_KYAKU_L, MOVE_RYO_HIEN_SHIPPUU_KYAKU_H).
; Full screen forward jump.
MoveC_Ryo_HienShippuuKyaku:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $05, .chkEnd
; --------------- frames #3-4 ---------------
	jp   .doGravity
; --------------- frame #0 ---------------
; Startup
.obj0:
	; Set manual control for next frames, due to the jump logic
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
; Handles the initial jump, shared between light/heavy variations.
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		
		; Set forward jump settings
		mMvC_ChkMove MOVE_RYO_HIEN_SHIPPUU_KYAKU_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0180
		jp   .doGravity
	.obj1_setJumpH:
		; Special settings at max power here
		mMvC_ChkMaxPow .obj1_setJumpMaxPowH
	.obj1_setJumpNormH: ; Heavy
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0200
		jp   .doGravity
	.obj1_setJumpMaxPowH: ; Heavy, Max POW
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV -$0200
		jp   .doGravity
.obj1_cont:
	;
	; The heavy version of the move does a second kick once the opponent is hit.
	;
	
	; The light version does not do this, it just handles gravity and waits for the player
	; to touch the ground.
	mMvC_ChkMove MOVE_RYO_HIEN_SHIPPUU_KYAKU_L, .doGravity
.obj1_contH:
	; Wait until we hit the opponent once
	mMvC_ValHit .doGravity
		; Opponent hit, switch to #2 and re-enable anims
		mMvC_SetFrame $02, ANIMSPEED_INSTANT
		mMvC_SetSpeedH $0400
		jp   .ret
; --------------- frame #2 ---------------
; Startup for second kick, which knocks down.
.obj2:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- common gravity check / frames #1-4 ---------------
.doGravity:
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Landed on ground, allow canceling specials
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		; If we landed prematurely, switch to #5.
		; Don't interrupt the second kick on #2-4 though, in case we're doing the heavy.
		mMvC_StartChkFrameInt
			mMvC_ChkFrame $02, .anim
			mMvC_ChkFrame $03, .anim
			mMvC_ChkFrame $04, .anim
		mMvC_SetLandFrame $05, $05
		jp   .ret
; --------------- frame #5 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_Zenretsuken ===============
; Move code for Ryo's Zenretsuken (MOVE_RYO_ZENRETSUKEN_L, MOVE_RYO_ZENRETSUKEN_H)
MoveC_Ryo_Zenretsuken:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		; Check for 1st hit
		mMvC_ChkFrame $00, .chk1stHit
		mMvC_ChkFrame $01, .chk1stHit
		mMvC_ChkFrame $02, .set1stHit0
		mMvC_ChkFrame $03, .chk1stHit
		mMvC_ChkFrame $04, .set1stHit1
		mMvC_ChkFrame $05, .chk1stHit
		mMvC_ChkFrame $06, .set1stHit0
		mMvC_ChkFrame $07, .chk1stHit
		mMvC_ChkFrame $08, .set1stHit1
		mMvC_ChkFrame $09, .chk1stHit
		; Whiff
		mMvC_ChkFrame $0A, .chkEnd
		; Hit sequence
		mMvC_ChkFrame $0B, .hitSeq0
		mMvC_ChkFrame $0D, .hitSeq1
		mMvC_ChkFrame $0F, .hitSeq0
		mMvC_ChkFrame $11, .hitSeq1
		mMvC_ChkFrame $13, .hitSeq0
		mMvC_ChkFrame $15, .hitSeq1NoShift
		mMvC_ChkFrame $16, .hitKnockdown
		; Recovery
		mMvC_ChkFrame $17, .chkEnd
	jp   .anim
	
; --------------- frames #2,#6 ---------------
; Sets HITTYPE_HIT_MULTI0 as damage type for the initial hit.
; This and the next one serve to switch up the initial hit depending on when we make
; contact with the opponent.
.set1stHit0:
	mMvC_ValFrameEnd .chk1stHit
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		mMvC_PlaySound SFX_HEAVY
		jp   .chk1stHit
; --------------- frames #4,#8 ---------------
; Sets HITTYPE_HIT_MULTI1 as damage type for the initial hit.
.set1stHit1:
	mMvC_ValFrameEnd .chk1stHit
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, $00
		mMvC_PlaySound SFX_HEAVY
		jp   .chk1stHit
; --------------- initial hit check / frames #0-9 ---------------
.chk1stHit:
	
	; Initialize the vertical shift offset for the damage loop, for when we get there
	ld   hl, iPlInfo_Ryo_Zanretsuken_VShift
	add  hl, bc
	ld   [hl], $00
	
	; If we don't hit the opponent by #A, the move ends prematurely. (.chkEnd)
	
	; Wait until the opponent is hit
	mMvC_ValHit .anim
	; Wait until the opponent is no longer invulnerable
	mMvC_ValNotInvuln .anim
	; Hit confirmed, jump to the damage loop
	mMvC_SetFrame $0B, ANIMSPEED_INSTANT
	jp   .ret
	
; --------------- frames #B,F,13 ---------------
; Hit sequence #0
.hitSeq0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		; Increment the vertical shift offset.
		; This is used by HitTypeS_MovePlToOpFront to progressively move the opponent up,
		; which is used by HITTYPE_HIT_MULTI0 and HITTYPE_HIT_MULTI1.
		ld   hl, iPlInfo_Ryo_Zanretsuken_VShift
		add  hl, bc
		inc  [hl]
		jp   .anim
; --------------- frames #D,11 ---------------
; Hit sequence #1.
; Same as the other one, just using HITTYPE_HIT_MULTI1.
.hitSeq1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		ld   hl, iPlInfo_Ryo_Zanretsuken_VShift
		add  hl, bc
		inc  [hl]
		jp   .anim
; --------------- frame #15 ---------------
; Hit with no more upmove.
.hitSeq1NoShift:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $04, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		jp   .anim
; --------------- frame #16 ---------------
; Hit that deals a knockdown at the end.
.hitKnockdown:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $14
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #17 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		; Cleanup
		ld   hl, iPlInfo_Ryo_Zanretsuken_VShift
		add  hl, bc
		ld   [hl], $00
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_KoHou ===============
; Move code for Ryo's Ko Hou (MOVE_RYO_KO_HOU_L, MOVE_RYO_KO_HOU_H).
; Became MoveC_Robert_RyuuGa in 96.
MoveC_Ryo_KoHou:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #1 ---------------	
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		mMvC_ChkMove MOVE_RYO_KO_HOU_H, .obj1_setHitH
	.obj1_setHitL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
	.obj1_setHitH: ; Heavy
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------	
.obj2:
	mMvC_ValFrameStart .obj2_cont
		mMvC_SetMoveH $0800
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl	; Seek to iPlInfo_Flags1
		res  PF1B_INVULN, [hl]
		mMvC_ChkMove MOVE_RYO_KO_HOU_H, .obj2_setJumpH
	.obj2_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj2_doGravity
	.obj2_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj2_doGravity
	.obj2_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	mMvC_NextFrameOnGtYSpeed -$06, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------	
.obj3:
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #4 ---------------	
.obj4:
	mMvC_SetSpeedH $0040
; --------------- frame #1-4 / common gravity ---------------	
.doGravity:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $05, $03
		jp   .ret
; --------------- frame #5 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_KyokukenRyuRenbuKen ===============
; Move code for Ryo's Kyokuken Ryu Renbu Ken.
; Multi-hit close combo.
MoveC_Ryo_KyokukenRyuRenbuKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #0 ---------------	
.obj0:
	; Set 1st hit.
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_CONTHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .anim
; --------------- frame #1 ---------------	
.obj1:
	; Set 2nd hit.
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, PF3_CONTHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .anim
; --------------- frame #2 ---------------	
.obj2:
	; Move forwards, set 3rd hit.
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_SetMoveH +$0800
.obj2_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		mMvC_PlaySound SFX_HEAVY
		jp   .anim
; --------------- frame #3 ---------------	
.obj3:
	; Move forwards one last time in the uppercut pose
	mMvC_ValFrameStartFast .obj3_cont
		mMvC_SetMoveH +$1000
.obj3_cont:
	jp   .anim
; --------------- frame #7 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Ryo_RyuKoRanbuS ===============
; Move code for Ryo's Ryu Ko Ranbu. (MOVE_RYO_RYU_KO_RANBU_S)
MoveC_Ryo_RyuKoRanbuS:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .objOdd
		mMvC_ChkFrame $05, .objOdd
		mMvC_ChkFrame $07, .objOdd
		mMvC_ChkFrame $09, .objOdd
		mMvC_ChkFrame $0B, .objOdd
		mMvC_ChkFrame $0D, .objOdd
		mMvC_ChkFrame $0F, .objOdd
		mMvC_ChkFrame $10, .startRyuuGa
		mMvC_ChkFrame $11, .chkEnd
	jp   .objEven
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameStart .obj0_getManCtrl
	; Nothing
.obj0_getManCtrl:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStart .obj1_chkGuard
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jump speed
		mMvC_SetSpeedH +$07FF
		mMvC_SetSpeedV -$0200
		jp   .doGravity
.obj1_chkGuard:
	;
	; Continue the jump until hitting the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]				; Did we reach?
	jp   z, .obj1_chkGuard_doGravity	; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj1_chkGuard_doGravity	; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj1_chkGuard_doGravity	; If not, skip	
	
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .obj1_chkGuard_guard		; If so, jump
	.obj1_chkGuard_noGuard:
		; Otherwise, continue to #2
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetFrame $02, $01
		mMvC_SetSpeedH $0000
		; Force player on the ground
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
		jp   .ret
.obj1_chkGuard_guard:
	; If the opponent blocked the hit, slow down considerably.
	; This will still moves us back for overlapping with the opponent.
	mMvC_SetSpeedH $0100
.obj1_chkGuard_doGravity:
	jp   .doGravity
; --------------- frames #3,5,7,9... ---------------
; Generic damage - odd frames.
; Alongside .objEven is used to alternate between hit effects constantly.
.objOdd:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		jp   .chkOtherEscape
; --------------- frame #2 ---------------
; Initial frame before the odd/even switching.
; This sets the initial jump speed and doesn't check for block yet.
.obj2:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		jp   .anim
; --------------- frames #4,6,8,A,... ---------------
; Generic damage - even frames.
.objEven:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
; --------------- common escape check ---------------
; Done at the start of about half of the frames.
	.chkOtherEscape:
		;
		; [POI] If the opponent somehow isn't in one of the hit effects 
		;       this move sets, hop back instead of continuing.
		;       This can happen if the opponent gets hit by a previously thrown
		;       fireball in the middle of the move.
		;
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
		jp   z, .anim			; If so, skip
		cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
		jp   z, .anim			; If so, skip
			; Otherwise, transition to hop
			ld   a, MOVE_SHARED_HOP_B
			call Pl_SetMove_StopSpeed
			jp   .ret
; --------------- frame #10 ---------------
; Transitions to Ko Hou at the end of the frame.	
.startRyuuGa:
	mMvC_ValFrameEnd .anim
		ld   a, MOVE_RYO_KO_HOU_H
		call MoveInputS_SetSpecMove_StopSpeed
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .ret
; --------------- common gravity check ---------------	
.doGravity:
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Allow special cancel on ground
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $11, $07
		jp   .ret
; --------------- frame #11 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Ryo_KoOuKenG ===============
; Initializes the projectile for:
; - Ryo's ground version of Ko Ou Ken (MOVE_RYO_KO_OU_KEN_GL, MOVE_RYO_KO_OU_KEN_GH)
; - Yuri's Ko Ou Ken (MOVE_YURI_KO_OU_KEN_L, MOVE_YURI_KO_OU_KEN_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Ryo_KoOuKenG:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Horz)	; BANK $03 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Horz)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Horz)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Ryo_KoOuKenG)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Ryo_KoOuKenG)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Ryo_KoOuKenG)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $00
	
				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$1000
				mMvC_SetMoveV -$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			; The heavy attack check assumes that moves using this projectile
			; always take up the first pair of special move slots.
			;

			jp   nc, .fldMaxPow			; Are we at max power? If not, jump
			cp   MOVE_SPEC_0_H			; Was this an heavy attack?
			jp   z, .fldHeavy			; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_SPEC_0_H			; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow		; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeed
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeed
		.fldHeavy:
			ld   hl, +$0400
		.setSpeed:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== ProjInit_Ryo_KoOuKenA ===============
; Initializes the projectile for:
; - Ryo's air version of Ko Ou Ken (MOVE_RYO_KO_OU_KEN_AL, MOVE_RYO_KO_OU_KEN_AH)
; - Yuri's Rai'oh Ken (MOVE_YURI_RAI_OH_KEN_L, MOVE_YURI_RAI_OH_KEN_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Ryo_KoOuKenA:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Ryo_KoOuKenA)	; BANK $02 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Ryo_KoOuKenA)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Ryo_KoOuKenA)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Ryo_KoOuKenA)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Ryo_KoOuKenA)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Ryo_KoOuKenA)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $00

				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$1000
				mMvC_SetMoveV -$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile speed.
			; The heavy attack check assumes that moves using this projectile
			; always take up the first pair of special move slots.
			;

			jp   nc, .fldMaxPow			; Are we at max power? If not, jump
			cp   MOVE_SPEC_4_H			; Was this an heavy attack?
			jp   z, .fldHeavy			; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_SPEC_4_H			; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow		; If so, jump
		.fldLight:
			mMvC_SetSpeedH +$0100
			mMvC_SetSpeedV +$0100
			jp   .ret
		.fldHeavyMaxPow:
			mMvC_SetSpeedH +$0200
			mMvC_SetSpeedV +$0180
			jp   .ret
		.fldHeavy:
			mMvC_SetSpeedH +$0400
			mMvC_SetSpeedV +$0300
		.ret:

		pop  de
	pop  bc
	ret
	
; =============== ProjInit_Ryo_HaohShoukouKen ===============
; Initializes the large projectile for Haoh Shoukou Ken, used by:
; - Ryo (MOVE_RYO_HAOH_SHOUKOU_KEN_L, MOVE_RYO_HAOH_SHOUKOU_KEN_H)
; - Yuri (MOVE_YURI_HAOH_SHOUKOU_KEN_L, MOVE_YURI_HAOH_SHOUKOU_KEN_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Ryo_HaohShoukouKen:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Horz)	; BANK $03 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Horz)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Horz)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Ryo_HaohShoukouKen)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Ryo_HaohShoukouKen)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Ryo_HaohShoukouKen)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $01

				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$1000
				mMvC_SetMoveV -$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			; The heavy attack check assumes that moves using this projectile
			; always take up the first pair of special move slots.
			;

			jp   nc, .fldMaxPow			; Are we at max power? If not, jump
			cp   MOVE_SPEC_5_H			; Was this an heavy attack?
			jp   z, .fldHeavy			; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_SPEC_5_H			; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow		; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeed
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeed
		.fldHeavy:
			ld   hl, +$0400
		.setSpeed:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== ProjC_Ryo_KoOuKenA ===============
; Like the default projectile code (ProjC_Horz), except it also moves down.
ProjC_Ryo_KoOuKenA:
	call ExOBJS_Play_ChkHitModeAndMoveH		; Can it despawn?
	jp   c, .despawn						; If so, jump
	mMvC_ChkGravityV $0000, .despawn		; Move down, and despawn when it touches the ground
	call OBJLstS_DoAnimTiming_Loop_by_DE	; Otherwise, continue animating
	ret
.despawn:
	call OBJLstS_Hide
	ret
	
; =============== MoveC_Yuri_ThrowG ===============
; Move code for Yuri's ground throw. (MOVE_SHARED_THROW_G).
MoveC_Yuri_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .doGravity0
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .doGravity1
		mMvC_ChkFrame $08, .doGravity1
		mMvC_ChkFrame $09, .obj9
		mMvC_ChkFrame $0A, .doGravity1
		mMvC_ChkFrame $0B, .anim
		mMvC_ChkFrame $0C, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Hold onto opponent.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $04
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
; Backjump.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH -$0200
		mMvC_SetSpeedV -$0500
.obj1_cont:
	mMvC_ValFrameEnd .doGravity0
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, $00
		jp   .doGravity0
; --------------- frame #2 ---------------
; Throw the opponent far away, moving now forward.
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		mMvC_SetSpeedH +$0040
		mMvC_SetSpeedV +$0000
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_MID_UB_NOSTUN, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
; Enable manual control for the gravity check, and finish backjump.
.obj3:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH +$0040
		mMvC_SetSpeedV +$0000
		jp   .anim
; --------------- common gravity check / frames #1,3,4 ---------------
; When landing on the ground, switch to #5.
.doGravity0:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $05, $0A
		jp   .ret
; --------------- frame #5 ---------------
; Delay after landing.
.obj5:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $03
		jp   .anim
; --------------- frame #6 ---------------
; Do a second jump while the opponent is flung away.
.obj6:
	mMvC_ValFrameStartFast .obj6_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$0000
		mMvC_SetSpeedV -$0480
.obj6_cont:
	mMvC_ValFrameEnd .doGravity1
		mMvC_SetAnimSpeed $02
		jp   .doGravity1
; --------------- frame #9 ---------------
; Enable manual control for gravity check.
.obj9:
	mMvC_ValFrameEnd .doGravity1
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity1
; --------------- common gravity check / frames #6-A ---------------
; When landing now, the throw has finished.
.doGravity1:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $0B, $03
		jp   .ret
; --------------- frame #C ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_KickFH ===============
; Move code for Yuri's Far Heavy Kick (MOVE_SHARED_KICK_FH).
MoveC_Yuri_KickFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0300
.obj1_cont:
	mMvC_ChkGravityHV $0060, .anim
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $02, $03
		jp   .ret
; --------------- frame #2 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret 
	
; =============== MoveInputReader_Yuri ===============
; Special move input checker for YURI.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Yuri:
	mMvIn_Validate Yuri, 2 ; No Air Moves, dumb check
	
.chkGround:
	;             SELECT + B                    SELECT + A
	mMvIn_ChkEasy MoveInit_Yuri_HienHouOuKyaku, MoveInit_Yuri_KuuGa
	mMvIn_ChkGA Yuri, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	; FBDF+P -> Haoh Shoukou Ken
	mMvIn_ChkDir MoveInput_FBDF, MoveInit_Yuri_HaohShoukouKen
	; FDF+P -> Kuu Ga
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Yuri_KuuGa
	; DF+P -> Ko Ou Ken
	mMvIn_ChkDir MoveInput_DF, MoveInit_Yuri_KoOuKen
	; FDB+P -> Hyaku Retsu Binta
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Yuri_HyakuRetsuBinta
	; DB+P -> Sai Ha
	mMvIn_ChkDir MoveInput_DB, MoveInit_Yuri_SaiHa
	; End
	jp   MoveInputReader_Yuri_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; FBFDB+K -> Hien Hou'ou Kyaku
	mMvIn_ChkDir MoveInput_FBFDB, MoveInit_Yuri_HienHouOuKyaku
.chkKickNoSuper:
	; DF+K -> Rai'oh Ken
	mMvIn_ChkDir MoveInput_DF, MoveInit_Yuri_RaiOhKen
	; End
	jp   MoveInputReader_Yuri_NoMove

; =============== MoveInit_Yuri_KoOuKen ===============
MoveInit_Yuri_KoOuKen:
	mMvIn_ValProjActive MoveInputReader_Yuri_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_YURI_KO_OU_KEN_L, MOVE_YURI_KO_OU_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_SaiHa ===============
MoveInit_Yuri_SaiHa:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_YURI_SAI_HA_L, MOVE_YURI_SAI_HA_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_HyakuRetsuBinta ===============
MoveInit_Yuri_HyakuRetsuBinta:
	;
	; The heavy version of this command throw has Yuri run forwards,
	; so it doesn't perform a standard command throw check here.
	;
	; Meanwhile the light version does it at a standstill, so the
	; check is made here.
	;
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_ChkLHP .heavy
.light:
	; Check throw range and other things
	mMvIn_ValStartCmdThrow_StdColi Yuri
		; OK, start the throw
		ld   a, MOVE_YURI_HYAKU_RETSU_BINTA_L
		call MoveInputS_SetSpecMove_StopSpeed
		; Invulnerable during the command throw 
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		set  PF1B_INVULN, [hl]
		jp   MoveInputReader_Yuri_MoveSet
.heavy:
	; Set the forwards run
	ld   a, MOVE_YURI_HYAKU_RETSU_BINTA_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_KuuGa ===============
MoveInit_Yuri_KuuGa:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_YURI_KUU_GA_L, MOVE_YURI_KUU_GA_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_RaiOhKen ===============
MoveInit_Yuri_RaiOhKen:
	mMvIn_ValProjActive MoveInputReader_Yuri_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_YURI_RAI_OH_KEN_L, MOVE_YURI_RAI_OH_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_HaohShoukouKen ===============
MoveInit_Yuri_HaohShoukouKen:
	mMvIn_ValProjActive MoveInputReader_Yuri_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_YURI_HAOH_SHOUKOU_KEN_L, MOVE_YURI_HAOH_SHOUKOU_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInit_Yuri_HienHouOuKyaku ===============
MoveInit_Yuri_HienHouOuKyaku:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_YURI_HIEN_HOU_OU_KYA_KU_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Yuri_MoveSet
	
; =============== MoveInputReader_Yuri_MoveSet ===============
MoveInputReader_Yuri_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Yuri_NoMove ===============
MoveInputReader_Yuri_NoMove:
	or   a
	ret  
	
; =============== MoveC_Yuri_KoOuKen ===============
; Move code for Yuri's Ko-Ou Ken (MOVE_YURI_KO_OU_KEN_L, MOVE_YURI_KO_OU_KEN_H).
; See also: MoveC_Ryo_KoOuKenG
MoveC_Yuri_KoOuKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]				; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de					; HL = Ptr to anim speed
		cp   MOVE_RYO_KO_OU_KEN_GH	; Doing the heavy version?
		jp   z, .obj1_setSpeedH		; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $08
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $10
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Ryo_KoOuKenG
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_SaiHa ===============
; Move code for Yuri's Sai Ha (MOVE_YURI_SAI_HA_L, MOVE_YURI_SAI_HA_H).
MoveC_Yuri_SaiHa:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
	mMvC_ChkFrame $00, .obj0
	mMvC_ChkFrame $01, .obj1
	mMvC_ChkFrame $02, .obj2
	mMvC_ChkFrame $03, .obj3
	mMvC_ChkFrame $04, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SCT_MOVEJUMP_A
		jp   .anim
; --------------- frame #1 ---------------
; Fire frame #0.
.obj1:
	; At the start of the frame, move player forward by a certain amount
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_ChkMove MOVE_YURI_SAI_HA_H, .obj1_setMoveH
	.obj1_setMoveL: ; Light
		ld   hl, +$0100
		jp   .obj1_setMove
	.obj1_setMoveH: ; Heavy
		mMvC_ChkMaxPow .obj1_setMoveE
		ld   hl, +$0700
		jp   .obj1_setMove
	.obj1_setMoveE: ; Max Power Heavy
		ld   hl, +$0C00
	.obj1_setMove:
		call Play_OBJLstS_MoveH_ByXFlipR
.obj1_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .anim
; --------------- frame #2 ---------------
; Fire frame #1.
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .anim
; --------------- frame #3 ---------------
; Fire frame #2.
.obj3:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_RaiOhKen ===============
; Move code for Yuri's Rai'oh Ken (MOVE_YURI_RAI_OH_KEN_L, MOVE_YURI_RAI_OH_KEN_H).
; Jump + diagonal down projectile
MoveC_Yuri_RaiOhKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
	mMvC_ChkFrame $00, .obj0
	mMvC_ChkFrame $01, .obj1
	mMvC_ChkFrame $03, .obj3
	mMvC_ChkFrame $04, .obj4
	mMvC_ChkFrame $05, .doGravity
	mMvC_ChkFrame $06, .chkEnd
; --------------- frame #2 ---------------
; Jump continuation.
	jp   .anim
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
; Jump.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Pick initial jump speed
		mMvC_ChkMove MOVE_YURI_RAI_OH_KEN_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		ld   hl, -$0600
		jp   .obj1_setJump
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		ld   hl, -$0700
		jp   .obj1_setJump
	.obj1_setJumpE: ; Max Power Heavy
		ld   hl, -$0800
	.obj1_setJump:
		call Play_OBJLstS_SetSpeedV
.obj1_cont:
	; Wait for Y Speed > -$06 before continuing to #2
	mMvC_ValNextFrameOnGtYSpeed -$06, ANIMSPEED_NONE, .doGravity
		;--
		; mMvC_SetAnimSpeed $03
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de
		ld   [hl], $03
		;--
		jp   .doGravity
; --------------- frame #3 ---------------
; Near the peak of jump, spawn projectile.
.obj3:
	mMvC_ValFrameStartFast .obj3_cont
		call ProjInit_Yuri_RaiOhKen
.obj3_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $02
		jp   .doGravity
; --------------- frame #4 ---------------
; Setup for gravity check
.obj4:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- common gravity check ---------------
.doGravity:
	; Continue to #6 when touching the ground
	mMvC_ChkGravityHV $0060, .anim
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $06, $03
		jp   .ret
; --------------- frame #6 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
	call Play_Pl_EndMove
	jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_HaohShoukouKen ===============
; Move code for Yuri's Haoh Shoukou Ken. (MOVE_YURI_HAOH_SHOUKOU_KEN_L, MOVE_YURI_HAOH_SHOUKOU_KEN_H)
; See also: MoveC_Ryo_HaohShoukouKen
MoveC_Yuri_HaohShoukouKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
	jp   .anim
.obj1:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]						; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de							; HL = Ptr to anim speed
		cp   MOVE_YURI_HAOH_SHOUKOU_KEN_H	; Doing the heavy version?
		jp   z, .obj1_setSpeedH				; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $08
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $10
		jp   .anim
; --------------- frame #2 ---------------	
.obj2:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Ryo_HaohShoukouKen
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------	
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_HyakuRetsuBintaL ===============
; Move code for the light version of Yuri's Haoh Shoukou Ken. (MOVE_YURI_HYAKU_RETSU_BINTA_L).
; This is a straight command throw that has Yuri slap the opponent.
MoveC_Yuri_HyakuRetsuBintaL:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $02, .slap1
		mMvC_ChkFrame $04, .slap0
		mMvC_ChkFrame $06, .slap1
		mMvC_ChkFrame $08, .slap0
		mMvC_ChkFrame $0A, .slap1
		mMvC_ChkFrame $0C, .slap0
		mMvC_ChkFrame $0E, .slap1
		mMvC_ChkFrame $10, .slap0
		mMvC_ChkFrame $12, .slap1
		mMvC_ChkFrame $14, .obj14
		mMvC_ChkFrame $15, .obj15
		mMvC_ChkFrame $16, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
; Startup grab
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		jp   .anim
; --------------- frame #4,8,C,10 ---------------
; Damage frame #0
.slap0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		jp   .chkOtherEscape
; --------------- frame #2,6,A,E,12 ---------------
; Damage frame #1
.slap1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, $00
; --------------- common escape check ---------------
; Done at the start of about half of the frames.
.chkOtherEscape:
	;
	; [POI] If the opponent somehow isn't in one of the hit effects 
	;       this move sets, hop back instead of continuing.
	;       This can happen if the opponent gets hit by a previously thrown
	;       fireball in the middle of the move.
	;
	ld   hl, iPlInfo_HitTypeIdOther
	add  hl, bc
	ld   a, [hl]
	cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
	jp   z, .anim			; If so, skip
	cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
	jp   z, .anim			; If so, skip
		; Otherwise, transition to hop
		ld   a, MOVE_SHARED_HOP_B
		call Pl_SetMove_StopSpeed
		; End the throw sequence
		xor  a
		ld   [wPlayPlThrowActId], a
		jp   .ret
; --------------- frame #14 ---------------
.obj14:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #15 ---------------
.obj15:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $14
		jp   .anim
; --------------- frame #16 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_HyakuRetsuBintaH ===============
; Move code for the heavy version of Yuri's Haoh Shoukou Ken. (MOVE_YURI_HYAKU_RETSU_BINTA_H).
; This is a run motion that transitions to the command throw move (light version).
MoveC_Yuri_HyakuRetsuBintaH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
; Run startup.
.obj0:
IF FIX_BUGS
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $10
		jp   .anim
ELSE
	mMvC_ValFrameEnd MoveC_Yuri_KuuGaL.anim
		mMvC_SetAnimSpeed $10
		jp   MoveC_Yuri_KuuGaL.anim
ENDC
; --------------- frame #1 ---------------
; Run forwards.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound $02
		mMvC_ChkMaxPow .obj1_setRunSpeedMaxPow
	.obj1_setRunSpeedNorm:
		mMvC_SetSpeedH +$0500
		jp   .movePl
	.obj1_setRunSpeedMaxPow:
		mMvC_SetSpeedH +$0680
		jp   .movePl
.obj1_cont:
	mMvC_ValFrameEnd .canStartThrow
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		; Fall-through
; --------------- .canStartThrow ---------------
; Attempts to start the command throw if we're close and the opponent didn't block the hit.
.canStartThrow:
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]			; Is the opponent invulnerable?
	jp   nz, .canStartThrow_no		; If so, skip
	bit  PF1B_GUARD, [hl]			; Is the opponent blocking?
	jp   nz, .canStartThrow_no		; If so, skip
	
	; Opponent must be on the ground (what's the air flag?)
	ld   hl, iPlInfo_OBJInfoYOther
	add  hl, bc
	ld   a, [hl]
	cp   PL_FLOOR_POS
	jp   nz, .canStartThrow_no
	
	;--
	;
	; The player must be close to the opponent.
	; Unlike everything else, this requires the player's collision boxes to make contact.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	ld   a, [hl]
	cp   PCF_PUSHED|PCF_PUSHEDOTHER		; Are we both pushing and being pushed?
	jp   z, .canStartThrow_yes			; If so, jump
	
	; If the opponent is dodging, they have no collision box, so the above check fails.
	; So in this case we do the normal distance check.
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_DODGE
	jp   nz, .canStartThrow_no
	mMvIn_ValClose .canStartThrow_no
	;--
	
.canStartThrow_yes:
	mMvIn_ValStartCmdThrow_StdColi .canStartThrow_no
		; Align player to the ground
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
		; Start the command throw move
		ld   a, MOVE_YURI_HYAKU_RETSU_BINTA_L
		call MoveInputS_SetSpecMove_StopSpeed
		; Set initial damage
		mMvC_SetDamageNext $08, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT
		jp   .ret	
.canStartThrow_no:

; --------------- common player movement ---------------
; Run forwards
.movePl:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #12 ---------------
; Whiff.
.chkEnd:
	; Slow down at 1px/frame. End the move when we stop moving.
	mMvC_ChkFrictionH $0100, .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_KuuGaL ===============
; Move code for the light version of Yuri's Kuu Ga. (MOVE_YURI_KUU_GA_L).
; Straight uppercut.
MoveC_Yuri_KuuGaL:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
; --------------- frame #0 ---------------
; Startup
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		jp   .anim
; --------------- frame #1 ---------------
; Uppercut #1
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		; Move forward 8px
		mMvC_SetMoveH +$0800
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Determine jump speed, based on the attack strength.
		; This is checked in an unusual way compared to other moves do it.
		ld   hl, iPlInfo_MoveDamageFlags3
		add  hl, bc
		ld   a, [hl]
		cp   PF3_HEAVYHIT			; Hit marked as heavy?
		jp   z, .obj1_setJumpH		; If so, jump
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0600
		jp   .obj1_cont
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0700
		jp   .obj1_cont
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0800
.obj1_cont:
	; Wait for Y Speed > -$06 before continuing to #2
	mMvC_NextFrameOnGtYSpeed -$06, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #2 ---------------
; Uppercut #2
.obj2:
	mMvC_SetSpeedH $0040
; --------------- common gravity check ---------------	
.doGravity:
	; Switch to #3 when landing
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $03, $05
		jp   .ret
; --------------- frame #3 ---------------
; Recovery
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_KuuGaL ===============
; Move code for the heavy version of Yuri's Kuu Ga. (MOVE_YURI_KUU_GA_H).
; Forward dash followed by an uppercut.
MoveC_Yuri_KuuGaH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Everything is here.
.obj0:
	; At the start of the frame, initialize the dash
	mMvC_ValFrameStartFast .chkMove
		; Move forwards 8px
		mMvC_SetMoveH +$0800
		
		; Determine the initial dash speed
		mMvC_ChkMaxPow .setSpeedMaxPow
	.setSpeedNorm: ; Light/Heavy
		mMvC_SetSpeedH +$0400 ; 4px/frame forward
		jp   .chkMove
	.setSpeedMaxPow: ; Max Power
		mMvC_SetSpeedH +$0600 ; 6px/frame forward
; --------------- common movement check ---------------
.chkMove:
	; Move forwards, slowing down by 0.25px/frame. If we stop, trigger the DP.
	mMvC_DoFrictionH $0040
	jp   c, .startDP
	
	; If the animation ended, trigger the DP (reverse of mMvC_ValFrameEnd)
	call OBJLstS_IsInternalFrameAboutToEnd
	jp   c, .startDP
	
	; The slide has an hitbox. If it hits the opponent, trigger the DP.
	mMvC_ValHit .anim ; and if it didn't yet, continue the animation
	
.startDP:
	; Switch to the light version of the move, which is the uppercut.
	ld   a, MOVE_YURI_KUU_GA_L
	call MoveInputS_SetSpecMove_StopSpeed
	; With these initial damage settings
	mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
	jp   .ret
	
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Yuri_HienHouOuKyaKu ===============
; Move code for Yuri's Hien Hou Ou Kya Ku (MOVE_YURI_HIEN_HOU_OU_KYA_KU_S).
; Multi-hit air kick move.
MoveC_Yuri_HienHouOuKyaKu:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .kickStart
		mMvC_ChkFrame $05, .objOdd
		mMvC_ChkFrame $07, .objOdd
		mMvC_ChkFrame $09, .objOdd
		mMvC_ChkFrame $0B, .objOdd
		mMvC_ChkFrame $0D, .objOdd
		mMvC_ChkFrame $0F, .objOdd
		mMvC_ChkFrame $11, .kickEnd
		mMvC_ChkFrame $12, .obj12
		mMvC_ChkFrame $13, .chkEnd
	jp   .objEven
; --------------- frame #2 ---------------
.obj2:
	; Prepare for manual jump control
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #3 ---------------
.obj3:
	; Initialize the jump at the start
	mMvC_ValFrameStartFast .obj3_chkGuard
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$07FF
		mMvC_SetSpeedV -$0200
		jp   .doGravity
.obj3_chkGuard:
	;
	; Continue the jump until hitting the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]			; Did we reach?
	jp   z, .obj3_chkGuard_doGravity	; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj3_chkGuard_doGravity	; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj3_chkGuard_doGravity	; If not, skip	
	
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .obj3_chkGuard_guard		; If so, jump
	.obj3_chkGuard_noGuard:
		; Otherwise, continue to #4
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetFrame $04, $01
		mMvC_SetSpeedH $0000
		; Force player on the ground
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
		jp   .ret
.obj3_chkGuard_guard:
	; If the opponent blocked the hit, slow down considerably.
	; This will still moves us back for overlapping with the opponent.
	mMvC_SetSpeedH $0100
.obj3_chkGuard_doGravity:
	jp   .doGravity
; --------------- frames #5,7,9... ---------------
; Generic damage - odd frames.
; Alongside .objEven is used to alternate between hit effects constantly.
.objOdd:
	mMvC_ValFrameStart .anim
		mMvC_SetMoveV -$0100
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		jp   .chkOtherEscape
; --------------- frame #4 ---------------
; Frame before the odd/even switching.
; This sets the initial jump speed and doesn't check for block yet.
.kickStart:
	mMvC_ValFrameStart .anim
		mMvC_SetMoveV -$0100
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		jp   .anim
; --------------- frames #6,8,A,... ---------------
; Generic damage - even frames.
.objEven:
	mMvC_ValFrameStart .anim
		mMvC_SetMoveV -$0100
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
; --------------- common escape check ---------------
; Done at the start of about half of the frames.
	.chkOtherEscape:
		;
		; [POI] If the opponent somehow isn't in one of the hit effects 
		;       this move sets, hop back instead of continuing.
		;       This can happen if the opponent gets hit by a previously thrown
		;       fireball in the middle of the move.
		;
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
		jp   z, .anim			; If so, skip
		cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
		jp   z, .anim			; If so, skip
			; Otherwise, transition to backjump
			ld   a, MOVE_SHARED_LAUNCH_UB_REC
			call Pl_SetMove_StopSpeed
			mMvC_SetSpeedH -$0300 ; 3px/frame back
			mMvC_SetSpeedV -$0500 ; 5px/frame up
			jp   .ret
; --------------- frame #11 ---------------
; Frame after the odd/even switching.
; This sets up the final hit that knocks down the opponent.
.kickEnd:
	mMvC_ValFrameStartFast .anim
		mMvC_SetMoveV -$0100
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		jp   .anim
; --------------- frame #12 ---------------
; Transitions to the far backhop done at the end of the kicks.
.obj12:
	mMvC_ValFrameEnd .anim
		ld   a, MOVE_SHARED_LAUNCH_UB_REC
		call Pl_SetMove_StopSpeed
		mMvC_SetSpeedH -$0300 ; 3px/frame back
		mMvC_SetSpeedV -$0500 ; 5px/frame up
		jp   .ret
; --------------- common gravity check ---------------	
.doGravity:
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Allow special cancel on ground
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $13, $07
		jp   .ret
; --------------- frame #13 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Yuri_RaiOhKen ===============
; Initializes the projectile for Yuri's Rai'oh Ken (MOVE_YURI_RAI_OH_KEN_L, MOVE_YURI_RAI_OH_KEN_H)
ProjInit_Yuri_RaiOhKen:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Yuri_RaiOhKen)	; BANK $02 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Yuri_RaiOhKen)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Yuri_RaiOhKen)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Yuri_RaiOhKen)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Yuri_RaiOhKen)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Yuri_RaiOhKen)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $00

				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$1000
				mMvC_SetMoveV -$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			;

			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			cp   MOVE_YURI_RAI_OH_KEN_H		; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_YURI_RAI_OH_KEN_H		; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow			; If so, jump
		.fldLight:
			mMvC_SetSpeedH +$0100
			mMvC_SetSpeedV +$0100
			jp   .end
		.fldHeavyMaxPow:
			mMvC_SetSpeedH +$0200
			mMvC_SetSpeedV +$0180
			jp   .end
		.fldHeavy:
			mMvC_SetSpeedH +$0400
			mMvC_SetSpeedV +$0300
		.end:
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Yuri_RaiOhKen ===============
; Projectile code for Yuri's Rai'oh Ken (MOVE_YURI_RAI_OH_KEN_L, MOVE_YURI_RAI_OH_KEN_H).
; A fireball that travels diagonally down, exploding on the ground.
ProjC_Yuri_RaiOhKen:
	mMvC_StartChkFrameInt
		mMvC_ChkFrame $00, .move
		mMvC_ChkFrame $01, .move
		mMvC_ChkFrame $07, .despawn
; --------------- frames #2-6 ---------------
; Part of the ground explosion animation.
	jp   .anim
; --------------- frames #0-1 ---------------	
.move:
	; If the opponent got hit by the projectile, despawn it
	call ExOBJS_Play_ChkHitModeAndMoveH
	jp   c, .despawn
	
	; Handle the diagonal down movement.
	; When it touches the ground, switch to #2
	mMvC_ChkGravityV $0000, .explode
	
	; Force the animation to stay on frame #0.
	; As soon as we're set to #1, reset it back to #0.
	mMvC_StartChkFrameInt
		cp   $01*OBJLSTPTR_ENTRYSIZE	; On frame #1?
		jp   nz, .anim					; If not, skip
	ld   [hl], $00*OBJLSTPTR_ENTRYSIZE	; Otherwise, loop back to #0
	ret
	
.explode:
	; Switch to #2
	ld   hl, iOBJInfo_OBJLstPtrTblOffset
	add  hl, de
	ld   [hl], $02*OBJLSTPTR_ENTRYSIZE
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret
.despawn:
	call OBJLstS_Hide
	ret
	
; =============== MoveC_Kim_ThrowG ===============
; Move code for Kim's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Kim_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
; When visually switching to #2, hit the opponent.
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_MID_UB_NOSTUN, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		; And when it does, also reset the throw sequence
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== MoveC_Kim_KickHN ===============
; Move code for Kim's Near Heavy Kick (MOVE_SHARED_KICK_HN).
MoveC_Kim_KickHN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $02, .chkEnd
; --------------- frame #1 ---------------
	jp   .anim
; --------------- frame #0 ---------------
; Set damage at the end.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID1, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kim_KickHM ===============
; Move code for Kim's Far Heavy Kick (MOVE_SHARED_KICK_HM).	
MoveC_Kim_KickHM:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
; --------------- frames #0-1 ---------------
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_SetMoveH +$0400
.obj2_cont:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SFX_HEAVY
		jp   .anim
; --------------- frame #2 ---------------
.obj3:
	mMvC_ValFrameStartFast .obj3_cont
		mMvC_SetMoveH +$0600
.obj3_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj4:
	mMvC_ValFrameStartFast .obj4_cont
		mMvC_SetMoveH +$0600
.obj4_cont:
	jp   .anim
; --------------- frame #2 ---------------
.obj5:
	mMvC_ValFrameStartFast .chkEnd
		mMvC_SetMoveH +$0400
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Kim ===============
; Special move input checker for KIM.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Kim:
	mMvIn_Validate Kim, 1
	
.chkAir:
	;             SELECT + B               SELECT + A
	mMvIn_ChkEasy MoveInit_Kim_HouOuKyaku, MoveInit_Kim_HishouKyaku
	mMvIn_ChkGA Kim, 0, .chkAirKick, CHKGA_KICK
	
.chkAirKick:
	mMvIn_ValSuper .chkAirKickNoSuper
	; DBDF+K -> Hou'ou Kyaku
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Kim_HouOuKyaku
.chkAirKickNoSuper:
	; DF+K -> Hishou Kyaku
	mMvIn_ChkDir MoveInput_DF, MoveInit_Kim_HishouKyaku
	; End
	jp   MoveInputReader_Kim_NoMove
	
.chkGround:
	;             SELECT + B               SELECT + A
	mMvIn_ChkEasy MoveInit_Kim_HouOuKyaku, MoveInit_Kim_HienZan
	mMvIn_ChkGA Kim, 0, .chkKick, CHKGA_KICK
	
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; DBDF+K -> Hou'ou Kyaku
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Kim_HouOuKyaku
.chkKickNoSuper:
	; DU+K -> Hien Zan
	mMvIn_ChkDir MoveInput_DU_Charge, MoveInit_Kim_HienZan
	; BF+K -> Ryuusei Ranku
	mMvIn_ChkDir MoveInput_BF_Charge, MoveInit_Kim_RyuuseiRanku
	; DB+K -> Han Getsu Zan
	mMvIn_ChkDir MoveInput_DB, MoveInit_Kim_HanGetsuZan
	; End
	jp   MoveInputReader_Kim_NoMove
	
; =============== MoveInit_Kim_HanGetsuZan ===============
MoveInit_Kim_HanGetsuZan:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KIM_HAN_GETSU_ZAN_L, MOVE_KIM_HAN_GETSU_ZAN_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kim_MoveSet
	
; =============== MoveInit_Kim_HienZan ===============
MoveInit_Kim_HienZan:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KIM_HIEN_ZAN_L, MOVE_KIM_HIEN_ZAN_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Kim_MoveSet
	
; =============== MoveInit_Kim_HishouKyaku ===============
MoveInit_Kim_HishouKyaku:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KIM_HISHOU_KYAKU_L, MOVE_KIM_HISHOU_KYAKU_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kim_MoveSet
	
; =============== MoveInit_Kim_RyuuseiRanku ===============
MoveInit_Kim_RyuuseiRanku:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KIM_RYUUSEI_RANKU_L, MOVE_KIM_RYUUSEI_RANKU_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kim_MoveSet
	
; =============== MoveInit_Kim_HouOuKyaku ===============
MoveInit_Kim_HouOuKyaku:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_KIM_HOU_OU_KYAKU_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kim_MoveSet
	
; =============== MoveInputReader_Kim_MoveSet ===============
MoveInputReader_Kim_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Kim_NoMove ===============
MoveInputReader_Kim_NoMove:
	or   a
	ret
	
; =============== MoveC_Kim_HanGetsuZan ===============
; Move code for Kim's Han Getsu Zan (MOVE_KIM_HAN_GETSU_ZAN_L, MOVE_KIM_HAN_GETSU_ZAN_H)
MoveC_Kim_HanGetsuZan:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkGravity
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #3-4 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0600
.obj0_cont:
	mMvC_ValFrameEnd .anim
		; From the next frame, knockdown on contact
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_B
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jump speed
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_ChkMove MOVE_KIM_HAN_GETSU_ZAN_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0300
		jp   .obj1_cont
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0380
		jp   .obj1_cont
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0400
.obj1_cont:
	; Immediately go to the next frame
	mMvC_NextFrameOnGtYSpeed -$08, ANIMSPEED_NONE
	jp   .chkGravity
; --------------- common gravity check / frame #1 ---------------
.chkGravity:
	; Touching the ground switches to #2 and deals another hit
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_SetLandFrame $03, $03
		jp   .ret
; --------------- frame #3 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kim_HienZan ===============
; Move code for Kim's Hien Zan (MOVE_KIM_HIEN_ZAN_L, MOVE_KIM_HIEN_ZAN_H)
MoveC_Kim_HienZan:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		; For the gravity check
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		; Deal hit on #2
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_SetMoveH +$0800
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set high jump speed
		mMvC_ChkMove MOVE_KIM_HIEN_ZAN_H, .obj2_setJumpH
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj2_doGravity
	.obj2_setJumpH:
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj2_doGravity
	.obj2_setJumpE:
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	; Wait for past the peak of the jump before continuing
	mMvC_NextFrameOnGtYSpeed $01, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	; Force the horizontal speed of 0.25px/frame until landing on the ground
	mMvC_SetSpeedH +$0040
; --------------- common gravity check / frames #2-3 ---------------
.doGravity:
	; When landing on the ground...
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		; Switch to #4
		mMvC_SetLandFrame $04, $03
		jp   .ret
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kim_HishouKyaku ===============
; Move code for Kim's Hishou Kyaku (MOVE_KIM_HISHOU_KYAKU_L, MOVE_KIM_HISHOU_KYAKU_H)
; Dive kick.
MoveC_Kim_HishouKyaku:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameStartFast .obj0_chkGuard
		mMvC_PlaySound SCT_MOVEJUMP_A
		
		; Set the dive speed
		mMvC_ChkMove MOVE_KIM_HISHOU_KYAKU_H, .obj0_setJumpH
	.obj0_setJumpL: ; Light
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV +$0100
		jp   .obj0_doGravity
	.obj0_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj0_setJumpE
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV +$0200
		jp   .obj0_doGravity
	.obj0_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV +$0300
	.obj0_doGravity:
		jp   .doGravity
.obj0_chkGuard:
	;
	; Continue the dive until hitting the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]			; Did we reach?
	jp   z, .obj0_chkGuard_doGravity	; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj0_chkGuard_doGravity	; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj0_chkGuard_doGravity	; If not, skip	
	
	; Otherwise, deal damage to the opponent, and start the loop.
	.obj0_chkGuard_noGuard:
		mMvC_SetDamageNext $01, HITTYPE_HIT_MID1, PF3_CONTHIT
		mMvC_SetFrame $01, $00
		jp   .ret
.obj0_chkGuard_doGravity:
	jp   .doGravity
; --------------- frame #1 ---------------
; Damage loop #1
.obj1:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_CONTHIT
		jp   .doGravity
; --------------- frame #2 ---------------
; Damage loop #2
.obj2:
	mMvC_ValFrameEnd .doGravity
		; If we didn't touch the ground yet by the end of #2, loop back to #1
		mMvC_SetDamageNext $01, HITTYPE_HIT_MID1, PF3_CONTHIT
		mMvC_SetFrameOnEnd $01
		jp   .doGravity
; --------------- common gravity check / frames #0-2 ---------------
.doGravity:
	; When touching the ground, continue to #3
	mMvC_ChkGravityHV $0018, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $03, $05
		jp   .ret
; --------------- frame #3 ---------------
; Recovery
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kim_RyuuseiRanku ===============
; Move code for Kim's Ryuusei Ranku (MOVE_KIM_RYUUSEI_RANKU_L, MOVE_KIM_RYUUSEI_RANKU_H)
; Dash, then jump kick that hits on the way up and the way down.	
MoveC_Kim_RyuuseiRanku:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .doGravity
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #0 ---------------
; Forwards dash
.obj0:
	mMvC_ValFrameStartFast .obj0_chkGuard
		mMvC_PlaySound SCT_MOVEJUMP_A
		
		; Set forwards dash speed
		mMvC_ChkMove MOVE_KIM_RYUUSEI_RANKU_H, .obj0_setDashH
		mMvC_SetSpeedH +$0500
		jp   .obj0_anim
	.obj0_setDashH:
		mMvC_ChkMaxPow .obj0_setDashE
		mMvC_SetSpeedH +$0600
		jp   .obj0_anim
	.obj0_setDashE:
		mMvC_SetSpeedH +$0700
	.obj0_anim:
		jp   .anim
.obj0_chkGuard:

	;
	; Continue the forwards dash until hitting the opponent, slowing down at 0.25px/frame.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]		; Did we reach?
	jp   z, .obj0_chkGuard_moveH	; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]			; Is the opponent invulnerable?
	jp   nz, .obj0_chkGuard_moveH	; If so, skip
	bit  PF1B_HITRECV, [hl]			; Did the opponent get hit?
	jp   z, .obj0_chkGuard_moveH	; If not, skip	
	
	jp   .obj0_chkGuard_noGuard
	
.obj0_chkGuard_moveH:
	; Do the movement
	mMvC_ChkFrictionH $0040, .anim
	; If we got here, by the time we stopped we still didn't hit the opponent.
	; Nothing special happens in this case, it just does the jump as normal.
	
	.obj0_chkGuard_noGuard:
		; We made contact.
		; Immediately switch to the next frame by resetting the counter and setting ANIMSPEED_INSTANT.
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		jp   .anim
; --------------- frame #1 ---------------
; Prepare for jumpkick.
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		; This jumpkick drops the opponent directly down, only hitting once
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
; Jumpkick up.
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_SetMoveH +$0800
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set jump settings
		mMvC_ChkMove MOVE_KIM_RYUUSEI_RANKU_H, .obj2_setJumpH
	.obj2_setJumpL: ; Light
		mMvC_SetSpeedH +$0180
		mMvC_SetSpeedV -$0500
		jp   .obj2_doGravity
	.obj2_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0500
		jp   .obj2_doGravity
	.obj2_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0280
		mMvC_SetSpeedV -$0500
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	; Immediately go to the next frame (YSpeed always > -$06)
	mMvC_NextFrameOnGtYSpeed -$06, ANIMSPEED_NONE
	jp   .doGravity
; --------------- common gravity check / frames #2-3 ---------------
; Jumpkick down on #3
.doGravity:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		; Switch to #4
		mMvC_SetLandFrame $04, $05
		jp   .ret
; --------------- frame #4 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kim_HouOuKyaku ===============
; Move code for Kim's Hou Ou Kyaku (MOVE_KIM_HOU_OU_KYAKU_S)
; Loads of kicks that transition to Hien Zan.
MoveC_Kim_HouOuKyaku:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .setDamageStart
		mMvC_ChkFrame $04, .setDamage0
		mMvC_ChkFrame $06, .setDamage0
		mMvC_ChkFrame $08, .setDamage0
		mMvC_ChkFrame $0A, .setDamage0
		mMvC_ChkFrame $0C, .setDamage0
		mMvC_ChkFrame $0E, .setDamage0
		mMvC_ChkFrame $0F, .toHienZan
		mMvC_ChkFrame $10, .chkEnd
	jp   .setDamage1
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
; Fast hop forwards.
.obj1:
	; Set the jump speed the first time we get here
	mMvC_ValFrameStartFast .obj1_chkGuard
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$07FF
		mMvC_SetSpeedV -$0200
		jp   .chkGravity
.obj1_chkGuard:
	;
	; Continue the jump until hitting the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]			; Did we reach?
	jp   z, .obj1_chkGuard_doGravity	; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj1_chkGuard_doGravity	; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj1_chkGuard_doGravity	; If not, skip	
	
	;
	; Significantly slow down if the opponent is blocking
	;
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .obj1_chkGuard_slowdown	; If so, jump
	
	.obj1_chkGuard_noGuard:
		; Otherwise, continue to #2
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetFrame $02, $01
		mMvC_SetSpeedH $0000
		; Align to floor
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
		jp   .ret
		
.obj1_chkGuard_slowdown:
	mMvC_SetSpeedH +$0100
	
.obj1_chkGuard_doGravity:
	jp   .chkGravity
	
; --------------- odd frames #3,5,7,9,B ---------------
.setDamage1:
	mMvC_ValFrameStartFast .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		jp   .chkOtherEscape
; --------------- initial damage frame / frame #2 ---------------
.setDamageStart:
	mMvC_ValFrameStartFast .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		jp   .anim
; --------------- even frames #4,6,8,A,E ---------------
.setDamage0:
	mMvC_ValFrameStartFast .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
; --------------- common escape check ---------------
.chkOtherEscape:
	;
	; [POI] If the opponent somehow isn't in one of the hit effects 
	;       this move sets, hop back instead of continuing.
	;       This can happen if the opponent gets hit by a previously thrown
	;       fireball in the middle of the move.
	;
	ld   hl, iPlInfo_HitTypeIdOther
	add  hl, bc
	ld   a, [hl]
	cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
	jp   z, .anim			; If so, skip
	cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
	jp   z, .anim			; If so, skip
		; Otherwise, transition to backjump
		ld   a, MOVE_SHARED_HOP_B
		call Pl_SetMove_StopSpeed
		jp   .ret
; --------------- final damage frame / frame #F ---------------
.toHienZan:
	; Success, transition to the new move when the frame ends.
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		ld   a, MOVE_KIM_HIEN_ZAN_H
		call MoveInputS_SetSpecMove_StopSpeed
		jp   .ret
; --------------- common gravity check / frame #1 ---------------
.chkGravity:
	; Touching the ground at any point during the initial forward jump switches to #10.
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $10, $07
		jp   .ret
; --------------- frame #10 ---------------
; Move whiffed, recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== END OF BANK ===============
; Junk area below
IF VER_EN
	mIncJunk "L027E1A"
ELSE
	mIncJunk "L027E11"
ENDC