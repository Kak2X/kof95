SndHeader_BGM_Boss:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Boss_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Boss_Ch1:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 2, 0
	sndtinc $00EC
	sndnote $12
	sndlen 12
	sndnote $13
	sndlen 3
	sndnote $14
	sndnote $15
	sndnote $16
	sndnote $17
	sndnote $18
	sndnote $19
	sndnote $1A
	sndnote $1B
	sndnote $1C
	sndnote $1D
	sndnote $1E
	sndnote $1F
	sndnote $20
	sndnote $21
	sndnote $22
	sndnote $23
	sndnote $25
	sndnote $27
	sndnote $2B
	sndlen 6
	sndnote $00
	sndlen 18
.main:
	sndnr11 2, 0
	sndenv 10, SNDENV_DEC, 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndenv 5, SNDENV_DEC, 2
	sndnote $1F
	sndlen 6
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $2B
	sndlen 4
	sndnote $2B
	sndnote $2B
	sndnote $37
	sndlen 6
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndloopcnt $01, 3, .main
	sndenv 10, SNDENV_DEC, 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndenv 5, SNDENV_DEC, 2
	sndnote $1F
	sndlen 6
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 72
	sndenv 10, SNDENV_DEC, 7
	sndnr11 3, 0
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $1A
	sndlen 24
	sndnote $18
	sndenv 11, SNDENV_DEC, 7
	sndnote $1D
	sndlen 36
	sndnote $18
	sndnote $24
	sndlen 24
	sndnote $23
	sndlen 96
	sndnote $22
	sndlen 36
	sndnote $20
	sndnote $1F
	sndlen 24
	sndnote $1D
	sndlen 36
	sndnote $18
	sndlen 60
	sndnote $11
	sndlen 96
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 12
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 12
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 54
	sndnote $00
	sndlen 96
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $1A
	sndlen 24
	sndnote $18
	sndnote $1D
	sndlen 36
	sndnote $18
	sndnote $24
	sndlen 24
	sndnote $23
	sndlen 96
	sndnote $22
	sndlen 36
	sndnote $20
	sndnote $1F
	sndlen 24
	sndnote $1D
	sndlen 36
	sndnote $24
	sndlen 60
	sndnote $11
	sndlen 96
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 12
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 12
	sndnote $1B
	sndlen 6
	sndnote $1D
	sndlen 54
	sndnote $00
	sndlen 96
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 34
	sndnote $00
	sndlen 26
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 36
	sndlen 12
	sndnote $1F
	sndnote $20
	sndlen 72
	sndnote $1F
	sndlen 18
	sndnote $20
	sndlen 6
	sndnote $22
	sndlen 36
	sndnote $20
	sndlen 24
	sndnote $1F
	sndnote $1D
	sndlen 12
	sndnote $1F
	sndlen 36
	sndnote $20
	sndlen 60
	sndnote $00
	sndnote $22
	sndlen 24
	sndnote $25
	sndnote $24
	sndlen 84
	sndnote $00
	sndlen 96
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $22
	sndlen 12
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 36
	sndlen 12
	sndnote $1F
	sndnote $20
	sndlen 72
	sndnote $1F
	sndlen 18
	sndnote $20
	sndlen 6
	sndnote $22
	sndlen 72
	sndnote $20
	sndlen 24
	sndnote $23
	sndlen 6
	sndnote $00
	sndnote $23
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $22
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $00
	sndnote $22
	sndnote $00
	sndnote $18
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $18
	sndlen 96
	sndlenpre $18
	sndnote $1B
	sndnote $1B
	sndnote $1B
	sndnote $1B
	sndnote $1B
	sndnote $1B
	sndloop .main
SndData_BGM_Boss_Ch2:
	sndenv 10, SNDENV_DEC, 3
	sndenach SNDOUT_CH2L
	sndnr21 1, 0
	sndnote $16
	sndlen 12
	sndnote $17
	sndlen 3
	sndnote $18
	sndnote $19
	sndnote $1A
	sndnote $1B
	sndnote $1C
	sndnote $1D
	sndnote $1E
	sndnote $1F
	sndnote $20
	sndnote $21
	sndnote $22
	sndnote $23
	sndnote $24
	sndnote $25
	sndnote $26
	sndnote $27
	sndnote $29
	sndnote $2B
	sndnote $26
	sndlen 6
	sndnote $00
	sndlen 18
.main:
	sndenv 10, SNDENV_DEC, 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 2
	sndenv 2, SNDENV_INC, 2
	sndnote $1F
	sndlen 6
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $2B
	sndlen 4
	sndnote $2B
	sndnote $2B
	sndnote $37
	sndlen 6
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndlen 4
	sndloopcnt $01, 3, .main
	sndenv 10, SNDENV_DEC, 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndenv 2, SNDENV_INC, 2
	sndnote $00
	sndlen 2
	sndnote $1F
	sndlen 6
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndnote $1F
	sndnote $2B
	sndnote $1F
	sndnote $13
	sndnote $1F
	sndnote $2B
	sndnote $37
	sndlen 4
	sndenv 10, SNDENV_DEC, 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $26
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 72
.loop1:
	sndenv 10, SNDENV_DEC, 7
	sndnote $18
	sndlen 6
	sndnote $00
	sndnote $0C
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 6
	sndnote $00
	sndnote $0C
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 6
	sndnote $00
	sndnote $1F
	sndlen 48
	sndenv 8, SNDENV_DEC, 7
	sndnote $20
	sndlen 24
	sndnote $1F
	sndnote $1F
	sndnote $1F
.loop1a:
	sndnote $1C
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1C
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1C
	sndlen 6
	sndnote $00
	sndenv 7, SNDENV_DEC, 2
	sndnote $1D
	sndnote $29
	sndnote $11
	sndnote $35
	sndnote $29
	sndnote $1D
	sndnote $1D
	sndnote $29
	sndloopcnt $02, 2, .loop1a
	sndenv 8, SNDENV_DEC, 7
	sndnote $0F
	sndlen 6
	sndnote $11
	sndlen 12
	sndnote $0F
	sndlen 6
	sndnote $11
	sndlen 12
	sndnote $0F
	sndlen 6
	sndnote $11
	sndlen 54
	sndnote $24
	sndlen 36
	sndnote $23
	sndlen 60
	sndnote $16
	sndlen 6
	sndnote $18
	sndlen 12
	sndnote $16
	sndlen 6
	sndnote $18
	sndlen 12
	sndnote $16
	sndlen 6
	sndnote $18
	sndlen 54
	sndnote $00
	sndlen 96
	sndloopcnt $01, 2, .loop1
.loop2:
	sndnote $1D
	sndlen 12
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 12
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 36
	sndenv 7, SNDENV_DEC, 2
	sndnote $22
	sndlen 6
	sndnote $16
	sndnote $2E
	sndnote $22
	sndenv 8, SNDENV_DEC, 7
	sndloopcnt $01, 2, .loop2
	sndnote $1B
	sndlen 12
	sndnote $0F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 12
	sndnote $0F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 6
	sndnote $00
	sndlen 30
	sndenv 7, SNDENV_DEC, 2
	sndnote $20
	sndlen 6
	sndnote $14
	sndnote $2C
	sndnote $20
	sndenv 8, SNDENV_DEC, 7
	sndnote $1F
	sndlen 12
	sndnote $13
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $16
	sndlen 12
	sndnote $13
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 6
	sndnote $00
	sndlen 30
	sndenv 7, SNDENV_DEC, 2
	sndnote $20
	sndlen 6
	sndnote $14
	sndnote $2C
	sndnote $20
	sndenv 8, SNDENV_DEC, 7
.loop3:
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 48
	sndloopcnt $01, 2, .loop3
.loop4:
	sndnote $18
	sndlen 6
	sndnote $00
	sndnote $0C
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 6
	sndnote $00
	sndnote $0C
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 6
	sndnote $00
	sndenv 7, SNDENV_DEC, 2
	sndnote $1D
	sndnote $11
	sndnote $29
	sndnote $1D
	sndnote $29
	sndnote $11
	sndnote $1D
	sndnote $29
	sndenv 8, SNDENV_DEC, 7
	sndloopcnt $01, 2, .loop4
	sndnote $1D
	sndlen 12
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1D
	sndlen 12
	sndnote $11
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $18
	sndlen 36
	sndnote $22
	sndlen 6
	sndnote $16
	sndnote $2E
	sndnote $22
.loop5:
	sndenv 7, SNDENV_DEC, 2
	sndnote $22
	sndlen 6
	sndnote $16
	sndnote $22
	sndnote $2E
	sndnote $3A
	sndnote $22
	sndnote $2E
	sndnote $16
	sndnote $22
	sndnote $16
	sndnote $22
	sndnote $2E
	sndnote $3A
	sndnote $22
	sndnote $2E
	sndnote $3A
	sndloopcnt $01, 2, .loop5
	sndenv 8, SNDENV_DEC, 7
	sndnote $1E
	sndlen 6
	sndnote $00
	sndnote $1E
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $1B
	sndlen 6
	sndnote $00
	sndnote $1D
	sndnote $00
	sndnote $13
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $13
	sndlen 96
	sndlenpre $18
	sndnote $16
	sndnote $16
	sndnote $16
	sndnote $16
	sndnote $16
	sndnote $16
	sndloop .main
SndData_BGM_Boss_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $02
	sndnote $00
	sndlen 93
.main:
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $0C
	sndnote $00
	sndloopcnt $01, 8, .main
.loop1:
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndloopcnt $02, 4, .loop1
	sndnote $0A
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0C
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0A
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0C
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0A
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0C
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
.loop1a:
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndloopcnt $02, 2, .loop1a
	sndloopcnt $01, 2, .loop1
.loop2:
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 6
	sndnote $00
	sndnote $16
	sndnote $00
	sndloopcnt $01, 4, .loop2
.loop3:
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndloopcnt $01, 4, .loop3
.loop4:
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 10
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 6
	sndnote $00
	sndnote $16
	sndnote $00
	sndloopcnt $01, 3, .loop4
	sndnote $17
	sndlen 6
	sndnote $00
	sndnote $17
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $16
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 12
	sndnote $14
	sndlen 6
	sndnote $00
	sndnote $16
	sndnote $00
	sndnote $0C
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $0C
	sndlen 96
	sndlenpre $18
	sndnote $0F
	sndnote $0F
	sndnote $0F
	sndnote $0F
	sndnote $0F
	sndnote $0F
	sndloop .main
SndData_BGM_Boss_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $30
	sndch4 8, 0, 0
	sndlen 93
.main:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 0
	sndlen 12
	sndch4 0, 0, 6
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 12
	sndloopcnt $01, 7, .main
	sndch4 8, 0, 0
	sndlen 72
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop1:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndloopcnt $01, 7, .loop1
	sndch4 8, 0, 0
	sndlen 72
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 12
.loop2:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndloopcnt $01, 7, .loop2
	sndch4 8, 0, 0
	sndlen 60
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop3:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndloopcnt $01, 11, .loop3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndlen 24
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndloop .main
	sndendch ;X

