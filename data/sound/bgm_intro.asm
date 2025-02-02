SndHeader_BGM_Intro:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Intro_Ch1:
	envelope $87
	panning $11
	duty_cycle 1
	speed $00C9
.main:
	envelope $75
	note F#,4, 12
	wait 2
	silence 4
	note F#,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note F#,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note F#,4, 6
	silence 6
	note F#,4, 2
	silence 4
	note F#,4, 2
	silence 4
	note F#,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note F#,4, 2
	silence 4
	note F#,5, 2
	silence 4
	note G_,5, 12
	silence 6
	note D_,4, 2
	silence 4
	note D_,4, 2
	silence 4
	note D_,4, 2
	silence 4
	note D_,4, 2
	silence 4
	note D_,4, 2
	silence 4
	snd_loop .main, $00, 4
	envelope $97
	duty_cycle 2
	silence 24
	note F#,4, 12
	note G_,4, 48
	note D_,4, 12
	envelope $B7
	note E_,4, 96
	continue 36
	note E_,5, 6
	silence
	note E_,5, 12
	note D_,5, 6
	note B_,4
	note D_,5
	note B_,4
	note A_,4, 12
	note E_,4, 96
	continue 36
	note E_,5, 6
	silence
	note E_,5, 12
	note D_,5, 6
	note B_,4
	note D_,5
	note B_,4
	note E_,4, 12
	note F_,5
	note E_,5, 6
	note D_,5
	note E_,5
	note C_,5
	note D_,5, 12
	note G_,5
	note F_,5, 6
	note E_,5
	note F_,5
	note D_,5
	note E_,5, 12
	note A_,4, 48
	chan_stop
SndData_BGM_Intro_Ch2:
	envelope $87
	panning $20
	duty_cycle 3
.main:
	envelope $72
	duty_cycle 1
	note F#,5, 6
	note D_,5
	note B_,4
	note E_,4
	note F#,4
	note B_,3
	note D_,4
	note E_,4
	note B_,4
	note F#,4
	note D_,5
	note E_,5
	note F#,5
	note B_,4
	note B_,3, 4
	note B_,3
	note B_,3
	note F#,4, 6
	note B_,3
	note F#,3
	note B_,3
	note F#,4
	note B_,3
	note F#,4
	note B_,4
	note E_,4
	note B_,4
	note F#,4
	note E_,5
	note F#,5
	note E_,5
	note B_,5
	note B_,4
	snd_loop .main, $00, 4
	envelope $B7
	duty_cycle 3
	silence 24
	note C#,4, 12
	note D_,4, 48
	note A_,3, 12
	note F#,4, 12
	note F#,4, 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note F#,4, 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note F#,4, 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note F#,4, 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note F#,4, 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note B_,4, 6
	silence
	note B_,4, 12
	note A_,4, 6
	note F#,4
	note A_,4
	note F#,4
	note E_,4, 12
	note F#,4, 12
	wait 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	wait 2
	silence 4
	note G_,4, 2
	silence 4
	note F#,4, 12
	note B_,4, 6
	silence
	note B_,4, 12
	note A_,4, 6
	note F#,4
	note A_,4
	note F#,4
	note B_,3, 12
	note C_,5
	note B_,4, 6
	note A_,4
	note B_,4
	note G_,4
	note A_,4, 12
	note D_,5
	note C_,5, 6
	note B_,4
	note C_,5
	note A_,4
	note B_,4, 12
	note E_,4, 48
	chan_stop
SndData_BGM_Intro_Ch3:
	wave_vol $C0
	panning $04
	wave_id $03
	fine_tune 12
	note E_,3, 96
	continue 84
	note B_,2, 12
	note E_,3, 96
	continue 84
	note B_,2, 12
	note E_,3, 96
	continue 84
	note B_,2, 12
	note E_,3, 96
	continue 96
	wave_id $04
	fine_tune -12
	silence 24
	note F#,3, 12
	note G_,3, 48
	note D_,3, 12
.main:
	note E_,3, 12
	note B_,2
	note D_,3
	note E_,3
	note E_,3
	note B_,2
	note D_,3
	note B_,2
	snd_loop .main, $00, 4
	note F_,3, 12
	note E_,3
	note C_,3
	note D_,3
	note G_,3
	note F_,3
	note D_,3
	note E_,3
	note A_,2, 48
	chan_stop
SndData_BGM_Intro_Ch4:
	panning $88
	fine_tune 16
	envelope $B1
.main:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 4 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .main, $00, 8
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $00, 18 ; envelope $00 ; note4 B_,6,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop1:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop1, $00, 3
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 24 ; envelope $52 ; note4 B_,5,0
	chan_stop
