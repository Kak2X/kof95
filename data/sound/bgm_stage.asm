SndHeader_BGM_Stage:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Stage_Ch1:
	envelope $B7
	panning $11
	duty_cycle 3
	speed $00E2
.loop1:
	note D_,4, 6
	note D#,4
	note E_,4
	note B_,4
	note A#,4
	note A_,4
	note E_,5
.main:
	note D_,5, 72
	note A_,4, 2
	note A#,4
	note B_,4, 14
	note A#,4, 6
	continue 66
	silence 6
	note G_,4, 2
	note G#,4
	note A_,4, 20
	note A#,4, 6
	note A_,4
	silence
	note D_,4
	silence
	note D_,4
	silence
	note G_,4, 2
	note G#,4
	note A_,4, 14
	note G_,4, 6
	silence
	silence 24
	silence 54
	note D_,4, 6
	note D#,4
	note E_,4
	note B_,4
	note A#,4
	note A_,4
	note E_,5
	note D_,5, 72
	note A_,4, 2
	note A#,4
	note B_,4, 14
	note A#,4, 6
	continue 66
	silence 6
	note G_,4, 2
	note G#,4
	note A_,4, 20
	note A#,4, 6
	note A_,4
	silence
	note D_,4
	silence
	note D_,4
	silence
	note G_,4, 2
	note G#,4
	note A_,4, 14
	note G_,4, 6
	silence
	silence 24
	silence 96
	silence 24
	note E_,4, 6
	note D_,4
	note D#,4
	note E_,4
	silence 12
	note E_,5, 6
	note D_,5
	note D#,5
	note E_,5
	silence
	note D#,5, 2
	note E_,5, 4
	continue 6
	note E_,5
	note D#,5
	note D_,5
	note B_,4
	note A#,4
	note A_,4
	note A_,4, 2
	note A#,4
	note B_,4, 8
	wait 6
	note A#,4
	note A_,4
	note A#,4
	note A_,4
	note D_,4, 12
	note E_,4, 6
	note D#,4
	note D_,4
	note B_,3
	note D_,4
	note E_,4
	silence
	note E_,4, 12
	note D#,4, 6
	note D_,4
	note B_,3
	note D_,4
	note E_,4
	silence
	note E_,5
	continue 6
	note E_,5
	note D_,5
	note B_,4
	note D_,5
	note B_,4
	note A_,4
	note G_,4, 4
	note A_,4
	note A#,4
	note B_,4, 6
	note C_,5
	note D_,5
	note D#,5
	note E_,5
	silence
	silence
	silence 24
	note E_,4, 6
	note D_,4
	note D#,4
	note E_,4
	silence 12
	note E_,5, 6
	note D_,5
	note D#,5
	note E_,5
	silence
	note D#,5, 2
	note E_,5, 4
	continue 6
	note E_,5
	note D#,5
	note D_,5
	note B_,4
	note A#,4
	note A_,4
	note A_,4, 2
	note A#,4
	note B_,4, 8
	wait 6
	note A#,4
	note A_,4
	note A#,4
	note A_,4
	note D_,4, 12
	note E_,4, 6
	silence
	note E_,4
	silence
	note B_,4
	note A#,4, 12
	note A_,4, 6
	note A#,4
	note A_,4
	note G_,4, 12
	note D_,4, 4
	note F#,4
	note G_,4
	note A_,4, 6
	note A#,4
	note G_,4
	note E_,4
	note D_,4
	note A#,4
	note A_,4
	note G_,4
	note B_,4
	note A#,4
	note D_,4
	note E_,4
	note F#,4
	note G_,4
	note A_,4
	note A#,4
	note B_,4
	note C#,5
	snd_loop .main, $01, 2
	note D_,5, 72
	note B_,4, 24
	note D_,5, 36
	wait 24
	note E_,5, 36
	note C#,5, 96
	silence
	note C_,5
	note C_,5, 36
	wait 24
	note D_,5, 36
	note B_,4, 96
	note D_,5, 6
	note D_,5
	silence
	note D_,5, 12
	note E_,5
	note D_,5, 6
	silence
	snd_loop .loop1
SndData_BGM_Stage_Ch2:
	envelope $B6
	panning $02
	duty_cycle 2
.loop1:
	silence 42
.main:
	note B_,4, 24
	note A#,4
	note A_,4
	note G_,4
	note G_,4, 6
	note G_,4
	note E_,4
	note G_,4, 12
	note G_,4
	note E_,4, 6
	note D_,4
	note D_,4
	note B_,3
	note F#,4, 12
	note F#,4
	note A_,4, 6
	note G_,4
	note F#,4
	silence
	note B_,3
	silence
	note B_,3
	silence
	note E_,4, 2
	note F_,4
	note F#,4, 14
	note E_,4, 6
	silence
	note C_,5, 2
	note C#,5
	note D_,5, 20
	note E_,5, 6
	note D_,5
	silence
	note B_,4
	silence
	note A_,4
	silence
	note G_,4
	note D_,4
	note B_,3
	note C_,4
	note C#,4
	note G#,4
	note G_,4
	note F#,4
	note C#,5
	note B_,4, 24
	note A#,4
	note A_,4
	note G_,4
	note G_,4, 6
	note G_,4
	note E_,4
	note G_,4, 12
	note G_,4
	note E_,4, 6
	note D_,4
	note D_,4
	note B_,3
	note F#,4, 12
	note F#,4
	note A_,4, 6
	note G_,4
	note F#,4
	silence
	note B_,3
	silence
	note B_,3
	silence
	note E_,4, 2
	note F_,4
	note F#,4, 14
	note E_,4, 6
	silence
	note C_,5, 2
	note C#,5
	note D_,5, 20
	note E_,5, 6
	note D_,5
	note B_,4
	note D_,5
	note C_,5
	note A_,4
	note G_,4
	note B_,4
	note A_,4
	note G_,4
	note A_,4
	note G_,4
	note F#,4, 4
	note F_,4
	note E_,4
	note D_,4, 6
	note E_,5
	note B_,3, 12
	silence
	note C#,4, 6
	note B_,3
	note C_,4
	note C#,4
	silence 12
	note C#,5, 6
	note B_,4
	note C_,5
	note C#,5
	silence
	note G_,4
	continue 24
	note G_,4, 12
	note E_,4, 6
	note G_,4, 12
	note G_,4
	note E_,4, 6
	note B_,3, 12
	note G_,4, 6
	note B_,4
	note G#,3
	note G#,3
	silence 24
	note G#,3, 6
	note G#,3
	silence
	note G#,3
	note D#,3, 12
	note F#,3
	note G_,3, 6
	note G_,3
	note B_,3
	note B_,3
	silence 24
	note B_,3, 6
	note B_,3
	silence
	note B_,3
	note B_,3, 12
	note B_,3
	note B_,3, 6
	note B_,3
	note B_,3, 12
	silence
	note C#,4, 6
	note B_,3
	note C_,4
	note C#,4
	silence 12
	note C#,5, 6
	note B_,4
	note C_,5
	note C#,5
	silence
	note G_,4
	continue 24
	note G_,4, 12
	note E_,4, 6
	note G_,4, 12
	note G_,4
	note E_,4, 6
	note B_,3, 12
	note G_,4, 6
	note B_,4
	note G#,3
	note G#,3
	silence 24
	note G#,3, 6
	note G#,3
	silence
	note G#,3
	note D#,3, 12
	note F#,3
	note G_,3, 6
	note G_,3
	note D_,4, 12
	note D_,4
	note E_,4, 6
	note D_,4, 12
	note B_,3
	note A#,3
	note A_,3, 6
	note A#,3
	note D_,4
	note G_,4
	silence
	snd_loop .main, $01, 2
	note B_,4, 24
	note G_,4
	note B_,4
	note F#,4
	note A_,4, 18
	note A_,4
	note A_,4, 24
	note C#,5, 12
	note B_,4
	note A_,4
	note G_,4, 18
	note G_,4
	note E_,4, 12
	note F#,4, 18
	note E_,4
	note D_,4, 6
	note B_,3
	note E_,4
	note E_,4
	note B_,3, 12
	note G_,4
	note F#,4, 6
	note E_,4, 12
	note E_,4
	note D_,4, 6
	note B_,3, 12
	note A_,3
	note A_,4, 18
	note G_,4
	note E_,4, 12
	note B_,4
	note A_,4
	note G_,4, 6
	note E_,4
	note C_,4
	note E_,4
	note F#,4, 18
	note E_,4
	note C_,4, 12
	note C_,4
	note E_,4
	note F#,4, 6
	note E_,4
	note C_,4, 12
	note G_,4, 6
	note G_,4
	note B_,3
	note G_,4
	note G_,4
	note B_,3
	note D_,4
	note E_,4
	note F#,4
	note G_,4
	note A_,4
	note A#,4
	note B_,4
	note C_,5
	note D_,5
	note E_,5
	note B_,4
	note B_,4
	silence
	note B_,4, 12
	note C#,5
	note B_,4, 6
	silence
	snd_loop .loop1
SndData_BGM_Stage_Ch3:
	wave_vol $C0
	panning $40
	wave_id $04
	silence 42
.main:
	note E_,3, 6
	note E_,3
	silence 24
	note E_,3, 6
	note E_,3
	silence
	note E_,3
	note B_,2, 12
	note D_,3
	note D#,3, 6
	note D#,3
	snd_loop .main, $02, 7
	note E_,3, 6
	note E_,3
	silence
	note D_,3
	silence
	note C_,3
	silence
	note B_,2
	silence
	note A#,2
	silence
	note A_,2
	silence
	note G_,3
	silence
	silence
.loop1:
	note E_,3, 6
	note E_,3
	silence 24
	note E_,3, 6
	note E_,3
	silence
	note E_,3
	note B_,2, 12
	note D_,3
	note D#,3, 6
	note D#,3
	snd_loop .loop1, $02, 7
	note D_,3, 12
	note D_,3
	note E_,3, 6
	note D_,3, 12
	note B_,2
	note A#,2
	note A_,2, 6
	note A#,2
	note D_,3
	note G_,3
	silence
	snd_loop .main, $01, 2
	note G_,3, 24
	note D_,3, 12
	note B_,2, 6
	note G_,3, 12
	note G_,3
	note D_,3, 6
	note B_,2
	note D_,3
	note G_,3, 12
	note F#,3, 24
	note D_,3, 12
	note A_,2, 6
	note F#,3, 12
	note F#,3
	note D_,3, 6
	note A_,2
	note D_,3
	note F#,3, 12
	note E_,3
	note E_,3
	note D_,3
	note B_,2, 6
	note A_,2, 12
	note B_,2
	note D_,3, 6
	note E_,3
	note F#,3
	note G_,3, 12
	note E_,3, 6
	note E_,3
	note B_,2, 12
	note G_,3
	note F#,3, 6
	note E_,3, 12
	note E_,3
	note D_,3, 6
	note B_,2, 12
	note A_,2
	note C_,3, 6
	note C_,3
	note E_,3
	silence
	note G_,3
	silence
	note E_,3
	note C_,3, 12
	note C_,3
	note C_,3, 6
	note C_,3
	note E_,3
	note G_,3, 12
	note C_,3, 6
	note C_,3
	note E_,3
	silence
	note G_,3
	silence
	note E_,3
	note C_,3, 12
	note C_,3
	note C_,3, 6
	note D_,3
	note E_,3
	note A_,3, 12
	note B_,3
	note B_,3
	note A_,3, 6
	note G_,3, 12
	note F#,3
	note E_,3
	note D_,3, 6
	note B_,2
	note C_,3
	note B_,2, 12
	note D_,3, 6
	note D_,3
	silence
	note D_,3, 12
	note E_,3
	note D_,3, 6
	silence
	silence 42
	snd_loop .main
SndData_BGM_Stage_Ch4:
	panning $88
	fine_tune 48
	note4p $00, 42 ; envelope $00 ; note4 B_,6,0
.main:
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main, $02, 2
.loop1:
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .loop1, $02, 3
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $02, 4 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop2:
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $04, 12 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .loop2, $03, 3
	note4p $01, 18 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .loop2, $02, 2
	snd_loop .main, $01, 2
.loop3:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .loop3, $01, 7
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main
