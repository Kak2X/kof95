SndHeader_SFX_CharSelected:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_CharSelected_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_CharSelected_Ch2:
	envelope $F1
	panning $22
	duty_cycle 0
	note C_,4, 1
	note D_,4
	note E_,4
	note F_,4
	note G_,4
	note A_,4
	note B_,4
	note C_,5, 1
	note E_,5
	note B_,5
	note E_,6, 3
	envelope $71
	note C_,5, 1
	note E_,5
	note B_,5
	note E_,6, 3
	envelope $41
	note C_,5, 1
	note E_,5
	note B_,5
	note E_,6, 3
	envelope $11
	note C_,5, 1
	note E_,5
	note B_,5
	note E_,6, 3
	chan_stop
