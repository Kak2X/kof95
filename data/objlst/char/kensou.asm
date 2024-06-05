OBJLstPtrTable_Kensou_Idle:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_Idle3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_WalkF:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_WalkF1_A, OBJLstHdrB_Kensou_WalkF1_B
	dw OBJLstHdrA_Kensou_WalkF1_A, OBJLstHdrB_Kensou_WalkF2_B
	dw OBJLstHdrA_Kensou_WalkF3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_WalkB:
	dw OBJLstHdrA_Kensou_WalkF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_WalkF1_A, OBJLstHdrB_Kensou_WalkF2_B
	dw OBJLstHdrA_Kensou_WalkF1_A, OBJLstHdrB_Kensou_WalkF1_B
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Crouch:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_JumpN:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_JumpF:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B ;X
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_JumpB:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B ;X
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_BlockG:
	dw OBJLstHdrA_Kensou_BlockG0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_BlockC:
	dw OBJLstHdrA_Kensou_BlockC0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Hit0Mid:
	dw OBJLstHdrA_Kensou_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Dizzy:
	dw OBJLstHdrA_Kensou_Hit0Mid0, OBJLSTPTR_NONE
OBJLstPtrTable_Kensou_Hit1Mid:
	dw OBJLstHdrA_Kensou_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_HitLow:
	dw OBJLstHdrA_Kensou_HitLow0_A, OBJLstHdrB_Kensou_HitLow0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_LaunchUBRec:
	dw OBJLstHdrA_Kensou_Hit0Mid0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpF4, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpF3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpF2, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_LaunchUB:
	dw OBJLstHdrA_Kensou_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_LaunchSwoopup:
	dw OBJLstHdrA_Kensou_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchSwoopup1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchSwoopup2, OBJLSTPTR_NONE
OBJLstPtrTable_Kensou_LaunchDBShake:
	dw OBJLstHdrA_Kensou_LaunchDBShake3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchDBShake3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_HitSweep:
	dw OBJLstHdrA_Kensou_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_GrabUBNoSync:
	dw OBJLstHdrA_Kensou_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Wakeup:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_HopF:
	dw OBJLstHdrA_Kensou_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_HopB:
	dw OBJLstHdrA_Kensou_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_ChargeMeter:
	dw OBJLstHdrA_Kensou_ChargeMeter0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_ChargeMeter1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchLN:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_PunchLN1_A, OBJLstHdrB_Kensou_PunchLN1_B
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchHN:
	dw OBJLstHdrA_Kensou_PunchHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchHN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchHM:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_PunchHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchHM2_A, OBJLstHdrB_Kensou_PunchLN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickLN:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickLM:
	dw OBJLstHdrA_Kensou_Idle0_A, OBJLstHdrB_Kensou_Idle0_B
	dw OBJLstHdrA_Kensou_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickLN1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickHN:
	dw OBJLstHdrA_Kensou_KickHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickHN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickHM:
	dw OBJLstHdrA_Kensou_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickHM2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchCL:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_PunchCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchCH:
	dw OBJLstHdrA_Kensou_PunchCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickCL:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickCH:
	dw OBJLstHdrA_Kensou_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchALI:
	dw OBJLstHdrA_Kensou_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchAHI:
	dw OBJLstHdrA_Kensou_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickALI:
	dw OBJLstHdrA_Kensou_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickALX:
	dw OBJLstHdrA_Kensou_KickALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickALX0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickAHX:
	dw OBJLstHdrA_Kensou_KickAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_AttackA:
	dw OBJLstHdrA_Kensou_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Strike:
	dw OBJLstHdrA_Kensou_Strike0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kensou_Strike1, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Dodge:
	dw OBJLstHdrA_Kensou_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_DodgeCounter:
	dw OBJLstHdrA_Kensou_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_DodgeCounter1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_DodgeCounter2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Intro:
	dw OBJLstHdrA_Kensou_Intro0_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro1_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro2_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro0_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro2_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro0_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro1_A, OBJLstHdrB_Kensou_Intro0_B
	dw OBJLstHdrA_Kensou_Intro7_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_Intro8_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_Intro9_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_Intro8_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_Intro11, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Intro8_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_Intro9_A, OBJLstHdrB_Kensou_Intro7_B
	dw OBJLstHdrA_Kensou_WalkF1_A, OBJLstHdrB_Kensou_WalkF2_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Taunt:
	dw OBJLstHdrA_Kensou_Taunt0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Taunt1_A, OBJLstHdrB_Kensou_Taunt1_B
	dw OBJLstHdrA_Kensou_Taunt2_A, OBJLstHdrB_Kensou_Taunt1_B
	dw OBJLstHdrA_Kensou_Taunt1_A, OBJLstHdrB_Kensou_Taunt1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_Win:
	dw OBJLstHdrA_Kensou_Win0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Win1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Win2_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win3_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win2_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win3_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win2_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win3_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLstHdrA_Kensou_Win2_A, OBJLstHdrB_Kensou_Win2_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_LostTimeover:
	dw OBJLstHdrA_Kensou_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_ChouKyuuDan:
	dw OBJLstHdrA_Kensou_Strike0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_ChouKyuuDan1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_RyuuGakuSai:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_RyuuGakuSai1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuGakuSai7, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_RyuuRenGa:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_RyuuSouGeki:
	dw OBJLstHdrA_Kensou_RyuuSouGeki0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuSouGeki1_A, OBJLstHdrB_Kensou_RyuuSouGeki1_B
	dw OBJLstHdrA_Kensou_RyuuSouGeki2_A, OBJLstHdrB_Kensou_RyuuSouGeki1_B
	dw OBJLstHdrA_Kensou_RyuuSouGeki1_A, OBJLstHdrB_Kensou_RyuuSouGeki1_B
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_RyuuSouGeki5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_ShinryuuTenbuKyaku:
	dw OBJLstHdrA_Kensou_RyuuRenGa4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_ShinryuuTenbuKyaku5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_JumpN1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_PunchFH:
	dw OBJLstHdrA_Kensou_PunchFH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchFH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_PunchFH2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_KickFH:
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLstHdrA_Kensou_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_RyuuRenGa5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kensou_Crouch0_A, OBJLstHdrB_Kensou_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kensou_ThrowG:
	dw OBJLstHdrA_Kensou_ThrowG0_A, OBJLstHdrB_Kensou_HitLow0_B
	dw OBJLstHdrA_Kensou_ThrowG1_A, OBJLstHdrB_Kensou_HitLow0_B
	dw OBJLstHdrA_Kensou_ThrowG0_A, OBJLstHdrB_Kensou_HitLow0_B
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Kensou_Idle0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Idle0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrB_Kensou_Idle0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Idle0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Kensou_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
	db $38,$F2,$0A ; $05
		
OBJLstHdrA_Kensou_Idle3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Idle3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
	db $30,$02,$0C ; $06
		
OBJLstHdrA_Kensou_WalkF1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_WalkF1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $10,$FA,$06 ; $03
		
OBJLstHdrB_Kensou_WalkF1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FA,$00 ; $00
	db $30,$02,$02 ; $01
		
OBJLstHdrB_Kensou_WalkF2_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
		
OBJLstHdrA_Kensou_WalkF3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_WalkF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F2,$00 ; $00
	db $21,$FA,$02 ; $01
	db $21,$02,$04 ; $02
	db $39,$F2,$06 ; $03
	db $31,$FA,$08 ; $04
	db $31,$02,$0A ; $05
		
OBJLstHdrA_Kensou_Crouch0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
		
OBJLstHdrB_Kensou_Crouch0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$FA,$00 ; $00
	db $38,$02,$02 ; $01
		
OBJLstHdrB_Kensou_HitLow0_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F5,$00 ; $00
	db $38,$FD,$02 ; $01
		
OBJLstHdrA_Kensou_JumpN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kensou_JumpN3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_JumpN3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
		
OBJLstHdrA_Kensou_JumpF3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_JumpN3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_JumpN3.bin ; iOBJLstHdrA_DataPtr
	db $F0 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_JumpF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $28,$F2,$08 ; $04
	db $28,$FA,$0A ; $05
		
OBJLstHdrA_Kensou_JumpF4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_BlockG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_BlockG0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F0,$00 ; $00
	db $28,$F8,$02 ; $01
	db $28,$00,$04 ; $02
	db $18,$F8,$06 ; $03
	db $18,$00,$08 ; $04
		
OBJLstHdrA_Kensou_BlockC0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_BlockC0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
		
OBJLstHdrA_Kensou_Hit0Mid0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Hit0Mid0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F6,$00 ; $00
	db $20,$FE,$02 ; $01
	db $20,$06,$04 ; $02
	db $30,$FE,$06 ; $03
	db $30,$06,$08 ; $04
	db $38,$F6,$0A ; $05
		
OBJLstHdrA_Kensou_Hit1Mid1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $20,$FE,$02 ; $01
	db $20,$06,$04 ; $02
	db $30,$FE,$06 ; $03
	db $30,$06,$08 ; $04
		
OBJLstHdrA_Kensou_LaunchDBShake3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_LaunchSwoopup2:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_LaunchSwoopup1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_HitLow0_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_HitLow0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
		
OBJLstHdrA_Kensou_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $28,$0E,$08 ; $04
	db $38,$EE,$0A ; $05
	db $38,$06,$0C ; $06
		
OBJLstHdrA_Kensou_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $3A,$EE,$00 ; $00
	db $32,$F6,$02 ; $01
	db $32,$FE,$04 ; $02
	db $32,$06,$06 ; $03
	db $32,$0E,$08 ; $04
		
OBJLstHdrA_Kensou_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $18,$F2,$08 ; $04
	db $18,$FA,$0A ; $05
		
OBJLstHdrB_Kensou_PunchLN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_PunchLN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Kensou_PunchHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $38,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
	db $30,$02,$0C ; $06
		
OBJLstHdrA_Kensou_PunchHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
	db $38,$F2,$08 ; $04
		
OBJLstHdrA_Kensou_PunchHM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchHM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FD,$00 ; $00
	db $20,$05,$02 ; $01
	db $30,$F5,$04 ; $02
	db $30,$FD,$06 ; $03
	db $30,$05,$08 ; $04
	db $38,$ED,$0A ; $05
		
OBJLstHdrA_Kensou_PunchHM2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchHM2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E7,$00 ; $00
	db $28,$EF,$02 ; $01
	db $28,$F7,$04 ; $02
	db $28,$FF,$06 ; $03
	db $18,$EF,$08 ; $04
	db $18,$F7,$0A ; $05
		
OBJLstHdrA_Kensou_KickLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $30,$F2,$04 ; $02
	db $30,$FA,$06 ; $03
		
OBJLstHdrA_Kensou_KickLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $18,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
	db $28,$EA,$06 ; $03
	db $30,$F2,$08 ; $04
		
OBJLstHdrA_Kensou_KickHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Kensou_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$F6,$00 ; $00
	db $1C,$FE,$02 ; $01
	db $1C,$06,$04 ; $02
	db $2C,$FE,$06 ; $03
	db $2C,$06,$08 ; $04
	db $3C,$06,$0A ; $05
	db $1C,$0E,$0C ; $06
		
OBJLstHdrA_Kensou_KickHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
		
OBJLstHdrA_Kensou_KickHM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickHM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$E2,$00 ; $00
	db $1E,$EA,$02 ; $01
	db $1E,$F2,$04 ; $02
	db $16,$FA,$06 ; $03
	db $2E,$EA,$08 ; $04
	db $2E,$F2,$0A ; $05
	db $3E,$F2,$0C ; $06
		
OBJLstHdrA_Kensou_KickHM2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $18,$FF,$04 ; $02
	db $18,$07,$06 ; $03
	db $30,$F7,$08 ; $04
	db $28,$FF,$0A ; $05
	db $28,$07,$0C ; $06
		
OBJLstHdrA_Kensou_PunchCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $38,$FA,$08 ; $04
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Kensou_PunchCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Kensou_ShinryuuTenbuKyaku5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_PunchCH0.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_RyuuRenGa4:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_PunchCH0.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_PunchCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $38,$F6,$08 ; $04
	db $38,$FE,$0A ; $05
	db $38,$06,$0C ; $06
		
OBJLstHdrA_Kensou_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kensou_KickCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kensou_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $38,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $30,$0A,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kensou_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
	db $28,$0A,$0C ; $06
		
OBJLstHdrA_Kensou_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F2,$00 ; $00
	db $21,$FA,$02 ; $01
	db $21,$02,$04 ; $02
	db $29,$0A,$06 ; $03
	db $31,$02,$08 ; $04
		
OBJLstHdrA_Kensou_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
	db $28,$02,$0A ; $05
	db $38,$FA,$0C ; $06
		
OBJLstHdrA_Kensou_KickALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $28,$FA,$08 ; $04
	db $28,$02,$0A ; $05
		
OBJLstHdrA_Kensou_KickAHX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_KickAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $25,$EB,$00 ; $00
	db $15,$F3,$02 ; $01
	db $15,$FB,$04 ; $02
	db $0D,$03,$06 ; $03
	db $25,$F3,$08 ; $04
	db $25,$FB,$0A ; $05
	db $1D,$03,$0C ; $06
		
OBJLstHdrA_Kensou_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F9,$00 ; $00
	db $20,$01,$02 ; $01
	db $30,$F9,$04 ; $02
	db $30,$01,$06 ; $03
	db $20,$09,$08 ; $04
	db $38,$F1,$0A ; $05
		
OBJLstHdrA_Kensou_DodgeCounter1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_DodgeCounter1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$E8,$00 ; $00
	db $21,$F0,$02 ; $01
	db $19,$F8,$04 ; $02
	db $29,$F8,$06 ; $03
	db $31,$F0,$08 ; $04
	db $39,$F8,$0A ; $05
	db $31,$00,$0C ; $06
	db $19,$00,$0E ; $07
		
OBJLstHdrA_Kensou_DodgeCounter2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_DodgeCounter2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $25,$EA,$00 ; $00
	db $1D,$F2,$02 ; $01
	db $1D,$FA,$04 ; $02
	db $2D,$F2,$06 ; $03
	db $2D,$FA,$08 ; $04
	db $2D,$02,$0A ; $05
	db $3D,$F2,$0C ; $06
		
OBJLstHdrA_Kensou_ThrowG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_ThrowG0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $18,$F9,$06 ; $03
	db $18,$01,$08 ; $04
		
OBJLstHdrA_Kensou_ThrowG1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_ThrowG1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $20,$F2,$04 ; $02
	db $18,$FA,$06 ; $03
	db $18,$02,$08 ; $04
		
OBJLstHdrA_Kensou_ChargeMeter0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_ChargeMeter0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
	db $38,$F2,$0A ; $05
		
OBJLstHdrA_Kensou_ChargeMeter1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_ChargeMeter1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kensou_Strike1: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Strike1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $20,$0A,$08 ; $04
	db $30,$F2,$0A ; $05
	db $30,$FA,$0C ; $06
	db $38,$02,$0E ; $07
	db $38,$EA,$10 ; $08
	db $38,$0A,$12 ; $09
	
; [TCRF] Unreferenced sprite mapping using otherwise unused graphics.	
OBJLstHdrA_Kensou_Unused_A_0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Unused_A_0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $05,$F2,$00 ; $00
	db $05,$FA,$02 ; $01
	db $05,$02,$04 ; $02
	db $15,$F2,$06 ; $03
	db $15,$FA,$08 ; $04
	db $15,$02,$0A ; $05
	db $1D,$EA,$0C ; $06
	
OBJLstHdrA_Kensou_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$F1,$00 ; $00
	db $1C,$F9,$02 ; $01
	db $14,$01,$04 ; $02
	db $0C,$09,$06 ; $03
	db $2C,$F9,$08 ; $04
	db $24,$01,$0A ; $05
	db $1C,$09,$0C ; $06
		
OBJLstHdrA_Kensou_Intro0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrB_Kensou_Intro0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Intro0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FA,$00 ; $00
	db $30,$02,$02 ; $01
		
OBJLstHdrA_Kensou_Intro1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrA_Kensou_Intro2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrA_Kensou_Intro7_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro7_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $18,$03,$04 ; $02
	db $10,$FB,$06 ; $03
	db $28,$03,$08 ; $04
		
OBJLstHdrB_Kensou_Intro7_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Intro7_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FA,$00 ; $00
	db $30,$02,$02 ; $01
		
OBJLstHdrA_Kensou_Intro9_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro9_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
	db $28,$F3,$08 ; $04
		
OBJLstHdrA_Kensou_Intro8_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro8_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $10,$FB,$06 ; $03
		
OBJLstHdrA_Kensou_Intro11:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Intro11 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $18,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kensou_Taunt0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Taunt0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $20,$F9,$02 ; $01
	db $20,$01,$04 ; $02
	db $30,$F9,$06 ; $03
	db $30,$01,$08 ; $04
	db $30,$09,$0A ; $05
	db $38,$F1,$0C ; $06
		
OBJLstHdrA_Kensou_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $20,$04,$04 ; $02
	db $10,$FC,$06 ; $03
		
OBJLstHdrB_Kensou_Taunt1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Taunt1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F8,$00 ; $00
	db $30,$00,$02 ; $01
	db $38,$08,$04 ; $02
		
OBJLstHdrA_Kensou_Taunt2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Taunt2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $10,$FA,$06 ; $03
	db $10,$02,$08 ; $04
		
OBJLstHdrA_Kensou_Win0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Win0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kensou_Win1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Win1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EF,$00 ; $00
	db $18,$F7,$02 ; $01
	db $20,$FF,$04 ; $02
	db $28,$F7,$06 ; $03
	db $30,$FF,$08 ; $04
	db $38,$F7,$0A ; $05
	db $10,$FF,$0C ; $06
		
OBJLstHdrA_Kensou_Win2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Win2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
		
OBJLstHdrB_Kensou_Win2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_Win2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $30,$F2,$04 ; $02
	db $30,$FA,$06 ; $03
	db $38,$02,$08 ; $04
	db $38,$EA,$0A ; $05
		
OBJLstHdrA_Kensou_Win3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Win3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
		
OBJLstHdrA_Kensou_Strike0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_Strike0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1E,$FA,$00 ; $00
	db $1E,$02,$02 ; $01
	db $2E,$FA,$04 ; $02
	db $2E,$02,$06 ; $03
	db $3E,$02,$08 ; $04
		
OBJLstHdrA_Kensou_ChouKyuuDan1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_ChouKyuuDan1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $30,$12,$08 ; $04
	db $38,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kensou_RyuuGakuSai1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuGakuSai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FB,$00 ; $00
	db $30,$03,$02 ; $01
	db $20,$FB,$04 ; $02
	db $20,$03,$06 ; $03
	db $10,$FB,$08 ; $04
	db $10,$03,$0A ; $05
		
OBJLstHdrA_Kensou_RyuuGakuSai3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuGakuSai1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kensou_RyuuGakuSai1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kensou_RyuuGakuSai2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuGakuSai2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E7,$00 ; $00
	db $20,$EF,$02 ; $01
	db $20,$F7,$04 ; $02
	db $20,$FF,$06 ; $03
	db $18,$07,$08 ; $04
	db $30,$F7,$0A ; $05
	db $30,$FF,$0C ; $06
		
OBJLstHdrA_Kensou_RyuuGakuSai4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuGakuSai4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F6,$00 ; $00
	db $18,$FE,$02 ; $01
	db $28,$F6,$04 ; $02
	db $28,$FE,$06 ; $03
	db $38,$F6,$08 ; $04
	db $38,$FE,$0A ; $05
		
OBJLstHdrA_Kensou_HopF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_HopF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $23,$EE,$00 ; $00
	db $1B,$F6,$02 ; $01
	db $1B,$FE,$04 ; $02
	db $2B,$F6,$06 ; $03
	db $2B,$FE,$08 ; $04
	db $33,$06,$0A ; $05
		
OBJLstHdrA_Kensou_RyuuRenGa2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuRenGa2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kensou_RyuuRenGa5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuRenGa5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1F,$E2,$00 ; $00
	db $27,$EA,$02 ; $01
	db $1F,$F2,$04 ; $02
	db $1F,$FA,$06 ; $03
	db $2F,$F2,$08 ; $04
	db $2F,$FA,$0A ; $05
		
OBJLstHdrA_Kensou_RyuuSouGeki0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuSouGeki0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F3,$00 ; $00
	db $1A,$FB,$02 ; $01
	db $1A,$03,$04 ; $02
	db $22,$0B,$06 ; $03
	db $2A,$FB,$08 ; $04
	db $2A,$03,$0A ; $05
	db $3A,$FB,$0C ; $06
		
OBJLstHdrA_Kensou_RyuuSouGeki1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuSouGeki1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$EA,$04 ; $02
	db $38,$EA,$06 ; $03
	db $38,$F2,$08 ; $04
	db $18,$F2,$0A ; $05
	db $18,$FA,$0C ; $06
	db $18,$02,$0E ; $07
		
OBJLstHdrB_Kensou_RyuuSouGeki1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kensou_RyuuSouGeki1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$02,$00 ; $00
	db $30,$0A,$02 ; $01
	db $38,$FA,$04 ; $02
	db $38,$02,$06 ; $03
		
OBJLstHdrA_Kensou_RyuuSouGeki2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuSouGeki2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $28,$EA,$04 ; $02
	db $38,$EA,$06 ; $03
	db $20,$F2,$08 ; $04
	db $18,$FA,$0A ; $05
	db $18,$02,$0C ; $06
		
OBJLstHdrA_Kensou_RyuuSouGeki5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuSouGeki5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $18,$0A,$06 ; $03
	db $30,$02,$08 ; $04
	db $38,$F2,$0A ; $05
	db $38,$FA,$0C ; $06
		
OBJLstHdrA_Kensou_RyuuGakuSai7:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_RyuuGakuSai7 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $38,$FA,$08 ; $04
		
OBJLstHdrA_Kensou_PunchFH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchFH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $20,$FF,$04 ; $02
	db $30,$F7,$06 ; $03
	db $30,$FF,$08 ; $04
	db $38,$07,$0A ; $05
		
OBJLstHdrA_Kensou_PunchFH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchFH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $20,$0A,$04 ; $02
	db $30,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Kensou_PunchFH2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kensou_PunchFH2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2D,$EA,$00 ; $00
	db $25,$F2,$02 ; $01
	db $2D,$FA,$04 ; $02
	db $35,$F2,$06 ; $03
	db $3D,$FA,$08 ; $04
	db $35,$02,$0A ; $05