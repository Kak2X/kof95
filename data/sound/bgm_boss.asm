SndHeader_BGM_Boss:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Boss_Ch1:
	envelope $A7
	panning $11
	duty_cycle 2
	speed $00EC
	note F_,3, 12
	note F#,3, 3
	note G_,3
	note G#,3
	note A_,3
	note A#,3
	note B_,3
	note C_,4
	note C#,4
	note D_,4
	note D#,4
	note E_,4
	note F_,4
	note F#,4
	note G_,4
	note G#,4
	note A_,4
	note A#,4
	note C_,5
	note D_,5
	note F#,5, 6
	silence 18
.main:
	duty_cycle 2
	envelope $A2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	envelope $52
	note F#,4, 6
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,5, 4
	note F#,5
	note F#,5
	note F#,6, 6
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	snd_loop .main, $01, 3
	envelope $A2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	envelope $52
	note F#,4, 6
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	note F#,5, 4
	silence 2
	silence 72
	envelope $A7
	duty_cycle 3
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	note C#,4, 24
	note B_,3
	envelope $B7
	note E_,4, 36
	note B_,3
	note B_,4, 24
	note A#,4, 96
	note A_,4, 36
	note G_,4
	note F#,4, 24
	note E_,4, 36
	note B_,3, 60
	note E_,3, 96
	note D_,4, 6
	note E_,4, 12
	note D_,4, 6
	note E_,4, 12
	note D_,4, 6
	note E_,4, 54
	silence 96
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	note C#,4, 24
	note B_,3
	note E_,4, 36
	note B_,3
	note B_,4, 24
	note A#,4, 96
	note A_,4, 36
	note G_,4
	note F#,4, 24
	note E_,4, 36
	note B_,4, 60
	note E_,3, 96
	note D_,4, 6
	note E_,4, 12
	note D_,4, 6
	note E_,4, 12
	note D_,4, 6
	note E_,4, 54
	silence 96
	note A_,4, 12
	note A_,3, 2
	silence 4
	note A_,4, 12
	note A_,3, 2
	silence 4
	note E_,4, 34
	silence 26
	note A_,4, 12
	note A_,3, 2
	silence 4
	note A_,4, 12
	note A_,3, 2
	silence 4
	note E_,4, 36
	wait 12
	note F#,4
	note G_,4, 72
	note F#,4, 18
	note G_,4, 6
	note A_,4, 36
	note G_,4, 24
	note F#,4
	note E_,4, 12
	note F#,4, 36
	note G_,4, 60
	silence
	note A_,4, 24
	note C_,5
	note B_,4, 84
	silence 96
	note A_,4, 12
	note A_,3, 2
	silence 4
	note A_,4, 12
	note A_,3, 2
	silence 4
	note E_,4, 36
	wait 12
	note F#,4
	note G_,4, 72
	note F#,4, 18
	note G_,4, 6
	note A_,4, 72
	note G_,4, 24
	note A#,4, 6
	silence
	note A#,4
	silence
	silence 12
	note A_,4, 6
	silence
	silence 12
	note G_,4, 6
	silence
	note A_,4
	silence
	note B_,3
	silence
	silence 24
	note B_,3, 96
	continue 24
	note D_,4
	note D_,4
	note D_,4
	note D_,4
	note D_,4
	note D_,4
	snd_loop .main
SndData_BGM_Boss_Ch2:
	envelope $A3
	panning $20
	duty_cycle 1
	note A_,3, 12
	note A#,3, 3
	note B_,3
	note C_,4
	note C#,4
	note D_,4
	note D#,4
	note E_,4
	note F_,4
	note F#,4
	note G_,4
	note G#,4
	note A_,4
	note A#,4
	note B_,4
	note C_,5
	note C#,5
	note D_,5
	note E_,5
	note F#,5
	note C#,5, 6
	silence 18
.main:
	envelope $A2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	silence 2
	envelope $2A
	note F#,4, 6
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,5, 4
	note F#,5
	note F#,5
	note F#,6, 6
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5, 4
	snd_loop .main, $01, 3
	envelope $A2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	envelope $2A
	silence 2
	note F#,4, 6
	note F#,3
	note F#,4
	note F#,5
	note F#,6
	note F#,4
	note F#,5
	note F#,4
	note F#,3
	note F#,4
	note F#,5
	note F#,6, 4
	envelope $A2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	note C#,5, 4
	silence 2
	silence 72
.loop2:
	envelope $A7
	note B_,3, 6
	silence
	note B_,2, 2
	silence 4
	note B_,3, 6
	silence
	note B_,2, 2
	silence 4
	note B_,3, 6
	silence
	note F#,4, 48
	envelope $87
	note G_,4, 24
	note F#,4
	note F#,4
	note F#,4
.loop1:
	note D#,4, 6
	silence
	note E_,3, 2
	silence 4
	note D#,4, 6
	silence
	note E_,3, 2
	silence 4
	note D#,4, 6
	silence
	envelope $72
	note E_,4
	note E_,5
	note E_,3
	note E_,6
	note E_,5
	note E_,4
	note E_,4
	note E_,5
	snd_loop .loop1, $02, 2
	envelope $87
	note D_,3, 6
	note E_,3, 12
	note D_,3, 6
	note E_,3, 12
	note D_,3, 6
	note E_,3, 54
	note B_,4, 36
	note A#,4, 60
	note A_,3, 6
	note B_,3, 12
	note A_,3, 6
	note B_,3, 12
	note A_,3, 6
	note B_,3, 54
	silence 96
	snd_loop .loop2, $01, 2
.loop3:
	note E_,4, 12
	note E_,3, 2
	silence 4
	note E_,4, 12
	note E_,3, 2
	silence 4
	note B_,3, 36
	envelope $72
	note A_,4, 6
	note A_,3
	note A_,5
	note A_,4
	envelope $87
	snd_loop .loop3, $01, 2
	note D_,4, 12
	note D_,3, 2
	silence 4
	note D_,4, 12
	note D_,3, 2
	silence 4
	note D_,4, 6
	silence 30
	envelope $72
	note G_,4, 6
	note G_,3
	note G_,5
	note G_,4
	envelope $87
	note F#,4, 12
	note F#,3, 2
	silence 4
	note A_,3, 12
	note F#,3, 2
	silence 4
	note D_,4, 6
	silence 30
	envelope $72
	note G_,4, 6
	note G_,3
	note G_,5
	note G_,4
	envelope $87
.loop4:
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	note E_,3, 2
	silence 4
	note E_,4, 6
	silence
	silence 48
	snd_loop .loop4, $01, 2
.loop5:
	note B_,3, 6
	silence
	note B_,2, 2
	silence 4
	note B_,3, 6
	silence
	note B_,2, 2
	silence 4
	note B_,3, 6
	silence
	envelope $72
	note E_,4
	note E_,3
	note E_,5
	note E_,4
	note E_,5
	note E_,3
	note E_,4
	note E_,5
	envelope $87
	snd_loop .loop5, $01, 2
	note E_,4, 12
	note E_,3, 2
	silence 4
	note E_,4, 12
	note E_,3, 2
	silence 4
	note B_,3, 36
	note A_,4, 6
	note A_,3
	note A_,5
	note A_,4
.loop6:
	envelope $72
	note A_,4, 6
	note A_,3
	note A_,4
	note A_,5
	note A_,6
	note A_,4
	note A_,5
	note A_,3
	note A_,4
	note A_,3
	note A_,4
	note A_,5
	note A_,6
	note A_,4
	note A_,5
	note A_,6
	snd_loop .loop6, $01, 2
	envelope $87
	note F_,4, 6
	silence
	note F_,4
	silence
	silence 12
	note E_,4, 6
	silence
	silence 12
	note D_,4, 6
	silence
	note E_,4
	silence
	note F#,3
	silence
	silence 24
	note F#,3, 96
	continue 24
	note A_,3
	note A_,3
	note A_,3
	note A_,3
	note A_,3
	note A_,3
	snd_loop .main
SndData_BGM_Boss_Ch3:
	wave_vol $C0
	panning $04
	wave_id $02
	silence 93
.main:
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note B_,2
	silence
	snd_loop .main, $01, 8
.loop1:
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note E_,3
	silence
	snd_loop .loop1, $02, 4
	note A_,2, 4
	silence 2
	note B_,2, 10
	silence 2
	note A_,2, 4
	silence 2
	note B_,2, 10
	silence 2
	note A_,2, 4
	silence 2
	note B_,2, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note E_,3
	silence
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note E_,3
	silence
.loop2:
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note E_,3
	silence
	snd_loop .loop2, $02, 2
	snd_loop .loop1, $01, 2
.loop3:
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note A_,3, 6
	silence
	note A_,3
	silence
	snd_loop .loop3, $01, 4
.loop4:
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note D_,3, 4
	silence 2
	note E_,3, 10
	silence 2
	note E_,3, 6
	silence
	note E_,3
	silence
	snd_loop .loop4, $01, 4
.loop5:
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note G_,3, 4
	silence 2
	note A_,3, 10
	silence 2
	note A_,3, 6
	silence
	note A_,3
	silence
	snd_loop .loop5, $01, 3
	note A#,3, 6
	silence
	note A#,3
	silence
	silence 12
	note A_,3, 6
	silence
	silence 12
	note G_,3, 6
	silence
	note A_,3
	silence
	note B_,2
	silence
	silence 24
	note B_,2, 96
	continue 24
	note D_,3
	note D_,3
	note D_,3
	note D_,3
	note D_,3
	note D_,3
	snd_loop .main
SndData_BGM_Boss_Ch4:
	panning $88
	fine_tune 48
	note4p $00, 93 ; envelope $00 ; note4 B_,6,0
.main:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	wait 6
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	snd_loop .main, $01, 7
	note4p $00, 72 ; envelope $00 ; note4 B_,6,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop1:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .loop1, $01, 7
	note4p $00, 72 ; envelope $00 ; note4 B_,6,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
.loop2:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .loop2, $01, 7
	note4p $00, 60 ; envelope $00 ; note4 B_,6,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop3:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .loop3, $01, 11
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00, 24 ; envelope $00 ; note4 B_,6,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main
SndData_Unused_0007D57E:
	chan_stop
