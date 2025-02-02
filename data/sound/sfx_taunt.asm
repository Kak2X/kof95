SndHeader_SFX_Taunt:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Taunt_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Taunt_Ch2:
	envelope $A9
	panning $22
	duty_cycle 0
	note A_,6, 6
	lock_envelope
	note G_,6, 1
	note F_,6, 1
	note E_,6, 1
	note D_,6, 1
	note C_,6, 1
	chan_stop
