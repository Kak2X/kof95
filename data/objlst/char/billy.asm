OBJLstPtrTable_Billy_Idle:
	dw OBJLstHdrA_Billy_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Idle1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Idle2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Idle1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_WalkF:
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_WalkB:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Crouch:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_CrouchWalkF:
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLstHdrA_Billy_CrouchWalkF1_A, OBJLstHdrB_Billy_CrouchWalkF1_B
	dw OBJLstHdrA_Billy_CrouchWalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_CrouchWalkF1_A, OBJLstHdrB_Billy_CrouchWalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_JumpN:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_BlockG:
	dw OBJLstHdrA_Billy_BlockG0_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_BlockC:
	dw OBJLstHdrA_Billy_BlockC0_A, OBJLstHdrB_Billy_BlockC0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Hit0Mid:
	dw OBJLstHdrA_Billy_Hit0Mid0_A, OBJLstHdrB_Billy_Hit0Mid0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Dizzy:
	dw OBJLstHdrA_Billy_Hit0Mid0_A, OBJLstHdrB_Billy_Hit0Mid0_B
OBJLstPtrTable_Billy_Hit1Mid:
	dw OBJLstHdrA_Billy_Hit1Mid1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_HitLow:
	dw OBJLstHdrA_Billy_HitLow0_A, OBJLstHdrB_Billy_Hit0Mid0_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_LaunchUBRec:
	dw OBJLstHdrA_Billy_Hit0Mid0_A, OBJLstHdrB_Billy_Hit0Mid0_B ;X
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_LaunchUB:
	dw OBJLstHdrA_Billy_Hit0Mid0_A, OBJLstHdrB_Billy_Hit0Mid0_B
	dw OBJLstHdrA_Billy_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_LaunchSwoopup:
	dw OBJLstHdrA_Billy_Hit1Mid1_A, OBJLstHdrB_Billy_WalkF1_B ;X
	dw OBJLstHdrA_Billy_LaunchSwoopup1_A, OBJLstHdrB_Billy_LaunchSwoopup1_B ;X
	dw OBJLstHdrA_Billy_LaunchSwoopup2_A, OBJLstHdrB_Billy_LaunchSwoopup2_B ;X
OBJLstPtrTable_Billy_LaunchDBShake:
	dw OBJLstHdrA_Billy_LaunchDBShake3_A, OBJLstHdrB_Billy_LaunchDBShake3_B
	dw OBJLstHdrA_Billy_LaunchDBShake3_A, OBJLstHdrB_Billy_LaunchDBShake3_B
	dw OBJLstHdrA_Billy_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_HitSweep:
	dw OBJLstHdrA_Billy_Hit1Mid1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_LaunchUB1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_LaunchUB2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_GrabUBNoSync:
	dw OBJLstHdrA_Billy_GrabUBNoSync0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Wakeup:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_HopF:
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_HopB:
	dw OBJLstHdrA_Billy_Hit1Mid1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_ChargeMeter:
	dw OBJLstHdrA_Billy_ChargeMeter0_A, OBJLstHdrB_Billy_BlockC0_B
	dw OBJLstHdrA_Billy_ChargeMeter1_A, OBJLstHdrB_Billy_BlockC0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchLN:
	dw OBJLstHdrA_Billy_PunchLN0_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchLN1_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchLN0_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchLM:
	dw OBJLstHdrA_Billy_PunchLM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchLM1_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchLM0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchHN:
	dw OBJLstHdrA_Billy_PunchLN0_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchLN0_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchHM:
	dw OBJLstHdrA_Billy_PunchHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchLM1_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchHM2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickLN:
	dw OBJLstHdrA_Billy_Idle0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickLN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Idle0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickHN:
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickHN1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickHM:
	dw OBJLstHdrA_Billy_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickHM1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchCL:
	dw OBJLstHdrA_Billy_PunchCL0_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_PunchCL1_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLstHdrA_Billy_PunchCL0_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchCH:
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLstHdrA_Billy_PunchCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickCL:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_KickCL1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickCH:
	dw OBJLstHdrA_Billy_CrouchWalkF2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickCH1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_CrouchWalkF2, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchALI:
	dw OBJLstHdrA_Billy_PunchALI0_A, OBJLstHdrB_Billy_PunchALI0_B
	dw OBJLstHdrA_Billy_PunchALI0_A, OBJLstHdrB_Billy_PunchALI0_B
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchALX:
	dw OBJLstHdrA_Billy_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchALX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_PunchAHX:
	dw OBJLstHdrA_Billy_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchAHX0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickALI:
	dw OBJLstHdrA_Billy_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickALI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickAHI:
	dw OBJLstHdrA_Billy_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickAHI0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_AttackA:
	dw OBJLstHdrA_Billy_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_AttackA0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_JumpN3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Strike:
	dw OBJLstHdrA_Billy_Strike0, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_PunchLM1_A, OBJLstHdrB_Billy_PunchLN0_B ;X
	dw OBJLstHdrA_Billy_Strike2, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Billy_PunchHM0, OBJLSTPTR_NONE ;X
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Dodge:
	dw OBJLstHdrA_Billy_KickHM0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_DodgeCounter:
	dw OBJLstHdrA_Billy_KickHM0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_DodgeCounter1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickHM0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Intro:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChargeMeter0_A, OBJLstHdrB_Billy_BlockC0_B
	dw OBJLstHdrA_Billy_ChargeMeter1_A, OBJLstHdrB_Billy_BlockC0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Taunt:
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_Win:
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt1_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Taunt0_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLstHdrA_Billy_Win7_A, OBJLstHdrB_Billy_Taunt0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_LostTimeover:
	dw OBJLstHdrA_Billy_Hit1Mid1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_SansetsuKonChuudanUchi:
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi1_A, OBJLstHdrB_Billy_SansetsuKonChuudanUchi1_B
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi2_A, OBJLstHdrB_Billy_SansetsuKonChuudanUchi2_B
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi3_A, OBJLstHdrB_Billy_SansetsuKonChuudanUchi3_B
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi2_A, OBJLstHdrB_Billy_SansetsuKonChuudanUchi2_B
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi1_A, OBJLstHdrB_Billy_SansetsuKonChuudanUchi1_B
	dw OBJLstHdrA_Billy_PunchLM0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_SenpuuKon:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Intro3, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_SuzumeOtoshi:
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLstHdrA_Billy_SuzumeOtoshi1_A, OBJLstHdrB_Billy_SuzumeOtoshi1_B
	dw OBJLstHdrA_Billy_SuzumeOtoshi1_A, OBJLstHdrB_Billy_SuzumeOtoshi2_B
	dw OBJLstHdrA_Billy_SuzumeOtoshi1_A, OBJLstHdrB_Billy_SuzumeOtoshi3_B
	dw OBJLstHdrA_Billy_SuzumeOtoshi1_A, OBJLstHdrB_Billy_SuzumeOtoshi2_B
	dw OBJLstHdrA_Billy_SuzumeOtoshi1_A, OBJLstHdrB_Billy_SuzumeOtoshi1_B
	dw OBJLstHdrA_Billy_PunchLN0_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KyoushuuHishouKon:
	dw OBJLstHdrA_Billy_KyoushuuHishouKon0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_ChouKaenSenpuuKon:
	dw OBJLstHdrA_Billy_WalkF1_A, OBJLstHdrB_Billy_WalkF1_B
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ChouKaenSenpuuKon4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_PunchLM1_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_PunchHM2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_Strike0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_KickFH:
	dw OBJLstHdrA_Billy_KyoushuuHishouKon1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KickFH2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_WalkF0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_CrouchWalkF0_A, OBJLstHdrB_Billy_CrouchWalkF0_B
	dw OBJLSTPTR_NONE
		

OBJLstPtrTable_Billy_ThrowG:
	dw OBJLstHdrA_Billy_PunchLM1_A, OBJLstHdrB_Billy_PunchLN0_B
	dw OBJLstHdrA_Billy_ThrowG1, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ThrowG2, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ThrowG3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_KyoushuuHishouKon0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Billy_ThrowG5_A, OBJLstHdrB_Billy_LaunchSwoopup1_B
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Billy_Idle0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Idle0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F4,$00 ; $00
	db $19,$FC,$02 ; $01
	db $21,$04,$04 ; $02
	db $31,$F4,$06 ; $03
	db $29,$FC,$08 ; $04
	db $31,$04,$0A ; $05
		
OBJLstHdrA_Billy_Idle1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Idle1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $21,$F3,$00 ; $00
	db $19,$FB,$02 ; $01
	db $21,$03,$04 ; $02
	db $31,$F3,$06 ; $03
	db $29,$FB,$08 ; $04
	db $31,$03,$0A ; $05
		
OBJLstHdrA_Billy_Idle2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Idle2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F2,$00 ; $00
	db $1A,$FA,$02 ; $01
	db $22,$02,$04 ; $02
	db $32,$F2,$06 ; $03
	db $2A,$FA,$08 ; $04
	db $32,$02,$0A ; $05
		
OBJLstHdrA_Billy_WalkF0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $28,$06,$06 ; $03
	db $30,$F6,$08 ; $04
	db $30,$FE,$0A ; $05
		
OBJLstHdrA_Billy_KyoushuuHishouKon0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_WalkF0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_KyoushuuHishouKon3:
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_WalkF0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_ThrowG1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_WalkF0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_WalkF1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$EC,$04 ; $02
	db $18,$F4,$06 ; $03
	db $18,$FC,$08 ; $04
		
OBJLstHdrA_Billy_ThrowG5_A:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_WalkF1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_WalkF1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Billy_WalkF1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$04,$00 ; $00
	db $38,$F4,$02 ; $01
	db $38,$FC,$04 ; $02
	db $38,$04,$06 ; $03
	db $38,$EC,$08 ; $04
		
OBJLstHdrB_Billy_LaunchDBShake3_B:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Billy_WalkF1_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Billy_LaunchSwoopup2_B: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Billy_WalkF1_B.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Billy_LaunchSwoopup1_B:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_WalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrB_Billy_WalkF1_B.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_CrouchWalkF0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_CrouchWalkF0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F0,$00 ; $00
	db $28,$F8,$02 ; $01
	db $28,$00,$04 ; $02
	db $28,$08,$06 ; $03
	db $18,$F8,$08 ; $04
		
OBJLstHdrA_Billy_CrouchWalkF1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_CrouchWalkF0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EF,$00 ; $00
	db $28,$F7,$02 ; $01
	db $28,$FF,$04 ; $02
	db $28,$07,$06 ; $03
	db $18,$F7,$08 ; $04
		
OBJLstHdrB_Billy_CrouchWalkF0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_CrouchWalkF0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F0,$00 ; $00
	db $38,$F8,$02 ; $01
	db $38,$00,$04 ; $02
	db $38,$08,$06 ; $03
		
OBJLstHdrB_Billy_CrouchWalkF1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_CrouchWalkF1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EF,$00 ; $00
	db $38,$F7,$02 ; $01
	db $38,$FF,$04 ; $02
	db $38,$07,$06 ; $03
		
OBJLstHdrA_Billy_CrouchWalkF2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_CrouchWalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $30,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
	db $38,$04,$0C ; $06
		
OBJLstHdrA_Billy_JumpN3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_CrouchWalkF2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_CrouchWalkF2.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_BlockG0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_BlockG0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F3,$00 ; $00
	db $28,$FB,$02 ; $01
	db $28,$03,$04 ; $02
	db $18,$FB,$06 ; $03
	db $18,$03,$08 ; $04
		
OBJLstHdrA_Billy_BlockC0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_BlockC0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F6,$00 ; $00
	db $28,$FE,$02 ; $01
	db $28,$06,$04 ; $02
	db $28,$0E,$06 ; $03
	db $18,$FE,$08 ; $04
		
OBJLstHdrA_Billy_Hit0Mid0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Hit0Mid0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F5,$00 ; $00
	db $28,$FD,$02 ; $01
	db $28,$05,$04 ; $02
	db $18,$FD,$06 ; $03
	db $18,$05,$08 ; $04
	db $20,$0D,$0A ; $05
		
OBJLstHdrB_Billy_Hit0Mid0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_Hit0Mid0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F4,$00 ; $00
	db $38,$FC,$02 ; $01
	db $38,$04,$04 ; $02
		
OBJLstHdrA_Billy_Hit1Mid1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EB,$00 ; $00
	db $28,$F3,$02 ; $01
	db $28,$FB,$04 ; $02
	db $28,$03,$06 ; $03
	db $18,$FB,$08 ; $04
	db $18,$03,$0A ; $05
		
OBJLstHdrA_Billy_LaunchDBShake3_A:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_LaunchSwoopup2_A: ;X
	db OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $08 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_LaunchSwoopup1_A: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Hit1Mid1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_Hit1Mid1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_HitLow0_A: ;X
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_HitLow0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F5,$00 ; $00
	db $28,$FD,$02 ; $01
	db $28,$05,$04 ; $02
	db $18,$FD,$06 ; $03
	db $18,$05,$08 ; $04
		
OBJLstHdrA_Billy_LaunchUB2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_LaunchUB2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $32,$EC,$00 ; $00
	db $32,$F4,$02 ; $01
	db $32,$FC,$04 ; $02
	db $32,$04,$06 ; $03
	db $32,$0C,$08 ; $04
		
OBJLstHdrA_Billy_LaunchUB1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $1E,$F2,$00 ; $00
	db $1E,$FA,$02 ; $01
	db $26,$02,$04 ; $02
	db $2E,$0A,$06 ; $03
	db $2E,$F2,$08 ; $04
	db $2E,$FA,$0A ; $05
	db $36,$02,$0C ; $06
		
OBJLstHdrA_Billy_GrabUBNoSync0:
	db OLF_XFLIP|OLF_YFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_LaunchUB1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_LaunchUB1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_PunchLN0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLN0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EE,$00 ; $00
	db $28,$F6,$02 ; $01
	db $28,$FE,$04 ; $02
	db $18,$F6,$06 ; $03
	db $18,$FE,$08 ; $04
		
OBJLstHdrB_Billy_PunchLN0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_PunchLN0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F1,$00 ; $00
	db $38,$F9,$02 ; $01
	db $38,$01,$04 ; $02
	db $38,$09,$06 ; $03
		
OBJLstHdrA_Billy_PunchLN1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLN1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
	db $18,$EC,$06 ; $03
	db $18,$F4,$08 ; $04
	db $18,$FC,$0A ; $05
		
OBJLstHdrA_Billy_PunchLM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $22,$F4,$00 ; $00
	db $1A,$FC,$02 ; $01
	db $22,$04,$04 ; $02
	db $2A,$EC,$06 ; $03
	db $32,$F4,$08 ; $04
	db $2A,$FC,$0A ; $05
	db $32,$04,$0C ; $06
		
OBJLstHdrA_Billy_SansetsuKonChuudanUchi0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_PunchLM0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_PunchLM1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
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
		
OBJLstHdrA_Billy_PunchALI0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchLM1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_PunchLM1_A.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_PunchHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$E0,$00 ; $00
	db $24,$E8,$02 ; $01
	db $24,$F0,$04 ; $02
	db $24,$F8,$06 ; $03
	db $34,$F0,$08 ; $04
	db $34,$F8,$0A ; $05
	db $34,$00,$0C ; $06
		
OBJLstHdrA_Billy_ThrowG2:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_05 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_PunchHN1.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_DodgeCounter1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $24,$D8,$00 ; $00
	db $24,$E0,$02 ; $01
	db $24,$E8,$04 ; $02
	db $24,$F0,$06 ; $03
	db $34,$E8,$08 ; $04
	db $34,$F0,$0A ; $05
	db $34,$F8,$0C ; $06
		
OBJLstHdrA_Billy_PunchHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $30,$F4,$06 ; $03
	db $30,$FC,$08 ; $04
	db $30,$04,$0A ; $05
	db $10,$FC,$0C ; $06
		
OBJLstHdrA_Billy_Strike0:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_PunchHM0.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_PunchHM2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F4,$00 ; $00
	db $20,$FC,$02 ; $01
	db $18,$04,$04 ; $02
	db $28,$04,$06 ; $03
	db $28,$0C,$08 ; $04
	db $30,$F4,$0A ; $05
	db $30,$FC,$0C ; $06
	db $38,$04,$0E ; $07
	db $38,$EC,$10 ; $08
		
OBJLstHdrA_Billy_Strike2: ;X
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchHM2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_PunchHM2.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_KickLN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickLN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $38,$E2,$06 ; $03
	db $30,$EA,$08 ; $04
	db $30,$F2,$0A ; $05
	db $28,$FA,$0C ; $06
	db $30,$02,$0E ; $07
		
OBJLstHdrA_Billy_KickHN1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickHN1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$E4,$00 ; $00
	db $28,$EC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $20,$FC,$06 ; $03
	db $30,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
		
OBJLstHdrA_Billy_KickHM1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickHM1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$DD,$00 ; $00
	db $20,$E5,$02 ; $01
	db $28,$ED,$04 ; $02
	db $20,$F5,$06 ; $03
	db $30,$E5,$08 ; $04
	db $38,$ED,$0A ; $05
	db $30,$F5,$0C ; $06
	db $28,$FD,$0E ; $07
	db $18,$ED,$10 ; $08
		
OBJLstHdrA_Billy_PunchCL0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchCL0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$FC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$EC,$04 ; $02
	db $18,$F4,$06 ; $03
	db $18,$FC,$08 ; $04
		
OBJLstHdrA_Billy_PunchCL1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchCL1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $28,$F4,$02 ; $01
	db $28,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $18,$FC,$08 ; $04
	db $18,$F4,$0A ; $05
		
OBJLstHdrA_Billy_PunchCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$DC,$00 ; $00
	db $28,$E4,$02 ; $01
	db $28,$EC,$04 ; $02
	db $28,$F4,$06 ; $03
	db $38,$EC,$08 ; $04
	db $38,$F4,$0A ; $05
	db $30,$FC,$0C ; $06
	db $38,$04,$0E ; $07
		
OBJLstHdrA_Billy_KickCL1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickCL1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$E6,$00 ; $00
	db $38,$EE,$02 ; $01
	db $28,$F6,$04 ; $02
	db $28,$FE,$06 ; $03
	db $38,$F6,$08 ; $04
	db $38,$FE,$0A ; $05
	db $30,$06,$0C ; $06
		
OBJLstHdrA_Billy_KickCH1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$E3,$00 ; $00
	db $28,$EB,$02 ; $01
	db $38,$EB,$04 ; $02
	db $28,$F3,$06 ; $03
	db $28,$FB,$08 ; $04
	db $28,$03,$0A ; $05
	db $38,$F3,$0C ; $06
	db $38,$FB,$0E ; $07
	db $38,$03,$10 ; $08
		
OBJLstHdrA_Billy_KickAHI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickCH1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_KickCH1.bin ; iOBJLstHdrA_DataPtr
	db $F8 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Billy_PunchALI0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_PunchALI0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F2,$00 ; $00
	db $30,$FA,$02 ; $01
	db $30,$02,$04 ; $02
	db $30,$0A,$06 ; $03
		
OBJLstHdrA_Billy_PunchALX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchALX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $27,$EC,$00 ; $00
	db $1F,$F4,$02 ; $01
	db $1F,$FC,$04 ; $02
	db $27,$04,$06 ; $03
	db $2F,$F4,$08 ; $04
	db $2F,$FC,$0A ; $05
	db $37,$04,$0C ; $06
		
OBJLstHdrA_Billy_PunchAHX0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_PunchAHX0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $20,$04,$06 ; $03
	db $30,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
	db $30,$04,$0C ; $06
		
OBJLstHdrA_Billy_KickALI0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickALI0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E4,$00 ; $00
	db $20,$EC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $20,$FC,$06 ; $03
	db $30,$EC,$08 ; $04
	db $30,$F4,$0A ; $05
	db $30,$FC,$0C ; $06
	db $30,$04,$0E ; $07
		
OBJLstHdrA_Billy_KickHM0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $18,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $28,$F4,$06 ; $03
	db $30,$FC,$08 ; $04
	db $30,$EC,$0A ; $05
	db $38,$F4,$0C ; $06
		
OBJLstHdrA_Billy_KyoushuuHishouKon1:
	db OLF_XFLIP ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_ThrowG3.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_ThrowG3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickHM0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $18,$04,$02 ; $01
	db $20,$0C,$04 ; $02
	db $28,$04,$06 ; $03
	db $30,$0C,$08 ; $04
	db $30,$FC,$0A ; $05
	db $38,$04,$0C ; $06
		
OBJLstHdrA_Billy_ChargeMeter0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_ChargeMeter0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $28,$09,$06 ; $03
	db $30,$11,$08 ; $04
	db $18,$F9,$0A ; $05
	db $18,$01,$0C ; $06
		
OBJLstHdrB_Billy_BlockC0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_BlockC0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$F4,$00 ; $00
	db $38,$FC,$02 ; $01
	db $38,$04,$04 ; $02
	db $38,$EC,$06 ; $03
		
OBJLstHdrA_Billy_ChargeMeter1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_ChargeMeter1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$F1,$00 ; $00
	db $28,$F9,$02 ; $01
	db $28,$01,$04 ; $02
	db $28,$09,$06 ; $03
	db $30,$11,$08 ; $04
	db $18,$F9,$0A ; $05
	db $18,$01,$0C ; $06
		
OBJLstHdrA_Billy_AttackA0:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_AttackA0 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$E4,$00 ; $00
	db $30,$EC,$02 ; $01
	db $20,$F4,$04 ; $02
	db $20,$FC,$06 ; $03
	db $20,$04,$08 ; $04
	db $30,$F4,$0A ; $05
	db $30,$FC,$0C ; $06
	db $30,$04,$0E ; $07
	db $38,$0C,$10 ; $08
		
OBJLstHdrA_Billy_Taunt0_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Taunt0_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FC,$00 ; $00
	db $20,$04,$02 ; $01
	db $18,$0C,$04 ; $02
	db $20,$F4,$06 ; $03
	db $30,$F4,$08 ; $04
	db $28,$EC,$0A ; $05
	db $10,$FC,$0C ; $06
		
OBJLstHdrB_Billy_Taunt0_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_Taunt0_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$FC,$00 ; $00
	db $30,$04,$02 ; $01
	db $38,$F4,$04 ; $02
		
OBJLstHdrA_Billy_Taunt1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Taunt1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$FE,$00 ; $00
	db $20,$06,$02 ; $01
	db $28,$F6,$04 ; $02
	db $18,$F6,$06 ; $03
	db $20,$EE,$08 ; $04
	db $10,$FE,$0A ; $05
		
OBJLstHdrA_Billy_Win7_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Win7_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EE,$00 ; $00
	db $20,$F6,$02 ; $01
	db $20,$FE,$04 ; $02
	db $20,$06,$06 ; $03
	db $30,$F6,$08 ; $04
		
OBJLstHdrA_Billy_SansetsuKonChuudanUchi1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_0F ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $30,$EC,$06 ; $03
	db $30,$F4,$08 ; $04
	db $30,$FC,$0A ; $05
	db $38,$04,$0C ; $06
		
OBJLstHdrA_Billy_SansetsuKonChuudanUchi2_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_10 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrA_Billy_SansetsuKonChuudanUchi3_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_11 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw OBJLstHdrA_Billy_SansetsuKonChuudanUchi1_A.bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
		
OBJLstHdrB_Billy_SansetsuKonChuudanUchi1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$CC,$00 ; $00
	db $28,$D4,$02 ; $01
	db $28,$DC,$04 ; $02
	db $28,$E4,$06 ; $03
		
OBJLstHdrB_Billy_SansetsuKonChuudanUchi2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$B4,$00 ; $00
	db $28,$BC,$02 ; $01
	db $28,$CC,$04 ; $02
	db $28,$D4,$06 ; $03
	db $28,$E4,$08 ; $04
		
OBJLstHdrB_Billy_SansetsuKonChuudanUchi3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SansetsuKonChuudanUchi2_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$A4,$00 ; $00
	db $28,$AC,$02 ; $01
	db $28,$C4,$04 ; $02
	db $28,$CC,$06 ; $03
	db $28,$E4,$08 ; $04
		
OBJLstHdrA_Billy_Intro1:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Intro1 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F8,$00 ; $00
	db $20,$00,$02 ; $01
	db $38,$F0,$04 ; $02
	db $30,$F8,$06 ; $03
	db $30,$00,$08 ; $04
	db $28,$08,$0A ; $05
	db $38,$08,$0C ; $06
		
OBJLstHdrA_Billy_Intro2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Intro2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F0,$00 ; $00
	db $20,$F8,$02 ; $01
	db $20,$00,$04 ; $02
	db $28,$08,$06 ; $03
	db $38,$F0,$08 ; $04
	db $30,$F8,$0A ; $05
	db $30,$00,$0C ; $06
	db $38,$08,$0E ; $07
		
OBJLstHdrA_Billy_Intro3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_Intro3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F8,$00 ; $00
	db $20,$00,$02 ; $01
	db $28,$08,$04 ; $02
	db $30,$F0,$06 ; $03
	db $30,$F8,$08 ; $04
	db $30,$00,$0A ; $05
	db $38,$08,$0C ; $06
		
OBJLstHdrA_Billy_SuzumeOtoshi1_A:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_12 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_SuzumeOtoshi1_A ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$F3,$00 ; $00
	db $20,$FB,$02 ; $01
	db $20,$03,$04 ; $02
	db $28,$EB,$06 ; $03
	db $30,$F3,$08 ; $04
	db $30,$FB,$0A ; $05
	db $30,$03,$0C ; $06
		
OBJLstHdrB_Billy_SuzumeOtoshi1_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SuzumeOtoshi1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $08,$DC,$00 ; $00
	db $10,$E4,$02 ; $01
	db $18,$EC,$04 ; $02
		
OBJLstHdrB_Billy_SuzumeOtoshi2_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SuzumeOtoshi1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$D4,$00 ; $00
	db $0C,$E0,$02 ; $01
	db $18,$EC,$04 ; $02
		
OBJLstHdrB_Billy_SuzumeOtoshi3_B:
	db $00 ; iOBJLstHdrA_Flags
	dpr GFX_Char_Billy_SuzumeOtoshi1_B ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $F8,$CC,$00 ; $00
	db $08,$DC,$02 ; $01
	db $18,$EC,$04 ; $02
		
OBJLstHdrA_Billy_KyoushuuHishouKon2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KyoushuuHishouKon2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $28,$EC,$00 ; $00
	db $20,$F4,$02 ; $01
	db $20,$FC,$04 ; $02
	db $28,$04,$06 ; $03
	db $38,$EC,$08 ; $04
	db $30,$F4,$0A ; $05
	db $30,$FC,$0C ; $06
	db $38,$04,$0E ; $07
		
OBJLstHdrA_Billy_KyoushuuHishouKon4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KyoushuuHishouKon4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $07 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F4,$00 ; $00
	db $18,$FC,$02 ; $01
	db $20,$EC,$04 ; $02
	db $28,$F4,$06 ; $03
	db $28,$FC,$08 ; $04
	db $28,$04,$0A ; $05
	db $30,$EC,$0C ; $06
		
OBJLstHdrA_Billy_KyoushuuHishouKon5:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KyoushuuHishouKon5 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$E4,$00 ; $00
	db $18,$EC,$02 ; $01
	db $18,$F4,$04 ; $02
	db $18,$FC,$06 ; $03
	db $28,$EC,$08 ; $04
	db $28,$F4,$0A ; $05
	db $28,$FC,$0C ; $06
	db $28,$04,$0E ; $07
		
OBJLstHdrA_Billy_KyoushuuHishouKon6:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KyoushuuHishouKon6 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $18,$F0,$00 ; $00
	db $18,$F8,$02 ; $01
	db $18,$00,$04 ; $02
	db $28,$E8,$06 ; $03
	db $28,$F0,$08 ; $04
	db $28,$F8,$0A ; $05
	db $28,$00,$0C ; $06
	db $20,$08,$0E ; $07
		
OBJLstHdrA_Billy_ChouKaenSenpuuKon2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_ChouKaenSenpuuKon2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0D ; OBJ Count
	;    Y   X  ID+FLAG
	db $1C,$F4,$00 ; $00
	db $1C,$FC,$02 ; $01
	db $1C,$04,$04 ; $02
	db $1C,$0C,$06 ; $03
	db $24,$EC,$08 ; $04
	db $2C,$F4,$0A ; $05
	db $2C,$FC,$0C ; $06
	db $2C,$04,$0E ; $07
	db $34,$EC,$10 ; $08
	db $3C,$F4,$12 ; $09
	db $3C,$FC,$14 ; $0A
	db $3C,$04,$16 ; $0B
	db $2C,$0C,$18 ; $0C
		
OBJLstHdrA_Billy_ChouKaenSenpuuKon3:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_ChouKaenSenpuuKon3 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0C ; OBJ Count
	;    Y   X  ID+FLAG
	db $20,$EA,$00 ; $00
	db $20,$F2,$02 ; $01
	db $18,$FA,$04 ; $02
	db $18,$02,$06 ; $03
	db $20,$0A,$08 ; $04
	db $30,$F2,$0A ; $05
	db $28,$FA,$0C ; $06
	db $28,$02,$0E ; $07
	db $30,$EA,$10 ; $08
	db $30,$0A,$12 ; $09
	db $38,$FA,$14 ; $0A
	db $38,$02,$16 ; $0B
		
OBJLstHdrA_Billy_ChouKaenSenpuuKon4:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_13 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_ChouKaenSenpuuKon4 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0C ; OBJ Count
	;    Y   X  ID+FLAG
	db $19,$F5,$00 ; $00
	db $19,$FD,$02 ; $01
	db $21,$05,$04 ; $02
	db $21,$ED,$06 ; $03
	db $21,$0D,$08 ; $04
	db $29,$F5,$0A ; $05
	db $29,$FD,$0C ; $06
	db $31,$05,$0E ; $07
	db $31,$ED,$10 ; $08
	db $31,$0D,$12 ; $09
	db $39,$F5,$14 ; $0A
	db $39,$FD,$16 ; $0B
		
OBJLstHdrA_Billy_KickFH2:
	db $00 ; iOBJLstHdrA_Flags
	db COLIBOX_01 ; iOBJLstHdrA_ColiBoxId
	db COLIBOX_02 ; iOBJLstHdrA_HitboxId
	dpr GFX_Char_Billy_KickFH2 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $23,$E4,$00 ; $00
	db $1B,$EC,$02 ; $01
	db $23,$F4,$04 ; $02
	db $1B,$FC,$06 ; $03
	db $1B,$04,$08 ; $04
	db $2B,$FC,$0A ; $05
	db $2B,$04,$0C ; $06
	db $33,$0C,$0E ; $07
	db $33,$F4,$10 ; $08