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
	note4 D#,5,0, 5
	note4 A_,4,0, 2
	chan_stop
