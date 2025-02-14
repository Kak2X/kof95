SndHeader_SFX_Unused_Bomb:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_Bomb_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_Bomb_Ch4:
	envelope $F4
	panning $88
	note4 D#,5,0, 3
	note4 G#,4,0, 2
	note4x $53, 3 ; Nearest: G#,4,0
	note4 C_,5,0, 2
	note4x $53, 2 ; Nearest: G#,4,0
	note4 G_,4,0, 55
	chan_stop