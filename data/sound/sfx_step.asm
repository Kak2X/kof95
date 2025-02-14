SndHeader_SFX_Step:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Step_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Step_Ch4:
	envelope $29
	panning $88
	note4x $40, 2 ; Nearest: B_,5,0
	envelope $F1
	lock_envelope
	note4x $42, 1 ; Nearest: A_,5,0
	note4x $43, 1 ; Nearest: G#,5,0
	chan_stop