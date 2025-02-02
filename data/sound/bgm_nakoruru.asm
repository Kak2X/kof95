SndHeader_BGM_Nakoruru:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch3 ; Data ptr
	db 12 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Nakoruru_Ch1:
	envelope $95
	panning $11
	duty_cycle 3
	speed $00D8
	silence 48
	fine_tune -12
.main:
	envelope $95
	snd_call SndCall_BGM_Nakoruru_Ch1_0
	snd_loop .main, $01, 3
	silence 96
	fine_tune 12
	silence 48
	silence 6
	note D_,5
	note F_,5
	note D_,5
	note G_,5
	note D_,5
	note A_,5
	note D_,5
	note C_,6, 12
	note A#,5, 84
	silence 48
	silence 6
	note G_,5
	note A#,5
	note G_,5
	note C_,6
	note G_,5
	note D_,6, 12
	note F_,6, 36
	note E_,6, 6
	note D_,6
	note E_,6, 36
	note D_,6, 6
	note C_,6
	note D_,6, 54
	note D_,5, 6
	note F_,5
	note D_,5
	note G_,5
	note D_,5
	note A_,5
	note D_,5
	note C_,6, 12
	note A#,5, 84
	silence 48
	silence 6
	note G_,5
	note A#,5
	note G_,5
	note C_,6
	note G_,5
	note D_,6, 12
	note F_,6, 6
	note G_,6
	envelope $30
	note G_,6
	envelope $20
	note G_,6
	silence 12
	envelope $95
	note F_,6, 6
	note G_,6
	note G_,6
	note A#,6
	envelope $30
	note A#,6
	envelope $20
	note A#,6
	envelope $95
	note G_,6, 6
	note A#,6, 12
	note C_,7, 6
	note D_,7, 4
	silence 2
	note D_,7, 4
	silence 2
	note D_,7, 4
	silence 8
	silence 12
	note C_,7, 6
	note D_,7
	note C_,7
	note D_,7
	envelope $30
	note D_,7
	envelope $20
	note D_,7
	envelope $95
	note C_,7, 6
	note D_,7
	note A_,6
	note A#,6
	fine_tune -12
	snd_call SndCall_BGM_Nakoruru_Ch1_0
.loop1:
	snd_call SndCall_BGM_Nakoruru_Ch1_0
	fine_tune 12
	silence 30
	note C_,5, 6
	note E_,5
	note C_,5
	note F_,5
	note C_,5
	note G_,5
	note C_,5
	note A_,5
	note C_,5
	note A#,5
	note C_,5
	silence 30
	note C_,5, 6
	note E_,5
	note C_,5
	note E_,5
	note F_,5
	note G_,5
	note A_,5
	note A#,5
	note B_,5
	note C_,6
	note D_,6
	fine_tune -12
	snd_loop .loop1, $01, 2
	fine_tune 12
	envelope $72
.loop2:
	note D_,6, 6
	note E_,6
	note E_,6
	note E_,6
	note D_,6
	note E_,6
	note D_,6
	note E_,6
	snd_loop .loop2, $01, 4
	fine_tune -12
	snd_loop .main
SndData_BGM_Nakoruru_Ch2:
	envelope $D5
	panning $02
	duty_cycle 3
	silence 48
.main:
	snd_call SndCall_BGM_Nakoruru_Ch2_0
	snd_loop .main, $01, 3
	note C_,4, 6
	note D_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note C_,4, 6
	note D_,4
	note D_,4
	note F_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,4, 6
	note F_,4, 12
	note G_,4, 6
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 2
	silence 6
	note A_,3, 6
	note A_,3
	note G_,3
	note A_,3
	note G_,3
	note A_,3
	note A_,3, 2
	silence 4
	wait 2
	silence 4
	note G_,3, 6
	note A_,3
	note E_,3
	note F_,3
	envelope $72
.loop1:
	note G_,3, 6
	note D_,3
	note A#,2
	note D_,3
	note A#,2
	note G_,3
	note D_,3
	note A#,3
	note A#,2
	note G_,3
	note D_,3
	note A#,3
	note D_,4
	note A#,3
	note G_,3
	note D_,3
	note G_,4
	note D_,4
	note A#,3
	note D_,4
	note A#,3
	note G_,4
	note D_,4
	note A#,4
	note A#,3
	note G_,4
	note D_,4
	note A#,4
	note D_,5
	note A#,4
	note G_,4
	note D_,4
	snd_loop .loop1, $01, 2
	envelope $D5
	note C_,4, 6
	note D_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note C_,4, 6
	note D_,4
	note D_,4
	note F_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,4, 6
	note F_,4, 12
	note G_,4, 6
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 2
	silence 6
	note A_,3, 6
	note A_,3
	note G_,3
	note A_,3
	note G_,3
	note A_,3
	note A_,3, 2
	silence 4
	wait 2
	silence 4
	note G_,3, 6
	note A_,3
	note E_,3
	note F_,3
	note C_,4
	note D_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note C_,4, 6
	note D_,4
	note D_,4
	note F_,4
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,4, 6
	note F_,4, 12
	note G_,4, 6
	note A_,6, 4
	silence 2
	note A_,6, 4
	silence 2
	note A_,6, 4
	silence 8
	silence 12
	note G_,6, 6
	note A_,6
	note G_,6
	note A_,6
	silence 12
	note G_,6, 6
	note A_,6
	note E_,6
	note F_,6
.loop2:
	snd_call SndCall_BGM_Nakoruru_Ch2_0
	snd_loop .loop2, $01, 2
	note G_,3, 6
	wait 90
	note E_,3, 6
	wait 90
	snd_call SndCall_BGM_Nakoruru_Ch2_0
	note G_,3, 6
	wait 90
	note E_,3, 6
	wait 90
	note E_,4, 48
	note D#,4
	note D_,4
	note C_,4
	snd_loop .main
SndData_BGM_Nakoruru_Ch3:
	wave_vol $C0
	panning $40
	wave_id $02
	silence 48
.main:
	snd_call SndCall_BGM_Nakoruru_Ch3_0
	snd_loop .main, $01, 3
.loop1:
	note F_,4, 6
	note G_,4
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note F_,4, 6
	note G_,4
	note G_,4
	note A#,4
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,4, 6
	note A#,4, 12
	note C_,5, 6
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	silence 6
	note D_,3, 6
	note D_,3
	note C_,3
	note D_,3
	note C_,3
	note D_,3
	note D_,3, 2
	silence 4
	wait 2
	silence 4
	note C_,3, 6
	note D_,3
	note A_,2
	note A#,2
	snd_loop .loop1, $01, 5
.loop2:
	snd_call SndCall_BGM_Nakoruru_Ch3_0
	snd_loop .loop2, $01, 2
	note C_,3, 6
	wait 90
	note A_,2, 6
	wait 90
	snd_call SndCall_BGM_Nakoruru_Ch3_0
	note C_,3, 6
	wait 90
	note A_,2, 6
	wait 90
.loop3:
	note E_,3, 6
	note E_,3
	note D#,3
	note D#,3
	note D_,3
	note D_,3
	note D#,3
	note D#,3
	snd_loop .loop3, $01, 4
	snd_loop .main
SndData_BGM_Nakoruru_Ch4:
	panning $88
	fine_tune 16
	envelope $B1
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.main:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .main, $01, 6
.loop1:
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop1, $01, 6
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop2:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop2, $01, 6
	note4p $00, 96 ; envelope $00 ; note4 B_,6,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop3:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop3, $01, 4
.loop4:
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	wait 18
	wait 12
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop4, $01, 2
.loop5:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop5, $01, 2
.loop6:
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	wait 18
	wait 12
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop6, $01, 2
.loop7:
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop7, $01, 8
	snd_loop .main
SndCall_BGM_Nakoruru_Ch1_0:
	note F_,5, 6
	note G_,5
	envelope $30
	note G_,5
	envelope $20
	note G_,5
	silence 12
	envelope $95
	note F_,5, 6
	note G_,5
	note G_,5
	note A#,5
	envelope $30
	note A#,5
	envelope $20
	note A#,5
	envelope $95
	note G_,5, 6
	note A#,5, 12
	note C_,6, 6
	note D_,6, 4
	silence 2
	note D_,6, 4
	silence 2
	note D_,6, 4
	silence 8
	silence 12
	note C_,6, 6
	note D_,6
	note C_,6
	note D_,6
	envelope $30
	note D_,6
	envelope $20
	note D_,6
	envelope $95
	note C_,6, 6
	note D_,6
	note A_,5
	note A#,5
	snd_ret
SndCall_BGM_Nakoruru_Ch3_0:
	note F_,3, 6
	note G_,3
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note F_,3, 6
	note G_,3
	note G_,3
	note A#,3
	note G_,3, 4
	silence 2
	note G_,3, 4
	silence 2
	note G_,3, 6
	note A#,3, 12
	note C_,3, 6
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 8
	silence 12
	note C_,3, 6
	note D_,3
	note C_,3
	note D_,3
	note D_,3, 2
	silence 4
	wait 2
	silence 4
	note C_,3, 6
	note D_,3
	note A_,2
	note A#,2
	snd_ret
SndCall_BGM_Nakoruru_Ch2_0:
	note C_,3, 6
	note D_,3
	envelope $30
	note D_,3
	envelope $20
	note D_,3
	silence 12
	envelope $95
	note C_,3, 6
	note D_,3
	note D_,3
	note F_,3
	note D_,3, 4
	silence 2
	note D_,3, 4
	silence 2
	note D_,3, 6
	note F_,3, 12
	note G_,2, 6
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 2
	note A_,3, 4
	silence 8
	silence 12
	note G_,3, 6
	note A_,3
	note G_,3
	note A_,3
	note A_,3, 2
	silence 4
	wait 2
	silence 4
	note G_,3, 6
	note A_,3
	note E_,3
	note F_,3
	snd_ret
