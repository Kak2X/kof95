; =============== MoveC_Mai_ThrowG ===============
; Move code for Mai's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Mai_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
; When visually switching to #3, hit the opponent.
.obj1:
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
	
; =============== MoveInputReader_Mai ===============
; Special move input checker for MAI.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Mai:
	mMvIn_Validate Mai, 1
	
.chkAir:
	;             SELECT + B                            SELECT + A
	mMvIn_ChkEasy MoveInit_Mai_ChoHissatsuShinobibachi, MoveInit_Mai_KuuchuuMusasabiMai
	mMvIn_ChkGA Mai, .chkAirPunch, .chkAirKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkAirKick:
	mMvIn_ValSuper .chkAirKickNoSuper
	; FBF+K -> Cho Hissatsu Shinobibachi
	mMvIn_ChkDir MoveInput_FBF, MoveInit_Mai_ChoHissatsuShinobibachi
.chkAirKickNoSuper:
	; End
	jp   MoveInputReader_Mai_NoMove
.chkAirPunch:
	; DB+P -> Kuuchuu Musasabi no Mai
	mMvIn_ChkDir MoveInput_DB, MoveInit_Mai_KuuchuuMusasabiMai
	; End
	jp   MoveInputReader_Mai_NoMove
	
.chkGround:
	;             SELECT + B                            SELECT + A
	mMvIn_ChkEasy MoveInit_Mai_ChoHissatsuShinobibachi, MoveInit_Mai_HishoRyuEnJin
	mMvIn_ChkGA Mai, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValProjActive .chkPunchNoProj
	; DF+P -> Ka Cho Sen
	mMvIn_ChkDir MoveInput_DF, MoveInit_Mai_KaChoSen
.chkPunchNoProj:
	; DB+P -> Ryu En Bu
	mMvIn_ChkDir MoveInput_DB, MoveInit_Mai_RyuEnBu
	; DU+P -> Chijou Musasabi no Mai
	mMvIn_ChkDir MoveInput_DU_Charge, MoveInit_Mai_ChijouMusasabiMai
	; End
	jp   MoveInputReader_Mai_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; FBF+K -> Cho Hissatsu Shinobibachi
	mMvIn_ChkDir MoveInput_FBF, MoveInit_Mai_ChoHissatsuShinobibachi
.chkKickNoSuper:
	; BDF+K -> Hissatsu Shinobibachi
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Mai_HissatsuShinobibachi
	; FDF+K -> Hisho Ryu En Jin
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Mai_HishoRyuEnJin
	; End
	jp   MoveInputReader_Mai_NoMove
	
; =============== MoveInit_Mai_KaChoSen ===============	
MoveInit_Mai_KaChoSen:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_MAI_KA_CHO_SEN_L, MOVE_MAI_KA_CHO_SEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_HissatsuShinobibachi ===============
MoveInit_Mai_HissatsuShinobibachi:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_MAI_HISSATSU_SHINOBIBACHI_L, MOVE_MAI_HISSATSU_SHINOBIBACHI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_RyuEnBu ===============
MoveInit_Mai_RyuEnBu:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_MAI_RYU_EN_BU_L, MOVE_MAI_RYU_EN_BU_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_HishoRyuEnJin ===============
MoveInit_Mai_HishoRyuEnJin:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_MAI_HISHO_RYU_EN_JIN_L, MOVE_MAI_HISHO_RYU_EN_JIN_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	inc  hl
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_ChijouMusasabiMai ===============
MoveInit_Mai_ChijouMusasabiMai:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_MAI_CHIJOU_MUSASABI_L, MOVE_MAI_CHIJOU_MUSASABI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_KuuchuuMusasabiMai ===============
MoveInit_Mai_KuuchuuMusasabiMai:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_MAI_KUUCHUU_MUSASABI_L, MOVE_MAI_KUUCHUU_MUSASABI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInit_Mai_ChoHissatsuShinobibachi ===============
MoveInit_Mai_ChoHissatsuShinobibachi:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Mai_MoveSet
	
; =============== MoveInputReader_Mai_MoveSet ===============
MoveInputReader_Mai_MoveSet:
	scf
	ret
; =============== MoveInputReader_Mai_NoMove ===============
MoveInputReader_Mai_NoMove:
	or   a
	ret
	
; =============== MoveC_Mai_KaChoSen ===============
; Move code for Mai's Ka Cho Sen (MOVE_MAI_KA_CHO_SEN_L, MOVE_MAI_KA_CHO_SEN_H).
MoveC_Mai_KaChoSen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStart .anim
		call ProjInit_Mai_KaChoSen
		;
		; The heavy version keeps Mai in the "throw" frame for longer.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; Seek to anim speed
		cp   MOVE_MAI_KA_CHO_SEN_H		; Doing the heavy version?
		jp   z, .heavy					; If so, jump
	.light:
		ld   [hl], $04					; iOBJInfo_FrameTotal = $04
		jp   .anim
	.heavy:
		ld   [hl], $07					; iOBJInfo_FrameTotal = $07
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
	
; =============== MoveC_Mai_HissatsuShinobibachi ===============
; Move code for Mai's Hissatsu Shinobibachi (MOVE_MAI_HISSATSU_SHINOBIBACHI_L, MOVE_MAI_HISSATSU_SHINOBIBACHI_H).
MoveC_Mai_HissatsuShinobibachi:
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
	mMvC_ValFrameStart .moveH
		mMvC_PlaySound SFX_STEP
		mMvC_SetSpeedH $0200
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, $00
		jp   .moveH
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .moveH
		mMvC_PlaySound SFX_STEP
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, $00
		jp   .moveH
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .moveH
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_STEP
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
; --------------- frames #0-2 / common horizontal movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
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
		mMvC_ChkMove MOVE_MAI_HISSATSU_SHINOBIBACHI_H, .obj3_setJumpH
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
; --------------- frame #3 / common gravity check ---------------
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
		mMvC_SetLandFrame $04, $07
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
	
; =============== MoveC_Mai_RyuEnBu ===============
; Move code for Mai's Ryu En Bu (MOVE_MAI_RYU_EN_BU_L, MOVE_MAI_RYU_EN_BU_H).
MoveC_Mai_RyuEnBu:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
; --------------- frames #1,3 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_PlaySound SCT_PHYSFIRE
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $05
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_HALFSPEED
		jp   .anim
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
	
; =============== MoveC_Mai_HishoRyuEnJin ===============
; Move code for Mai's Hisho Ryu En Jin (MOVE_MAI_HISHO_RYU_EN_JIN_L, MOVE_MAI_HISHO_RYU_EN_JIN_H).
MoveC_Mai_HishoRyuEnJin:
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
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Move 7px forward, 1px above
	mMvC_ValFrameStart .obj1_cont
		mMvC_SetMoveH +$0700
		mMvC_SetMoveV -$0100
.obj1_cont:
	; Set damage for #2
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_CONTHIT|PF3_HALFSPEED
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStart .obj2_cont
		mMvC_PlaySound SCT_PHYSFIRE
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set jump speed depending on LHE status
		mMvC_ChkMove MOVE_MAI_HISHO_RYU_EN_JIN_H, .obj2_setJumpH
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
	; When switching to #3, deal the knockdown
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_CONTHIT|PF3_HALFSPEED
		jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	; When switching to #5, set a much smaller horz. movement speed. 
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH +$0040
		jp   .doGravity
; --------------- frames #2-5 / common gravity check ---------------
; Switches directly to #6 (recovery) when landing on the ground in frames #2-4
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
	
; =============== MoveC_Mai_ChijouMusasabi ===============
; Move code for Mai's Chijou Musasabi no Mai (MOVE_MAI_CHIJOU_MUSASABI_L, MOVE_MAI_CHIJOU_MUSASABI_H).
MoveC_Mai_ChijouMusasabi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .playSFXOnEnd
		mMvC_ChkFrame $03, .playSFXOnEnd
		mMvC_ChkFrame $04, .playSFXOnEnd
		mMvC_ChkFrame $05, .playSFXOnEnd
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .doGravity
		mMvC_ChkFrame $08, .chkEnd
		mMvC_ChkFrame $09, .chkStartKuuchuu
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $02
		jp   .anim
; --------------- frame #1 ---------------
; Jump setup.
.obj1:
	mMvC_ValFrameStart .playSFXOnEnd
		mMvC_PlaySound SFX_JUMP
		
		; No longer invulnerable
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		
		;
		; Pick the jump direction depending on what we're holding.
		; Note that, regardless of the jump direction, the resulting jump is always a backwards jump.
		; As a result, the player's direction must be adjusted so that:
		; - When holding left, the player must be facing right.
		; - When holding right, the player must be facing left.
		;
		
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		bit  KEYB_RIGHT, [hl]		; Holding right?
		jp   nz, .obj1_chkFlipR		; If so, jump
		bit  KEYB_LEFT, [hl]		; Holding left?
		jp   nz, .obj1_chkFlipL		; If so, jump
		
		; If we're not holding anything, don't alter the player's direction.
		; This could have jumped directly to .obj1_setBackJump... but, for some reason, they
		; went with jumping to the .obj1_chkFlip* check that won't cause a jump to .obj1_flip.
		; WHY
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de
		bit  SPRB_XFLIP, [hl]	; Visually facing right? (1P side)
		jp   z, .obj1_chkFlipR	; If not, jump
		
	.obj1_chkFlipL:
		; We held left.
		; The player must be facing right before getting to .obj1_setBackJump.
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de
		bit  SPRB_XFLIP, [hl]	; Visually facing right? (1P side)
		jp   z, .obj1_flip		; If not, jump
		jp   .obj1_setBackJump
		
	.obj1_chkFlipR:
		; We held right.
		; The player must be facing left before getting to .obj1_setBackJump.
		ld   hl, iOBJInfo_OBJLstFlags
		add  hl, de
		bit  SPRB_XFLIP, [hl]	; Visually facing right? (1P side)
		jp   nz, .obj1_flip		; If so, jump
		jp   .obj1_setBackJump
	.obj1_flip:
		; Flip the player horizontally
		ld   a, [hl]
		xor  SPR_XFLIP
		ld   [hl], a
		
	.obj1_setBackJump:
		mMvC_SetSpeedH -$0600
		mMvC_ChkMaxPow .obj1_setBackJumpMaxPow
	.obj1_setBackJumpNoMaxPow:
		mMvC_SetSpeedV -$0780
		jp   .obj1_doGravity
	.obj1_setBackJumpMaxPow:
		mMvC_SetSpeedV -$0700
	.obj1_doGravity:
		jp   .doGravity
; --------------- frames #1-5 / mid jump ---------------
.playSFXOnEnd:
	mMvC_ValFrameEnd .doGravity
		mMvC_PlaySound SFX_LIGHT
		jp   .doGravity
; --------------- frame #6 ---------------
; End of jump check.
.obj6:
	; Loop back to #2 if, by the end of the frame, we didn't touch the edge of the screen yet.
	; Otherwise, switch to #9.
	ld   hl, iOBJInfo_RangeMoveAmount
	add  hl, de
	ld   a, [hl]
	or   a				; iOBJInfo_RangeMoveAmount != 0?
	jp   nz, .obj6_setNext	; If so, jump
	mMvC_ValFrameEnd .doGravity
		mMvC_SetFrameOnEnd $02
		jp   .doGravity
.obj6_setNext:
	mMvC_SetFrame $09, $03
	jp   .ret
; --------------- frame #9 ---------------
; Checks for the input to transition to Kuuchuu Musasabi no Mai.
.chkStartKuuchuu:
	mMvC_ValFrameEnd .anim
	
		; Holding B transitions to the wall dive attack
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		bit  KEYB_B, [hl]			; Pressed B?
		jp   nz, .startKuuChuu		; If so, jump
		
		; [POI] The CPU always starts it
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		bit  PF0B_CPU, [hl]			; Are we a CPU?
		jp   nz, .startKuuChuu		; If so, jump
		
		; If we didn't hold anything, just continue to #7 where we fall down normally.
		mMvC_SetFrame $07, ANIMSPEED_NONE
		jp   .ret
		
	.startKuuChuu:
		; Switch to the appropriate version of Kuuchuu Musasabi no Mai
		mMvC_ChkMove MOVE_MAI_CHIJOU_MUSASABI_H, .startKuuChuuH
	.startKuuChuuL:
		ld   a, MOVE_MAI_KUUCHUU_MUSASABI_L
		call MoveInputS_SetSpecMove_StopSpeed
		jp   .ret
	.startKuuChuuH:
		ld   a, MOVE_MAI_KUUCHUU_MUSASABI_H
		call MoveInputS_SetSpecMove_StopSpeed
		jp   .ret
; --------------- frame #1-7 / common gravity check ---------------
.doGravity:
	; Switch to #8 if we touched the ground instead of the screen edge
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $08, $07
		jp   .ret
; --------------- frame #8 ---------------
; Ends the move at the end of the frame.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Mai_KuuchuuMusasabi ===============
; Move code for Mai's Kuuchuu Musasabi no Mai (MOVE_MAI_KUUCHUU_MUSASABI_L, MOVE_MAI_KUUCHUU_MUSASABI_H).
; Dive attack.
MoveC_Mai_KuuchuuMusasabi:
	call Play_Pl_MoveByColiBoxOverlapX
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
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStart .doGravity
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_ChkMove MOVE_MAI_KUUCHUU_MUSASABI_H, .obj1_setDiveH
	.obj1_setDiveL: ; Light
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV +$0200
		jp   .obj1_doGravity
	.obj1_setDiveH: ; Heavy
		mMvC_ChkMaxPow .obj1_setDiveE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV +$0180
		jp   .obj1_doGravity
	.obj1_setDiveE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV +$0000
	.obj1_doGravity:
		jp   .doGravity
; --------------- frame #1 / common gravity check ---------------
.doGravity:
	mMvC_ChkGravityHV $0018, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $02, $05
		jp   .ret
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
	
; =============== MoveC_Mai_ChoHissatsuShinobibachi ===============
; Move code for the super version of Mai's Cho Hissatsu Shinobibachi (MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S).
MoveC_Mai_ChoHissatsuShinobibachi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .moveH
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #0 ---------------
; Initial forward dash.
.obj0:
	mMvC_ValFrameStart .obj0_cont
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		res  PF1B_INVULN, [hl]
		mMvC_PlaySound SFX_STEP
		mMvC_SetSpeedH +$0300
.obj0_cont:
	mMvC_ValFrameEnd .moveH
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, $00
		jp   .moveH
; --------------- [TCRF] unreferenced frame #1 ---------------
; This being skipped makes the move deal one less hit.
.unused_obj1:
	mMvC_ValFrameEnd .moveH
		mMvC_PlaySound SFX_STEP
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, $00
		jp   .moveH
; --------------- frame #2 ---------------
; Initial forward dash, dealing damage.
.obj2:
	mMvC_ValFrameEnd .moveH
		mMvC_PlaySound SFX_STEP
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .moveH
; --------------- frames #0-2 / common movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #3 ---------------
; Jump.
.obj3:
	mMvC_ValFrameStart .obj3_cont
		mMvC_PlaySound SCT_PHYSFIRE
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set jump settings
		mMvC_SetSpeedH +$0780
		mMvC_SetSpeedV -$0400
		jp   .doGravity
.obj3_cont:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
; --------------- frame #4 ---------------
; Mid-jump loop
.obj4:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
		jp   .doGravity
; --------------- frame #5 ---------------
; Mid-jump loop.
.obj5:
	; Loop back to #4 if we didn't touch the ground by the end of the frame
	mMvC_ValFrameEnd .doGravity
		mMvC_SetFrameOnEnd $04
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE
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
		mMvC_SetLandFrame $06, $0A
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
	
; =============== ProjInit_Mai_KaChoSen ===============
; Initialized the projectile for Mai's Ka Cho Sen (MOVE_MAI_KA_CHO_SEN_L, MOVE_MAI_KA_CHO_SEN_H).
ProjInit_Mai_KaChoSen:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Mai_KaChoSen)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Mai_KaChoSen)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Mai_KaChoSen)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $03	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], $03	; iOBJInfo_FrameTotal

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
			cp   MOVE_MAI_KA_CHO_SEN_H		; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_MAI_KA_CHO_SEN_H		; Was this an heavy attack?
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
	
; =============== MoveC_Rugal_KickHN ===============
; Move code for Rugal's Near Heavy Kick. (MOVE_SHARED_KICK_HN)
MoveC_Rugal_KickHN:
	call Play_Pl_MoveByColiBoxOverlapX
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
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	; Wait for the animation to advance before ending the move
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveInputReader_Rugal ===============
; Special move input checker for RUGAL.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Rugal:
	mMvIn_Validate Rugal, 2
	
.chkGround:
	;             SELECT + B                       SELECT + A
	mMvIn_ChkEasy MoveInit_Rugal_GiganticPressure, MoveInit_Rugal_GenocideCutter
	mMvIn_ChkGA Rugal, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH

.chkPunch:
	; FBDF+P -> Kaiser Wave
	mMvIn_ChkDir MoveInput_FBDF, MoveInit_Rugal_KaiserWave
	; FDB+P -> God Press
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Rugal_GodPress
	; DF+P -> Reppu Ken
	mMvIn_ChkDir MoveInput_DF, MoveInit_Rugal_ReppuKen
	; End
	jp   MoveInputReader_Rugal_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; FDBFDB+K -> Gigantic Pressure
	mMvIn_ChkDir MoveInput_FDBFDB, MoveInit_Rugal_GiganticPressure
.chkKickNoSuper:
	; DB+K -> Genocide Cutter
	mMvIn_ChkDir MoveInput_DB, MoveInit_Rugal_GenocideCutter
	; DF+K -> Dark Barrier
	mMvIn_ChkDir MoveInput_DF, MoveInit_Rugal_DarkBarrier
	; End
	jp   MoveInputReader_Rugal_NoMove
	
; =============== MoveInit_Rugal_ReppuKen ===============
MoveInit_Rugal_ReppuKen:
	mMvIn_ValProjActive MoveInputReader_Rugal_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RUGAL_REPPU_KEN_L, MOVE_RUGAL_REPPU_KEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInit_Rugal_GodPress ===============
MoveInit_Rugal_GodPress:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RUGAL_GOD_PRESS_L, MOVE_RUGAL_GOD_PRESS_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInit_Rugal_DarkBarrier ===============
MoveInit_Rugal_DarkBarrier:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_RUGAL_DARK_BARRIER_L, MOVE_RUGAL_DARK_BARRIER_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREFLECT, [hl]
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInit_Rugal_GenocideCutter ===============
MoveInit_Rugal_GenocideCutter:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_RUGAL_GENOCIDE_CUTTER_L, MOVE_RUGAL_GENOCIDE_CUTTER_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInit_Rugal_KaiserWave ===============
MoveInit_Rugal_KaiserWave:
	mMvIn_ValProjActive MoveInputReader_Rugal_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_RUGAL_KAISER_WAVE_L, MOVE_RUGAL_KAISER_WAVE_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInit_Rugal_GiganticPressure ===============
MoveInit_Rugal_GiganticPressure:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_RUGAL_GIGANTIC_PRESSURE_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Rugal_MoveSet
	
; =============== MoveInputReader_Rugal_MoveSet ===============
MoveInputReader_Rugal_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Rugal_NoMove ===============
MoveInputReader_Rugal_NoMove:
	or   a
	ret
	
; =============== MoveC_Rugal_ReppuKen ===============
; Move code for Rugal's:
; - Reppu Ken (MOVE_RUGAL_REPPU_KEN_L, MOVE_RUGAL_REPPU_KEN_H)
; - Kaiser Wave (MOVE_RUGAL_KAISER_WAVE_L, MOVE_RUGAL_KAISER_WAVE_H)
MoveC_Rugal_ReppuKen:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
	
		;
		; How long to stay in #3 after the projectile spawns?
		; The heavy version stays for longer.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; HL = Ptr to anim speed
		cp   MOVE_RUGAL_REPPU_KEN_H		; Doing the heavy version?
		jp   z, .obj1_setSpeedH			; If so, jump
		cp   MOVE_RUGAL_KAISER_WAVE_H	; Doing the heavy version?
		jp   z, .obj1_setSpeedH			; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $08
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $10
		jp   .anim

; --------------- frame #3 ---------------
.obj3:
	;
	; Spawn the proper projectile type at the start
	;
	mMvC_ValFrameStartFast .chkEnd
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_RUGAL_REPPU_KEN_L
		jp   z, .obj3_reppuKen
		cp   MOVE_RUGAL_REPPU_KEN_H
		jp   z, .obj3_reppuKen
	.obj3_kaiserWave:
		call ProjInit_Rugal_KaiserWave
		jp   .chkEnd
	.obj3_reppuKen:
		call ProjInit_Rugal_ReppuKen
.chkEnd:
	; Wait for recovery
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Rugal_DarkBarrier ===============
; Move code for Rugal's Dark Barrier (MOVE_RUGAL_DARK_BARRIER_L, MOVE_RUGAL_DARK_BARRIER_H).
; See also: MoveC_Athena_PsychoReflector
MoveC_Rugal_DarkBarrier:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .chkHit
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #3 ---------------
; Shield disappears.
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		; Animate the shield as fast as possible
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		
		mMvC_PlaySound SCT_BARRIER
		
		; Determine how long the shield is active (loop count from #2 to #1)
		mMvC_ChkMove MOVE_RUGAL_DARK_BARRIER_H, .obj0_setLoopH
	.obj0_setLoopL:
		ld   hl, iPlInfo_Rugal_DarkBarrier_LoopCount
		add  hl, bc
		ld   [hl], $04
		jp   .anim
	.obj0_setLoopH:
		ld   hl, iPlInfo_Rugal_DarkBarrier_LoopCount
		add  hl, bc
		ld   [hl], $08
		jp   .anim
		
; --------------- frame #2 ---------------
; Shield frame #1
.obj2:
	mMvC_ValFrameEnd .chkHit
		; If the loop counter didn't elapse, loop back to #1
		ld   hl, iPlInfo_Rugal_DarkBarrier_LoopCount
		add  hl, bc
		dec  [hl]					; Is the counter elapsed?
		jp   z, .anim				; If it did, allow continuing to #3
		mMvC_SetFrame $01, $00
		jp   .ret
; --------------- common hit check / frames #1-2 ---------------
; Shield frame #0
.chkHit:
	; If the opponent is hit, switch to #3
	mMvC_ValHit .anim
		mMvC_SetFrame $03, $00
		jp   .ret
; --------------- frame #6 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
	
; =============== MoveC_Rugal_GenocideCutter ===============
; Move code for Rugal's Genocide Cutter (MOVE_RUGAL_GENOCIDE_CUTTER_L, MOVE_RUGAL_GENOCIDE_CUTTER_H).
MoveC_Rugal_GenocideCutter:
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
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		; Prepare for jump
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		; Set big damage
		mMvC_SetDamageNext $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		jp   .anim
; --------------- frame #1 ---------------
; Jump.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetMoveH $0800
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set jump settings
		mMvC_ChkMove MOVE_RUGAL_GENOCIDE_CUTTER_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0400
		jp   .obj1_cont
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0600
		jp   .obj1_cont
	.obj1_setJumpE: ; Max Power Heavy 
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0700
.obj1_cont:
	; Wait for YSpeed > -$06 before continuing. This only delays the Max Power version.
	mMvC_NextFrameOnGtYSpeed -$06, ANIMSPEED_INSTANT
	jp   .doGravity
; --------------- frame #2 ---------------
; Jump.
.obj2:
	; Immediately switch to #3
	mMvC_NextFrameOnGtYSpeed -$06, ANIMSPEED_NONE
		mMvC_SetSpeedH $0040
		jp   .doGravity
; --------------- frame #3 ---------------
; Jump.
.obj3:
	; Force low speed
	mMvC_SetSpeedH $0040
; --------------- common gravity check / frames #1-3 ---------------
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
	
; =============== MoveC_Rugal_GodPress ===============
; Move code for Rugal's God Press (MOVE_RUGAL_GOD_PRESS_L, MOVE_RUGAL_GOD_PRESS_H).
; Rugal rushes forwards, grabs the opponent, and smashes them at the edge of the playfield.
MoveC_Rugal_GodPress:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $0A
		jp   .anim
; --------------- frame #1 ---------------
; Run forwards attempting to grab the opponent.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		; Set dash speed, depending on the move strength
		mMvC_ChkMove MOVE_RUGAL_GOD_PRESS_H, .obj1_setSpeedH
	.obj1_setSpeedL: ; Light
		mMvC_SetSpeedH +$0400
		jp   .obj1_cont
	.obj1_setSpeedH: ; Heavy
		mMvC_ChkMaxPow .obj1_setSpeedE
		mMvC_SetSpeedH +$0500
		jp   .obj1_cont
	.obj1_setSpeedE: ; Max Power Heavy
		mMvC_SetSpeedH +$0600
.obj1_cont:
	; If by the end of the frame, we didn't reach the opponent
	mMvC_ValFrameEnd .chkOtherHit
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetFrameOnEnd $04
		jp   .moveH
		
.chkOtherHit:
	;
	; If we didn't hit the opponent yet, return without doing anything.
	; 
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]			; Did we reach?
	jp   z, .moveH						; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .moveH						; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .moveH						; If not, skip	
	;
	; If the hit is blocked, backhop away.
	;	
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .switchToBackHop			; If so, jump
	
	.chkOtherHit_ok:
		;
		; The hit wasn't blocked, so switch to #2 to continue the attack.
		;
		mMvC_SetFrame $02, ANIMSPEED_NONE
		ld   a, PLAY_THROWACT_NEXT03
		ld   [wPlayPlThrowActId], a
		mMvC_SetDamageNext $08, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		mMvC_SetDamage $08, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
	IF FIX_BUGS == 1
		jp   .ret
	ELSE
		jp   MoveC_Rugal_GiganticPressure.ret
	ENDC


; --------------- frame #2 ---------------	
; Runs forward holding the opponent until reaching the edge of the stage.
.obj2:

	;
	; If the opponent isn't in the intended HITTYPE_GRAB_UB_SYNC after 8 frames,
	; assume that something went wrong and hop back, ending the move.
	;
	
	;--
	ld   hl, iOBJInfo_Status
	add  hl, de
	bit  OSTB_GFXNEWLOAD, [hl]	; First time we get here?
	jp   nz, .obj2_chkEdge		; If so, skip (not needed, see below)
	;--
	
		; Delay the first hit and the HITTYPE check for the first 5 frames.
		; We can do it this way since we know the initial value iOBJInfo_FrameLeft is set to,
		; and that decrements every frame.
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   a, [hl]
		cp   ANIMSPEED_NONE-$05		; iOBJInfo_FrameLeft >= $FA?
		jp   nc, .obj2_1stDamage	; If so, skip
		
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_GRAB_UB_SYNC	; Opponent's HitType != HITTYPE_GRAB_UB_SYNC?
		jp   nz, .switchToBackHop	; If so, jump
		
	jp   .obj2_chkEdge
.obj2_1stDamage:
	; Deal the hit on contact, which will only take effect once.
	mMvC_SetDamage $08, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
.obj2_chkEdge:
	
	;
	; Continue moving until either we or the opponent get near the edge of the stage.
	; When that happens, switch to #3, the recovery.
	;
	ld   hl, iPlInfo_OBJInfoXOther
	add  hl, bc
	ld   a, [hl]
	cp   $00+PLAY_BORDER_X		; Opponent on the left edge?	
	jp   z, .obj2_setDamage		; If so, jump
	cp   $100-PLAY_BORDER_X		; Opponent on the right edge?	
	jp   z, .obj2_setDamage		; If so, jump
	ld   hl, iOBJInfo_X
	add  hl, de
	ld   a, [hl]
	cp   $00+PLAY_BORDER_X		; Are we on the left edge?	
	jp   z, .obj2_setDamage		; If so, jump
	cp   $100-PLAY_BORDER_X		; Are we on the right edge?
	jp   z, .obj2_setDamage		; If so, jump
	; Otherwise, continue moving
	jp   .moveH
.obj2_setDamage:
	;
	; Switch to #3 and setup the damage dealt by the move.
	;
	mMvC_SetFrame $03, $08
	mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
	jp   .ret
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameEnd .anim
; --------------- common early end - opponent blocked ---------------
.switchToBackHop:
	; When the opponent blocks the move, hop away.
	ld   a, MOVE_SHARED_HOP_B
	call Pl_SetMove_StopSpeed
	; And end the throw sequence
	ld   a, PLAY_THROWACT_NONE
	ld   [wPlayPlThrowActId], a
	jp   .ret
; --------------- common forwards movement / frames #1-3 ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ChkFrictionH $0100, .anim
		; End the throw
		call Play_Pl_EndMove
		ld   a, PLAY_THROWACT_NONE
		ld   [wPlayPlThrowActId], a
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Rugal_GiganticPressure ===============
; Move code for Rugal's Gigantic Pressure (MOVE_RUGAL_GIGANTIC_PRESSURE_S).
MoveC_Rugal_GiganticPressure:
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
; --------------- frame #0 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		; 16 frames to reach the opponent
		mMvC_SetAnimSpeed $10
		jp   .anim
; --------------- frame #2 ---------------
; Initial dash towards opponent.
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		; Set dash speed
		mMvC_SetSpeedH +$0700
.obj2_cont:
	mMvC_ValFrameEnd .chkOtherHit
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetFrameOnEnd $05
		jp   .moveH
		
; --------------- hit check / frame #2 ---------------
; Checks if the opponent was successfully hit.
.chkOtherHit:
	;
	; If we didn't hit the opponent yet, return without doing anything.
	; 
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]		; Did we reach?
	jp   z, .moveH					; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]			; Is the opponent invulnerable?
	jp   nz, .moveH					; If so, skip
	bit  PF1B_HITRECV, [hl]			; Did the opponent get hit?
	jp   z, .moveH					; If not, skip	
	;
	; If the hit is blocked, backhop away.
	;	
	bit  PF1B_GUARD, [hl]			; Is the opponent blocking?
	jp   nz, .switchToBackHop		; If so, jump
	
	.chkOtherHit_ok:
		;
		; The hit wasn't blocked, so switch to #3 to continue the attack.
		;
		mMvC_SetFrame $03, ANIMSPEED_NONE
		ld   a, PLAY_THROWACT_NEXT03
		ld   [wPlayPlThrowActId], a
		mMvC_SetDamageNext $20, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		mMvC_SetDamage $20, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		jp   .ret
		
; --------------- frame #4 ---------------	
; Runs forward holding the opponent until reaching the edge of the stage.
.obj3:

	;
	; If the opponent isn't in the intended HITTYPE_GRAB_UB_SYNC after 8 frames,
	; assume that something went wrong and hop back, ending the move.
	;
	
	;--
	ld   hl, iOBJInfo_Status
	add  hl, de
	bit  OSTB_GFXNEWLOAD, [hl]	; First time we get here?
	jp   nz, .obj3_chkEdge		; If so, skip (not needed, see below)
	;--
	
		; Skip the HITTYPE check for the first 8 frames.
		; We can do it this way since we know the initial value iOBJInfo_FrameLeft is set to,
		; and that decrements every frame.
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   a, [hl]
		cp   ANIMSPEED_NONE-$07		; iOBJInfo_FrameLeft >= $F8?
		jp   nc, .obj3_chkEdge		; If so, skip
		
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_GRAB_UB_SYNC	; Opponent's HitType != HITTYPE_GRAB_UB_SYNC?
		jp   nz, .switchToBackHop	; If so, jump
.obj3_chkEdge:
	;
	; Continue moving until either we or the opponent get near the edge of the stage.
	; When that happens, switch to #5 and spawn the skull projectile.
	;
	ld   hl, iPlInfo_OBJInfoXOther
	add  hl, bc
	ld   a, [hl]
	cp   $00+PLAY_BORDER_X		; Opponent on the left edge?	
	jp   z, .obj3_setDamage		; If so, jump
	cp   $100-PLAY_BORDER_X		; Opponent on the right edge?	
	jp   z, .obj3_setDamage		; If so, jump
	ld   hl, iOBJInfo_X
	add  hl, de
	ld   a, [hl]
	cp   $00+PLAY_BORDER_X		; Are we on the left edge?	
	jp   z, .obj3_setDamage		; If so, jump
	cp   $100-PLAY_BORDER_X		; Are we on the right edge?
	jp   z, .obj3_setDamage		; If so, jump
	; Otherwise, continue moving
	jp   .moveH
.obj3_setDamage:
	;
	; Switch to #4 and setup the damage dealt by the move.
	;
	mMvC_SetFrame $04, $08
	mMvC_SetDamageNext $20, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
	jp   .ret
; --------------- frame #4 ---------------
; Last frame, with Rugal and the opponent on the wall.
.obj4:
	mMvC_ValFrameEnd .anim
		; Set damage settings
		mMvC_SetDamageNext $20, HITTYPE_LAUNCH_SWOOPUP, PF3_HEAVYHIT
		; Copy them over to the projectile
		call Play_Proj_CopyMoveDamageFromPl
		; And spawn said projectile
		call ProjInit_Rugal_GiganticPressure
		; Finally, backhop and end the move.
		
; --------------- common backhop switch ---------------
; Switches to the backwards hop.
.switchToBackHop:
	ld   a, MOVE_SHARED_HOP_B
	call Pl_SetMove_StopSpeed
	ld   a, PLAY_THROWACT_NONE
	ld   [wPlayPlThrowActId], a
	jp   .ret
; --------------- common horizontal movement ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- frame #5 ---------------
; Slow down, and when we stop moving end the move.
; We get here only if the opponent wasn't hit.
.chkEnd:
	mMvC_ChkFrictionH $0100, .anim
		call Play_Pl_EndMove
		ld   a, PLAY_THROWACT_NONE
		ld   [wPlayPlThrowActId], a
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Rugal_ReppuKen ===============
; Initializes the projectile for Rugal's Reppu Ken (MOVE_RUGAL_REPPU_KEN_L, MOVE_RUGAL_REPPU_KEN_H).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Rugal_ReppuKen:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Rugal_ReppuKen)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Rugal_ReppuKen)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Rugal_ReppuKen)	; iOBJInfo_OBJLstPtrTbl_High
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
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			;

			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			cp   MOVE_RUGAL_REPPU_KEN_H		; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_RUGAL_REPPU_KEN_H		; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow			; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeedH
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeedH
		.fldHeavy:
			ld   hl, +$0400
		.setSpeedH:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== ProjInit_Rugal_KaiserWave ===============
; Initializes the projectile for Rugal's Kaiser Wave (MOVE_RUGAL_KAISER_WAVE_L, MOVE_RUGAL_KAISER_WAVE_H).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Rugal_KaiserWave:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Rugal_KaiserWave)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Rugal_KaiserWave)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Rugal_KaiserWave)	; iOBJInfo_OBJLstPtrTbl_High
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
			;

			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			cp   MOVE_RUGAL_KAISER_WAVE_H	; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_RUGAL_KAISER_WAVE_H	; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow			; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeedH
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeedH
		.fldHeavy:
			ld   hl, +$0400
		.setSpeedH:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret

; =============== ProjInit_Rugal_GiganticPressure ===============
; Initializes the projectile for Rugal's Gigantic Pressure (MOVE_RUGAL_GIGANTIC_PRESSURE_S).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Rugal_GiganticPressure:
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
			ld   [hl], BANK(ProjC_Rugal_GiganticPressure)	; BANK $18 ; iOBJInfo_Play_CodeBank
			inc  hl
			ld   [hl], LOW(ProjC_Rugal_GiganticPressure)	; iOBJInfo_Play_CodePtr_Low
			inc  hl
			ld   [hl], HIGH(ProjC_Rugal_GiganticPressure)	; iOBJInfo_Play_CodePtr_High

			; Write sprite mapping ptr for this projectile.
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_Proj_Rugal_GiganticPressure)	; BANK $01 ; iOBJInfo_BankNum
			inc  hl
			ld   [hl], LOW(OBJLstPtrTable_Proj_Rugal_GiganticPressure)	; iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   [hl], HIGH(OBJLstPtrTable_Proj_Rugal_GiganticPressure)	; iOBJInfo_OBJLstPtrTbl_High
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
			mMvC_SetMoveH +$0000
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Rugal_GiganticPressure ===============
; Projectile code for Rugal's Gigantic Pressure (MOVE_RUGAL_GIGANTIC_PRESSURE_S).
ProjC_Rugal_GiganticPressure:
	; Wait for the sprite counter to reach $1A before despawning
	mMvC_StartChkFrameInt
		mMvC_ChkFrame $1A, .chkEnd
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret  
.chkEnd:
	mMvC_ValFrameEnd .anim
		call OBJLstS_Hide
		ret
	
; =============== MoveC_Kensou_ThrowG ===============
; Move code for Kensou's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Kensou_ThrowG:
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
		mMvC_SetDamageNext $06, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $14
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
	
; =============== MoveC_Kensou_PunchFH ===============
; Move code for Kensou's forward heavy punch. (MOVE_SHARED_PUNCH_FH).
MoveC_Kensou_PunchFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .chkEnd
; --------------- frames #0-1 ---------------
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
; =============== MoveC_Kensou_KickFH ===============
; Move code for Kensou's forward heavy kick. (MOVE_SHARED_KICK_FH).
; This is a forward kick hop.
MoveC_Kensou_KickFH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
; --------------- frame #1 ---------------
.obj1:
	; At the end, enable manual control for the gravity check
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	; Set jump settings at the start of the frame
	mMvC_ValFrameStartFast .chkGravity
		mMvC_PlaySound SFX_HEAVY
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0200
; --------------- gravity check, frame #2 ---------------
.chkGravity:
	; Switch to #3 when touching the ground
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $03, $03
		jp   .ret
; --------------- frame #3 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveInputReader_Kensou ===============
; Special move input checker for KENSOU.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Kensou:
	mMvIn_Validate Kensou, 1

.chkAir:
	;             SELECT + B                          SELECT + A
	mMvIn_ChkEasy MoveInit_Kensou_ShinryuuTenbuKyaku, MoveInit_Kensou_RyuuSouGeki
	mMvIn_ChkGA Kensou, .chkAirPunch, .chkAirKick, CHKGA_KICK|CHKGA_PUNCH

.chkAirPunch:
	; DB+P -> Ryuu Sou Geki
	mMvIn_ChkDir MoveInput_DB, MoveInit_Kensou_RyuuSouGeki
	; End
	jp   MoveInputReader_Kensou_NoMove
.chkAirKick:
	mMvIn_ValSuper .chkAirKickNoSuper
	; DFBF+K -> Shinryuu Tenbu Kyaku
	mMvIn_ChkDir MoveInput_DFBF, MoveInit_Kensou_ShinryuuTenbuKyaku
.chkAirKickNoSuper:
	; End
	jp   MoveInputReader_Kensou_NoMove
	
.chkGround:
	;             SELECT + B                          SELECT + A
	mMvIn_ChkEasy MoveInit_Kensou_ShinryuuTenbuKyaku, MoveInit_Kensou_RyuuGakuSai
	mMvIn_ChkGA Kensou, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	; BDF+P -> Ryuu Ren Ga
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Kensou_RyuuRenGa
	; DB+P -> Chou Kyuu Dan
	mMvIn_ChkDir MoveInput_DB, MoveInit_Kensou_ChouKyuuDan
	; End
	jp   MoveInputReader_Kensou_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; DFBF+K -> Shinryuu Tenbu Kyaku
	mMvIn_ChkDir MoveInput_DFBF, MoveInit_Kensou_ShinryuuTenbuKyaku
.chkKickNoSuper:
	; BDB+K -> Ryuu Gaku Sai
	mMvIn_ChkDir MoveInput_BDB, MoveInit_Kensou_RyuuGakuSai
	; End
	jp   MoveInputReader_Kensou_NoMove
	
; =============== MoveInit_Kensou_ChouKyuuDan ===============
MoveInit_Kensou_ChouKyuuDan:
	mMvIn_ValProjActive MoveInputReader_Kensou_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_KENSOU_CHOU_KYUU_DAN_L, MOVE_KENSOU_CHOU_KYUU_DAN_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Kensou_MoveSet
	
; =============== MoveInit_Kensou_RyuuGakuSai ===============
MoveInit_Kensou_RyuuGakuSai:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_KENSOU_RYUU_GAKU_SAI_L, MOVE_KENSOU_RYUU_GAKU_SAI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	; Not coming from a super
	ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
	add  hl, bc
	ld   [hl], $00
	jp   MoveInputReader_Kensou_MoveSet
	
; =============== MoveInit_Kensou_RyuuRenGa ===============
MoveInit_Kensou_RyuuRenGa:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_KENSOU_RYUU_REN_GA_L, MOVE_KENSOU_RYUU_REN_GA_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kensou_MoveSet
	
; =============== MoveInit_Kensou_RyuuSouGeki ===============
MoveInit_Kensou_RyuuSouGeki:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_KENSOU_RYUU_SOU_GEKI_L, MOVE_KENSOU_RYUU_SOU_GEKI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Kensou_MoveSet
	
; =============== MoveInit_Kensou_ShinryuuTenbuKyaku ===============
MoveInit_Kensou_ShinryuuTenbuKyaku:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Kensou_MoveSet
	
; =============== MoveInputReader_Kensou_MoveSet ===============
MoveInputReader_Kensou_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Kensou_NoMove ===============
MoveInputReader_Kensou_NoMove:
	or   a
	ret
	
; =============== MoveC_Kensou_ChouKyuuDan ===============
; Move code for Kensou's Chou Kyuu Dan (MOVE_KENSOU_CHOU_KYUU_DAN_L, MOVE_KENSOU_CHOU_KYUU_DAN_H).
; Horizontal projectile.
; See also: MoveC_Athena_PsychoBall
MoveC_Kensou_ChouKyuuDan:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]						; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de							; HL = Ptr to anim speed
		cp   MOVE_KENSOU_CHOU_KYUU_DAN_H	; Doing the heavy version?
		jp   z, .obj0_setSpeedH				; If so, jump
	.obj0_setSpeedL:
		ld   [hl], $0E
		jp   .anim
	.obj0_setSpeedH:
		ld   [hl], $1A
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Athena_PsychoBall
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kensou_RyuuGakuSai ===============
; Move code for Kensou's Gaku Sai (MOVE_KENSOU_RYUU_GAKU_SAI_L, MOVE_KENSOU_RYUU_GAKU_SAI_H).
; Essentially a fancy uppercut.
MoveC_Kensou_RyuuGakuSai:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .obj7
		mMvC_ChkFrame $08, .doGravity
		mMvC_ChkFrame $09, .chkEnd
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .anim
	
		; If coming from the super, move $0Cpx forwards
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   a, [hl]
		or   a
		jp   z, .anim
		mMvC_SetMoveH +$0C00
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		
		; Deal half damage if coming from the super move
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   a, [hl]
		or   a							; Super flag set?
		jp   z, .obj2_setDamageNorm		; If not, jump
	.obj2_setDamageSuper:
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .anim
	.obj2_setDamageNorm:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameStartFast .obj3_cont
		mMvC_SetMoveH +$0C00
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		
		; Pick jump settings
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   a, [hl]
		or   a
		jp   nz, .obj3_setJumpS
		mMvC_ChkMove MOVE_KENSOU_RYUU_GAKU_SAI_H, .obj3_setJumpH
	.obj3_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj3_doGravity
	.obj3_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj3_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj3_doGravity
	.obj3_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0800
		jp   .obj3_doGravity
	.obj3_setJumpS: ; Super
		mMvC_SetSpeedH +$0480
		mMvC_SetSpeedV -$0680
	.obj3_doGravity:
		jp   .doGravity
.obj3_cont:
	; Immediately switch to the next frame
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		; Deal half damage if coming from the super move
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   a, [hl]
		or   a
		jp   z, .obj3_setDamageNorm
	.obj3_setDamageSuper:
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .anim
	.obj3_setDamageNorm:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	; Identical to .obj3_cont
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   a, [hl]
		or   a
		jp   z, .obj4_setDamageNorm
	.obj4_setDamageSuper:
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		jp   .anim
	.obj4_setDamageNorm:
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #5 ---------------
.obj5:
	; Immediately switch to the next frame
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .doGravity
		mMvC_SetSpeedH +$0040
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #6 ---------------
.obj6:
	; Wait for near peak
	mMvC_NextFrameOnGtYSpeed -$03, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #7 ---------------
.obj7:
	; Wait for post-peak
	mMvC_NextFrameOnGtYSpeed +$01, ANIMSPEED_NONE
	jp   .doGravity
; --------------- common gravity check ---------------
.doGravity:
	; Switch to #9 when landing on the ground
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $09, $07
		jp   .ret
; --------------- frame #9 ---------------
.chkEnd:
	; Recovery
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		; Cleanup
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   [hl], $00
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kensou_RyuuRenGa ===============
; Move code for Kensou's Gaku Sai (MOVE_KENSOU_RYUU_REN_GA_L, MOVE_KENSOU_RYUU_REN_GA_H).
; Forwards hopkick.
MoveC_Kensou_RyuuRenGa:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
; --------------- frame #3 ---------------
	jp   .moveH
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set forwards hop settings
		mMvC_ChkMove MOVE_KENSOU_RYUU_REN_GA_H, .obj1_setJumpH
	.obj1_setJumpL:
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV -$0200
		jp   .obj1_cont
	.obj1_setJumpH:
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0200
		jp   .obj1_cont
	.obj1_setJumpE:
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0200
.obj1_cont:
	; On hit, align to the floor and start moving forward dealing the other hits
	mMvC_ValHit .chkGravity
		mMvC_SetFrame $02, $01
		; Align to floor
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
		mMvC_SetSpeedH $0200
		jp   .ret
; --------------- frame #2 ---------------
; 2nd kick
.obj2:
	mMvC_ValFrameEnd .moveH
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID0, PF3_CONTHIT
		jp   .moveH
; --------------- frame #4 ---------------
; 3rd kick
.obj4:
	mMvC_ValFrameEnd .moveH
		mMvC_SetAnimSpeed $08
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .moveH
; --------------- frame #5 ---------------
; Slow down at 0.5px/frame
.obj5:
	mMvC_DoFrictionH $0080
		mMvC_ValFrameEnd .anim
		jp   .end
; --------------- common horizontal movement / frames #2-5 ---------------
.moveH:
	call OBJLstS_ApplyXSpeed
	jp   .anim
; --------------- common gravity check / frame #1 ---------------
.chkGravity:
	; We only get here on #1.
	; If we touch the ground, the move whiffed. Skip to #6.
	mMvC_ChkGravityHV $0030, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $06, $07
		jp   .ret
; --------------- frame #6 ---------------
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

; =============== MoveC_Kensou_RyuuSouGeki ===============
; Move code for Kensou's Ryuu Sou Geki (MOVE_KENSOU_RYUU_SOU_GEKI_L, MOVE_KENSOU_RYUU_SOU_GEKI_H).
; Divekick.
MoveC_Kensou_RyuuSouGeki:
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
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		; Set divekick speed
		mMvC_ChkMove MOVE_KENSOU_RYUU_SOU_GEKI_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV +$0200
		jp   .obj1_cont
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV +$0180
		jp   .obj1_cont
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV +$0000
.obj1_cont:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		jp   .chkGravity
; --------------- frame #2 ---------------
; Damage frame
.obj2:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID1, $00
		jp   .chkGravity
; --------------- frame #3 ---------------
; Damage frame
.obj3:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		mMvC_SetFrameOnEnd $02
		jp   .chkGravity
; --------------- common gravity check / frame #1-3 ---------------
.chkGravity:
	; Touching the ground at any point skips to #4, preparing for the final kick
	mMvC_ChkGravityHV $0018, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $04, $01
		jp   .ret
; --------------- frame #4 ---------------
; Landed
.obj4:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $08
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_PlaySound SCT_MOVEJUMP_A
		jp   .anim
; --------------- frame #5 ---------------
; The kick takes effect here.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Kensou_ShinryuuTenbuKyaku ===============
; Move code for Kensou's Shinryuu Tenbu Kyaku (MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S)
; Fancy DP that transitions to another fancy DP.
MoveC_Kensou_ShinryuuTenbuKyaku:
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
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Set jump speed at the start
	mMvC_ValFrameStartFast .obj2
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0300
; --------------- frame #2 ---------------
; Damage frame #0
.obj2:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		jp   .chkGravity
; --------------- frame #3 ---------------
; Damage frame #1
.obj3:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
		jp   .chkGravity
; --------------- frame #4 ---------------
; Set fast forward movement for #5
.obj4:
	mMvC_ValFrameEnd .chkGravity
		mMvC_SetSpeedH +$0400
		jp   .chkGravity
; --------------- frame #5 ---------------
; Fast fall.
.obj5:
	ld   hl, +$0300 ; High gravity
	jp   .chkGravityCustom
; --------------- common gravity chck --------------
.chkGravity:
	ld   hl, +$0030 ; Low gravity
.chkGravityCustom:
	; Switch to #6 when landing on the ground
	call OBJLstS_ApplyGravityVAndMoveHV
	jp   nc, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $06, $00
		jp   .ret
; --------------- frame #6 ---------------
.chkEnd:
	; Transition to the DP at the end
	mMvC_ValFrameEnd .anim
		; New move
		ld   a, MOVE_KENSOU_RYUU_GAKU_SAI_H
		call MoveInputS_SetSpecMove_StopSpeed
		; Reset the frame timer
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
		; Deal half damage for some frames
		ld   hl, iPlInfo_Kensou_RyuuGakuSai_FromSuper
		add  hl, bc
		ld   [hl], $01
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== ProjInit_Athena_PsychoBall ===============
; Initializes the projectile for:
; - Athena's 108 Psycho Ball (MOVE_ATHENA_PSYCHO_BALL_L, MOVE_ATHENA_PSYCHO_BALL_H)
; - Kensou's Chou Kyuu Dan (MOVE_KENSOU_CHOU_KYUU_DAN_L, MOVE_KENSOU_CHOU_KYUU_DAN_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Athena_PsychoBall:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Athena_PsychoBall)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Athena_PsychoBall)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Athena_PsychoBall)	; iOBJInfo_OBJLstPtrTbl_High
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
				mMvC_SetMoveV -$0400
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
	
	
; =============== MoveC_Athena_ThrowG ===============
; Move code for Athena's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Athena_ThrowG:
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
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_NOSYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_MID_UB_NOSTUN, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $14
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

; =============== MoveC_Athena_ThrowA ===============
; Move code for Athena's Air Throw. (MOVE_SHARED_THROW_A).
; This launches the opponent forwards, diagonally down.
MoveC_Athena_ThrowA:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .doGravity
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		; Throw the opponent straight down.
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Backjump away at the start
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetSpeedH -$0200
		mMvC_SetSpeedV -$0200
.obj1_cont:
	mMvC_ValFrameEnd .doGravity
		; Set manual control for the gravity check
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .doGravity
; --------------- common gravity check / frames #1-2 ---------------
.doGravity:
	; Switch to #4 when landing on the ground
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $03, $04
		jp   .ret
; --------------- frame #4 ---------------
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
	
; =============== MoveC_Athena_PhoenixBomb ===============
; Move code for Athena's Phoenix Bomb. (MOVE_SHARED_KICK_AHD).
MoveC_Athena_PhoenixBomb:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .doGravity
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #3 ---------------
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	; Keep moving downwards until the opponent is hit
	mMvC_ValHit .doGravity
		; On contact, rebound the opposite way
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00			; Reset frame #0
		mMvC_SetSpeedH -$0080	; 0.5px/frame back
		mMvC_SetSpeedV -$0300	; 3px/frame up
		jp   .doGravity
; --------------- frame #1 ---------------
.obj1:
	; Switch to #2 on the jump peak
	mMvC_NextFrameOnGtYSpeed $00, ANIMSPEED_NONE
	jp   .doGravity
; --------------- common gravity check / frames #0-2 ---------------
.doGravity:
	; When landing on the ground, switch to #3
	mMvC_ChkGravityHV $0060, .anim
		mMvC_SetLandFrame $04, $04
		jp   .ret
; --------------- frame #4 ---------------
; Recovery when landed on the ground.
.chkEnd:
IF FIX_BUGS == 1
	mMvC_ValFrameEnd .anim
ELSE
	mMvC_ValFrameEnd MoveC_Athena_ThrowA.anim
ENDC
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  

; =============== MoveInputReader_Athena ===============
; Special move input checker for ATHENA.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Athena:
	mMvIn_Validate Athena, 1
	
.chkAir:
	;             SELECT + B                     SELECT + A
	mMvIn_ChkEasy MoveInit_Athena_ShCrystGround, MoveInit_Athena_PhoenixArrow
	mMvIn_ChkGA Athena, .chkAirPunch, 0, CHKGA_PUNCH
	
.chkAirPunch:
	; FDF+P (air) -> Psycho Sword
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Athena_PsychoSword
	; DB+P (air) -> Phoenix Arrow
	mMvIn_ChkDir MoveInput_DB, MoveInit_Athena_PhoenixArrow
	; End
	jp   MoveInputReader_Athena_NoMove
	
.chkGround:
	;             SELECT + B                     SELECT + A
	mMvIn_ChkEasy MoveInit_Athena_ShCrystGround, MoveInit_Athena_PsychoSword
	mMvIn_ChkGA Athena, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; BFDB+P -> Shining Crystal Bit
	mMvIn_ChkDir MoveInput_BFDB, MoveInit_Athena_ShCrystGround
.chkPunchNoSuper:
	; FDF+P -> Psycho Sword
	mMvIn_ChkDir MoveInput_FDF, MoveInit_Athena_PsychoSword
	; DB+P -> Psycho Ball
	mMvIn_ChkDir MoveInput_DB, MoveInit_Athena_PsychoBall
	; End
	jp   MoveInputReader_Athena_NoMove
.chkKick:
	; BDF+K -> Psycho Reflector
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Athena_PsychoReflector
	; End
	jp   MoveInputReader_Athena_NoMove
	
; =============== MoveInit_Athena_PsychoBall ===============	
MoveInit_Athena_PsychoBall:
	mMvIn_ValProjActive MoveInputReader_Athena_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_ATHENA_PSYCHO_BALL_L, MOVE_ATHENA_PSYCHO_BALL_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Athena_MoveSet
	
; =============== MoveInit_Athena_PsychoReflector ===============
MoveInit_Athena_PsychoReflector:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_ATHENA_PSYCHO_REFLECTOR_L, MOVE_ATHENA_PSYCHO_REFLECTOR_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREFLECT, [hl]
	jp   MoveInputReader_Athena_MoveSet
	
; =============== MoveInit_Athena_PsychoSword ===============
MoveInit_Athena_PsychoSword:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_ATHENA_PSYCHO_SWORD_L, MOVE_ATHENA_PSYCHO_SWORD_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Athena_MoveSet
	
; =============== MoveInit_Athena_PhoenixArrow ===============
MoveInit_Athena_PhoenixArrow:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_ATHENA_PHOENIX_ARROW_L, MOVE_ATHENA_PHOENIX_ARROW_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Athena_MoveSet
	
; =============== MoveInit_Athena_ShCrystGround ===============
MoveInit_Athena_ShCrystGround:
	mMvIn_ValProjActive MoveInputReader_Athena_NoMove
	
	; Don't start the move if a projectile sprite is visible.
	; Normally it would be enough to use mMvIn_ValProjActive, 
	; but Athena can reflect projectiles, and when that happens 
	; PF0B_PROJACTIVE isn't updated (by mistake?).
	ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
	add  hl, de								; Seek to the projectile status (2 OBJInfo after the player)
	bit  OSTB_VISIBLE, [hl]					; Is it visible?
	jp   nz, MoveInputReader_Athena_NoMove	; If so, don't start the move.
	
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Athena_MoveSet
	
; =============== MoveInputReader_Athena_MoveSet ===============
MoveInputReader_Athena_MoveSet:
	scf
	ret
; =============== MoveInputReader_Athena_NoMove ===============
MoveInputReader_Athena_NoMove:
	or   a
	ret
	
; =============== MoveC_Athena_PsychoBall ===============
; Move code for Athena's Psycho Ball (MOVE_ATHENA_PSYCHO_BALL_L, MOVE_ATHENA_PSYCHO_BALL_H).
; Horizontal projectile.
; See also: MoveC_Ryo_KoOuKenG
MoveC_Athena_PsychoBall:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
	
		; How long to stay in #2 after the projectile spawns?
		; The heavy version stays for longer.
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; HL = Ptr to anim speed
		cp   MOVE_ATHENA_PSYCHO_BALL_H	; Doing the heavy version?
		jp   z, .obj0_setSpeedH			; If so, jump
	.obj0_setSpeedL:
		ld   [hl], $0C
		jp   .anim
	.obj0_setSpeedH:
		ld   [hl], $18
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Athena_PsychoBall
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Athena_PsychoReflector ===============
; Move code for Athena's Psycho Reflector (MOVE_ATHENA_PSYCHO_REFLECTOR_L, MOVE_ATHENA_PSYCHO_REFLECTOR_H).
; In this game, the reflector is a literal shield.
MoveC_Athena_PsychoReflector:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .chkHit
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $04, .chkEnd
; --------------- frame #3 ---------------
; Shield disappears.
	jp   .anim
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		; Animate the shield as fast as possible
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		
		mMvC_PlaySound SCT_BARRIER
		
		; Determine how long the shield is active (loop count from #2 to #1)
		mMvC_ChkMove MOVE_ATHENA_PSYCHO_REFLECTOR_H, .obj0_setLoopH
	.obj0_setLoopL:
		ld   hl, iPlInfo_Athena_PsychoReflector_LoopCount
		add  hl, bc
		ld   [hl], $04
		jp   .anim
	.obj0_setLoopH:
		ld   hl, iPlInfo_Athena_PsychoReflector_LoopCount
		add  hl, bc
		ld   [hl], $08
		jp   .anim
		
; --------------- frame #2 ---------------
; Shield frame #1
.obj2:
	mMvC_ValFrameEnd .chkHit
		; If the loop counter didn't elapse, loop back to #1
		ld   hl, iPlInfo_Athena_PsychoReflector_LoopCount
		add  hl, bc
		dec  [hl]					; Is the counter elapsed?
		jp   z, .anim				; If it did, allow continuing to #3
		mMvC_SetFrame $01, $00
		jp   .ret
; --------------- common hit check / frames #1-2 ---------------
; Shield frame #0
.chkHit:
	; If the opponent is hit, switch to #3
	mMvC_ValHit .anim
		mMvC_SetFrame $03, $00
		jp   .ret
; --------------- frame #4 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== MoveC_Athena_PsychoSword ===============
; Move code for Athena's Psycho Sword (MOVE_ATHENA_PSYCHO_SWORD_L, MOVE_ATHENA_PSYCHO_SWORD_H)
MoveC_Athena_PsychoSword:
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
		mMvC_ChkFrame $06, .chkGravity
		mMvC_ChkFrame $07, .chkEnd
; --------------- frame #0 ---------------	
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_PlaySound SFX_SPECIAL
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------	
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_SetMoveH $0800
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set different jump speed depending on attack strength
		mMvC_ChkMove MOVE_ATHENA_PSYCHO_SWORD_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj1_chkGravity
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj1_chkGravity
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj1_chkGravity:
		jp   .chkGravity
.obj1_cont:
	; Immediately switch to #2, since the Y speed is always > -$0A.
	; Unlike 96, this does not deal low continuous damage, but rather a single large hit
	; at the end of the frames.
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .chkGravity ; YSpeed > -$0A? If not, jump
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .chkGravity
; --------------- frame #2 ---------------	
.obj2:
	; Identical to .obj1_cont, more immediate damage
	mMvC_ValNextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE, .chkGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .chkGravity

; frames #3-5 handle the straight upwards part of the DP, continuing the animation when reaching a Y Speed threshold
; --------------- frame #3 ---------------
; Immediate threshold, to clear the horizontal speed as soon as possible.
.obj3:
	ld   a, -$0A
	jp   .chkThresholdY
; --------------- frame #4 ---------------	
.obj4:
	ld   a, -$03
	jp   .chkThresholdY
; --------------- frame #5 ---------------	
.obj5:
	ld   a, +$00
; --------------- common YSpeed threshold check / frames #3-5 ---------------
.chkThresholdY:
	ld   h, ANIMSPEED_NONE			; Manual control as always
	call OBJLstS_ReqAnimOnGtYSpeed	; mMvC_NextFrameOnGtYSpeed <A>, ANIMSPEED_NONE
	jp   nc, .chkGravity			; YSpeed >= Threshold? If not, jump
	mMvC_SetSpeedH $0000			; No horizontal movement on these three frames
	jp   .chkGravity
	
; --------------- common gravity handler ---------------
; If we touch the ground at any point between #1-#7, switch to #8.
.chkGravity:
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $07, $07
		jp   .ret
; --------------- frame #8 ---------------	
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		;--
		; [POI] Not used.
		ld   hl, iPlInfo_Athena_PsychoSword_77
		add  hl, bc
		ld   [hl], $00
		;--
		jr   .ret
; --------------- common ---------------	
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Athena_PhoenixArrow ===============
; Move code for Athena's Phoenix Arrow (MOVE_ATHENA_PHOENIX_ARROW_L, MOVE_ATHENA_PHOENIX_ARROW_H).
MoveC_Athena_PhoenixArrow:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj2
		mMvC_ChkFrame $05, .obj5
		mMvC_ChkFrame $06, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		jp   .anim
; --------------- frame #1 ---------------
; Diagonal forward-down dive from the air.
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_ChkMove MOVE_ATHENA_PHOENIX_ARROW_H, .obj1_setDashH
	.obj1_setDashL: ; Light
		mMvC_SetSpeedH +$0300
		mMvC_SetSpeedV +$0200
		jp   .obj1_cont
	.obj1_setDashH: ; Heavy
		mMvC_ChkMaxPow .obj1_setDashE
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV +$0180
		jp   .obj1_cont
	.obj1_setDashE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV +$0000
.obj1_cont:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		jp   .doGravity
; --------------- frames #2,4 ---------------
; Again.
.obj2:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID1, $00
		jp   .doGravity
; --------------- frame #3 ---------------
; Again.
.obj3:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		jp   .doGravity
; --------------- frame #5 ---------------
; Again.
.obj5:
	mMvC_ValFrameEnd .doGravity
		; Loop to #2 if we didn't touch the ground by the end of the frame
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		mMvC_SetFrameOnEnd $02
		jp   .doGravity
; --------------- frames #1-5 / common gravity check ---------------
.doGravity:
	mMvC_ChkGravityHV $0018, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		
		; The heavy version performs a kick at the end, by switching to a separate move.
		; (In 96, the code for it would be directly integrated into this move)
		; The light one doesn't, and continues to #6 instead.
		mMvC_ChkMove MOVE_ATHENA_PHOENIX_ARROW_L, .doGravity_setNextL
	.doGravity_setNextH:
		ld   a, MOVE_ATHENA_PHOENIX_ARROW_KICK_H
		call MoveInputS_SetSpecMove_StopSpeed
		jp   .ret
	.doGravity_setNextL:
		mMvC_SetLandFrame $06, $08
		jp   .ret
; --------------- frame #6 ---------------
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
	
; =============== MoveC_Athena_PhoenixArrowKick ===============
; Move code for the kick that ends the heavy version of Athena's Phoenix Arrow (MOVE_ATHENA_PHOENIX_ARROW_KICK_H).
MoveC_Athena_PhoenixArrowKick:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	; No explicit autocorrect unlike 96, because this is handled as a separate move.
	; And starting a new move makes the player face the opponent.
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $0A
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $06
		jp   .anim
; --------------- frame #2 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Athena_ShCryst ===============
; Move code for Athena's Shining Crystal Bit (MOVE_ATHENA_SHINING_CRYSTAL_BIT_S).
; Significantly simpler than the version in 96.
MoveC_Athena_ShCryst:
IF VER_EN
	call Play_Pl_MoveByColiBoxOverlapX
ENDC
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj5
		
; --------------- frame #0 ---------------
; Startup.
.obj0:

	;
	; For some reason, these actions happen a few frames before the
	; actual mMvC_ValFrameEnd triggers.
	; This is so pointless that the English version (and by extension, 96) got rid of this,
	; executing the actions alongside the other "end of frame" code.
	;
	; English 95 still keeps the old iteration though, unreferenced.
	;
	
IF VER_EN
	; While at the end of the frame...
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		; Loop initial two-sphere part (#2 to #1) $0E times.
		ld   hl, iPlInfo_Athena_ShCryst_LoopTimer
		add  hl, bc
		ld   [hl], $0E
		
		; Initialize the projectile
		call Task_PassControlFar
		call ProjInit_Athena_ShCrystCharge
		call Task_PassControlFar
		
		; Play ching SGB/DMG SFX
		mMvC_PlaySound SCT_SHCRYSTSPAWN
		call Task_PassControlFar
		jp   .anim
	
.obj0_unused_old:
ENDC

	ld   hl, iOBJInfo_FrameLeft
	add  hl, de
	ld   a, [hl]
	cp   $03				; 3 frames left?
	jp   z, .obj0_initProj	; If so, show the charged projectile
	cp   $02				; 2 frames left?
	jp   z, .obj0_playSFX	; If so, play effect SFX
	
	; While at the end of the frame...
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		; Loop initial two-sphere part (#2 to #1) $0E times.
		ld   hl, iPlInfo_Athena_ShCryst_LoopTimer
		add  hl, bc
		ld   [hl], $0E
		jp   .anim
.obj0_initProj:
	; Initialize the projectile
	call Task_PassControlFar
	call ProjInit_Athena_ShCrystCharge
	call Task_PassControlFar
	jp   .anim
	
.obj0_playSFX:
	; Play ching SGB/DMG SFX
	mMvC_PlaySound SCT_SHCRYSTSPAWN
	jp   .anim
	
; --------------- frame #1 ---------------
; Phase 1 - double small sphere.
.obj1:
	; Just animates as part of the charge loop.
	jp   .anim

; --------------- frame #2 ---------------
; Phase 1 - double small sphere + input check + loop check.
.obj2:
	mMvC_ValFrameEnd .anim
		; We're at the end of #2, check if we're looping back to #1.
		
		; If the counter elapsed, continue to #3.
		ld   hl, iPlInfo_Athena_ShCryst_LoopTimer
		add  hl, bc
		dec  [hl]		; LoopTimer--
		jp   z, .anim	; Did it elapse? If so, jump
		
		; Holding A ends the move early.
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		bit  KEYB_A, [hl]			; Holding A?
		jp   nz, .part1_earlyEnd	; If so, jump
		
		; Main input logic during the first phase of the move.
		; While the projectile code makes a small sphere orbit around Athena,
		; we check for the DF(+P) input:
		;
		; Performing it quickly switches to #4, past the point where the first
		; part of the move would naturally end.
		;
		; DF -> Next Phase
		mMvIn_ChkDir MoveInput_DF, .part1_startPart2L
		
		; Loop back to #1
		mMvC_SetFrame $01, $01
		jp   .ret
	; --------------- frame #2 / common phase 2 switch ---------------
	; Phase 1 - Switches to the second phase through directional inputs.
	.part1_startPart2L:
		; Start from a clean buffer
		call Play_Pl_ClearJoyDirBuffer
		
		; Switch to #4
		mMvC_SetFrame $04, $01
		
		; Slow down orbiting speed (new proj mode)
		call MoveS_Athena_ShCryst_SetOrbitNear
		jp   .ret
		
	; --------------- frames #2-3 / early end ---------------
	; Phase 1 - Ends the move immediately (as it's called under mMvC_ValFrameEnd)
	.part1_earlyEnd:
		call Task_PassControlFar
		jp   .end
; --------------- frame #3 ---------------
; Phase 1 - Last frame for the first phase.
.obj3:
	mMvC_ValFrameEnd .anim
	
		; If not holding B, the move ends immediately.
		; To throw the projectile, we must held B at least until phase 2 starts.
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		bit  KEYB_B, [hl]
		jp   z, .part1_earlyEnd
		
		; Set orbiting mode to projectile
		call MoveS_Athena_ShCryst_SetOrbitNear
		jp   .anim
		
; --------------- frame #4 ---------------
; Phase 2 - Charging up the projectile.
; During this phase, the projectile orbits around Athena's hand, slowing down
; until it almost stops moving over it.
.obj4:
	mMvC_ValFrameEnd .anim
		; Set a significant delay after releasing the projectile.
		mMvC_SetAnimSpeed $14
		
		; Note how there's no automatic release unlike 96.
		
		; If the player releases B, the projectile is thrown
		ld   hl, iPlInfo_JoyKeys
		add  hl, bc
		bit  KEYB_B, [hl]		; Holding B?
		jp   nz, .ret			; If so, keep waiting
		jp   .anim				; Otherwise, continue to #5
		
; --------------- frame #5 ---------------
; Phase 3 - Throwing the projectile.
.obj5:
	mMvC_ValFrameStartFast .obj5_cont
		; Save the damage
		mMvC_SetDamageNext $12, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT
		; Apply it to the projectile
		call Play_Proj_CopyMoveDamageFromPl
		; Throw the sphere projectile.
		call ProjInit_Athena_ShCrystThrown
.obj5_cont:
	mMvC_ValFrameEnd .anim
	
; --------------- common ---------------
.end:
	call Play_Pl_EndMove
	jr   .ret
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Athena_ShCrystThrown ===============
; Initializes the projectile for Athena's Shining Crystal Bit after it gets thrown (phase 3).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Athena_ShCrystThrown:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Athena_ShCrystThrown)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Athena_ShCrystThrown)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Athena_ShCrystThrown)	; iOBJInfo_OBJLstPtrTbl_High
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
				mMvC_SetMoveV -$0400
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			;
			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			ld   hl, +$0400
			jp   .setSpeedH
		.fldMaxPow:
			ld   hl, +$0200
		.setSpeedH:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== ProjInit_Athena_ShCrystCharge ===============
; Initializes the projectile for Athena's Shining Crystal Bit before it gets thrown.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Athena_ShCrystCharge:
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
			ld   [hl], BANK(ProjC_Athena_ShCrystCharge)	; BANK $18 ; iOBJInfo_Play_CodeBank
			inc  hl
			ld   [hl], LOW(ProjC_Athena_ShCrystCharge)	; iOBJInfo_Play_CodePtr_Low
			inc  hl
			ld   [hl], HIGH(ProjC_Athena_ShCrystCharge)	; iOBJInfo_Play_CodePtr_High

			; Write sprite mapping ptr for this projectile.
			ld   hl, iOBJInfo_BankNum
			add  hl, de
			ld   [hl], BANK(OBJLstPtrTable_Proj_Athena_ShCrystCharge)	; BANK $01 ; iOBJInfo_BankNum
			inc  hl
			ld   [hl], LOW(OBJLstPtrTable_Proj_Athena_ShCrystCharge)	; iOBJInfo_OBJLstPtrTbl_Low
			inc  hl
			ld   [hl], HIGH(OBJLstPtrTable_Proj_Athena_ShCrystCharge)	; iOBJInfo_OBJLstPtrTbl_High
			inc  hl
			ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


			; Set animation speed.
			ld   hl, iOBJInfo_FrameLeft
			add  hl, de
			ld   [hl], $00	; iOBJInfo_FrameLeft
			inc  hl
			ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal
			
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
			mMvC_SetMoveV -$1000
	
			; Save a copy of the player's position to the projectile's slot.
			; This is because it's used as the projectile's origin.
			; This exact thing will be also done when updating the origin through ProjC_Athena_ShCrystCharge_SetOrigin (English version only)
			push bc
				; BC = Ptr to X Position
				ld   hl, iOBJInfo_X
				add  hl, de
				push hl
				pop  bc
				
				; Copy it over to iOBJInfo_Proj_ShCrystCharge_OrigX
				ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
				add  hl, de		
				ld   a, [bc]	; A = X Position
				ldi  [hl], a	; Save it to iOBJInfo_Proj_ShCrystCharge_OrigX, seek to iOBJInfo_Proj_ShCrystCharge_OrigY
				
				; Copy over the Y position to iOBJInfo_Proj_ShCrystCharge_OrigY
				inc  bc			; Seek to iOBJInfo_XSub
				inc  bc			; Seek to iOBJInfo_Y
				ld   a, [bc]	; A = Y Position
				ld   [hl], a	; Save it to iOBJInfo_Proj_ShCrystCharge_OrigY
			pop  bc
			
			; Set priority value
			ld   hl, iOBJInfo_Play_Priority
			add  hl, de
			ld   [hl], PROJ_PRIORITY_NODESPAWN
				
			; Initialize the X and Y indexes for the sine coords table.
			; For the electron-like movement, the indexes are set up so that the projectile
			; initially moves right and down, and increment by $20 and $22 respectively
			; so they won't sync.
			xor  a
			ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosId
			add  hl, de
			ld   [hl], $00	; iOBJInfo_Proj_ShCrystCharge_XPosId ($0000, then right)
			inc  hl ; neg
			ld   [hl], $80	; iOBJInfo_Proj_ShCrystCharge_YPosId ($0000, then down)
			
			; Multipliers start at $00
			inc  hl
			ldi  [hl], a	; iOBJInfo_Proj_ShCrystCharge_XPosMul
			ld   [hl], a	; iOBJInfo_Proj_ShCrystCharge_YPosMul
			
			; Start from the first phase
			ld   hl, iOBJInfo_Proj_ShCrystCharge_OrbitMode
			add  hl, de
			ld   [hl], PROJ_SHCRYST_ORBITMODE_OVAL

			
			; 8 times for smooth origin transition between Slow and Hold mode
			ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigMoveLeft
			add  hl, de
			ld   [hl], $08
		pop  de
	pop  bc
	ret  
	
; =============== MoveS_Athena_ShCryst_SetOrbitNear ===============
; Sets the initial orbit mode for "Phase 2".
; This is when Athena holds an hand up, with the projectile's orbit slowly
; getting smaller. 
; IN
; - DE: Ptr to player wOBJInfo
MoveS_Athena_ShCryst_SetOrbitNear:
	push bc
		push de
			; BC = DE = Ptr to wOBJInfo
			push de
			pop  bc
			
			; DE = Ptr to the wOBJInfo of our projectile
			ld   hl, (OBJINFO_SIZE*2) ; 2 slots after ours
			add  hl, bc
			push hl
			pop  de
			
			; Set the new orbit mode
			ld   hl, iOBJInfo_Proj_ShCrystCharge_OrbitMode
			add  hl, de
			ld   [hl], PROJ_SHCRYST_ORBITMODE_SLOW
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Athena_ShCrystCharge ===============
; Projectile code for Athena's Shining Crystal Bit while it gets charged up.
; While charging, the projectile always orbits something.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo for the projectile
ProjC_Athena_ShCrystCharge:

IF VER_EN
	; 30FPS exec, across players
	call ProjC_Athena_ShCrystCharge_CanExec
	ret  c
ENDC
	
	; Make the projectile move in an expanding spiral motion if the move ended early
	; (meaning that we're no longer doing the super).
	; This check was relegated to MoveS_Athena_ShCryst_SetOrbitExpand in 96.
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS
	jp   nz, .switchToSpiral
	
	; Depending on the phase of the projectile...
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrbitMode
	add  hl, de
	ld   a, [hl]
	cp   PROJ_SHCRYST_ORBITMODE_OVAL
	jp   z, ProjC_Athena_ShCrystCharge_Oval
	cp   PROJ_SHCRYST_ORBITMODE_SLOW
	jp   z, ProjC_Athena_ShCrystCharge_Slow
	cp   PROJ_SHCRYST_ORBITMODE_HOLD
	jp   z, ProjC_Athena_ShCrystCharge_Hold
	

.switchToSpiral:

	;
	; The spiral motion isn't an oval-like orbit, and it gets its own different code pointer
	; so it won't be able to switch to some other mode.
	;

	; Reset indexes to fixed values
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosId
	add  hl, de
	ld   [hl], $00	; iOBJInfo_Proj_ShCrystCharge_XPosId ($0000, moves right)
	inc  hl
	ld   [hl], $40	; iOBJInfo_Proj_ShCrystCharge_YPosId ($4000, rightmost value, so first to move left)
	
	; Move deals no damage
	ld   hl, iOBJInfo_Play_DamageVal
	add  hl, de
	xor  a
	ldi  [hl], a	; iOBJInfo_Play_DamageVal
	ldi  [hl], a	; iOBJInfo_Play_DamageHitTypeId
	ld   [hl], a	; iOBJInfo_Play_DamageFlags3
	
	; Set a new code pointer
	ld   hl, iOBJInfo_Play_CodeBank
	add  hl, de
	ld   [hl], BANK(ProjC_Athena_ShCrystCharge_Spiral) 	; BANK $18 ; iOBJInfo_Play_CodeBank
	inc  hl
	ld   [hl], LOW(ProjC_Athena_ShCrystCharge_Spiral)	; iOBJInfo_Play_CodePtr_Low
	inc  hl
	ld   [hl], HIGH(ProjC_Athena_ShCrystCharge_Spiral)	; iOBJInfo_Play_CodePtr_High
	
	; Display spiral for $10 frames
	ld   hl, iOBJInfo_Proj_ShCrystCharge_DespawnTimer
	add  hl, de
	ld   [hl], $10	; iOBJInfo_Proj_ShCrystCharge_DespawnTimer
	ret
	
; =============== ProjC_Athena_ShCrystCharge_Oval ===============
; Initial electron-like mode.	
ProjC_Athena_ShCrystCharge_Oval:

IF VER_EN
	;
	; First, always sync the origin 16px above, 8px behind the player's origin
	;
	ld   b, -$08
	ld   c, -$10
	call ProjC_Athena_ShCrystCharge_SetOrigin
ENDC

	;
	; Update the X and Y coordinates, starting with the former.
	; In short, positions are read from a table of 16bit values (pixel + subpixels)
	; and exponentially multiplied ( << ) by some value.
	; Each coordinate has its own index to the table and multiplier, but the table
	; of coordinates is the same.
	;

	;
	; X POSITION
	;
	; XPos = POW(Coords[XPosId+$16], MAX(XPosMul, 4))
	;        -> Where XPosMul is incremented every 8 frames.
	;

	;
	; Slowly increment the X Position multiplier from $00 to $04 every 8 frames.
	;
	
	; DecTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = DecTimer % $08
	ld   a, [hl]
	and  a, $07
	ld   b, a
	
	; Seek to XPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_XPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	
	; If the multiplier is already $04, don't increment it further
	ld   a, [hl]		; A = XPosMul
	cp   $04			; XPosMul == 4?
	jp   z, .getX		; If so, skip
	
	; Otherwise, increment the multiplier if (DecTimer % 8) != 0
	ld   a, b			
	or   a				; DecTimer != 0?
	jp   nz, .getX		; If so, skip
	inc  [hl]			; Otherwise, XPosMul++	
	
.getX:

	;
	; Read out to B the relative X position off the table.
	;
		
	; Get/save the new index to the table of coords.
	; A = XPosId + $16
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosId
	add  hl, de
	ld   a, [hl]
	add  a, $16		; Index += $16
	ld   [hl], a	; and save back the updated index
	
	; B = Value multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. X Position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	;
	; Set the new X position.
	; ProjX = OriginX + RelX
	;
	
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	ld   a, [hl]			; A = X Origin
	add  b					; A += B
	ld   hl, iOBJInfo_X		
	add  hl, de				; HL = Ptr to X Pos
	ld   [hl], a			; Update it
	
	;--
	
	;
	; Y POSITION
	; Same thing, but with a different addresses/settings.
	;
	
	; DecTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = DecTimer % $08
	ld   a, [hl]
	and  a, $07
	ld   b, a
	
	; Seek to YPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_YPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	
	; If the multiplier is already $05, don't increment it further
	ld   a, [hl]		; A = XPosMul
	cp   $05			; YPosMul == 5?
	jp   z, .getY		; If so, skip
	
	; Otherwise, increment the multiplier if (DecTimer % 8) != 0
	ld   a, b			
	or   a				; DecTimer != 0?
	jp   nz, .getY		; If so, skip
	inc  [hl]			; Otherwise, YPosMul++	
.getY:
	; Get/save table index
	; A = LastId + $22
	; This extra $02 compared to the horz one makes the vertical movement faster than the horizontal one.
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosId
	add  hl, de
	ld   a, [hl]
	add  a, $22
	ld   [hl], a	; and save it back
	
	; B = Multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. Y position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	; ProjY = OrigY + RelY
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigY
	add  hl, de
	ld   a, [hl]			; A = Y Origin
	add  b					; A += B
	ld   hl, iOBJInfo_Y		
	add  hl, de				; HL = Ptr to Y Pos
	ld   [hl], a			; Update it
	ret
	
; =============== ProjC_Athena_ShCrystCharge_Hold ===============
; Only different thing from ProjC_Athena_ShCrystCharge_Slow in that
; the origin is on Athena's hand.
; It's not even necessary anyway, since ProjC_Athena_ShCrystCharge_Slow aligns it perfectly already.
ProjC_Athena_ShCrystCharge_Hold:
	; [POI] This branch existed in the Japanese version as well, but did not contain any code.
IF VER_EN
	; Origin is...
	ld   b, +$00 ; 
	ld   c, -$18 ; $18px above player
	call ProjC_Athena_ShCrystCharge_SetOrigin
	; Fall-through
ENDC
	
; =============== ProjC_Athena_ShCrystCharge_Slow ===============
; Like oval mode, but the arc keeps getting smaller.
ProjC_Athena_ShCrystCharge_Slow:

	;
	; First, slowly move the origin over Athena's hand for a smooth transition
	; to Hold mode. When we're done, switch to Hold mode when we're done.
	;
	; This moves the origin 1px backwards and 1px upwards every 8 frames,
	; and it gets done $08 times (what iOBJInfo_Proj_ShCrystCharge_OrigMoveLeft was set to).
	;
	; Considering the origin before getting here is set to:
	; - $00px horz
	; - $10px up
	; By the time we switch to Hold mode, it will be:
	; - $08px back
	; - $18px up
	; Which is the exact origin used by that mode.
	;
	
	; Only do this every 8 frames
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigMoveTimer
	add  hl, de
	inc  [hl]		; Timer++
	ld   a, [hl]		
	and  a, $07		; Timer % 8 != 0?
	jp   nz, .doX	; If so, skip
	
	; Don't do this if we switched to Hold mode already, as that uses its own origin.
	; (it's the only point OrigMoveLeft can be 0 here)
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigMoveLeft
	add  hl, de
	ld   a, [hl]
	or   a			; OrigMoveLeft == 0?
	jp   z, .doX	; If so, skip
	
	; Decrement counter of remaining UB movements.
	; If this is the last time we're getting here (OrigMoveLeft-1 == 0), switch to Hold mode.
	dec  [hl]				; MoveLeft--
	jp   nz, .moveOrigBack	; MoveLeft != 0? If so, skip
	; Otherwise, switch to Hold mode
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrbitMode
	add  hl, de
	ld   [hl], PROJ_SHCRYST_ORBITMODE_HOLD
	
.moveOrigBack:
	; Move origin backwards by 1px.
	; Determine which side the projectile is facing first.
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Facing right? (originally thrown on 1P side)
	jp   nz, .moveOrigL		; If so, move it left (backwards for 1P side)
	; Otherwise, move it right (backwards for 2P side)
.moveOrigR:
	; OrigX++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	inc  [hl]
	jp   .moveOrigU
.moveOrigL:
	; OrigX--
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	dec  [hl]
	
.moveOrigU:
	; Move origin up by 1px
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigY
	add  hl, de
	dec  [hl]
	
.doX:
	;
	; Then, update the X and Y coordinates, starting with the former.
	; This process is very similar to what's done in ProjC_Athena_ShCrystCharge_Oval,
	; except that the multipliers get decremented slowly (not incremented every frame)
	; and that the indexes are incremented by a different value.
	;

	;
	; X POSITION
	;

	;
	; Slowly decrement the X Position multiplier from $05 to $01 every $20 frames.
	;
	
	; DecTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = DecTimer % $20
	ld   a, [hl]
	and  a, $1F
	ld   b, a
	
	; Seek to XPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_XPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	
	; If the multiplier is already $01, don't decrement it further
	ld   a, [hl]		; A = XPosMul
	cp   $01			; XPosMul == 1?
	jp   z, .getX		; If so, skip
	
	; Otherwise, decrement the multiplier if (DecTimer % $20) != 0
	ld   a, b			
	or   a				; DecTimer != 0?
	jp   nz, .getX		; If so, skip
	dec  [hl]			; Otherwise, XPosMul--	
	
.getX:
	;
	; Read out to B the relative X position off the table, then apply it.
	;
	
	; Get/save table index
	; A = LastId + $20
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosId
	add  hl, de
	ld   a, [hl]
	add  a, $20
	ld   [hl], a	; and save it back
	
	; B = Multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. X position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	; ProjX = OrigX + RelX
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	ld   a, [hl]			; A = X Origin
	add  b					; A += B
	ld   hl, iOBJInfo_X		
	add  hl, de				; HL = Ptr to X Pos
	ld   [hl], a			; Update it
	
.doY:
	;
	; Y POSITION
	;
	
	;
	; Decrement the Y Position multiplier from $06 to $01 every *alternating* $20 frames.
	; (that is, decrement for $20 continuous frames, then nothing for the next $20, and so on).
	; This causes the Y Multiplier to decrement much faster than the horizontal one, though
	; because YPosMulDecTimer (and XPosMulDecTimer) don't get initialized, the actual point this happens
	; is effectively randomized depending on how long we held the projectile the previous times.
	;
	
	; DecTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = DecTimer & $20
	ld   a, [hl]
	and  a, $20
	ld   b, a
	
	; Seek to YPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_YPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	
	; If the multiplier is already $01, don't decrement it further
	ld   a, [hl]		; A = YPosMul
	cp   $01			; YPosMul == 1?
	jp   z, .getY		; If so, skip
	
	; Otherwise, decrement the multiplier if (DecTimer & $20) != 0
	ld   a, b			
	or   a				; DecTimer != 0?
	jp   nz, .getY		; If so, skip
	dec  [hl]			; Otherwise, YPosMul--	
	
.getY:
	;
	; Read out to B the relative Y position off the table, then apply it.
	;
	
	; Get/save table index
	; A = LastId + $1F
	; This makes the vertical movement slightly slower than the horizontal one ($20).
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosId
	add  hl, de
	ld   a, [hl]
	add  a, $1F
	ld   [hl], a	; and save it back
	
	; B = Multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. Y position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	; ProjY = OrigY + RelY
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigY
	add  hl, de
	ld   a, [hl]			; A = Y Origin
	add  b					; A += B
	ld   hl, iOBJInfo_Y		
	add  hl, de				; HL = Ptr to Y Pos
	ld   [hl], a			; Update it
	ret
	
; =============== ProjC_Athena_ShCrystCharge_Spiral ===============
; Spiral outwards motion, used to despawn the projectile when the move ends early.
; Code-wise, it's very similar to the other modes.
ProjC_Athena_ShCrystCharge_Spiral:
IF VER_EN
	; 30FPS exec, across players
	call ProjC_Athena_ShCrystCharge_CanExec
	ret  c
ENDC
	; Not necessary, already done by .switchToSpiral
	ld   hl, iOBJInfo_Play_DamageVal
	add  hl, de
	xor  a
	ldi  [hl], a	; iOBJInfo_Play_DamageVal
	ldi  [hl], a	; iOBJInfo_Play_DamageHitTypeId
	ld   [hl], a	; iOBJInfo_Play_DamageFlags3
	
	; Despawn the projectile when the timer expires
	ld   hl, iOBJInfo_Proj_ShCrystCharge_DespawnTimer
	add  hl, de
	dec  [hl]
	jp   z, OBJLstS_Hide
	
.doX:
	;
	; X POSITION
	;

	;
	; Quickly increment the X Position multiplier every 4 frames, with no upper limit.
	;
	
	; IncTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = IncTimer % 4
	ld   a, [hl]
	and  a, $03
	ld   b, a
	
	; Seek to XPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_XPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	
	; Increment the multiplier with no upper limit if (IncTimer % 4) != 0
	ld   a, b
	or   a				; IncTimer % 4 != 0?
	jp   nz, .getX		; If so, skip
	inc  [hl]			; Otherwise, XPosMul++	
	
.getX:
	;
	; Read out to B the relative X position off the table, then apply it.
	;
	
	; Get/save table index
	; A = LastId + $20
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosId
	add  hl, de
	ld   a, [hl]
	add  a, $20
	ld   [hl], a	; and save it back
	
	; B = Multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_XPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. X position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	; ProjX = OrigX + RelX
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	ld   a, [hl]			; A = X Origin
	add  b					; A += B
	ld   hl, iOBJInfo_X		
	add  hl, de				; HL = Ptr to X Pos
	ld   [hl], a			; Update it
	
.doY:
	;
	; Y POSITION
	;
	
	;
	; Quickly increment the X Position multiplier every 8 frames, with no upper limit.
	;
	
	; IncTimer++
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMulUpdTimer
	add  hl, de
	inc  [hl]
	
	; Get divider mask.
	; B = IncTimer % 8
	ld   a, [hl]
	and  a, $07
	ld   b, a
	
	; Seek to YPosMul
	; HL = Ptr to iOBJInfo_Proj_ShCrystCharge_YPosMul
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	
	; Increment the multiplier with no upper limit if (IncTimer % 8) != 0
	ld   a, b
	or   a				; IncTimer % 8 != 0?
	jp   nz, .getY		; If so, skip
	inc  [hl]			; Otherwise, YPosMul++	
.getY:
	;
	; Read out to B the relative Y position off the table, then apply it.
	;
	
	; Get/save table index
	; A = LastId + $20
	; This is exactly the same as the horizontal one, resulting in a spiral motion
	; as the multipliers grow without limit.
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosId
	add  hl, de
	ld   a, [hl]
	add  a, $20
	ld   [hl], a	; and save it back
	
	; B = Multiplier
	ld   hl, iOBJInfo_Proj_ShCrystCharge_YPosMul
	add  hl, de
	ld   b, [hl]
	
	; B = Rel. Y position
	call ProjC_Athena_ShCrystCharge_GetSinePos
	
	; ProjY = OrigY + RelY
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigY
	add  hl, de
	ld   a, [hl]			; A = Y Origin
	add  b					; A += B
	ld   hl, iOBJInfo_Y		
	add  hl, de				; HL = Ptr to Y Pos
	ld   [hl], a			; Update it
	ret
	
IF VER_EN
; =============== ProjC_Athena_ShCrystCharge_CanExec ===============
; Called at the start of the charging projectile code to determine if 
; the rest of the code should be executed.
; This projectile is special in that it executes its code every other
; gameplay frame, alternating between 1P and 2P.
; Even frames -> 2P exec
; Odd  frames -> 1P exec
; IN
; - BC: Ptr to wPlInfo
; OUT
; - C flag: If set, the code should not execute
ProjC_Athena_ShCrystCharge_CanExec:
	ld   hl, iPlInfo_PlId
	add  hl, bc
	ld   a, [hl]
	cp   PL2			; Playing as 2P?
	jp   z, .pl2		; If so, jump
.pl1:
	ld   a, [wTimer]
	bit  0, a			; wPlayTimer % 2 == 0? (even frame)
	jp   z, .retSet		; If so, no exec
	jp   .retClear		; Otherwise, exec it
.pl2:
	ld   a, [wTimer]
	bit  0, a			; wPlayTimer % 2 != 0? (odd frame)
	jp   nz, .retSet	; If so, no exec
.retClear:
	scf
	ccf		; C flag clear
	ret
.retSet:
	scf		; C flag set
	ret
ENDC
	
; =============== ProjC_Athena_ShCrystCharge_GetSinePos ===============
; Gets a value from the coordinates table and shifts it left B times.
; IN
; - A: Index to coordinates table
; - B: Multiplier
; OUT
; - B: Returned position.
;      This will be treated as an X or Y position depending on the context.
ProjC_Athena_ShCrystCharge_GetSinePos:
	push de
		push hl
			; HL = Base 16bit value (for multiplier $00)
			call ProjC_Athena_ShCrystCharge_GetBaseSinePos
			
			; Shift it left B times. B will be at most 6.
			; HL = HL << B
		.loop:
			sla  l			; HL << 1
			rl   h
			dec  b			; Did it all times?
			jp   nz, .loop	; If not, loop
			
			; And move it to BC.
			; Only the high byte (pixel count) is usable, since the subpixels got trashed
			; by the shifting, which is fine as projectile positions don't use subpixels.
			push hl	; BC = HL
			pop  bc
			
		pop  hl
	pop  de
	ret

IF VER_EN
; =============== ProjC_Athena_ShCrystCharge_SetOrigin ===============
; Sets a new origin for the projectile, relative to the player's current position.
; IN
; - B: X Offset.
;      This is relative to the projectile facing *left*, so positive values move it backwards.
; - C: Y Offset.
; - DE: Ptr to wOBJInfo for projectile
ProjC_Athena_ShCrystCharge_SetOrigin:

	;
	; Refresh the base origin first.
	; Copy the player's X and Y positions to iOBJInfo_Proj_ShCrystCharge_Orig*.
	;
	push bc
		push de
			; BC = Ptr to the X Origin of the projectile (Destination)
			ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
			add  hl, de
			push hl
			pop  bc
			
			; HL = Ptr to the player's X position (Source)
			push de
				; This requires seeking back to the player's wOBJInfo.
				; As always, it's 2 slots before the one for the projectile, in DE.
				ld   hl, -(OBJINFO_SIZE*2)
				add  hl, de		; HL = iOBJInfo_Status for player
				
				; Seek to the X position
				ld   de, iOBJInfo_X
				add  hl, de
			pop  de
			
			; Sync the X origin
			ld   a, [hl]	; Read Player X Position
			ld   [bc], a	; Copy it over as new X origin
			
			; Sync the Y origin
			inc  hl			; Seek to iOBJInfo_XSub
			inc  hl			; Seek to iOBJInfo_YSub
			inc  bc			; Seek to iOBJInfo_Proj_ShCrystCharge_OrigY
			ld   a, [hl]	; Read Player Y Position
			ld   [bc], a	; Copy it over as new Y origin
		pop  de
	pop  bc
	
	;
	; Apply the X Offset.
	; Bizzarely, positive offset values make set it backwards here.
	;
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Is the projectile facing right? (initially thrown on the 1P side?)
	jp   nz, .setPosR		; If so, jump
	; Otherwise, it's facing left (2P side)
.setPosL:
	; iOBJInfo_Proj_ShCrystCharge_OrigX += B
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de
	ld   a, [hl]	; A = OrigX
	add  b			; += OffsetX
	ld   [hl], a	; Save it back
	jp   .setPosY
	
.setPosR:
	; iOBJInfo_Proj_ShCrystCharge_OrigX -= B
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigX
	add  hl, de		; HL = Ptr to OrigX
	ld   a, b		; A = -OffsetX
	cpl
	inc  a
	ld   b, [hl]	; B = OrigX
	add  b			; += OffsetX
	ld   [hl], a	; Save it back
	
	;
	; Apply the Y Offset.
	;
.setPosY:
	; iOBJInfo_Proj_ShCrystCharge_OrigY += C
	ld   hl, iOBJInfo_Proj_ShCrystCharge_OrigY
	add  hl, de
	ld   a, [hl]	; A = OrigY
	add  c			; += OffsetY
	ld   [hl], a	; Save it back
	ret
ENDC

; =============== ProjC_Athena_ShCrystCharge_GetBaseSinePos ===============
; Gets a base coordinate position for the projectile from the coordinates table.
; IN
; - A: Position ID.
; OUT
; - HL: Position (pixels + subpixels)
;       This value will be treated as either an X or Y position, depending
;       on the context this ended up getting called.
ProjC_Athena_ShCrystCharge_GetBaseSinePos:
	push bc
		; Generate offset to a table of 2-byte positions
		; BC = A * 2
		ld   b, $00
		ld   c, a
		sla  c
		rl   b
		
		; Offset the table
		ld   hl, .sineTbl
		add  hl, bc
		
		; Read out the raw value to BC
		ld   c, [hl]
		inc  hl
		ld   b, [hl]
		
		; For whatever reason, the raw value isn't directly the base value pre-multiplication.
		; Instead, it's the base value shifted right 6 times (*$40), which is the value that
		; would be used with the max multiplier.
		
		; Since we want the base value though, divide it by $40 (>> 6).
		; As we're only using the upper byte (so what's the point of the low one?), we're fine
		; since 6 < 9 shifts.
		; HL = BC / $40
REPT 6
		sra  b	; >> 1 , 6 times
		rr   c
ENDR
		push bc	; Move it to HL
		pop  hl
		
	pop  bc
	ret
	
; SINE TABLE
; Table of incrementing and decrementing 16bit signed numbers (pixels + subpixels).
; Used in order, one by one, these result in the projectile moving in a smooth sine motion.
; To generate the various movement patterns, the X and Y indexes are incremented by
; different offsets.
.sineTbl: 
	dw $0000
	dw $0192
	dw $0324
	dw $04B5
	dw $0646
	dw $07D6
	dw $0964
	dw $0AF1
	dw $0C7C
	dw $0E06
	dw $0F8D
	dw $1112
	dw $1294
	dw $1413
	dw $1590
	dw $1709
	dw $187E
	dw $19EF
	dw $1B5D
	dw $1CC6
	dw $1E2B
	dw $1F8C
	dw $20E7
	dw $223D
	dw $238E
	dw $24DA
	dw $2620
	dw $2760
	dw $289A
	dw $29CE
	dw $2AFB
	dw $2C21
	dw $2D41
	dw $2E5A
	dw $2F6C
	dw $3076
	dw $3179
	dw $3274
	dw $3368
	dw $3453
	dw $3537
	dw $3612
	dw $36E5
	dw $37AF
	dw $3871
	dw $392B
	dw $39DB
	dw $3A82
	dw $3B21
	dw $3BB6
	dw $3C42
	dw $3CC5
	dw $3D3F
	dw $3DAF
	dw $3E15
	dw $3E72
	dw $3EC5
	dw $3F0F
	dw $3F4F
	dw $3F85
	dw $3FB1
	dw $3FD4
	dw $3FEC
	dw $3FFB
	dw $4000
	dw $3FFB
	dw $3FEC
	dw $3FD4
	dw $3FB1
	dw $3F85
	dw $3F4F
	dw $3F0F
	dw $3EC5
	dw $3E72
	dw $3E15
	dw $3DAF
	dw $3D3F
	dw $3CC5
	dw $3C42
	dw $3BB6
	dw $3B21
	dw $3A82
	dw $39DB
	dw $392B
	dw $3871
	dw $37AF
	dw $36E5
	dw $3612
	dw $3537
	dw $3453
	dw $3368
	dw $3274
	dw $3179
	dw $3076
	dw $2F6C
	dw $2E5A
	dw $2D41
	dw $2C21
	dw $2AFB
	dw $29CE
	dw $289A
	dw $2760
	dw $2620
	dw $24DA
	dw $238E
	dw $223D
	dw $20E7
	dw $1F8C
	dw $1E2B
	dw $1CC6
	dw $1B5D
	dw $19EF
	dw $187E
	dw $1709
	dw $1590
	dw $1413
	dw $1294
	dw $1112
	dw $0F8D
	dw $0E06
	dw $0C7C
	dw $0AF1
	dw $0964
	dw $07D6
	dw $0646
	dw $04B5
	dw $0324
	dw $0192
	dw $0000
	dw $FE6E
	dw $FCDC
	dw $FB4B
	dw $F9BA
	dw $F82A
	dw $F69C
	dw $F50F
	dw $F384
	dw $F1FA
	dw $F073
	dw $EEEE
	dw $ED6C
	dw $EBED
	dw $EA70
	dw $E8F8
	dw $E782
	dw $E611
	dw $E4A3
	dw $E33A
	dw $E1D5
	dw $E074
	dw $DF19
	dw $DDC3
	dw $DC72
	dw $DB26
	dw $D9E0
	dw $D8A0
	dw $D766
	dw $D632
	dw $D505
	dw $D3DF
	dw $D2BF
	dw $D1A6
	dw $D094
	dw $CF8A
	dw $CE87
	dw $CD8C
	dw $CC98
	dw $CBAD
	dw $CAC9
	dw $C9EE
	dw $C91B
	dw $C851
	dw $C78F
	dw $C6D5
	dw $C625
	dw $C57E
	dw $C4DF
	dw $C44A
	dw $C3BE
	dw $C33B
	dw $C2C2
	dw $C252
	dw $C1EB
	dw $C18E
	dw $C13B
	dw $C0F1
	dw $C0B1
	dw $C07B
	dw $C04F
	dw $C02C
	dw $C014
	dw $C005
	dw $C000
	dw $C005
	dw $C014
	dw $C02C
	dw $C04F
	dw $C07B
	dw $C0B1
	dw $C0F1
	dw $C13B
	dw $C18E
	dw $C1EB
	dw $C252
	dw $C2C2
	dw $C33B
	dw $C3BE
	dw $C44A
	dw $C4DF
	dw $C57E
	dw $C625
	dw $C6D5
	dw $C78F
	dw $C851
	dw $C91B
	dw $C9EE
	dw $CAC9
	dw $CBAD
	dw $CC98
	dw $CD8C
	dw $CE87
	dw $CF8A
	dw $D094
	dw $D1A6
	dw $D2BF
	dw $D3DF
	dw $D505
	dw $D632
	dw $D766
	dw $D8A0
	dw $D9E0
	dw $DB26
	dw $DC72
	dw $DDC3
	dw $DF19
	dw $E074
	dw $E1D5
	dw $E33A
	dw $E4A3
	dw $E611
	dw $E782
	dw $E8F8
	dw $EA70
	dw $EBED
	dw $ED6C
	dw $EEEE
	dw $F073
	dw $F1FA
	dw $F384
	dw $F50F
	dw $F69C
	dw $F82A
	dw $F9BA
	dw $FB4B
	dw $FCDC
	dw $FE6E

; =============== MoveC_Heidern_ThrowG ===============
; Move code for Heidern's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Heidern_ThrowG:
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
	
; =============== MoveC_Heidern_ThrowA ===============
; Move code for Heidern's Air Throw (MOVE_SHARED_THROW_A).
; Identical to the standard air throw (MoveC_Base_ThrowA_DirD) except Heidern moves forward when dropping down.
MoveC_Heidern_ThrowA:
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
	; Move forwards 1.5px/frame
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_SetSpeedH +$0180
.obj1_cont:	
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
	; Switch to #2 when touching the ground
	mMvC_ChkGravityHV $0060, .anim
		; When touching the ground, perform the actual throw.
		mMvC_SetLandFrame $02, $01
		mMvC_SetDamage $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== MoveC_Heidern_PunchHN ===============
; Move code for Heidern's:
; - Near Heavy punch (MOVE_SHARED_PUNCH_HN)
; - Near Heavy kick (MOVE_SHARED_KICK_HN)
MoveC_Heidern_PunchHN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
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
	
; =============== MoveInputReader_Heidern ===============
; Special move input checker for HEIDERN.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Heidern:
	mMvIn_Validate Heidern, 2

.chkGround:
	;             SELECT + B                     SELECT + A
	mMvIn_ChkEasy MoveInit_Heidern_FinalBringer, MoveInit_Heidern_NeckRoller
	mMvIn_ChkGA Heidern, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH

.chkPunch:
	; DU+P -> Moon Slasher
	mMvIn_ChkDir MoveInput_DU_Charge, MoveInit_Heidern_MoonSlasher
	; BF+P -> Cross Cutter
	mMvIn_ChkDir MoveInput_BF_Charge, MoveInit_Heidern_CrossCutter
	; FDB+P -> Storm Bringer
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Heidern_StormBringer
	; End
	jp   MoveInputReader_Heidern_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; BDU+K -> Final Bringer
	mMvIn_ChkDir MoveInput_BDU_Charge, MoveInit_Heidern_FinalBringer
.chkKickNoSuper:
	; DU+K -> Neck Roller
	mMvIn_ChkDir MoveInput_DU_Charge, MoveInit_Heidern_NeckRoller
	; End
	jp   MoveInputReader_Heidern_NoMove
	
; =============== MoveInit_Heidern_CrossCutter ===============
MoveInit_Heidern_CrossCutter:
	mMvIn_ValProjActive MoveInputReader_Heidern_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_HEIDERN_CROSS_CUTTER_L, MOVE_HEIDERN_CROSS_CUTTER_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Heidern_MoveSet
	
; =============== MoveInit_Heidern_NeckRoller ===============
MoveInit_Heidern_NeckRoller:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_HEIDERN_NECK_ROLLER_L, MOVE_HEIDERN_NECK_ROLLER_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Heidern_MoveSet
	
; =============== MoveInit_Heidern_StormBringer ===============
MoveInit_Heidern_StormBringer:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_ValStartCmdThrow_StdColi Heidern
		mMvIn_GetLHP MOVE_HEIDERN_STORM_BRINGER_L, MOVE_HEIDERN_STORM_BRINGER_H
		call MoveInputS_SetSpecMove_StopSpeed
		;--
		; Not coming from a super, so no double damage
		ld   hl, iPlInfo_Heidern_StormBringer_FromSuper
		add  hl, bc
		ld   [hl], $00
		;--
		ld   hl, iPlInfo_Flags1
		add  hl, bc
		set  PF1B_INVULN, [hl]
		jp   MoveInputReader_Heidern_MoveSet
	
; =============== MoveInit_Heidern_MoonSlasher ===============
MoveInit_Heidern_MoonSlasher:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_HEIDERN_MOON_SLASHER_L, MOVE_HEIDERN_MOON_SLASHER_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Heidern_MoveSet
	
; =============== MoveInit_Heidern_FinalBringer ===============
MoveInit_Heidern_FinalBringer:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_HEIDERN_FINAL_BRINGER_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Heidern_MoveSet
	
; =============== MoveInputReader_Heidern_MoveSet ===============
MoveInputReader_Heidern_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Heidern_NoMove ===============
MoveInputReader_Heidern_NoMove:
	or   a
	ret  
	
; =============== MoveC_Heidern_CrossCutter ===============
; Move code for Heidern's Cross Cutter (MOVE_HEIDERN_CROSS_CUTTER_L, MOVE_HEIDERN_CROSS_CUTTER_H)
MoveC_Heidern_CrossCutter:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .chkEnd
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
	
		; Determine how long to stay in #2
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]						; A = iPlInfo_MoveId
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de							; HL = Ptr to iOBJInfo_FrameTotal
		cp   MOVE_HEIDERN_CROSS_CUTTER_H	; Doing the heavy version?
		jp   z, .obj2_setSpeedH				; If so, jump
	.obj2_setSpeedL:
		ld   [hl], $08	; iOBJInfo_FrameTotal for light or super
		jp   .anim
	.obj2_setSpeedH:
		ld   [hl], $10	; iOBJInfo_FrameTotal for heavy
		jp   .anim
; --------------- frame #2 ---------------
; Spawn the projectile at the start
.obj2:
	mMvC_ValFrameStartFast .obj2_cont
		call ProjInit_Heidern_CrossCutter
.obj2_cont:
	jp   .anim
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
	
; =============== MoveC_Heidern_NeckRoller ===============
; Move code for Heidern's:
; - Neck Roller (MOVE_HEIDERN_NECK_ROLLER_L, MOVE_HEIDERN_NECK_ROLLER_H)
; - Final Bringer (MOVE_HEIDERN_FINAL_BRINGER_S)
MoveC_Heidern_NeckRoller:
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
	mMvC_ChkFrame $07, .obj7
	mMvC_ChkFrame $08, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValFrameEnd .anim
		; Prepare for manual jump control
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		; Loop the attack frames 7 times
		ld   hl, iPlInfo_Heidern_NeckRoller_LoopCount
		add  hl, bc
		ld   [hl], $07
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj2
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		
		;
		; Initialize the jump settings.
		;
		
		; Y Speed -> 7px/frame up
		mMvC_SetSpeedV $F900
		
		; X Speed -> depends on the player distance.
		ld   hl, iPlInfo_PlDistance
		add  hl, bc
		ld   a, [hl]				; A = Distance
		ld   h, $26
		cp   h						; A >= $26?
		jp   nc, .obj1_setSpeedFar	; If so, jump
	.obj1_setSpeedNear:
		; Player is near opponent:
		; SpeedH = Distance * 4 / 256
		sla  a			; A = A * 4
		sla  a
		ld   l, a		; In the subpixel speed
		ld   h, $00
		jp   .obj1_setSpeed
	.obj1_setSpeedFar:
		; Player is far from the opponent:
		; SpeedH = Distance / 32
REPT 5
		srl  a			; A = A / 32
ENDR
		ld   h, a		; In the pixel speed
		ld   l, a
	.obj1_setSpeed:
		call Play_OBJLstS_SetSpeedH_ByXFlipR
		jp   .doGravity
; --------------- frame #2 ---------------
.obj2:
	; Immediately transition to the next frame, since YSpeed is always > -$0A
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_NextFrameOnGtYSpeed -$0A, ANIMSPEED_NONE
	jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
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
	jp   nz, .startBackjump				; If so, jump
	.obj3_chkGuard_noGuard:
		; Otherwise, continue to #4
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		mMvC_SetFrame $04, $01
		mMvC_SetSpeedH +$0000
		; Force player over opponent
		call HitTypeS_SyncPlPosFromOtherPos
		jp   .ret
.obj3_chkGuard_doGravity:
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	mMvC_ValFrameEnd .anim
	
		;
		; The super move (Final Bringer) transitions to Storm Bringer (health restore) on contact,
		; rather than continuing with the current move.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_HEIDERN_FINAL_BRINGER_S		; Doing the super move?
		jp   nz, .anim							; If not, skip
	
		; Force player on the ground
		ld   hl, iOBJInfo_Y
		add  hl, de
		ld   [hl], PL_FLOOR_POS
	
		; New Move
		ld   a, MOVE_HEIDERN_STORM_BRINGER_H
		call MoveInputS_SetSpecMove_StopSpeed
		
		; Initial hit
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		
		; Enable double damage for coming from the super
		ld   hl, iPlInfo_Heidern_StormBringer_FromSuper
		add  hl, bc
		ld   [hl], $01
		jp   .ret
; --------------- frame #5 ---------------
; Spinny damage loop #1.
.obj5:
	mMvC_ValFrameEnd .chkOtherEscape
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetDamage $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetMoveV -$0100
		jp   .chkOtherEscape
; --------------- frame #6 ---------------
; Spinny damage loop #2.
.obj6:
	mMvC_ValFrameEnd .chkOtherEscape
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		mMvC_SetDamage $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		
		; Loop back to #5 if the counter didn't elapse yet
		ld   hl, iPlInfo_Heidern_NeckRoller_LoopCount
		add  hl, bc
		dec  [hl]
		jp   z, .obj6_noLoop
		mMvC_SetFrame $05, $01
		jp   .ret
	.obj6_noLoop:
		; Deal knockdown
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_SetDamage $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .chkOtherEscape
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
	jp   .startBackjump
; --------------- common gravity checker / frames #1-3 (before contact) ---------------
.doGravity:
	; If we land on the ground (ie: whiff), switch to #8.
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $08, $07
		jp   .ret
; --------------- frame #7 ---------------
; If we got here, we didn't whiff and finished dealing dealing damage to the opponent.
; Backjump away at the end.
.obj7:
	mMvC_ValFrameEnd .anim
; --------------- switch to backjump ---------------
	.startBackjump:
		ld   a, MOVE_SHARED_LAUNCH_UB_REC
		call Pl_SetMove_StopSpeed
		mMvC_SetSpeedH -$0300 ; 3px/frame back
		mMvC_SetSpeedV -$0500 ; 5px/frame up
		jp   .ret
; --------------- frame #8 ---------------
.chkEnd:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
; =============== MoveC_Heidern_StormBringer ===============
; Move code for Heidern's Storm Bringer (MOVE_HEIDERN_STORM_BRINGER_L, MOVE_HEIDERN_STORM_BRINGER_H).
; Also used as part of the Super Move.
; Command throw that recovers health.
MoveC_Heidern_StormBringer:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .setDamageStart
		mMvC_ChkFrame $02, .setDamageStart
		mMvC_ChkFrame $04, .setDamage0
		mMvC_ChkFrame $06, .setDamage1
		mMvC_ChkFrame $08, .setDamage0
		mMvC_ChkFrame $0A, .setDamage1
		mMvC_ChkFrame $0C, .setDamage0
		mMvC_ChkFrame $0E, .setDamage1
		mMvC_ChkFrame $10, .setDamage0
		mMvC_ChkFrame $12, .setDamage1
		mMvC_ChkFrame $14, .setDamageEnd
		mMvC_ChkFrame $15, .obj15
		mMvC_ChkFrame $16, .chkEnd
	jp   .anim
; --------------- frames #0,2 ---------------
; Deal damage.
.setDamageStart:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		jp   .anim
; --------------- frames #4,8,C,10 ---------------
.setDamage0:
	mMvC_ValFrameEnd .anim
		; If we came here from the super move, deal double damage
		; iPlInfo_Heidern_StormBringer_FromSuper is set to $01 in that case.
		ld   hl, iPlInfo_Heidern_StormBringer_FromSuper
		add  hl, bc
		bit  0, [hl]
		jp   nz, .setDamageSuper0
	.setDamageNorm0:
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, $00
		jp   .restoreHealth
	.setDamageSuper0:
		mMvC_SetDamageNext $02, HITTYPE_HIT_MULTI0, PF3_SUPERALT
		jp   .restoreHealth
; --------------- frames #6,A,E,12 ---------------
.setDamage1:
	mMvC_ValFrameEnd .anim
		; Same as above but for HITTYPE_HIT_MULTI1
		ld   hl, iPlInfo_Heidern_StormBringer_FromSuper
		add  hl, bc
		bit  0, [hl]
		jp   nz, .setDamageSuper1
	.setDamageNorm1:
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, $00
		jp   .restoreHealth
	.setDamageSuper1:
		mMvC_SetDamageNext $02, HITTYPE_HIT_MULTI1, PF3_SUPERALT
; --------------- common health restore  ---------------
	.restoreHealth:
		; Restores health line by line until we reach the cap
		ld   hl, iPlInfo_Health
		add  hl, bc
		ld   a, [hl]				; A = Health
		cp   PLAY_HEALTH_MAX		; Health == $48?
		jp   z, .chkOtherEscape		; If so, don't increment it anymore
		inc  [hl]					; Otherwise, Health++
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
		ld   a, MOVE_SHARED_HOP_B
		call Pl_SetMove_StopSpeed
		xor  a
		ld   [wPlayPlThrowActId], a
		jp   .ret
; --------------- frame #14 ---------------
.setDamageEnd:
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
	
; =============== MoveC_Heidern_MoonSlasher ===============
; Move code for Heidern's Moon Slasher (MOVE_HEIDERN_MOON_SLASHER_L, MOVE_HEIDERN_MOON_SLASHER_H).
MoveC_Heidern_MoonSlasher:
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
		; If we're at max power, deal extra damage
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_PlaySound SFX_SPECIAL
		mMvC_ChkNotMaxPow .anim ; Jump to .anim if not at max power
			mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
			jp   .anim
; --------------- frame #1 ---------------	
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_SetMoveH +$0400
.obj1_cont:
	jp   .damageNotMaxPow
; --------------- frame #2 ---------------	
.obj2:
	mMvC_ValFrameStart .damageNotMaxPow
		mMvC_SetMoveH +$0400
; --------------- frmes #1-2 / extra damage check ---------------	
.damageNotMaxPow:
	; If we're at max power, deal extra damage
	mMvC_ValFrameEnd .anim
		mMvC_ChkNotMaxPow .anim ; Jump to .anim if not at max power
			mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT
			jp   .anim
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $08
		jp   .anim
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
	
; =============== ProjInit_Heidern_CrossCutter ===============
; Initializes the projectile for Heidern's Cross Cutter (MOVE_HEIDERN_CROSS_CUTTER_L, MOVE_HEIDERN_CROSS_CUTTER_H)
ProjInit_Heidern_CrossCutter:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Heidern_CrossCutter)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Heidern_CrossCutter)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Heidern_CrossCutter)	; iOBJInfo_OBJLstPtrTbl_High
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

			jp   nc, .fldMaxPow					; Are we at max power? If not, jump
			cp   MOVE_HEIDERN_CROSS_CUTTER_H	; Was this an heavy attack?
			jp   z, .fldHeavy					; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_HEIDERN_CROSS_CUTTER_H	; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow				; If so, jump
		.fldLight:
			mMvC_SetSpeedH +$0100
			jp   .end
		.fldHeavyMaxPow:
			mMvC_SetSpeedH +$0200
			jp   .end
		.fldHeavy:
			mMvC_SetSpeedH +$0400
		.end:

		pop  de
	pop  bc
	ret
	
; 
; =============== START OF MODULE Win/Cutscene ===============
;
	
GFXDef_Cutscene_Font_CharUnlock0: mGfxDef "data/gfx/cutscene_font_charunlock0.bin"
; [TCRF] The leftover Japanese Nakoruru unlock instructions got altered in the English version,
;        most importantly mentioning the inputs for the flight moves when done flightless.
;        The updated instructions use a new ポ character, which wasn't in the font pack before.
;        This is significant because there is no second revision released for the Japanese version.
IF VER_EN
GFXDef_Cutscene_Font_CharUnlock1: mGfxDef "data/gfx/en/cutscene_font_charunlock1.bin"
ELSE
GFXDef_Cutscene_Font_CharUnlock1: mGfxDef "data/gfx/cutscene_font_charunlock1.bin"
ENDC
PUSHC
SETCHARMAP charunlock 
Text_CutsceneBossUnlock0:
	db "奴はまだ死んではおらん!"
	db "            "
	db "ワシも手助けいたそう! "
	db "            "
Text_CutsceneBossUnlock2:
	db "奴は私のかげ武者にすぎん!   "
	db "                "
	db "兵の力をおまえ達に見せてやろう!"
	db "                "
Text_CutsceneBossUnlock5:
	db "私を使って最強を目指すがいい! "
	db "                "
	db "フハハハハハハ!        "
	db "                "
Text_CutsceneBossUnlockCode:
	db "ルガール&<サ2>イシュウ使用コマンド"
	db "                "
	db " タカㇻロゴがめんで      "
	db "                "
	db " セレクト3回         "
	db "                "
Text_CutsceneNakoruruUnlock0:
	db "なんてこと!        "
	db "              "
	db "オロチの力をまだ感じるわ! "
	db "              "
Text_CutsceneNakoruruUnlockCode:
	db "ナコルル使用コマンド  "
	db "            "
	db " タカㇻロゴがめんで  "
	db "            "
	db " セレクトを20回おす "
	db "            "
Text_CutsceneNakoruruUnlock2:
	db "私もお手伝いします!    "
	db "              "
	db "大自然のてきを倒して下さい!"
	db "              "
Text_CutsceneSaisyuMoveList:
	db "やみばらい   鬼やき   "
	db "↓↘→+B   →↓↘+B "
	db "              "
	db "かむかかり         "
	db "→↘↓↙←+B       "
	db "              "
	db "おろちなぎ         "
	db "↓↙←↙↓↘→+B     "
Text_CutsceneRugalMoveList:
	db "れっぷうけん  カイザーウェーブ"
	db "↓↘→+B   →←↙↓↘→+B"
	db "                "
	db "ジェノサイドカッター      "
	db "↓↙←↖+A          "
	db "                "
	db "ダークバリ<ア2>ー ゴッドプレス  "
	db "↓↘→+A   →↘↓↙←+B "
	db "                "
	db "ギガンテックプレッシヤー    "
	db "→↘↓↙←→↘↓↙←+A    "
	db "                "
	
IF VER_EN
; [TCRF] See above
Text_CutsceneNakoruruMoveList:
	db "アムベヤトロ   アンヌムツベ   "
	db "→↘↓↙←+B  ←↙↓+B    "
	db "                  "
	db "レラムツベ    カムイリムセ   "
	db "↓↘→+B    ←↓↙+B    "
	db "                  "
	db "カムイムツベ   ヤトロポック   "
	db "たかにつかまって たかにつかまって "
	db "B        ↓+B      "
	db "                  "
	db "アペチカムイリムセ たかにつかまる "
	db "←↓↙+B(<大2>)  ↓↙←+A   "
	db "                  "
	db "エレルシカムイリムセ        "
	db "→↘↓↙←→↘↓↙←+B      "
	db "                  "
ELSE
Text_CutsceneNakoruruMoveList:
	db "アムベヤトロ   アンヌムツベ   "
	db "→↘↓↙←+B  ←↙↓+B    "
	db "                  "
	db "レラムツベ    カムイリムセ   "
	db "↓↘→+B    ←↓↙+B    "
	db "                  "
	db "カムイムツベ   レラムツベ    "
	db "たかにつかまって たかにつかまって "
	db "B        ↓+B      "
	db "                  "
	db "アペチカムイリムセ         "
	db "←↓↙+B(<大2>)          "
	db "                  "
	db "エレルシカムイリムセ        "
	db "→↘↓↙←→↘↓↙←+B      "
	db "                  "
ENDC

POPC

; =============== SubModule_CutsceneCharUnlock ===============
; This submodule handles the character unlock cutscene for both Saisyu/Rugal and Nakoruru.
; Because the manual hides the existence of these playable characters, it also displays
; their move list and unlock instructions,
SubModule_CutsceneCharUnlock:
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
	ld   hl, GFXDef_Cutscene_Font_CharUnlock0
	ld   de, $9000			; 3rd GFX Block, tiles $00-$7F
	call CopyTilesAutoNum
	ld   hl, GFXDef_Cutscene_Font_CharUnlock1
	ld   de, $8800			; 2nd GFX Block, tiles $80-$8B
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
	
	;
	; Determine which unlock instructions to display.
	;
	
	
	; [POI] On EASY, don't do anything. We can't even get here on EASY though...
	ld   a, [wDifficulty]
	cp   DIFFICULTY_EASY
	ret  z
	
	; On NORMAL, show the Saisyu/Rugal unlock instructions.
	cp   DIFFICULTY_NORMAL
	jp   z, Cutscene_CharUnlockBoss

	; On HARD, show the Nakoruru unlock instructions.
	; [POI] The following check always jumps, because on HARD we only get here when defeating Nakoruru.
	;       The presence of an explicit stage check suggests that at some point, on HARD, you would
	;       have received Saisyu/Rugal's unlock instructions as well.
	;       That'd be less Replay Value(tm) though, presumably why it was changed.
	ld   a, [wCharSeqId]
	cp   STAGESEQ_NAKORURU+1				; Just defeated Nakoruru?
	jp   z, Cutscene_CharUnlockNakoruru		; If so, jump
	
Cutscene_CharUnlockBoss:
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; [POI] Actually unlock the boss characters when we get here.
	;       96 doesn't do this anymore for some reason.
	ld   hl, wDipSwitch
	set  DIPB_UNLOCK_BOSS, [hl]
	
.saisyu:
	;--
	; #0 - Draw Saisyu
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   a, CHAR_ID_SAISYU
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	;--
	
IF VER_EN
	; Saisyu Text 0
	ld   hl, TextDef_CutsceneBossUnlockEn
	ld   b, BANK(TextDef_CutsceneBossUnlockEn) ; BANK $13
	ld   c, $0A
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	
	; Saisyu Move List 0
	ld   hl, TextDef_CutsceneSaisyuMoveListEn0
	ld   b, BANK(TextDef_CutsceneSaisyuMoveListEn0) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
	ld   b, $3C
	call Cutscene18_PostTextWrite
	call Task_PassControl_NoDelay
	
	; Saisyu Move List 1
	ld   hl, TextDef_CutsceneSaisyuMoveListEn1
	ld   b, BANK(TextDef_CutsceneSaisyuMoveListEn1) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
ELSE
	;--
	; #1 - Saisyu Text
	ld   de, Text_CutsceneBossUnlock0
	ld   hl, $9981
	ld   b, $0C
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap ; Clear everything
	;--
	
	;--
	; #2 - Saisyu move list
	ld   de, Text_CutsceneSaisyuMoveList
	ld   hl, $9841
	ld   b, $0E
	ld   c, $08
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
ENDC
	; Press START to continue
.smLoop:
	call Cutscene18_IsStartPressed
	jp   c, .rugal
	call Task_PassControl_NoDelay
	jp   .smLoop
	;--
	
.rugal:
	call ClearBGMap
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	
	;--
	; #3 - Draw Rugal
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   a, CHAR_ID_RUGAL
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	; Rugal Text
	ld   hl, TextDef_CutsceneBossUnlockEn1
	ld   b, BANK(TextDef_CutsceneBossUnlockEn1) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	
	; Rugal move list 0
	ld   hl, TextDef_CutsceneRugalMoveListEn0
	ld   b, BANK(TextDef_CutsceneRugalMoveListEn0) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
	ld   b, $3C
	call Cutscene18_PostTextWrite
	call Task_PassControl_NoDelay
	
	; Rugal move list 1
	ld   hl, TextDef_CutsceneRugalMoveListEn1
	ld   b, BANK(TextDef_CutsceneRugalMoveListEn1) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
ELSE
	;--
	; #4 - Rugal Text
	ld   de, Text_CutsceneBossUnlock2
	ld   hl, $9981
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap ; Clear everything
	;--
	
	;--
	; #5 - Rugal move list
	ld   de, Text_CutsceneRugalMoveList
	ld   hl, $9841
	ld   b, $10
	ld   c, $0C
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
ENDC
	; Press START to continue
.rmLoop:
	call Cutscene18_IsStartPressed
	jp   c, .bossKey
	call Task_PassControl_NoDelay
	jp   .rmLoop
	;--
	
.bossKey:
	call ClearBGMap
	
	;--
	; #6 - Boss unlock instructions (SELECTx3 at the Takara logo)
IF VER_EN
	call Task_PassControl_NoDelay
	ld   hl, TextDef_CutsceneBossUnlockCodeEn
	ld   b, BANK(TextDef_CutsceneBossUnlockCodeEn) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
ELSE
	ld   de, Text_CutsceneBossUnlockCode
	ld   hl, $9842
	ld   b, $10
	ld   c, $06
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
ENDC
	; Press START to continue
.bkLoop:
	call Cutscene18_IsStartPressed
	jp   c, .last
	call Task_PassControl_NoDelay
	jp   .bkLoop
	
.last:
	call ClearBGMap
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	;--
	; #7 - Draw Rugal
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; [POI] Pointless palette setup
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	ld   a, CHAR_ID_RUGAL
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	; Rugal text 2
	ld   hl, TextDef_CutsceneBossUnlockEn2
	ld   b, BANK(TextDef_CutsceneBossUnlockEn2) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $F0
	call Cutscene18_PostTextWrite
	call ClearBGMap
ELSE
	;--
	; #8 - Rugal text 2
	ld   de, Text_CutsceneBossUnlock5
	ld   hl, $9981
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $F0
	call Cutscene18_PostTextWrite
	call ClearBGMap
	;--
ENDC
	ret
	
Cutscene_CharUnlockNakoruru:
	; This seamlessly continues from Nakururu's ending cutscene.

	; [POI] Unlock everything.
	ld   hl, wDipSwitch
	set  DIPB_UNLOCK_BOSS, [hl]
	set  DIPB_UNLOCK_OTHER, [hl]
	
	; Start 1st cutscene music
	ld   a, BGM_CUTSCENE1
	call HomeCall_Sound_ReqPlayExId_Stub
	
	;--
	; #0 - Draw Nakoruru
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   a, CHAR_ID_NAKORURU
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--

IF VER_EN
	; Text 0
	ld   hl, TextDef_CutsceneNakoruruUnlockEn0
	ld   b, BANK(TextDef_CutsceneNakoruruUnlockEn0) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	
	; Unlock instructions
	ld   hl, TextDef_CutsceneNakoruruUnlockCodeEn
	ld   b, BANK(TextDef_CutsceneNakoruruUnlockCodeEn) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
ELSE
	;--
	; #1 - Text 0
	ld   de, Text_CutsceneNakoruruUnlock0
	ld   hl, $9981
	ld   b, $0E
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	;--
	
	;--
	; #2 - Unlock instructions
	;      Inconsistently, they are displayed before her move list, unlike the two bosses.
	ld   de, Text_CutsceneNakoruruUnlockCode
	ld   hl, $9843
	ld   b, $0C
	ld   c, $06
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	; Press START to continue
ENDC
.nkLoop:
	call Cutscene18_IsStartPressed
	jp   c, .nt1
	call Task_PassControl_NoDelay
	jp   .nkLoop
	
.nt1:
	call ClearBGMap
IF VER_EN
	call Task_PassControl_NoDelay
ENDC	
	;--
	; #3 - Draw Nakoruru
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; [POI] Pointless palette setup
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	ld   a, CHAR_ID_NAKORURU
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	;--
	
IF VER_EN
	; Text 1
	ld   hl, TextDef_CutsceneNakoruruUnlockEn1
	ld   b, BANK(TextDef_CutsceneNakoruruUnlockEn1) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	
	; Nakoruru move list 0
	ld   hl, TextDef_CutsceneNakoruruMoveListEn0
	ld   b, BANK(TextDef_CutsceneNakoruruMoveListEn0) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
	ld   b, $3C
	call Cutscene18_PostTextWrite
	call Task_PassControl_NoDelay
	
	; Nakoruru move list 1
	ld   hl, TextDef_CutsceneNakoruruMoveListEn1
	ld   b, BANK(TextDef_CutsceneNakoruruMoveListEn1) ; BANK $13
	ld   c, $06
	call TextPrinter_MultiFrameFar_NoCtrl
	call Task_PassControl_NoDelay
ELSE
	;--
	; #4 - Text 1
	ld   de, Text_CutsceneNakoruruUnlock2
	ld   hl, $9981
	ld   b, $0E
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene18_PostTextWrite
	call ClearBGMap
	;--
	
	;--
	; #5 - Nakoruru move list
	ld   de, Text_CutsceneNakoruruMoveList
	ld   hl, $9841
	ld   b, $12
	ld   c, $10
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
ENDC
	; Press START to continue
.nmLoop:
	call Task_PassControl_NoDelay
	call Cutscene18_IsStartPressed
	jp   nc, .nmLoop
	call ClearBGMap
IF VER_EN
	call Task_PassControl_NoDelay
ENDC
	;--
	ret
	
; =============== Cutscene18_PostTextWrite ===============
; Shared code executed after text finishes writing for a cutscene.
; This delays the cutscene from continuing, until the timer elapses or START is pressed.
; IN
; - B: Max number of frames to wait
; OUT
; - C flag: If set, it was aborted early
Cutscene18_PostTextWrite:
	; Check early abort
	call Cutscene18_IsStartPressed	; Did anyone press START?
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
	jp   nz, Cutscene18_PostTextWrite	; If not, loop
.end:
	xor  a	; C flag clear
	ret

; =============== Cutscene18_IsStartPressed ===============
; Checks if any player pressed START.
; Identical to Win_IsStartPressed.
; OUT
; - C flag: If set, someone did
Cutscene18_IsStartPressed:
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

IF VER_EN

; In BANK $1F on the Japanese version
FontDef_Default:
	dw $9000 	; Destination ptr
	db $30 		; Tiles to copy
.col:
	db COL_WHITE ; Bit0 color map (background)
	db COL_BLACK ; Bit1 color map (foreground)
	; 1bpp font gfx
.gfx:
	INCBIN "data/gfx/font.bin"
	
	; =============== END OF BANK ===============
	; Junk area below.	
	mIncJunk "L187C2D"
ELSE
	; =============== END OF BANK ===============
	; Junk area below, contains a partial duplicate of the above subroutine.
	mIncJunk "L1879E0"
ENDC
	
; 
; =============== END OF MODULE Win/Cutscene ===============
;