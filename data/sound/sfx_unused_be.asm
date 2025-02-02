SndHeader_SFX_Unused_BE:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_BE_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_BE_Ch2:
	envelope $F3
	panning $20
	duty_cycle 2
	chan_stop
