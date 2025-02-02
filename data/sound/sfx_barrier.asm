SndHeader_SFX_Barrier:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Barrier_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Barrier_Ch4:
	envelope $F7
	panning $88
	wait 39
	wait 3
	wait 38
	wait 3
	wait 37
	wait 3
	wait 36
	wait 3
	wait 35
	wait 3
	wait 34
	wait 3
	wait 33
	wait 3
	wait 32
	wait 5
	envelope $F1
	wait 64
	wait 6
	chan_stop
