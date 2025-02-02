SndHeader_BGM_Credits:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch3 ; Data ptr
	db 12 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Credits_Ch1:
	envelope $86
	panning $11
	duty_cycle 0
	speed $00A1
.main:
	envelope $86
	duty_cycle 0
	note D#,5, 2
	note E_,5
	note F_,5, 6
	silence
	note D_,5, 80
	envelope $77
	silence 24
	silence 8
	note A_,4, 2
	note A#,4, 6
	silence 8
	note G#,4, 2
	note A_,4
	note A#,4, 12
	note G#,4, 8
	silence
	note F#,4
	note F_,4
	envelope $87
	note D#,5, 2
	note E_,5
	note F_,5, 6
	silence
	note D_,5, 80
	silence 24
	silence 8
	note A_,4, 2
	note A#,4, 6
	silence 8
	note G#,4, 2
	note A_,4
	note A#,4, 12
	note G#,4, 8
	silence
	note F#,4
	note F_,4
	envelope $87
	note G_,4, 96
	silence 80
	duty_cycle 3
	note C#,5, 2
	note D_,5, 6
	note C_,5, 8
	note A#,4, 2
	note B_,4, 6
	note G_,4, 8
	note D_,4, 64
	wait 8
	note D_,4
	note D_,4, 2
	note D#,4, 6
	note A_,4, 8
	note G_,4, 2
	note G#,4
	note A_,4, 36
	note G_,3, 8
	note A_,3
	note B_,3
	note C_,4
	note D_,4
	note A_,3
	note G_,3
	note F#,4, 2
	note G_,4, 62
	duty_cycle 0
	note A#,4, 2
	note B_,4, 6
	note A#,4, 2
	note B_,4, 6
	note C_,5, 2
	note C#,5
	note D_,5, 12
	wait 8
	silence 8
	silence 8
	note D_,5, 40
	duty_cycle 3
	note C#,5, 2
	note D_,5, 6
	note C_,5, 8
	note A#,4, 2
	note B_,4, 6
	note G_,4, 8
	note D_,4, 64
	wait 8
	note D_,4
	note D_,4, 2
	note D#,4, 6
	note A_,4, 8
	note G_,4, 2
	note G#,4
	note A_,4, 36
	note G_,3, 8
	note A_,3
	note B_,3
	note C_,4
	note D_,4
	note A_,3
	note G_,3
	note F#,4, 2
	note G_,4, 78
	duty_cycle 0
	note B_,4, 16
	wait 8
	silence 32
	duty_cycle 3
	note A#,4, 8
	note B_,4
	note C_,5
	note D#,5
	note F_,5
	note A#,5, 16
	wait 40
	note G#,5, 8
	note G_,5
	note F_,5
	note C_,5
	note C#,5
	note D_,5
	note D#,5
	note F_,5
	note D_,5
	note A#,4, 48
	wait 8
	note B_,4
	note G_,5
	note F_,5, 64
	note D#,5, 24
	note D_,5, 96
	silence
	snd_loop .main
SndData_BGM_Credits_Ch2:
	envelope $86
	panning $20
	duty_cycle 0
.main:
	envelope $86
	note G#,4, 2
	note A_,4
	note A#,4, 6
	silence
	note A#,4, 80
	envelope $77
	silence 24
	silence 8
	note D_,4, 2
	note D#,4, 6
	silence 8
	note C#,4, 2
	note D_,4
	note D#,4, 12
	note C#,4, 8
	silence
	note C#,4
	note C#,4
	envelope $87
	note G#,4, 2
	note A_,4
	note A#,4, 6
	silence
	note A#,4, 80
	silence 24
	silence 8
	note D_,4, 2
	note D#,4, 6
	silence 8
	note C#,4, 2
	note D_,4
	note D#,4, 12
	note C#,4, 8
	silence
	note C#,4
	note C#,4
	note E_,4, 96
	silence
	envelope $86
	note B_,4, 16
	wait 8
	silence 16
	note D_,4, 8
	note F#,4
	note F_,4
	note E_,4
	note D_,4, 24
	note B_,4, 16
	wait 8
	silence 8
	note D_,4
	note D_,4
	note D#,4
	note A_,4
	note A_,4, 32
	note B_,4, 16
	wait 8
	silence 56
	note F#,4, 2
	note G_,4, 6
	note F#,4, 2
	note G_,4, 6
	note A_,4, 16
	note A_,4, 8
	silence
	silence
	note A_,4, 40
	silence 16
	note B_,4
	note B_,4, 8
	silence 16
	note D_,4, 8
	note F#,4
	note F_,4
	note E_,4
	note D_,4, 24
	note B_,4, 16
	wait 8
	silence 8
	note D_,4
	note D_,4
	note D#,4
	note A_,4
	note A_,4, 32
	note B_,4, 16
	wait 8
	silence 72
	note G_,4, 16
	wait 8
	silence 24
	note A#,4
	note G_,4
	note A#,4, 16
	wait 8
	silence 72
	note A#,4, 16
	wait 8
	silence 72
	note G#,4, 16
	wait 8
	silence 8
	note G#,4
	note G#,4
	note D#,4
	note D_,4
	note C_,4
	note C_,5, 24
	note A#,4, 16
	wait 8
	silence 72
	note C_,5, 96
	snd_loop .main
SndData_BGM_Credits_Ch3:
	wave_vol $C0
	panning $04
	wave_id $03
.main:
	note C_,3, 36
	silence 4
	note G_,3, 6
	silence 2
	note C_,4, 22
	silence 2
	note G_,3, 6
	silence 2
	note F#,3, 6
	silence 2
	note F_,3, 6
	silence 2
	note E_,3, 36
	silence 12
	note G#,3, 22
	silence 2
	note A#,3, 22
	silence 2
	snd_loop .main, $01, 2
	note C_,3, 36
	silence 4
	note G_,3, 6
	silence 2
	note C_,4, 22
	silence 2
	note G#,3, 2
	note A_,3
	note A#,3
	note B_,3
	note C_,4, 16
	note C_,3, 22
	silence 2
	note C_,3, 6
	silence 18
	silence 48
.loop1:
	note C_,3, 36
	silence 4
	note G_,3, 6
	silence 2
	note C_,4, 22
	silence 2
	note G_,3, 22
	silence 2
	snd_loop .loop1, $01, 7
	note C_,3, 36
	silence 4
	note C_,3, 6
	silence 2
	note F_,3, 22
	silence 2
	note G_,3, 22
	silence 2
	note C_,3, 16
	note C_,3, 8
	silence 8
	note C#,3, 6
	silence 2
	note D_,3, 6
	silence 2
	note A#,3, 16
	note G#,3
	note C_,3, 6
	silence 2
	note C#,3, 6
	silence 2
	note G_,3, 16
	note G_,3, 6
	silence 2
	note F#,3, 16
	note F#,3, 6
	silence 2
	note E_,3, 6
	silence 2
	note D#,3, 6
	silence 2
	note D_,3, 6
	silence 2
	note C#,3, 6
	silence 2
	note C_,3, 6
	silence 2
	note B_,2, 6
	silence 2
	note F_,3, 8
	silence
	note F_,3
	silence
	note C_,3, 6
	silence 2
	note F_,3, 6
	silence 2
	note G_,3, 22
	silence 2
	note G_,3, 22
	silence 2
	note C_,3, 22
	silence 18
	note G_,3, 6
	silence 2
	note C_,4, 22
	silence 2
	note C_,4, 22
	silence 2
	note C_,3, 24
	silence 72
	snd_loop .main
SndData_BGM_Credits_Ch4:
	panning $88
	fine_tune 48
.main:
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .main, $01, 5
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 24 ; envelope $51 ; note4 F_,5,0
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
.loop1:
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop1, $01, 7
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 4 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop2:
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop2, $01, 3
	note4p $03, 8 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 4
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 4 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 8 ; envelope $52 ; note4 B_,5,0
	note4p $00, 16 ; envelope $00 ; note4 B_,6,0
	snd_loop .main
