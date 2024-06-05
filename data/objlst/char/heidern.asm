OBJLstPtrTable_Heidern_Idle:
	dw OBJLstHdrA_Heidern_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Idle1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_WalkF:
	dw OBJLstHdrA_Heidern_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_WalkF2_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_WalkB:
	dw OBJLstHdrA_Heidern_WalkF2_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Idle0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Crouch:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_JumpN:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_JumpF:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_JumpB:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_BlockG:
	dw OBJLstHdrA_Heidern_BlockG0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_BlockC:
	dw OBJLstHdrA_Heidern_BlockC0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_HopF:
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_HopB:
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_ChargeMeter:
	dw OBJLstHdrA_Heidern_ChargeMeter0_A, OBJLstHdrB_Heidern_ChargeMeter0_B
	dw OBJLstHdrA_Heidern_ChargeMeter1_A, OBJLstHdrB_Heidern_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchLN:
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchLN1_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchLM:
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchLM1_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchHN:
	dw OBJLstHdrA_Heidern_PunchHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchHN1_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchHN2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchHN3_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchHM:
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchHN1_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickLN:
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickLM:
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_KickLM1_A, OBJLstHdrB_Heidern_KickLM1_B
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickHN:
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_KickHN1_B
	dw OBJLstHdrA_Heidern_KickHN2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickHM:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_KickLM1_A, OBJLstHdrB_Heidern_KickHM2_B
	dw OBJLstHdrA_Heidern_KickHM3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchCL:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_PunchCL1_A, OBJLstHdrB_Heidern_PunchCL1_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchCH:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_PunchCH1_A, OBJLstHdrB_Heidern_PunchCL1_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickCL:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickCH:
	dw OBJLstHdrA_Heidern_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchALI:
	dw OBJLstHdrA_Heidern_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchAHI:
	dw OBJLstHdrA_Heidern_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchALX:
	dw OBJLstHdrA_Heidern_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_PunchAHX:
	dw OBJLstHdrA_Heidern_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickALI:
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_KickALI0_B
	dw OBJLstHdrA_Heidern_KickALI1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickAHI:
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_KickALI0_B
	dw OBJLstHdrA_Heidern_KickALI1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_KickALI0_B
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_KickAHI3_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickALX:
	dw OBJLstHdrA_Heidern_KickALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_KickAHX:
	dw OBJLstHdrA_Heidern_KickAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_AttackA:
	dw OBJLstHdrA_Heidern_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickHN1_A, OBJLstHdrB_Heidern_AttackA1_B
	dw OBJLstHdrA_Heidern_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B ;X
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Strike:
	dw OBJLstHdrA_Heidern_Strike0_A, OBJLstHdrB_Heidern_Strike0_B
	dw OBJLstHdrA_Heidern_Strike1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Strike2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickLM1_A, OBJLstHdrB_Heidern_KickLM1_B
	dw OBJLstHdrA_Heidern_PunchLN0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Dodge:
	dw OBJLstHdrA_Heidern_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_DodgeCounter:
	dw OBJLstHdrA_Heidern_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_KickHM3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_DodgeCounter2_A, OBJLstHdrB_Heidern_DodgeCounter2_B
	dw OBJLstHdrA_Heidern_DodgeCounter3_A, OBJLstHdrB_Heidern_DodgeCounter2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Hit0Mid:
	dw OBJLstHdrA_Heidern_Hit0Mid0_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Dizzy:
	dw OBJLstHdrA_Heidern_Hit0Mid0_A, OBJLstHdrB_Heidern_Hit0Mid0_B
OBJLstPtrTable_Heidern_Hit1Mid:
	dw OBJLstHdrA_Heidern_Hit1Mid1_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_HitLow:
	dw OBJLstHdrA_Heidern_HitLow0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_LaunchUBRec:
	dw OBJLstHdrA_Heidern_Hit0Mid0_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLstHdrA_Heidern_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpN1_A, OBJLstHdrB_Heidern_WalkF2_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_LaunchUB:
	dw OBJLstHdrA_Heidern_Hit0Mid0_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLstHdrA_Heidern_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_LaunchUB2_A, OBJLstHdrB_Heidern_LaunchUB2_B
	dw OBJLstHdrA_Heidern_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_LaunchUB2_A, OBJLstHdrB_Heidern_LaunchUB2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_LaunchSwoopup:
	dw OBJLstHdrA_Heidern_Hit1Mid1_A, OBJLstHdrB_Heidern_Hit0Mid0_B ;X
	dw OBJLstHdrA_Heidern_LaunchSwoopup1_A, OBJLstHdrB_Heidern_LaunchSwoopup1_B ;X
	dw OBJLstHdrA_Heidern_LaunchSwoopup2_A, OBJLstHdrB_Heidern_LaunchSwoopup2_B ;X
OBJLstPtrTable_Heidern_LaunchDBShake:
	dw OBJLstHdrA_Heidern_LaunchDBShake3_A, OBJLstHdrB_Heidern_LaunchDBShake3_B
	dw OBJLstHdrA_Heidern_LaunchDBShake3_A, OBJLstHdrB_Heidern_LaunchDBShake3_B
	dw OBJLstHdrA_Heidern_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_LaunchUB2_A, OBJLstHdrB_Heidern_LaunchUB2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_HitSweep:
	dw OBJLstHdrA_Heidern_Hit1Mid1_A, OBJLstHdrB_Heidern_Hit0Mid0_B ;X
	dw OBJLstHdrA_Heidern_LaunchUB1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_LaunchUB2_A, OBJLstHdrB_Heidern_LaunchUB2_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_GrabUBNoSync:
	dw OBJLstHdrA_Heidern_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Wakeup:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Intro:
	dw OBJLstHdrA_Heidern_Intro0_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLstHdrA_Heidern_Intro1_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLstHdrA_Heidern_Intro2_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Taunt:
	dw OBJLstHdrA_Heidern_Taunt0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_Win:
	dw OBJLstHdrA_Heidern_Win0_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLstHdrA_Heidern_Win1_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLstHdrA_Heidern_Win2_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLstHdrA_Heidern_Win1_A, OBJLstHdrB_Heidern_Intro0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_LostTimeover:
	dw OBJLstHdrA_Heidern_Hit1Mid1_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_CrossCutter:
	dw OBJLstHdrA_Heidern_CrossCutter0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_CrossCutter1_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_CrossCutter2_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLstHdrA_Heidern_CrossCutter3_A, OBJLstHdrB_Heidern_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_NeckRoller:
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLstHdrA_Heidern_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_NeckRoller3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_NeckRoller4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_NeckRoller5_A, OBJLstHdrB_Heidern_NeckRoller5_B
	dw OBJLstHdrA_Heidern_NeckRoller6_A, OBJLstHdrB_Heidern_NeckRoller6_B
	dw OBJLstHdrA_Heidern_NeckRoller4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_Crouch0_A, OBJLstHdrB_Heidern_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_StormBringer:
	dw OBJLstHdrA_Heidern_StormBringer0_A, OBJLstHdrB_Heidern_StormBringer0_B
	dw OBJLstHdrA_Heidern_StormBringer1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer3_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_StormBringer2_A, OBJLstHdrB_Heidern_StormBringer2_B
	dw OBJLstHdrA_Heidern_PunchCL1_A, OBJLstHdrB_Heidern_PunchCL1_B
	dw OBJLstHdrA_Heidern_StormBringer1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_MoonSlasher:
	dw OBJLstHdrA_Heidern_MoonSlasher0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_MoonSlasher1_A, OBJLstHdrB_Heidern_StormBringer0_B
	dw OBJLstHdrA_Heidern_MoonSlasher2_A, OBJLstHdrB_Heidern_MoonSlasher2_B
	dw OBJLstHdrA_Heidern_MoonSlasher3_A, OBJLstHdrB_Heidern_MoonSlasher2_B
	dw OBJLstHdrA_Heidern_CrossCutter0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_ThrowG:
	dw OBJLstHdrA_Heidern_ThrowG0_A, OBJLstHdrB_Heidern_PunchLN0_B
	dw OBJLstHdrA_Heidern_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_ThrowG2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Heidern_ThrowG3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Heidern_ThrowA:
	dw OBJLstHdrA_Heidern_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Heidern_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Heidern_Idle0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Idle0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F4,$00 ; $00
	db $1C,$FC,$02 ; $01
	db $24,$04,$04 ; $02
	db $2C,$F4,$06 ; $03
	db $2C,$FC,$08 ; $04
	db $34,$04,$0A ; $05
	db $3C,$F4,$0C ; $06
		
OBJLstHdrA_Heidern_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $30,$F4,$06 ; $03
	db $30,$FC,$08 ; $04
	db $30,$04,$0A ; $05
	db $10,$FC,$0C ; $06
		
OBJLstHdrA_Heidern_WalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$F4,$00 ; $00
	db $19,$FC,$02 ; $01
	db $21,$04,$04 ; $02
	db $29,$F4,$06 ; $03
	db $29,$FC,$08 ; $04
	db $39,$FC,$0A ; $05
		
OBJLstHdrA_Heidern_WalkF2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_WalkF2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
	db $10,$F3,$08 ; $04
		
OBJLstHdrA_Heidern_Crouch0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $28,$04,$04 ; $02
	db $18,$FC,$06 ; $03
		
OBJLstHdrB_Heidern_Crouch0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F4,$00 ; $00
	db $38,$FC,$02 ; $01
	db $38,$04,$04 ; $02
		
OBJLstHdrA_Heidern_JumpN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $20,$EC,$06 ; $03
	db $10,$F4,$08 ; $04
	db $10,$FC,$0A ; $05
		
OBJLstHdrA_Heidern_Strike0_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_JumpN1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Heidern_WalkF2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_WalkF2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
		
OBJLstHdrB_Heidern_Strike0_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_WalkF2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_WalkF2_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_JumpN3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpN3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $18,$04,$04 ; $02
	db $28,$F4,$06 ; $03
	db $28,$FC,$08 ; $04
	db $28,$04,$0A ; $05
		
OBJLstHdrA_Heidern_KickCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpN3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_JumpN3.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_JumpF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $18,$04,$04 ; $02
	db $20,$F4,$06 ; $03
	db $28,$FC,$08 ; $04
	db $28,$04,$0A ; $05
		
OBJLstHdrA_Heidern_JumpF4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $F0 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_Strike1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_JumpF3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1B,$F9,$00 ; $00
	db $1B,$01,$02 ; $01
	db $13,$09,$04 ; $02
	db $2B,$F9,$06 ; $03
	db $2B,$01,$08 ; $04
		
OBJLstHdrA_Heidern_JumpF5:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_JumpF3.bin ; iOBJLstHdrA_DataPtr
	db $F0 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_BlockG0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_BlockG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $38,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
	db $30,$0A,$0C ; $06
		
OBJLstHdrA_Heidern_BlockC0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_BlockC0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $28,$04,$04 ; $02
	db $38,$F4,$06 ; $03
	db $38,$FC,$08 ; $04
	db $38,$04,$0A ; $05
		
OBJLstHdrA_Heidern_Hit0Mid0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Hit0Mid0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F7,$00 ; $00
	db $20,$FF,$02 ; $01
	db $20,$07,$04 ; $02
	db $10,$07,$06 ; $03
		
OBJLstHdrB_Heidern_Hit0Mid0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
	db $30,$04,$04 ; $02
		
OBJLstHdrB_Heidern_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Heidern_LaunchSwoopup2_B: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Heidern_LaunchSwoopup1_B: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_Hit1Mid1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E9,$00 ; $00
	db $20,$F1,$02 ; $01
	db $20,$F9,$04 ; $02
	db $20,$01,$06 ; $03
		
OBJLstHdrA_Heidern_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_LaunchSwoopup2_A: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_LaunchSwoopup1_A: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_HitLow0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_HitLow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$F7,$00 ; $00
	db $26,$FF,$02 ; $01
	db $26,$07,$04 ; $02
	db $3E,$EF,$06 ; $03
	db $36,$F7,$08 ; $04
	db $36,$FF,$0A ; $05
	db $36,$07,$0C ; $06
		
OBJLstHdrA_Heidern_LaunchUB2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_LaunchUB2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EC,$00 ; $00
	db $38,$F4,$02 ; $01
	db $38,$FC,$04 ; $02
		
OBJLstHdrA_Heidern_NeckRoller6_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_LaunchUB2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_NeckRoller5_A.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_NeckRoller5_A:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_LaunchUB2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$D4,$00 ; $00
	db $28,$DC,$02 ; $01
	db $28,$E4,$04 ; $02
		
OBJLstHdrB_Heidern_LaunchUB2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_LaunchUB2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $34,$04,$00 ; $00
	db $34,$0C,$02 ; $01
	db $3C,$14,$04 ; $02
		
OBJLstHdrA_Heidern_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $30,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $30,$0A,$08 ; $04
	db $38,$F2,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Heidern_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchLN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $10,$FA,$08 ; $04
		
OBJLstHdrB_Heidern_PunchLN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
	db $30,$04,$04 ; $02
		
OBJLstHdrB_Heidern_StormBringer2_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_PunchLN0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E9,$00 ; $00
	db $20,$F1,$02 ; $01
	db $20,$F9,$04 ; $02
	db $20,$01,$06 ; $03
	db $10,$F9,$08 ; $04
	
; [TCRF] Unreferenced sprite mapping. Identical to OBJLstHdrA_Heidern_PunchLN1_A except the hitbox is different.
OBJLstHdrA_Heidern_Unused_PunchLN1Alt_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchLN1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
	
OBJLstHdrA_Heidern_PunchLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E3,$00 ; $00
	db $20,$EB,$02 ; $01
	db $20,$F3,$04 ; $02
	db $20,$FB,$06 ; $03
	db $20,$03,$08 ; $04
	db $10,$F3,$0A ; $05
	db $10,$FB,$0C ; $06
		
OBJLstHdrA_Heidern_ThrowG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchLM1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F1,$00 ; $00
	db $20,$F9,$02 ; $01
	db $20,$01,$04 ; $02
	db $30,$F1,$06 ; $03
	db $30,$F9,$08 ; $04
	db $30,$01,$0A ; $05
	db $38,$09,$0C ; $06
	db $10,$F9,$0E ; $07
		
OBJLstHdrA_Heidern_MoonSlasher0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchHN0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchHN3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E4,$00 ; $00
	db $20,$EC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $20,$FC,$06 ; $03
	db $20,$04,$08 ; $04
	db $10,$F4,$0A ; $05
	db $10,$FC,$0C ; $06
		
OBJLstHdrA_Heidern_PunchHN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchHN3_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchHN2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $18,$04,$04 ; $02
	db $28,$F4,$06 ; $03
	db $28,$FC,$08 ; $04
	db $28,$04,$0A ; $05
	db $38,$F4,$0C ; $06
	db $38,$FC,$0E ; $07
	db $38,$04,$10 ; $08
		
OBJLstHdrA_Heidern_ThrowG1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchHN2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_KickLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2E,$EB,$00 ; $00
	db $26,$F3,$02 ; $01
	db $16,$FB,$04 ; $02
	db $1E,$03,$06 ; $03
	db $26,$FB,$08 ; $04
	db $2E,$03,$0A ; $05
	db $1E,$0B,$0C ; $06
	db $3E,$03,$0E ; $07
		
OBJLstHdrA_Heidern_KickLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E1,$00 ; $00
	db $20,$E9,$02 ; $01
	db $20,$F1,$04 ; $02
	db $20,$F9,$06 ; $03
	db $20,$01,$08 ; $04
	db $10,$F9,$0A ; $05
	db $10,$01,$0C ; $06
		
OBJLstHdrB_Heidern_KickLM1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_KickLM1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FA,$00 ; $00
	db $38,$02,$02 ; $01
		
OBJLstHdrA_Heidern_KickHN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickHN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EC,$00 ; $00
	db $18,$F4,$02 ; $01
	db $18,$FC,$04 ; $02
	db $18,$04,$06 ; $03
	db $18,$0C,$08 ; $04
		
OBJLstHdrB_Heidern_KickHN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_KickHN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $38,$FC,$04 ; $02
		
OBJLstHdrA_Heidern_KickHN2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$ED,$00 ; $00
	db $18,$F5,$02 ; $01
	db $18,$FD,$04 ; $02
	db $18,$05,$06 ; $03
	db $28,$F5,$08 ; $04
	db $28,$FD,$0A ; $05
	db $38,$FD,$0C ; $06
	db $30,$ED,$0E ; $07
		
OBJLstHdrB_Heidern_KickHM2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_KickHM2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F9,$00 ; $00
	db $30,$01,$02 ; $01
		
OBJLstHdrA_Heidern_KickHM3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickHM3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $23,$F5,$00 ; $00
	db $1B,$FD,$02 ; $01
	db $1B,$05,$04 ; $02
	db $2B,$FD,$06 ; $03
	db $2B,$05,$08 ; $04
	db $2B,$0D,$0A ; $05
		
OBJLstHdrA_Heidern_ThrowA0: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickHM3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_KickHM3.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E4,$00 ; $00
	db $28,$EC,$02 ; $01
	db $28,$F4,$04 ; $02
	db $28,$FC,$06 ; $03
	db $28,$04,$08 ; $04
	db $18,$F4,$0A ; $05
	db $18,$FC,$0C ; $06
		
OBJLstHdrB_Heidern_PunchCL1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_PunchCL1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F4,$00 ; $00
	db $38,$FC,$02 ; $01
	db $38,$04,$04 ; $02
	db $38,$EC,$06 ; $03
		
OBJLstHdrB_Heidern_ChargeMeter0_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_PunchCL1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_PunchCL1_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchCH1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchCH1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E4,$00 ; $00
	db $28,$EC,$02 ; $01
	db $28,$F4,$04 ; $02
	db $28,$FC,$06 ; $03
	db $18,$F4,$08 ; $04
	db $18,$FC,$0A ; $05
		
OBJLstHdrA_Heidern_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $38,$F4,$04 ; $02
	db $20,$FC,$06 ; $03
	db $20,$04,$08 ; $04
	db $30,$FC,$0A ; $05
	db $30,$04,$0C ; $06
	db $38,$0C,$0E ; $07
		
OBJLstHdrA_Heidern_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $35,$E9,$00 ; $00
	db $2D,$F1,$02 ; $01
	db $25,$F9,$04 ; $02
	db $25,$01,$06 ; $03
	db $25,$09,$08 ; $04
	db $35,$F9,$0A ; $05
	db $35,$01,$0C ; $06
	db $35,$09,$0E ; $07
		
OBJLstHdrA_Heidern_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EB,$00 ; $00
	db $20,$F3,$02 ; $01
	db $30,$F3,$04 ; $02
	db $20,$FB,$06 ; $03
	db $30,$FB,$08 ; $04
	db $28,$03,$0A ; $05
	db $30,$0B,$0C ; $06
		
OBJLstHdrA_Heidern_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1F,$EC,$00 ; $00
	db $0F,$F4,$02 ; $01
	db $17,$FC,$04 ; $02
	db $1F,$04,$06 ; $03
	db $1F,$F4,$08 ; $04
	db $27,$FC,$0A ; $05
	db $2F,$04,$0C ; $06
		
OBJLstHdrA_Heidern_ThrowG2:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_PunchAHI0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_PunchALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $28,$F2,$08 ; $04
	db $28,$FA,$0A ; $05
	db $28,$02,$0C ; $06
		
OBJLstHdrA_Heidern_PunchAHX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $32,$E4,$00 ; $00
	db $2A,$EC,$02 ; $01
	db $2A,$F4,$04 ; $02
	db $2A,$FC,$06 ; $03
	db $2A,$04,$08 ; $04
	db $32,$0C,$0A ; $05
	db $1A,$FC,$0C ; $06
	
; [TCRF] Unreferenced sprite mapping. Identical to OBJLstHdrA_Heidern_PunchAHX0 except shifted up by 16px and left by 8px.
OBJLstHdrA_Heidern_Unused_PunchAHXAlt0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_PunchAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2A,$D4,$00 ; $00
	db $22,$DC,$02 ; $01
	db $22,$E4,$04 ; $02
	db $22,$EC,$06 ; $03
	db $22,$F4,$08 ; $04
	db $2A,$FC,$0A ; $05
	db $12,$EC,$0C ; $06

OBJLstHdrB_Heidern_KickALI0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_KickALI0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
		
OBJLstHdrA_Heidern_KickALI1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickALI1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$EC,$00 ; $00
	db $18,$F4,$02 ; $01
	db $18,$FC,$04 ; $02
	db $18,$04,$06 ; $03
	db $10,$0C,$08 ; $04
	db $28,$F4,$0A ; $05
	db $28,$FC,$0C ; $06
		
OBJLstHdrB_Heidern_KickAHI3_B: ;X
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_KickAHI3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
	db $38,$F4,$06 ; $03
		
OBJLstHdrA_Heidern_KickALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $17,$EC,$00 ; $00
	db $17,$F4,$02 ; $01
	db $17,$FC,$04 ; $02
	db $27,$EC,$06 ; $03
	db $27,$F4,$08 ; $04
	db $27,$FC,$0A ; $05
	db $27,$04,$0C ; $06
		
OBJLstHdrA_Heidern_ThrowG3:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Heidern_KickALX0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_KickAHX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_KickAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2E,$E3,$00 ; $00
	db $26,$EB,$02 ; $01
	db $16,$F3,$04 ; $02
	db $16,$FB,$06 ; $03
	db $16,$03,$08 ; $04
	db $26,$F3,$0A ; $05
	db $26,$FB,$0C ; $06
	db $26,$03,$0E ; $07
		
OBJLstHdrA_Heidern_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1A,$F4,$00 ; $00
	db $1A,$FC,$02 ; $01
	db $22,$04,$04 ; $02
	db $2A,$F4,$06 ; $03
	db $2A,$FC,$08 ; $04
	db $32,$04,$0A ; $05
	db $3A,$F4,$0C ; $06
		
OBJLstHdrA_Heidern_DodgeCounter2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_DodgeCounter2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EC,$00 ; $00
	db $20,$EC,$02 ; $01
	db $28,$E4,$04 ; $02
	db $38,$E4,$06 ; $03
		
OBJLstHdrB_Heidern_DodgeCounter2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_DodgeCounter2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $38,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $20,$04,$06 ; $03
	db $30,$FC,$08 ; $04
	db $30,$04,$0A ; $05
		
OBJLstHdrA_Heidern_DodgeCounter3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_DodgeCounter3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EC,$00 ; $00
		
OBJLstHdrA_Heidern_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FC,$00 ; $00
	db $18,$04,$02 ; $01
	db $28,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $28,$0C,$08 ; $04
		
OBJLstHdrA_Heidern_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FC,$00 ; $00
	db $18,$04,$02 ; $01
	db $28,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $28,$0C,$08 ; $04
		
OBJLstHdrB_Heidern_AttackA1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_AttackA1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F6,$00 ; $00
	db $28,$FE,$02 ; $01
	db $38,$FE,$04 ; $02
		
OBJLstHdrA_Heidern_Strike2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Strike2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $28,$0C,$08 ; $04
	db $28,$14,$0A ; $05
	db $38,$04,$0C ; $06
	db $38,$0C,$0E ; $07
		
OBJLstHdrA_Heidern_Intro0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Intro0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $10,$FC,$04 ; $02
	db $10,$F4,$06 ; $03
		
OBJLstHdrB_Heidern_Intro0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_Intro0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$04,$00 ; $00
	db $30,$F4,$02 ; $01
	db $30,$FC,$04 ; $02
	db $30,$04,$06 ; $03
		
OBJLstHdrA_Heidern_Intro1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Intro1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $10,$FC,$04 ; $02
	db $10,$F4,$06 ; $03
		
OBJLstHdrA_Heidern_Intro2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Intro2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$EC,$04 ; $02
	db $10,$F4,$06 ; $03
	db $10,$FC,$08 ; $04
		
OBJLstHdrA_Heidern_Taunt0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Taunt0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $23,$F2,$00 ; $00
	db $1B,$FA,$02 ; $01
	db $1B,$02,$04 ; $02
	db $2B,$FA,$06 ; $03
	db $2B,$02,$08 ; $04
	db $3B,$FA,$0A ; $05
	db $3B,$02,$0C ; $06
		
OBJLstHdrA_Heidern_Win0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Win0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $10,$FC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $10,$F4,$06 ; $03
		
OBJLstHdrA_Heidern_Win1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Win1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $10,$FC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $10,$F4,$06 ; $03
		
OBJLstHdrA_Heidern_Win2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_Win2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $10,$FC,$02 ; $01
	db $10,$F4,$04 ; $02
	db $20,$F4,$06 ; $03
		
OBJLstHdrA_Heidern_CrossCutter0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_CrossCutter0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $28,$03,$04 ; $02
	db $30,$F3,$06 ; $03
	db $30,$FB,$08 ; $04
	db $38,$03,$0A ; $05
		
OBJLstHdrA_Heidern_CrossCutter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_CrossCutter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $10,$F4,$06 ; $03
	db $10,$FC,$08 ; $04
		
OBJLstHdrA_Heidern_CrossCutter2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_CrossCutter2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $10,$FC,$06 ; $03
	db $10,$04,$08 ; $04
		
OBJLstHdrA_Heidern_CrossCutter3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_CrossCutter3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$04,$02 ; $01
	db $10,$FC,$04 ; $02
	db $10,$04,$06 ; $03
		
OBJLstHdrA_Heidern_NeckRoller3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_NeckRoller3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $18,$F4,$06 ; $03
	db $10,$FC,$08 ; $04
	db $10,$04,$0A ; $05
	db $08,$0C,$0C ; $06
		
OBJLstHdrA_Heidern_NeckRoller4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_NeckRoller4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$F0,$00 ; $00
	db $14,$F8,$02 ; $01
	db $14,$00,$04 ; $02
	db $14,$08,$06 ; $03
	db $24,$F8,$08 ; $04
	db $24,$00,$0A ; $05
	db $34,$00,$0C ; $06
	db $34,$08,$0E ; $07
		
OBJLstHdrB_Heidern_NeckRoller5_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_NeckRoller5_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
		
OBJLstHdrB_Heidern_NeckRoller6_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_NeckRoller5_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Heidern_NeckRoller5_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Heidern_StormBringer0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_StormBringer0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$FC,$00 ; $00
	db $10,$04,$02 ; $01
		
OBJLstHdrB_Heidern_StormBringer0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_StormBringer0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F8,$00 ; $00
	db $20,$00,$02 ; $01
	db $20,$08,$04 ; $02
	db $30,$F0,$06 ; $03
	db $30,$F8,$08 ; $04
	db $30,$00,$0A ; $05
	db $38,$08,$0C ; $06
		
OBJLstHdrA_Heidern_StormBringer1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_StormBringer1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$04,$02 ; $01
	db $18,$0C,$04 ; $02
	db $30,$F4,$06 ; $03
	db $30,$FC,$08 ; $04
	db $30,$04,$0A ; $05
		
OBJLstHdrA_Heidern_StormBringer2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_StormBringer2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $20,$04,$06 ; $03
	db $10,$F4,$08 ; $04
	db $10,$FC,$0A ; $05
		
OBJLstHdrA_Heidern_StormBringer3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_StormBringer3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $20,$04,$06 ; $03
	db $10,$F4,$08 ; $04
	db $10,$FC,$0A ; $05
		
OBJLstHdrA_Heidern_MoonSlasher1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_21 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_MoonSlasher1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F5,$00 ; $00
	db $10,$FD,$02 ; $01
	db $10,$05,$04 ; $02
	db $18,$0D,$06 ; $03
	db $28,$0D,$08 ; $04
	db $10,$ED,$0A ; $05
		
OBJLstHdrA_Heidern_MoonSlasher2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_22 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_MoonSlasher2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E4,$00 ; $00
	db $18,$E4,$02 ; $01
	db $18,$EC,$04 ; $02
	db $10,$F4,$06 ; $03
	db $20,$F4,$08 ; $04
	db $30,$F4,$0A ; $05
	db $08,$FC,$0C ; $06
	db $18,$FC,$0E ; $07
	db $28,$EC,$10 ; $08
		
OBJLstHdrB_Heidern_MoonSlasher2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Heidern_MoonSlasher2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$FC,$00 ; $00
	db $2A,$04,$02 ; $01
	db $32,$FC,$04 ; $02
	db $3A,$04,$06 ; $03
		
OBJLstHdrA_Heidern_MoonSlasher3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Heidern_MoonSlasher3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $30,$F4,$02 ; $01
	db $30,$EC,$04 ; $02
	db $28,$E4,$06 ; $03
	db $20,$EC,$08 ; $04