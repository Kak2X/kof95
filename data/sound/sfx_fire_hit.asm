SndHeader_SFX_FireHit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_FireHit_Ch4 ; Data ptr
	db 5 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_FireHit_Ch4:
	envelope $F4
	panning $88
	note4 D#,5,0, 6
	note4 G#,4,0, 6
	note4x $53, 6 ; Nearest: G#,4,0
	note4 C_,5,0, 6
	note4x $53, 6 ; Nearest: G#,4,0
	note4 G_,4,0, 55
	chan_stop
