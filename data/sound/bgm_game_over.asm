SndHeader_BGM_GameOver:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_GameOver_Ch1:
	envelope $A7
	panning $11
	duty_cycle 3
	speed $00D3
	note A#,5, 12
	wait 4
	note A#,5
	note A#,5
	vibrato_on
	note F_,6, 44
	silence 4
	chan_stop
SndData_BGM_GameOver_Ch2:
	envelope $A7
	panning $20
	duty_cycle 1
	silence 12
	note G#,4, 2
	note A_,4
	note A#,4
	note B_,4
	note C_,5
	note C#,5
	note D_,5, 44
	silence 4
	chan_stop
SndData_BGM_GameOver_Ch3:
	wave_vol $80
	panning $04
	wave_id $03
	silence 12
	note E_,4, 2
	note F_,4
	note F#,4
	note G_,4
	note G#,4
	note A_,4
	note A#,4, 12
	chan_stop
SndData_BGM_GameOver_Ch4:
	panning $88
	fine_tune 16
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 4 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 24 ; envelope $52 ; note4 B_,5,0
	chan_stop
