SndHeader_BGM_CharSelect:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch1 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch2 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_BGM_CharSelect_Ch1:
	envelope $A7
	panning $11
	duty_cycle 2
	speed $00F6
.main:
	note C_,5, 96
	note F_,4, 12
	envelope $30
	note F_,4, 6
	envelope $A7
	note F_,4, 12
	envelope $30
	note F_,4, 6
	envelope $A7
	note F_,4, 6
	envelope $40
	note F_,4
	envelope $A7
	note D#,4, 48
	snd_loop .main
SndData_BGM_CharSelect_Ch2:
	envelope $A7
	panning $20
	duty_cycle 2
.main:
	note C_,4, 48
	note G_,4
	note C_,4, 38
	silence 10
	note G_,3, 24
	note A#,4
	snd_loop .main
SndData_BGM_CharSelect_Ch3:
	wave_vol $C0
	panning $04
	wave_id $03
.main:
	note C_,3, 6
	note C_,3
	note A#,2
	note C_,3
	silence 12
	note G_,3, 6
	silence 18
	note F_,3, 4
	note A#,3
	note C_,4
	note F_,4, 6
	silence
	note C_,4, 4
	note A#,3
	note G_,3
	note F_,3, 6
	silence
	note F_,3
	note F_,3
	silence
	note F_,3
	note F_,3
	silence
	note A#,3
	silence
	note A#,3
	note A#,3
	silence
	note A#,3
	note A#,3
	silence
	snd_loop .main
SndData_BGM_CharSelect_Ch4:
	panning $88
	fine_tune 16
	envelope $B1
.main:
	note4p $01, 24 ; envelope $51 ; note4 F_,5,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $01, 12 ; envelope $51 ; note4 F_,5,0
	note4p $03, 3 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $00, 18 ; envelope $00 ; note4 B_,6,0
	note4p $01, 6 ; envelope $51 ; note4 F_,5,0
	note4p $03, 3 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $03 ; envelope $31 ; note4x $21 ; Nearest: A#,5,0
	note4p $02, 6 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $01 ; envelope $51 ; note4 F_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $00 ; envelope $00 ; note4 B_,6,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	note4p $02 ; envelope $52 ; note4 B_,5,0
	snd_loop .main
