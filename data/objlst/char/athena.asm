OBJLstPtrTable_Athena_Idle:
	dw OBJLstHdrA_Athena_Idle0_A, OBJLstHdrB_Athena_Idle0_B
	dw OBJLstHdrA_Athena_Idle1_A, OBJLstHdrB_Athena_Idle1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_WalkF:
	dw OBJLstHdrA_Athena_Idle0_A, OBJLstHdrB_Athena_Idle0_B
	dw OBJLstHdrA_Athena_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_WalkF2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_WalkB:
	dw OBJLstHdrA_Athena_WalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Idle0_A, OBJLstHdrB_Athena_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Crouch:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_JumpN:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_JumpF:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_JumpB:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_BlockG:
	dw OBJLstHdrA_Athena_BlockG0_A, OBJLstHdrB_Athena_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_BlockC:
	dw OBJLstHdrA_Athena_BlockC0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_HopF:
	dw OBJLstHdrA_Athena_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_HopB:
	dw OBJLstHdrA_Athena_HopB0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_HopB0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_ChargeMeter:
	dw OBJLstHdrA_Athena_ChargeMeter0_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ChargeMeter1_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchLN:
	dw OBJLstHdrA_Athena_PunchLN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLstHdrA_Athena_PunchLN1_A, OBJLstHdrB_Athena_PunchLN1_B
	dw OBJLstHdrA_Athena_PunchLN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchLM:
	dw OBJLstHdrA_Athena_PunchLN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLstHdrA_Athena_PunchLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PunchLN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchHN:
	dw OBJLstHdrA_Athena_PunchHN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLstHdrA_Athena_PunchHN1_A, OBJLstHdrB_Athena_PunchHN1_B
	dw OBJLstHdrA_Athena_PunchHN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchHM:
	dw OBJLstHdrA_Athena_PunchHN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLstHdrA_Athena_PunchHM1_A, OBJLstHdrB_Athena_PunchHN1_B
	dw OBJLstHdrA_Athena_PunchHN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickLN:
	dw OBJLstHdrA_Athena_KickLN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickLN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickHN:
	dw OBJLstHdrA_Athena_KickHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_HopB0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickHM:
	dw OBJLstHdrA_Athena_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchCL:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PunchCL1_A, OBJLstHdrB_Athena_PunchCL1_B
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchCH:
	dw OBJLstHdrA_Athena_PunchCH0_A, OBJLstHdrB_Athena_PunchCL1_B
	dw OBJLstHdrA_Athena_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PunchCH0_A, OBJLstHdrB_Athena_PunchCL1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickCL:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickCH:
	dw OBJLstHdrA_Athena_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchALI:
	dw OBJLstHdrA_Athena_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchAHI:
	dw OBJLstHdrA_Athena_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PunchAHX:
	dw OBJLstHdrA_Athena_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickALI:
	dw OBJLstHdrA_Athena_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickAHI:
	dw OBJLstHdrA_Athena_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickAHX:
	dw OBJLstHdrA_Athena_KickAHX0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_KickAHX0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_AttackA:
	dw OBJLstHdrA_Athena_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Strike:
	dw OBJLstHdrA_Athena_Idle0_A, OBJLstHdrB_Athena_Idle0_B ;X
	dw OBJLstHdrA_Athena_Strike1_A, OBJLstHdrB_Athena_PunchHN1_B ;X
	dw OBJLstHdrA_Athena_Idle0_A, OBJLstHdrB_Athena_Idle0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Dodge:
	dw OBJLstHdrA_Athena_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_DodgeCounter:
	dw OBJLstHdrA_Athena_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_KickLN1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Hit0Mid:
	dw OBJLstHdrA_Athena_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Dizzy:
	dw OBJLstHdrA_Athena_Hit0Mid0, OBJLSTPTR_NONE
OBJLstPtrTable_Athena_Hit1Mid:
	dw OBJLstHdrA_Athena_Hit1Mid1_A, OBJLstHdrB_Athena_Idle1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_HitLow:
	dw OBJLstHdrA_Athena_HitLow0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_LaunchUBRec:
	dw OBJLstHdrA_Athena_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_LaunchUB:
	dw OBJLstHdrA_Athena_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_LaunchSwoopup:
	dw OBJLstHdrA_Athena_Hit1Mid1_A, OBJLstHdrB_Athena_Idle1_B
	dw OBJLstHdrA_Athena_LaunchSwoopup1_A, OBJLstHdrB_Athena_LaunchSwoopup1_B
	dw OBJLstHdrA_Athena_LaunchSwoopup2_A, OBJLstHdrB_Athena_LaunchSwoopup2_B
OBJLstPtrTable_Athena_LaunchDBShake:
	dw OBJLstHdrA_Athena_LaunchDBShake3_A, OBJLstHdrB_Athena_LaunchDBShake3_B
	dw OBJLstHdrA_Athena_LaunchDBShake3_A, OBJLstHdrB_Athena_LaunchDBShake3_B
	dw OBJLstHdrA_Athena_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_HitSweep:
	dw OBJLstHdrA_Athena_Hit1Mid1_A, OBJLstHdrB_Athena_Idle1_B
	dw OBJLstHdrA_Athena_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_GrabUBNoSync:
	dw OBJLstHdrA_Athena_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Wakeup:
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Intro:
	dw OBJLstHdrA_Athena_Intro0_A, OBJLstHdrB_Athena_Intro0_B
	dw OBJLstHdrA_Athena_Intro1_A, OBJLstHdrB_Athena_Intro0_B
	dw OBJLstHdrA_Athena_Intro2_A, OBJLstHdrB_Athena_Intro0_B
	dw OBJLstHdrA_Athena_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Intro4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Intro5_A, OBJLstHdrB_Athena_Intro5_B
	dw OBJLstHdrA_Athena_Intro6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Intro7_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Intro8_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Intro9_A, OBJLstHdrB_Athena_Intro9_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Taunt:
	dw OBJLstHdrA_Athena_Taunt0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Taunt1_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_Taunt2_A, OBJLstHdrB_Athena_Taunt2_B
	dw OBJLstHdrA_Athena_Taunt3_A, OBJLstHdrB_Athena_Taunt2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_Win:
	dw OBJLstHdrA_Athena_Win0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Win1_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Win2_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Win3_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Win4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Win5_A, OBJLstHdrB_Athena_Win5_B
	dw OBJLstHdrA_Athena_Win6_A, OBJLstHdrB_Athena_Win5_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_LostTimeover:
	dw OBJLstHdrA_Athena_WalkF1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PsychoBall:
	dw OBJLstHdrA_Athena_PsychoBall0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PsychoBall1_A, OBJLstHdrB_Athena_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PsychoReflector:
	dw OBJLstHdrA_Athena_PunchHN0_A, OBJLstHdrB_Athena_PunchLN0_B
	dw OBJLstHdrA_Athena_PsychoReflector1_A, OBJLstHdrB_Athena_PsychoReflector1_B
	dw OBJLstHdrA_Athena_PsychoReflector1_A, OBJLstHdrB_Athena_PsychoReflector2_B
	dw OBJLstHdrA_Athena_PsychoReflector3_A, OBJLstHdrB_Athena_PsychoReflector3_B
	dw OBJLstHdrA_Athena_PsychoReflector3_A, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PsychoSword:
	dw OBJLstHdrA_Athena_PsychoSword0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PsychoSword1_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_PsychoSword2_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_PsychoSword3_A, OBJLstHdrB_Athena_Intro7_B
	dw OBJLstHdrA_Athena_Intro6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Intro5_A, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PhoenixArrow:
	dw OBJLstHdrA_Athena_PhoenixArrow0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrow1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrow2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrow3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrow0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrow1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_PhoenixArrowKick:
	dw OBJLstHdrA_Athena_PhoenixArrowKick0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_PhoenixArrowKick1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_ShiningCrystalBitG:
	dw OBJLstHdrA_Athena_ChargeMeter1_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ChargeMeter0_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ChargeMeter1_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ChargeMeter0_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ShiningCrystalBitG4_A, OBJLstHdrB_Athena_ChargeMeter0_B
	dw OBJLstHdrA_Athena_ShiningCrystalBitG5, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_KickAHD:
	dw OBJLstHdrA_Athena_KickAHD0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_KickAHD0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_ThrowG:
	dw OBJLstHdrA_Athena_ThrowG0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Athena_ThrowG1_A, OBJLstHdrB_Athena_PunchLN1_B
	dw OBJLstHdrA_Athena_ThrowG2_A, OBJLstHdrB_Athena_ThrowG2_B
	dw OBJLstHdrA_Athena_ThrowG3_A, OBJLstHdrB_Athena_ThrowG2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Athena_ThrowA:
	dw OBJLstHdrA_Athena_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_ThrowA1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Athena_Crouch0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Athena_Idle0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Idle0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
		
OBJLstHdrB_Athena_Idle0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F0,$00 ; $00
	db $38,$F8,$02 ; $01
	db $38,$00,$04 ; $02
		
OBJLstHdrB_Athena_PunchLN1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Athena_Idle0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_Idle1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Idle1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
		
OBJLstHdrB_Athena_Idle1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrB_Athena_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Athena_Idle1_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Athena_LaunchSwoopup2_B:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Athena_Idle1_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Athena_LaunchSwoopup1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Idle1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Athena_Idle1_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_WalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
		
OBJLstHdrA_Athena_WalkF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_WalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
		
OBJLstHdrA_Athena_Crouch0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Crouch0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Athena_JumpN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F6,$00 ; $00
	db $20,$FE,$02 ; $01
	db $30,$F6,$04 ; $02
	db $30,$FE,$06 ; $03
		
OBJLstHdrA_Athena_JumpN3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpN3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Athena_JumpF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Athena_JumpF4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_JumpF5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpF5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $18,$0A,$04 ; $02
	db $28,$02,$06 ; $03
	db $28,$0A,$08 ; $04
	db $30,$FA,$0A ; $05
		
OBJLstHdrA_Athena_JumpF3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_JumpF5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_JumpF5.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_BlockG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_BlockG0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F9,$00 ; $00
	db $28,$01,$02 ; $01
	db $18,$F9,$04 ; $02
	db $18,$01,$06 ; $03
		
OBJLstHdrA_Athena_BlockC0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_BlockC0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $38,$F2,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Athena_Hit0Mid0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Hit0Mid0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
		
OBJLstHdrA_Athena_Hit1Mid1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F8,$00 ; $00
	db $28,$00,$02 ; $01
	db $18,$F8,$04 ; $02
	db $18,$00,$06 ; $03
		
OBJLstHdrA_Athena_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_LaunchSwoopup2_A:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_LaunchSwoopup1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_HitLow0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_HitLow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $36,$F2,$00 ; $00
	db $26,$FA,$02 ; $01
	db $26,$02,$04 ; $02
	db $36,$FA,$06 ; $03
	db $36,$02,$08 ; $04
		
OBJLstHdrA_Athena_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$F2,$00 ; $00
	db $2E,$FA,$02 ; $01
	db $26,$02,$04 ; $02
	db $2E,$0A,$06 ; $03
	db $36,$F2,$08 ; $04
	db $36,$02,$0A ; $05
		
OBJLstHdrA_Athena_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $3A,$F2,$00 ; $00
	db $32,$FA,$02 ; $01
	db $32,$02,$04 ; $02
	db $32,$0A,$06 ; $03
		
OBJLstHdrA_Athena_PunchLN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F5,$00 ; $00
	db $20,$FD,$02 ; $01
		
OBJLstHdrB_Athena_PunchLN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
	db $38,$06,$04 ; $02
		
OBJLstHdrA_Athena_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F8,$00 ; $00
	db $28,$00,$02 ; $01
	db $28,$08,$04 ; $02
	db $18,$F8,$06 ; $03
	db $18,$00,$08 ; $04
		
OBJLstHdrA_Athena_PunchLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Athena_PunchHN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchHN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Athena_PunchHN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchHN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
		
OBJLstHdrB_Athena_PunchHN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PunchHN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Athena_PunchHM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchHM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
		
OBJLstHdrA_Athena_KickLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Athena_KickLN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickLN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FD,$00 ; $00
	db $20,$05,$02 ; $01
	db $30,$F5,$04 ; $02
	db $30,$FD,$06 ; $03
	db $30,$05,$08 ; $04
		
OBJLstHdrA_Athena_HopB0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_HopB0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EB,$00 ; $00
	db $20,$F3,$02 ; $01
	db $20,$FB,$04 ; $02
	db $20,$03,$06 ; $03
	db $30,$F3,$08 ; $04
	db $30,$FB,$0A ; $05
		
OBJLstHdrA_Athena_KickHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_HopB0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_HopB0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $20,$EA,$04 ; $02
	db $28,$F2,$06 ; $03
	db $38,$F2,$08 ; $04
		
OBJLstHdrA_Athena_KickHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $30,$0A,$0A ; $05
		
OBJLstHdrA_Athena_KickHM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickHM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $28,$FA,$08 ; $04
	db $30,$02,$0A ; $05
	db $10,$F2,$0C ; $06
		
OBJLstHdrA_Athena_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
		
OBJLstHdrB_Athena_PunchCL1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PunchCL1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
		
OBJLstHdrA_Athena_PunchCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $30,$FA,$04 ; $02
	db $38,$F2,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Athena_PunchCH0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchCH0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
		
OBJLstHdrA_Athena_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $38,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Athena_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_KickCL1.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $38,$F2,$06 ; $03
	db $38,$FA,$08 ; $04
		
OBJLstHdrA_Athena_KickCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $38,$F2,$04 ; $02
	db $38,$FA,$06 ; $03
		
OBJLstHdrA_Athena_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
		
OBJLstHdrA_Athena_HopF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_HopF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Athena_PunchAHX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PunchAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $14,$F6,$00 ; $00
	db $1C,$FE,$02 ; $01
	db $24,$F6,$04 ; $02
	db $2C,$FE,$06 ; $03
	db $34,$F6,$08 ; $04
		
OBJLstHdrA_Athena_KickAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $18,$0A,$06 ; $03
	db $28,$FA,$08 ; $04
	db $28,$02,$0A ; $05
	db $38,$FA,$0C ; $06
		
OBJLstHdrA_Athena_KickAHX0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Athena_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$02,$00 ; $00
	db $20,$0A,$02 ; $01
	db $30,$02,$04 ; $02
	db $30,$0A,$06 ; $03
		
OBJLstHdrA_Athena_ThrowG0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $30,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
	db $38,$04,$0C ; $06
		
OBJLstHdrA_Athena_ThrowG1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowG1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $20,$12,$06 ; $03
	db $18,$FA,$08 ; $04
	db $18,$02,$0A ; $05
		
OBJLstHdrA_Athena_ThrowG2_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowG2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
		
OBJLstHdrB_Athena_ThrowG2_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_ThrowG2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
	db $30,$04,$04 ; $02
		
OBJLstHdrA_Athena_ThrowG3_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowG3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
		
OBJLstHdrA_Athena_ThrowA0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$F4,$00 ; $00
	db $24,$FC,$02 ; $01
	db $24,$04,$04 ; $02
	db $34,$F4,$06 ; $03
	db $34,$FC,$08 ; $04
	db $34,$EC,$0A ; $05
		
OBJLstHdrA_Athena_ThrowA1: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ThrowA1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $18,$0A,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Athena_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $18,$F2,$04 ; $02
	db $18,$FA,$06 ; $03
	db $08,$F2,$08 ; $04
	db $08,$FA,$0A ; $05
		
OBJLstHdrB_Athena_ChargeMeter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
		
OBJLstHdrB_Athena_Win5_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F3,$00 ; $00
	db $38,$FB,$02 ; $01
		
OBJLstHdrA_Athena_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $18,$F2,$04 ; $02
	db $18,$FA,$06 ; $03
	db $08,$F2,$08 ; $04
	db $08,$FA,$0A ; $05
		
; [TCRF] Unreferenced sprite mapping using otherwise unused graphics.
OBJLstHdrA_Athena_Unused_A_0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Unused_A_0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $20,$EA,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
	db $20,$02,$0A ; $05
	db $10,$EA,$0C ; $06

; [TCRF] Unreferenced sprite mapping using otherwise unused graphics.
OBJLstHdrA_Athena_Unused_A_1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Unused_A_1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $18,$F2,$04 ; $02
	db $18,$FA,$06 ; $03

OBJLstHdrA_Athena_Strike1_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Strike1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
		
OBJLstHdrA_Athena_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $28,$0A,$08 ; $04
	db $18,$FA,$0A ; $05
		
OBJLstHdrA_Athena_Intro0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F7,$00 ; $00
	db $20,$FF,$02 ; $01
		
OBJLstHdrB_Athena_Intro0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Intro0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
		
OBJLstHdrA_Athena_Intro1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F7,$00 ; $00
	db $20,$FF,$02 ; $01
		
OBJLstHdrA_Athena_Intro2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Athena_Intro3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
	db $28,$F2,$08 ; $04
		
OBJLstHdrA_Athena_Intro4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E7,$00 ; $00
	db $10,$EF,$02 ; $01
	db $10,$F7,$04 ; $02
	db $20,$EF,$06 ; $03
	db $20,$F7,$08 ; $04
	db $20,$FF,$0A ; $05
	db $30,$F7,$0C ; $06
	db $38,$FF,$0E ; $07
		
OBJLstHdrB_Athena_Intro5_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Intro5_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$0A,$00 ; $00
	db $18,$12,$02 ; $01
	db $18,$02,$04 ; $02
		
OBJLstHdrA_Athena_Intro7_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro7_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $10,$F2,$06 ; $03
	db $10,$FA,$08 ; $04
		
OBJLstHdrA_Athena_Intro8_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro8_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $10,$EA,$04 ; $02
	db $10,$F2,$06 ; $03
	db $10,$FA,$08 ; $04
		
OBJLstHdrA_Athena_Intro9_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro9_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$04,$02 ; $01
	db $10,$FC,$04 ; $02
	db $10,$04,$06 ; $03
		
OBJLstHdrA_Athena_Taunt0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Taunt0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $30,$F3,$04 ; $02
	db $30,$FB,$06 ; $03
		
OBJLstHdrA_Athena_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $20,$EC,$04 ; $02
	db $18,$F4,$06 ; $03
	db $18,$FC,$08 ; $04
	db $18,$04,$0A ; $05
	
OBJLstHdrB_Athena_Unused_B_0:	
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Unused_B_0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F3,$00 ; $00
	db $38,$FB,$02 ; $01
	
OBJLstHdrA_Athena_Taunt2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Taunt2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
		
OBJLstHdrB_Athena_Taunt2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Taunt2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $38,$FD,$02 ; $01
		
OBJLstHdrA_Athena_Taunt3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Taunt3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
		
OBJLstHdrA_Athena_Win0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $18,$F8,$02 ; $01
	db $20,$00,$04 ; $02
	db $28,$F8,$06 ; $03
	db $30,$00,$08 ; $04
	db $38,$F0,$0A ; $05
	db $38,$F8,$0C ; $06
		
OBJLstHdrA_Athena_Win1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $10,$F3,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrA_Athena_Win2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $10,$F3,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrA_Athena_Win3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $18,$EA,$04 ; $02
	db $10,$F2,$06 ; $03
	db $10,$FA,$08 ; $04
		
OBJLstHdrA_Athena_Win4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $12,$F6,$00 ; $00
	db $1A,$FE,$02 ; $01
	db $22,$EE,$04 ; $02
	db $22,$F6,$06 ; $03
	db $2A,$FE,$08 ; $04
	db $32,$F6,$0A ; $05
		
OBJLstHdrA_Athena_Win6_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win6_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $18,$F2,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrA_Athena_Win5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Win6_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_Win6_A.bin ; iOBJLstHdrA_DataPtr
	db $01 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_PsychoBall0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoBall0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $38,$FA,$08 ; $04
	db $30,$F2,$0A ; $05
		
OBJLstHdrA_Athena_PsychoBall1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoBall1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F6,$00 ; $00
	db $28,$FE,$02 ; $01
	db $28,$06,$04 ; $02
	db $18,$F6,$06 ; $03
	db $18,$FE,$08 ; $04
		
OBJLstHdrA_Athena_PsychoReflector3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoReflector3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $30,$F2,$04 ; $02
	db $30,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Athena_PsychoReflector1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_14 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoReflector3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_PsychoReflector3_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Athena_PsychoReflector1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PsychoReflector1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrB_Athena_PsychoReflector2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PsychoReflector2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrB_Athena_PsychoReflector3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_PsychoReflector3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $30,$E2,$04 ; $02
	db $30,$EA,$06 ; $03
		
OBJLstHdrA_Athena_PsychoSword0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoSword0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $18,$0A,$06 ; $03
	db $28,$02,$08 ; $04
	db $30,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Athena_PsychoSword1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoSword1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $08,$EB,$00 ; $00
	db $18,$EB,$02 ; $01
	db $10,$F3,$04 ; $02
	db $10,$FB,$06 ; $03
	db $20,$F3,$08 ; $04
	db $20,$FB,$0A ; $05
		
OBJLstHdrB_Athena_Intro7_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Intro7_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
		
OBJLstHdrB_Athena_Intro9_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Athena_Intro7_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
		
OBJLstHdrA_Athena_PsychoSword2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoSword2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $08,$EA,$00 ; $00
	db $18,$EA,$02 ; $01
	db $10,$F2,$04 ; $02
	db $10,$FA,$06 ; $03
	db $20,$F2,$08 ; $04
	db $20,$FA,$0A ; $05
		
OBJLstHdrA_Athena_PsychoSword3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PsychoSword3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$EA,$00 ; $00
	db $20,$EA,$02 ; $01
	db $10,$F2,$04 ; $02
	db $10,$FA,$06 ; $03
	db $20,$F2,$08 ; $04
	db $20,$FA,$0A ; $05
		
OBJLstHdrA_Athena_Intro6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro6 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
	db $38,$FA,$0A ; $05
		
OBJLstHdrA_Athena_Intro5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_Intro5_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$F2,$06 ; $03
	db $28,$FA,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$F2,$0C ; $06
		
OBJLstHdrA_Athena_PhoenixArrow0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FB,$00 ; $00
	db $28,$03,$02 ; $01
	db $38,$FB,$04 ; $02
	db $38,$03,$06 ; $03
		
OBJLstHdrA_Athena_PhoenixArrow2:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_PhoenixArrow0.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_PhoenixArrowKick0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrowKick0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $30,$02,$04 ; $02
	db $38,$F2,$06 ; $03
	db $38,$FA,$08 ; $04
		
OBJLstHdrA_Athena_PhoenixArrowKick1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_24 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrowKick1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E2,$00 ; $00
	db $30,$EA,$02 ; $01
	db $30,$F2,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Athena_PhoenixArrow1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrow1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2E,$F2,$00 ; $00
	db $2E,$FA,$02 ; $01
	db $2E,$02,$04 ; $02
		
OBJLstHdrA_Athena_PhoenixArrow3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_PhoenixArrow1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Athena_PhoenixArrow1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Athena_ShiningCrystalBitG4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ShiningCrystalBitG4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $28,$F2,$04 ; $02
	db $28,$FA,$06 ; $03
		
OBJLstHdrA_Athena_ShiningCrystalBitG5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_ShiningCrystalBitG5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $38,$EA,$06 ; $03
	db $38,$F2,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Athena_KickAHD0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Athena_KickAHD0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $28,$F2,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $20,$0A,$0A ; $05