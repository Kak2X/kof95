SndHeader_SFX_ChargeMeter:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_ChargeMeter_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_ChargeMeter_Ch2:
	envelope $F1
	panning $22
	duty_cycle 0
.main:
	note A_,4, 1
	note A#,4
	note B_,4
	snd_loop .main, $00, 6
.loop1:
	note A_,4, 1
	note A#,4
	note B_,4
	fine_tune 1
	snd_loop .loop1, $00, 28
	chan_stop
