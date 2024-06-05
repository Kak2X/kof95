OBJLstPtrTable_Rugal_Idle:
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Idle2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Idle1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_WalkF:
	dw OBJLstHdrA_Rugal_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_WalkB:
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_WalkF0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Crouch:
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_JumpN:
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_BlockG:
	dw OBJLstHdrA_Rugal_BlockG0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_BlockC:
	dw OBJLstHdrA_Rugal_BlockC0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Hit0Mid:
	dw OBJLstHdrA_Rugal_Hit0Mid0_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Dizzy:
	dw OBJLstHdrA_Rugal_Hit0Mid0_A, OBJLstHdrB_Rugal_Hit0Mid0_B
OBJLstPtrTable_Rugal_Hit1Mid:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_HitLow:
	dw OBJLstHdrA_Rugal_HitLow0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_LaunchUBRec:
	dw OBJLstHdrA_Rugal_Hit0Mid0_A, OBJLstHdrB_Rugal_Hit0Mid0_B ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_LaunchUB:
	dw OBJLstHdrA_Rugal_Hit0Mid0_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLstHdrA_Rugal_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_LaunchSwoopup:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B ;X
	dw OBJLstHdrA_Rugal_LaunchSwoopup1_A, OBJLstHdrB_Rugal_LaunchSwoopup1_B ;X
	dw OBJLstHdrA_Rugal_LaunchSwoopup2_A, OBJLstHdrB_Rugal_LaunchSwoopup2_B ;X
OBJLstPtrTable_Rugal_LaunchDBShake:
	dw OBJLstHdrA_Rugal_LaunchDBShake3_A, OBJLstHdrB_Rugal_LaunchDBShake3_B
	dw OBJLstHdrA_Rugal_LaunchDBShake3_A, OBJLstHdrB_Rugal_LaunchDBShake3_B
	dw OBJLstHdrA_Rugal_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_HitSweep:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B ;X
	dw OBJLstHdrA_Rugal_LaunchUB1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_LaunchUB2, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_GrabUBNoSync:
	dw OBJLstHdrA_Rugal_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Wakeup:
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_HopF:
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_HopB:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_ChargeMeter:
	dw OBJLstHdrA_Rugal_ChargeMeter0_A, OBJLstHdrB_Rugal_ChargeMeter0_B
	dw OBJLstHdrA_Rugal_ChargeMeter1_A, OBJLstHdrB_Rugal_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchLN:
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_PunchLN1_A, OBJLstHdrB_Rugal_PunchLN1_B ;X
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchLM:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_PunchLM1_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchHN:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B ;X
	dw OBJLstHdrA_Rugal_PunchHN1_A, OBJLstHdrB_Rugal_PunchHN1_B ;X
	dw OBJLstHdrA_Rugal_PunchHN2, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchHM:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_PunchHM1_A, OBJLstHdrB_Rugal_PunchHM1_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickLN:
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_KickLN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickLM:
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Idle0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickHN:
	dw OBJLstHdrA_Rugal_KickHN0_A, OBJLstHdrB_Rugal_KickHN0_B
	dw OBJLstHdrA_Rugal_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHN2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickHM:
	dw OBJLstHdrA_Rugal_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHM2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHM3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchCL:
	dw OBJLstHdrA_Rugal_PunchCL0_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLstHdrA_Rugal_PunchCL1_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLstHdrA_Rugal_PunchCL0_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchCH:
	dw OBJLstHdrA_Rugal_PunchCL0_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLstHdrA_Rugal_PunchCL1_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLstHdrA_Rugal_PunchCH2_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickCL:
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHM3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickCH:
	dw OBJLstHdrA_Rugal_PunchCL0_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLstHdrA_Rugal_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchCL0_A, OBJLstHdrB_Rugal_PunchCL0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchALI:
	dw OBJLstHdrA_Rugal_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_PunchAHI:
	dw OBJLstHdrA_Rugal_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickALI:
	dw OBJLstHdrA_Rugal_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KickAHI:
	dw OBJLstHdrA_Rugal_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_KickHN0_A, OBJLstHdrB_Rugal_KickAHI1_B
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_AttackA:
	dw OBJLstHdrA_Rugal_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Strike:
	dw OBJLstHdrA_Rugal_Strike0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Strike0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Rugal_Strike0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Dodge:
	dw OBJLstHdrA_Rugal_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_DodgeCounter:
	dw OBJLstHdrA_Rugal_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchHN1_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Intro:
	dw OBJLstHdrA_Rugal_Intro0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Intro0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Taunt:
	dw OBJLstHdrA_Rugal_Taunt0_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt1_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt2_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt1_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt0_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt1_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt2_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt1_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_Win:
	dw OBJLstHdrA_Rugal_Taunt0_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt1_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Taunt0_A, OBJLstHdrB_Rugal_Taunt0_B
	dw OBJLstHdrA_Rugal_Win3_A, OBJLstHdrB_Rugal_Win3_B
	dw OBJLstHdrA_Rugal_Win4_A, OBJLstHdrB_Rugal_Win3_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_LostTimeover:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLstHdrA_Rugal_Intro0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_ReppuKen:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_ReppuKen1_A, OBJLstHdrB_Rugal_ReppuKen1_B
	dw OBJLstHdrA_Rugal_ReppuKen2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ReppuKen3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_GodPress:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_GodPress1_A, OBJLstHdrB_Rugal_ReppuKen1_B
	dw OBJLstHdrA_Rugal_GodPress2_A, OBJLstHdrB_Rugal_ReppuKen1_B
	dw OBJLstHdrA_Rugal_GodPress3_A, OBJLstHdrB_Rugal_PunchHM1_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_GiganticPressure:
	dw OBJLstHdrA_Rugal_ChargeMeter0_A, OBJLstHdrB_Rugal_ChargeMeter0_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_GiganticPressure2_A, OBJLstHdrB_Rugal_ReppuKen1_B
	dw OBJLstHdrA_Rugal_GiganticPressure3_A, OBJLstHdrB_Rugal_ReppuKen1_B
	dw OBJLstHdrA_Rugal_GodPress3_A, OBJLstHdrB_Rugal_PunchHM1_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_DarkBarrier:
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLstHdrA_Rugal_DarkBarrier1_A, OBJLstHdrB_Rugal_DarkBarrier1_B
	dw OBJLstHdrA_Rugal_DarkBarrier2_A, OBJLstHdrB_Rugal_DarkBarrier1_B
	dw OBJLstHdrA_Rugal_DarkBarrier3_A, OBJLstHdrB_Rugal_DarkBarrier1_B
	dw OBJLstHdrA_Rugal_DarkBarrier4_A, OBJLstHdrB_Rugal_DarkBarrier1_B
	dw OBJLstHdrA_Rugal_DarkBarrier5_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_PunchLM0_A, OBJLstHdrB_Rugal_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_GenocideCutter:
	dw OBJLstHdrA_Rugal_GenocideCutter0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_GenocideCutter1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_GenocideCutter2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_GenocideCutter3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_KaiserWave:
	dw OBJLstHdrA_Rugal_Hit1Mid1_A, OBJLstHdrB_Rugal_Hit0Mid0_B
	dw OBJLstHdrA_Rugal_KaiserWave1_A, OBJLstHdrB_Rugal_KaiserWave1_B
	dw OBJLstHdrA_Rugal_KaiserWave1_A, OBJLstHdrB_Rugal_KaiserWave2_B
	dw OBJLstHdrA_Rugal_KaiserWave3_A, OBJLstHdrB_Rugal_KaiserWave3_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Rugal_ThrowG:
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_ThrowG0_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLstHdrA_Rugal_ThrowG13, OBJLSTPTR_NONE
	dw OBJLstHdrA_Rugal_PunchHN1_A, OBJLstHdrB_Rugal_PunchHN1_B
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Rugal_Idle0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Idle0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1B,$F9,$00 ; $00
	db $1B,$01,$02 ; $01
	db $23,$09,$04 ; $02
	db $2B,$F1,$06 ; $03
	db $2B,$F9,$08 ; $04
	db $2B,$01,$0A ; $05
	db $3B,$F9,$0C ; $06
	db $3B,$01,$0E ; $07
		
OBJLstHdrA_Rugal_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F9,$00 ; $00
	db $18,$01,$02 ; $01
	db $20,$09,$04 ; $02
	db $28,$F1,$06 ; $03
	db $28,$F9,$08 ; $04
	db $28,$01,$0A ; $05
	db $38,$F9,$0C ; $06
	db $38,$01,$0E ; $07
		
OBJLstHdrA_Rugal_Idle2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Idle2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F9,$00 ; $00
	db $18,$01,$02 ; $01
	db $20,$09,$04 ; $02
	db $28,$F1,$06 ; $03
	db $28,$F9,$08 ; $04
	db $28,$01,$0A ; $05
	db $38,$F9,$0C ; $06
	db $38,$01,$0E ; $07
		
OBJLstHdrA_Rugal_WalkF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F7,$00 ; $00
	db $18,$FF,$02 ; $01
	db $28,$EF,$04 ; $02
	db $28,$F7,$06 ; $03
	db $28,$FF,$08 ; $04
	db $38,$F7,$0A ; $05
	db $38,$FF,$0C ; $06
	db $20,$07,$0E ; $07
		
OBJLstHdrA_Rugal_WalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $28,$EC,$06 ; $03
	db $28,$F4,$08 ; $04
	db $28,$FC,$0A ; $05
	db $38,$F4,$0C ; $06
	db $38,$FC,$0E ; $07
	db $30,$04,$10 ; $08
		
OBJLstHdrA_Rugal_Crouch0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Crouch0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $38,$02,$0A ; $05
	db $30,$EA,$0C ; $06
		
OBJLstHdrA_Rugal_JumpN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F8,$00 ; $00
	db $18,$00,$02 ; $01
	db $28,$F0,$04 ; $02
	db $28,$F8,$06 ; $03
	db $28,$00,$08 ; $04
	db $20,$08,$0A ; $05
	db $38,$00,$0C ; $06
		
OBJLstHdrA_Rugal_KickHM0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_JumpN1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_BlockG0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_BlockG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F1,$00 ; $00
	db $1C,$F9,$02 ; $01
	db $1C,$01,$04 ; $02
	db $2C,$F9,$06 ; $03
	db $2C,$01,$08 ; $04
	db $34,$F1,$0A ; $05
	db $3C,$F9,$0C ; $06
	db $3C,$01,$0E ; $07
		
OBJLstHdrA_Rugal_BlockC0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_BlockC0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F6,$00 ; $00
	db $20,$FE,$02 ; $01
	db $20,$06,$04 ; $02
	db $30,$F6,$06 ; $03
	db $30,$FE,$08 ; $04
	db $30,$06,$0A ; $05
		
OBJLstHdrA_Rugal_Hit0Mid0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Hit0Mid0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
	db $20,$0A,$0A ; $05
		
OBJLstHdrB_Rugal_Hit0Mid0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F7,$00 ; $00
	db $38,$FF,$02 ; $01
		
OBJLstHdrB_Rugal_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Rugal_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Rugal_LaunchSwoopup2_B: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Rugal_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Rugal_LaunchSwoopup1_B: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Rugal_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_Hit1Mid1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EE,$00 ; $00
	db $18,$F6,$02 ; $01
	db $18,$FE,$04 ; $02
	db $20,$06,$06 ; $03
	db $28,$F6,$08 ; $04
	db $28,$FE,$0A ; $05
		
OBJLstHdrA_Rugal_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_LaunchSwoopup2_A: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_LaunchSwoopup1_A: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_HitLow0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_HitLow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$02,$00 ; $00
	db $20,$0A,$02 ; $01
	db $28,$12,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
	db $30,$0A,$0A ; $05
		
OBJLstHdrA_Rugal_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
	db $38,$0A,$06 ; $03
	db $38,$12,$08 ; $04
		
OBJLstHdrA_Rugal_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2D,$F2,$00 ; $00
	db $2D,$FA,$02 ; $01
	db $25,$02,$04 ; $02
	db $25,$0A,$06 ; $03
	db $2D,$12,$08 ; $04
	db $35,$02,$0A ; $05
	db $35,$0A,$0C ; $06
		
OBJLstHdrA_Rugal_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_PunchLM0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchLM0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $10,$FA,$08 ; $04
	db $10,$02,$0A ; $05
		
OBJLstHdrA_Rugal_PunchLN1_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchLM0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_PunchLM0_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Rugal_PunchLN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchLN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
	db $30,$05,$04 ; $02
		
OBJLstHdrA_Rugal_PunchLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E5,$00 ; $00
	db $20,$ED,$02 ; $01
	db $20,$F5,$04 ; $02
	db $20,$FD,$06 ; $03
	db $20,$05,$08 ; $04
	db $10,$F5,$0A ; $05
	db $10,$FD,$0C ; $06
		
OBJLstHdrA_Rugal_PunchHN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $20,$0A,$08 ; $04
	db $10,$F2,$0A ; $05
	db $10,$FA,$0C ; $06
		
OBJLstHdrA_Rugal_DarkBarrier5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_PunchHN1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_ReppuKen1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_PunchHN1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Rugal_PunchHN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchHN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $30,$02,$04 ; $02
	db $30,$0A,$06 ; $03
		
OBJLstHdrB_Rugal_ReppuKen1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchHN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Rugal_PunchHN1_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_PunchHN2: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1A,$F2,$00 ; $00
	db $1A,$FA,$02 ; $01
	db $12,$02,$04 ; $02
	db $22,$02,$06 ; $03
	db $2A,$F2,$08 ; $04
	db $2A,$FA,$0A ; $05
	db $32,$02,$0C ; $06
	db $3A,$F2,$0E ; $07
		
OBJLstHdrA_Rugal_ThrowG13:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_PunchHN2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_PunchHM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E8,$00 ; $00
	db $20,$F0,$02 ; $01
	db $20,$F8,$04 ; $02
	db $20,$00,$06 ; $03
	db $10,$F0,$08 ; $04
	db $10,$F8,$0A ; $05
		
OBJLstHdrA_Rugal_GodPress3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchHM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_PunchHM1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Rugal_PunchHM1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchHM1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
	db $38,$05,$04 ; $02
		
OBJLstHdrB_Rugal_KaiserWave3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchHM1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$ED,$00 ; $00
	db $30,$F5,$02 ; $01
	db $38,$FD,$04 ; $02
		
OBJLstHdrA_Rugal_KickLN1: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1D,$F7,$00 ; $00
	db $1D,$FF,$02 ; $01
	db $1D,$07,$04 ; $02
	db $2D,$F7,$06 ; $03
	db $2D,$FF,$08 ; $04
	db $2D,$07,$0A ; $05
	db $35,$EF,$0C ; $06
	db $3D,$FF,$0E ; $07
	db $25,$EF,$10 ; $08
		
OBJLstHdrA_Rugal_KickLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$E2,$00 ; $00
	db $1E,$EA,$02 ; $01
	db $16,$F2,$04 ; $02
	db $16,$FA,$06 ; $03
	db $1E,$02,$08 ; $04
	db $26,$F2,$0A ; $05
	db $26,$FA,$0C ; $06
	db $36,$F2,$0E ; $07
	db $36,$FA,$10 ; $08
		
OBJLstHdrA_Rugal_KickHN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $18,$0A,$08 ; $04
	db $10,$FA,$0A ; $05
	db $10,$02,$0C ; $06
		
OBJLstHdrB_Rugal_KickHN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_KickHN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
		
OBJLstHdrA_Rugal_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $28,$FA,$08 ; $04
	db $28,$02,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Rugal_KickHN2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$EA,$00 ; $00
	db $21,$F2,$02 ; $01
	db $19,$FA,$04 ; $02
	db $19,$02,$06 ; $03
	db $21,$0A,$08 ; $04
	db $29,$FA,$0A ; $05
	db $29,$02,$0C ; $06
	db $39,$FA,$0E ; $07
	db $39,$02,$10 ; $08
		
OBJLstHdrA_Rugal_KickHM1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_KickHN2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_KickHM2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1D,$E8,$00 ; $00
	db $1D,$F0,$02 ; $01
	db $1D,$F8,$04 ; $02
	db $1D,$00,$06 ; $03
	db $2D,$F0,$08 ; $04
	db $2D,$F8,$0A ; $05
	db $2D,$00,$0C ; $06
	db $2D,$08,$0E ; $07
	db $3D,$00,$10 ; $08
		
OBJLstHdrA_Rugal_KickAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_KickHM2.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_KickHM3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickHM3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$E8,$00 ; $00
	db $28,$F0,$02 ; $01
	db $28,$F8,$04 ; $02
	db $28,$00,$06 ; $03
	db $30,$08,$08 ; $04
	db $38,$F0,$0A ; $05
	db $38,$F8,$0C ; $06
	db $38,$00,$0E ; $07
	db $18,$F8,$10 ; $08
	db $18,$00,$12 ; $09
		
OBJLstHdrA_Rugal_PunchCL0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchCL0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $28,$09,$06 ; $03
	db $18,$F9,$08 ; $04
	db $18,$01,$0A ; $05
		
OBJLstHdrB_Rugal_PunchCL0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_PunchCL0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F8,$00 ; $00
	db $38,$00,$02 ; $01
		
OBJLstHdrA_Rugal_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E7,$00 ; $00
	db $28,$EF,$02 ; $01
	db $28,$F7,$04 ; $02
	db $28,$FF,$06 ; $03
	db $28,$07,$08 ; $04
	db $18,$F7,$0A ; $05
	db $18,$FF,$0C ; $06
		
OBJLstHdrA_Rugal_PunchCH2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchCH2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $20,$EA,$06 ; $03
	db $18,$F2,$08 ; $04
	db $18,$FA,$0A ; $05
		
OBJLstHdrA_Rugal_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $36,$E6,$00 ; $00
	db $36,$EE,$02 ; $01
	db $26,$F6,$04 ; $02
	db $26,$FE,$06 ; $03
	db $26,$06,$08 ; $04
	db $36,$F6,$0A ; $05
	db $36,$FE,$0C ; $06
	db $36,$06,$0E ; $07
		
OBJLstHdrA_Rugal_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$EC,$00 ; $00
	db $19,$F4,$02 ; $01
	db $19,$FC,$04 ; $02
	db $11,$04,$06 ; $03
	db $29,$F4,$08 ; $04
	db $29,$FC,$0A ; $05
	db $21,$04,$0C ; $06
		
OBJLstHdrA_Rugal_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2E,$E3,$00 ; $00
	db $26,$EB,$02 ; $01
	db $1E,$F3,$04 ; $02
	db $1E,$FB,$06 ; $03
	db $1E,$03,$08 ; $04
	db $2E,$F3,$0A ; $05
	db $2E,$FB,$0C ; $06
	db $2E,$03,$0E ; $07
		
OBJLstHdrA_Rugal_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KickALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $3A,$E7,$00 ; $00
	db $32,$EF,$02 ; $01
	db $1A,$F7,$04 ; $02
	db $1A,$FF,$06 ; $03
	db $12,$07,$08 ; $04
	db $2A,$F7,$0A ; $05
	db $2A,$FF,$0C ; $06
	db $22,$07,$0E ; $07
		
OBJLstHdrB_Rugal_KickAHI1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_KickAHI1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
		
OBJLstHdrA_Rugal_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $18,$F8,$02 ; $01
	db $18,$00,$04 ; $02
	db $20,$08,$06 ; $03
	db $28,$F8,$08 ; $04
	db $28,$00,$0A ; $05
	db $30,$08,$0C ; $06
	db $38,$F8,$0E ; $07
	db $38,$00,$10 ; $08
		
OBJLstHdrA_Rugal_ThrowG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ThrowG0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $10,$FA,$08 ; $04
	db $10,$02,$0A ; $05
		
OBJLstHdrA_Rugal_ThrowG1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ThrowG1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $17,$EF,$00 ; $00
	db $17,$F7,$02 ; $01
	db $0F,$FF,$04 ; $02
	db $17,$07,$06 ; $03
	db $27,$F7,$08 ; $04
	db $1F,$FF,$0A ; $05
	db $27,$07,$0C ; $06
	db $37,$F7,$0E ; $07
	db $2F,$FF,$10 ; $08
	db $37,$07,$12 ; $09
		
OBJLstHdrA_Rugal_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
	db $18,$02,$0A ; $05
		
OBJLstHdrB_Rugal_ChargeMeter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EC,$00 ; $00
	db $38,$F4,$02 ; $01
	db $38,$04,$04 ; $02
		
OBJLstHdrA_Rugal_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$F2,$06 ; $03
	db $28,$FA,$08 ; $04
	db $28,$02,$0A ; $05
		
OBJLstHdrA_Rugal_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $32,$EA,$00 ; $00
	db $32,$F2,$02 ; $01
	db $1A,$FA,$04 ; $02
	db $1A,$02,$06 ; $03
	db $12,$0A,$08 ; $04
	db $2A,$FA,$0A ; $05
	db $2A,$02,$0C ; $06
	db $22,$0A,$0E ; $07
		
OBJLstHdrA_Rugal_Strike0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Strike0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $18,$06,$06 ; $03
	db $20,$0E,$08 ; $04
	db $30,$FE,$0A ; $05
	db $28,$06,$0C ; $06
	db $30,$0E,$0E ; $07
	db $38,$16,$10 ; $08
		
OBJLstHdrA_Rugal_Intro0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Intro0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F5,$00 ; $00
	db $28,$FD,$02 ; $01
	db $28,$05,$04 ; $02
	db $38,$F5,$06 ; $03
	db $38,$FD,$08 ; $04
	db $38,$05,$0A ; $05
		
OBJLstHdrA_Rugal_Taunt0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Taunt0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
		
OBJLstHdrB_Rugal_Taunt0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Taunt0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $28,$0A,$0A ; $05
	db $30,$F2,$0C ; $06
	db $38,$FA,$0E ; $07
	db $38,$02,$10 ; $08
		
OBJLstHdrA_Rugal_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
		
OBJLstHdrA_Rugal_Taunt2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Taunt2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
		
OBJLstHdrA_Rugal_Win3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Win3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $10,$FA,$04 ; $02
	db $10,$F2,$06 ; $03
	db $20,$F2,$08 ; $04
		
OBJLstHdrB_Rugal_Win3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_Win3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $38,$02,$06 ; $03
		
OBJLstHdrA_Rugal_Win4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_Win4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $20,$F2,$04 ; $02
	db $28,$EA,$06 ; $03
	db $10,$F2,$08 ; $04
	db $10,$FA,$0A ; $05
		
OBJLstHdrA_Rugal_ReppuKen2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ReppuKen2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $30,$F3,$06 ; $03
	db $30,$FB,$08 ; $04
	db $30,$03,$0A ; $05
	db $30,$0B,$0C ; $06
	db $10,$FB,$0E ; $07
		
OBJLstHdrA_Rugal_ReppuKen3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_ReppuKen3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F3,$00 ; $00
	db $10,$FB,$02 ; $01
	db $20,$F3,$04 ; $02
	db $20,$FB,$06 ; $03
	db $20,$03,$08 ; $04
	db $30,$F3,$0A ; $05
	db $30,$FB,$0C ; $06
	db $30,$03,$0E ; $07
		
OBJLstHdrA_Rugal_GodPress1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GodPress1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $20,$06,$06 ; $03
	db $28,$0E,$08 ; $04
	db $10,$F6,$0A ; $05
	db $10,$FE,$0C ; $06
		
OBJLstHdrA_Rugal_GodPress2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GodPress1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Rugal_GodPress1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Rugal_DarkBarrier1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_14 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_DarkBarrier1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrB_Rugal_DarkBarrier1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_DarkBarrier1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $1E,$F5,$00 ; $00
	db $1E,$FD,$02 ; $01
	db $1E,$05,$04 ; $02
	db $2E,$F5,$06 ; $03
	db $2E,$FD,$08 ; $04
	db $2E,$05,$0A ; $05
	db $26,$ED,$0C ; $06
	db $3E,$05,$0E ; $07
	db $36,$ED,$10 ; $08
	db $3E,$F5,$12 ; $09
		
OBJLstHdrA_Rugal_DarkBarrier2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_14 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_DarkBarrier2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrA_Rugal_DarkBarrier3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_DarkBarrier3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrA_Rugal_DarkBarrier4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_DarkBarrier4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrA_Rugal_GenocideCutter0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GenocideCutter0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$EA,$00 ; $00
	db $24,$F2,$02 ; $01
	db $1C,$FA,$04 ; $02
	db $1C,$02,$06 ; $03
	db $2C,$FA,$08 ; $04
	db $2C,$02,$0A ; $05
	db $34,$EA,$0C ; $06
	db $34,$F2,$0E ; $07
	db $3C,$02,$10 ; $08
		
OBJLstHdrA_Rugal_GenocideCutter1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_2E ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GenocideCutter1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0F ; OBJ Count
	;    Y   X  ID+FLAG
	db $15,$E9,$00 ; $00
	db $15,$F1,$02 ; $01
	db $0D,$F9,$04 ; $02
	db $0D,$01,$06 ; $03
	db $15,$09,$08 ; $04
	db $15,$11,$0A ; $05
	db $25,$F1,$0C ; $06
	db $1D,$F9,$0E ; $07
	db $1D,$01,$10 ; $08
	db $25,$E9,$12 ; $09
	db $35,$F1,$14 ; $0A
	db $2D,$F9,$16 ; $0B
	db $2D,$01,$18 ; $0C
	db $2D,$09,$1A ; $0D
	db $25,$11,$1C ; $0E
		
OBJLstHdrA_Rugal_GenocideCutter2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GenocideCutter2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$F0,$00 ; $00
	db $19,$F8,$02 ; $01
	db $19,$00,$04 ; $02
	db $19,$08,$06 ; $03
	db $29,$F8,$08 ; $04
	db $29,$00,$0A ; $05
	db $39,$00,$0C ; $06
	db $09,$00,$0E ; $07
		
OBJLstHdrA_Rugal_GenocideCutter3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GenocideCutter3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0B ; OBJ Count
	;    Y   X  ID+FLAG
	db $12,$F3,$00 ; $00
	db $1A,$FB,$02 ; $01
	db $12,$03,$04 ; $02
	db $1A,$0B,$06 ; $03
	db $22,$F3,$08 ; $04
	db $2A,$FB,$0A ; $05
	db $22,$03,$0C ; $06
	db $2A,$0B,$0E ; $07
	db $32,$F3,$10 ; $08
	db $3A,$FB,$12 ; $09
	db $32,$13,$14 ; $0A
		
OBJLstHdrA_Rugal_KaiserWave1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KaiserWave1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$FA,$00 ; $00
	db $1C,$02,$02 ; $01
	db $2C,$FA,$04 ; $02
	db $2C,$02,$06 ; $03
	db $3C,$FA,$08 ; $04
	db $3C,$02,$0A ; $05
		
OBJLstHdrB_Rugal_KaiserWave1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_KaiserWave1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$0A,$00 ; $00
		
OBJLstHdrB_Rugal_KaiserWave2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Rugal_KaiserWave2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$0A,$00 ; $00
	db $20,$12,$02 ; $01
		
OBJLstHdrA_Rugal_KaiserWave3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_KaiserWave3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$DD,$00 ; $00
	db $20,$E5,$02 ; $01
	db $20,$ED,$04 ; $02
	db $20,$F5,$06 ; $03
	db $10,$ED,$08 ; $04
		
OBJLstHdrA_Rugal_GiganticPressure2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GiganticPressure2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $20,$06,$06 ; $03
	db $20,$0E,$08 ; $04
	db $20,$16,$0A ; $05
	db $10,$F6,$0C ; $06
	db $10,$FE,$0E ; $07
		
OBJLstHdrA_Rugal_GiganticPressure3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Rugal_GiganticPressure3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $20,$06,$06 ; $03
	db $20,$0E,$08 ; $04
	db $20,$16,$0A ; $05
	db $10,$F6,$0C ; $06
	db $10,$FE,$0E ; $07