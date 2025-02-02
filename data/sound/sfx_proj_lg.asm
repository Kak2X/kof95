SndHeader_SFX_ProjLg:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_ProjLg_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_ProjLg_Ch4:
	envelope $F7
	panning $88
	wait 84
	wait 3
	wait 83
	wait 3
	wait 82
	wait 3
	wait 81
	wait 3
	wait 80
	wait 5
	envelope $F1
	wait 64
	wait 4
	chan_stop
