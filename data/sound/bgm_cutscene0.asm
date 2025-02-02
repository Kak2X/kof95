SndHeader_BGM_Cutscene0:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_Cutscene0_Ch1:
	envelope $B7
	panning $11
	duty_cycle 2
	speed $00BA
.main:
	envelope $97
	note F_,4, 48
	note C_,5, 36
	note B_,4, 96
	note A#,4
	note E_,4
	silence 12
	note F_,4, 48
	note C_,5, 36
	note B_,4, 96
	note A#,4
	note E_,5
	silence 12
	note C_,3
	note C_,3, 6
	silence
	silence
	note A#,3
	note G#,3, 12
	silence 42
	envelope $91
	note D_,5, 6
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	envelope $97
	note C_,3, 12
	note C_,3, 6
	silence
	silence
	note A#,3
	note G#,3, 12
	silence 48
	silence 96
	note C_,3, 12
	note C_,3, 6
	silence
	silence
	note A#,3
	note G#,3, 12
	silence 42
	envelope $91
	note D_,5, 6
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	note D#,5
	note D_,5
	note D#,5
	envelope $97
	note C_,3, 12
	note C_,3, 6
	silence
	silence
	note A#,3
	note G#,3, 12
	silence 48
	silence 54
	note F_,3, 6
	note G#,3
	note F_,3
	note G#,3
	note A#,3
	note C_,4
	note F_,4
	note F_,4, 24
	note A#,4, 96
	continue 12
	note G#,4
	note G_,4, 24
	note F#,4
	note F_,4
	note D_,5, 96
	continue 24
	note C#,5
	note C_,5
	note F_,4
	note A#,4, 96
	continue 12
	note G#,4
	note G_,4, 24
	note F#,4
	note F_,4
	note D_,5, 96
	continue 12
	note C_,5
	note G#,5, 24
	note C_,5, 96
	continue 96
	snd_loop .main
SndData_BGM_Cutscene0_Ch2:
	envelope $B7
	panning $20
	duty_cycle 1
.loop1:
	envelope $97
	silence 1
	note C_,3, 48
	note C_,4, 36
	note B_,3, 96
	note A#,3
	note E_,3
	silence 12
	note C_,3, 48
	note C_,4, 36
	note B_,3, 96
	note A#,3
	note E_,4
	silence 11
.main:
	silence 90
	envelope $91
	note B_,4, 6
	note C_,5
	note C_,5
	note B_,4
	note C_,5
	note C_,5
	note B_,4
	note C_,5
	note C_,5
	note B_,4
	note C_,5
	note C_,5
	note B_,4
	note C_,5
	note C_,5
	note B_,4
	note C_,5
	silence 96
	silence
	snd_loop .main, $01, 2
	envelope $97
	note C_,3, 6
	silence 18
	silence 12
	note A_,3
	note A_,3, 36
	note F_,3, 12
	note D#,3, 36
	wait 12
	note D_,3, 24
	note C#,3
	note C_,3
	silence 12
	note G#,3
	note A_,3, 36
	note F_,3, 12
	note D#,3, 36
	wait 12
	note D_,3, 24
	note C#,3
	note C_,3
	silence 12
	note G#,3
	note A_,3, 36
	note F_,3, 12
	note D#,3, 36
	wait 12
	note D_,3, 24
	note C#,3
	note C_,3
	silence 12
	note G#,3
	note A_,3, 36
	note F_,3, 12
	note D#,3, 36
	note F_,3, 12
	note F#,3, 24
	note G_,3, 96
	continue 96
	snd_loop .loop1
SndData_Unused_0007D775:
	chan_stop
SndData_BGM_Cutscene0_Ch3:
	wave_vol $C0
	panning $04
	wave_id $03
.main:
	wave_id $03
	note F_,3, 48
	wait 12
	note G_,3
	note G#,3
	note F_,3, 60
	note B_,3, 12
	note C_,4
	note D_,4
	note F_,3, 60
	note A#,3, 12
	note C_,4
	note C#,4
	note C_,4, 24
	note C#,4, 12
	note A#,3
	note C_,4
	note G#,3
	silence
	silence 6
	note E_,3
	silence 12
	snd_loop .main, $01, 2
	wave_id $06
	note F_,3, 12
	note F_,3, 6
	silence
	silence 72
	silence 54
	note F_,3, 6
	note C_,4
	note A#,3
	note F_,3
	note A#,3
	note C_,4
	note D#,4
	note F_,3, 12
	note F_,3, 6
	silence
	silence 72
	note D#,3, 54
	note F_,3, 6
	note G#,3
	note F_,3
	note G#,3
	note A#,3
	note B_,3
	note C_,4
	note F_,3, 12
	note F_,3, 6
	silence
	silence 72
	silence 54
	note F_,3, 6
	note C_,4
	note A#,3
	note F_,3
	note A#,3
	note C_,4
	note D#,4
	note F_,3, 12
	note F_,3, 6
	silence
	silence 72
	silence 96
	note F_,3, 6
	silence 18
	silence 12
	note C#,4
	note D_,4, 36
	note A#,3, 12
	note G#,3, 36
	wait 12
	note G_,3, 24
	note F#,3
	note F_,3
	silence 12
	note C#,4
	note D_,4, 36
	note A#,3, 12
	note G#,3, 36
	wait 12
	note G_,3, 24
	note F#,3
	note F_,3
	silence 12
	note C#,4
	note D_,4, 36
	note A#,3, 12
	note G#,3, 36
	wait 12
	note G_,3, 24
	note F#,3
	note F_,3
	silence 12
	note C#,4
	note D_,4, 36
	note A#,3, 12
	note G#,3, 36
	note A#,2, 12
	note B_,2, 24
	note C_,3, 96
	silence 96
	snd_loop .main
SndData_Unused_0007D821:
	chan_stop
SndData_BGM_Cutscene0_Ch4:
	panning $88
	fine_tune 16
	envelope $A1
.main:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 3 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00, 6 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00, 12 ; envelope $00 ; note4 B_,6,0
	snd_loop .main, $01, 2
.loop1:
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 3 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	snd_loop .loop1, $01, 3
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $04 ; envelope $53 ; note4x $11 ; Nearest: A#,6,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03, 3 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 12 ; envelope $52 ; note4 B_,5,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
.loop2:
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
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
	snd_loop .loop2, $01, 4
	note4p $03, 6 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	snd_loop .main
SndData_Unused_0007D905:
	chan_stop
