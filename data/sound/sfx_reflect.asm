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
	note4x $40, 6 ; Nearest: B_,5,0
	envelope $F1
	note4x $70, 18 ; Nearest: B_,4,0
	chan_stop

