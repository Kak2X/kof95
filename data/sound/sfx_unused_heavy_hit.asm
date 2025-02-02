SndHeader_SFX_Unused_HeavyHit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_HeavyHit_Ch4 ; Data ptr
	db -4 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_HeavyHit_Ch4:
	envelope $F4
	panning $88
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
	chan_stop
