SndHeader_BGM_Ending:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Ending_Ch1:
	envelope $B7
	panning $11
	duty_cycle 3
	speed $00CE
.main:
	note B_,4, 44
	silence 4
	note D_,5, 18
	note A_,5
	note G_,5, 12
	note F#,5, 24
	note A_,4, 12
	note D_,5, 36
	note B_,5, 12
	note A_,5
	note A_,5, 18
	note D_,5, 54
	note B_,5, 12
	note A_,5
	note A_,5, 18
	note C#,5, 78
	note B_,4, 44
	silence 4
	note D_,5, 18
	note A_,5
	note G_,5, 12
	note F#,5, 24
	note A_,4, 12
	note D_,5, 36
	note B_,5, 12
	note A_,5
	note A_,5, 18
	note D_,5, 54
	note B_,5, 12
	note A_,5
	note A_,5, 18
	note C#,5, 54
	note B_,4, 6
	note C#,5
	note D_,5
	note E_,5
	note F#,5
	silence 18
	note D_,5, 6
	silence
	note E_,5
	silence 18
	note C#,5, 6
	silence 18
	note D_,5, 12
	continue 72
	note B_,4, 6
	note C#,5
	note D_,5
	note E_,5
	note F#,5
	silence 18
	note D_,5, 6
	silence
	note E_,5
	silence 18
	note C#,5, 6
	silence 18
	note D_,5, 12
	continue 96
	snd_loop .main
SndData_BGM_Ending_Ch2:
	envelope $B3
	panning $02
	duty_cycle 3
.loop1:
	note F#,4, 6
	note D_,4
	note B_,3
	note F#,4
	note D_,4
	note B_,3
	note F#,4
	note B_,4
	note B_,4
	note D_,4
	note F#,4
	note B_,3
	note B_,4
	note E_,4
	note A_,4
	note E_,4
	note D_,4, 12
	silence 6
	note C#,4
	note D_,4
	note F#,4
	note F#,4, 12
	note E_,4
	note D_,4
	note F#,4, 6
	note G_,4
	note B_,4
	note F#,4
.main:
	note B_,4, 6
	note A_,4
	note D_,4
	note B_,4
	note A_,4
	note D_,4
	note B_,4
	note A_,4
	snd_loop .main, $02, 2
	note A_,4, 6
	note G_,4
	note C#,4
	note A_,4
	note G_,4
	note C#,4
	note A_,4
	note G_,4
	note A_,4
	note F#,4
	note C#,4
	note A_,4
	note F#,4
	note C#,4
	note A_,4
	note F#,4
	snd_loop .loop1, $01, 2
	note C#,5, 6
	silence 18
	note A_,4, 6
	silence
	note B_,4
	silence 18
	note G#,4, 6
	silence 18
	note A_,4, 12
	continue 72
	note F#,4, 6
	note G#,4
	note A_,4
	note B_,4
	note C#,5
	silence 18
	note A_,4, 6
	silence
	note B_,4
	silence 18
	note G#,4, 6
	silence 18
	note A_,4, 12
	continue 96
	snd_loop .loop1
SndData_BGM_Ending_Ch3:
	wave_vol $C0
	panning $40
	wave_id $04
.main:
	note B_,3, 12
	silence 6
	note B_,3
	silence 12
	note B_,3
	silence
	note B_,3
	silence 6
	wait 12
	note A#,3, 6
	note A_,3, 12
	silence 6
	note A_,3
	silence 12
	note A_,3
	silence
	note A_,3, 6
	silence
	note C#,3
	note D_,3
	note F#,3
	note C#,3
	note B_,2, 12
	silence 6
	note D_,3
	silence 12
	note D_,3
	silence
	note D_,3
	silence 6
	wait 12
	wait 6
	note A_,3, 12
	silence 6
	note C#,3
	silence 12
	note C#,3
	silence
	note C#,3
	silence 6
	note D_,3, 12
	note C#,3, 6
	note B_,2, 12
	note A_,2
	note B_,2, 24
	wait 12
	note B_,2
	silence 6
	wait 12
	note A#,2, 6
	note A_,3, 12
	silence 6
	note A_,3
	silence 12
	note A_,3
	silence
	note A_,3, 6
	silence
	note C#,3
	note D_,3
	note F#,3
	note C#,3
	note B_,2, 12
	silence 6
	note D_,3
	silence 12
	note D_,3
	silence
	note D_,3
	silence 6
	wait 12
	wait 6
	note A_,3, 12
	silence 6
	note C#,3
	silence 12
	note C#,3
	silence
	note C#,3
	silence 6
	note D_,3, 12
	note C#,3, 6
	note F#,3
	silence 18
	note D_,3, 6
	silence
	note E_,3
	silence 18
	silence 12
	note C#,3
	note D_,3
	continue 12
	note B_,3, 6
	note F#,3
	note D_,3
	note A_,3, 12
	note A#,3
	note B_,3
	note A_,3
	note A#,3
	note B_,3, 6
	note F#,3
	silence 18
	note D_,3, 6
	silence
	note E_,3
	silence 18
	silence 12
	note C#,3
	note D_,3
	continue 24
	silence 12
	note B_,2, 4
	note D_,3
	note F#,3
	note B_,3, 12
	note A_,3, 6
	note F#,3
	note E_,3
	note D_,3
	note C#,3
	note B_,2
	snd_loop .main
SndData_BGM_Ending_Ch4:
	panning $88
	fine_tune 48
.main:
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	snd_loop .main, $02, 3
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 4 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main, $01, 2
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00, 18 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 6
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 12 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	wait 6
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02, 4 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main
