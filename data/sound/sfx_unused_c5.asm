SndHeader_SFX_Unused_C5:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_C5_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_C5_Ch4:
	envelope $F1
	panning $88
	chan_stop
