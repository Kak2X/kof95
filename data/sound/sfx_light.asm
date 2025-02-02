SndHeader_SFX_Light:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Light_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Light_Ch4:
	envelope $E4
	panning $88
	wait 88
	wait 2
	lock_envelope
	wait 89
	wait 1
	wait 90
	wait 1
	wait 91
	wait 1
	wait 92
	wait 1
	wait 93
	wait 1
	chan_stop
