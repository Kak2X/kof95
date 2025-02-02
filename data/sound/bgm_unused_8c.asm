SndHeader_BGM_Unused_8C:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Unused_8C_Ch1:
	envelope $B2
	panning $11
	duty_cycle 3
	speed $009C
	chan_stop
SndData_BGM_Unused_8C_Ch2:
	envelope $B2
	panning $02
	duty_cycle 3
	chan_stop
SndData_BGM_Unused_8C_Ch3:
	wave_vol $C0
	panning $40
	wave_id $07
	chan_stop
SndData_BGM_Unused_8C_Ch4:
	panning $88
	fine_tune 16
	envelope $A1
	chan_stop
