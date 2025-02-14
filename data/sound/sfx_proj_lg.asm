SndHeader_SFX_ProjLg:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_ProjLg_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_ProjLg_Ch4:
	envelope $F7
	panning $88
	note4 B_,4,0, 3
	note4x $53, 3 ; Nearest: G#,4,0
	note4x $52, 3 ; Nearest: A_,4,0
	note4x $51, 3 ; Nearest: A#,4,0
	note4x $50, 5 ; Nearest: B_,4,0
	envelope $F1
	note4x $40, 4 ; Nearest: B_,5,0
	chan_stop