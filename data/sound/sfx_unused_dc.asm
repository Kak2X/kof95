SndHeader_SFX_Unused_DC:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_DC_Ch2 ; Data ptr
	db 6 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_DC_Ch2:
	envelope $F7
	panning $20
	duty_cycle 1
	chan_stop
