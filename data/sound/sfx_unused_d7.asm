SndHeader_SFX_Unused_D7:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_D7_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_D7_Ch2:
	panning $22
	duty_cycle 0
	chan_stop
