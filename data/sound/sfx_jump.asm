SndHeader_SFX_Jump:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Jump_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Jump_Ch4:
	envelope $19
	panning $88
	wait 72
	wait 3
	envelope $F1
	wait 64
	wait 6
	chan_stop
