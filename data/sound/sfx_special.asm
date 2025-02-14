SndHeader_SFX_Special:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Special_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Special_Ch4:
	envelope $F5
	panning $88
.loop0:
	note4x $30, 1 ; Nearest: B_,5,0
	lock_envelope
	note4x $31, 1 ; Nearest: A#,5,0
	note4x $32, 1 ; Nearest: A_,5,0
	note4x $33, 1 ; Nearest: G#,5,0
	note4 G_,5,0, 1
	note4 F#,5,0, 1
	note4 F_,5,0, 1
	snd_loop .loop0, $00, 2
.loop1:
	envelope $F4
	note4x $80, 4 ; Nearest: B_,3,0
	lock_envelope
	note4x $58, 2 ; Nearest: B_,4,1
	note4x $33, 2 ; Nearest: G#,5,0
	note4 F#,5,0, 3
	note4x $52, 2 ; Nearest: A_,4,0
	snd_loop .loop1, $00, 2
	chan_stop
