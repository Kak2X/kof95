OBJLstPtrTable_Yuri_Idle:
	dw OBJLstHdrA_Yuri_Idle0_A, OBJLstHdrB_Yuri_Idle0_B
	dw OBJLstHdrA_Yuri_Idle1_A, OBJLstHdrB_Yuri_Idle1_B
	dw OBJLstHdrA_Yuri_Idle2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Idle1_A, OBJLstHdrB_Yuri_Idle1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_WalkF:
	dw OBJLstHdrA_Yuri_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Idle1_A, OBJLstHdrB_Yuri_Idle1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_WalkB:
	dw OBJLstHdrA_Yuri_Idle1_A, OBJLstHdrB_Yuri_Idle1_B
	dw OBJLstHdrA_Yuri_WalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Crouch:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_JumpN:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_JumpF:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B ;X
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_JumpB:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B ;X
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_BlockG:
	dw OBJLstHdrA_Yuri_BlockG0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_BlockC:
	dw OBJLstHdrA_Yuri_BlockC0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Hit0Mid:
	dw OBJLstHdrA_Yuri_Hit0Mid0_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Dizzy:
	dw OBJLstHdrA_Yuri_Hit0Mid0_A, OBJLstHdrB_Yuri_Hit0Mid0_B
OBJLstPtrTable_Yuri_Hit1Mid:
	dw OBJLstHdrA_Yuri_Hit1Mid1_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HitLow:
	dw OBJLstHdrA_Yuri_HitLow0_A, OBJLstHdrB_Yuri_Crouch0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_LaunchUBRec:
	dw OBJLstHdrA_Yuri_Hit0Mid0_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLstHdrA_Yuri_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_LaunchUB:
	dw OBJLstHdrA_Yuri_Hit0Mid0_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLstHdrA_Yuri_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_LaunchSwoopup:
	dw OBJLstHdrA_Yuri_Hit1Mid1_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLstHdrA_Yuri_LaunchSwoopup1_A, OBJLstHdrB_Yuri_LaunchSwoopup1_B
	dw OBJLstHdrA_Yuri_LaunchSwoopup2_A, OBJLstHdrB_Yuri_LaunchSwoopup2_B
OBJLstPtrTable_Yuri_LaunchDBShake:
	dw OBJLstHdrA_Yuri_LaunchDBShake3_A, OBJLstHdrB_Yuri_LaunchDBShake3_B
	dw OBJLstHdrA_Yuri_LaunchDBShake3_A, OBJLstHdrB_Yuri_LaunchDBShake3_B
	dw OBJLstHdrA_Yuri_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HitSweep:
	dw OBJLstHdrA_Yuri_Hit1Mid1_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLstHdrA_Yuri_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_GrabUBNoSync:
	dw OBJLstHdrA_Yuri_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Wakeup:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HopF:
	dw OBJLstHdrA_Yuri_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HopB:
	dw OBJLstHdrA_Yuri_Hit1Mid1_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_ChargeMeter:
	dw OBJLstHdrA_Yuri_ChargeMeter0_A, OBJLstHdrB_Yuri_ChargeMeter0_B
	dw OBJLstHdrA_Yuri_ChargeMeter1_A, OBJLstHdrB_Yuri_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchLN:
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchLN1_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchLM:
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchLM1_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchHN:
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchHN1_A, OBJLstHdrB_Yuri_PunchHN1_B
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchHM:
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_PunchHM1_A, OBJLstHdrB_Yuri_PunchHN1_B
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickLN:
	dw OBJLstHdrA_Yuri_KickLN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickLN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickLM:
	dw OBJLstHdrA_Yuri_KickLM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickLM0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickHN:
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLstHdrA_Yuri_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_PunchLN0_A, OBJLstHdrB_Yuri_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickHM:
	dw OBJLstHdrA_Yuri_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickHN1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchCL:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_PunchCL1_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchCH:
	dw OBJLstHdrA_Yuri_PunchHN1_A, OBJLstHdrB_Yuri_PunchHN1_B
	dw OBJLstHdrA_Yuri_PunchCH1_A, OBJLstHdrB_Yuri_PunchCH1_B
	dw OBJLstHdrA_Yuri_PunchCH2_A, OBJLstHdrB_Yuri_PunchHN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickCL:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickCH:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickCH2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickCH3_A, OBJLstHdrB_Yuri_KickCH3_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchALI:
	dw OBJLstHdrA_Yuri_PunchALI0_A, OBJLstHdrB_Yuri_PunchALI0_B
	dw OBJLstHdrA_Yuri_PunchALI0_A, OBJLstHdrB_Yuri_PunchALI0_B
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_PunchAHI:
	dw OBJLstHdrA_Yuri_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_PunchAHI1_A, OBJLstHdrB_Yuri_PunchALI0_B
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickALI:
	dw OBJLstHdrA_Yuri_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Strike:
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B ;X
	dw OBJLstHdrA_Yuri_Strike1_A, OBJLstHdrB_Yuri_PunchCH1_B ;X
	dw OBJLstHdrA_Yuri_Strike2_A, OBJLstHdrB_Yuri_PunchCH1_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Dodge:
	dw OBJLstHdrA_Yuri_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_DodgeCounter:
	dw OBJLstHdrA_Yuri_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickHN1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Taunt:
	dw OBJLstHdrA_Yuri_Taunt0_A, OBJLstHdrB_Yuri_Taunt0_B
	dw OBJLstHdrA_Yuri_Taunt1_A, OBJLstHdrB_Yuri_Taunt0_B
	dw OBJLstHdrA_Yuri_Taunt0_A, OBJLstHdrB_Yuri_Taunt0_B
	dw OBJLstHdrA_Yuri_Taunt1_A, OBJLstHdrB_Yuri_Taunt0_B
	dw OBJLstHdrA_Yuri_Taunt0_A, OBJLstHdrB_Yuri_Taunt0_B
	dw OBJLstHdrA_Yuri_Taunt5_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLstHdrA_Yuri_Taunt6_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLstHdrA_Yuri_Taunt5_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLstHdrA_Yuri_Taunt6_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_Win:
	dw OBJLstHdrA_Yuri_Win0_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_Win1_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_Win0_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_Win1_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_Win0_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_Win5_A, OBJLstHdrB_Yuri_Win0_B
	dw OBJLstHdrA_Yuri_KickLN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Win7, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_LostTimeover:
	dw OBJLstHdrA_Yuri_Hit1Mid1_A, OBJLstHdrB_Yuri_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KoOuKen:
	dw OBJLstHdrA_Yuri_KoOuKen0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KoOuKen1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KoOuKen2_A, OBJLstHdrB_Yuri_PunchHN1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_SaiHa:
	dw OBJLstHdrA_Yuri_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_SaiHa1_A, OBJLstHdrB_Yuri_SaiHa1_B
	dw OBJLstHdrA_Yuri_SaiHa2_A, OBJLstHdrB_Yuri_SaiHa1_B
	dw OBJLstHdrA_Yuri_SaiHa3_A, OBJLstHdrB_Yuri_SaiHa1_B
	dw OBJLstHdrA_Yuri_SaiHa4_A, OBJLstHdrB_Yuri_SaiHa1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HyakuRetsuBintaH:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_HopF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
OBJLstPtrTable_Yuri_HyakuRetsuBintaL:
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike0_A, OBJLstHdrB_Yuri_Strike0_B
	dw OBJLstHdrA_Yuri_Strike1_A, OBJLstHdrB_Yuri_PunchCH1_B
	dw OBJLstHdrA_Yuri_Strike2_A, OBJLstHdrB_Yuri_PunchCH1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KuuGaH:
	dw OBJLstHdrA_Yuri_KuuGaH0, OBJLSTPTR_NONE
OBJLstPtrTable_Yuri_KuuGaL:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_KuuGaL2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_RaiOhKen:
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_PunchAHI1_A, OBJLstHdrB_Yuri_PunchALI0_B
	dw OBJLstHdrA_Yuri_RaiOhKen4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HaohShoukouKen:
	dw OBJLstHdrA_Yuri_HaohShoukouKen0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HaohShoukouKen1_A, OBJLstHdrB_Yuri_ChargeMeter0_B
	dw OBJLstHdrA_Yuri_HaohShoukouKen2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_HienHouOuKyaKu:
	dw OBJLstHdrA_Yuri_HaohShoukouKen0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HaohShoukouKen1_A, OBJLstHdrB_Yuri_ChargeMeter0_B
	dw OBJLstHdrA_Yuri_ChargeMeter0_A, OBJLstHdrB_Yuri_ChargeMeter0_B
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_HienHouOuKyaKu6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Crouch0_A, OBJLstHdrB_Yuri_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_KickFH:
	dw OBJLstHdrA_Yuri_Taunt5_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLstHdrA_Yuri_KickFH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_Taunt5_A, OBJLstHdrB_Yuri_Taunt5_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_ThrowG:
	dw OBJLstHdrA_Yuri_JumpF5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG8, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_RaiOhKen4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG10, OBJLSTPTR_NONE
	dw OBJLstHdrA_Yuri_ThrowG11_A, OBJLstHdrB_Yuri_ThrowG11_B
	dw OBJLstHdrA_Yuri_ThrowG12_A, OBJLstHdrB_Yuri_ThrowG11_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Yuri_ThrowA:
	dw OBJLstHdrA_Yuri_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Yuri_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Yuri_ThrowA0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Yuri_Idle0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Idle0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $28,$04,$04 ; $02
	db $18,$F4,$06 ; $03
	db $18,$FC,$08 ; $04
		
OBJLstHdrA_Yuri_Idle1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Idle0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_Idle0_A.bin ; iOBJLstHdrA_DataPtr
	db $01 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Yuri_Idle0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Idle0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F0,$00 ; $00
	db $38,$F8,$02 ; $01
	db $38,$00,$04 ; $02
		
OBJLstHdrB_Yuri_Idle1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Idle1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F0,$00 ; $00
	db $38,$F8,$02 ; $01
	db $38,$00,$04 ; $02
		
OBJLstHdrA_Yuri_Idle2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Idle2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F1,$00 ; $00
	db $20,$F9,$02 ; $01
	db $20,$01,$04 ; $02
	db $38,$F1,$06 ; $03
	db $30,$F9,$08 ; $04
	db $30,$01,$0A ; $05
		
OBJLstHdrA_Yuri_WalkF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_WalkF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_WalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_Crouch0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrA_Yuri_KickCH3_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_Crouch0_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Yuri_Crouch0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F7,$00 ; $00
	db $38,$FF,$02 ; $01
	db $38,$07,$04 ; $02
		
OBJLstHdrB_Yuri_KickCH3_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Yuri_Crouch0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_JumpN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1E,$F7,$00 ; $00
	db $16,$FF,$02 ; $01
	db $1E,$07,$04 ; $02
	db $26,$FF,$06 ; $03
	db $2E,$F7,$08 ; $04
	db $36,$FF,$0A ; $05
		
OBJLstHdrA_Yuri_ThrowG6:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpN1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ThrowG10:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpN1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ThrowA0: ;X
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpN1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_WalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F5,$00 ; $00
	db $20,$FD,$02 ; $01
	db $20,$05,$04 ; $02
	db $30,$F5,$06 ; $03
	db $30,$FD,$08 ; $04
		
OBJLstHdrA_Yuri_ThrowG4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_WalkF1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_HopF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HopF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$E9,$00 ; $00
	db $21,$F1,$02 ; $01
	db $21,$F9,$04 ; $02
	db $21,$01,$06 ; $03
	db $31,$F9,$08 ; $04
	db $31,$01,$0A ; $05
		
OBJLstHdrA_Yuri_HienHouOuKyaKu3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HopF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_HopF0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_JumpF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Yuri_JumpF4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_JumpF3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F2,$00 ; $00
	db $1C,$FA,$02 ; $01
	db $1C,$02,$04 ; $02
	db $2C,$F2,$06 ; $03
	db $2C,$FA,$08 ; $04
	db $2C,$02,$0A ; $05
		
OBJLstHdrA_Yuri_JumpF5:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpF3.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ThrowG5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpF3.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ThrowG2:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_JumpF3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_JumpF3.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_BlockG0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_BlockG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F9,$00 ; $00
	db $22,$01,$02 ; $01
	db $32,$F9,$04 ; $02
	db $32,$01,$06 ; $03
	db $2A,$09,$08 ; $04
		
OBJLstHdrA_Yuri_BlockC0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_BlockC0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F9,$00 ; $00
	db $28,$01,$02 ; $01
	db $28,$09,$04 ; $02
		
OBJLstHdrA_Yuri_Hit0Mid0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Hit0Mid0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F2,$00 ; $00
	db $22,$FA,$02 ; $01
	db $22,$02,$04 ; $02
		
OBJLstHdrB_Yuri_Hit0Mid0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $32,$F8,$00 ; $00
	db $32,$00,$02 ; $01
	db $3A,$F0,$04 ; $02
		
OBJLstHdrB_Yuri_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Yuri_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Yuri_LaunchSwoopup2_B:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Yuri_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Yuri_LaunchSwoopup1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Yuri_Hit0Mid0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_Hit1Mid1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F1,$00 ; $00
	db $22,$F9,$02 ; $01
	db $22,$01,$04 ; $02
		
OBJLstHdrA_Yuri_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_LaunchSwoopup2_A:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_LaunchSwoopup1_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_HitLow0_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HitLow0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F7,$00 ; $00
	db $28,$FF,$02 ; $01
	db $28,$07,$04 ; $02
	db $18,$FF,$06 ; $03
		
OBJLstHdrA_Yuri_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $3C,$EA,$00 ; $00
	db $34,$F2,$02 ; $01
	db $34,$FA,$04 ; $02
	db $34,$02,$06 ; $03
	db $34,$0A,$08 ; $04
		
OBJLstHdrA_Yuri_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $2C,$F0,$00 ; $00
	db $2C,$F8,$02 ; $01
	db $24,$00,$04 ; $02
	db $2C,$08,$06 ; $03
	db $34,$00,$08 ; $04
	db $3C,$F8,$0A ; $05
		
OBJLstHdrA_Yuri_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_PunchLN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F3,$00 ; $00
	db $28,$FB,$02 ; $01
	db $28,$03,$04 ; $02
	db $18,$F3,$06 ; $03
	db $18,$FB,$08 ; $04
		
OBJLstHdrB_Yuri_PunchLN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EF,$00 ; $00
	db $38,$F7,$02 ; $01
	db $38,$FF,$04 ; $02
		
OBJLstHdrA_Yuri_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$F2,$06 ; $03
	db $18,$FA,$08 ; $04
		
OBJLstHdrA_Yuri_PunchLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_PunchCH2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchCH2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
		
OBJLstHdrA_Yuri_PunchHN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchCH2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_PunchCH2_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Yuri_PunchHN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_PunchHN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F4,$00 ; $00
	db $30,$FC,$02 ; $01
	db $38,$04,$04 ; $02
		
OBJLstHdrA_Yuri_KoOuKen2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KoOuKen2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E6,$00 ; $00
	db $20,$EE,$02 ; $01
	db $20,$F6,$04 ; $02
	db $20,$FE,$06 ; $03
		
OBJLstHdrA_Yuri_PunchHM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KoOuKen2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_KoOuKen2_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_KickLN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickLN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_KickLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F7,$00 ; $00
	db $20,$FF,$02 ; $01
	db $30,$EF,$04 ; $02
	db $30,$F7,$06 ; $03
	db $30,$FF,$08 ; $04
	db $20,$07,$0A ; $05
		
OBJLstHdrA_Yuri_KickLM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickLM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
		
OBJLstHdrA_Yuri_KickLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $29,$DE,$00 ; $00
	db $21,$E6,$02 ; $01
	db $21,$EE,$04 ; $02
	db $21,$F6,$06 ; $03
	db $31,$EE,$08 ; $04
	db $31,$F6,$0A ; $05
		
OBJLstHdrA_Yuri_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_KickHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
	db $30,$0A,$0C ; $06
		
OBJLstHdrA_Yuri_KickHM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickHM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $29,$DF,$00 ; $00
	db $21,$E7,$02 ; $01
	db $21,$EF,$04 ; $02
	db $21,$F7,$06 ; $03
	db $31,$EF,$08 ; $04
	db $31,$F7,$0A ; $05
	db $29,$FF,$0C ; $06
		
OBJLstHdrA_Yuri_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $18,$F9,$06 ; $03
		
OBJLstHdrA_Yuri_PunchCH1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchCH1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $10,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
		
OBJLstHdrB_Yuri_PunchCH1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_PunchCH1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Yuri_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F8,$00 ; $00
	db $20,$00,$02 ; $01
	db $30,$F8,$04 ; $02
	db $30,$00,$06 ; $03
	db $30,$08,$08 ; $04
	db $38,$F0,$0A ; $05
		
OBJLstHdrA_Yuri_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $36,$E4,$00 ; $00
	db $2E,$EC,$02 ; $01
	db $26,$F4,$04 ; $02
	db $26,$FC,$06 ; $03
	db $2E,$04,$08 ; $04
	db $36,$F4,$0A ; $05
	db $36,$FC,$0C ; $06
		
OBJLstHdrA_Yuri_KickCH2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickCH2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $30,$EA,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
		
OBJLstHdrA_Yuri_PunchALI0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchALI0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $28,$F2,$08 ; $04
		
OBJLstHdrA_Yuri_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$FB,$00 ; $00
	db $10,$03,$02 ; $01
	db $20,$FB,$04 ; $02
	db $20,$03,$06 ; $03
	db $30,$FB,$08 ; $04
	db $30,$03,$0A ; $05
		
L076EAE: db $60;X
L076EAF: db $01;X
L076EB0: db $02;X
L076EB1: db $60;X
L076EB2: db $59;X
L076EB3: db $0E;X
L076EB4: db $9B;X
L076EB5: db $6E;X
L076EB6: db $00;X
OBJLstHdrB_Yuri_PunchALI0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_PunchALI0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FA,$00 ; $00
	db $30,$02,$02 ; $01
		
OBJLstHdrA_Yuri_PunchAHI1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_PunchAHI1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $20,$FF,$04 ; $02
	db $30,$EF,$06 ; $03
	db $30,$F7,$08 ; $04
		
OBJLstHdrA_Yuri_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $20,$0A,$08 ; $04
	db $28,$FA,$0A ; $05
	db $28,$02,$0C ; $06
		
OBJLstHdrA_Yuri_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $30,$F3,$04 ; $02
	db $30,$FB,$06 ; $03
	db $38,$03,$08 ; $04
		
OBJLstHdrA_Yuri_ThrowG8:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ThrowG8 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F6,$00 ; $00
	db $20,$FE,$02 ; $01
	db $30,$F6,$04 ; $02
	db $30,$FE,$06 ; $03
		
OBJLstHdrA_Yuri_RaiOhKen4:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ThrowG8 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_ThrowG8.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $18,$FA,$08 ; $04
	db $18,$02,$0A ; $05
		
OBJLstHdrA_Yuri_ThrowG12_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_ChargeMeter0_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $18,$FA,$08 ; $04
	db $18,$02,$0A ; $05
		
OBJLstHdrA_Yuri_ThrowG11_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_ChargeMeter1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_Taunt0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Taunt0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrB_Yuri_Taunt0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Taunt0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F8,$00 ; $00
	db $30,$00,$02 ; $01
		
OBJLstHdrA_Yuri_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Yuri_Taunt5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Taunt5_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
		
OBJLstHdrB_Yuri_Taunt5_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Taunt5_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_Taunt6_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Taunt6_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
		
OBJLstHdrA_Yuri_Win0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Win0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrB_Yuri_Win0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Win0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$00 ; $00
	db $30,$FE,$02 ; $01
		
OBJLstHdrA_Yuri_Win1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Win1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Yuri_Win5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Win5_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Yuri_Win7:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Win7 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $20,$F8,$02 ; $01
	db $20,$00,$04 ; $02
	db $30,$F8,$06 ; $03
	db $30,$00,$08 ; $04
		
OBJLstHdrA_Yuri_KoOuKen0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KoOuKen0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F6,$00 ; $00
	db $21,$FE,$02 ; $01
	db $21,$06,$04 ; $02
	db $31,$F6,$06 ; $03
	db $31,$FE,$08 ; $04
	db $31,$06,$0A ; $05
	db $11,$06,$0C ; $06
		
OBJLstHdrA_Yuri_KoOuKen1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KoOuKen1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_SaiHa4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_SaiHa4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $28,$F4,$04 ; $02
		
OBJLstHdrB_Yuri_SaiHa1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_SaiHa1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $28,$0A,$04 ; $02
	db $38,$02,$06 ; $03
	db $38,$FA,$08 ; $04
		
OBJLstHdrA_Yuri_SaiHa1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_SaiHa1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $28,$EA,$08 ; $04
	db $28,$F2,$0A ; $05
		
OBJLstHdrA_Yuri_SaiHa2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_SaiHa2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $28,$EA,$08 ; $04
	db $28,$F2,$0A ; $05
		
OBJLstHdrA_Yuri_SaiHa3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_SaiHa3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $28,$EA,$08 ; $04
	db $28,$F2,$0A ; $05
		
OBJLstHdrA_Yuri_Strike0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Strike0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrB_Yuri_Strike0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_Strike0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F3,$00 ; $00
	db $30,$FB,$02 ; $01
	db $38,$03,$04 ; $02
		
OBJLstHdrA_Yuri_HyakuRetsuBintaL4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HyakuRetsuBintaL4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EF,$00 ; $00
	db $20,$F7,$02 ; $01
	db $20,$FF,$04 ; $02
		
OBJLstHdrA_Yuri_HyakuRetsuBintaL5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HyakuRetsuBintaL5_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrA_Yuri_Strike1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Strike1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E7,$00 ; $00
	db $20,$EF,$02 ; $01
	db $20,$F7,$04 ; $02
	db $20,$FF,$06 ; $03
		
OBJLstHdrA_Yuri_Strike2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_Strike2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Yuri_KuuGaH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_01 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KuuGaH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $35,$F9,$00 ; $00
	db $35,$01,$02 ; $01
	db $35,$09,$04 ; $02
	db $25,$F9,$06 ; $03
	db $25,$01,$08 ; $04
	db $25,$09,$0A ; $05
	db $35,$11,$0C ; $06
		
OBJLstHdrA_Yuri_KuuGaL2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_15 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KuuGaL2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$F0,$00 ; $00
	db $11,$F8,$02 ; $01
	db $29,$F0,$04 ; $02
	db $21,$F8,$06 ; $03
	db $21,$00,$08 ; $04
	db $31,$F8,$0A ; $05
	db $31,$00,$0C ; $06
		
OBJLstHdrA_Yuri_HaohShoukouKen0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HaohShoukouKen0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $38,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Yuri_HaohShoukouKen1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HaohShoukouKen1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FB,$00 ; $00
	db $18,$FB,$02 ; $01
	db $18,$03,$04 ; $02
	db $28,$03,$06 ; $03
	db $28,$0B,$08 ; $04
		
OBJLstHdrB_Yuri_ChargeMeter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrB_Yuri_ThrowG11_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Yuri_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Yuri_ChargeMeter0_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_HaohShoukouKen2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HaohShoukouKen2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EA,$00 ; $00
	db $30,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
	db $20,$FA,$06 ; $03
	db $20,$02,$08 ; $04
	db $30,$F2,$0A ; $05
	db $30,$FA,$0C ; $06
	db $30,$02,$0E ; $07
		
OBJLstHdrA_Yuri_HienHouOuKyaKu5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HienHouOuKyaKu5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $28,$03,$04 ; $02
	db $30,$EB,$06 ; $03
	db $30,$F3,$08 ; $04
	db $30,$FB,$0A ; $05
		
OBJLstHdrA_Yuri_HienHouOuKyaKu6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_HienHouOuKyaKu6 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F6,$00 ; $00
	db $1C,$FE,$02 ; $01
	db $1C,$06,$04 ; $02
	db $34,$EE,$06 ; $03
	db $2C,$F6,$08 ; $04
	db $2C,$FE,$0A ; $05
	db $24,$EE,$0C ; $06
		
OBJLstHdrA_Yuri_KickFH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickFH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F4,$00 ; $00
	db $28,$FC,$02 ; $01
	db $28,$04,$04 ; $02
	db $28,$0C,$06 ; $03
	db $38,$FC,$08 ; $04
	db $38,$04,$0A ; $05
		
OBJLstHdrA_Yuri_ThrowG1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickFH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_KickFH1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Yuri_ThrowG3:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Yuri_KickFH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Yuri_KickFH1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset