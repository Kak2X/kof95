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
	wait 68
	wait 3
	wait 87
	wait 2
	wait 83
	wait 3
	wait 71
	wait 2
	wait 83
	wait 2
	wait 100
	wait 55
	chan_stop
