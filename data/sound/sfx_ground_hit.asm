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
	wait 68
	wait 2
	wait 67
	wait 2
	wait 68
	wait 2
	wait 100
	wait 18
	envelope $44
	wait 68
	wait 2
	wait 67
	wait 2
	wait 68
	wait 2
	wait 100
	wait 18
	chan_stop
