INCLUDE "data/objlst/char/kyo.asm"
INCLUDE "data/objlst/char/heidern.asm"
INCLUDE "data/objlst/char/ralf.asm"
INCLUDE "data/objlst/char/athena.asm"

; =============== MoveC_Billy_ThrowG ===============
; Move code for Billy's ground throw. (MOVE_SHARED_THROW_G).
; See also: MoveC_Kyo_ThrowG
MoveC_Billy_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $05, .chkEnd
; --------------- frames #2-4 ---------------
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
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_MID_UB_NOSTUN, PF3_HEAVYHIT
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
	
; =============== MoveC_Billy_KickFH ===============
; Move code for Billy's Far Heavy Kick (MOVE_SHARED_KICK_FH).
; Slidekick.
MoveC_Billy_KickFH:
	call Play_Pl_MoveByColiBoxOverlapX
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
	; Wait
	mMvC_ValFrameEnd .anim
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Set manual control for speed check
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	; Set dash speed at the start
	mMvC_ValFrameStartFast .obj2_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_SetSpeedH $0400
		jp   .anim
.obj2_cont:
	; Move forwards, slowing down 0.25px/frame
	mMvC_ChkFrictionH $0040, .anim
		; When we stop moving, stay for 10 more frames on #2
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00			; Reset counter
		mMvC_SetAnimSpeed $0A	; Set new speed for current frame
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
	
; =============== MoveInputReader_Billy ===============
; Special move input checker for BILLY.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Billy:
	mMvIn_Validate Billy, 0

.chkGround:
	;             SELECT + B                        SELECT + A
	mMvIn_ChkEasy MoveInit_Billy_ChouKaenSenpuuKon, MoveInit_Billy_KyoushuuHishouKon
	mMvIn_ChkGA Billy, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH

.chkPunch:
	mMvIn_ValSuper .chkPunchNoSuper
	; DFDB+P -> Chou Kaen Senpuu Kon
	mMvIn_ChkDir MoveInput_DFDB, MoveInit_Billy_ChouKaenSenpuuKon
.chkPunchNoSuper:
	; BDF+P -> Sansetsu Kon Chuudan Uchi
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Billy_SansetsuKonChuudanUchi
	; DB+P -> Suzume Otoshi
	mMvIn_ChkDir MoveInput_DB, MoveInit_Billy_SuzumeOtoshi
	; PPP -> Senpuu Kon
	mMvIn_ChkBtnStrict MoveInput_PPP, MoveInit_Billy_SenpuuKon
	; End
	jp   MoveInputReader_Billy_NoMove
.chkKick:
	; BDF+K -> Kyoushuu Hishou Kon
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Billy_KyoushuuHishouKon
	; End
	jp   MoveInputReader_Billy_NoMove
	
; =============== MoveInit_Billy_SansetsuKonChuudanUchi ===============
MoveInit_Billy_SansetsuKonChuudanUchi:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L, MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Billy_MoveSet
	
; =============== MoveInit_Billy_SenpuuKon ===============
MoveInit_Billy_SenpuuKon:
	call Play_Pl_ClearJoyBtnBuffer
	mMvIn_GetLHP MOVE_BILLY_SENPUU_KON_L, MOVE_BILLY_SENPUU_KON_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Billy_MoveSet
	
; =============== MoveInit_Billy_SuzumeOtoshi ===============
MoveInit_Billy_SuzumeOtoshi:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_BILLY_SUZUME_OTOSHI_L, MOVE_BILLY_SUZUME_OTOSHI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Billy_MoveSet
	
; =============== MoveInit_Billy_KyoushuuHishouKon ===============
MoveInit_Billy_KyoushuuHishouKon:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_BILLY_KYOUSHUU_HISHOU_KON_L, MOVE_BILLY_KYOUSHUU_HISHOU_KON_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Billy_MoveSet
	
; =============== MoveInit_Billy_ChouKaenSenpuuKon ===============
MoveInit_Billy_ChouKaenSenpuuKon:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	call Play_Proj_CopyMoveDamageFromPl
	
; =============== MoveInputReader_Billy_MoveSet ===============
MoveInputReader_Billy_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Billy_NoMove ===============
MoveInputReader_Billy_NoMove:
	or   a
	ret  

; =============== MoveC_Billy_SansetsuKonChuudanUchi ===============
; Move code for Billy's:
; - Sansetsu Kon Chuudan Uchi (MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L, MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H).	
; - Suzume Otoshi (MOVE_BILLY_SUZUME_OTOSHI_L, MOVE_BILLY_SUZUME_OTOSHI_H)
MoveC_Billy_SansetsuKonChuudanUchi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $06, .obj6
; --------------- frames #0,4-5 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $03
		; At Max Power, deal an extra hit
		mMvC_ChkNotMaxPow .anim
		mMvC_SetDamageNext $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $08
		; At Max Power, deal an extra hit
		mMvC_ChkNotMaxPow .anim
		mMvC_SetDamage $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $02
		jp   .anim
; --------------- frame #6 ---------------
.obj6:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Billy_SenpuuKon ===============
; Move code for Billy's Senpuu Kon (MOVE_BILLY_SENPUU_KON_L, MOVE_BILLY_SENPUU_KON_H).	
MoveC_Billy_SenpuuKon:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .setDamage0
		mMvC_ChkFrame $03, .setDamage0
		mMvC_ChkFrame $05, .setDamage0
		mMvC_ChkFrame $07, .setDamage0
		mMvC_ChkFrame $09, .chkEnd
	jp   .setDamage1
; --------------- frames #1,3,5,6 ---------------
.setDamage0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID0, $00
		mMvC_PlaySound SFX_LIGHT
		jp   .anim
; --------------- frames #2,4,6,8 ---------------
.setDamage1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $04, HITTYPE_HIT_MID1, $00
		mMvC_PlaySound SFX_LIGHT
		jp   .anim
; --------------- frame #9 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Billy_KyoushuuHishouKon ===============
; Move code for Billy's Kyoushuu Hishou Kon. (MOVE_BILLY_KYOUSHUU_HISHOU_KON_L, MOVE_BILLY_KYOUSHUU_HISHOU_KON_H).
MoveC_Billy_KyoushuuHishouKon:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .obj4
		mMvC_ChkFrame $06, .obj6
		mMvC_ChkFrame $07, .chkEnd
; --------------- frame #2 ---------------
.obj2:
	; Set manual control at the end, for the jump parts
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #3 ---------------
.obj3:
	mMvC_ValFrameStartFast .obj3_cont
		mMvC_PlaySound SFX_SPECIAL
		;--
		; Remove invuln
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_INVULN, [hl]
		;--
		; Set very tall off-screen jump...
		mMvC_ChkMove MOVE_BILLY_KYOUSHUU_HISHOU_KON_H, .obj3_setJumpH
	.obj3_setJumpL: ; Light
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$1000
		jp   .obj3_doGravity
	.obj3_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj3_setJumpE
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$1800
		jp   .obj3_doGravity
	.obj3_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0040
		mMvC_SetSpeedV -$0600 ; ... unless it's at Max Power!
	.obj3_doGravity:
		jp   .doGravityU
		
.obj3_cont:
	; Wait for the YSpeed to be > -$04 before continuing.
	; When switching to #4, the super low gravity for the Max Power move will start to take effect.
	mMvC_ValNextFrameOnGtYSpeed -$04, ANIMSPEED_NONE, .doGravityU
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetFrameOnEnd $04
		jp   .doGravityU
; --------------- frame #4 ---------------
; Damage loop, frame #0
.obj4:
	mMvC_ValFrameEnd .doGravityD
		jp   .setDamage
; --------------- frame #6 ---------------
; Damage loop, frame #2
.obj6:
	; If we didn't touch the ground by the end of the frame, loop back to #4
	mMvC_ValFrameEnd .doGravityD
		mMvC_SetFrameOnEnd $04
		; And deal another hit, deadly if the opponent is close.
		; Because of the low gravity, the Max Power version deals half damage.
	.setDamage:
		mMvC_ChkNotMove MOVE_BILLY_KYOUSHUU_HISHOU_KON_H, .setDamageNorm
		mMvC_ChkNotMaxPow .setDamageNorm
	.setDamageMaxPow: ; Max Power Heavy
		mMvC_SetDamageNext $05, HITTYPE_HIT_MID0, PF3_CONTHIT
		mMvC_PlaySound SFX_LIGHT
		jp   .doGravityD
	.setDamageNorm: ; Normal
		mMvC_SetDamageNext $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_PlaySound SFX_LIGHT
		jp   .doGravityD
		
; --------------- common gravity check, normal / frame #3 ---------------
; Standard gravity applies.	
.doGravityU:
	ld   hl, $0060
	jp   .doGravityCustom
	
; --------------- common gravity check, damage ver / frames #4-6 ---------------
; Used when floating down during the damage loop.
;
; This sets super low gravity when performing the heavy move at Max Power, which
; goes with its significantly lower jump height.
.doGravityD:
	; Not doing the heavy? Use normal gravity.
	mMvC_ChkNotMove MOVE_BILLY_KYOUSHUU_HISHOU_KON_H, .doGravityDNorm
	; Not at max power? Use normal gravity.
	mMvC_ChkNotMaxPow .doGravityDNorm
	; Otherwise, super floaty time.
.doGravityDMaxPow:
	ld   hl, $000C
	jp   .doGravityCustom
.doGravityDNorm:
	ld   hl, $0060
; --------------- common gravity check / frames #3-6 ---------------
; IN
; - HL: Gravity
.doGravityCustom:
	; Switch to #7 when landing on the ground.
	call OBJLstS_ApplyGravityVAndMoveHV ; mMvC_ChkGravityHV <HL>, .chkMove
	jp   nc, .chkMove ; Do the movement while still in the air.
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
; --------------- common air movement code / frames #3-6 ---------------
.chkMove:
	;
	; Billy is slowly floating, with precise horizontal movement that 
	; doesn't depend on the player side.
	;
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	bit  KEYB_RIGHT, [hl]	; Holding Right?
	jp   nz, .chkMoveR		; If so, jump
	bit  KEYB_LEFT, [hl]	; Holding Left?
	jp   nz, .chkMoveL		; If so, jump
	jp   .anim
.chkMoveR:
	mMvC_ChkMaxPow .setMoveRMaxPow
.setMoveRNorm:
	mMvC_SetMoveHAbs +$0080 ; move right 0.5px/frame
	jp   .anim
.setMoveRMaxPow:
	mMvC_SetMoveHAbs +$0200 ; move right 2px/frame
	jp   .anim
.chkMoveL:
	mMvC_ChkMaxPow .setMoveLMaxPow
.setMoveLNorm:
	mMvC_SetMoveHAbs -$0080 ; move left 0.5px/frame
	jp   .anim
.setMoveLMaxPow:
	mMvC_SetMoveHAbs -$0200 ; move left 2px/frame
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
	
; =============== MoveC_Billy_ChouKaenSenpuuKon ===============
; Move code for Billy's Chou Kaen Senpuu Kon (MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S).	
MoveC_Billy_ChouKaenSenpuuKon:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .setDamageStart
		mMvC_ChkFrame $01, .anim
		mMvC_ChkFrame $02, .setDamage0
		mMvC_ChkFrame $03, .setDamage1
		mMvC_ChkFrame $04, .setDamage0
	; [BUG] Incorrect sequence value
	IF !FIX_BUGS
		mMvC_ChkFrame $03, .setDamage1
	ELSE
		mMvC_ChkFrame $05, .setDamage1
	ENDC
		mMvC_ChkFrame $06, .setDamage0
		mMvC_ChkFrame $07, .setDamage1
		mMvC_ChkFrame $09, .spawnProj
		mMvC_ChkFrame $0A, .chkEnd
; --------------- frame #[4],8 ---------------
	jp   .anim
; --------------- frame #0 ---------------
; Flame wheel start.
.setDamageStart:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $0D, HITTYPE_HIT_MID1, PF3_FIRE
		jp   .anim
; --------------- odd damage frame / frames #2,[4],6 ---------------
; Flame wheel hit type #0
.setDamage0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $0D, HITTYPE_HIT_MID0, PF3_FIRE
		mMvC_PlaySound SCT_PHYSFIRE
		jp   .anim
; --------------- even damage frame / frames #3,5,7 ---------------
; Flame wheel hit type #1
.setDamage1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $0D, HITTYPE_HIT_MID1, PF3_FIRE
		mMvC_PlaySound SCT_PHYSFIRE
		jp   .anim
; --------------- frame #9 ---------------
; Launch the wheel forward, as its own projectile
.spawnProj:
	mMvC_ValFrameStartFast .spawnProj_cont
		call ProjInit_Billy_ChouKaenSenpuuKon
.spawnProj_cont:
	mMvC_ValFrameEnd .anim
		; 30 frame recovery
		mMvC_SetAnimSpeed $1E
		jp   .anim
; --------------- frame #A ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== ProjInit_Billy_ChouKaenSenpuuKon ===============
; Initializes the projectile for Billy's Chou Kaen Senpuu Kon (MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S).
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Billy_ChouKaenSenpuuKon:
	mMvC_PlaySound SCT_PHYSFIRE

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
				ld   [hl], BANK(ProjC_Billy_ChouKaenSenpuuKon)	; BANK $08 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Billy_ChouKaenSenpuuKon)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Billy_ChouKaenSenpuuKon)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Billy_ChouKaenSenpuuKon)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Billy_ChouKaenSenpuuKon)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Billy_ChouKaenSenpuuKon)	; iOBJInfo_OBJLstPtrTbl_High
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
				
				; Display for half a second
				inc  hl ; Seek to iOBJInfo_Play_EnaTimer
				ld   [hl], 30
				
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

			mMvC_SetSpeedH +$0300
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Billy_ChouKaenSenpuuKon ===============
; Projectile code for Billy's Chou Kaen Senpuu Kon (MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S).
; A flame wheel that moves forward, despawning on contact or after the specified time limit. 
ProjC_Billy_ChouKaenSenpuuKon:

	; Handle the despawn timer
	ld   hl, iOBJInfo_Play_EnaTimer
	add  hl, de
	dec  [hl]			; DespawnTimer--
	jp   z, .despawn	; Did it reach 0? If so, jump
	
	; Handle the hitbox
	call ExOBJS_Play_ChkHitModeAndMoveH		; Hit the opponent?
	jp   c, .despawn						; If so, despawn
	
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret
.despawn:
	call OBJLstS_Hide
	ret
; =============== END OF BANK ===============
; Junk area below, containing an incomplete duplicate of the above function, then repeating junk.
	mIncJunk "L087E13"