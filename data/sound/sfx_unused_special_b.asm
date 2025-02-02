SndHeader_SFX_Unused_SpecialB:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_SpecialB_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_SpecialB_Ch4:
	envelope $F5
	panning $88
	wait 65
	wait 3
	wait 66
	wait 3
	wait 67
	wait 3
	wait 68
	wait 3
	envelope $F1
	note4x $80, 10 ; Nearest: B_,3,0
	chan_stop
