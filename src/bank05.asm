MoveAnimTbl_Marker:
; =============== MoveAnimTbl_* ===============
; OBJInfo and PlInfo settings for every move (not just specials).
; This primarily defines the move animations, which in turn define the frames, which have their own collision boxes.
;
; It's extremely important that the move animations assigned here are compatible with the respective move code
; as assigned in MoveCodePtrTbl_*.
; 
; This is due to what the move code can do with the sprite mapping ID:
; - The move may only end when a certain ID is reached.
;   If the animation has less frames, it may loop or freeze at the last frame,
;   causing a softlock if the other player doesn't hit the player out of it (guaranteed in case of the CPU).
; - The move ID may be set to an arbitrary value.
;   If that's past the end of the animation table, it will read a garbage sprite mapping
;   with a likely invalid tile count. As neither the GFX writer and sprite mapping writer
;   validate the tile count (in particular there's nothing to mark the number of free space
;   left in the OAM mirror), the game breaks.
;
; See also: Pl_SetNewMove
;
; FORMAT
; Each entry is 8 bytes:
; - 0: Bank number for the animation table (iOBJInfo_BankNum)
; - 1-2: Ptr to animation table (iOBJInfo_OBJLstPtrTbl)
; - 3: Sprite Mapping ID target, when this is reached something happens (usually checking if the move can end). (iPlInfo_OBJLstPtrTblOffsetMoveEnd)
; - 4: Animation speed. Higher values = slower animation (iOBJInfo_FrameLeft)
; - 5: Damage dealt to the opponent (iPlInfo_MoveDamageValNext)
; - 6: Hit Effect ID delivered to the opponent if hit by the move. (HITTYPE_*) (iPlInfo_MoveDamageHitTypeIdNext)
; - 7: Hit properties (how the opponent can block it, etc...) 
;      iPlInfo_Flags3 delivered to the opponent on hit (iPlInfo_MoveDamageFlags3Next)
;
; NOTES
; - Every character begins with a dummy row for move $00 (MOVE_SHARED_NONE).
;   This is never used and shouldn't be for obvious reasons.
; - Characters without a special intro have a duplicate of their normal intro.
; - [POI] Empty special/super move slots are filed with placeholder default entries.
;         All of these reuse the idle animation truncated to the first frame.
;         For special moves, these are set to deal no damage, while super moves do $14 lines.

MACRO mMvAnDef
	dp \1
	db \2, \3, \4, \5, \6
ENDM


MoveAnimTbl_Kyo:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $0C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Kyo_WalkF, $08, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Kyo_WalkB, $08, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Kyo_Crouch, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Kyo_CrouchWalkF, $0C, $03, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Kyo_JumpN, $1C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Kyo_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Kyo_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Kyo_BlockG, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Kyo_BlockC, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Kyo_HopF, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Kyo_HopB, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Kyo_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Kyo_Taunt, $14, $03, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Kyo_Dodge, $00, $1E, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Kyo_Wakeup, $04, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Kyo_Dizzy, $04, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Kyo_Win, $10, $08, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Kyo_LostTimeover, $00, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Kyo_Intro, $10, $08, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Kyo_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Kyo_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Kyo_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Kyo_PunchHM, $0C, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Kyo_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Kyo_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Kyo_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Kyo_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Kyo_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Kyo_PunchCH, $0C, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Kyo_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Kyo_KickCH, $0C, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Kyo_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Kyo_Strike, $08, $03, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Kyo_KickFH, $10, $02, $06, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Kyo_KickFCH, $18, $02, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Kyo_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Kyo_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Kyo_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Kyo_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Kyo_PunchALX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Kyo_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Kyo_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Kyo_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Kyo_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Kyo_PunchAHD, $10, $01, $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT|PF3_OVERHEAD ;X ; BANK $08 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Kyo_YamiBarai, $0C, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_FIRE ; BANK $08 ; MOVE_KYO_YAMI_BARAI_L
	mMvAnDef OBJLstPtrTable_Kyo_YamiBarai, $0C, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_FIRE ; BANK $08 ; MOVE_KYO_YAMI_BARAI_H
	mMvAnDef OBJLstPtrTable_Kyo_OniYaki, $14, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE ; BANK $08 ; MOVE_KYO_ONI_YAKI_L
	mMvAnDef OBJLstPtrTable_Kyo_OniYaki, $14, $02, $0A, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_KYO_ONI_YAKI_H
	mMvAnDef OBJLstPtrTable_Kyo_OboroGuruma, $20, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $08 ; MOVE_KYO_OBORO_GURUMA_L
	mMvAnDef OBJLstPtrTable_Kyo_OboroGuruma, $20, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT ; BANK $08 ; MOVE_KYO_OBORO_GURUMA_H
	mMvAnDef OBJLstPtrTable_Kyo_KototsukiYou, $18, $02, $09, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $08 ; MOVE_KYO_KOTOTSUKI_YOU_L
	mMvAnDef OBJLstPtrTable_Kyo_KototsukiYou, $18, $04, $09, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $08 ; MOVE_KYO_KOTOTSUKI_YOU_H
	mMvAnDef OBJLstPtrTable_Kyo_Kai, $14, $FF, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $08 ; MOVE_KYO_KAI_L
	mMvAnDef OBJLstPtrTable_Kyo_Kai, $14, $FF, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT ; BANK $08 ; MOVE_KYO_KAI_H
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_KYO_78
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_KYO_7A
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_KYO_7C
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_KYO_7E
	mMvAnDef OBJLstPtrTable_Kyo_UraOrochiNagi, $18, $01, $20, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_HALFSPEED ; BANK $08 ; MOVE_KYO_URA_OROCHI_NAGI_S
	mMvAnDef OBJLstPtrTable_Kyo_ThrowG, $14, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Kyo_Idle, $00, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Kyo_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Kyo_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Kyo_LostTimeover, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Kyo_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Kyo_LaunchUB, $10, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Kyo_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Kyo_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Kyo_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Kyo_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Kyo_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Kyo_LostTimeover, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Kyo_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Kyo_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Kyo_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Kyo_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Benimaru:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Benimaru_WalkF, $08, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Benimaru_WalkB, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Benimaru_Crouch, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Benimaru_Crouch, $00, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Benimaru_JumpN, $1C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Benimaru_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Benimaru_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Benimaru_BlockG, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Benimaru_BlockC, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Benimaru_HopF, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Benimaru_HopB, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Benimaru_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Benimaru_Taunt, $04, $06, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Benimaru_Dodge, $00, $1E, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Benimaru_Wakeup, $04, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Benimaru_Dizzy, $04, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Benimaru_Win, $08, $03, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Benimaru_Taunt, $00, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Benimaru_Intro, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Benimaru_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Benimaru_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Benimaru_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Benimaru_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Benimaru_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Benimaru_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Benimaru_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Benimaru_KickHM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Benimaru_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Benimaru_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Benimaru_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Benimaru_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Benimaru_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Benimaru_Strike, $0C, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $00, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $00, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Benimaru_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Benimaru_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Benimaru_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Benimaru_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Benimaru_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Benimaru_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Benimaru_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Benimaru_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Benimaru_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Benimaru_KickAHD, $10, $01, $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ;X ; BANK $07 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $00, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Benimaru_Raijinken, $20, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_SUPERALT ; BANK $07 ; MOVE_BENIMARU_RAIJINKEN_L
	mMvAnDef OBJLstPtrTable_Benimaru_Raijinken, $20, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT ; BANK $07 ; MOVE_BENIMARU_RAIJINKEN_H
	mMvAnDef OBJLstPtrTable_Benimaru_ShinkuuKatateGoma, $18, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L
	mMvAnDef OBJLstPtrTable_Benimaru_ShinkuuKatateGoma, $18, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H
	mMvAnDef OBJLstPtrTable_Benimaru_IaiGeri, $28, $01, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_BENIMARU_IAI_GERI_L
	mMvAnDef OBJLstPtrTable_Benimaru_IaiGeri, $28, $01, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_BENIMARU_IAI_GERI_H
	mMvAnDef OBJLstPtrTable_Benimaru_SuperInazumaKickL, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT ; BANK $07 ; MOVE_BENIMARU_SUPER_INAZUMA_KICK_L
	mMvAnDef OBJLstPtrTable_Benimaru_SuperInazumaKickL, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_SUPERALT ; BANK $07 ; MOVE_BENIMARU_SUPER_INAZUMA_KICK_H
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, $00 ;X ; BANK $07 ; MOVE_BENIMARU_74
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, $00 ;X ; BANK $07 ; MOVE_BENIMARU_76
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $02, $0A, HITTYPE_HIT_MID1, $00 ;X ; BANK $07 ; MOVE_BENIMARU_78
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $02, $0A, HITTYPE_HIT_MID1, $00 ;X ; BANK $07 ; MOVE_BENIMARU_7A
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_BENIMARU_7C
	mMvAnDef OBJLstPtrTable_Benimaru_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_BENIMARU_7E
	mMvAnDef OBJLstPtrTable_Benimaru_Raikouken, $14, $01, $0A, HITTYPE_HIT_MID0, PF3_SUPERALT ; BANK $07 ; MOVE_BENIMARU_RAIKOUKEN_S
	mMvAnDef OBJLstPtrTable_Benimaru_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Benimaru_ThrowA, $08, $0A, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Benimaru_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Benimaru_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Benimaru_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Benimaru_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchUB, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Benimaru_HitSweep, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Benimaru_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Benimaru_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchDBShake, $0C, $FF, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Benimaru_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Benimaru_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Ryo:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $04, $06, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Ryo_WalkF, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Ryo_WalkB, $0C, $03, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Ryo_Crouch, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $04, $03, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Ryo_JumpN, $1C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Ryo_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Ryo_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Ryo_BlockG, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Ryo_BlockC, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Ryo_HopF, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Ryo_HopB, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Ryo_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Ryo_Taunt, $14, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Ryo_Dodge, $00, $1E, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Ryo_Wakeup, $04, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Ryo_Dizzy, $04, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Ryo_Win, $14, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Ryo_LostTimeover, $00, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Ryo_Intro, $24, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Ryo_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Ryo_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Ryo_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Ryo_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Ryo_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Ryo_KickHN, $0C, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Ryo_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Ryo_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Ryo_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Ryo_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Ryo_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Ryo_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Ryo_DodgeCounter, $0C, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Ryo_Strike, $0C, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Ryo_PunchFH, $04, $02, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Ryo_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Ryo_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Ryo_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Ryo_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Ryo_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Ryo_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Ryo_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Ryo_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Ryo_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Ryo_KoOuKenGl, $08, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_KO_OU_KEN_GL
	mMvAnDef OBJLstPtrTable_Ryo_KoOuKenGl, $08, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_KO_OU_KEN_GH
	mMvAnDef OBJLstPtrTable_Ryo_HienShippuuKyaku, $14, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_HIEN_SHIPPUU_KYAKU_L
	mMvAnDef OBJLstPtrTable_Ryo_HienShippuuKyaku, $14, $04, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $07 ; MOVE_RYO_HIEN_SHIPPUU_KYAKU_H
	mMvAnDef OBJLstPtrTable_Ryo_Zenretsuken, $5C, $00, $04, HITTYPE_HIT_MULTI0, $00 ; BANK $07 ; MOVE_RYO_ZENRETSUKEN_L
	mMvAnDef OBJLstPtrTable_Ryo_Zenretsuken, $5C, $00, $04, HITTYPE_HIT_MULTI0, $00 ; BANK $07 ; MOVE_RYO_ZENRETSUKEN_H
	mMvAnDef OBJLstPtrTable_Ryo_KoHou, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_KO_HOU_L
	mMvAnDef OBJLstPtrTable_Ryo_KoHou, $14, $03, $09, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_RYO_KO_HOU_H
	mMvAnDef OBJLstPtrTable_Ryo_KoOuKenAl, $0C, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_KO_OU_KEN_AL
	mMvAnDef OBJLstPtrTable_Ryo_KoOuKenAl, $0C, $03, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_RYO_KO_OU_KEN_AH
	mMvAnDef OBJLstPtrTable_Ryo_HaohShokouKen, $08, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_HAOH_SHOKOU_KEN_L
	mMvAnDef OBJLstPtrTable_Ryo_HaohShokouKen, $08, $03, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_RYO_HAOH_SHOKOU_KEN_H
	mMvAnDef OBJLstPtrTable_Ryo_KyokukenRyuRenbuKen, $10, $01, $0A, HITTYPE_HIT_MID1, PF3_HITLOW|PF3_OVERHEAD|PF3_CONTHIT ;X ; BANK $07 ; MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_L
	mMvAnDef OBJLstPtrTable_Ryo_KyokukenRyuRenbuKen, $10, $01, $0A, HITTYPE_HIT_MID1, PF3_HITLOW|PF3_OVERHEAD|PF3_CONTHIT ; BANK $07 ; MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_H
	mMvAnDef OBJLstPtrTable_Ryo_RyuKoRanbu, $44, $08, $09, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $07 ; MOVE_RYO_RYU_KO_RANBU_S
	mMvAnDef OBJLstPtrTable_Ryo_ThrowG, $08, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Ryo_Idle, $00, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Ryo_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Ryo_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Ryo_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Ryo_HitLow, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Ryo_LaunchUB, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Ryo_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Ryo_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Ryo_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Ryo_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Ryo_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Ryo_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Ryo_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Ryo_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Ryo_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Ryo_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Yuri:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Yuri_WalkF, $0C, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Yuri_WalkB, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Yuri_Crouch, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $03, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Yuri_JumpN, $1C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Yuri_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Yuri_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Yuri_BlockG, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Yuri_BlockC, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Yuri_HopF, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Yuri_HopB, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Yuri_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Yuri_Taunt, $20, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Yuri_Dodge, $00, $1E, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Yuri_Wakeup, $04, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Yuri_Dizzy, $04, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Yuri_Win, $1C, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Yuri_LostTimeover, $00, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Yuri_Taunt, $20, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Yuri_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Yuri_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Yuri_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Yuri_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Yuri_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Yuri_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Yuri_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Yuri_KickHM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Yuri_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Yuri_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Yuri_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Yuri_KickCH, $0C, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Yuri_DodgeCounter, $0C, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Yuri_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Yuri_KickFH, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Yuri_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Yuri_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Yuri_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Yuri_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Yuri_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Yuri_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Yuri_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Yuri_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Yuri_PunchAHI, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Yuri_KoOuKen, $08, $02, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_KO_OU_KEN_L
	mMvAnDef OBJLstPtrTable_Yuri_KoOuKen, $08, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_KO_OU_KEN_H
	mMvAnDef OBJLstPtrTable_Yuri_SaiHa, $10, $00, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_SAI_HA_L
	mMvAnDef OBJLstPtrTable_Yuri_SaiHa, $10, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_SAI_HA_H
	mMvAnDef OBJLstPtrTable_Yuri_HyakuRetsuBintaL, $58, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_HYAKU_RETSU_BINTA_L
	mMvAnDef OBJLstPtrTable_Yuri_HyakuRetsuBintaH, $08, $01, $04, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_HYAKU_RETSU_BINTA_H
	mMvAnDef OBJLstPtrTable_Yuri_KuuGaL, $0C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $07 ; MOVE_YURI_KUU_GA_L
	mMvAnDef OBJLstPtrTable_Yuri_KuuGaH, $00, $FF, $09, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_YURI_KUU_GA_H
	mMvAnDef OBJLstPtrTable_Yuri_RaiOhKen, $18, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_RAI_OH_KEN_L
	mMvAnDef OBJLstPtrTable_Yuri_RaiOhKen, $18, $04, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_RAI_OH_KEN_H
	mMvAnDef OBJLstPtrTable_Yuri_HaohShoukouKen, $08, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_HAOH_SHOUKOU_KEN_L
	mMvAnDef OBJLstPtrTable_Yuri_HaohShoukouKen, $08, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_YURI_HAOH_SHOUKOU_KEN_H
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_YURI_7C
	mMvAnDef OBJLstPtrTable_Yuri_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_YURI_7E
	mMvAnDef OBJLstPtrTable_Yuri_HienHouOuKyaKu, $4C, $02, $09, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $07 ; MOVE_YURI_HIEN_HOU_OU_KYA_KU_S
	mMvAnDef OBJLstPtrTable_Yuri_ThrowG, $28, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Yuri_ThrowA, $08, $0A, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Yuri_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Yuri_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Yuri_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Yuri_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Yuri_LaunchUB, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Yuri_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Yuri_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Yuri_HitSweep, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Yuri_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Yuri_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Yuri_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Yuri_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Yuri_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Yuri_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Yuri_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Terry:
	db $52, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Terry_Idle, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Terry_WalkF, $08, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Terry_WalkB, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Terry_Crouch, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Kyo_CrouchWalkF, $04, $03, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Terry_JumpN, $1C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Terry_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Terry_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Terry_BlockG, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Terry_BlockC, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Terry_HopF, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Terry_HopB, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Terry_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Terry_Taunt, $1C, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Terry_Dodge, $00, $1E, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Terry_Wakeup, $04, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Terry_Dizzy, $04, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Terry_Win, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Terry_LostTimeover, $00, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Terry_Taunt, $1C, $03, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Terry_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Terry_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Terry_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Terry_PunchHM, $0C, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Terry_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Terry_KickHN, $0C, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Terry_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Terry_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Terry_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Terry_PunchCH, $0C, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Terry_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Terry_KickCH, $0C, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Terry_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Terry_Strike, $14, $04, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Terry_PunchFH, $0C, $01, $06, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Terry_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Terry_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Terry_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Terry_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Terry_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Terry_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Terry_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Terry_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Terry_KickALI, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Terry_PowerWave, $0C, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_POWER_WAVE_L
	mMvAnDef OBJLstPtrTable_Terry_PowerWave, $0C, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_POWER_WAVE_H
	mMvAnDef OBJLstPtrTable_Terry_BurnKnuckle, $18, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_BURN_KNUCKLE_L
	mMvAnDef OBJLstPtrTable_Terry_BurnKnuckle, $18, $04, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_BURN_KNUCKLE_H
	mMvAnDef OBJLstPtrTable_Terry_CrackShot, $10, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_CRACK_SHOT_L
	mMvAnDef OBJLstPtrTable_Terry_CrackShot, $10, $04, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_CRACK_SHOT_H
	mMvAnDef OBJLstPtrTable_Terry_RisingTackle, $1C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_RISING_TACKLE_L
	mMvAnDef OBJLstPtrTable_Terry_RisingTackle, $1C, $02, $09, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_TERRY_RISING_TACKLE_H
	mMvAnDef OBJLstPtrTable_Terry_PowerDunk, $10, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $07 ; MOVE_TERRY_POWER_DUNK_L
	mMvAnDef OBJLstPtrTable_Terry_PowerDunk, $10, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $07 ; MOVE_TERRY_POWER_DUNK_H
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_TERRY_78
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_TERRY_7A
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_TERRY_7C
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_TERRY_7E
	mMvAnDef OBJLstPtrTable_Terry_PowerWave, $0C, $01, $20, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_TERRY_POWER_GEYSER_S
	mMvAnDef OBJLstPtrTable_Terry_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Terry_Idle, $00, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Terry_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Terry_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Terry_LostTimeover, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Terry_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Terry_LaunchUB, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Terry_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Terry_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Terry_HitSweep, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Terry_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Terry_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Terry_LostTimeover, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Terry_LaunchDBShake, $0C, $FF, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Terry_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Terry_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Terry_LaunchDBShake, $00, $3C, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_GRAB_UB_SYNC
	mMvAnDef OBJLstPtrTable_Terry_LaunchDBShake, $00, $3C, $00, $00, $00 ;X ; BANK $07 ; [TCRF] Duplicate of above

MoveAnimTbl_Joe:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Joe_Idle, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Joe_WalkF, $0C, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Joe_WalkB, $0C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Joe_Crouch, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Joe_CrouchWalkF, $04, $03, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Joe_JumpN, $1C, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Joe_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Joe_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Joe_BlockG, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Joe_BlockC, $00, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Joe_HopF, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Joe_HopB, $08, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Joe_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Joe_Taunt, $14, $04, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Joe_Dodge, $00, $1E, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Joe_Wakeup, $04, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Joe_Dizzy, $04, $0A, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Joe_Win, $08, $06, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Joe_LostTimeover, $00, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Joe_Taunt, $14, $04, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Joe_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Joe_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Joe_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Joe_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Joe_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Joe_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Joe_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $07 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Joe_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Joe_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Joe_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Joe_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Joe_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Joe_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Joe_Strike, $08, $04, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Joe_KickFCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $07 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Joe_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Joe_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Joe_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Joe_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Joe_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Joe_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Joe_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Joe_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Joe_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $07 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $03, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Joe_HurricaneUpper, $08, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_HURRICANE_UPPER_L
	mMvAnDef OBJLstPtrTable_Joe_HurricaneUpper, $08, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_HURRICANE_UPPER_H
	mMvAnDef OBJLstPtrTable_Joe_SlashKickL, $10, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_SLASH_KICK_L
	mMvAnDef OBJLstPtrTable_Joe_SlashKickL, $10, $04, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_SLASH_KICK_H
	mMvAnDef OBJLstPtrTable_Joe_Bakuretsuken, $24, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_BAKURETSUKEN_L
	mMvAnDef OBJLstPtrTable_Joe_Bakuretsuken, $24, $04, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ;X ; BANK $07 ; MOVE_JOE_BAKURETSUKEN_H
	mMvAnDef OBJLstPtrTable_Joe_TigerKickL, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $07 ; MOVE_JOE_TIGER_KICK_L
	mMvAnDef OBJLstPtrTable_Joe_TigerKickL, $14, $02, $09, HITTYPE_HIT_MID1, $00 ; BANK $07 ; MOVE_JOE_TIGER_KICK_H
	mMvAnDef OBJLstPtrTable_Joe_OugonNoKakato, $14, $01, $09, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $07 ; MOVE_JOE_OUGON_NO_KAKATO_L
	mMvAnDef OBJLstPtrTable_Joe_OugonNoKakato, $14, $02, $09, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $07 ; MOVE_JOE_OUGON_NO_KAKATO_H
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_JOE_78
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_JOE_7A
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_JOE_7C
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $07 ; MOVE_JOE_7E
	mMvAnDef OBJLstPtrTable_Joe_HurricaneUpper, $08, $01, $02, HITTYPE_LAUNCH_SWOOPUP, $00 ; BANK $07 ; MOVE_JOE_SCREW_UPPER_S
	mMvAnDef OBJLstPtrTable_Joe_ThrowG, $0C, $01, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Joe_Idle, $00, $00, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Joe_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Joe_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Joe_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Joe_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $07 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Joe_LaunchUB, $10, $05, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Joe_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Joe_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Joe_HitSweep, $08, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Joe_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Joe_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Joe_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Joe_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Joe_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Joe_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Joe_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $07 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Heidern:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $0C, $06, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Heidern_WalkF, $08, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Heidern_WalkB, $08, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Heidern_Crouch, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $03, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Heidern_JumpN, $1C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Heidern_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Heidern_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Heidern_BlockG, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Heidern_BlockC, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Heidern_HopF, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Heidern_HopB, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Heidern_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Heidern_Taunt, $00, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Heidern_Dodge, $00, $1E, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Heidern_Wakeup, $04, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Heidern_Dizzy, $04, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Heidern_Win, $0C, $06, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Heidern_LostTimeover, $00, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Heidern_Intro, $08, $09, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Heidern_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Heidern_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Heidern_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Heidern_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Heidern_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Heidern_KickHN, $0C, $02, $08, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Heidern_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Heidern_KickHM, $14, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Heidern_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Heidern_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Heidern_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Heidern_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Heidern_DodgeCounter, $0C, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Heidern_Strike, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Heidern_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Heidern_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Heidern_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Heidern_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Heidern_PunchALX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Heidern_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Heidern_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Heidern_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Heidern_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Heidern_CrossCutter, $0C, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_CROSS_CUTTER_L
	mMvAnDef OBJLstPtrTable_Heidern_CrossCutter, $10, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_CROSS_CUTTER_H
	mMvAnDef OBJLstPtrTable_Heidern_NeckRoller, $20, $01, $03, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $08 ; MOVE_HEIDERN_NECK_ROLLER_L
	mMvAnDef OBJLstPtrTable_Heidern_NeckRoller, $20, $04, $03, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $08 ; MOVE_HEIDERN_NECK_ROLLER_H
	mMvAnDef OBJLstPtrTable_Heidern_StormBringer, $58, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_STORM_BRINGER_L
	mMvAnDef OBJLstPtrTable_Heidern_StormBringer, $58, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_STORM_BRINGER_H
	mMvAnDef OBJLstPtrTable_Heidern_MoonSlasher, $0C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $08 ; MOVE_HEIDERN_MOON_SLASHER_L
	mMvAnDef OBJLstPtrTable_Heidern_MoonSlasher, $0C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_MOON_SLASHER_H
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $08 ; MOVE_HEIDERN_74
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $08 ; MOVE_HEIDERN_76
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_HEIDERN_78
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_HEIDERN_7A
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_HEIDERN_7C
	mMvAnDef OBJLstPtrTable_Heidern_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_HEIDERN_7E
	mMvAnDef OBJLstPtrTable_Heidern_NeckRoller, $18, $01, $04, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT ; BANK $08 ; MOVE_HEIDERN_FINAL_BRINGER_S
	mMvAnDef OBJLstPtrTable_Heidern_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Heidern_ThrowA, $08, $0A, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Heidern_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Heidern_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Heidern_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Heidern_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Heidern_LaunchUB, $10, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Heidern_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Heidern_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Heidern_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Heidern_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Heidern_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Heidern_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Heidern_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Heidern_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Heidern_LaunchDBShake, $00, $3C, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Heidern_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Ralf:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $0C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Ralf_WalkF, $0C, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Ralf_WalkB, $0C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Ralf_Crouch, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $03, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Ralf_JumpN, $1C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Ralf_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Ralf_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Ralf_BlockG, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Ralf_BlockC, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Ralf_HopF, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Ralf_HopB, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Ralf_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Ralf_Taunt, $00, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Ralf_Dodge, $00, $1E, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Ralf_Wakeup, $04, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Ralf_Dizzy, $04, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Ralf_Win, $18, $03, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Ralf_LostTimeover, $00, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Ralf_Intro, $34, $03, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Ralf_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Ralf_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Ralf_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Ralf_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Ralf_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Ralf_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Ralf_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Ralf_KickHM, $10, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Ralf_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Ralf_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Ralf_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Ralf_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Ralf_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Ralf_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Ralf_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Ralf_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Ralf_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Ralf_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Ralf_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Ralf_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Ralf_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Ralf_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ;X ; BANK $08 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Ralf_KickALI, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Ralf_VulcanPunchL, $0C, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_FIRE ; BANK $08 ; MOVE_RALF_VULCAN_PUNCH_L
	mMvAnDef OBJLstPtrTable_Ralf_VulcanPunchL, $0C, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_CONTHIT ; BANK $08 ; MOVE_RALF_VULCAN_PUNCH_H
	mMvAnDef OBJLstPtrTable_Ralf_GatlingAttackL, $14, $02, $0A, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $08 ; MOVE_RALF_GATLING_ATTACK_L
	mMvAnDef OBJLstPtrTable_Ralf_GatlingAttackL, $14, $04, $0A, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $08 ; MOVE_RALF_GATLING_ATTACK_H
	mMvAnDef OBJLstPtrTable_Ralf_BackBreaker, $28, $0A, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_RALF_BACK_BREAKER_L
	mMvAnDef OBJLstPtrTable_Ralf_BackBreaker, $28, $0A, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_RALF_BACK_BREAKER_H
	mMvAnDef OBJLstPtrTable_Ralf_BakudanPunchL, $2C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_RALF_BAKUDAN_PUNCH_L
	mMvAnDef OBJLstPtrTable_Ralf_BakudanPunchL, $2C, $02, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_RALF_BAKUDAN_PUNCH_H
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $08 ; MOVE_RALF_74
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $08 ; MOVE_RALF_76
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_RALF_78
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_RALF_7A
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_RALF_7C
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_RALF_7E
	mMvAnDef OBJLstPtrTable_Ralf_BaribariVulcanPunchS, $30, $01, $0A, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $08 ; MOVE_RALF_BARIBARI_VULCAN_PUNCH_S
	mMvAnDef OBJLstPtrTable_Ralf_ThrowG, $14, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Ralf_Idle, $00, $00, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Ralf_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Ralf_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Ralf_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Ralf_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Ralf_LaunchUB, $10, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Ralf_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Ralf_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Ralf_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Ralf_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Ralf_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Ralf_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Ralf_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Ralf_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Ralf_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Ralf_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Athena:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Athena_Idle, $04, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Athena_WalkF, $08, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Athena_WalkB, $08, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Athena_Crouch, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $03, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Athena_JumpN, $1C, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Athena_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Athena_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Athena_BlockG, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Athena_BlockC, $00, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Athena_HopF, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Athena_HopB, $08, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Athena_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Athena_Taunt, $0C, $04, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Athena_Dodge, $00, $1E, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Athena_Wakeup, $04, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Athena_Dizzy, $04, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Athena_Win, $18, $03, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Athena_LostTimeover, $00, $01, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Athena_Intro, $24, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Athena_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Athena_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Athena_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Athena_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Athena_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Athena_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Athena_KickLN, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $08 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Athena_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Athena_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Athena_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Athena_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Athena_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $08 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Athena_DodgeCounter, $04, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Athena_Strike, $08, $05, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Athena_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Athena_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Athena_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Athena_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Athena_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Athena_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Athena_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Athena_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ;X ; BANK $08 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Athena_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $08 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Athena_KickAHD, $10, $FF, $06, HITTYPE_HIT_MID1, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Athena_PsychoBall, $04, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PSYCHO_BALL_L
	mMvAnDef OBJLstPtrTable_Athena_PsychoBall, $04, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PSYCHO_BALL_H
	mMvAnDef OBJLstPtrTable_Athena_PsychoReflector, $10, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PSYCHO_REFLECTOR_L
	mMvAnDef OBJLstPtrTable_Athena_PsychoReflector, $10, $04, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PSYCHO_REFLECTOR_H
	mMvAnDef OBJLstPtrTable_Athena_PsychoSword, $1C, $01, $04, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $08 ; MOVE_ATHENA_PSYCHO_SWORD_L
	mMvAnDef OBJLstPtrTable_Athena_PsychoSword, $1C, $04, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PSYCHO_SWORD_H
	mMvAnDef OBJLstPtrTable_Athena_PhoenixArrow, $10, $01, $09, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_ATHENA_PHOENIX_ARROW_L
	mMvAnDef OBJLstPtrTable_Athena_PhoenixArrow, $10, $02, $09, HITTYPE_HIT_MID1, $00 ; BANK $08 ; MOVE_ATHENA_PHOENIX_ARROW_H
	mMvAnDef OBJLstPtrTable_Athena_PhoenixArrowKick, $08, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $08 ; MOVE_ATHENA_74
	mMvAnDef OBJLstPtrTable_Athena_PhoenixArrowKick, $08, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_PHOENIX_ARROW_KICK_H
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_ATHENA_78
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_ATHENA_7A
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_ATHENA_7C
	mMvAnDef OBJLstPtrTable_Athena_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $08 ; MOVE_ATHENA_7E
	mMvAnDef OBJLstPtrTable_Athena_ShiningCrystalBitG, $14, $08, $14, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $08 ; MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS
	mMvAnDef OBJLstPtrTable_Athena_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Athena_ThrowA, $0C, $0A, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Athena_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Athena_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Athena_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Athena_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $08 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Athena_LaunchUB, $10, $05, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Athena_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Athena_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Athena_HitSweep, $08, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Athena_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Athena_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Athena_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Athena_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Athena_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Athena_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Athena_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Kensou:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $0C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Kensou_WalkF, $0C, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Kensou_WalkB, $0C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Kensou_Crouch, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $03, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Kensou_JumpN, $1C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Kensou_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Kensou_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Kensou_BlockG, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Kensou_BlockC, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Kensou_HopF, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Kensou_HopB, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Kensou_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Kensou_Taunt, $0C, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Kensou_Dodge, $00, $1E, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Kensou_Wakeup, $04, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Kensou_Dizzy, $04, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Kensou_Win, $20, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Kensou_LostTimeover, $00, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Kensou_Intro, $34, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Kensou_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Kensou_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Kensou_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Kensou_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Kensou_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Kensou_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Kensou_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Kensou_KickHM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Kensou_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Kensou_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Kensou_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Kensou_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Kensou_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Kensou_Strike, $04, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Kensou_PunchFH, $08, $01, $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Kensou_KickFH, $0C, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Kensou_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Kensou_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Kensou_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Kensou_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Kensou_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Kensou_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Kensou_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Kensou_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Kensou_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Kensou_ChouKyuuDan, $04, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_KENSOU_CHOU_KYUU_DAN_L
	mMvAnDef OBJLstPtrTable_Kensou_ChouKyuuDan, $04, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_KENSOU_CHOU_KYUU_DAN_H
	mMvAnDef OBJLstPtrTable_Kensou_RyuuGakuSai, $24, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_KENSOU_RYUU_GAKU_SAI_L
	mMvAnDef OBJLstPtrTable_Kensou_RyuuGakuSai, $24, $04, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_KENSOU_RYUU_GAKU_SAI_H
	mMvAnDef OBJLstPtrTable_Kensou_RyuuRenGa, $18, $01, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_KENSOU_RYUU_REN_GA_L
	mMvAnDef OBJLstPtrTable_Kensou_RyuuRenGa, $18, $04, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_KENSOU_RYUU_REN_GA_H
	mMvAnDef OBJLstPtrTable_Kensou_RyuuSouGeki, $18, $01, $09, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_KENSOU_RYUU_SOU_GEKI_L
	mMvAnDef OBJLstPtrTable_Kensou_RyuuSouGeki, $18, $02, $09, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_KENSOU_RYUU_SOU_GEKI_H
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $09 ; MOVE_KENSOU_74
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $09 ; MOVE_KENSOU_76
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KENSOU_78
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KENSOU_7A
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KENSOU_7C
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KENSOU_7E
	mMvAnDef OBJLstPtrTable_Kensou_ShinryuuTenbuKyaku, $18, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $09 ; MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S
	mMvAnDef OBJLstPtrTable_Kensou_ThrowG, $08, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Kensou_Idle, $00, $00, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Kensou_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Kensou_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Kensou_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Kensou_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Kensou_LaunchUB, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Kensou_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Kensou_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Kensou_HitSweep, $08, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Kensou_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Kensou_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Kensou_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Kensou_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Kensou_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Kensou_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Kensou_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Kim:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Kim_Idle, $0C, $06, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Kim_WalkF, $08, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Kim_WalkB, $08, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Kim_Crouch, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Kim_CrouchWalkF, $0C, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Kim_JumpN, $1C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Kim_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Kim_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Kim_BlockG, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Kim_BlockC, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Kim_HopF, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Kim_HopB, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Kim_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Kim_Taunt, $0C, $04, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Kim_Dodge, $00, $1E, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Kim_Wakeup, $04, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Kim_Dizzy, $04, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Kim_Win, $1C, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Kim_LostTimeover, $00, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Kim_Intro, $28, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Kim_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Kim_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Kim_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Kim_PunchHM, $0C, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Kim_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Kim_KickHN, $08, $02, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Kim_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Kim_KickHM, $14, $03, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Kim_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Kim_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Kim_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Kim_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Kim_DodgeCounter, $0C, $02, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Kim_Strike, $04, $05, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Kim_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Kim_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Kim_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ;X ; BANK $09 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Kim_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Kim_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Kim_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Kim_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Kim_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Kim_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Kim_HanGetsuZan, $14, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $09 ; MOVE_KIM_HAN_GETSU_ZAN_L
	mMvAnDef OBJLstPtrTable_Kim_HanGetsuZan, $14, $03, $0A, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $09 ; MOVE_KIM_HAN_GETSU_ZAN_H
	mMvAnDef OBJLstPtrTable_Kim_HienZan, $14, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_KIM_HIEN_ZAN_L
	mMvAnDef OBJLstPtrTable_Kim_HienZan, $14, $04, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_KIM_HIEN_ZAN_H
	mMvAnDef OBJLstPtrTable_Kim_HishouKyaku, $0C, $FF, $04, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $09 ; MOVE_KIM_HISHOU_KYAKU_L
	mMvAnDef OBJLstPtrTable_Kim_HishouKyaku, $0C, $FF, $04, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $09 ; MOVE_KIM_HISHOU_KYAKU_H
	mMvAnDef OBJLstPtrTable_Kim_RyuuseiRanku, $10, $06, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_HITLOW|PF3_CONTHIT ; BANK $09 ; MOVE_KIM_RYUUSEI_RANKU_L
	mMvAnDef OBJLstPtrTable_Kim_RyuuseiRanku, $10, $08, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_HITLOW|PF3_CONTHIT ; BANK $09 ; MOVE_KIM_RYUUSEI_RANKU_H
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $09 ; MOVE_KIM_74
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $09 ; MOVE_KIM_76
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KIM_78
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KIM_7A
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KIM_7C
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_KIM_7E
	mMvAnDef OBJLstPtrTable_Kim_HouOuKyaku, $3C, $02, $09, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $09 ; MOVE_KIM_HOU_OU_KYAKU_S
	mMvAnDef OBJLstPtrTable_Kim_ThrowG, $08, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Kim_Idle, $00, $00, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Kim_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Kim_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Kim_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Kim_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Kim_LaunchUB, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Kim_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Kim_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Kim_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Kim_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Kim_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Kim_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Kim_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Kim_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Kim_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Kim_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Mai:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Mai_Idle, $0C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Mai_WalkF, $08, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Mai_WalkB, $08, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Mai_Crouch, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Mai_CrouchWalkF, $08, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Mai_JumpN, $1C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Mai_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Mai_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Mai_BlockG, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Mai_BlockC, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Mai_HopF, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Mai_HopB, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Mai_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Mai_Taunt, $14, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Mai_Dodge, $00, $1E, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Mai_Wakeup, $04, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Mai_Dizzy, $04, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Mai_Win, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Mai_LostTimeover, $00, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Mai_Taunt, $14, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Mai_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Mai_PunchLN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Mai_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Mai_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Mai_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Mai_KickLN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Mai_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Mai_KickLM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Mai_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Mai_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Mai_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Mai_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Mai_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Mai_Strike, $08, $02, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Mai_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Mai_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Mai_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Mai_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Mai_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Mai_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Mai_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Mai_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Mai_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Mai_PunchAHD, $10, $01, $06, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Mai_KaChoSen, $10, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_KA_CHO_SEN_L
	mMvAnDef OBJLstPtrTable_Mai_KaChoSen, $10, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_KA_CHO_SEN_H
	mMvAnDef OBJLstPtrTable_Mai_HissatsuShinobibachi, $10, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $09 ; MOVE_MAI_HISSATSU_SHINOBIBACHI_L
	mMvAnDef OBJLstPtrTable_Mai_HissatsuShinobibachi, $10, $03, $0A, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $09 ; MOVE_MAI_HISSATSU_SHINOBIBACHI_H
	mMvAnDef OBJLstPtrTable_Mai_RyuEnBu, $10, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_RYU_EN_BU_L
	mMvAnDef OBJLstPtrTable_Mai_RyuEnBu, $10, $02, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_RYU_EN_BU_H
	mMvAnDef OBJLstPtrTable_Mai_HishoRyuEnJin, $18, $01, $09, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_MAI_HISHO_RYU_EN_JIN_L
	mMvAnDef OBJLstPtrTable_Mai_HishoRyuEnJin, $18, $02, $09, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_MAI_HISHO_RYU_EN_JIN_H
	mMvAnDef OBJLstPtrTable_Mai_ChijouMusasabi, $28, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_CHIJOU_MUSASABI_L
	mMvAnDef OBJLstPtrTable_Mai_ChijouMusasabi, $28, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_CHIJOU_MUSASABI_H
	mMvAnDef OBJLstPtrTable_Mai_KuuchuuMusasabi, $08, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_KUUCHUU_MUSASABI_L
	mMvAnDef OBJLstPtrTable_Mai_KuuchuuMusasabi, $08, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_MAI_KUUCHUU_MUSASABI_H
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_MAI_7C
	mMvAnDef OBJLstPtrTable_Mai_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_MAI_7E
	mMvAnDef OBJLstPtrTable_Mai_ChoHissatsuShinobibachi, $18, $02, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S
	mMvAnDef OBJLstPtrTable_Mai_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Mai_ThrowA, $08, $0A, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Mai_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Mai_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Mai_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Mai_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Mai_LaunchUB, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Mai_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Mai_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Mai_HitSweep, $08, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Mai_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Mai_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Mai_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Mai_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Mai_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Mai_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Mai_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Iori:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Iori_Idle, $0C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Iori_WalkF, $0C, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Iori_WalkB, $0C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Iori_Crouch, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $03, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Iori_JumpN, $1C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Iori_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Iori_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Iori_BlockG, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Iori_BlockC, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Iori_HopF, $08, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Iori_HopB, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Iori_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Iori_Taunt, $00, $08, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Iori_Dodge, $00, $1E, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Iori_Wakeup, $04, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Iori_Dizzy, $04, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Iori_Win, $10, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Iori_LostTimeover, $00, $09, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Iori_Intro, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Iori_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Iori_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Iori_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Iori_PunchHM, $0C, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Iori_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Iori_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Iori_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Iori_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Iori_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Iori_PunchCH, $0C, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Iori_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Iori_KickCH, $0C, $04, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Iori_DodgeCounter, $04, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Iori_Strike, $08, $04, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Iori_PunchFH, $08, $03, $06, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Iori_KickFH, $10, $03, $06, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Iori_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Iori_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Iori_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Iori_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Iori_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Iori_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Iori_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ;X ; BANK $09 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Iori_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Iori_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $00, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $00, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Iori_KickAhb, $10, $01, $06, HITTYPE_HIT_MID0, $00 ;X ; BANK $09 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Iori_YamiBarai, $14, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_FIRE ; BANK $09 ; MOVE_IORI_YAMI_BARAI_L
	mMvAnDef OBJLstPtrTable_Iori_YamiBarai, $14, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_FIRE ; BANK $09 ; MOVE_IORI_YAMI_BARAI_H
	mMvAnDef OBJLstPtrTable_Iori_OniYaki, $14, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE ; BANK $09 ; MOVE_IORI_ONI_YAKI_L
	mMvAnDef OBJLstPtrTable_Iori_OniYaki, $14, $02, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_IORI_ONI_YAKI_H
	mMvAnDef OBJLstPtrTable_Iori_AoiHana, $14, $01, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_IORI_AOI_HANA_L
	mMvAnDef OBJLstPtrTable_Iori_AoiHana, $14, $01, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $09 ; MOVE_IORI_AOI_HANA_H
	mMvAnDef OBJLstPtrTable_Iori_KotoTsukiIn, $1C, $01, $09, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $09 ; MOVE_IORI_KOTO_TSUKI_IN_L
	mMvAnDef OBJLstPtrTable_Iori_KotoTsukiIn, $1C, $01, $09, HITTYPE_HIT_MID0, PF3_CONTHIT ; BANK $09 ; MOVE_IORI_KOTO_TSUKI_IN_H
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $01, $09, HITTYPE_HIT_MULTI0, $00 ;X ; BANK $09 ; MOVE_IORI_74
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $04, $09, HITTYPE_HIT_MULTI0, $00 ;X ; BANK $09 ; MOVE_IORI_76
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_IORI_78
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_IORI_7A
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_IORI_7C
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $09 ; MOVE_IORI_7E
	mMvAnDef OBJLstPtrTable_Iori_KinYaOtome, $48, $0C, $09, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $09 ; MOVE_IORI_KIN_YA_OTOME_S
	mMvAnDef OBJLstPtrTable_Iori_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Iori_Idle, $00, $00, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Iori_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Iori_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Iori_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Iori_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Iori_LaunchUB, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Iori_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Iori_LaunchSwoopup, $18, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Iori_HitSweep, $08, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Iori_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Iori_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Iori_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Iori_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Iori_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Iori_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Iori_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Eiji:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Eiji_Idle, $04, $04, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Eiji_WalkF, $04, $03, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Eiji_WalkB, $04, $04, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Eiji_Crouch, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Eiji_Idle, $00, $03, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Eiji_JumpN, $1C, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Eiji_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Eiji_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Eiji_BlockG, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Eiji_BlockC, $00, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Eiji_HopF, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Eiji_HopB, $08, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Eiji_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Eiji_Taunt, $14, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Eiji_Dodge, $00, $1E, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Eiji_Wakeup, $04, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Eiji_Dizzy, $04, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Eiji_Win, $08, $09, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Eiji_LostTimeover, $00, $01, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Eiji_Intro, $20, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Eiji_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Eiji_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Eiji_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Eiji_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Eiji_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Eiji_KickHN, $14, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Eiji_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $09 ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Eiji_KickHM, $0C, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Eiji_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Eiji_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Eiji_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Eiji_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $09 ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Eiji_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Eiji_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Eiji_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Eiji_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Eiji_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Eiji_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Eiji_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Eiji_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Eiji_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Eiji_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Eiji_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Eiji_KickALX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Eiji_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Eiji_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $09 ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Eiji_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Eiji_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Eiji_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $09 ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Eiji_Kikouhou, $0C, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KIKOUHOU_L
	mMvAnDef OBJLstPtrTable_Eiji_Kikouhou, $0C, $02, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KIKOUHOU_H
	mMvAnDef OBJLstPtrTable_Eiji_KotsuHazakiKiri, $14, $01, $0A, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KOTSU_HAZAKI_KIRI_L
	mMvAnDef OBJLstPtrTable_Eiji_KotsuHazakiKiri, $14, $01, $0A, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KOTSU_HAZAKI_KIRI_H
	mMvAnDef OBJLstPtrTable_Eiji_RyuuEijin, $18, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_RYUU_EIJIN_L
	mMvAnDef OBJLstPtrTable_Eiji_RyuuEijin, $18, $04, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_RYUU_EIJIN_H
	mMvAnDef OBJLstPtrTable_Eiji_KasumiGeri, $0C, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KASUMI_GERI_L
	mMvAnDef OBJLstPtrTable_Eiji_KasumiGeri, $0C, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_KASUMI_GERI_H
	mMvAnDef OBJLstPtrTable_Eiji_Zantetsuha, $08, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_ZANTETSUHA_L
	mMvAnDef OBJLstPtrTable_Eiji_Zantetsuha, $08, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $09 ; MOVE_EIJI_ZANTETSUHA_H
	mMvAnDef OBJLstPtrTable_Eiji_KageUtsushi, $10, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_EIJI_KAGE_UTSUSHI_L
	mMvAnDef OBJLstPtrTable_Eiji_KageUtsushi, $10, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $09 ; MOVE_EIJI_KAGE_UTSUSHI_H
	mMvAnDef OBJLstPtrTable_Eiji_KotsuHazakiKiri, $14, $01, $00, $00, $00 ; BANK $09 ; MOVE_EIJI_TENBAKYAKU_L
	mMvAnDef OBJLstPtrTable_Eiji_KotsuHazakiKiri, $14, $01, $00, $00, $00 ; BANK $09 ; MOVE_EIJI_TENBAKYAKU_H
	mMvAnDef OBJLstPtrTable_Eiji_ZantetsuTourouken, $54, $02, $01, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $09 ; MOVE_EIJI_ZANTETSU_TOUROUKEN_S
	mMvAnDef OBJLstPtrTable_Eiji_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Eiji_ThrowG, $00, $0A, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Eiji_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Eiji_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Eiji_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Eiji_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Eiji_LaunchUB, $10, $05, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Eiji_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Eiji_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Eiji_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Eiji_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Eiji_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Eiji_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Eiji_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Eiji_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Eiji_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $09 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Eiji_LaunchDBShake, $00, $3C, $00, $00, $00 ;X ; BANK $09 ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Billy:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Billy_Idle, $0C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Billy_WalkF, $04, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Billy_WalkB, $04, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Billy_Crouch, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Billy_CrouchWalkF, $0C, $03, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Billy_JumpN, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Billy_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Billy_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Billy_BlockG, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Billy_BlockC, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Billy_HopF, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Billy_HopB, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Billy_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Billy_Taunt, $14, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Billy_Dodge, $00, $1E, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Billy_Wakeup, $04, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Billy_Dizzy, $04, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Billy_Win, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Billy_LostTimeover, $00, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Billy_Intro, $30, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Billy_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Billy_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Billy_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Billy_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Billy_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Billy_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Billy_KickLN, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Billy_KickHM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Billy_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Billy_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Billy_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Billy_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Billy_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Billy_Strike, $0C, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Billy_KickFH, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Billy_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Billy_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Billy_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Billy_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Billy_PunchALX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Billy_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Billy_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ;X ; BANK $0A ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Billy_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Billy_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Billy_SansetsuKonChuudanUchi, $10, $01, $0A, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L
	mMvAnDef OBJLstPtrTable_Billy_SansetsuKonChuudanUchi, $10, $03, $0A, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H
	mMvAnDef OBJLstPtrTable_Billy_SenpuuKon, $0C, $00, $0A, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SENPUU_KON_L
	mMvAnDef OBJLstPtrTable_Billy_SenpuuKon, $0C, $02, $0A, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SENPUU_KON_H
	mMvAnDef OBJLstPtrTable_Billy_SuzumeOtoshi, $10, $01, $04, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SUZUME_OTOSHI_L
	mMvAnDef OBJLstPtrTable_Billy_SuzumeOtoshi, $10, $04, $04, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_BILLY_SUZUME_OTOSHI_H
	mMvAnDef OBJLstPtrTable_Billy_KyoushuuHishouKon, $1C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, $00 ; BANK $0A ; MOVE_BILLY_KYOUSHUU_HISHOU_KON_L
	mMvAnDef OBJLstPtrTable_Billy_KyoushuuHishouKon, $1C, $02, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_BILLY_KYOUSHUU_HISHOU_KON_H
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $0A ; MOVE_BILLY_74
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $0A ; MOVE_BILLY_76
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_BILLY_78
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_BILLY_7A
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_BILLY_7C
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_BILLY_7E
	mMvAnDef OBJLstPtrTable_Billy_ChouKaenSenpuuKon, $40, $01, $20, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE ; BANK $0A ; MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S
	mMvAnDef OBJLstPtrTable_Billy_ThrowG, $18, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Billy_Idle, $00, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Billy_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Billy_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Billy_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Billy_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Billy_LaunchUB, $10, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Billy_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Billy_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Billy_HitSweep, $08, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Billy_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Billy_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Billy_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Billy_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Billy_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Billy_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Billy_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Saisyu:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $0C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Saisyu_WalkF, $0C, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Saisyu_WalkB, $0C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Saisyu_Crouch, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Saisyu_JumpN, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Saisyu_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Saisyu_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Saisyu_BlockG, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Saisyu_BlockC, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Saisyu_HopF, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Saisyu_HopB, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Saisyu_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Saisyu_Taunt, $10, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Saisyu_Dodge, $00, $1E, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Saisyu_Wakeup, $04, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Saisyu_Dizzy, $04, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Saisyu_Taunt, $10, $03, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Saisyu_LostTimeover, $00, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Saisyu_Intro, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Saisyu_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Saisyu_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, $00 ;X ; BANK $0A ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Saisyu_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Saisyu_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Saisyu_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Saisyu_KickHN, $08, $02, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Saisyu_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Saisyu_KickHN, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Saisyu_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Saisyu_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Saisyu_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Saisyu_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Saisyu_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Saisyu_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Saisyu_PunchFH, $04, $04, $06, HITTYPE_HIT_MID1, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Saisyu_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Saisyu_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Saisyu_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Saisyu_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Saisyu_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Saisyu_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Saisyu_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Saisyu_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Saisyu_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Saisyu_YamiBarai, $0C, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_FIRE ; BANK $0A ; MOVE_SAISYU_YAMI_BARAI_L
	mMvAnDef OBJLstPtrTable_Saisyu_YamiBarai, $0C, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SAISYU_YAMI_BARAI_H
	mMvAnDef OBJLstPtrTable_Saisyu_OniYaki, $14, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE ; BANK $0A ; MOVE_SAISYU_ONI_YAKI_L
	mMvAnDef OBJLstPtrTable_Saisyu_OniYaki, $14, $02, $0A, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $0A ; MOVE_SAISYU_ONI_YAKI_H
	mMvAnDef OBJLstPtrTable_Saisyu_EnJou, $14, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_OVERHEAD|PF3_CONTHIT ; BANK $0A ; MOVE_SAISYU_EN_JOU_L
	mMvAnDef OBJLstPtrTable_Saisyu_EnJou, $14, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_OVERHEAD|PF3_CONTHIT ; BANK $0A ; MOVE_SAISYU_EN_JOU_H
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SAISYU_70
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $02, $09, HITTYPE_HIT_MID0, $00 ;X ; BANK $0A ; MOVE_SAISYU_72
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $0A ; MOVE_SAISYU_74
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ;X ; BANK $0A ; MOVE_SAISYU_76
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_SAISYU_78
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_SAISYU_7A
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_SAISYU_7C
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_SAISYU_7E
	mMvAnDef OBJLstPtrTable_Saisyu_UraOrochiNagi, $24, $01, $20, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE ; BANK $0A ; MOVE_SAISYU_URA_OROCHI_NAGI_S
	mMvAnDef OBJLstPtrTable_Saisyu_ThrowG, $10, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Saisyu_Idle, $00, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Saisyu_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Saisyu_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Saisyu_LostTimeover, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Saisyu_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchUB, $10, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Saisyu_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Saisyu_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Saisyu_LostTimeover, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Saisyu_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Saisyu_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Rugal:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $0C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Rugal_WalkF, $08, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Rugal_WalkB, $08, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Rugal_Crouch, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $03, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Rugal_JumpN, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Rugal_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Rugal_JumpN, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Rugal_BlockG, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Rugal_BlockC, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Rugal_HopF, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Rugal_HopB, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Rugal_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Rugal_Taunt, $1C, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Rugal_Dodge, $00, $1E, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Rugal_Wakeup, $04, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Rugal_Dizzy, $04, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Rugal_Win, $10, $08, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Rugal_LostTimeover, $04, $04, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Rugal_Intro, $08, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Rugal_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ;X ; BANK $0A ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Rugal_PunchHN, $0C, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Rugal_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Rugal_PunchHM, $08, $02, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Rugal_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, PF3_HITLOW ;X ; BANK $0A ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Rugal_KickHN, $0C, $01, $08, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Rugal_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Rugal_KickHM, $10, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Rugal_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Rugal_PunchCH, $08, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Rugal_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Rugal_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Rugal_DodgeCounter, $08, $04, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Rugal_Strike, $08, $03, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Rugal_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Rugal_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Rugal_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Rugal_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Rugal_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Rugal_PunchAHI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Rugal_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Rugal_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Rugal_AttackA, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $10, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $10, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $10, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Rugal_ReppuKen, $0C, $01, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_REPPU_KEN_L
	mMvAnDef OBJLstPtrTable_Rugal_ReppuKen, $0C, $03, $0A, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_REPPU_KEN_H
	mMvAnDef OBJLstPtrTable_Rugal_GodPress, $10, $02, $0A, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_RUGAL_GOD_PRESS_L
	mMvAnDef OBJLstPtrTable_Rugal_GodPress, $10, $02, $0A, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_GOD_PRESS_H
	mMvAnDef OBJLstPtrTable_Rugal_DarkBarrier, $18, $01, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_DARK_BARRIER_L
	mMvAnDef OBJLstPtrTable_Rugal_DarkBarrier, $18, $04, $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_DARK_BARRIER_H
	mMvAnDef OBJLstPtrTable_Rugal_GenocideCutter, $10, $01, $09, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $0A ; MOVE_RUGAL_GENOCIDE_CUTTER_L
	mMvAnDef OBJLstPtrTable_Rugal_GenocideCutter, $10, $02, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT ; BANK $0A ; MOVE_RUGAL_GENOCIDE_CUTTER_H
	mMvAnDef OBJLstPtrTable_Rugal_KaiserWave, $0C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_RUGAL_KAISER_WAVE_L
	mMvAnDef OBJLstPtrTable_Rugal_KaiserWave, $0C, $04, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_KAISER_WAVE_H
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_RUGAL_
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_RUGAL_
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_RUGAL_
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $02, $0A, HITTYPE_DUMMY, $00 ;X ; BANK $0A ; MOVE_RUGAL_
	mMvAnDef OBJLstPtrTable_Rugal_GiganticPressure, $14, $01, $0A, HITTYPE_HIT_MULTI1, PF3_HEAVYHIT ; BANK $0A ; MOVE_RUGAL_GIGANTIC_PRESSURE_S
	mMvAnDef OBJLstPtrTable_Rugal_ThrowG, $0C, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Rugal_Idle, $00, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Rugal_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Rugal_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Rugal_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Rugal_HitLow, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Rugal_LaunchUB, $10, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Rugal_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Rugal_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Rugal_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Rugal_LaunchUBRec, $18, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Rugal_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Rugal_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Rugal_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Rugal_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Rugal_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Rugal_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_SYNC
MoveAnimTbl_Nakoruru:
	db $51, $00, $00, $00, $00, $00, $00, $00 ;X ; MOVE_SHARED_NONE
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $08, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_IDLE
	mMvAnDef OBJLstPtrTable_Nakoruru_WalkF, $08, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_F
	mMvAnDef OBJLstPtrTable_Nakoruru_WalkB, $08, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WALK_B
	mMvAnDef OBJLstPtrTable_Nakoruru_Crouch, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CROUCH
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $03, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_CROUCHWALK_F
	mMvAnDef OBJLstPtrTable_Nakoruru_JumpN, $1C, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_JUMP_N
	mMvAnDef OBJLstPtrTable_Nakoruru_JumpF, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_F
	mMvAnDef OBJLstPtrTable_Nakoruru_JumpB, $1C, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_JUMP_B
	mMvAnDef OBJLstPtrTable_Nakoruru_BlockG, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_G
	mMvAnDef OBJLstPtrTable_Nakoruru_BlockC, $00, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_BLOCK_C
	mMvAnDef OBJLstPtrTable_Nakoruru_HopF, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_F
	mMvAnDef OBJLstPtrTable_Nakoruru_HopB, $08, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HOP_B
	mMvAnDef OBJLstPtrTable_Nakoruru_ChargeMeter, $04, $00, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_CHARGEMETER
	mMvAnDef OBJLstPtrTable_Nakoruru_Taunt, $0C, $03, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_TAUNT
	mMvAnDef OBJLstPtrTable_Nakoruru_Dodge, $00, $1E, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DODGE
	mMvAnDef OBJLstPtrTable_Nakoruru_Wakeup, $04, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WAKEUP
	mMvAnDef OBJLstPtrTable_Nakoruru_Dizzy, $04, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_DIZZY
	mMvAnDef OBJLstPtrTable_Nakoruru_Win, $14, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_WIN
	mMvAnDef OBJLstPtrTable_Nakoruru_LostTimeover, $00, $01, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LOST_TIMEOVER
	mMvAnDef OBJLstPtrTable_Nakoruru_Intro, $1C, $06, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_INTRO
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchLN, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LN
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchHN, $08, $01, $04, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HN
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchLM, $08, $00, $04, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_LM
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchHM, $14, $00, $04, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_HM
	mMvAnDef OBJLstPtrTable_Nakoruru_KickLN, $08, $01, $08, HITTYPE_HIT_MID1, $00 ;X ; BANK $0A ; MOVE_SHARED_KICK_LN
	mMvAnDef OBJLstPtrTable_Nakoruru_KickHN, $10, $00, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HN
	mMvAnDef OBJLstPtrTable_Nakoruru_KickLM, $08, $01, $08, HITTYPE_HIT_MID0, $00 ; BANK $0A ; MOVE_SHARED_KICK_LM
	mMvAnDef OBJLstPtrTable_Nakoruru_KickHM, $08, $03, $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_KICK_HM
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchCL, $08, $00, $03, HITTYPE_HIT_MID1, $00 ; BANK $0A ; MOVE_SHARED_PUNCH_CL
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchCH, $10, $01, $03, HITTYPE_HIT_MID1, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_PUNCH_CH
	mMvAnDef OBJLstPtrTable_Nakoruru_KickCL, $08, $00, $06, HITTYPE_HIT_MID1, PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CL
	mMvAnDef OBJLstPtrTable_Nakoruru_KickCH, $08, $02, $06, HITTYPE_SWEEP, PF3_HEAVYHIT|PF3_HITLOW ; BANK $0A ; MOVE_SHARED_KICK_CH
	mMvAnDef OBJLstPtrTable_Nakoruru_DodgeCounter, $0C, $03, $07, HITTYPE_HIT_MID0, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_DODGE_COUNTER
	mMvAnDef OBJLstPtrTable_Nakoruru_Strike, $08, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_SHARED_STRIKE
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_FH
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FH
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_FCH
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALI
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHI
	mMvAnDef OBJLstPtrTable_Nakoruru_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALI
	mMvAnDef OBJLstPtrTable_Nakoruru_KickAHI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHI
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchALI, $10, $01, $05, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_ALX
	mMvAnDef OBJLstPtrTable_Nakoruru_PunchAHX, $10, $01, $05, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_PUNCH_AHX
	mMvAnDef OBJLstPtrTable_Nakoruru_KickALI, $10, $01, $09, HITTYPE_HIT_MID0, PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_ALX
	mMvAnDef OBJLstPtrTable_Nakoruru_KickAHX, $10, $01, $09, HITTYPE_HIT_MID0, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_KICK_AHX
	mMvAnDef OBJLstPtrTable_Nakoruru_KickAHI, $10, $01, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_OVERHEAD ; BANK $0A ; MOVE_SHARED_ATTACK_A
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_PUNCH_AHD
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHD
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $08, $06, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ;X ; BANK $0A ; MOVE_SHARED_KICK_AHB
	mMvAnDef OBJLstPtrTable_Nakoruru_AmubeYatoro, $0C, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_NAKORURU_AMUBE_YATORO_L
	mMvAnDef OBJLstPtrTable_Nakoruru_AmubeYatoro, $0C, $03, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT ; BANK $0A ; MOVE_NAKORURU_AMUBE_YATORO_H
	mMvAnDef OBJLstPtrTable_Nakoruru_AnnuMutsube, $18, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_HALFSPEED|PF3_SUPERALT ; BANK $0A ; MOVE_NAKORURU_ANNU_MUTSUBE_L
	mMvAnDef OBJLstPtrTable_Nakoruru_AnnuMutsube, $18, $01, $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_HALFSPEED|PF3_SUPERALT ; BANK $0A ; MOVE_NAKORURU_ANNU_MUTSUBE_H
	mMvAnDef OBJLstPtrTable_Nakoruru_KamuiRimse, $0C, $01, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_KAMUI_RIMSE_L
	mMvAnDef OBJLstPtrTable_Nakoruru_KamuiRimse, $18, $01, $04, HITTYPE_HIT_MID1, PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_KAMUI_RIMSE_H
	mMvAnDef OBJLstPtrTable_Nakoruru_LelaMutsube, $1C, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_HALFSPEED|PF3_SUPERALT ; BANK $0A ; MOVE_NAKORURU_LELA_MUTSUBE_L
	mMvAnDef OBJLstPtrTable_Nakoruru_LelaMutsube, $1C, $02, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_CONTHIT|PF3_HALFSPEED|PF3_SUPERALT ; BANK $0A ; MOVE_NAKORURU_LELA_MUTSUBE_H
	mMvAnDef OBJLstPtrTable_Nakoruru_MamahahaFlight, $10, $01, $00, $00, $00 ; BANK $0A ; MOVE_NAKORURU_MAMAHAHA_FLIGHT_L
	mMvAnDef OBJLstPtrTable_Nakoruru_MamahahaFlight, $10, $01, $00, $00, $00 ; BANK $0A ; MOVE_NAKORURU_MAMAHAHA_FLIGHT_H
	mMvAnDef OBJLstPtrTable_Nakoruru_YatoroPokku, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_YATORO_POKKU_L
	mMvAnDef OBJLstPtrTable_Nakoruru_YatoroPokku, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_YATORO_POKKU_H
	mMvAnDef OBJLstPtrTable_Nakoruru_KamuiMutsube, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_KAMUI_MUTSUBE_L
	mMvAnDef OBJLstPtrTable_Nakoruru_KamuiMutsube, $14, $01, $09, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_KAMUI_MUTSUBE_H
	mMvAnDef OBJLstPtrTable_Nakoruru_ElerushKamuiRimse, $5C, $01, $14, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_FIRE|PF3_CONTHIT ; BANK $0A ; MOVE_NAKORURU_ELERUSH_KAMUI_RIMSE_S
	mMvAnDef OBJLstPtrTable_Nakoruru_ThrowG, $04, $0A, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_THROW_G
	mMvAnDef OBJLstPtrTable_Nakoruru_Idle, $00, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_THROW_A
	mMvAnDef OBJLstPtrTable_Nakoruru_BlockG, $00, $05, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_POST_BLOCKSTUN
	mMvAnDef OBJLstPtrTable_Nakoruru_Hit0Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT0MID
	mMvAnDef OBJLstPtrTable_Nakoruru_Hit1Mid, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT1MID
	mMvAnDef OBJLstPtrTable_Nakoruru_HitLow, $00, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HITLOW
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchUB, $10, $05, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchSwoopup, $18, $00, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvAnDef OBJLstPtrTable_Nakoruru_HitSweep, $08, $02, $00, $00, $00 ;X ; BANK $0A ; MOVE_SHARED_HIT_SWEEP
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchUBRec, $18, $02, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_REC
	mMvAnDef OBJLstPtrTable_Nakoruru_Hit0Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID0
	mMvAnDef OBJLstPtrTable_Nakoruru_Hit1Mid, $00, $14, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_HIT_MULTIMID1
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchDBShake, $0C, $FF, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvAnDef OBJLstPtrTable_Nakoruru_GrabUBNoSync, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvAnDef OBJLstPtrTable_Nakoruru_LaunchDBShake, $00, $3C, $00, $00, $00 ; BANK $0A ; MOVE_SHARED_GRAB_UB_SYNC

GFX_Char_Ralf_BakudanPunchL3: INCBIN "data/gfx/char/ralf_bakudanpunchl3.bin"
GFX_Char_Ralf_BakudanPunchL4: INCBIN "data/gfx/char/ralf_bakudanpunchl4.bin"
GFX_Char_Ralf_VulcanPunchL0_A: INCBIN "data/gfx/char/ralf_vulcanpunchl0_a.bin"
GFX_Char_Ralf_GatlingAttackL4_B: INCBIN "data/gfx/char/ralf_gatlingattackl4_b.bin"
GFX_Char_Ralf_BaribariVulcanPunchS10: INCBIN "data/gfx/char/ralf_baribarivulcanpunchs10.bin"
GFX_Char_Ralf_GatlingAttackL5_A: INCBIN "data/gfx/char/ralf_gatlingattackl5_a.bin"
GFX_Char_Ralf_BaribariVulcanPunchS11_B: INCBIN "data/gfx/char/ralf_baribarivulcanpunchs11_b.bin"
GFX_Char_Ralf_GatlingAttackL5_B: INCBIN "data/gfx/char/ralf_gatlingattackl5_b.bin"
GFX_Char_Nakoruru_Unused_Intro4_A: INCBIN "data/gfx/char/nakoruru_unused_intro4_a.bin"
GFX_Char_Nakoruru_Unused_Intro4_B: INCBIN "data/gfx/char/nakoruru_unused_intro4_b.bin"
GFX_Char_Nakoruru_Unused_Intro5_B: INCBIN "data/gfx/char/nakoruru_unused_intro5_b.bin"

; =============== MoveC_Joe_ThrowG ===============
; Move code for these ground throws: (MOVE_SHARED_THROW_G).
; - Joe
; - Rugal
MoveC_Joe_ThrowG:
	mMvC_ValLoaded .ret
	mMvC_StartChkFrame
	mMvC_ChkFrame $00, .setDamageStart
	mMvC_ChkFrame $01, .setDamage1
	mMvC_ChkFrame $03, .setDamage1
	mMvC_ChkFrame $05, .setDamage1
	mMvC_ChkFrame $07, .setDamage1
	mMvC_ChkFrame $09, .setDamage1
	mMvC_ChkFrame $0B, .setDamage1
	mMvC_ChkFrame $0D, .setDamageEnd
	mMvC_ChkFrame $0E, .chkEnd

	jp   .setDamage0
; --------------- initial damage frame ---------------
.setDamageStart:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $03
		mMvC_SetDamageNext $02, HITTYPE_HIT_MULTI0, $00
		jp   .anim
; --------------- odd frames #1,3,5,7,9,B ---------------
.setDamage1:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $02, HITTYPE_HIT_MULTI1, $00
		jp   .anim
; --------------- even frames #2,4,6,8,A ---------------
.setDamage0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $02, HITTYPE_HIT_MULTI0, PF3_HEAVYHIT
		jp   .anim
; --------------- last damage frame, with knockdown ---------------
.setDamageEnd:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $04, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #E ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		;
		; Joe jumps far back when the throw ends, while Rugal doesn't.
		;
		mMvIn_ValSkipWithChar CHAR_ID_RUGAL, .rugalEnd
	.joeNext:
		; Switch to backjump
		ld   a, MOVE_SHARED_LAUNCH_UB_REC
		call Pl_SetMove_StopSpeed
		; Set backjump speed
		mMvC_SetSpeedH -$0280
		mMvC_SetSpeedV -$0500
		; End the throw
		xor  a
		ld   [wPlayPlThrowActId], a
		jr   .ret
	.rugalEnd:
		; End the throw
		xor  a
		ld   [wPlayPlThrowActId], a
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Joe_KickFCH ===============
; Move code for Joe's Forward Crouching Heavy Kick (MOVE_SHARED_KICK_FCH).
; This is a slide.
MoveC_Joe_KickFCH:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
; Set slide speed.
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_SetSpeedH +$0400
		jp   .anim
.obj1_cont:
	; Slow down at 0.25px/frame
	mMvC_ChkFrictionH $0040, .anim
		; Re-enable animations
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed $1E
		jp   .anim
; --------------- frame #2 ---------------
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
	
; =============== MoveC_Joe_KickLN ===============
; Move code for Joe's Near Light Kick (MOVE_SHARED_KICK_LN)
MoveC_Joe_KickLN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
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
	
; =============== MoveInputReader_Joe ===============
; Special move input checker for JOE.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Joe:
	mMvIn_Validate Joe, 0

.chkGround:
	;             SELECT + B               SELECT + A
	mMvIn_ChkEasy MoveInit_Joe_ScrewUpper, MoveInit_Joe_TigerKick
	mMvIn_ChkGA Joe, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	mMvIn_ValProjActive .chkPunchNoSuper
	mMvIn_ValSuper .chkPunchNoSuper
	; FBDF+P -> Screw Upper
	mMvIn_ChkDir MoveInput_FBDF, MoveInit_Joe_ScrewUpper
.chkPunchNoSuper:
	mMvIn_ValProjActive .chkPunchNoProj
	; BDF+P -> Hurricane Upper
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Joe_HurricaneUpper
.chkPunchNoProj:
	; PPP -> Bakuretsuken 
	mMvIn_ChkBtnStrict MoveInput_PPP, MoveInit_Joe_Bakuretsuken
	; End
	jp   MoveInputReader_Joe_NoMove
.chkKick:
	; BF+K -> Slash Kick
	mMvIn_ChkDir MoveInput_BF, MoveInit_Joe_SlashKick
	; DF+K -> Tiger Kick
	mMvIn_ChkDir MoveInput_DF, MoveInit_Joe_TigerKick
	; DB+K -> Ougon no Kakato
	mMvIn_ChkDir MoveInput_DB, MoveInit_Joe_OugonNoKakato
	; End	
	jp   MoveInputReader_Joe_NoMove
	
; =============== MoveInit_Joe_HurricaneUpper ===============
MoveInit_Joe_HurricaneUpper:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_JOE_HURRICANE_UPPER_L, MOVE_JOE_HURRICANE_UPPER_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInit_Joe_SlashKick ===============
MoveInit_Joe_SlashKick:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_JOE_SLASH_KICK_L, MOVE_JOE_SLASH_KICK_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInit_Joe_Bakuretsuken ===============
MoveInit_Joe_Bakuretsuken:
	call Play_Pl_ClearJoyBtnBuffer
	mMvIn_GetLHP MOVE_JOE_BAKURETSUKEN_L, MOVE_JOE_BAKURETSUKEN_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInit_Joe_TigerKick ===============
MoveInit_Joe_TigerKick:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_JOE_TIGER_KICK_L, MOVE_JOE_TIGER_KICK_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	set  PF1B_INVULN, [hl]
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInit_Joe_OugonNoKakato ===============
MoveInit_Joe_OugonNoKakato:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_JOE_OUGON_NO_KAKATO_L, MOVE_JOE_OUGON_NO_KAKATO_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInit_Joe_ScrewUpper ===============
MoveInit_Joe_ScrewUpper:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_JOE_SCREW_UPPER_S
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Joe_MoveSet
	
; =============== MoveInputReader_Joe_MoveSet ===============
MoveInputReader_Joe_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Joe_NoMove ===============
MoveInputReader_Joe_NoMove:
	or   a
	ret
	
; =============== MoveC_Joe_HurricaneUpper ===============
; Move code for Joe's:
; - Hurricane Upper (MOVE_JOE_HURRICANE_UPPER_L, MOVE_JOE_HURRICANE_UPPER_H)
; - Screw Upper (MOVE_JOE_SCREW_UPPER_S)
; See also: MoveC_Terry_PowerWave
MoveC_Joe_HurricaneUpper:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .chkEnd
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
	
		;
		; Update the animation speed and spawn the proper projectile.
		;
		
		; Doing the super?
		mMvC_ChkMove MOVE_JOE_SCREW_UPPER_S, .obj1_super
		
	.obj1_pw:
		; Spawn the projectile
		call ProjInit_Joe_HurricaneUpper
		
		; Determine anim speed
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = iPlInfo_MoveId
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; HL = Ptr to iOBJInfo_FrameTotal
		cp   MOVE_JOE_HURRICANE_UPPER_H	; Doing the heavy version?
		jp   z, .obj1_setSpeedH			; If so, jump
	.obj1_setSpeedL:
		ld   [hl], $0A	; iOBJInfo_FrameTotal for light
		jp   .anim
	.obj1_setSpeedH:
		ld   [hl], $14	; iOBJInfo_FrameTotal for heavy
		jp   .anim
		
	.obj1_super:
		; Spawn projectile
		call ProjInit_Joe_ScrewUpper
		; Update anim speed for uppercut frame
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de
		ld   [hl], $5A
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

; =============== MoveC_Joe_SlashKick ===============
; Move code for Joe's Slash Kick (MOVE_JOE_SLASH_KICK_L, MOVE_JOE_SLASH_KICK_H)
; See also: MoveC_Terry_BurnKnuckle
MoveC_Joe_SlashKick:	
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
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStart .obj2_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		mMvC_SetMoveH +$0800
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jump speed
		mMvC_ChkMove MOVE_JOE_SLASH_KICK_H, .obj2_setJumpH
	.obj2_setJumpL: ; Light
		mMvC_SetSpeedH +$0500
		mMvC_SetSpeedV -$0300
		jp   .obj2_doGravity
	.obj2_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj2_setJumpE
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0380
		jp   .obj2_doGravity
	.obj2_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV -$0400
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	jp   .doGravity
; --------------- frame #3 ---------------
.obj3:
	jp   .doGravity
; --------------- frame #4 ---------------
.obj4:
	; Loop to #3 (until we touch the ground)
	mMvC_ValFrameEnd .doGravity
		ld   hl, iOBJInfo_OBJLstPtrTblOffset
		add  hl, de
		ld   [hl], ($03-1)*OBJLSTPTR_ENTRYSIZE ; offset by -1
		jp   .doGravity
; --------------- frames #2-4 / common gravity check ---------------		
.doGravity:
	; Switch to #5 when we touch the ground
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
	
; =============== MoveC_Joe_Bakuretsuken ===============
; Move code for Joe's Bakuretsuken (MOVE_JOE_BAKURETSUKEN_L, MOVE_JOE_BAKURETSUKEN_H)
; PPP move that can transition into Bakuretsuken Finish.
MoveC_Joe_Bakuretsuken:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		;-
		; Bakuretsuken
		mMvC_ChkFrame $00, .setDamageStart
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .setDamage0
		mMvC_ChkFrame $03, .obj1
		mMvC_ChkFrame $04, .setDamage1
		mMvC_ChkFrame $05, .obj1
		
		mMvC_ChkFrame $06, .setDamageStart
		mMvC_ChkFrame $07, .obj1
		mMvC_ChkFrame $08, .setDamage0
		mMvC_ChkFrame $09, .obj1
		mMvC_ChkFrame $0A, .setDamage1
		mMvC_ChkFrame $0B, .obj1
		
		mMvC_ChkFrame $0C, .setDamageStart
		mMvC_ChkFrame $0D, .obj1
		mMvC_ChkFrame $0E, .setDamage0
		mMvC_ChkFrame $0F, .obj1
		mMvC_ChkFrame $10, .setDamage1
		mMvC_ChkFrame $11, .obj1
		
		mMvC_ChkFrame $12, .chkLoop
		;--
		; Bakuretsuken Finish
		mMvC_ChkFrame $13, .finisher0
		mMvC_ChkFrame $14, .finisher1
		mMvC_ChkFrame $15, .chkEnd
	jp   .anim

; --------------- frame #0 + repeats ---------------
; Damage loop, 1st hit.
.setDamageStart:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MID0, $00
		; Initialize the loop marker, by default we don't loop.
		ld   hl, iPlInfo_Joe_Bakuretsuken_LoopFlag
		add  hl, bc
		ld   [hl], $00
		jp   .anim
; --------------- frame #2 + repeats ---------------
; Damage loop, 2nd hit.
.setDamage0:
	mMvC_ValFrameEnd .chkInputNext
		mMvC_SetDamageNext $01, HITTYPE_HIT_MID0, $00
		mMvC_PlaySound SFX_HEAVY
		jp   .chkInputNext
; --------------- frame #4 + repeats ---------------
; Damage loop, 3rd hit.
.setDamage1:
	mMvC_ValFrameEnd .chkInputNext
		mMvC_SetDamageNext $01, HITTYPE_HIT_MID1, $00
		mMvC_PlaySound SFX_HEAVY
		jp   .chkInputNext
; --------------- frame #4 + repeats ---------------
; Damage loop, check for input.
.obj1:
	mMvC_ValFrameEnd .anim
; --------------- common input check ---------------
.chkInputNext:
	; DF -> Bakuretsuken Finish
	mMvIn_ChkDir MoveInput_DF, .startFinisher		; Did the DF(+P) motion? If so, jump
	
	; This move continues indefinitely as long as we're still mashing punch.
	; PPP -> Continue punching
	mMvIn_ChkBtnStrictNot MoveInput_PPP, .anim		; Still mashing punch? If not, jump
	
	; Otherwise, enable the loop.
	; Note that .setDamageStart is called three times for each damage loop,
	; and each time it resets the loop flag.
	; This means the actual PPP input must be performed between #D-#12.
	call Play_Pl_ClearJoyBtnBuffer
	ld   hl, iPlInfo_Joe_Bakuretsuken_LoopFlag
	add  hl, bc
	ld   [hl], $01
	jp   .anim
.startFinisher:
	; Switch to the first frame of Bakuretsuken Finish 
	call Play_Pl_ClearJoyDirBuffer
	mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, $00
		mMvC_SetFrame $13, $06
		jp   .ret
; --------------- frame #12 ---------------
; Check if the damage loop should loop.
.chkLoop:
	mMvC_ValFrameEnd .chkInputNext
		; If the loop flag isn't set, end the move now
		ld   hl, iPlInfo_Joe_Bakuretsuken_LoopFlag
		add  hl, bc
		ld   a, [hl]
		cp   $00
		jp   z, .end
		; Otherwise, loop back to the start
		mMvC_SetFrame $00, ANIMSPEED_INSTANT
		jp   .ret
; --------------- frame #13 ---------------
; Bakuretsuken Finish, frame #0
.finisher0:
	mMvC_ValFrameStartFast .finisher0_cont
		mMvC_PlaySound SFX_SPECIAL
		; Determine forward dash speed
		mMvC_ChkMaxPow .setDashE
	.setDashNorm: ; Normal
		mMvC_SetSpeedH +$0500
		jp   .finisher0_anim
	.setDashE: ; Max Power
		mMvC_SetSpeedH +$0800
	.finisher0_anim:
		jp   .anim
.finisher0_cont:
	mMvC_DoFrictionH $0080
		mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		mMvC_SetDamageNext $0A, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #14 ---------------
; Bakuretsuken Finish, frame #1. Recovery.
.finisher1:
	mMvC_ValFrameStartFast .finisher1_cont
		mMvC_PlaySound SFX_SPECIAL
.finisher1_cont:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $10
		jp   .anim
; --------------- frame #15 ---------------
; Bakuretsuken Finish, frame #2. Recovery.
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
	
; =============== MoveC_Joe_TigerKick ===============
; Move code for Joe's Tiger Kick (MOVE_JOE_TIGER_KICK_L, MOVE_JOE_TIGER_KICK_H)
MoveC_Joe_TigerKick:
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
	mMvC_ChkFrame $06, .chkEnd
; --------------- frame #1 ---------------
; Startup.
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_INSTANT
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #2 ---------------
; Jump frame.
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
		; Set jump speed
		mMvC_ChkMove MOVE_JOE_TIGER_KICK_H, .obj2_setSpeedH
	.obj2_setSpeedL: ; Light
		mMvC_SetSpeedH +$0080
		mMvC_SetSpeedV -$0600
		jp   .obj2_doGravity
	.obj2_setSpeedH: ; Heavy
		mMvC_ChkMaxPow .obj2_setSpeedE
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0700
		jp   .obj2_doGravity
	.obj2_setSpeedE: ; Max Power Heavy 
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0800
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	; Set damage #1
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #3 ---------------
; Jump frame loop #0
.obj3:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #4 ---------------
; Jump frame loop #1
.obj4:
	; Switch to #5 at Y Speed > -$03
	mMvC_ValNextFrameOnGtYSpeed -$03, ANIMSPEED_NONE, .obj4_cont
		; Reset frame count
		ld   hl, iOBJInfo_FrameLeft
		add  hl, de
		ld   [hl], $00
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetFrameOnEnd $05
		jp   .doGravity
.obj4_cont:
	; Loop back to #3 at the end.
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
		mMvC_SetFrameOnEnd $03
		jp   .doGravity
; --------------- frame #5 ---------------
; Jump peak
.obj5:
	mMvC_SetSpeedH $0040
; --------------- frame #2-5 / common gravity check ---------------
.doGravity:
	; Switch to #6 when landing
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
	
; =============== MoveC_Joe_OugonNoKakato ===============
; Move code for Joe's Ougon no Kakato (MOVE_JOE_OUGON_NO_KAKATO_L, MOVE_JOE_OUGON_NO_KAKATO_H)
; See also: MoveC_Terry_CrackShot
MoveC_Joe_OugonNoKakato:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .anim
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .doGravity
		mMvC_ChkFrame $04, .anim
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
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
		mMvC_ChkMove MOVE_JOE_OUGON_NO_KAKATO_H, .obj2_setSpeedH
	.obj2_setSpeedL: ; Light
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0500
		jp   .obj2_doGravity
	.obj2_setSpeedH: ; Heavy
		mMvC_ChkMaxPow .obj2_setSpeedE
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0480
		jp   .obj2_doGravity
	.obj2_setSpeedE: ; Max Power Heavy 
		mMvC_SetSpeedH +$0600
		mMvC_SetSpeedV -$0400
	.obj2_doGravity:
		jp   .doGravity
.obj2_cont:
	mMvC_ValNextFrameOnGtYSpeed -$02, ANIMSPEED_NONE, .doGravity
		; Set next damage
		mMvC_ChkMove MOVE_JOE_OUGON_NO_KAKATO_H, .obj2_setDamageH
	.obj2_setDamageL: ; Light
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageH: ; Heavy
		mMvC_ChkMaxPow .obj2_setDamageE
		mMvC_SetDamageNext $08, HITTYPE_HIT_MID1, PF3_HEAVYHIT
		jp   .doGravity
	.obj2_setDamageE: ; Max Power Heavy 
		mMvC_SetDamageNext $08, HITTYPE_LAUNCH_FAST_DB, PF3_HEAVYHIT
		jp   .doGravity
; --------------- frame #2-4 / common gravity check ---------------
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
	

; =============== ProjInit_Joe_HurricaneUpper ===============
; Initializes the projectile for Joe's Hurricane Upper (MOVE_JOE_HURRICANE_UPPER_L, MOVE_JOE_HURRICANE_UPPER_H)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Joe_HurricaneUpper:
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
				ld   [hl], BANK(OBJLstPtrTable_Proj_Joe_HurricaneUpper)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Joe_HurricaneUpper)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Joe_HurricaneUpper)	; iOBJInfo_OBJLstPtrTbl_High
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
			cp   MOVE_JOE_HURRICANE_UPPER_H	; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_JOE_HURRICANE_UPPER_H	; Was this an heavy attack?
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
	
; =============== ProjInit_Joe_ScrewUpper ===============
; Initializes the projectile for Joe's Screw Upper (MOVE_JOE_SCREW_UPPER_S)
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
ProjInit_Joe_ScrewUpper:
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
				ld   [hl], BANK(ProjC_Joe_ScrewUppper)	; BANK $05 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Joe_ScrewUppper)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Joe_ScrewUppper)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Joe_ScrewUpper)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Joe_ScrewUpper)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Joe_ScrewUpper)	; iOBJInfo_OBJLstPtrTbl_High
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
				
				; Display for 1 second
				inc  hl ; Seek to iOBJInfo_Play_EnaTimer
				ld   [hl], 60
				
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

			mMvC_SetSpeedH $0080
		pop  de
	pop  bc
	ret
	
; =============== ProjC_Joe_ScrewUppper ===============
; Projectile code for Joe's Screw Upper.
; A whirlwind as tall as the playfield, which despawn after the specified time limit. 
; This does not disappear on hit.
ProjC_Joe_ScrewUppper:

	; Handle the despawn timer
	ld   hl, iOBJInfo_Play_EnaTimer
	add  hl, de
	dec  [hl]			; DespawnTimer--
	jp   z, .despawn	; Did it reach 0? If so, jump
	
	call ExOBJS_Play_ChkHitModeAndMoveH
	call OBJLstS_DoAnimTiming_Loop_by_DE
	ret
.despawn:
	call OBJLstS_Hide
	ret
	
; =============== END OF BANK ===============
; Junk area below.
	mIncJunk "L057D53"