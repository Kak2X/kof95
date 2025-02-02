SndHeader_SFX_Block:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Block_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Block_Ch4:
	envelope $F1
	panning $88
	wait 68
	wait 5
	wait 86
	wait 2
	chan_stop
