SndHeader_SFX_CursorMove:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_CursorMove_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_CursorMove_Ch2:
	envelope $F1
	panning $22
	duty_cycle 1
	note C_,5, 2
	note E_,5
	note G_,5
	envelope $81
	note C_,5, 2
	note E_,5
	note G_,5
	envelope $41
	note C_,5, 2
	note E_,5
	note G_,5
	chan_stop
