SndHeader_BGM_Cutscene1:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Cutscene1_Ch1:
	envelope $B7
	panning $11
	duty_cycle 2
	speed $00BF
.main:
	note G_,4, 12
	envelope $30
	note G_,4, 12
	envelope $20
	note G_,4, 12
	envelope $B7
	note D_,5
	note C#,5
	envelope $20
	note C#,5
	envelope $B7
	note G_,4, 24
	note A#,4, 36
	note G_,5, 4
	envelope $20
	note G_,5, 8
	envelope $B7
	note G_,5, 4
	envelope $20
	note G_,5, 8
	envelope $B7
	note A_,5, 4
	envelope $20
	note A_,5, 8
	envelope $B7
	note A#,5, 4
	envelope $20
	note A#,5, 8
	envelope $B7
	note A_,5, 4
	envelope $20
	note A_,5, 8
	envelope $B7
	silence 36
	note D_,5, 12
	note C#,5, 24
	note G_,4
	note A#,4, 72
	note A_,4, 6
	silence 18
	snd_loop .main
SndData_BGM_Cutscene1_Ch2:
	envelope $B5
	panning $20
	duty_cycle 1
.main:
	note A#,3, 48
	note G_,3
	note F#,3, 36
	note E_,5, 4
	silence 8
	wait 4
	silence 8
	note F#,5, 4
	silence 8
	note G_,5, 4
	silence 8
	note F#,5, 4
	silence 8
	note D_,3, 6
	silence
	note D_,3
	silence
	note D_,3
	silence
	note D_,3
	silence
	note D_,3
	silence
	note D_,3
	silence
	note D_,3
	silence
	note D_,3
	silence
	note F_,3, 48
	note F#,3, 24
	note E_,3, 6
	silence 18
	snd_loop .main
SndData_BGM_Cutscene1_Ch3:
	wave_vol $C0
	panning $04
	wave_id $07
	note G_,3, 12
	silence
	silence
	note D_,3
	note C#,3, 24
	note G_,3
	note A#,3, 36
	note G_,3, 6
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note A_,2
	silence 18
.main:
	note G_,3, 6
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	note G_,3
	silence
	snd_loop .main
SndData_BGM_Cutscene1_Ch4:
	panning $88
	fine_tune 16
	envelope $91
.main:
	note4p $02, 18 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .main
