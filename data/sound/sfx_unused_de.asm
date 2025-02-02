SndHeader_SFX_Unused_DE:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_DE_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_DE_Ch2:
	envelope $E6
	panning $22
	duty_cycle 3
	chan_stop
