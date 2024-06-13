; =============== MoveC_Hit_PostStunKnockback ===============
; Move handler for ground knockback.
;
; Because this only displays one single animation frame, it has different timing logic from other moves.
; Instead of going off the animation timer (iOBJInfo_OBJLstPtrTblOffsetView), this goes
; off the frame timer (iOBJInfo_FrameLeft) which ticks down.
; Because of this, .anim is only used to decrement iOBJInfo_FrameLeft.
;
; Handler for:
; - MOVE_SHARED_POST_BLOCKSTUN (hit type: HitTypeC_Blocked)
; - MOVE_SHARED_HIT0MID (hit type: HitTypeC_HitMid0)
; - MOVE_SHARED_HIT1MID (hit type: HitTypeC_HitMid1)
; - MOVE_SHARED_HITLOW (hit type: HitTypeC_HitLow)
MoveC_Hit_PostStunKnockback:
	; Deliver knockback to the opponent, if needed
	call Play_Pl_GiveKnockbackCornered
	; No collision box overlapping allowed
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Equivalent to mMvC_ValLoaded for a single frame
	call OBJLstS_IsGFXLoadDone
	jp   nz, .anim
	
	; Depending on the how many frames are left...
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]
	cp   $00			; iOBJInfo_FrameLeft == $00? (last frame)
	jp   z, .chkEnd		; If so, jump
	cp   $01			; iOBJInfo_FrameLeft != $01?
	jp   nz, .anim		; If so, jump (iOBJInfo_FrameLeft--)
	
; --------------- second to last subframe ---------------
.setKnockbackSpeed:
	; Manually reset back iOBJInfo_FrameLeft to $00, since we're not calling .anim (even though we could have if we really wanted).
	ld   [hl], $00
	
	; Setup the knockback speed, depending on how long we have shaken.
	;
	; The direction here is relative to the internal flip flag, since it's
	; not affected by the visual PF1B_XFLIPLOCK (see Play_CalcPlDistanceAndXFlip)
	; and we always want to move away from the opponent.
	;
	; For some reason, this is relative to the player facing *left* (2P side),
	; so moving to the right moves the player back.
	
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Was this an heavy hit?
	jp   nz, .setSpeedFast		; If so, jump
.setSpeedNorm:
	ld   hl, $0280				; Otherwise HL = $02.80px/frame (short)
	jp   .setSpeed
.setSpeedFast:
	ld   hl, $0400				; HL = $04px/frame (long)
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	jp   .ret
; --------------- last subframe ---------------
.chkEnd:
	; Slow down at $00.40px/frame, and end the move when we stop moving.
	; This doesn't call .anim, preventing iOBJInfo_FrameLeft from resetting back to iOBJInfo_FrameTotal.
	mMvC_ChkFrictionH $0040, .ret
		call Play_Pl_EndMove
; --------------- common ---------------
.ret:
	ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
	
; =============== MoveC_Hit_Launch_Generic ===============
; Continuation code for the a generic launch/throw arc without mid-air recovery.
; Handler for:
; - MOVE_SHARED_LAUNCH_UB (hit type: HitTypeC_LaunchHighUB)
MoveC_Hit_Launch_Generic:
	call Play_Pl_MoveByColiBoxOverlapX
	; [POI] Missing wait
	;mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	; Startup #1.
	mMvC_ValFrameEnd .doGravity_preRebound
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity_preRebound
; --------------- frame #1 ---------------
.obj1:
	; Startup #2.
	jp   .doGravity_preRebound
; --------------- frame #2 ---------------
; Pre-rebound frame.
.obj2:
	; Set manual control for #3
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #3 ---------------
; Rebounding off the ground.
.obj3:
	; At the start of the frame, set the jump speed for the rebound.
	mMvC_ValFrameStartFast .obj3_cont
		
		;--
		;
		; Cut in half the horizontal speed.
		; iOBJInfo_SpeedX /= 2
		;
		push bc
			ld   hl, iOBJInfo_SpeedX
			add  hl, de		; Seek to iOBJInfo_SpeedX
			ld   b, [hl]	; B = iOBJInfo_SpeedX
			inc  hl			; Seek to iOBJInfo_SpeedXSub
			ld   c, [hl]	; C = iOBJInfo_SpeedXSub
			push bc			; Move to HL
			pop  hl
		pop  bc
		sra  h				; HL >> 1
		rr   l
		call Play_OBJLstS_SetSpeedH	; Set the horizontal speed to that
		;--
		mMvC_SetSpeedV -$0300	; 3px/frame up
		jp   .doGravity_postRebound
.obj3_cont:
	jp   .doGravity_postRebound
; --------------- frames #0-1 / common gravity check, before rebound ---------------	
; Gravity check used for the pre-rebound frames, before the player touches the ground the first time.
; During these frames, the player is vulnerable and can be combo'd off.
;
; As soon as we touch the ground, we are set as invulnerable and can't be hit again until we wake up.
;
; In 96, this also checked for roll inputs, which don't exist here.
.doGravity_preRebound:
	; When we touch the ground (the first time)...
	mMvC_ChkGravityHV $0060, .anim
		
		; Use frame #2 when landing on the ground.
		mMvC_SetLandFrame $02, $05
		
		; When bouncing on the ground, we are completely invulnerable
		; Can't be hit until we get up
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		set  PF1B_INVULN, [hl]
		
		; Stop flashing
		ld   hl, iPlInfo_Flags3
		add  hl, bc
		res  PF3B_FIRE, [hl]
		res  PF3B_SUPERALT, [hl]
		jp   .ret
; --------------- frame #3, common gravity check, after rebound ---------------	
.doGravity_postRebound:
	; When touching the ground after the rebound, play the drop SFX and switch to #4
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $04, $05
		jp   .ret
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_StartWakeUp
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Hit_Launch_Shake ===============
; Pratically identical to MoveC_Hit_Launch_Generic, except the screen shakes
; when the player hits the ground.
; Handler for:
; - MOVE_SHARED_LAUNCH_DB_SHAKE (hit type: HitTypeC_LaunchFastDB)
; - MOVE_SHARED_LAUNCH_UB_SHAKE (hit type: HitTypeC_LaunchMidUB_NoStun)
MoveC_Hit_Launch_Shake:
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	; Do nothing but handle gravity.
	jp   .doGravity_preRebound
; --------------- frame #1 ---------------
; Frame when hitting the ground.
.obj1:
	; Shake the screen when the ground is hit
	call Play_Pl_DoGroundScreenShake
	mMvC_ValFrameEnd .anim
		; Set manual control for #2
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		; Stop shaking when we leave the ground
		xor  a
		ld   [wScreenShakeY], a
		jp   .anim
; --------------- frame #2 ---------------
; Rebounding off the ground. Identical to version in MoveC_Hit_Launch_Generic.
.obj2:
	; At the start of the frame, set the jump speed for the rebound.
	mMvC_ValFrameStartFast .obj2_cont
		;--
		;
		; Cut in half the horizontal speed.
		; iOBJInfo_SpeedX /= 2
		;
		push bc
			ld   hl, iOBJInfo_SpeedX
			add  hl, de		; Seek to iOBJInfo_SpeedX
			ld   b, [hl]	; B = iOBJInfo_SpeedX
			inc  hl			; Seek to iOBJInfo_SpeedXSub
			ld   c, [hl]	; C = iOBJInfo_SpeedXSub
			push bc			; Move to HL
			pop  hl
		pop  bc
		sra  h				; HL >> 1
		rr   l
		call Play_OBJLstS_SetSpeedH	; Set the horizontal speed to that
		;--
		mMvC_SetSpeedV -$0300	; 3px/frame up
		jp   .doGravity_afterRebound
.obj2_cont:
	jp   .doGravity_afterRebound
; --------------- frame #0 / common gravity check ---------------
; Before hitting the ground the first time...
.doGravity_preRebound:
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $01, $09
		
		; End the damage string when touching the ground
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		set  PF1B_INVULN, [hl]
	
		mMvC_PlaySound SCT_GROUNDHIT
		
		; Stop flashing as well
		ld   hl, iPlInfo_Flags3
		add  hl, bc
		res  PF3B_FIRE, [hl]
		res  PF3B_SUPERALT, [hl]
		jp   .ret
; --------------- frame #2 / common gravity check ---------------
; After we rebounded once...
.doGravity_afterRebound:
	; Handle gravity
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $03, $05
		jp   .ret
; --------------- frame #3 ---------------
.chkEnd:
	; Wake up at the end of the frame
	mMvC_ValFrameEnd .anim
		call Play_Pl_StartWakeUp
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Hit_Launch_SwoopUp ===============
; Continuation code for hits that launch the player upwards.
;
; This handles both the projectile and throw versions.
;
; The command throw version doesn't do anything special, but the projectile one toggles
; the invulnerability flag off to deal multiple hits and move the player upwards as long as 
; the tall projectile is still active.
; 
; Disabling invulnerability immediately resets the move because the player is always overlapping
; a very tall projectile that doesn't despawn on hit. When the hit registers, it will end up
; restarting this move.
;
; Note that the hit code at HitTypeC_Launch_SwoopUp marks the player as invulnerable before the 
; move can start, and it only gets enabled when attempting to move into the frame for downwards
; movement.
;
; Handler for:
; - MOVE_SHARED_LAUNCH_SWOOPUP (hit type: HitTypeC_Launch_SwoopUp)
MoveC_Hit_Launch_SwoopUp:
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
		mMvC_ChkFrame $06, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Upwards movement - frame #0.
.obj0:
	; Apply $00.30px/frame gravity while moving up.
	ld   hl, iOBJInfo_SpeedY
	add  hl, de
	ld   a, [hl]
	bit  7, a				; SpeedY < 0? (MSB set)
	jp   nz, .doGravity0030	; If so, jump
.obj0_onDown:	
	; Immediately switch to #3 and apply $00.60px/frame gravity if we start moving down.
	; This skips the looping logic in #1.
	mMvC_SetFrameOnEnd $03
	jp   .doGravity0060
; --------------- frame #1 ---------------
; Upwards movement - frame #1.
.obj1:
	ld   hl, iOBJInfo_SpeedY
	add  hl, de
	ld   a, [hl]
	bit  7, a				; SpeedY < 0? (MSB set)
	jp   nz, .obj1_onUp		; If so, jump
.obj1_onDown:
	; Immediately switch to #3 and apply $00.60px/frame gravity if we start moving down.
	; Like with #0.
	mMvC_SetFrameOnEnd $03
	jp   .doGravity0060
.obj1_onUp:
	mMvC_ValFrameEnd .doGravity0030
		; The non-projectile (Ralf) version consistently avoids touching PF1B_INVULN.
		ld   hl, iPlInfo_CharIdOther
		add  hl, bc
		ld   a, [hl]
		cp   CHAR_ID_RALF		; Opponent is Ralf?
		jp   nz, .obj1_onUpProj	; If not, skip
	.obj1_onUpRalf:
		; Play SFX
		mMvC_PlaySound SFX_LIGHT
		jp   .obj1_switchTo0
	.obj1_onUpProj:
		; Allow next hit to happen.
		; If the projectile is still active, this will reset the move and continue the upwards movement.
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		res  PF1B_INVULN, [hl]
	.obj1_switchTo0:
		; Force animation to loop back to #0 regardless, for the non-projectile one.
		mMvC_SetFrameOnEnd $06+1 ; Force anim code to loop to 0
		jp   .doGravity0030
; --------------- frame #2 ---------------
; Downwards movement - loop frame #0.
.obj2:
	; For Ralf's command throw, disable invulnerability with the higher gravity.
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RALF		; Opponent is Ralf?
	jp   nz, .doGravity0060	; If not, skip
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	res  PF1B_INVULN, [hl]	; Otherwise, disable invuln first
	jp   .doGravity0060
; --------------- frame #3 ---------------
; Downwards movement - loop frame #1.
.obj3:
	; For Ralf's command throw, disable invulnerability with the higher gravity.
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RALF			; Opponent is Ralf?
	jp   nz, .obj3_chkLoop		; If not, skip
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	res  PF1B_INVULN, [hl]		; Otherwise, disable invuln first
.obj3_chkLoop:
	; Loop back to #2 if we haven't touched the ground by the time this frame ended
	mMvC_ValFrameEnd .doGravity0060
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de
		ld   [hl], $01*OBJLSTPTR_ENTRYSIZE ; offset by -1
		jp   .doGravity0060
; --------------- frame #4 ---------------
; Ground touched - screen shake effect, speed reset.
.obj4:
	call Play_Pl_DoGroundScreenShake
	mMvC_ValFrameEnd .anim
		; Get manual control for #5.
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #5 ---------------
; Rebounding off the ground.
.obj5:
	; At the start of the frame, set the jump speed for the rebound.
	; This is like what MoveC_Hit_Launch_Generic does.
	mMvC_ValFrameStartFast .obj5_cont
	
		;--
		;
		; Cut in half the horizontal speed.
		; iOBJInfo_SpeedX /= 2
		;
		push bc
			ld   hl, iOBJInfo_SpeedX
			add  hl, de		; Seek to iOBJInfo_SpeedX
			ld   b, [hl]	; B = iOBJInfo_SpeedX
			inc  hl			; Seek to iOBJInfo_SpeedXSub
			ld   c, [hl]	; C = iOBJInfo_SpeedXSub
			push bc			; Move to HL
			pop  hl
		pop  bc
		sra  h				; HL >> 1
		rr   l
		call Play_OBJLstS_SetSpeedH	; Set the horizontal speed to that
		;--
		
		;
		; Unlike MoveC_Hit_Launch_Generic, this doesn't use a fixed vertical speed.
		; The new vertical speed is calculated from:
		; iOBJInfo_SpeedY = -(OkSpeedY/2) - $04
		;
		; Use iPlInfo_Hit_SwoopUp_OkSpeedY since that's the last valid speed value
		; from before touching the ground.
		ld   hl, iPlInfo_Hit_SwoopUp_OkSpeedY
		add  hl, bc
		ld   a, [hl]	; A = Orig Y Speed
		sra  a			; Cut it in half
		add  a, $04		; Add 4
		cpl				; Invert it from positive to negative, since we're moving up
		inc  a
		ld   h, a		; Set that as number of pixels
		ld   l, $FF		; and $FF as subpixels
		call Play_OBJLstS_SetSpeedV
		
		jp   .doGravityToChkEnd
.obj5_cont:
	jp   .doGravityToChkEnd
	
; -------------------------------------------------------------------
; --------------- frames #0-3 / common gravity checks ---------------	
; -------------------------------------------------------------------
; Two different entry points to the gravity function are used, depending on
; the direction we're moving vertically.
;
; - $00.30px/frame gravity is applied when moving up.
; - $00.60px/frame gravity is applied when moving down.
;   This also makes the player invulnerable for projectile-based hits. (read: not hit by Ralf)
;

; --------------- .doGravity0030 ---------------
; Applies gravity at $00.30px/frame.
.doGravity0030:
	;--
	; [TCRF] It looks like this originally applied a significant amount of negative gravity.
	;        This would have made the upwards movement much faster... but it also the breaks downwards movement,
	ld   hl, -$0200		
	;--
	ld   hl, +$0030		; HL = $00.30px/frame gravity
	jp   .doGravityByHL
; --------------- .doGravity0060 ---------------
; Applies gravity at $00.60px/frame.
.doGravity0060:
	; Really make sure the player is invulnerable if we're doing the projectile version
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RALF			; iPlInfo_CharIdOther == CHAR_ID_RALF?
	jp   z, .doGravity0060_main	; If so, skip
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]		; Otherwise, enable invuln
.doGravity0060_main:
	ld   hl, $0060				; HL = $00.60px/frame gravity
	; Fall-through
	
; --------------- .doGravityByHL ---------------
; Handles gravity and moves the player.
; IN
; - HL: Gravity to apply
.doGravityByHL:

	;
	; Always save a copy of the current Y Speed.
	; This is because iOBJInfo_SpeedY gets erased when touching the ground (#4), 
	; and in #5 we need to rebound at a speed relative to it.
	;
	push hl
		ld   hl, iOBJInfo_SpeedY
		add  hl, de
		ld   a, [hl]		; A = Y Speed		
		ld   hl, iPlInfo_Hit_SwoopUp_OkSpeedY
		add  hl, bc			; Seek to backup field
		ld   [hl], a		; Copy it there
	pop  hl
	
	;
	; Apply HL gravity and move in both directions.
	; In case of the projectile version of the hit, our H Speed will be 0.
	;
	; When touching the ground, switch to #4.
	;
	call OBJLstS_ApplyGravityVAndMoveHV	; Did we touch the ground?
	jp   nc, .anim						; If not, jump
		mMvC_SetLandFrame $04, $0B	; Set the next frame
		
		; Play a sound effect for hitting the ground
		mMvC_PlaySound SCT_GROUNDHIT
		
		; Turn invulnerability on to end the damage string
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		set  PF1B_INVULN, [hl]
		
		; Stop flashing the opponent as well
		ld   hl, iPlInfo_Flags3
		add  hl, bc
		res  PF3B_FIRE, [hl]
		res  PF3B_SUPERALT, [hl]
		jp   .ret
; --------------- frame #5 / gravity check ---------------
.doGravityToChkEnd:
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $06, $05
		jp   .ret
; --------------- frame #6 ---------------
; Wake up when the frame ends.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_StartWakeUp
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Hit_Sweep ===============
; Continuation code for sweeps (crouching heavy kicks).
;
; This causes the player to be knocked back with a jump, with settings previously
; set in HitTypeC_Sweep.
; Shouldn't be used on player death even though it's "compatible" with it.
;
; Handler for:
; - MOVE_SHARED_HIT_SWEEP (hit type: HitTypeC_Sweep)
MoveC_Hit_Sweep:
	call Play_Pl_MoveByColiBoxOverlapX
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	; Get manual control for #1
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- frame #1 ---------------
.obj1:
	jp   .doGravity
; --------------- common gravity check ---------------
.doGravity:
	; Switch to #2 when landing on the ground
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $02, $05
		; Stop flashing
		ld   hl, iPlInfo_Flags3
		add  hl, bc
		res  PF3B_FIRE, [hl]
		res  PF3B_SUPERALT, [hl]
		jp   .ret
; --------------- frame #2 ---------------
.chkEnd:
	; The knockback ends when the frame ends
	mMvC_ValFrameEnd .anim
		call Play_Pl_StartWakeUp
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Hit_Launch_RecA ===============
; Move code for a generic backjump with air recovery.
; 
; This is used for:
; - The continuation code for getting hit by a normal in the air by HitTypeC_HitA (MOVE_SHARED_LAUNCH_UB_REC)
; - The backjump for several special moves that can transition to this
;
; Since the player recovers mid-air, it can't be used with player death.
;
; Handler for:
; - MOVE_SHARED_LAUNCH_UB_REC (hit type: HitTypeC_HitA)
MoveC_Hit_Launch_RecA:
	call Play_Pl_MoveByColiBoxOverlapX
	;mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .setManCtrl
		mMvC_ChkFrame $01, .waitM07
		mMvC_ChkFrame $02, .waitM05
		mMvC_ChkFrame $03, .waitM01
		mMvC_ChkFrame $04, .waitP01
		mMvC_ChkFrame $05, .doGravity
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #0 ---------------
; Set manual control at the end of the frame.
.setManCtrl:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- frame #1 ---------------
; Wait for YSpeed > -$07 before continuing to #2.
.waitM07:
	mMvC_NextFrameOnGtYSpeed -$07, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #2 ---------------
.waitM05:
	mMvC_NextFrameOnGtYSpeed -$05, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------
.waitM01:
	mMvC_NextFrameOnGtYSpeed -$01, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #4 ---------------
.waitP01:
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frames #0-5 / common gravity check ---------------
.doGravity:
	; Switch to #6 when touching the ground
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $06, ANIMSPEED_INSTANT
		jp   .ret
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
; =============== MoveC_Hit_MultiMidKnockback ===============
; Continuation code for hits in the middle of a ground-based special move that hits multiple times.
;
; In practice, this is identical to MoveC_Hit_PostStunKnockback except that, with Kensou, the player drops on the ground at the end.
;
; Like that move, it uses the frame timer since the player doesn't animate.
;
; Handler for: 
; - MOVE_SHARED_HIT_MULTIMID0 (hit type: HitTypeC_Hit_Multi0)
; - MOVE_SHARED_HIT_MULTIMID1 (hit type: HitTypeC_Hit_Multi1)
MoveC_Hit_MultiMidKnockback:
	; Deliver knockback to the opponent, if needed
	call Play_Pl_GiveKnockbackCornered
	; This shouldn't be needed
	;mMvC_ValLoaded .ret
	; Equivalent to mMvC_ValLoaded for a single frame
	call OBJLstS_IsGFXLoadDone
	jp   nz, .anim
	
	; Depending on the how many frames are left...
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]
	cp   $00					; iOBJInfo_FrameLeft == $00? (last frame)
	jp   z, .chkEnd				; If so, jump
	cp   $01					; iOBJInfo_FrameLeft == $01?
	jp   z, .setKnockbackSpeed	; If so, jump
	; Otherwise, tick down iOBJInfo_FrameLeft
	jp   .anim
; --------------- second to last subframe ---------------
.setKnockbackSpeed:
	; Manually reset back iOBJInfo_FrameLeft to $00, since we're not calling .anim (even though we could have if we really wanted).
	ld   [hl], $00
	
	; Setup the knockback speed, depending on how long we have shaken.
	;
	; The direction here is relative to the internal flip flag, since it's
	; not affected by the visual PF1B_XFLIPLOCK (see Play_CalcPlDistanceAndXFlip)
	; and we always want to move away from the opponent.
	;
	; For some reason, this is relative to the player facing *left* (2P side),
	; so moving to the right moves the player back.
	
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Was this an heavy hit?
	jp   nz, .setSpeedFast		; If so, jump
.setSpeedNorm:
	ld   hl, $0280				; Otherwise HL = $02.80px/frame (short)
	jp   .setSpeed
.setSpeedFast:
	ld   hl, $0400				; HL = $04px/frame (long)
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	; If we're on the ground, we can proceed to .chkEnd from the next frame
	; to first handle the knockback, and only drop on the ground when we stop moving.
	
	; If we're in the air though, drop down immediately using the just set speed settings.
	; This is to account for character-specific checks inside HitTypeS_MovePlToOpFront that
	; override the default behaviour of forcing the player on the ground.
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   a, [hl]			; A = Y Pos
	cp   PL_FLOOR_POS		; A == PL_FLOOR_POS?
	jp   nz, .switchToDrop	; If not, jump
	
	jp   .ret
; --------------- last subframe ---------------
.chkEnd:
	; Slow down at $00.40px/frame, and return to the idle move when we stop moving.
	; This doesn't call .anim, preventing iOBJInfo_FrameLeft from resetting back to iOBJInfo_FrameTotal.
	mMvC_ChkFrictionH $0040, .ret
		; If we got hit by Kensou, and the hit didn't KO us, switch to the drop move.
		; This is because Kensou exclusively uses this hit type to end his ground throw,
		; which needs the opponent to drop on the ground.
		; (In 96, this became the standard behaviour)
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a					; No health left?
		jp   z, .switchToDrop	; If so, skip
		
		ld   hl, iPlInfo_CharIdOther
		add  hl, bc
		ld   a, [hl]			; A = Opponent CharId
		cp   CHAR_ID_KENSOU		; Opponent is Kensou?
		jp   nz, .end			; If not, jump (return to the idle mode)
		
		jp   .switchToDrop
		
.switchToDrop:
	ld   a, MOVE_SHARED_LAUNCH_UB
	call Pl_SetMove_StopSpeed
	jp   .ret
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
.ret:
	ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
	
; =============== MoveC_Hit_GrabNoSync ===============
; Continuation code for grab frames that don't sync the player position in the middle of the move,
; so they can't be used if the opponent is moving.
; Reworked into MoveC_Hit_Throw_Rot in 96, which was made less hardcoded.
;
; Handler for:
; - HITTYPE_GRAB_UB_NOSYNC (hit type: HitTypeC_Grab_UB_NoSync)
; - HITTYPE_GRAB_FG_NOSYNC (hit type: HitTypeC_Grab_FG_NoSync)
MoveC_Hit_GrabNoSync:
	call Play_Pl_GiveKnockbackCornered
	
	; Equivalent to mMvC_ValLoaded for a single frame
	call OBJLstS_IsGFXLoadDone
	jp   nz, .anim
	
	; [POI] iOBJInfo_FrameLeft is initially set at ANIMSPEED_NONE when we get here.
	;       It should never elapse, but in case it does, depending on the how many frames are left...
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]
	cp   $00
	jp   z, .chkEnd
	cp   $01
	jp   nz, .anim
	
; --------------- second to last subframe ---------------
;
; Fallback similar to the one in MoveC_Hit_MultiMidKnockback.
;
.setKnockbackSpeed:
	; Manually reset back iOBJInfo_FrameLeft to $00, since we're not calling .anim (even though we could have if we really wanted).
	ld   [hl], $00
	
	; Setup the knockback speed, depending on how long we have shaken.
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Was this an heavy hit?
	jp   nz, .setSpeedFast		; If so, jump
.setSpeedNorm:
	ld   hl, $0280				; Otherwise HL = $02.80px/frame (short)
	jp   .setSpeed
.setSpeedFast:
	ld   hl, $0400				; HL = $04px/frame (long)
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	; If we're on the ground, we can proceed to .chkEnd from the next frame
	; to first handle the knockback, and only drop on the ground when we stop moving.
	; If we're in the air though, drop down immediately using the just set speed settings.
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   a, [hl]			; A = Y Pos
	cp   PL_FLOOR_POS		; A == PL_FLOOR_POS?
	jp   nz, .switchToDrop	; If not, jump
	
	jp   .ret
; --------------- last subframe ---------------
.chkEnd:
	; Slow down at $00.40px/frame, and switch to the drop move when we stop moving.
	; This doesn't call .anim, preventing iOBJInfo_FrameLeft from resetting back to iOBJInfo_FrameTotal.
	mMvC_ChkFrictionH $0040, .ret
		; If we died, just end the move.
		; Hopefully we are on the ground when this happens.
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a				; No health left?
		jp   nz, .end		; If so, jump
.switchToDrop:
	ld   a, MOVE_SHARED_LAUNCH_UB
	call Pl_SetMove_StopSpeed
	jp   .ret
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
.ret:
	ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
	
; =============== MoveC_Hit_GrabSync ===============
; Continuation code for grab frames when the opponent can move during the throw.
; Accomplished by always updating the player position while the move is executed,
; instead of leaving it only to the hit code (aka, at the start of the move).
; Reworked into MoveC_Hit_Throw_Rot in 96, which was made less hardcoded.
;
; Handler for:
; - HITTYPE_GRAB_UB_SYNC (hit type: HitTypeC_Grab_UB_Sync)
MoveC_Hit_GrabSync:
	call Play_Pl_GiveKnockbackCornered
	
	; Equivalent to mMvC_ValLoaded for a single frame
	call OBJLstS_IsGFXLoadDone
	jp   nz, .syncPos
	
	; [POI] iOBJInfo_FrameLeft is initially set at ANIMSPEED_NONE when we get here.
	;       It should never elapse, but in case it does, depending on the how many frames are left...
	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]
	cp   $00
	jp   z, .chkEnd
	cp   $01
	jp   z, .setKnockbackSpeed
	
.syncPos:
	;
	; Force the player to be:
	; - 4px in front of the opponent
	; - At the same Y position as the opponent...
	;   ...unless we're being held off the ground by Rugal during one of his moves that
	;      hold the opponent forward (God Press and Gigantic Pressure)
	;
	; These should be consistent with the ones specified in the hit handler at MoveC_Hit_GrabSync,
	; but only the Y position is.
	;
	
	; X Position
	call HitTypeS_SyncPlPosFromOtherPos
	mMvC_SetMoveH -$0400 ; 4px behind, which increases the distance to the opponent
	
	; Y Position
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_RUGAL					; Opponent is RUGAL?
	jp   nz, .sameY						; If not, jump
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]						; Opponent is performing...
	cp   MOVE_RUGAL_GOD_PRESS_L			; God Press?
	jp   z, .upY						; If so, jump
	cp   MOVE_RUGAL_GOD_PRESS_H			; ""
	jp   z, .upY						; ""
	cp   MOVE_RUGAL_GIGANTIC_PRESSURE_S	; Gigantic Pressure?
	jp   z, .upY						; If so, jump

	jp   .sameY							; Otherwise, use the same Y pos

.upY:
	mMvC_SetMoveV -$1000				; 16px above
.sameY:
	jp   .anim

; --------------- second to last subframe ---------------
;
; Fallback similar to the one in MoveC_Hit_MultiMidKnockback.
; (and identical to the one in MoveC_Hit_GrabNoSync)
;
.setKnockbackSpeed:
	; Manually reset back iOBJInfo_FrameLeft to $00, since we're not calling .anim (even though we could have if we really wanted).
	ld   [hl], $00
	
	; Setup the knockback speed, depending on how long we have shaken.
	ld   hl, iPlInfo_Flags3
	add  hl, bc
	bit  PF3B_HEAVYHIT, [hl]	; Was this an heavy hit?
	jp   nz, .setSpeedFast		; If so, jump
.setSpeedNorm:
	ld   hl, $0280				; Otherwise HL = $02.80px/frame (short)
	jp   .setSpeed
.setSpeedFast:
	ld   hl, $0400				; HL = $04px/frame (long)
.setSpeed:
	call Play_OBJLstS_SetSpeedH_ByXDirL
	
	; If we're on the ground, we can proceed to .chkEnd from the next frame
	; to first handle the knockback, and only drop on the ground when we stop moving.
	; If we're in the air though, drop down immediately using the just set speed settings.
	ld   hl, iOBJInfo_Y
	add  hl, de
	ld   a, [hl]			; A = Y Pos
	cp   PL_FLOOR_POS		; A == PL_FLOOR_POS?
	jp   nz, .switchToDrop	; If not, jump
	
	jp   .ret
; --------------- last subframe ---------------
.chkEnd:
	; Slow down at $00.40px/frame, and switch to the drop move when we stop moving.
	; This doesn't call .anim, preventing iOBJInfo_FrameLeft from resetting back to iOBJInfo_FrameTotal.
	mMvC_ChkFrictionH $0040, .ret
		; If we died, just end the move.
		; Hopefully we are on the ground when this happens.
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]
		or   a				; No health left?
		jp   nz, .end		; If so, jump
.switchToDrop:
	ld   a, MOVE_SHARED_LAUNCH_UB
	call Pl_SetMove_StopSpeed
	jp   .ret
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
.ret:
	ret
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
	
; =============== MoveC_Terry_ThrowG ===============
; Move code for Terry's ground throw. (MOVE_SHARED_THROW_G).
MoveC_Terry_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
	mMvC_ChkFrame $00, .obj0
	mMvC_ChkFrame $01, .obj1
	mMvC_ChkFrame $03, .chkEnd
; --------------- frame #2 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Terry_PunchFH ===============
; Move code for Terry's Forward Heavy Punch. (MOVE_SHARED_PUNCH_FH)
MoveC_Terry_PunchFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $03, .chkEnd
; --------------- frames #0,2 --------------
	jp   .anim
; --------------- frame #1 --------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 --------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common --------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveC_Terry_PunchHN ===============
; Move code of the Near Heavy Punch (MOVE_SHARED_PUNCH_HN) for:
; - Terry
; - Ralf
MoveC_Terry_PunchHN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $03, .chkEnd
; --------------- frames #1-2 --------------
	jp   .anim
; --------------- frame #0 --------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 --------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common --------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Terry ===============
; Special move input checker for TERRY.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Terry:
	mMvIn_Validate Terry, 0
	
.chkGround:
	;             SELECT + B                  SELECT + A
	mMvIn_ChkEasy MoveInit_Terry_PowerGeyser, MoveInit_Terry_RisingTackle
	mMvIn_ChkGA Terry, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValProjActive .chkPunchNoSuper
	mMvIn_ValSuper .chkPunchNoSuper
	; DBDF+P -> Power Geyser
	mMvIn_ChkDir MoveInput_DBDF, MoveInit_Terry_PowerGeyser
.chkPunchNoSuper:
	mMvIn_ValProjActive .chkPunchNoProj
	; DF+P -> Power Wave
	mMvIn_ChkDir MoveInput_DF, MoveInit_Terry_PowerWave
.chkPunchNoProj:
	; DU+P -> Rising Tackle
	mMvIn_ChkDir MoveInput_DU_Charge, MoveInit_Terry_RisingTackle
	; DB+P -> Burn Knuckle
	mMvIn_ChkDir MoveInput_DB, MoveInit_Terry_BurnKnuckle
	; End
	jp   MoveInputReader_Terry_NoMove
.chkKick:
	; DB+K -> Crack Shot
	mMvIn_ChkDir MoveInput_DB, MoveInit_Terry_CrackShot
	; FDF+K -> Power Dunk
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Terry_PowerDunk
	; End
	jp   MoveInputReader_Terry_NoMove
	
; =============== MoveInit_Terry_PowerWave ===============
MoveInit_Terry_PowerWave:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_TERRY_POWER_WAVE_L, MOVE_TERRY_POWER_WAVE_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInit_Terry_BurnKnuckle ===============
MoveInit_Terry_BurnKnuckle:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_TERRY_BURN_KNUCKLE_L, MOVE_TERRY_BURN_KNUCKLE_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInit_Terry_CrackShot ===============
MoveInit_Terry_CrackShot:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_TERRY_CRACK_SHOT_L, MOVE_TERRY_CRACK_SHOT_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInit_Terry_RisingTackle ===============
MoveInit_Terry_RisingTackle:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_TERRY_RISING_TACKLE_L, MOVE_TERRY_RISING_TACKLE_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInit_Terry_PowerDunk ===============
MoveInit_Terry_PowerDunk:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_TERRY_POWER_DUNK_L, MOVE_TERRY_POWER_DUNK_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInit_Terry_PowerGeyser ===============
MoveInit_Terry_PowerGeyser:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_TERRY_POWER_GEYSER_S
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Terry_MoveSet
	
; =============== MoveInputReader_Terry_MoveSet ===============
MoveInputReader_Terry_MoveSet:
	scf
	ret
; =============== MoveInputReader_Terry_NoMove ===============
MoveInputReader_Terry_NoMove:
	or   a
	ret
	
; =============== MoveC_Terry_PowerWave ===============
; Move code for Terry's:
; - Power Wave (MOVE_TERRY_POWER_WAVE_L, MOVE_TERRY_POWER_WAVE_H)
; - Power Geyser (MOVE_TERRY_POWER_GEYSER_S)
MoveC_Terry_PowerWave:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStart .anim
	
		;
		; Update the animation speed and spawn the proper projectile.
		;
		
		; Doing the super?
		mMvC_ChkMove MOVE_TERRY_POWER_GEYSER_S, .obj2_super
		
	.obj2_pw:
		; Spawn the projectile
		call ProjInit_Terry_PowerWave
		
		; Determine anim speed
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = iPlInfo_MoveId
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; HL = Ptr to iOBJInfo_FrameTotal
		cp   MOVE_TERRY_POWER_WAVE_H	; Doing the heavy version?
		jp   z, .obj2_setSpeedH			; If so, jump
	.obj2_setSpeedL:
		ld   [hl], $0A	; iOBJInfo_FrameTotal for light
		jp   .anim
	.obj2_setSpeedH:
		ld   [hl], $14	; iOBJInfo_FrameTotal for heavy
		jp   .anim
		
	.obj2_super:
		; Spawn projectile
		call ProjInit_Terry_PowerGeyser
		; Update anim speed
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de
		ld   [hl], $28
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
; =============== MoveC_Terry_BurnKnuckle ===============
; Move code for Terry's Burn Knuckle (MOVE_TERRY_BURN_KNUCKLE_L, MOVE_TERRY_BURN_KNUCKLE_H)
MoveC_Terry_BurnKnuckle:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		jp   .anim
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameStart .obj3_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jump speed
		mMvC_ChkMove MOVE_TERRY_BURN_KNUCKLE_H, .obj3_setJumpH
	.obj3_setJumpL: ; Light
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0300
		jp   .obj3_doGravity
	.obj3_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj3_setJumpE
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0380
		jp   .obj3_doGravity
	.obj3_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV -$0400
	.obj3_doGravity:
		jp   .doGravity
.obj3_cont:
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	jp   .doGravity
; --------------- frame #5 ---------------
.obj5:
	; Loop to #4 (until we touch the ground)
	mMvC_ValFrameEnd .doGravity
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de
		ld   [hl], $03*OBJLSTPTR_ENTRYSIZE ; offset by -1
		jp   .doGravity
; --------------- frames #3-5 / common gravity check ---------------		
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

; =============== MoveC_Terry_CrackShot ===============
; Move code for Terry's Crack Shot (MOVE_TERRY_CRACK_SHOT_L, MOVE_TERRY_CRACK_SHOT_H)
MoveC_Terry_CrackShot:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .doGravity
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetMoveH $0700
.obj1_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_ChkMove MOVE_TERRY_CRACK_SHOT_H, .obj1_setDamageH
	.obj1_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
	.obj1_setDamageH: ; Heavy
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_PlaySound SCT_MOVEJUMP_B
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jump speed
		mMvC_ChkMove MOVE_TERRY_CRACK_SHOT_H, .obj2_setSpeedH
	.obj2_setSpeedL: ; Light
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0300
		jp   .obj2_doGravity
	.obj2_setSpeedH: ; Heavy
		mMvC_ChkMaxPow .obj2_setSpeedE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0380
		jp   .obj2_doGravity
	.obj2_setSpeedE: ; Max Power Heavy 
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0400
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	mMvC_ValNextFrameOnGtYSpeed -$02, ANIMSPEED_NONE, .doGravity
		; Set next damage
		mMvC_ChkMove MOVE_TERRY_CRACK_SHOT_H, .obj2_setDamageH
	.obj2_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj2_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageE: ; Max Power Heavy 
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #2-3 / common gravity check ---------------
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
	
; =============== MoveC_Terry_RisingTackle ===============
; Move code for Terry's Rising Tackle (MOVE_TERRY_RISING_TACKLE_L, MOVE_TERRY_RISING_TACKLE_H)
; This version of Rising Tackle deals continuous low damage.
MoveC_Terry_RisingTackle:
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
		mMvC_ChkFrame $06, .doGravity
		mMvC_ChkFrame $07, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0700
.obj0_cont:

	mMvC_ValFrameEnd .anim
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Before jump, 1st hit
		mMvC_ChkMove MOVE_TERRY_RISING_TACKLE_H, .obj0_setDamageH
	.obj0_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
	.obj0_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj0_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, $00
		jp   .anim
	.obj0_setDamageE: ; Max Power Heavy
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetMoveH +$0700
		mMvC_SetMoveV -$0100
.obj1_cont:
	mMvC_ValFrameEnd .anim
		; Animate as soon as possible
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		; Before jump, 2nd hit
		mMvC_ChkMove MOVE_TERRY_RISING_TACKLE_H, .obj1_setDamageH
	.obj1_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
	.obj1_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj1_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
	.obj1_setDamageE: ; Max Power Heavy
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_PlaySound SFX_SPECIAL
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Initialize jump at the start
		mMvC_ChkMove MOVE_TERRY_RISING_TACKLE_H, .obj2_setJumpH
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
		; [BUG] The animation speed is currently set to ANIMSPEED_INSTANT.
		;       This means the first time we get here is also when mMvC_ValFrameEnd triggers.
		;       Not executing .obj2_cont now means the mMvC_ValFrameEnd branch below will never execute.
		IF FIX_BUGS == 0
			jp   .doGravity
		ENDC
.obj2_cont:
	
	mMvC_ValFrameEnd .doGravity
		;--
		; [TCRF] Unreachable due to bug above.
		mMvC_ChkMove MOVE_TERRY_RISING_TACKLE_H, .obj2_setDamageH
	.obj2_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj2_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageE: ; Max Power Heavy
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
		;--
; --------------- frame #3 ---------------
; Jump damage frame.
.obj3:
	mMvC_ValFrameEnd .doGravity
		; For the Y Speed check in #4
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_ChkMove MOVE_TERRY_RISING_TACKLE_H, .obj3_setDamageH
	.obj3_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
	.obj3_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj3_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
	.obj3_setDamageE: ; Max Power Heavy
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #4 ---------------
; Jump frame. Wait for Y Speed > -3, a little before the peak of the jump.
.obj4:
	mMvC_NextFrameOnGtYSpeed -$03, $01
	jp   .doGravity
; --------------- frame #5 ---------------
; Jump frame.
.obj5:
	; Slow down at the end
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH +$0040
		jp   .doGravity
; --------------- common gravity check ---------------
.doGravity:
	; Apply gravity until we land, then switch to #7
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $07, $03
		jp   .ret
; --------------- frame #7 ---------------
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
	
; =============== MoveC_Terry_PowerDunk ===============
; Move code for Terry's Power Dunk (MOVE_TERRY_POWER_DUNK_L, MOVE_TERRY_POWER_DUNK_H)
MoveC_Terry_PowerDunk:
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
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_PlaySound SFX_JUMP
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl	; Seek to iPlInfo_Flags1
		res  PF1B_INVULN, [hl]
		;--
		; Determine jump speed
		mMvC_ChkMove MOVE_TERRY_POWER_DUNK_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0600
		jp   .obj1_doGravity
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0180
		mMvC_SetSpeedV -$0680
		jp   .obj1_doGravity
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0680
	.obj1_doGravity:
		jp   .doGravity
.obj1_cont:
	mMvC_NextFrameOnGtYSpeed -$0A, $05
	jp   .doGravity
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_PlaySound SCT_FIREHIT
		; Heavy version shakes opponent longer
		mMvC_ChkMove MOVE_TERRY_POWER_DUNK_H, .obj2_setDamageH
	.obj2_setDamageL:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_OVERHEAD
		jp   .doGravity
	.obj2_setDamageH:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT|PF3_OVERHEAD
		jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	; Get manual control when switching to #5 (final jump frame with gravity check).
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- frames #1-5 / common gravity check ---------------
.doGravity:
	; Switch to #6 when we land on the floor
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
; =============== ProjInit_Terry_PowerWave ===============
; Initializes the projectile for Terry's Power Wave (MOVE_TERRY_POWER_WAVE_L, MOVE_TERRY_POWER_WAVE_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Terry_PowerWave:
	mMvC_PlaySound SCT_PROJ_SM

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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Terry_PowerWave)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Terry_PowerWave)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Terry_PowerWave)	; iOBJInfo_OBJLstPtrTbl_High
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
			;

			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			cp   MOVE_TERRY_POWER_WAVE_H	; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_TERRY_POWER_WAVE_H	; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow			; If so, jump
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
	
; =============== ProjInit_Terry_PowerGeyser ===============
; Initializes the projectile for Terry's Power Geyser (MOVE_TERRY_POWER_GEYSER_S)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Terry_PowerGeyser:
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
			ld   [hl], BANK(ProjC_Terry_PowerGeyser)	; BANK $03 ; iOBJInfo_Play_CodeBank
			inc  hl
			ld   [hl], LOW(ProjC_Terry_PowerGeyser)	; iOBJInfo_Play_CodePtr_Low
			inc  hl
			ld   [hl], HIGH(ProjC_Terry_PowerGeyser)	; iOBJInfo_Play_CodePtr_High

			; Write sprite mapping ptr for this projectile.
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_Proj_Terry_PowerGeyser)	; BANK $01 ; iOBJInfo_BankNum
			inc  hl
			ld   [hl], LOW(OBJLstPtrTable_Proj_Terry_PowerGeyser)	; iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   [hl], HIGH(OBJLstPtrTable_Proj_Terry_PowerGeyser)	; iOBJInfo_OBJLstPtrTbl_High
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
			mMvC_SetMoveH +$1600

		pop  de
	pop  bc
	ret
	
; =============== ProjC_Horz ===============
; Generic projectile code for those that only move horizontally.
ProjC_Horz:
	call ExOBJS_Play_ChkHitModeAndMoveH		; Can it despawn?
	jp   c, .despawn						; If so, jump
	call OBJLstS_DoAnimTiming_Loop_by_DE	; Otherwise, continue animating
	ret
.despawn:
	call OBJLstS_Hide
	ret
	
; =============== ProjC_Terry_PowerGeyser ===============	
; Projectile code for Terry's Power Geyser
; This despawns automatically when frame #1F ends.	
ProjC_Terry_PowerGeyser:
	; Depending on the internal frame...
	mMvC_StartChkFrameInt
		mMvC_ChkFrame $1F, .chkDespawn
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret
.chkDespawn:
	mMvC_ValFrameEnd .anim
		call OBJLstS_Hide
		ret 
	
IF REV_VER == VER_96F
GFXDef_Play_Stage_03: mGfxDef "data/gfx/96f/play_stage_03.bin"
BG_Play_Stage_03: INCBIN "data/bg/96f/play_stage_03.bin"
BG_Play_Stage_03_Unused: INCBIN "data/bg/96f/play_stage_03_unused.bin"
ELSE
GFXDef_Play_Stage_03: mGfxDef "data/gfx/play_stage_03.bin"
BG_Play_Stage_03: INCBIN "data/bg/play_stage_03.bin"
BG_Play_Stage_03_Unused: INCBIN "data/bg/play_stage_03_unused.bin"
ENDC


; 
; =============== START OF MODULE Win/Cutscene ===============
;

IF REV_VER == VER_96F
	; [POI] GFXDef_Cutscene_Rugal is a bit fucked in the fake 96.
	;       BG_Play_Stage_03_Unused is 16 bytes longer than it should be, shifting the rest down.
	;       Those 16 bytes (1 tile) are reclaimed from the middle of cutscene_rugal.bin"
GFXDef_Cutscene_Rugal:
	INCBIN "data/bg/96f/play_stage_03_unused_2.bin"
	db (.end-.bin+TILESIZE)/TILESIZE ; Same as the original
.bin:
	INCBIN "data/gfx/96f/cutscene_rugal.bin"
.end:
ELSE
GFXDef_Cutscene_Rugal: mGfxDef "data/gfx/cutscene_rugal.bin"
ENDC
BG_Cutscene_Rugal: INCBIN "data/bg/cutscene_rugal.bin"
GFXDef_Cutscene_Saisyu: mGfxDef "data/gfx/cutscene_saisyu.bin"
BG_Cutscene_Saisyu: INCBIN "data/bg/cutscene_saisyu.bin"
GFXDef_Cutscene_Vice: mGfxDef "data/gfx/cutscene_vice.bin"
BG_Cutscene_Vice: INCBIN "data/bg/cutscene_vice.bin"
GFXDef_Cutscene_Font_IntBoss: mGfxDef "data/gfx/cutscene_font_intboss.bin"
PUSHC
SETCHARMAP intboss

Text_CutsceneIntA0:
	db "ルガールさま・・・・。 "
	db "            "
Text_CutsceneIntA1T:
	db "ただいま、あらたなチームが3かいせん"
	db "                  "
	db "しゅつじょうをけっていしました。  "
	db "                  "
Text_CutsceneIntA2:
	db "フッフッフッフッ・・・おもしろい。 "
	db "                  "
Text_CutsceneIntA3T:
	db "そのチーム、どこまでのものか"
	db "              "
	db "みせてもらうとしよう。   "
	db "              "
Text_CutsceneIntB0:
	db "フッフッフッ・・・はやくここまで"
	db "                "
	db "かちのぽってくるがいい!    "
	db "                "
Text_CutsceneIntB1:
	db "私にたおされるためにな!"
	db "            "
Text_CutsceneIntB2:
	db "ハッハッハッハッ!!"
	db "          "
Text_CutsceneSaisyu00T:
	db "ようこそ!しょくん。"
	db "          "
Text_CutsceneSaisyu01:
	db "ル、ルガール! "
	db "        "
Text_CutsceneSaisyu02:
	db "フッフッフッ、そのとおりだ。"
	db "              "
Text_CutsceneSaisyu03T:
	db "さっそくでわるいのだが、しょくんには"
	db "                  "
	db "私のビジネスに協力していただこう。 "
	db "                  "
Text_CutsceneSaisyu04:
	db "なに!?"
	db "    "
Text_CutsceneSaisyu05T:
	db "キミたちを最強の人間兵器として "
	db "                "
	db "かいぞうするのだ!       "
	db "                "
Text_CutsceneSaisyu06T:
	db "よろこびたまえ、きみたちは私のてで "
	db "                  "
	db "すばらしいしょうひんとなれるのだよ。"
	db "                  "
Text_CutsceneSaisyu07:
	db "さて、そのまえにまず人間兵器の "
	db "                "
	db "しさく型と戦っていただこう。  "
	db "                "
Text_CutsceneSaisyu08:
	db "フッフッフッ。 "
	db "        "
Text_CutsceneSaisyu09:
	db "おはつにおめにかかります。   "
	db "                "
	db "ワシのなはクサナギ サイシュウ。"
	db "                "
Text_CutsceneSaisyu0A:
	db "どうです、わしとひとつおてあわせ"
	db "                "
	db "ねがえぬかな?         "
	db "                "
Text_CutsceneSaisyu0B:
	db "まさか!? "
	db "      "
Text_CutsceneSaisyu0C:
	db "ハッハッハッ!そのとおり、   "
	db "                "
	db "かれはクサナギ キョウのちちだ。"
	db "                "
Text_CutsceneSaisyu0D:
	db "しかばねどうぜんだったかれに、 "
	db "                "
	db "私がいきるみちを        "
	db "                "
Text_CutsceneSaisyu0E:
	db "あたえてやったのだよ! "
	db "            "
Text_CutsceneSaisyu0F:
	db "これにまけるようでは、どのみち   "
	db "                  "
	db "キミたちにはしょうひんかちはない! "
	db "                  "
Text_CutsceneSaisyu10:
	db "せいぜいキタイにこたえてくれたまえ！"
	db "                  "
Text_CutsceneIntA1S:
	db "ただいま、れいの人ぶつの6かいせん "
	db "                  "
	db "しゅつじょうがけっていしました。  "
	db "                  "
Text_CutsceneIntA3S:
	db "ヤツの力、どこまでのものか "
	db "              "
	db "みせてもらうとしよう。   "
	db "              "
	db "おじょうさんの力、どこまでも"
	db "つか            "
	db "    みせてもらうとしよう"
	db "。             "
	db "        "
Text_CutsceneSaisyu00S:
	db "ようこそ! "
	db "      "
Text_CutsceneSaisyu03S:
	db "私のビジネスに協力していただこう。 "
	db "                  "
Text_CutsceneSaisyu05S:
	db "キミを最強の人間兵器として "
	db "              "
	db "かいぞうするのだ!     "
	db "              "
Text_CutsceneSaisyu06S:
	db "よろこびたまえ、きみは私のてで   "
	db "                  "
	db "すばらしいしょうひんとなれるのだよ。"
	db "                  "
Text_CutsceneRugal0:
	db "フッ、さすがですな。"
	db "          "
Text_CutsceneRugal1:
	db "これで、いきておめいをさらしていた "
	db "                  "
	db "私もやっと・・・・・。       "
	db "                  "
Text_CutsceneRugal2:
	db "フッフッフッ! "
	db "        "
Text_CutsceneRugal3:
	db "すばらしい!きたいどおりの "
	db "              "
	db "しょうひんだ!       "
	db "              "
Text_CutsceneRugal4:
	db "その力!私の力をもって "
	db "            "
	db "てにいれてくれる!   "
	db "            "
Text_CutsceneRugal5:
	db "オオオオオオオ・・・・ "
	db "            "
POPC

GFXDef_Cutscene_Font_RugalDefeat: mGfxDef "data/gfx/cutscene_font_rugaldefeat.bin"

PUSHC
SETCHARMAP rugaldefeat

Text_CutsceneRugalDefeat0:
	db "クッ、このパワーをもってしても "
	db "                "
	db "かてぬとは・・・!       "
Text_CutsceneRugalDefeat1:
	db "!?・・・なんだ! "
	db "          "
	db "か、からだが・・・。"
Text_CutsceneRugalDefeat2:
	db "ば、ばかな・・・      "
	db "              "
	db "この私がこんなことで・・・。"
Text_CutsceneRugalDefeat3:
	db "フフフフ・・・まあいい。"
Text_CutsceneRugalDefeat4:
	db "このせかいが私をひつようとするかぎり"
	db "                  "
	db "私はかならずよみがえる・・・    "
Text_CutsceneRugalDefeat5:
	db "そのときにまたあおう・・・ "
	db "              "
	db "しょくん・・・       "
POPC


; =============== SubModule_CutsceneIntA ===============
; This submodule handles the first intermission cutscene with Vice/Rugal.
SubModule_CutsceneIntA:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_IntBoss
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	; Load Vice's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Vice
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Vice
	; The English version repositions Vice and Rugal one tile above, to make space for the taller "textbox"
	; This change is applied everywhere.
IF VER_EN
	ld   hl, $9846
ELSE
	ld   hl, $9866
ENDC
	ld   b, $0A ; Width
	ld   c, $0A ; Height
	call CopyBGToRect
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start 1st cutscene music
	ld   a, BGM_CUTSCENE1
	call HomeCall_Sound_ReqPlayExId_Stub
	
	;
	; TEXT PRINTING
	;
	
	; Print out the screens of text one by one
	
IF VER_EN 
	;--
	; Text 0
	ld   hl, TextDef_CutsceneIntAEn0S	; DE = Source (Single)
	ld   a, [wPlayMode]
	and  a						; wPlayMode == MODE_SINGLE1P?
	jr   z, .t0Set				; If so, skip
	ld   hl, TextDef_CutsceneIntAEn0T	; DE = Source (Team)
.t0Set:
	ld   b, BANK(TextDef_CutsceneIntAEn0S) ; BANK $15
	ld   c, $04 ; Delay
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	call Task_PassControl_NoDelay
	;--
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneIntA0	; Source
	ld   hl, $99C1		; Destination
	ld   b, $0C			; Width
	ld   c, $02			; Height
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #1 - Text 1
	; This varies depending on the game mode.
	ld   de, Text_CutsceneIntA1S	; DE = Source (Single)
	ld   a, [wPlayMode]
	and  a				; wPlayMode == MODE_SINGLE1P?
	jr   z, .t1Set		; If so, skip
	ld   de, Text_CutsceneIntA1T	; DE = Source (Team)
.t1Set:
	ld   hl, $99C1		; Destination
	ld   b, $12			; Width
	ld   c, $04			; Height
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #2 - Scroll Vice right for $78 frames.
	;      This moves her off-screen, ready to be unloaded.
	ld   b, $78
.viceMvLoop:
	; Pressing START now ends the cutscene early, but only in the Japanese version.
IF !VER_EN
	call Cutscene03_IsStartPressed
	ret  c
ENDC
	ld   hl, hScrollX			; Scroll viewport left 1px/frame
	dec  [hl]
	call Task_PassControl_NoDelay
	dec  b						; Done moving?
	jp   nz, .viceMvLoop		; If not, loop
	;--
	
	;--
	; #3 - Load Rugal graphics / tilemap.
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Put Rugal off-screen to the left
	ld   a, $60
	ldh  [hScrollX], a
	
	; Delete Vice tilemap
	call ClearBGMap
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9840
ELSE
	ld   hl, $9860
ENDC
	ld   b, $0C ; Width
	ld   c, $0A ; Height
	call CopyBGToRect
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	
	;--
	; #4 - Scroll Rugal right for $30 frames.
	;      This moves him partially on-screen.
	ld   b, $30
.rugalMvLoop:
	; Pressing START now ends the cutscene early, but only in the Japanese version.
	call Cutscene03_IsStartPressed
IF !VER_EN
	ret  c
ENDC
	ld   hl, hScrollX			; Scroll viewport left 1px/frame
	dec  [hl]
	call Task_PassControl_NoDelay
	dec  b						; Done moving?
	jp   nz, .rugalMvLoop		; If not, loop
	;--
	
IF VER_EN
	;--
	; Text 1
	ld   hl, TextDef_CutsceneIntAEn1	; Source
	ld   b, BANK(TextDef_CutsceneIntAEn1)		; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ELSE
	;--
	; #5 - Text 2
	ld   de, Text_CutsceneIntA2	; Source
	ld   hl, $99C7		; Destination
	ld   b, $12			; Width
	ld   c, $02			; Height
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #6 - Text 3
	; This varies depending on the game mode.
	ld   de, Text_CutsceneIntA3S	; DE = Source (Single)
	ld   a, [wPlayMode]
	and  a				; wPlayMode == MODE_SINGLE1P?
	jr   z, .t3Set		; If so, skip
	ld   de, Text_CutsceneIntA3T	; DE = Source (Team)
.t3Set:
	ld   hl, $99C7		; Destination
	ld   b, $0E			; Width
	ld   c, $04			; Height
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4 ; Wait for $B4 frames
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ENDC
; =============== SubModule_CutsceneIntA ===============
; This submodule handles the second intermission cutscene with Rugal.
SubModule_CutsceneIntB:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_IntBoss
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	
	;-----------------------------------
	rst  $10				; Stop LCD
	
	
	; Put Rugal almost off-screen to the left
	ld   a, $78
	ldh  [hScrollX], a
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9844
ELSE
	ld   hl, $9864
ENDC
	ld   b, $0C ; Width
	ld   c, $0A ; Height
	call CopyBGToRect
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	
	;--
	; #0 - Scroll Rugal right for $78 frames.
	;      This moves him at the center of the screen.
	ld   b, $78
.rugalMvLoop:
	; Pressing START now ends the cutscene early, but only in the Japanese version.
	call Cutscene03_IsStartPressed
IF !VER_EN
	ret  c
ENDC
	ld   hl, hScrollX			; Scroll viewport left 1px/frame
	dec  [hl]
	call Task_PassControl_NoDelay
	dec  b						; Done moving?
	jp   nz, .rugalMvLoop		; If not, loop
	;--
	
IF VER_EN
	;--
	; Text 0
	ld   hl, TextDef_CutsceneIntBEn0
	ld   b, BANK(TextDef_CutsceneIntBEn0) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ELSE
	;--
	; #1 - Text 0
	ld   de, Text_CutsceneIntB0
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #2 - Text 1
	ld   de, Text_CutsceneIntB1
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #3 - Text 2
	ld   de, Text_CutsceneIntB2
	ld   hl, $99C1
	ld   b, $0A
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ENDC

	
; =============== SubModule_CutsceneSaisyu ===============
; This submodule handles the cutscene before fighting Saisyu.
SubModule_CutsceneSaisyu:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_IntBoss
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9844
ELSE
	ld   hl, $9864
ENDC
	ld   b, $0C
	ld   c, $0A
	call CopyBGToRect
	
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	
IF VER_EN
	;--
	; Text 0
	ld   hl, TextDef_CutsceneSaisyuEn0S	; Source (Single)
	ld   a, [wPlayMode]
	and  a
	jr   z, .t0Set
	ld   hl, TextDef_CutsceneSaisyuEn0T	; Source (Team)
.t0Set:
	ld   b, BANK(TextDef_CutsceneSaisyuEn0S) ; BANK $15
	ld   c, $04 ; Delay
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneSaisyu00S	; Source (Single)
	ld   b, $06			; Width (Single)
	ld   a, [wPlayMode]
	and  a				; wPlayMode == MODE_SINGLE1P?
	jr   z, .t0Set		; If so, skip
	ld   de, Text_CutsceneSaisyu00T	; Source (Team)
	ld   b, $0A			; Width (Team)
.t0Set:
	ld   hl, $99C1		; Destination
	ld   c, $02			; Width
	ld   a, $04			; Height
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #1 - Draw team members
	;-----------------------------------
	rst  $10				; Stop LCD
	call Cutscene_DrawPlPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 1
	ld   hl, TextDef_CutsceneSaisyuEn1
	ld   b, BANK(TextDef_CutsceneSaisyuEn1) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #2 - Text 1
	ld   de, Text_CutsceneSaisyu01
	ld   hl, $99C1
	ld   b, $08
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC

	;--
	; #3 - Draw Rugal
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Reload cutscene palette as the pics load their own
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9844
ELSE
	ld   hl, $9864
ENDC
	ld   b, $0C
	ld   c, $0A
	call CopyBGToRect
	
	; Set DMG palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 2
	ld   hl, TextDef_CutsceneSaisyuEn2
	ld   b, BANK(TextDef_CutsceneSaisyuEn2) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #4 - Text 2
	ld   de, Text_CutsceneSaisyu02
	ld   hl, $99C1
	ld   b, $0E
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #5 - Text 3
	ld   de, Text_CutsceneSaisyu03S	; Source (Single)
	ld   c, $02			; Height (Single)
	ld   a, [wPlayMode]
	and  a				; wPlayMode == MODE_SINGLE1P?
	jr   z, .t3Set		; If so, skip
	ld   de, Text_CutsceneSaisyu03T	; Source (Team)
	ld   c, $04			; Height (Team)
.t3Set:
	ld   hl, $99C1		; Destination
	ld   b, $12			; Width
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #6 - Draw team members
	;-----------------------------------
	rst  $10				; Stop LCD
	call Cutscene_DrawPlPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 3
	ld   hl, TextDef_CutsceneSaisyuEn3
	ld   b, BANK(TextDef_CutsceneSaisyuEn3) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #7 - Text 4
	ld   de, Text_CutsceneSaisyu04
	ld   hl, $99C1
	ld   b, $04
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #8 - Draw Rugal
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Reload cutscene palette as the pics load their own
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9844
ELSE
	ld   hl, $9864
ENDC
	ld   b, $0C
	ld   c, $0A
	call CopyBGToRect
	
	; Set DMG palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 4
	ld   hl, TextDef_CutsceneSaisyuEn4 ; TextDef_CutsceneSaisyuEn4
	ld   b, BANK(TextDef_CutsceneSaisyuEn4) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE

	;--
	; #9 - Text 5
	ld   de, Text_CutsceneSaisyu05S	; Source (Single)
	ld   b, $0E			; Width (Single)
	ld   a, [wPlayMode]
	and  a				; wPlayMode == MODE_SINGLE1P? 
	jr   z, .t5Set		; If so, skip
	ld   de, Text_CutsceneSaisyu05T	; Source (Team) 
	ld   b, $10			; Width (Team)
.t5Set:
	ld   hl, $99C1		; Destination
	ld   c, $04			; Height
	ld   a, $04			; Delay
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #A - Text 6
	ld   de, Text_CutsceneSaisyu06S
	ld   a, [wPlayMode]
	and  a
	jr   z, .t6Set
	ld   de, Text_CutsceneSaisyu06T
.t6Set:
	ld   hl, $99C1
	ld   b, $12
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #B - Text 7
	ld   de, Text_CutsceneSaisyu07
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC

	;--
	; #C - Draw Saisyu
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Put Saisyu off-screen to the right
	ld   a, $80
	ldh  [hScrollX], a
	
	; Reload SGB palette
	ld   de, $0000
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Load Saisyu's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Saisyu
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Saisyu
	ld   hl, $9860
	ld   b, $10
	ld   c, $0A
	call CopyBGToRect
	
	; Set DMG palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	;--
	
	;--
	; #D - Scroll Saisyu left for $70 frames.
	;      This moves him at the center of the screen.
	ld   b, $70
.saisyuMvLoop:
	call Cutscene03_IsStartPressed
IF !VER_EN
	ret  c
ENDC
	ld   hl, hScrollX			; Scroll viewport right 1px/frame
	inc  [hl]
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .saisyuMvLoop
	;--
	
IF VER_EN
	;--
	; Text 5
	ld   hl, TextDef_CutsceneSaisyuEn5
	ld   b, BANK(TextDef_CutsceneSaisyuEn5) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #E - Text 8
	ld   de, Text_CutsceneSaisyu08
	ld   hl, $99C0
	ld   b, $08
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #F - Text 9
	ld   de, Text_CutsceneSaisyu09
	ld   hl, $99C0
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #10 - Text A
	ld   de, Text_CutsceneSaisyu0A
	ld   hl, $99C0
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC

	;--
	; #6 - Draw team members
	;-----------------------------------
	rst  $10				; Stop LCD
	xor  a					; Reset X Scroll
	ldh  [hScrollX], a
	call Cutscene_DrawPlPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 6
	ld   hl, TextDef_CutsceneSaisyuEn6
	ld   b, BANK(TextDef_CutsceneSaisyuEn6) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #11 - Text B
	ld   de, Text_CutsceneSaisyu0B
	ld   hl, $99C1
	ld   b, $06
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #12 - Draw Rugal
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Reload cutscene palette as the pics load their own
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9844
ELSE
	ld   hl, $9864
ENDC
	ld   b, $0C
	ld   c, $0A
	call CopyBGToRect
	
	; Set DMG palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 7
	ld   hl, TextDef_CutsceneSaisyuEn7
	ld   b, BANK(TextDef_CutsceneSaisyuEn7) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ELSE
	;--
	; #13 - Text C
	ld   de, Text_CutsceneSaisyu0C
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #14 - Text D
	ld   de, Text_CutsceneSaisyu0D
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #15 - Text E
	ld   de, Text_CutsceneSaisyu0E
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #16 - Text F
	ld   de, Text_CutsceneSaisyu0F
	ld   hl, $99C1
	ld   b, $12
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #17 - Text 10
	ld   de, Text_CutsceneSaisyu10
	ld   hl, $99C1
	ld   b, $12
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ENDC

; =============== SubModule_CutsceneRugal ===============
; This submodule handles the cutscene before fighting Rugal.
SubModule_CutsceneRugal:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_IntBoss
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	call ClearBGMap
	
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Load Saisyu's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Saisyu
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Saisyu
	ld   hl, $9862
	ld   b, $10
	ld   c, $0A
	call CopyBGToRect
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
IF VER_EN
	;--
	; Text 0
	ld   hl, TextDef_CutsceneRugalEn0
	ld   b, BANK(TextDef_CutsceneRugalEn0) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneRugal0
	ld   hl, $99C1
	ld   b, $0A
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #1 - Text 1
	ld   de, Text_CutsceneRugal1
	ld   hl, $99C1
	ld   b, $12
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #2 - Draw Rugal
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Reload cutscene palette as the pics load their own
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Load Rugal's GFX and tilemap
	ld   hl, GFXDef_Cutscene_Rugal
	ld   de, $8800
	call CopyTilesAutoNum
	ld   de, BG_Cutscene_Rugal
IF VER_EN
	ld   hl, $9843
ELSE
	ld   hl, $9863
ENDC
	ld   b, $0C
	ld   c, $0A
	call CopyBGToRect
	
	; Set DMG palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	;--
	; Text 1
	ld   hl, TextDef_CutsceneRugalEn1
	ld   b, BANK(TextDef_CutsceneRugalEn1) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #3 - Text 2
	ld   de, Text_CutsceneRugal2
	ld   hl, $99C1
	ld   b, $08
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #4 - Text 3
	ld   de, Text_CutsceneRugal3
	ld   hl, $99C1
	ld   b, $0E
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
	
	;--
	; #5 - Text 4
	ld   de, Text_CutsceneRugal4
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #6 - Draw Omega Rugal pic
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   a, CHAR_ID_RUGAL
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	call Task_PassControl_NoDelay
	;--
	; Play SGB transformation sound
	ld   hl, (SGB_SND_A_JETSTART << 8)|$00
	call SGB_PrepareSoundPacketA
	call Task_PassControl_NoDelay
	;--
	
	;--
	; Text 2
	ld   hl, TextDef_CutsceneRugalEn2
	ld   b, BANK(TextDef_CutsceneRugalEn2) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ELSE
	;--
	; #7 - Text 5
	ld   de, Text_CutsceneRugal5
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	jp   Cutscene03_ClearText ; End
	;--
ENDC	
	
; =============== SubModule_CutsceneRugalDefeat ===============
; This submodule handles the cutscene where Rugal dies.
SubModule_CutsceneRugalDefeat:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_RugalDefeat
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Draw Omega Rugal pic
	ld   a, CHAR_ID_RUGAL
	call Cutscene_DrawOpponentPicScreen
	
	; Load pic overlay object.
	; This is a black square that covers the opponent pic (see also: Cutscene03_BlinkPic).
	ld   hl, GFX_Cutscene_PicBlink		; 2 black tiles
	ld   de, $8000
	call CopyTilesAutoNum
	ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
	ld   de, OBJInfoInit_Cutscene_PicBlink
	call OBJLstS_InitFrom
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	; Set a fully black palette for it
	ld   a, $FF
	ldh  [rOBP0], a
	
IF VER_EN
	;--
	; Text 0
	ld   hl, TextDef_CutsceneRugalDefeatEn0
	ld   b, BANK(TextDef_CutsceneRugalDefeatEn0) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneRugalDefeat0
	ld   hl, $99C1
	ld   b, $10
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWrite
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #1 - Start flashing the Omega Rugal pic.
	; 	   The flashes will become progressively faster over time.
	ld   a, $1F					; Flash every 32 frames
	ld   [wCutBlinkPicMask], a
	;--
	
IF VER_EN
	;--
	; Text 1
	ld   hl, TextDef_CutsceneRugalDefeatEn1
	ld   b, BANK(TextDef_CutsceneRugalDefeatEn1) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #2 - Text 1
	ld   de, Text_CutsceneRugalDefeat1
	ld   hl, $99C1
	ld   b, $0A
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup_BlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
	
	;--
	; #3 - Flash faster
	ld   a, $0F					; Flash every 16 frames
	ld   [wCutBlinkPicMask], a
	; Play sound effect while this goes on.
	; It will get progressively noisier over time.
	ld   hl, (SGB_SND_B_WATERFALL << 8)|$00
	call SGB_PrepareSoundPacketB
	call Task_PassControl_NoDelay
	;--
	
	;--
	; #4 - Text 2
	ld   de, Text_CutsceneRugalDefeat2
	ld   hl, $99C1
	ld   b, $0E
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup_BlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #5 - Flash faster
	ld   a, $07					; Flash every 8 frames
	ld   [wCutBlinkPicMask], a
	ld   hl, (SGB_SND_B_WATERFALL << 8)|$01
	call SGB_PrepareSoundPacketB
	call Task_PassControl_NoDelay
	;--
	
IF VER_EN
	;--
	; Text 2
	ld   hl, TextDef_CutsceneRugalDefeatEn2
	ld   b, BANK(TextDef_CutsceneRugalDefeatEn2) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFastBlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
ELSE
	;--
	; #6 - Text 3
	ld   de, Text_CutsceneRugalDefeat3
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $01
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup_BlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
	
	;--
	; #7 - Flash faster
	ld   a, $03					; Flash every 4 frames
	ld   [wCutBlinkPicMask], a
	ld   hl, (SGB_SND_B_WATERFALL << 8)|$02
	call SGB_PrepareSoundPacketB
	call Task_PassControl_NoDelay
	;--
	
	;--
	; #8 - Text 4
	ld   de, Text_CutsceneRugalDefeat4
	ld   hl, $99C1
	ld   b, $12
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup_BlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	call Cutscene03_ClearText
	;--
ENDC
	
	;--
	; #9 - Flash faster
IF VER_EN
	ld   a, $03					; Flash every 4 frames
ELSE
	ld   a, $01					; Flash every other frame
ENDC
	ld   [wCutBlinkPicMask], a
	ld   hl, (SGB_SND_B_WATERFALL << 8)|$03
	call SGB_PrepareSoundPacketB
	call Task_PassControl_NoDelay
	;--
	
IF VER_EN
	;--
	; Text 3
	ld   hl, TextDef_CutsceneRugalDefeatEn3
	ld   b, BANK(TextDef_CutsceneRugalDefeatEn3) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFastBlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	;--
ELSE
	;--
	; #9 - Text 5
	ld   de, Text_CutsceneRugalDefeat5
	ld   hl, $99C1
	ld   b, $0E
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup_BlinkPic
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene03_PostTextWriteBlinkPic
	;--
ENDC
	
	;--
	; #A - Stop effects
	
	; Stop flashing effect
	ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Stop cutscene music
	ld   a, SND_MUTE
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; and the SGB thunder-like effect
	ld   hl, (SGB_SND_B_STOP << 8)|$00
	call SGB_PrepareSoundPacketB
	;--
	
	;--
	; #B - Wait for 20 frames
	ld   b, $14
.eLoop:
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .eLoop
	;--
	
	;--
	; #C - White out the screen
	
	; Set white DMG palettes
	ld   a, $00
	ldh  [rBGP], a
	ldh  [rOBP0], a
	
	; Play thunder effect
	ld   hl, (SGB_SND_A_TELEPORT << 8)|$01
	call SGB_PrepareSoundPacketA
	
	; Wait 4 frames
	ld   b, $04
.rLoop:
	call Task_PassControl_Delay3B
	dec  b
	jp   nz, .rLoop
	;--
	
	; End
	jp   ClearBGMap
	
; =============== Cutscene03_ClearText ===============
; Blank out any existing text.
Cutscene03_ClearText:
	; Clear all 4 rows (7 in the English version)
IF VER_EN
	ld   hl, BGMap_Begin+$0180 ; BG Ptr (En)
ELSE
	ld   hl, BGMap_Begin+$01C0 ; BG Ptr (Jp)
ENDC
	ld   b, $18	; Rect Width
IF VER_EN
	ld   c, $07 ; Rect Height (En)
ELSE
	ld   c, $04 ; Rect Height (Jp)
ENDC
	ld   d, $00 ; Tile ID
	jp   FillBGRect
	
; =============== Cutscene03_PostTextWrite ===============
; Shared code executed after text finishes writing for a cutscene.
; This delays the cutscene from continuing, until the timer elapses or START is pressed.
; IN
; - B: Max number of frames to wait
; OUT
; - C flag: If set, it was aborted early
Cutscene03_PostTextWrite:
	; Check early abort
	call Cutscene03_IsStartPressed	; Did anyone press START?
IF VER_EN
	jr   nc, .contWait				; If not, jump
	call Task_PassControl_NoDelay	; Otherwise wait a frame, then return
	ret
ELSE
	ret  c							; If so, return
ENDC
.contWait:
	call Task_PassControl_NoDelay	; Wait frame
	dec  b							; Are we done?
	jp   nz, Cutscene03_PostTextWrite	; If not, loop
.end:
	xor  a	; C flag clear
	ret
	
; =============== Cutscene03_PostTextWriteBlinkPic ===============
; Identical to Cutscene03_PostTextWrite, except it also flashes Omega Rugal's pic..
; IN
; - B: Delay in frames
Cutscene03_PostTextWriteBlinkPic:
	; Check early abort
	call Cutscene03_IsStartPressed	; Did anyone press START?
IF VER_EN
	jr   nc, .contWait				; If not, jump
	call Task_PassControl_NoDelay	; Otherwise wait a frame, then return
	ret
ELSE
	ret  c							; If so, return
ENDC
.contWait:
	call Task_PassControl_NoDelay	; Wait frame
	call Cutscene03_BlinkPic			; Flash object
	dec  b							; Are we done?
	jp   nz, Cutscene03_PostTextWriteBlinkPic	; If not, loop
.end:
	xor  a	; C flag clear
	ret

; =============== Cutscene03_IsStartPressed ===============
; Checks if any player pressed START.
; Identical to Win_IsStartPressed.
; OUT
; - C flag: If set, someone did
Cutscene03_IsStartPressed:
	; If any player presses START, return set
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a
	jp   nz, .abort
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a
	jp   nz, .abort
	; Otherwise, return clear
	xor  a
	ret
.abort:
	scf
	ret
	
; =============== Cutscene03_BlinkPic ===============
; Flashes Omega Rugal's pic.
; This is accomplished by quickly toggling wOBJInfo_PicBlink's visibility,
; which is a black square that fully covers the pic if visible.
Cutscene03_BlinkPic:
	push af
		push bc
			push hl
				
				;
				; Visible = wTimer & wCutBlinkPicMask == 0
				; The lower the mask value is, the more the blocker object is visible.
				;
				ld   a, [wCutBlinkPicMask]
				ld   b, a			; B = Flash Mask
				ld   a, [wTimer]	; A = Timer
				and  b				; Timer & Mask != 0?
				jp   nz, .hide		; If so, jump (hide object)
			.show:
				ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
				set  OSTB_VISIBLE, [hl]
				jp   .end
			.hide:
				ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
				res  OSTB_VISIBLE, [hl]
			.end:
			
			pop  hl
		pop  bc
	pop  af
	ret
	
; =============== TextPrinter_MultiFrame_WithSpeedup_BlinkPic ===============
; Identical to TextPrinter_MultiFrame_WithSpeedup except it also flashes Omega Rugal's pic.
;
; IN
; - DE: Ptr to text data (list of tile IDs)
; - HL: Ptr to tilemap (Destination)
; - A: Delay between letter printing
; - B: Text width (number of characters in a line)
; - C: Text height (number of lines)
TextPrinter_MultiFrame_WithSpeedup_BlinkPic:
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
						call Cutscene03_BlinkPic
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
	jr   nz, TextPrinter_MultiFrame_WithSpeedup_BlinkPic	; If not, loop
	call Task_PassControl_NoDelay
	call Cutscene03_BlinkPic
	ret
	
GFX_Cutscene_PicBlink: mGfxDef "data/gfx/cutscene_picblink.bin"
OBJInfoInit_Cutscene_PicBlink:
	db $00 ; iOBJInfo_Status
	db $00 ; iOBJInfo_OBJLstFlags
	db $00 ; iOBJInfo_OBJLstFlagsView
	db $38 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db $28 ; iOBJInfo_Y
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
	db BANK(OBJLstPtrTable_Cutscene_PicBlink) ; iOBJInfo_BankNum (BANK $01)
	db LOW(OBJLstPtrTable_Cutscene_PicBlink) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Cutscene_PicBlink) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNum (BANK $01)
	db LOW(OBJLstPtrTable_Cutscene_PicBlink) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Cutscene_PicBlink) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High

INCLUDE "data/objlst/cutscene.asm"

; 
; =============== END OF MODULE Win/Cutscene ===============
;

; =============== END OF BANK ===============
; Junk area below.
IF VER_EN
	mIncJunk "L037C03"
ELSE
	mIncJunk "L037E61"
ENDC