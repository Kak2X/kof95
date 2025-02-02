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
	wait 48
	wait 1
	lock_envelope
	wait 49
	wait 1
	wait 50
	wait 1
	wait 51
	wait 1
	wait 52
	wait 1
	wait 53
	wait 1
	wait 54
	wait 1
	snd_loop .loop0, $00, 2
.loop1:
	envelope $F4
	note4x $80, 4 ; Nearest: B_,3,0
	lock_envelope
	wait 88
	wait 2
	wait 51
	wait 2
	wait 53
	wait 3
	wait 82
	wait 2
	snd_loop .loop1, $00, 2
	chan_stop
