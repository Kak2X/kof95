SndHeader_SFX_Reflect:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Reflect_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Reflect_Ch4:
	envelope $F6
	panning $88
	wait 64
	wait 6
	envelope $F1
	wait 112
	wait 18
	chan_stop
