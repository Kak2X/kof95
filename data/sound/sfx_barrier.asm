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
	note4 G#,5,0, 3
	note4 A_,5,0, 3
	note4 A#,5,0, 3
	note4 B_,5,0, 3
	note4x $23, 3 ; Nearest: G#,5,0
	note4x $22, 3 ; Nearest: A_,5,0
	note4x $21, 3 ; Nearest: A#,5,0
	note4x $20, 5 ; Nearest: B_,5,0
	envelope $F1
	note4x $40, 6 ; Nearest: B_,5,0
	chan_stop