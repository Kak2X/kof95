SndHeader_SFX_Heavy:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Heavy_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Heavy_Ch4:
	envelope $E4
	panning $88
	note4 A#,4,1, 2
	lock_envelope
	note4 B_,4,1, 1
	note4x $5B, 1 ; Nearest: G#,4,1
	note4x $5A, 1 ; Nearest: A_,4,1
	note4x $59, 1 ; Nearest: A#,4,1
	note4x $58, 1 ; Nearest: B_,4,1
	chan_stop
