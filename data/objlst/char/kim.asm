OBJLstPtrTable_Kim_Idle:
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Idle2_A, OBJLstHdrB_Kim_Idle2_B
	dw OBJLstHdrA_Kim_Idle1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_WalkF:
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_WalkF2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_WalkB:
	dw OBJLstHdrA_Kim_WalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Crouch:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_CrouchWalkF:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_CrouchWalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_CrouchWalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_CrouchWalkF1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_JumpN:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_JumpF:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B ;X
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_JumpB:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B ;X
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_BlockG:
	dw OBJLstHdrA_Kim_BlockG0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_BlockC:
	dw OBJLstHdrA_Kim_BlockC0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HopF:
	dw OBJLstHdrA_Kim_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_WalkF1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HopB:
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_ChargeMeter:
	dw OBJLstHdrA_Kim_ChargeMeter0_A, OBJLstHdrB_Kim_ChargeMeter0_B
	dw OBJLstHdrA_Kim_ChargeMeter1_A, OBJLstHdrB_Kim_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchLN:
	dw OBJLstHdrA_Kim_PunchLN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchLN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchLM:
	dw OBJLstHdrA_Kim_PunchLN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchLN0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchHN:
	dw OBJLstHdrA_Kim_PunchHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchHM:
	dw OBJLstHdrA_Kim_PunchHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHM2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickLN:
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_KickLN1_A, OBJLstHdrB_Kim_KickLN1_B
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickLM:
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickHN:
	dw OBJLstHdrA_Kim_KickHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickHM:
	dw OBJLstHdrA_Kim_PunchHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHM2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickHM4_A, OBJLstHdrB_Kim_KickHM4_B
	dw OBJLstHdrA_Kim_CrouchWalkF1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchCL:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_PunchCL1_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchCH:
	dw OBJLstHdrA_Kim_PunchCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickCL:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickCH:
	dw OBJLstHdrA_Kim_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickCH0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchALI:
	dw OBJLstHdrA_Kim_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_PunchAHI:
	dw OBJLstHdrA_Kim_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickALI:
	dw OBJLstHdrA_Kim_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_KickAHI:
	dw OBJLstHdrA_Kim_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_AttackA:
	dw OBJLstHdrA_Kim_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Strike:
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_KickHM4_A, OBJLstHdrB_Kim_Strike1_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Dodge:
	dw OBJLstHdrA_Kim_Dodge0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_DodgeCounter:
	dw OBJLstHdrA_Kim_Dodge0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_DodgeCounter1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_DodgeCounter2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_DodgeCounter1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Hit0Mid:
	dw OBJLstHdrA_Kim_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Dizzy:
	dw OBJLstHdrA_Kim_Hit0Mid0, OBJLSTPTR_NONE
OBJLstPtrTable_Kim_Hit1Mid:
	dw OBJLstHdrA_Kim_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HitLow:
	dw OBJLstHdrA_Kim_HitLow0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_LaunchUBRec:
	dw OBJLstHdrA_Kim_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_LaunchUB:
	dw OBJLstHdrA_Kim_Hit0Mid0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_LaunchSwoopup:
	dw OBJLstHdrA_Kim_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchSwoopup1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchSwoopup2, OBJLSTPTR_NONE
OBJLstPtrTable_Kim_LaunchDBShake:
	dw OBJLstHdrA_Kim_LaunchDBShake3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchDBShake3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HitSweep:
	dw OBJLstHdrA_Kim_Hit1Mid1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_LaunchUB1, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Kim_LaunchUB2, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_GrabUBNoSync:
	dw OBJLstHdrA_Kim_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Wakeup:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Intro:
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Idle2_A, OBJLstHdrB_Kim_Idle2_B
	dw OBJLstHdrA_Kim_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Idle0_A, OBJLstHdrB_Kim_Idle0_B
	dw OBJLstHdrA_Kim_Intro5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Intro6_A, OBJLstHdrB_Kim_Intro6_B
	dw OBJLstHdrA_Kim_Intro7_A, OBJLstHdrB_Kim_Intro6_B
	dw OBJLstHdrA_Kim_Intro8, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_ChargeMeter1_A, OBJLstHdrB_Kim_ChargeMeter0_B
	dw OBJLstHdrA_Kim_ChargeMeter0_A, OBJLstHdrB_Kim_ChargeMeter0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Taunt:
	dw OBJLstHdrA_Kim_Taunt0_A, OBJLstHdrB_Kim_Taunt0_B
	dw OBJLstHdrA_Kim_Taunt1_A, OBJLstHdrB_Kim_Taunt0_B
	dw OBJLstHdrA_Kim_Taunt2_A, OBJLstHdrB_Kim_Taunt0_B
	dw OBJLstHdrA_Kim_Taunt0_A, OBJLstHdrB_Kim_Taunt0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_Win:
	dw OBJLstHdrA_Kim_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Win1_A, OBJLstHdrB_Kim_Win1_B
	dw OBJLstHdrA_Kim_Win2_A, OBJLstHdrB_Kim_Win1_B
	dw OBJLstHdrA_Kim_Win3_A, OBJLstHdrB_Kim_Win1_B
	dw OBJLstHdrA_Kim_Win4_A, OBJLstHdrB_Kim_Win4_B
	dw OBJLstHdrA_Kim_Win5_A, OBJLstHdrB_Kim_Win4_B
	dw OBJLstHdrA_Kim_Win6_A, OBJLstHdrB_Kim_Win4_B
	dw OBJLstHdrA_Kim_Win4_A, OBJLstHdrB_Kim_Win4_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_LostTimeover:
	dw OBJLstHdrA_Kim_Hit1Mid1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HanGetsuZan:
	dw OBJLstHdrA_Kim_HanGetsuZan0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_HanGetsuZan1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_HanGetsuZan3_A, OBJLstHdrB_Kim_HanGetsuZan3_B
	dw OBJLstHdrA_Kim_HanGetsuZan4_A, OBJLstHdrB_Kim_HanGetsuZan3_B
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HienZan:
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_HienZan1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_HienZan2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HishouKyaku:
	dw OBJLstHdrA_Kim_HishouKyaku0_A, OBJLstHdrB_Kim_HishouKyaku0_B
	dw OBJLstHdrA_Kim_HishouKyaku0_A, OBJLstHdrB_Kim_HishouKyaku1_B
	dw OBJLstHdrA_Kim_HishouKyaku0_A, OBJLstHdrB_Kim_HishouKyaku0_B
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_RyuuseiRanku:
	dw OBJLstHdrA_Kim_RyuuseiRanku0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_RyuuseiRanku2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_RyuuseiRanku3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_HouOuKyaku:
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLstHdrA_Kim_HouOuKyaku1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickLM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickLN1_A, OBJLstHdrB_Kim_KickLN1_B
	dw OBJLstHdrA_Kim_KickHN0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickCH0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_PunchHM2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_KickHM4_A, OBJLstHdrB_Kim_KickHM4_B
	dw OBJLstHdrA_Kim_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_Crouch0_A, OBJLstHdrB_Kim_Crouch0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Kim_ThrowG:
	dw OBJLstHdrA_Kim_ThrowG0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Kim_ThrowG2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Kim_Idle0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Idle0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
		
OBJLstHdrB_Kim_Idle0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Idle0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F5,$00 ; $00
	db $30,$FD,$02 ; $01
	db $30,$05,$04 ; $02
		
OBJLstHdrA_Kim_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$02,$0A ; $05
	db $38,$FA,$0C ; $06
		
OBJLstHdrA_Kim_Idle2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Idle2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrB_Kim_Idle2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Idle2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F5,$00 ; $00
	db $38,$FD,$02 ; $01
	db $38,$05,$04 ; $02
		
OBJLstHdrA_Kim_WalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_WalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1F,$F4,$00 ; $00
	db $1F,$FC,$02 ; $01
	db $1F,$04,$04 ; $02
	db $2F,$F4,$06 ; $03
	db $2F,$FC,$08 ; $04
	db $37,$04,$0A ; $05
		
OBJLstHdrA_Kim_WalkF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_WalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kim_Crouch0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Crouch0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
		
OBJLstHdrB_Kim_Crouch0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Crouch0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F5,$00 ; $00
	db $38,$FD,$02 ; $01
		
OBJLstHdrA_Kim_CrouchWalkF1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_CrouchWalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F6,$00 ; $00
	db $28,$FE,$02 ; $01
	db $30,$06,$04 ; $02
	db $38,$F6,$06 ; $03
	db $38,$FE,$08 ; $04
		
OBJLstHdrA_Kim_JumpN3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_CrouchWalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_CrouchWalkF1.bin ; iOBJLstHdrA_DataPtr
	db $F4 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_JumpF3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_CrouchWalkF1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_CrouchWalkF1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_CrouchWalkF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_CrouchWalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F7,$00 ; $00
	db $28,$FF,$02 ; $01
	db $30,$07,$04 ; $02
	db $38,$F7,$06 ; $03
	db $38,$FF,$08 ; $04
		
OBJLstHdrA_Kim_JumpN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_JumpN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F6,$00 ; $00
	db $18,$FE,$02 ; $01
	db $18,$06,$04 ; $02
	db $28,$F6,$06 ; $03
	db $28,$FE,$08 ; $04
	db $38,$FE,$0A ; $05
		
OBJLstHdrA_Kim_JumpF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrA_Kim_JumpF4:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_JumpF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_JumpF2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_BlockG0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_BlockG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $38,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Kim_BlockC0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_BlockC0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F7,$00 ; $00
	db $28,$FF,$02 ; $01
	db $38,$F7,$04 ; $02
	db $38,$FF,$06 ; $03
	db $38,$07,$08 ; $04
		
OBJLstHdrA_Kim_Hit0Mid0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Hit0Mid0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FB,$00 ; $00
	db $20,$03,$02 ; $01
	db $30,$F3,$04 ; $02
	db $30,$FB,$06 ; $03
	db $30,$03,$08 ; $04
	db $20,$F3,$0A ; $05
		
OBJLstHdrA_Kim_Hit1Mid1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kim_LaunchDBShake3:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_LaunchSwoopup2:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_LaunchSwoopup1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Hit1Mid1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_Hit1Mid1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_HitLow0: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HitLow0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $30,$F2,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
		
OBJLstHdrA_Kim_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $28,$0A,$06 ; $03
	db $38,$02,$08 ; $04
	db $38,$0A,$0A ; $05
	db $40,$F2,$0C ; $06
		
OBJLstHdrA_Kim_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $30,$FA,$04 ; $02
	db $30,$02,$06 ; $03
	db $30,$0A,$08 ; $04
		
OBJLstHdrA_Kim_PunchLN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchLN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F5,$00 ; $00
	db $21,$FD,$02 ; $01
	db $21,$05,$04 ; $02
	db $31,$F5,$06 ; $03
	db $31,$FD,$08 ; $04
	db $31,$05,$0A ; $05
		
OBJLstHdrA_Kim_PunchLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kim_PunchLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E9,$00 ; $00
	db $20,$F1,$02 ; $01
	db $20,$F9,$04 ; $02
	db $28,$01,$06 ; $03
	db $30,$F1,$08 ; $04
	db $30,$F9,$0A ; $05
	db $38,$01,$0C ; $06
		
OBJLstHdrA_Kim_PunchHM2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
	db $20,$FA,$06 ; $03
	db $30,$EA,$08 ; $04
	db $30,$F2,$0A ; $05
		
OBJLstHdrA_Kim_PunchHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Kim_PunchHM2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Kim_PunchHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$DD,$00 ; $00
	db $20,$E5,$02 ; $01
	db $20,$ED,$04 ; $02
	db $20,$F5,$06 ; $03
	db $30,$ED,$08 ; $04
	db $30,$F5,$0A ; $05
		
OBJLstHdrA_Kim_PunchHN2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchHN2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Kim_PunchHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$E9,$00 ; $00
	db $21,$F1,$02 ; $01
	db $21,$F9,$04 ; $02
	db $29,$01,$06 ; $03
	db $31,$F1,$08 ; $04
	db $31,$F9,$0A ; $05
		
OBJLstHdrA_Kim_KickLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$02,$00 ; $00
	db $20,$0A,$02 ; $01
	db $30,$02,$04 ; $02
	db $30,$0A,$06 ; $03
		
OBJLstHdrB_Kim_KickLN1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_KickLN1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
		
OBJLstHdrA_Kim_KickLM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickLM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E3,$00 ; $00
	db $18,$EB,$02 ; $01
	db $18,$F3,$04 ; $02
	db $20,$FB,$06 ; $03
	db $20,$03,$08 ; $04
	db $28,$E3,$0A ; $05
	db $28,$EB,$0C ; $06
	db $28,$F3,$0E ; $07
	db $38,$F3,$10 ; $08
		
OBJLstHdrA_Kim_KickHN0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickHN0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $11,$F2,$00 ; $00
	db $19,$FA,$02 ; $01
	db $21,$02,$04 ; $02
	db $21,$F2,$06 ; $03
	db $29,$FA,$08 ; $04
	db $39,$FA,$0A ; $05
		
OBJLstHdrA_Kim_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1E,$E6,$00 ; $00
	db $1E,$EE,$02 ; $01
	db $16,$F6,$04 ; $02
	db $2E,$EE,$06 ; $03
	db $26,$F6,$08 ; $04
	db $36,$F6,$0A ; $05
	db $1E,$FE,$0C ; $06
	db $36,$FE,$0E ; $07
		
OBJLstHdrA_Kim_KickHM4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickHM4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $28,$FA,$06 ; $03
	db $30,$F2,$08 ; $04
	db $38,$FA,$0A ; $05
		
OBJLstHdrB_Kim_KickHM4_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_KickHM4_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E2,$00 ; $00
	db $20,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
		
OBJLstHdrA_Kim_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EA,$00 ; $00
	db $28,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
		
OBJLstHdrA_Kim_PunchCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
	db $30,$04,$06 ; $03
	db $38,$EC,$08 ; $04
	db $38,$F4,$0A ; $05
		
OBJLstHdrA_Kim_PunchCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$E2,$00 ; $00
	db $38,$EA,$02 ; $01
	db $28,$F2,$04 ; $02
	db $28,$FA,$06 ; $03
	db $38,$F2,$08 ; $04
	db $38,$FA,$0A ; $05
		
OBJLstHdrA_Kim_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F5,$00 ; $00
	db $28,$FD,$02 ; $01
	db $28,$05,$04 ; $02
	db $38,$ED,$06 ; $03
	db $38,$F5,$08 ; $04
	db $38,$FD,$0A ; $05
	db $38,$05,$0C ; $06
		
OBJLstHdrA_Kim_KickCH0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickCH0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FA,$00 ; $00
	db $28,$02,$02 ; $01
	db $28,$0A,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
	db $38,$0A,$0A ; $05
		
OBJLstHdrA_Kim_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $28,$0A,$08 ; $04
	db $30,$F2,$0A ; $05
	db $38,$FA,$0C ; $06
	db $38,$02,$0E ; $07
	db $38,$0A,$10 ; $08
		
OBJLstHdrA_Kim_PunchALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $1C,$FE,$04 ; $02
	db $1C,$06,$06 ; $03
	db $2C,$F6,$08 ; $04
	db $2C,$FE,$0A ; $05
		
OBJLstHdrA_Kim_PunchAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_PunchAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $18,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $28,$F2,$08 ; $04
	db $28,$FA,$0A ; $05
	db $30,$02,$0C ; $06
		
OBJLstHdrA_Kim_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$EE,$00 ; $00
	db $18,$F6,$02 ; $01
	db $18,$FE,$04 ; $02
	db $28,$F6,$06 ; $03
	db $28,$FE,$08 ; $04
	db $38,$FE,$0A ; $05
	db $38,$F6,$0C ; $06
		
OBJLstHdrA_Kim_KickAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_KickAHI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $31,$EA,$00 ; $00
	db $21,$F2,$02 ; $01
	db $19,$FA,$04 ; $02
	db $19,$02,$06 ; $03
	db $19,$0A,$08 ; $04
	db $31,$F2,$0A ; $05
	db $29,$FA,$0C ; $06
	db $29,$02,$0E ; $07
		
OBJLstHdrA_Kim_Dodge0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Dodge0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $30,$EE,$04 ; $02
	db $30,$F6,$06 ; $03
		
OBJLstHdrA_Kim_DodgeCounter1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_DodgeCounter1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $28,$FA,$04 ; $02
	db $30,$EA,$06 ; $03
	db $30,$F2,$08 ; $04
		
OBJLstHdrA_Kim_DodgeCounter2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_DodgeCounter2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1F,$E3,$00 ; $00
	db $27,$EB,$02 ; $01
	db $1F,$F3,$04 ; $02
	db $17,$FB,$06 ; $03
	db $1F,$03,$08 ; $04
	db $2F,$F3,$0A ; $05
	db $27,$FB,$0C ; $06
	db $2F,$03,$0E ; $07
		
OBJLstHdrA_Kim_ThrowG0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_ThrowG0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
	db $28,$0A,$04 ; $02
	db $38,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Kim_ThrowG1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_ThrowG1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F7,$00 ; $00
	db $20,$FF,$02 ; $01
	db $20,$07,$04 ; $02
	db $38,$F7,$06 ; $03
	db $30,$FF,$08 ; $04
	db $30,$07,$0A ; $05
		
OBJLstHdrA_Kim_ThrowG2:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_ThrowG2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $28,$02,$06 ; $03
	db $38,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
	db $38,$02,$0C ; $06
		
OBJLstHdrA_Kim_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrB_Kim_ChargeMeter0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_ChargeMeter0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F2,$00 ; $00
	db $38,$FA,$02 ; $01
	db $38,$02,$04 ; $02
		
OBJLstHdrA_Kim_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $28,$02,$04 ; $02
	db $18,$FA,$06 ; $03
		
OBJLstHdrB_Kim_Strike1_B: ;X
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Strike1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$E2,$00 ; $00
	db $28,$EA,$02 ; $01
	db $20,$F2,$04 ; $02
		
OBJLstHdrA_Kim_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$EA,$06 ; $03
	db $28,$F2,$08 ; $04
	db $28,$FA,$0A ; $05
	db $30,$02,$0C ; $06
		
OBJLstHdrA_Kim_Intro5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Intro5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
	db $38,$02,$0A ; $05
		
OBJLstHdrA_Kim_Intro6_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Intro6_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F5,$00 ; $00
	db $20,$FD,$02 ; $01
	db $10,$F5,$04 ; $02
	db $10,$FD,$06 ; $03
		
OBJLstHdrB_Kim_Intro6_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Intro6_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F7,$00 ; $00
	db $30,$FF,$02 ; $01
		
OBJLstHdrA_Kim_Intro7_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Intro7_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $10,$F6,$06 ; $03
	db $10,$FE,$08 ; $04
		
OBJLstHdrA_Kim_Intro8:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Intro8 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$EE,$00 ; $00
	db $1C,$F6,$02 ; $01
	db $1C,$FE,$04 ; $02
	db $2C,$F6,$06 ; $03
	db $2C,$FE,$08 ; $04
	db $3C,$F6,$0A ; $05
	db $3C,$FE,$0C ; $06
		
OBJLstHdrA_Kim_Taunt0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Taunt0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $18,$F6,$08 ; $04
	db $18,$FE,$0A ; $05
		
OBJLstHdrB_Kim_Taunt0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Taunt0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F6,$00 ; $00
	db $38,$FE,$02 ; $01
		
OBJLstHdrA_Kim_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $18,$F6,$08 ; $04
	db $18,$FE,$0A ; $05
		
OBJLstHdrA_Kim_Taunt2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Taunt2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $18,$F6,$08 ; $04
	db $18,$FE,$0A ; $05
		
OBJLstHdrA_Kim_Win1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
		
OBJLstHdrB_Kim_Win1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Win1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F8,$00 ; $00
	db $18,$00,$02 ; $01
	db $28,$F8,$04 ; $02
	db $28,$00,$06 ; $03
	db $38,$F8,$08 ; $04
	db $38,$00,$0A ; $05
		
OBJLstHdrA_Kim_Win2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win2_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
		
OBJLstHdrA_Kim_Win3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
		
OBJLstHdrA_Kim_Win4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
		
OBJLstHdrB_Kim_Win4_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_Win4_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$FA,$00 ; $00
	db $10,$02,$02 ; $01
	db $20,$F2,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
		
OBJLstHdrA_Kim_Win5_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win5_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
		
OBJLstHdrA_Kim_Win6_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_Win6_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FA,$00 ; $00
	db $20,$02,$02 ; $01
		
OBJLstHdrA_Kim_HanGetsuZan0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HanGetsuZan0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $26,$EB,$00 ; $00
	db $26,$F3,$02 ; $01
	db $26,$FB,$04 ; $02
	db $26,$03,$06 ; $03
	db $1E,$0B,$08 ; $04
	db $36,$FB,$0A ; $05
	db $36,$03,$0C ; $06
		
OBJLstHdrA_Kim_HanGetsuZan1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HanGetsuZan1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$FA,$00 ; $00
	db $18,$02,$02 ; $01
	db $28,$F2,$04 ; $02
	db $28,$FA,$06 ; $03
	db $28,$02,$08 ; $04
	db $30,$0A,$0A ; $05
	db $38,$F2,$0C ; $06
	db $38,$FA,$0E ; $07
		
OBJLstHdrA_Kim_HanGetsuZan3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HanGetsuZan3_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $30,$EA,$02 ; $01
		
OBJLstHdrB_Kim_HanGetsuZan3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_HanGetsuZan3_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F2,$00 ; $00
	db $28,$FA,$02 ; $01
	db $38,$F2,$04 ; $02
	db $38,$FA,$06 ; $03
	db $38,$02,$08 ; $04
	db $38,$0A,$0A ; $05
		
OBJLstHdrA_Kim_HanGetsuZan4_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HanGetsuZan4_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
		
OBJLstHdrA_Kim_HienZan1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HienZan1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $18,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $28,$FA,$08 ; $04
		
OBJLstHdrA_Kim_HienZan2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_25 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HienZan2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0D ; OBJ Count
	;    Y   X  ID+FLAG
	db $13,$EA,$00 ; $00
	db $0B,$F2,$02 ; $01
	db $0B,$FA,$04 ; $02
	db $0B,$02,$06 ; $03
	db $13,$0A,$08 ; $04
	db $23,$EA,$0A ; $05
	db $1B,$F2,$0C ; $06
	db $1B,$FA,$0E ; $07
	db $1B,$02,$10 ; $08
	db $23,$0A,$12 ; $09
	db $2B,$F2,$14 ; $0A
	db $2B,$FA,$16 ; $0B
	db $2B,$02,$18 ; $0C
		
OBJLstHdrA_Kim_HishouKyaku0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HishouKyaku0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F3,$00 ; $00
	db $18,$FB,$02 ; $01
	db $18,$03,$04 ; $02
		
OBJLstHdrB_Kim_HishouKyaku1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_HishouKyaku1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EF,$00 ; $00
	db $28,$F7,$02 ; $01
	db $28,$FF,$04 ; $02
	db $38,$F7,$06 ; $03
	db $28,$07,$08 ; $04
		
OBJLstHdrB_Kim_HishouKyaku0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Kim_HishouKyaku0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F0,$00 ; $00
	db $28,$F8,$02 ; $01
	db $28,$00,$04 ; $02
	db $28,$08,$06 ; $03
	db $38,$F0,$08 ; $04
	db $38,$F8,$0A ; $05
		
OBJLstHdrA_Kim_RyuuseiRanku0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_RyuuseiRanku0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EA,$00 ; $00
	db $30,$F2,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05
	db $30,$0A,$0C ; $06
		
OBJLstHdrA_Kim_RyuuseiRanku2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_RyuuseiRanku2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $10,$FA,$00 ; $00
	db $10,$02,$02 ; $01
	db $20,$FA,$04 ; $02
	db $20,$02,$06 ; $03
	db $30,$02,$08 ; $04
		
OBJLstHdrA_Kim_RyuuseiRanku3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_RyuuseiRanku3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $20,$0A,$06 ; $03
	db $30,$F2,$08 ; $04
	db $30,$FA,$0A ; $05
	db $30,$02,$0C ; $06
	db $30,$0A,$0E ; $07
	db $40,$02,$10 ; $08
		
OBJLstHdrA_Kim_HouOuKyaku1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Kim_HouOuKyaku1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F2,$00 ; $00
	db $20,$FA,$02 ; $01
	db $20,$02,$04 ; $02
	db $30,$F2,$06 ; $03
	db $30,$FA,$08 ; $04
	db $30,$02,$0A ; $05