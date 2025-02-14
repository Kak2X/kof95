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
	note4x $48, 3 ; Nearest: B_,5,1
	envelope $F1
	note4x $40, 6 ; Nearest: B_,5,0
	chan_stop