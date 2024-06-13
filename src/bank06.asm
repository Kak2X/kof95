; =============== MoveCodePtrTbl_* ===============
; Code pointers assigned to every move.
; These follow the groups mentioned in Play_DoPl.execMoveCode.
MoveCodePtrTbl_Marker:

MACRO mMvCodeDef
	IF _NARG > 1 ; For those that define an improper bank number
		dw \1
		db \2
	ELSE
		dpr \1
	ENDC
	
	db $00 ; Padding
ENDM

MoveCodePtrTbl_Kyo:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Kyo_Strike ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Kyo_KickFH ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Kyo_KickFCH ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Kyo_YamiBarai ; BANK $02 ; MOVE_KYO_YAMI_BARAI_L
	mMvCodeDef MoveC_Kyo_YamiBarai ; BANK $02 ; MOVE_KYO_YAMI_BARAI_H
	mMvCodeDef MoveC_Kyo_OniYaki ; BANK $02 ; MOVE_KYO_ONI_YAKI_L
	mMvCodeDef MoveC_Kyo_OniYaki ; BANK $02 ; MOVE_KYO_ONI_YAKI_H
	mMvCodeDef MoveC_Kyo_OboroGuruma ; BANK $02 ; MOVE_KYO_OBORO_GURUMA_L
	mMvCodeDef MoveC_Kyo_OboroGuruma ; BANK $02 ; MOVE_KYO_OBORO_GURUMA_H
	mMvCodeDef MoveC_Kyo_KototsukiYou ; BANK $02 ; MOVE_KYO_KOTOTSUKI_YOU_L
	mMvCodeDef MoveC_Kyo_KototsukiYou ; BANK $02 ; MOVE_KYO_KOTOTSUKI_YOU_H
	mMvCodeDef MoveC_Kyo_Kai ; BANK $02 ; MOVE_KYO_KAI_L
	mMvCodeDef MoveC_Kyo_Kai ; BANK $02 ; MOVE_KYO_KAI_H
	mMvCodeDef MoveC_Kyo_YamiBarai ;X ; BANK $02 ; MOVE_KYO_78
	mMvCodeDef MoveC_Kyo_YamiBarai ;X ; BANK $02 ; MOVE_KYO_7A
	mMvCodeDef MoveC_Kyo_YamiBarai ;X ; BANK $02 ; MOVE_KYO_7C
	mMvCodeDef MoveC_Kyo_YamiBarai ;X ; BANK $02 ; MOVE_KYO_7E
	mMvCodeDef MoveC_Kyo_UraOrochiNagi ; BANK $02 ; MOVE_KYO_URA_OROCHI_NAGI_S
	mMvCodeDef MoveC_Kyo_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Benimaru:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Benimaru_KickAHD ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Benimaru_Raijinken ; BANK $02 ; MOVE_BENIMARU_RAIJINKEN_L
	mMvCodeDef MoveC_Benimaru_Raijinken ; BANK $02 ; MOVE_BENIMARU_RAIJINKEN_H
	mMvCodeDef MoveC_Benimaru_ShinkuuKatateGoma ; BANK $02 ; MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L
	mMvCodeDef MoveC_Benimaru_ShinkuuKatateGoma ; BANK $02 ; MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H
	mMvCodeDef MoveC_Benimaru_IaiGeri ; BANK $02 ; MOVE_BENIMARU_IAI_GERI_L
	mMvCodeDef MoveC_Benimaru_IaiGeri ; BANK $02 ; MOVE_BENIMARU_IAI_GERI_H
	mMvCodeDef MoveC_Benimaru_SuperInazumaKick ; BANK $02 ; MOVE_BENIMARU_SUPER_INAZUMA_KICK_L
	mMvCodeDef MoveC_Benimaru_SuperInazumaKick ; BANK $02 ; MOVE_BENIMARU_SUPER_INAZUMA_KICK_H
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_76
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_78
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_7A
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_7C
	mMvCodeDef MoveC_Benimaru_Raijinken ;X ; BANK $02 ; MOVE_BENIMARU_7E
	mMvCodeDef MoveC_Benimaru_Raikouken ; BANK $02 ; MOVE_BENIMARU_RAIKOUKEN_S
	mMvCodeDef MoveC_Benimaru_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_ThrowA_DirD ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Ryo:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Ryo_PunchFH ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Ryo_KoOuKenG ; BANK $02 ; MOVE_RYO_KO_OU_KEN_GL
	mMvCodeDef MoveC_Ryo_KoOuKenG ; BANK $02 ; MOVE_RYO_KO_OU_KEN_GH
	mMvCodeDef MoveC_Ryo_HienShippuuKyaku ; BANK $02 ; MOVE_RYO_HIEN_SHIPPUU_KYAKU_L
	mMvCodeDef MoveC_Ryo_HienShippuuKyaku ; BANK $02 ; MOVE_RYO_HIEN_SHIPPUU_KYAKU_H
	mMvCodeDef MoveC_Ryo_Zenretsuken ; BANK $02 ; MOVE_RYO_ZENRETSUKEN_L
	mMvCodeDef MoveC_Ryo_Zenretsuken ; BANK $02 ; MOVE_RYO_ZENRETSUKEN_H
	mMvCodeDef MoveC_Ryo_KoHou ; BANK $02 ; MOVE_RYO_KO_HOU_L
	mMvCodeDef MoveC_Ryo_KoHou ; BANK $02 ; MOVE_RYO_KO_HOU_H
	mMvCodeDef MoveC_Ryo_KoOuKenA ; BANK $02 ; MOVE_RYO_KO_OU_KEN_AL
	mMvCodeDef MoveC_Ryo_KoOuKenA ;X ; BANK $02 ; MOVE_RYO_KO_OU_KEN_AH
	mMvCodeDef MoveC_Ryo_HaohShoukouKen ; BANK $02 ; MOVE_RYO_HAOH_SHOKOU_KEN_L
	mMvCodeDef MoveC_Ryo_HaohShoukouKen ; BANK $02 ; MOVE_RYO_HAOH_SHOKOU_KEN_H
	mMvCodeDef MoveC_Ryo_KyokukenRyuRenbuKen ;X ; BANK $02 ; MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_L
	mMvCodeDef MoveC_Ryo_KyokukenRyuRenbuKen ; BANK $02 ; MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_H
	mMvCodeDef MoveC_Ryo_RyuKoRanbuS ; BANK $02 ; MOVE_RYO_RYU_KO_RANBU_S
	mMvCodeDef MoveC_Ryo_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Yuri:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Yuri_KickFH ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Yuri_KoOuKen ; BANK $02 ; MOVE_YURI_KO_OU_KEN_L
	mMvCodeDef MoveC_Yuri_KoOuKen ; BANK $02 ; MOVE_YURI_KO_OU_KEN_H
	mMvCodeDef MoveC_Yuri_SaiHa ; BANK $02 ; MOVE_YURI_SAI_HA_L
	mMvCodeDef MoveC_Yuri_SaiHa ; BANK $02 ; MOVE_YURI_SAI_HA_H
	mMvCodeDef MoveC_Yuri_HyakuRetsuBintaL ; BANK $02 ; MOVE_YURI_HYAKU_RETSU_BINTA_L
	mMvCodeDef MoveC_Yuri_HyakuRetsuBintaH ; BANK $02 ; MOVE_YURI_HYAKU_RETSU_BINTA_H
	mMvCodeDef MoveC_Yuri_KuuGaL ; BANK $02 ; MOVE_YURI_KUU_GA_L
	mMvCodeDef MoveC_Yuri_KuuGaH ; BANK $02 ; MOVE_YURI_KUU_GA_H
	mMvCodeDef MoveC_Yuri_RaiOhKen ; BANK $02 ; MOVE_YURI_RAI_OH_KEN_L
	mMvCodeDef MoveC_Yuri_RaiOhKen ; BANK $02 ; MOVE_YURI_RAI_OH_KEN_H
	mMvCodeDef MoveC_Yuri_HaohShoukouKen ; BANK $02 ; MOVE_YURI_HAOH_SHOUKOU_KEN_L
	mMvCodeDef MoveC_Yuri_HaohShoukouKen ; BANK $02 ; MOVE_YURI_HAOH_SHOUKOU_KEN_H
	mMvCodeDef MoveC_Yuri_KoOuKen ;X ; BANK $02 ; MOVE_YURI_7C
	mMvCodeDef MoveC_Yuri_KoOuKen ;X ; BANK $02 ; MOVE_YURI_7E
	mMvCodeDef MoveC_Yuri_HienHouOuKyaKu ; BANK $02 ; MOVE_YURI_HIEN_HOU_OU_KYA_KU_S
	mMvCodeDef MoveC_Yuri_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_ThrowA_DirD ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Terry:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Terry_PunchHN ; BANK $03 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Terry_PunchFH ; BANK $03 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Terry_PowerWave ; BANK $03 ; MOVE_TERRY_POWER_WAVE_L
	mMvCodeDef MoveC_Terry_PowerWave ; BANK $03 ; MOVE_TERRY_POWER_WAVE_H
	mMvCodeDef MoveC_Terry_BurnKnuckle ; BANK $03 ; MOVE_TERRY_BURN_KNUCKLE_L
	mMvCodeDef MoveC_Terry_BurnKnuckle ; BANK $03 ; MOVE_TERRY_BURN_KNUCKLE_H
	mMvCodeDef MoveC_Terry_CrackShot ; BANK $03 ; MOVE_TERRY_CRACK_SHOT_L
	mMvCodeDef MoveC_Terry_CrackShot ; BANK $03 ; MOVE_TERRY_CRACK_SHOT_H
	mMvCodeDef MoveC_Terry_RisingTackle ; BANK $03 ; MOVE_TERRY_RISING_TACKLE_L
	mMvCodeDef MoveC_Terry_RisingTackle ; BANK $03 ; MOVE_TERRY_RISING_TACKLE_H
	mMvCodeDef MoveC_Terry_PowerDunk ; BANK $03 ; MOVE_TERRY_POWER_DUNK_L
	mMvCodeDef MoveC_Terry_PowerDunk ; BANK $03 ; MOVE_TERRY_POWER_DUNK_H
	mMvCodeDef MoveC_Terry_PowerWave ;X ; BANK $03 ; MOVE_TERRY_78
	mMvCodeDef MoveC_Terry_PowerWave ;X ; BANK $03 ; MOVE_TERRY_7A
	mMvCodeDef MoveC_Terry_PowerWave ;X ; BANK $03 ; MOVE_TERRY_7C
	mMvCodeDef MoveC_Terry_PowerWave ;X ; BANK $03 ; MOVE_TERRY_7E
	mMvCodeDef MoveC_Terry_PowerWave ; BANK $03 ; MOVE_TERRY_POWER_GEYSER_S
	mMvCodeDef MoveC_Terry_ThrowG ; BANK $03 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ;X ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Joe:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Joe_KickLN ; BANK $05 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Joe_KickFCH ; BANK $05 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Joe_HurricaneUpper ; BANK $05 ; MOVE_JOE_HURRICANE_UPPER_L
	mMvCodeDef MoveC_Joe_HurricaneUpper ; BANK $05 ; MOVE_JOE_HURRICANE_UPPER_H
	mMvCodeDef MoveC_Joe_SlashKick ; BANK $05 ; MOVE_JOE_SLASH_KICK_L
	mMvCodeDef MoveC_Joe_SlashKick ; BANK $05 ; MOVE_JOE_SLASH_KICK_H
	mMvCodeDef MoveC_Joe_Bakuretsuken ; BANK $05 ; MOVE_JOE_BAKURETSUKEN_L
	mMvCodeDef MoveC_Joe_Bakuretsuken ; BANK $05 ; MOVE_JOE_BAKURETSUKEN_H
	mMvCodeDef MoveC_Joe_TigerKick ; BANK $05 ; MOVE_JOE_TIGER_KICK_L
	mMvCodeDef MoveC_Joe_TigerKick ; BANK $05 ; MOVE_JOE_TIGER_KICK_H
	mMvCodeDef MoveC_Joe_OugonNoKakato ; BANK $05 ; MOVE_JOE_OUGON_NO_KAKATO_L
	mMvCodeDef MoveC_Joe_OugonNoKakato ; BANK $05 ; MOVE_JOE_OUGON_NO_KAKATO_H
	mMvCodeDef MoveC_Joe_HurricaneUpper ;X ; BANK $05 ; MOVE_JOE_78
	mMvCodeDef MoveC_Joe_HurricaneUpper ;X ; BANK $05 ; MOVE_JOE_7A
	mMvCodeDef MoveC_Joe_HurricaneUpper ;X ; BANK $05 ; MOVE_JOE_7C
	mMvCodeDef MoveC_Joe_HurricaneUpper ;X ; BANK $05 ; MOVE_JOE_7E
	mMvCodeDef MoveC_Joe_HurricaneUpper ; BANK $05 ; MOVE_JOE_SCREW_UPPER_S
	mMvCodeDef MoveC_Joe_ThrowG ; BANK $05 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Heidern:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Heidern_PunchHN ; BANK $18 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Heidern_PunchHN ; BANK $18 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Heidern_CrossCutter ; BANK $18 ; MOVE_HEIDERN_CROSS_CUTTER_L
	mMvCodeDef MoveC_Heidern_CrossCutter ; BANK $18 ; MOVE_HEIDERN_CROSS_CUTTER_H
	mMvCodeDef MoveC_Heidern_NeckRoller ; BANK $18 ; MOVE_HEIDERN_NECK_ROLLER_L
	mMvCodeDef MoveC_Heidern_NeckRoller ; BANK $18 ; MOVE_HEIDERN_NECK_ROLLER_H
	mMvCodeDef MoveC_Heidern_StormBringer ; BANK $18 ; MOVE_HEIDERN_STORM_BRINGER_L
	mMvCodeDef MoveC_Heidern_StormBringer ; BANK $18 ; MOVE_HEIDERN_STORM_BRINGER_H
	mMvCodeDef MoveC_Heidern_MoonSlasher ; BANK $18 ; MOVE_HEIDERN_MOON_SLASHER_L
	mMvCodeDef MoveC_Heidern_MoonSlasher ; BANK $18 ; MOVE_HEIDERN_MOON_SLASHER_H
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_74
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_76
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_78
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_7A
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_7C
	mMvCodeDef MoveC_Heidern_CrossCutter ;X ; BANK $18 ; MOVE_HEIDERN_7E
	mMvCodeDef MoveC_Heidern_NeckRoller ; BANK $18 ; MOVE_HEIDERN_FINAL_BRINGER_S
	mMvCodeDef MoveC_Heidern_ThrowG ; BANK $18 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Heidern_ThrowA ; BANK $18 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ;X ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Ralf:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Terry_PunchHN ; BANK $03 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Ralf_VulcanPunch ; BANK $19 ; MOVE_RALF_VULCAN_PUNCH_L
	mMvCodeDef MoveC_Ralf_VulcanPunch ; BANK $19 ; MOVE_RALF_VULCAN_PUNCH_H
	mMvCodeDef MoveC_Ralf_GatlingAttack ; BANK $19 ; MOVE_RALF_GATLING_ATTACK_L
	mMvCodeDef MoveC_Ralf_GatlingAttack ; BANK $19 ; MOVE_RALF_GATLING_ATTACK_H
	mMvCodeDef MoveC_Ralf_BackBreaker ; BANK $19 ; MOVE_RALF_BACK_BREAKER_L
	mMvCodeDef MoveC_Ralf_BackBreaker ; BANK $19 ; MOVE_RALF_BACK_BREAKER_H
	mMvCodeDef MoveC_Ralf_BakudanPunch ; BANK $19 ; MOVE_RALF_BAKUDAN_PUNCH_L
	mMvCodeDef MoveC_Ralf_BakudanPunch ; BANK $19 ; MOVE_RALF_BAKUDAN_PUNCH_H
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_74
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_76
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_78
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_7A
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_7C
	mMvCodeDef MoveC_Ralf_VulcanPunch ;X ; BANK $19 ; MOVE_RALF_7E
	mMvCodeDef MoveC_Ralf_BaribariVulcanPunch ; BANK $19 ; MOVE_RALF_BARIBARI_VULCAN_PUNCH_S
	mMvCodeDef MoveC_Ralf_ThrowG ; BANK $19 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Athena:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Athena_KickHN ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Athena_PhoenixBomb ;X ; BANK $18 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Athena_PsychoBall ; BANK $18 ; MOVE_ATHENA_PSYCHO_BALL_L
	mMvCodeDef MoveC_Athena_PsychoBall ; BANK $18 ; MOVE_ATHENA_PSYCHO_BALL_H
	mMvCodeDef MoveC_Athena_PsychoReflector ; BANK $18 ; MOVE_ATHENA_PSYCHO_REFLECTOR_L
	mMvCodeDef MoveC_Athena_PsychoReflector ; BANK $18 ; MOVE_ATHENA_PSYCHO_REFLECTOR_H
	mMvCodeDef MoveC_Athena_PsychoSword ; BANK $18 ; MOVE_ATHENA_PSYCHO_SWORD_L
	mMvCodeDef MoveC_Athena_PsychoSword ; BANK $18 ; MOVE_ATHENA_PSYCHO_SWORD_H
	mMvCodeDef MoveC_Athena_PhoenixArrow ; BANK $18 ; MOVE_ATHENA_PHOENIX_ARROW_L
	mMvCodeDef MoveC_Athena_PhoenixArrow ; BANK $18 ; MOVE_ATHENA_PHOENIX_ARROW_H
	mMvCodeDef MoveC_Athena_PhoenixArrowKick ;X ; BANK $18 ; MOVE_ATHENA_74
	mMvCodeDef MoveC_Athena_PhoenixArrowKick ; BANK $18 ; MOVE_ATHENA_PHOENIX_ARROW_KICK_H
	mMvCodeDef MoveC_Athena_PsychoBall ;X ; BANK $18 ; MOVE_ATHENA_78
	mMvCodeDef MoveC_Athena_PsychoBall ;X ; BANK $18 ; MOVE_ATHENA_7A
	mMvCodeDef MoveC_Athena_PsychoBall ;X ; BANK $18 ; MOVE_ATHENA_7C
	mMvCodeDef MoveC_Athena_PsychoBall ;X ; BANK $18 ; MOVE_ATHENA_7E
	mMvCodeDef MoveC_Athena_ShCryst ; BANK $18 ; MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS
	mMvCodeDef MoveC_Athena_ThrowG ; BANK $18 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Athena_ThrowA ; BANK $18 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Kensou:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Kensou_PunchFH ; BANK $18 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Kensou_KickFH ; BANK $18 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ; BANK $18 ; MOVE_KENSOU_CHOU_KYUU_DAN_L
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ; BANK $18 ; MOVE_KENSOU_CHOU_KYUU_DAN_H
	mMvCodeDef MoveC_Kensou_RyuuGakuSai ; BANK $18 ; MOVE_KENSOU_RYUU_GAKU_SAI_L
	mMvCodeDef MoveC_Kensou_RyuuGakuSai ; BANK $18 ; MOVE_KENSOU_RYUU_GAKU_SAI_H
	mMvCodeDef MoveC_Kensou_RyuuRenGa ; BANK $18 ; MOVE_KENSOU_RYUU_REN_GA_L
	mMvCodeDef MoveC_Kensou_RyuuRenGa ; BANK $18 ; MOVE_KENSOU_RYUU_REN_GA_H
	mMvCodeDef MoveC_Kensou_RyuuSouGeki ; BANK $18 ; MOVE_KENSOU_RYUU_SOU_GEKI_L
	mMvCodeDef MoveC_Kensou_RyuuSouGeki ; BANK $18 ; MOVE_KENSOU_RYUU_SOU_GEKI_H
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_74
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_76
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_78
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_7A
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_7C
	mMvCodeDef MoveC_Kensou_ChouKyuuDan ;X ; BANK $18 ; MOVE_KENSOU_7E
	mMvCodeDef MoveC_Kensou_ShinryuuTenbuKyaku ; BANK $18 ; MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S
	mMvCodeDef MoveC_Kensou_ThrowG ; BANK $18 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Kim:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Athena_KickHN ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Kim_KickHN ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Kim_KickHM ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Kim_HanGetsuZan ; BANK $02 ; MOVE_KIM_HAN_GETSU_ZAN_L
	mMvCodeDef MoveC_Kim_HanGetsuZan ; BANK $02 ; MOVE_KIM_HAN_GETSU_ZAN_H
	mMvCodeDef MoveC_Kim_HienZan ; BANK $02 ; MOVE_KIM_HIEN_ZAN_L
	mMvCodeDef MoveC_Kim_HienZan ; BANK $02 ; MOVE_KIM_HIEN_ZAN_H
	mMvCodeDef MoveC_Kim_HishouKyaku ; BANK $02 ; MOVE_KIM_HISHOU_KYAKU_L
	mMvCodeDef MoveC_Kim_HishouKyaku ; BANK $02 ; MOVE_KIM_HISHOU_KYAKU_H
	mMvCodeDef MoveC_Kim_RyuuseiRanku ; BANK $02 ; MOVE_KIM_RYUUSEI_RANKU_L
	mMvCodeDef MoveC_Kim_RyuuseiRanku ; BANK $02 ; MOVE_KIM_RYUUSEI_RANKU_H
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_74
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_76
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_78
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_7A
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_7C
	mMvCodeDef MoveC_Kim_HanGetsuZan ;X ; BANK $02 ; MOVE_KIM_7E
	mMvCodeDef MoveC_Kim_HouOuKyaku ; BANK $02 ; MOVE_KIM_HOU_OU_KYAKU_S
	mMvCodeDef MoveC_Kim_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Mai:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Mai_KaChoSen ; BANK $18 ; MOVE_MAI_KA_CHO_SEN_L
	mMvCodeDef MoveC_Mai_KaChoSen ; BANK $18 ; MOVE_MAI_KA_CHO_SEN_H
	mMvCodeDef MoveC_Mai_HissatsuShinobibachi ; BANK $18 ; MOVE_MAI_HISSATSU_SHINOBIBACHI_L
	mMvCodeDef MoveC_Mai_HissatsuShinobibachi ; BANK $18 ; MOVE_MAI_HISSATSU_SHINOBIBACHI_H
	mMvCodeDef MoveC_Mai_RyuEnBu ; BANK $18 ; MOVE_MAI_RYU_EN_BU_L
	mMvCodeDef MoveC_Mai_RyuEnBu ; BANK $18 ; MOVE_MAI_RYU_EN_BU_H
	mMvCodeDef MoveC_Mai_HishoRyuEnJin ; BANK $18 ; MOVE_MAI_HISHO_RYU_EN_JIN_L
	mMvCodeDef MoveC_Mai_HishoRyuEnJin ; BANK $18 ; MOVE_MAI_HISHO_RYU_EN_JIN_H
	mMvCodeDef MoveC_Mai_ChijouMusasabi ; BANK $18 ; MOVE_MAI_CHIJOU_MUSASABI_L
	mMvCodeDef MoveC_Mai_ChijouMusasabi ; BANK $18 ; MOVE_MAI_CHIJOU_MUSASABI_H
	mMvCodeDef MoveC_Mai_KuuchuuMusasabi ; BANK $18 ; MOVE_MAI_KUUCHUU_MUSASABI_L
	mMvCodeDef MoveC_Mai_KuuchuuMusasabi ; BANK $18 ; MOVE_MAI_KUUCHUU_MUSASABI_H
	mMvCodeDef MoveC_Mai_KaChoSen ;X ; BANK $18 ; MOVE_MAI_7C
	mMvCodeDef MoveC_Mai_KaChoSen ;X ; BANK $18 ; MOVE_MAI_7E
	mMvCodeDef MoveC_Mai_ChoHissatsuShinobibachi ; BANK $18 ; MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S
	mMvCodeDef MoveC_Mai_ThrowG ; BANK $18 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_ThrowA_DirD ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Iori:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Dash ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Joe_KickFCH ;X ; BANK $05 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Iori_PunchFH ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Iori_KickFH ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Iori_YamiBarai ; BANK $02 ; MOVE_IORI_YAMI_BARAI_L
	mMvCodeDef MoveC_Iori_YamiBarai ; BANK $02 ; MOVE_IORI_YAMI_BARAI_H
	mMvCodeDef MoveC_Iori_OniYaki ; BANK $02 ; MOVE_IORI_ONI_YAKI_L
	mMvCodeDef MoveC_Iori_OniYaki ; BANK $02 ; MOVE_IORI_ONI_YAKI_H
	mMvCodeDef MoveC_Iori_AoiHana ; BANK $02 ; MOVE_IORI_AOI_HANA_L
	mMvCodeDef MoveC_Iori_AoiHana ; BANK $02 ; MOVE_IORI_AOI_HANA_H
	mMvCodeDef MoveC_Iori_KotoTsukiIn ; BANK $02 ; MOVE_IORI_KOTO_TSUKI_IN_L
	mMvCodeDef MoveC_Iori_KotoTsukiIn ; BANK $02 ; MOVE_IORI_KOTO_TSUKI_IN_H
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_74
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_76
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_78
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_7A
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_7C
	mMvCodeDef MoveC_Iori_YamiBarai ;X ; BANK $02 ; MOVE_IORI_7E
	mMvCodeDef MoveC_Iori_KinYaOtome ; BANK $02 ; MOVE_IORI_KIN_YA_OTOME_S
	mMvCodeDef MoveC_Iori_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Eiji:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Eiji_KickHN ; BANK $1E ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Eiji_KickHM ; BANK $1E ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Eiji_Kikouhou ; BANK $1E ; MOVE_EIJI_KIKOUHOU_L
	mMvCodeDef MoveC_Eiji_Kikouhou ; BANK $1E ; MOVE_EIJI_KIKOUHOU_H
	mMvCodeDef MoveC_Eiji_KotsuHazakiKiri ; BANK $1E ; MOVE_EIJI_KOTSU_HAZAKI_KIRI_L
	mMvCodeDef MoveC_Eiji_KotsuHazakiKiri ; BANK $1E ; MOVE_EIJI_KOTSU_HAZAKI_KIRI_H
	mMvCodeDef MoveC_Eiji_RyuuEijin ; BANK $1E ; MOVE_EIJI_RYUU_EIJIN_L
	mMvCodeDef MoveC_Eiji_RyuuEijin ; BANK $1E ; MOVE_EIJI_RYUU_EIJIN_H
	mMvCodeDef MoveC_Eiji_Kikouhou ; BANK $1E ; MOVE_EIJI_KASUMI_GERI_L
	mMvCodeDef MoveC_Eiji_Kikouhou ; BANK $1E ; MOVE_EIJI_KASUMI_GERI_H
	mMvCodeDef MoveC_Eiji_Zantetsuha ; BANK $1E ; MOVE_EIJI_ZANTETSUHA_L
	mMvCodeDef MoveC_Eiji_Zantetsuha ; BANK $1E ; MOVE_EIJI_ZANTETSUHA_H
	mMvCodeDef MoveC_Eiji_KageUtsushi ; BANK $1E ; MOVE_EIJI_KAGE_UTSUSHI_L
	mMvCodeDef MoveC_Eiji_KageUtsushi ; BANK $1E ; MOVE_EIJI_KAGE_UTSUSHI_H
	mMvCodeDef MoveC_Eiji_KotsuHazakiKiri ; BANK $1E ; MOVE_EIJI_TENBAKYAKU_L
	mMvCodeDef MoveC_Eiji_KotsuHazakiKiri ; BANK $1E ; MOVE_EIJI_TENBAKYAKU_H
	mMvCodeDef MoveC_Eiji_ZantetsuTourouken ; BANK $1E ; MOVE_EIJI_ZANTETSU_TOUROUKEN_S
	mMvCodeDef MoveC_Eiji_ThrowG ; BANK $1E ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ;X ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Billy:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Billy_KickFH ; BANK $08 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ; BANK $08 ; MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ; BANK $08 ; MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H
	mMvCodeDef MoveC_Billy_SenpuuKon ; BANK $08 ; MOVE_BILLY_SENPUU_KON_L
	mMvCodeDef MoveC_Billy_SenpuuKon ; BANK $08 ; MOVE_BILLY_SENPUU_KON_H
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ; BANK $08 ; MOVE_BILLY_SUZUME_OTOSHI_L
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ; BANK $08 ; MOVE_BILLY_SUZUME_OTOSHI_H
	mMvCodeDef MoveC_Billy_KyoushuuHishouKon ; BANK $08 ; MOVE_BILLY_KYOUSHUU_HISHOU_KON_L
	mMvCodeDef MoveC_Billy_KyoushuuHishouKon ; BANK $08 ; MOVE_BILLY_KYOUSHUU_HISHOU_KON_H
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_74
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_76
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_78
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_7A
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_7C
	mMvCodeDef MoveC_Billy_SansetsuKonChuudanUchi ;X ; BANK $08 ; MOVE_BILLY_7E
	mMvCodeDef MoveC_Billy_ChouKaenSenpuuKon ; BANK $08 ; MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S
	mMvCodeDef MoveC_Billy_ThrowG ; BANK $08 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Saisyu:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Athena_KickHN ;X ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Joe_KickFCH ;X ; BANK $05 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Saisyu_PunchFH ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Saisyu_YamiBarai ; BANK $02 ; MOVE_SAISYU_YAMI_BARAI_L
	mMvCodeDef MoveC_Saisyu_YamiBarai ; BANK $02 ; MOVE_SAISYU_YAMI_BARAI_H
	mMvCodeDef MoveC_Saisyu_OniYaki ; BANK $02 ; MOVE_SAISYU_ONI_YAKI_L
	mMvCodeDef MoveC_Saisyu_OniYaki ; BANK $02 ; MOVE_SAISYU_ONI_YAKI_H
	mMvCodeDef MoveC_Saisyu_EnJou ; BANK $02 ; MOVE_SAISYU_EN_JOU_L
	mMvCodeDef MoveC_Saisyu_EnJou ; BANK $02 ; MOVE_SAISYU_EN_JOU_H
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_70
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_72
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_74
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_76
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_78
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_7A
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_7C
	mMvCodeDef MoveC_Saisyu_YamiBarai ;X ; BANK $02 ; MOVE_SAISYU_7E
	mMvCodeDef MoveC_Saisyu_UraOrochiNagi ; BANK $02 ; MOVE_SAISYU_URA_OROCHI_NAGI_S
	mMvCodeDef MoveC_Saisyu_ThrowG ; BANK $02 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Rugal:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Base_RoundStart ; BANK $02 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ;X ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ;X ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Rugal_KickHN ; BANK $18 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Rugal_ReppuKen ; BANK $18 ; MOVE_RUGAL_REPPU_KEN_L
	mMvCodeDef MoveC_Rugal_ReppuKen ; BANK $18 ; MOVE_RUGAL_REPPU_KEN_H
	mMvCodeDef MoveC_Rugal_GodPress ; BANK $18 ; MOVE_RUGAL_GOD_PRESS_L
	mMvCodeDef MoveC_Rugal_GodPress ; BANK $18 ; MOVE_RUGAL_GOD_PRESS_H
	mMvCodeDef MoveC_Rugal_DarkBarrier ; BANK $18 ; MOVE_RUGAL_DARK_BARRIER_L
	mMvCodeDef MoveC_Rugal_DarkBarrier ; BANK $18 ; MOVE_RUGAL_DARK_BARRIER_H
	mMvCodeDef MoveC_Rugal_GenocideCutter ; BANK $18 ; MOVE_RUGAL_GENOCIDE_CUTTER_L
	mMvCodeDef MoveC_Rugal_GenocideCutter ; BANK $18 ; MOVE_RUGAL_GENOCIDE_CUTTER_H
	mMvCodeDef MoveC_Rugal_ReppuKen ; BANK $18 ; MOVE_RUGAL_KAISER_WAVE_L
	mMvCodeDef MoveC_Rugal_ReppuKen ; BANK $18 ; MOVE_RUGAL_KAISER_WAVE_H
	mMvCodeDef MoveC_Rugal_ReppuKen ;X ; BANK $18 ; MOVE_RUGAL_78
	mMvCodeDef MoveC_Rugal_ReppuKen ;X ; BANK $18 ; MOVE_RUGAL_7A
	mMvCodeDef MoveC_Rugal_ReppuKen ;X ; BANK $18 ; MOVE_RUGAL_7C
	mMvCodeDef MoveC_Rugal_ReppuKen ;X ; BANK $18 ; MOVE_RUGAL_7E
	mMvCodeDef MoveC_Rugal_GiganticPressure ; BANK $18 ; MOVE_RUGAL_GIGANTIC_PRESSURE_S
	mMvCodeDef MoveC_Joe_ThrowG ; BANK $05 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ;X ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC
MoveCodePtrTbl_Nakoruru:
	mMvCodeDef MoveC_Base_None ; BANK $02 ; MOVE_SHARED_NONE
	mMvCodeDef MoveC_Base_Idle ; BANK $02 ; MOVE_SHARED_IDLE
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_F
	mMvCodeDef MoveC_Base_WalkH ; BANK $02 ; MOVE_SHARED_WALK_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_CROUCH
	mMvCodeDef MoveC_Base_WalkH ;X ; BANK $02 ; MOVE_SHARED_CROUCHWALK_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_N
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_F
	mMvCodeDef MoveC_Base_Jump, $02 ; BANK $00 ; MOVE_SHARED_JUMP_B
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_G
	mMvCodeDef MoveC_Base_NoAnim ; BANK $02 ; MOVE_SHARED_BLOCK_C
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_F
	mMvCodeDef MoveC_Base_Hop ; BANK $02 ; MOVE_SHARED_HOP_B
	mMvCodeDef MoveC_Base_ChargeMeter ; BANK $02 ; MOVE_SHARED_CHARGEMETER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_TAUNT
	mMvCodeDef MoveC_Base_Dodge ; BANK $02 ; MOVE_SHARED_DODGE
	mMvCodeDef MoveC_Base_WakeUp ; BANK $02 ; MOVE_SHARED_WAKEUP
	mMvCodeDef MoveC_Base_Dizzy ; BANK $02 ; MOVE_SHARED_DIZZY
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_WIN
	mMvCodeDef MoveC_Base_RoundEnd ; BANK $02 ; MOVE_SHARED_LOST_TIMEOVER
	mMvCodeDef MoveC_Nakoruru_RoundStart ; BANK $16 ; MOVE_SHARED_INTRO
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_HM
	mMvCodeDef MoveC_Base_NormL ;X ; BANK $02 ; MOVE_SHARED_KICK_LN
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HN
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_LM
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_HM
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_PUNCH_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_PUNCH_CH
	mMvCodeDef MoveC_Base_NormL ; BANK $02 ; MOVE_SHARED_KICK_CL
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_KICK_CH
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_DODGE_COUNTER
	mMvCodeDef MoveC_Base_NormH ; BANK $02 ; MOVE_SHARED_STRIKE
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_PUNCH_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FH
	mMvCodeDef MoveC_Base_NormH ;X ; BANK $02 ; MOVE_SHARED_KICK_FCH
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHI
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_PUNCH_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_ALX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_KICK_AHX
	mMvCodeDef MoveC_Base_NormA ; BANK $02 ; MOVE_SHARED_ATTACK_A
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_PUNCH_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHD
	mMvCodeDef MoveC_Base_NormA ;X ; BANK $02 ; MOVE_SHARED_KICK_AHB
	mMvCodeDef MoveC_Nakoruru_AmubeYatoro ; BANK $16 ; MOVE_NAKORURU_AMUBE_YATORO_L
	mMvCodeDef MoveC_Nakoruru_AmubeYatoro ; BANK $16 ; MOVE_NAKORURU_AMUBE_YATORO_H
	mMvCodeDef MoveC_Nakoruru_AnnuMutsube ; BANK $16 ; MOVE_NAKORURU_ANNU_MUTSUBE_L
	mMvCodeDef MoveC_Nakoruru_AnnuMutsube ; BANK $16 ; MOVE_NAKORURU_ANNU_MUTSUBE_H
	mMvCodeDef MoveC_Nakoruru_KamuiRimse ; BANK $16 ; MOVE_NAKORURU_KAMUI_RIMSE_L
	mMvCodeDef MoveC_Nakoruru_KamuiRimse ; BANK $16 ; MOVE_NAKORURU_KAMUI_RIMSE_H
	mMvCodeDef MoveC_Nakoruru_LelaMutsube ; BANK $16 ; MOVE_NAKORURU_LELA_MUTSUBE_L
	mMvCodeDef MoveC_Nakoruru_LelaMutsube ; BANK $16 ; MOVE_NAKORURU_LELA_MUTSUBE_H
	mMvCodeDef MoveC_Nakoruru_MamahahaFlight ; BANK $16 ; MOVE_NAKORURU_MAMAHAHA_FLIGHT_L
	mMvCodeDef MoveC_Nakoruru_MamahahaFlight ; BANK $16 ; MOVE_NAKORURU_MAMAHAHA_FLIGHT_H
	mMvCodeDef MoveC_Nakoruru_YatoroPokku ; BANK $16 ; MOVE_NAKORURU_YATORO_POKKU_L
	mMvCodeDef MoveC_Nakoruru_YatoroPokku ; BANK $16 ; MOVE_NAKORURU_YATORO_POKKU_H
	mMvCodeDef MoveC_Nakoruru_KamuiMutsube ; BANK $16 ; MOVE_NAKORURU_KAMUI_MUTSUBE_L
	mMvCodeDef MoveC_Nakoruru_KamuiMutsube ; BANK $16 ; MOVE_NAKORURU_KAMUI_MUTSUBE_H
	mMvCodeDef MoveC_Nakoruru_ElerushKamuiRimse ; BANK $16 ; MOVE_NAKORURU_ELERUSH_KAMUI_RIMSE_S
	mMvCodeDef MoveC_Nakoruru_ThrowG ; BANK $16 ; MOVE_SHARED_THROW_G
	mMvCodeDef MoveC_Base_Idle ;X ; BANK $02 ; MOVE_SHARED_THROW_A
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_POST_BLOCKSTUN
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT0MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HIT1MID
	mMvCodeDef MoveC_Hit_PostStunKnockback ; BANK $03 ; MOVE_SHARED_HITLOW
	mMvCodeDef MoveC_Hit_Launch_Generic ; BANK $03 ; MOVE_SHARED_LAUNCH_UB
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_DB_SHAKE
	mMvCodeDef MoveC_Hit_Launch_SwoopUp ;X ; BANK $03 ; MOVE_SHARED_LAUNCH_SWOOPUP
	mMvCodeDef MoveC_Hit_Sweep ;X ; BANK $03 ; MOVE_SHARED_HIT_SWEEP
	mMvCodeDef MoveC_Hit_Launch_RecA ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_REC
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID0
	mMvCodeDef MoveC_Hit_MultiMidKnockback ; BANK $03 ; MOVE_SHARED_HIT_MULTIMID1
	mMvCodeDef MoveC_Hit_Launch_Shake ; BANK $03 ; MOVE_SHARED_LAUNCH_UB_SHAKE
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_NOSYNC
	mMvCodeDef MoveC_Hit_GrabNoSync ; BANK $03 ; MOVE_SHARED_GRAB_FG_NOSYNC
	mMvCodeDef MoveC_Hit_GrabSync ; BANK $03 ; MOVE_SHARED_GRAB_UB_SYNC

GFX_Char_Nakoruru_Idle0_A: INCBIN "data/gfx/char/nakoruru_idle0_a.bin"
GFX_Char_Nakoruru_Idle0_B: INCBIN "data/gfx/char/nakoruru_idle0_b.bin"
GFX_Char_Nakoruru_Idle1_A: INCBIN "data/gfx/char/nakoruru_idle1_a.bin"
GFX_Char_Nakoruru_Idle1_B: INCBIN "data/gfx/char/nakoruru_idle1_b.bin"
GFX_Char_Nakoruru_Idle2: INCBIN "data/gfx/char/nakoruru_idle2.bin"
GFX_Char_Nakoruru_WalkF0_B: INCBIN "data/gfx/char/nakoruru_walkf0_b.bin"
GFX_Char_Nakoruru_WalkF1: INCBIN "data/gfx/char/nakoruru_walkf1.bin"
GFX_Char_Nakoruru_WalkF2_B: INCBIN "data/gfx/char/nakoruru_walkf2_b.bin"
GFX_Char_Nakoruru_Crouch0: INCBIN "data/gfx/char/nakoruru_crouch0.bin"
GFX_Char_Nakoruru_JumpN1: INCBIN "data/gfx/char/nakoruru_jumpn1.bin"
GFX_Char_Nakoruru_JumpN3: INCBIN "data/gfx/char/nakoruru_jumpn3.bin"
GFX_Char_Nakoruru_JumpF2: INCBIN "data/gfx/char/nakoruru_jumpf2.bin"
GFX_Char_Nakoruru_BlockG0: INCBIN "data/gfx/char/nakoruru_blockg0.bin"
GFX_Char_Nakoruru_BlockC0: INCBIN "data/gfx/char/nakoruru_blockc0.bin"
GFX_Char_Nakoruru_Hit0Mid0: INCBIN "data/gfx/char/nakoruru_hit0mid0.bin"
GFX_Char_Nakoruru_Hit1Mid1: INCBIN "data/gfx/char/nakoruru_hit1mid1.bin"
GFX_Char_Nakoruru_HitLow0: INCBIN "data/gfx/char/nakoruru_hitlow0.bin"
GFX_Char_Nakoruru_LaunchUB1: INCBIN "data/gfx/char/nakoruru_launchub1.bin"
GFX_Char_Nakoruru_LaunchUB2: INCBIN "data/gfx/char/nakoruru_launchub2.bin"
GFX_Char_Nakoruru_PunchLN1_A: INCBIN "data/gfx/char/nakoruru_punchln1_a.bin"
GFX_Char_Nakoruru_PunchLN1_B: INCBIN "data/gfx/char/nakoruru_punchln1_b.bin"
GFX_Char_Nakoruru_PunchLN2_A: INCBIN "data/gfx/char/nakoruru_punchln2_a.bin"
GFX_Char_Nakoruru_PunchLM2: INCBIN "data/gfx/char/nakoruru_punchlm2.bin"
GFX_Char_Nakoruru_PunchHN0: INCBIN "data/gfx/char/nakoruru_punchhn0.bin"
GFX_Char_Nakoruru_PunchHN2_A: INCBIN "data/gfx/char/nakoruru_punchhn2_a.bin"
GFX_Char_Nakoruru_PunchHN1_B: INCBIN "data/gfx/char/nakoruru_punchhn1_b.bin"
GFX_Char_Nakoruru_PunchHN2_B: INCBIN "data/gfx/char/nakoruru_punchhn2_b.bin"
GFX_Char_Nakoruru_PunchHM0: INCBIN "data/gfx/char/nakoruru_punchhm0.bin"
GFX_Char_Nakoruru_PunchHM2: INCBIN "data/gfx/char/nakoruru_punchhm2.bin"
GFX_Char_Nakoruru_PunchHM3_A: INCBIN "data/gfx/char/nakoruru_punchhm3_a.bin"
GFX_Char_Nakoruru_PunchHM3_B: INCBIN "data/gfx/char/nakoruru_punchhm3_b.bin"
GFX_Char_Nakoruru_PunchHM4_A: INCBIN "data/gfx/char/nakoruru_punchhm4_a.bin"
GFX_Char_Nakoruru_KickLN0_A: INCBIN "data/gfx/char/nakoruru_kickln0_a.bin"
GFX_Char_Nakoruru_KickLN0_B: INCBIN "data/gfx/char/nakoruru_kickln0_b.bin"
GFX_Char_Nakoruru_KickLN1_B: INCBIN "data/gfx/char/nakoruru_kickln1_b.bin"
GFX_Char_Nakoruru_HopF0_A: INCBIN "data/gfx/char/nakoruru_hopf0_a.bin"
GFX_Char_Nakoruru_KickLM1_B: INCBIN "data/gfx/char/nakoruru_kicklm1_b.bin"
GFX_Char_Nakoruru_KickLM2: INCBIN "data/gfx/char/nakoruru_kicklm2.bin"
GFX_Char_Nakoruru_HopF0_B: INCBIN "data/gfx/char/nakoruru_hopf0_b.bin"
GFX_Char_Nakoruru_KickHN1: INCBIN "data/gfx/char/nakoruru_kickhn1.bin"
GFX_Char_Nakoruru_KickHM0: INCBIN "data/gfx/char/nakoruru_kickhm0.bin"
GFX_Char_Nakoruru_KickHM1: INCBIN "data/gfx/char/nakoruru_kickhm1.bin"
GFX_Char_Nakoruru_PunchCL1: INCBIN "data/gfx/char/nakoruru_punchcl1.bin"
GFX_Char_Nakoruru_PunchCH0: INCBIN "data/gfx/char/nakoruru_punchch0.bin"
GFX_Char_Nakoruru_PunchCH1: INCBIN "data/gfx/char/nakoruru_punchch1.bin"
GFX_Char_Nakoruru_KickCL1: INCBIN "data/gfx/char/nakoruru_kickcl1.bin"
GFX_Char_Nakoruru_KickCH0: INCBIN "data/gfx/char/nakoruru_kickch0.bin"
GFX_Char_Nakoruru_KickCH1: INCBIN "data/gfx/char/nakoruru_kickch1.bin"
GFX_Char_Nakoruru_PunchALI0_B: INCBIN "data/gfx/char/nakoruru_punchali0_b.bin"
GFX_Char_Nakoruru_KickALI0: INCBIN "data/gfx/char/nakoruru_kickali0.bin"
GFX_Char_Nakoruru_KickAHX1: INCBIN "data/gfx/char/nakoruru_kickahx1.bin"
GFX_Char_Nakoruru_ChargeMeter0_A: INCBIN "data/gfx/char/nakoruru_chargemeter0_a.bin"
GFX_Char_Nakoruru_ChargeMeter0_B: INCBIN "data/gfx/char/nakoruru_chargemeter0_b.bin"
GFX_Char_Nakoruru_ChargeMeter1_A: INCBIN "data/gfx/char/nakoruru_chargemeter1_a.bin"
GFX_Char_Nakoruru_Strike0: INCBIN "data/gfx/char/nakoruru_strike0.bin"
GFX_Char_Nakoruru_Strike1: INCBIN "data/gfx/char/nakoruru_strike1.bin"
GFX_Char_Nakoruru_Intro0_A: INCBIN "data/gfx/char/nakoruru_intro0_a.bin"
GFX_Char_Nakoruru_Intro0_B: INCBIN "data/gfx/char/nakoruru_intro0_b.bin"
GFX_Char_Nakoruru_Intro2_A: INCBIN "data/gfx/char/nakoruru_intro2_a.bin"
GFX_Char_Nakoruru_Intro1_A: INCBIN "data/gfx/char/nakoruru_intro1_a.bin"
GFX_Char_Nakoruru_Unused_Intro3: INCBIN "data/gfx/char/nakoruru_unused_intro3.bin"

; =============== END OF BANK ===============
; Junk area below.
IF VER_US
	mIncJunk "../padding_us/L067FB0"
ELSE
	mIncJunk "L067FB0"
ENDC