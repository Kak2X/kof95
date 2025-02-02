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
	wait 68
	wait 6
	wait 87
	wait 6
	wait 83
	wait 6
	wait 71
	wait 6
	wait 83
	wait 6
	wait 100
	wait 55
	chan_stop
