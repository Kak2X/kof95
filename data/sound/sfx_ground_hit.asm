SndHeader_SFX_GroundHit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_GroundHit_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_GroundHit_Ch4:
	envelope $E4
	panning $88
	note4 D#,5,0, 2
	note4x $43, 2 ; Nearest: G#,5,0
	note4 D#,5,0, 2
	note4 G_,4,0, 18
	envelope $44
	note4 D#,5,0, 2
	note4x $43, 2 ; Nearest: G#,5,0
	note4 D#,5,0, 2
	note4 G_,4,0, 18
	chan_stop
