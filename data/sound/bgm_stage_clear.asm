SndHeader_BGM_StageClear:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_StageClear_Ch1:
	envelope $A7
	panning $11
	duty_cycle 2
	speed $00E7
	silence 12
	note A_,5, 6
	silence 12
	note A_,4, 18
	note C_,5, 6
	silence
	note A_,5
	silence 12
	note C_,5, 18
	note D_,5
	note D#,5, 96
	wait 6
	note D_,5
	note C_,5
	note A_,4
	note D_,5
	note C_,5
	note A_,4
	note D_,5
	silence
	chan_stop
SndData_BGM_StageClear_Ch2:
	envelope $A7
	panning $20
	duty_cycle 2
	silence 12
	note E_,5, 6
	silence 12
	note E_,4, 18
	note G_,4, 6
	silence
	note E_,5
	silence 12
	note G_,4, 18
	note A_,4
	note A#,4, 96
	wait 6
	note A_,4
	note G_,4
	note E_,4
	note A_,4
	note G_,4
	note E_,4
	note A_,4
	silence
	chan_stop
SndData_BGM_StageClear_Ch3:
	wave_vol $C0
	panning $04
	wave_id $07
	silence 30
	note A_,2, 18
	note C_,3, 6
	silence
	note A_,3
	silence 12
	note C_,3, 18
	note D_,3
	note D#,3, 96
	wait 6
	note D_,3
	note C_,3
	note A_,2
	note D_,3
	note C_,3
	note A_,2
	note D_,3
	silence
	chan_stop
SndData_BGM_StageClear_Ch4:
	panning $88
	fine_tune 48
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 18 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 24 ; envelope $52 ; note4 B_,5,0
	wait 6
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	chan_stop
