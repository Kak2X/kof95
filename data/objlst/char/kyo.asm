OBJLstPtrTable_Kyo_Idle:
	dw OBJLstHdrA_Kyo_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Idle3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_WalkF:
	dw OBJLstHdrA_Kyo_WalkF0_A, OBJLstHdrB_Kyo_WalkF0_B
	dw OBJLstHdrA_Kyo_WalkF1_A, OBJLstHdrB_Kyo_WalkF1_B
	dw OBJLstHdrA_Kyo_Idle3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_WalkB:
	dw OBJLstHdrA_Kyo_Idle3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_WalkF1_A, OBJLstHdrB_Kyo_WalkF1_B
	dw OBJLstHdrA_Kyo_WalkF0_A, OBJLstHdrB_Kyo_WalkF0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Crouch:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_JumpN:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_JumpF:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpF2_A, OBJLstHdrB_Kyo_JumpF2_B
	dw OBJLstHdrA_Kyo_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpF4_A, OBJLstHdrB_Kyo_JumpF4_B
	dw OBJLstHdrA_Kyo_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_JumpB:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpF4_A, OBJLstHdrB_Kyo_JumpF4_B
	dw OBJLstHdrA_Kyo_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpF2_A, OBJLstHdrB_Kyo_JumpF2_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_BlockG:
	dw OBJLstHdrA_Kyo_BlockG0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_BlockC:
	dw OBJLstHdrA_Kyo_BlockC0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_HopF:
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_HopB:
	dw OBJLstHdrA_Kyo_HopB0_A, OBJLstHdrB_Kyo_HopB0_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_ChargeMeter:
	dw OBJLstHdrA_Kyo_ChargeMeter0_A, OBJLstHdrB_Kyo_ChargeMeter0_B
	dw OBJLstHdrA_Kyo_ChargeMeter1_A, OBJLstHdrB_Kyo_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Intro:
	dw OBJLstHdrA_Kyo_Intro0_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro2_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro3_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro4, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Taunt:
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Taunt1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Taunt1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Taunt1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Win:
	dw OBJLstHdrA_Kyo_Win0_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Win1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Win2_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Taunt1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchLN:
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_PunchLN1_A, OBJLstHdrB_Kyo_PunchLN1_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchLM:
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_PunchLM1_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchHN:
	dw OBJLstHdrA_Kyo_PunchHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchHN2_A, OBJLstHdrB_Kyo_PunchHN2_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchHM:
	dw OBJLstHdrA_Kyo_PunchHM0_A, OBJLstHdrB_Kyo_PunchHM0_B
	dw OBJLstHdrA_Kyo_PunchHM1_A, OBJLstHdrB_Kyo_PunchHN2_B
	dw OBJLstHdrA_Kyo_PunchHN2_A, OBJLstHdrB_Kyo_PunchHN2_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickLN:
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_KickLN1_A, OBJLstHdrB_Kyo_KickLN1_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickLM:
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_KickLM1_A, OBJLstHdrB_Kyo_KickLN1_B
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickHN:
	dw OBJLstHdrA_Kyo_PunchLN0_A, OBJLstHdrB_Kyo_PunchLN0_B
	dw OBJLstHdrA_Kyo_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickHN2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickHM:
	dw OBJLstHdrA_Kyo_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickHM1_A, OBJLstHdrB_Kyo_KickHM1_B
	dw OBJLstHdrA_Kyo_KickHM2_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchCL:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_PunchCL1_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchCH:
	dw OBJLstHdrA_Kyo_PunchCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickCL:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_KickCL1_A, OBJLstHdrB_Kyo_KickCL1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickCH:
	dw OBJLstHdrA_Kyo_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickCH1_A, OBJLstHdrB_Kyo_KickCH1_B
	dw OBJLstHdrA_Kyo_KickCH2_A, OBJLstHdrB_Kyo_KickCH1_B
	dw OBJLstHdrA_Kyo_KickCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchALI:
	dw OBJLstHdrA_Kyo_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchAHI:
	dw OBJLstHdrA_Kyo_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchALX:
	dw OBJLstHdrA_Kyo_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickALI:
	dw OBJLstHdrA_Kyo_KickALI0_A, OBJLstHdrB_Kyo_KickALI0_B
	dw OBJLstHdrA_Kyo_KickALI0_A, OBJLstHdrB_Kyo_KickALI0_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickAHI:
	dw OBJLstHdrA_Kyo_KickAHI0_A, OBJLstHdrB_Kyo_KickAHI0_B
	dw OBJLstHdrA_Kyo_KickAHI0_A, OBJLstHdrB_Kyo_KickAHI0_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickALX:
	dw OBJLstHdrA_Kyo_KickALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickAHX:
	dw OBJLstHdrA_Kyo_KickAHX0_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_KickAHX0_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_AttackA:
	dw OBJLstHdrA_Kyo_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN3_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Strike:
	dw OBJLstHdrA_Kyo_BlockG0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_PunchHM0_A, OBJLstHdrB_Kyo_PunchHM0_B
	dw OBJLstHdrA_Kyo_Strike2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Dodge:
	dw OBJLstHdrA_Kyo_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_DodgeCounter:
	dw OBJLstHdrA_Kyo_DodgeCounter0_A, OBJLstHdrB_Kyo_DodgeCounter0_B
	dw OBJLstHdrA_Kyo_DodgeCounter0_A, OBJLstHdrB_Kyo_DodgeCounter0_B
	dw OBJLstHdrA_Kyo_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Hit0Mid:
	dw OBJLstHdrA_Kyo_Hit0Mid0_A, OBJLstHdrB_Kyo_HopB0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Dizzy:
	dw OBJLstHdrA_Kyo_Hit0Mid0_A, OBJLstHdrB_Kyo_HopB0_B
OBJLstPtrTable_Kyo_LostTimeover:
	dw OBJLstHdrA_Kyo_HopB0_A, OBJLstHdrB_Kyo_HopB0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_HitLow:
	dw OBJLstHdrA_Kyo_HitLow0_A, OBJLstHdrB_Kyo_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_LaunchUBRec:
	dw OBJLstHdrA_Kyo_Hit0Mid0_A, OBJLstHdrB_Kyo_HopB0_B
	dw OBJLstHdrA_Kyo_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpF4_A, OBJLstHdrB_Kyo_JumpF4_B
	dw OBJLstHdrA_Kyo_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpF2_A, OBJLstHdrB_Kyo_JumpF2_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_LaunchUB:
	dw OBJLstHdrA_Kyo_Hit0Mid0_A, OBJLstHdrB_Kyo_HopB0_B
	dw OBJLstHdrA_Kyo_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_LaunchSwoopup:
	dw OBJLstHdrA_Kyo_HopB0_A, OBJLstHdrB_Kyo_HopB0_B ;X
	dw OBJLstHdrA_Kyo_LaunchSwoopup1_A, OBJLstHdrB_Kyo_LaunchSwoopup1_B ;X
	dw OBJLstHdrA_Kyo_LaunchSwoopup2_A, OBJLstHdrB_Kyo_LaunchSwoopup2_B ;X
OBJLstPtrTable_Kyo_LaunchDBShake:
	dw OBJLstHdrA_Kyo_LaunchDBShake3_A, OBJLstHdrB_Kyo_LaunchDBShake3_B
	dw OBJLstHdrA_Kyo_LaunchDBShake3_A, OBJLstHdrB_Kyo_LaunchDBShake3_B
	dw OBJLstHdrA_Kyo_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_HitSweep:
	dw OBJLstHdrA_Kyo_HopB0_A, OBJLstHdrB_Kyo_HopB0_B ;X
	dw OBJLstHdrA_Kyo_LaunchUB1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kyo_LaunchUB2, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_GrabUBNoSync:
	dw OBJLstHdrA_Kyo_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Wakeup:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_YamiBarai:
	dw OBJLstHdrA_Kyo_PunchHM0_A, OBJLstHdrB_Kyo_PunchHM0_B
	dw OBJLstHdrA_Kyo_YamiBarai1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_YamiBarai2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_YamiBarai2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_OniYaki:
	dw OBJLstHdrA_Kyo_OniYaki0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_OniYaki1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_OniYaki2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_OniYaki3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_OboroGuruma:
	dw OBJLstHdrA_Kyo_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickHM1_A, OBJLstHdrB_Kyo_KickHM1_B
	dw OBJLstHdrA_Kyo_KickAHX0_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickAHX0_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickAHX0_A, OBJLstHdrB_Kyo_KickHM2_B
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KototsukiYou:
	dw OBJLstHdrA_Kyo_PunchHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KototsukiYou1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KototsukiYou2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KototsukiYou3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Idle3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_OniYaki0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KototsukiYou6, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_Kai:
	dw OBJLstHdrA_Kyo_Kai0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Kai1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B
	dw OBJLstHdrA_Kyo_Kai3_A, OBJLstHdrB_Kyo_KickALI0_B
	dw OBJLstHdrA_Kyo_Kai0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_UraOrochiNagi:
	dw OBJLstHdrA_Kyo_Intro1_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro2_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro3_A, OBJLstHdrB_Kyo_Intro0_B
	dw OBJLstHdrA_Kyo_Intro4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_UraOrochiNagi4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_UraOrochiNagi5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_UraOrochiNagi6, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickFH:
	dw OBJLstHdrA_Kyo_Kai0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickFH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickFH2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Kai0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_KickFCH:
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_KickCL1_A, OBJLstHdrB_Kyo_KickFCH1_B
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLstHdrA_Kyo_KickFCH3_A, OBJLstHdrB_Kyo_KickFCH3_B
	dw OBJLstHdrA_Kyo_KickFCH4_A, OBJLstHdrB_Kyo_KickFCH3_B
	dw OBJLstHdrA_Kyo_KickFCH3_A, OBJLstHdrB_Kyo_KickFCH3_B
	dw OBJLstHdrA_Kyo_KickFCH6, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_PunchAHD:
	dw OBJLstHdrA_Kyo_PunchAHD0_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_PunchAHD1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kyo_PunchAHD1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kyo_JumpN1_A, OBJLstHdrB_Kyo_JumpN1_B ;X
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kyo_ThrowG:
	dw OBJLstHdrA_Kyo_ThrowG0_A, OBJLstHdrB_Kyo_ThrowG0_B
	dw OBJLstHdrA_Kyo_ThrowG1_A, OBJLstHdrB_Kyo_ThrowG1_B
	dw OBJLstHdrA_Kyo_ThrowG2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_ThrowG3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_ThrowG4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kyo_Crouch0_A, OBJLstHdrB_Kyo_Crouch0_B
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Kyo_Idle0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Idle0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kyo_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Kyo_Idle3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Idle3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $30,$02,$04 ; $02
	db $20,$F2,$06 ; $03
	db $20,$FA,$08 ; $04
	db $20,$02,$0A ; $05
		
OBJLstHdrA_Kyo_WalkF0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_WalkF0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $10,$FA,$06 ; $03
		
OBJLstHdrA_Kyo_WalkF1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_WalkF0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F1,$00 ; $00
	db $20,$F9,$02 ; $01
	db $20,$01,$04 ; $02
	db $10,$F9,$06 ; $03
		
OBJLstHdrB_Kyo_WalkF0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_WalkF0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
		
OBJLstHdrB_Kyo_WalkF1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
		
OBJLstHdrA_Kyo_Crouch0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrB_Kyo_Crouch0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Kyo_JumpN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_KickHM1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_KickHM1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F6,$00 ; $00
	db $1C,$FE,$02 ; $01
	db $1C,$06,$04 ; $02
		
OBJLstHdrB_Kyo_JumpN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_JumpN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$FF,$00 ; $00
	db $2C,$F7,$02 ; $01
	db $3C,$FF,$04 ; $02
		
OBJLstHdrB_Kyo_JumpN3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_JumpN3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$F7,$00 ; $00
	db $2C,$FF,$02 ; $01
		
OBJLstHdrB_Kyo_KickHM1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_JumpN3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Kyo_JumpN3_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_JumpF2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpF2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F2,$00 ; $00
	db $1C,$FA,$02 ; $01
	db $1C,$02,$04 ; $02
	db $2C,$F2,$06 ; $03
		
OBJLstHdrA_Kyo_JumpF4_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpF2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_JumpF2_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_ThrowG1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpF2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $1C,$FE,$04 ; $02
	db $2C,$EE,$06 ; $03
		
OBJLstHdrB_Kyo_JumpF2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_JumpF2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$FA,$00 ; $00
	db $2C,$02,$02 ; $01
	db $3C,$02,$04 ; $02
		
OBJLstHdrB_Kyo_JumpF4_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_JumpF2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Kyo_JumpF2_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_JumpF3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F8,$00 ; $00
	db $1C,$00,$02 ; $01
	db $2C,$F8,$04 ; $02
	db $2C,$00,$06 ; $03
		
OBJLstHdrA_Kyo_JumpF5:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_JumpF3.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_BlockG0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_BlockG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $38,$F2,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Kyo_BlockC0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_BlockC0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrA_Kyo_PunchLN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Kyo_ThrowG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_PunchLN0_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Kyo_PunchLN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $30,$02,$04 ; $02
		
OBJLstHdrB_Kyo_PunchLN1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
	db $30,$06,$04 ; $02
		
OBJLstHdrA_Kyo_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
		
OBJLstHdrA_Kyo_PunchLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
		
OBJLstHdrA_Kyo_DodgeCounter0_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FD,$00 ; $00
	db $20,$05,$02 ; $01
	db $20,$0D,$04 ; $02
	db $20,$15,$06 ; $03
		
OBJLstHdrA_Kyo_PunchHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
	db $30,$05,$04 ; $02
	db $28,$F5,$06 ; $03
	db $20,$FD,$08 ; $04
	db $20,$05,$0A ; $05
	db $38,$F5,$0C ; $06
		
OBJLstHdrA_Kyo_PunchHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Kyo_PunchHN2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchHN2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $10,$EE,$06 ; $03
	db $10,$F6,$08 ; $04
		
OBJLstHdrB_Kyo_PunchHN2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_PunchHN2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
	db $38,$04,$04 ; $02
		
OBJLstHdrB_Kyo_PunchHM0_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_PunchHN2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
	db $38,$05,$04 ; $02
		
OBJLstHdrA_Kyo_PunchHM0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchHM0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F9,$00 ; $00
	db $20,$01,$02 ; $01
	db $10,$F9,$04 ; $02
	db $10,$01,$06 ; $03
		
OBJLstHdrA_Kyo_PunchHM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchHM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E6,$00 ; $00
	db $20,$EE,$02 ; $01
	db $20,$F6,$04 ; $02
	db $20,$FE,$06 ; $03
		
OBJLstHdrA_Kyo_KickLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $30,$EA,$02 ; $01
	db $38,$E2,$04 ; $02
	db $38,$F2,$06 ; $03
		
OBJLstHdrB_Kyo_KickLN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickLN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
		
OBJLstHdrA_Kyo_KickLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $28,$EA,$02 ; $01
	db $28,$F2,$04 ; $02
	db $38,$F2,$06 ; $03
		
OBJLstHdrA_Kyo_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2B,$E2,$00 ; $00
	db $23,$EA,$02 ; $01
	db $1B,$F2,$04 ; $02
	db $1B,$FA,$06 ; $03
	db $2B,$F2,$08 ; $04
	db $2B,$FA,$0A ; $05
	db $3B,$F2,$0C ; $06
		
OBJLstHdrA_Kyo_KickHN2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $18,$FF,$04 ; $02
	db $30,$F7,$06 ; $03
	db $28,$FF,$08 ; $04
	db $10,$F7,$0A ; $05
	db $38,$EF,$0C ; $06
		
OBJLstHdrA_Kyo_KickHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F5,$00 ; $00
	db $18,$FD,$02 ; $01
	db $20,$05,$04 ; $02
	db $28,$F5,$06 ; $03
	db $28,$FD,$08 ; $04
	db $38,$F5,$0A ; $05
	db $38,$FD,$0C ; $06
		
OBJLstHdrA_Kyo_KickHM2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickHM2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$E6,$00 ; $00
	db $24,$EE,$02 ; $01
	db $24,$F6,$04 ; $02
		
OBJLstHdrB_Kyo_KickHM2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickHM2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $14,$EE,$00 ; $00
	db $14,$F6,$02 ; $01
	db $14,$FE,$04 ; $02
	db $24,$FE,$06 ; $03
	db $34,$F6,$08 ; $04
	db $34,$FE,$0A ; $05
		
OBJLstHdrA_Kyo_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E9,$00 ; $00
	db $28,$F1,$02 ; $01
	db $28,$F9,$04 ; $02
	db $28,$01,$06 ; $03
	db $18,$F9,$08 ; $04
		
OBJLstHdrA_Kyo_PunchCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E9,$00 ; $00
	db $20,$F1,$02 ; $01
	db $20,$F9,$04 ; $02
	db $28,$01,$06 ; $03
	db $30,$F1,$08 ; $04
	db $30,$F9,$0A ; $05
	db $38,$01,$0C ; $06
		
OBJLstHdrA_Kyo_PunchCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$EC,$00 ; $00
	db $18,$F4,$02 ; $01
	db $20,$EC,$04 ; $02
	db $20,$FC,$06 ; $03
	db $28,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
	db $38,$F4,$0C ; $06
	db $30,$EC,$0E ; $07
	db $10,$E4,$10 ; $08
		
OBJLstHdrA_Kyo_KickCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $18,$F9,$06 ; $03
	db $28,$E9,$08 ; $04
		
OBJLstHdrA_Kyo_KickAHI0_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_KickCL1_A.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Kyo_KickCL1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickCL1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $38,$F2,$02 ; $01
	db $38,$FA,$04 ; $02
	db $38,$02,$06 ; $03
		
OBJLstHdrA_Kyo_KickCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F0,$00 ; $00
	db $28,$F8,$02 ; $01
	db $28,$00,$04 ; $02
	db $38,$F8,$06 ; $03
	db $38,$00,$08 ; $04
	db $38,$08,$0A ; $05
		
OBJLstHdrA_Kyo_KickCH1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickCH1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$E2,$00 ; $00
	db $30,$EA,$02 ; $01
	db $28,$F2,$04 ; $02
	db $38,$F2,$06 ; $03
		
OBJLstHdrB_Kyo_KickCH1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickCH1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $38,$FA,$04 ; $02
	db $38,$02,$06 ; $03
	db $38,$0A,$08 ; $04
		
OBJLstHdrA_Kyo_KickCH2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickCH2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$F2,$00 ; $00
	db $36,$F2,$02 ; $01
	db $2E,$EA,$04 ; $02
	db $36,$E2,$06 ; $03
		
OBJLstHdrA_Kyo_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1F,$F1,$00 ; $00
	db $1F,$F9,$02 ; $01
	db $1F,$01,$04 ; $02
	db $2F,$01,$06 ; $03
	db $27,$09,$08 ; $04
		
OBJLstHdrA_Kyo_ThrowG4:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_PunchALI0.bin ; iOBJLstHdrA_DataPtr
	db $10 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2B,$EA,$00 ; $00
	db $13,$F2,$02 ; $01
	db $1B,$FA,$04 ; $02
	db $1B,$02,$06 ; $03
	db $23,$F2,$08 ; $04
	db $2B,$FA,$0A ; $05
	db $2B,$02,$0C ; $06
		
OBJLstHdrA_Kyo_PunchALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $1C,$FE,$04 ; $02
	db $24,$06,$06 ; $03
	db $24,$0E,$08 ; $04
	db $2C,$F6,$0A ; $05
	db $2C,$FE,$0C ; $06
		
OBJLstHdrA_Kyo_ThrowG3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_PunchALX0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_KickALI0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickALI0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$EE,$00 ; $00
	db $24,$F6,$02 ; $01
	db $24,$FE,$04 ; $02
	db $14,$F6,$06 ; $03
		
OBJLstHdrB_Kyo_KickALI0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickALI0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $14,$FE,$00 ; $00
	db $1C,$06,$02 ; $01
	db $34,$FE,$04 ; $02
	db $34,$06,$06 ; $03
	db $0C,$F6,$08 ; $04
		
OBJLstHdrB_Kyo_KickAHI0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickAHI0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $04 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$EE,$00 ; $00
	db $2C,$F6,$02 ; $01
	db $2C,$FE,$04 ; $02
	db $2C,$06,$06 ; $03
		
OBJLstHdrA_Kyo_KickALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F6,$00 ; $00
	db $1C,$FE,$02 ; $01
	db $1C,$06,$04 ; $02
	db $2C,$F6,$06 ; $03
	db $2C,$FE,$08 ; $04
	db $2C,$06,$0A ; $05
		
OBJLstHdrA_Kyo_KickFCH6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_KickALX0.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_KickAHX0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickAHX0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$E6,$00 ; $00
	db $24,$EE,$02 ; $01
	db $24,$F6,$04 ; $02
	db $34,$F6,$06 ; $03
		
OBJLstHdrA_Kyo_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $14,$F4,$00 ; $00
	db $14,$FC,$02 ; $01
	db $1C,$04,$04 ; $02
	db $24,$F4,$06 ; $03
	db $24,$FC,$08 ; $04
	db $2C,$04,$0A ; $05
	db $14,$0C,$0C ; $06
		
OBJLstHdrA_Kyo_Strike2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Strike2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $20,$FF,$04 ; $02
	db $30,$EF,$06 ; $03
	db $30,$F7,$08 ; $04
	db $30,$FF,$0A ; $05
	db $38,$07,$0C ; $06
		
OBJLstHdrA_Kyo_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F9,$00 ; $00
	db $28,$01,$02 ; $01
	db $28,$09,$04 ; $02
	db $18,$01,$06 ; $03
	db $18,$09,$08 ; $04
		
OBJLstHdrB_Kyo_ChargeMeter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
	db $38,$0A,$06 ; $03
		
OBJLstHdrA_Kyo_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F9,$00 ; $00
	db $28,$01,$02 ; $01
	db $28,$09,$04 ; $02
	db $18,$01,$06 ; $03
	db $18,$09,$08 ; $04
		
OBJLstHdrA_Kyo_Intro0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Intro0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FB,$00 ; $00
	db $28,$03,$02 ; $01
	db $18,$FB,$04 ; $02
	db $18,$03,$06 ; $03
		
OBJLstHdrB_Kyo_Intro0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_Intro0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Kyo_Intro1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Intro1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $28,$04,$04 ; $02
	db $18,$FC,$06 ; $03
	db $18,$04,$08 ; $04
		
OBJLstHdrA_Kyo_Intro2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Intro2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F2,$00 ; $00
	db $20,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $18,$FA,$08 ; $04
	db $18,$02,$0A ; $05
	db $20,$0A,$0C ; $06
		
OBJLstHdrA_Kyo_Intro3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Intro3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F2,$00 ; $00
	db $20,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $20,$0A,$08 ; $04
	db $18,$FA,$0A ; $05
	db $18,$02,$0C ; $06
		
OBJLstHdrA_Kyo_Intro4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Intro4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F8,$00 ; $00
	db $30,$00,$02 ; $01
	db $30,$08,$04 ; $02
	db $20,$F8,$06 ; $03
	db $20,$00,$08 ; $04
	db $20,$08,$0A ; $05
		
OBJLstHdrA_Kyo_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
		
OBJLstHdrA_Kyo_Win0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Win0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kyo_Win1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Win1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
		
OBJLstHdrA_Kyo_Win2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Win2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
		
OBJLstHdrA_Kyo_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F1,$00 ; $00
	db $30,$F9,$02 ; $01
	db $20,$E9,$04 ; $02
	db $28,$F1,$06 ; $03
	db $20,$F9,$08 ; $04
	db $38,$F1,$0A ; $05
		
OBJLstHdrB_Kyo_DodgeCounter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_DodgeCounter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EC,$00 ; $00
	db $30,$F4,$02 ; $01
	db $38,$E4,$04 ; $02
		
OBJLstHdrA_Kyo_HopB0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_HopB0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Kyo_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_HopB0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_HopB0_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_LaunchSwoopup2_A: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_HopB0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_HopB0_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_LaunchSwoopup1_A: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_HopB0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_HopB0_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_Hit0Mid0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Hit0Mid0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrB_Kyo_HopB0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_HopB0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $30,$02,$04 ; $02
		
OBJLstHdrB_Kyo_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_HopB0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Kyo_HopB0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Kyo_LaunchSwoopup2_B: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_HopB0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Kyo_HopB0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Kyo_LaunchSwoopup1_B: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_HopB0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Kyo_HopB0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kyo_HitLow0_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_HitLow0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
		
OBJLstHdrA_Kyo_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $3B,$EA,$00 ; $00
	db $33,$F2,$02 ; $01
	db $33,$FA,$04 ; $02
	db $33,$02,$06 ; $03
	db $33,$0A,$08 ; $04
		
OBJLstHdrA_Kyo_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$0A,$06 ; $03
	db $38,$F2,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Kyo_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kyo_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Kyo_ThrowG0_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_ThrowG0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F8,$00 ; $00
	db $30,$00,$02 ; $01
	db $38,$08,$04 ; $02
		
OBJLstHdrB_Kyo_ThrowG1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_ThrowG1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
	db $38,$06,$04 ; $02
		
OBJLstHdrA_Kyo_ThrowG2:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_ThrowG2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $29,$EB,$00 ; $00
	db $21,$F3,$02 ; $01
	db $29,$FB,$04 ; $02
	db $31,$03,$06 ; $03
	db $31,$F3,$08 ; $04
	db $39,$FB,$0A ; $05
		
OBJLstHdrA_Kyo_YamiBarai1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_YamiBarai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $18,$FA,$0A ; $05
	db $18,$02,$0C ; $06
		
OBJLstHdrA_Kyo_UraOrochiNagi4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_YamiBarai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F7,$00 ; $00
	db $38,$FF,$02 ; $01
	db $38,$07,$04 ; $02
	db $28,$FF,$06 ; $03
	db $28,$07,$08 ; $04
	db $18,$FF,$0A ; $05
	db $18,$07,$0C ; $06
		
OBJLstHdrA_Kyo_YamiBarai2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_YamiBarai2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EB,$00 ; $00
	db $30,$F3,$02 ; $01
	db $30,$FB,$04 ; $02
	db $38,$03,$06 ; $03
	db $20,$F3,$08 ; $04
	db $20,$FB,$0A ; $05
	db $28,$03,$0C ; $06
	db $18,$03,$0E ; $07
		
OBJLstHdrA_Kyo_OniYaki0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_OniYaki0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F1,$00 ; $00
	db $30,$F9,$02 ; $01
	db $30,$01,$04 ; $02
	db $38,$09,$06 ; $03
	db $20,$F1,$08 ; $04
	db $20,$F9,$0A ; $05
	db $20,$01,$0C ; $06
		
OBJLstHdrA_Kyo_OniYaki1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_OniYaki1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$E8,$00 ; $00
	db $1C,$F0,$02 ; $01
	db $1C,$F8,$04 ; $02
	db $1C,$00,$06 ; $03
	db $1C,$08,$08 ; $04
	db $2C,$E8,$0A ; $05
	db $2C,$F0,$0C ; $06
	db $2C,$F8,$0E ; $07
	db $2C,$00,$10 ; $08
	db $3C,$F8,$12 ; $09
		
OBJLstHdrA_Kyo_OniYaki2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_OniYaki2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $14,$E9,$00 ; $00
	db $14,$F1,$02 ; $01
	db $14,$F9,$04 ; $02
	db $14,$01,$06 ; $03
	db $24,$E9,$08 ; $04
	db $24,$F1,$0A ; $05
	db $24,$F9,$0C ; $06
	db $24,$01,$0E ; $07
	db $34,$F9,$10 ; $08
	db $34,$01,$12 ; $09
		
OBJLstHdrA_Kyo_OniYaki3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_OniYaki3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1D,$F1,$00 ; $00
	db $15,$F9,$02 ; $01
	db $15,$01,$04 ; $02
	db $25,$F9,$06 ; $03
	db $25,$01,$08 ; $04
	db $35,$F9,$0A ; $05
	db $35,$01,$0C ; $06
	db $15,$09,$0E ; $07
		
OBJLstHdrA_Kyo_KototsukiYou1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KototsukiYou1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $20,$F8,$02 ; $01
	db $20,$00,$04 ; $02
	db $30,$F0,$06 ; $03
	db $30,$F8,$08 ; $04
	db $30,$00,$0A ; $05
	db $38,$08,$0C ; $06
		
OBJLstHdrA_Kyo_KototsukiYou2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KototsukiYou2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $20,$F8,$02 ; $01
	db $20,$00,$04 ; $02
	db $30,$F0,$06 ; $03
	db $30,$F8,$08 ; $04
	db $30,$00,$0A ; $05
		
OBJLstHdrA_Kyo_KototsukiYou3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KototsukiYou3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F1,$00 ; $00
	db $20,$F9,$02 ; $01
	db $20,$01,$04 ; $02
	db $30,$F1,$06 ; $03
	db $30,$F9,$08 ; $04
	db $30,$01,$0A ; $05
		
OBJLstHdrA_Kyo_KototsukiYou6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KototsukiYou6 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $28,$F2,$06 ; $03
	db $28,$FA,$08 ; $04
	db $38,$F2,$0A ; $05
	db $38,$FA,$0C ; $06
	db $28,$02,$0E ; $07
	db $38,$02,$10 ; $08
		
OBJLstHdrA_Kyo_Kai0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Kai0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F1,$00 ; $00
	db $21,$F9,$02 ; $01
	db $21,$01,$04 ; $02
	db $31,$F1,$06 ; $03
	db $31,$F9,$08 ; $04
	db $39,$01,$0A ; $05
		
OBJLstHdrA_Kyo_Kai1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Kai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $1C,$FE,$04 ; $02
	db $14,$06,$06 ; $03
	db $2C,$F6,$08 ; $04
	db $2C,$FE,$0A ; $05
	db $24,$06,$0C ; $06
	db $3C,$FE,$0E ; $07
		
OBJLstHdrA_Kyo_KickFH2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Kai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$E2,$00 ; $00
	db $1C,$EA,$02 ; $01
	db $1C,$F2,$04 ; $02
	db $14,$FA,$06 ; $03
	db $2C,$EA,$08 ; $04
	db $2C,$F2,$0A ; $05
	db $24,$FA,$0C ; $06
	db $3C,$F2,$0E ; $07
		
OBJLstHdrA_Kyo_Kai3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_Kai3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $24,$FE,$04 ; $02
	db $2C,$F6,$06 ; $03
		
OBJLstHdrA_Kyo_UraOrochiNagi5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_16 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_UraOrochiNagi5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0D ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $30,$E2,$02 ; $01
	db $20,$EA,$04 ; $02
	db $30,$EA,$06 ; $03
	db $20,$F2,$08 ; $04
	db $30,$F2,$0A ; $05
	db $20,$FA,$0C ; $06
	db $30,$FA,$0E ; $07
	db $18,$02,$10 ; $08
	db $28,$02,$12 ; $09
	db $38,$02,$14 ; $0A
	db $18,$0A,$16 ; $0B
	db $28,$0A,$18 ; $0C
		
OBJLstHdrA_Kyo_UraOrochiNagi6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_UraOrochiNagi6 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0D ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
	db $20,$FA,$06 ; $03
	db $18,$02,$08 ; $04
	db $18,$0A,$0A ; $05
	db $38,$E2,$0C ; $06
	db $30,$EA,$0E ; $07
	db $30,$F2,$10 ; $08
	db $30,$FA,$12 ; $09
	db $28,$02,$14 ; $0A
	db $28,$0A,$16 ; $0B
	db $38,$02,$18 ; $0C
		
OBJLstHdrA_Kyo_KickFH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickFH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$E4,$00 ; $00
	db $19,$EC,$02 ; $01
	db $19,$F4,$04 ; $02
	db $21,$FC,$06 ; $03
	db $29,$EC,$08 ; $04
	db $29,$F4,$0A ; $05
	db $39,$F4,$0C ; $06
		
OBJLstHdrB_Kyo_KickFCH1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickFCH1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $38,$F2,$02 ; $01
	db $38,$FA,$04 ; $02
	db $38,$02,$06 ; $03
		
OBJLstHdrA_Kyo_KickFCH3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickFCH3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$E2,$00 ; $00
	db $30,$EA,$02 ; $01
	db $30,$F2,$04 ; $02
	db $20,$F2,$06 ; $03
	db $38,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrB_Kyo_KickFCH3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kyo_KickFCH3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $30,$02,$02 ; $01
		
OBJLstHdrA_Kyo_KickFCH4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_KickFCH4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $38,$F2,$04 ; $02
	db $38,$FA,$06 ; $03
		
OBJLstHdrA_Kyo_PunchAHD0_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchAHD0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F8,$00 ; $00
	db $1C,$00,$02 ; $01
	db $1C,$08,$04 ; $02
	db $0C,$00,$06 ; $03
		
OBJLstHdrA_Kyo_PunchAHD1: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kyo_PunchAHD1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
	db $28,$0A,$0A ; $05