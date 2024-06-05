SndHeader_BGM_Stage:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Stage_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Stage_Ch1:
	sndenv 11, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 3, 0
	sndtinc $00E2
.main:
	sndnote $1B
	sndlen 6
	sndnote $1C
	sndnote $1D
	sndnote $24
	sndnote $23
	sndnote $22
	sndnote $29
.loop1:
	sndnote $27
	sndlen 72
	sndnote $22
	sndlen 2
	sndnote $23
	sndnote $24
	sndlen 14
	sndnote $23
	sndlen 6
	sndlenpre $42
	sndnote $00
	sndlen 6
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 20
	sndnote $23
	sndlen 6
	sndnote $22
	sndnote $00
	sndnote $1B
	sndnote $00
	sndnote $1B
	sndnote $00
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 14
	sndnote $20
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 54
	sndnote $1B
	sndlen 6
	sndnote $1C
	sndnote $1D
	sndnote $24
	sndnote $23
	sndnote $22
	sndnote $29
	sndnote $27
	sndlen 72
	sndnote $22
	sndlen 2
	sndnote $23
	sndnote $24
	sndlen 14
	sndnote $23
	sndlen 6
	sndlenpre $42
	sndnote $00
	sndlen 6
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 20
	sndnote $23
	sndlen 6
	sndnote $22
	sndnote $00
	sndnote $1B
	sndnote $00
	sndnote $1B
	sndnote $00
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 14
	sndnote $20
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 96
	sndnote $00
	sndlen 24
	sndnote $1D
	sndlen 6
	sndnote $1B
	sndnote $1C
	sndnote $1D
	sndnote $00
	sndlen 12
	sndnote $29
	sndlen 6
	sndnote $27
	sndnote $28
	sndnote $29
	sndnote $00
	sndnote $28
	sndlen 2
	sndnote $29
	sndlen 4
	sndlenpre $06
	sndnote $29
	sndnote $28
	sndnote $27
	sndnote $24
	sndnote $23
	sndnote $22
	sndnote $22
	sndlen 2
	sndnote $23
	sndnote $24
	sndlen 8
	sndlen 6
	sndnote $23
	sndnote $22
	sndnote $23
	sndnote $22
	sndnote $1B
	sndlen 12
	sndnote $1D
	sndlen 6
	sndnote $1C
	sndnote $1B
	sndnote $18
	sndnote $1B
	sndnote $1D
	sndnote $00
	sndnote $1D
	sndlen 12
	sndnote $1C
	sndlen 6
	sndnote $1B
	sndnote $18
	sndnote $1B
	sndnote $1D
	sndnote $00
	sndnote $29
	sndlenpre $06
	sndnote $29
	sndnote $27
	sndnote $24
	sndnote $27
	sndnote $24
	sndnote $22
	sndnote $20
	sndlen 4
	sndnote $22
	sndnote $23
	sndnote $24
	sndlen 6
	sndnote $25
	sndnote $27
	sndnote $28
	sndnote $29
	sndnote $00
	sndnote $00
	sndnote $00
	sndlen 24
	sndnote $1D
	sndlen 6
	sndnote $1B
	sndnote $1C
	sndnote $1D
	sndnote $00
	sndlen 12
	sndnote $29
	sndlen 6
	sndnote $27
	sndnote $28
	sndnote $29
	sndnote $00
	sndnote $28
	sndlen 2
	sndnote $29
	sndlen 4
	sndlenpre $06
	sndnote $29
	sndnote $28
	sndnote $27
	sndnote $24
	sndnote $23
	sndnote $22
	sndnote $22
	sndlen 2
	sndnote $23
	sndnote $24
	sndlen 8
	sndlen 6
	sndnote $23
	sndnote $22
	sndnote $23
	sndnote $22
	sndnote $1B
	sndlen 12
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $1D
	sndnote $00
	sndnote $24
	sndnote $23
	sndlen 12
	sndnote $22
	sndlen 6
	sndnote $23
	sndnote $22
	sndnote $20
	sndlen 12
	sndnote $1B
	sndlen 4
	sndnote $1F
	sndnote $20
	sndnote $22
	sndlen 6
	sndnote $23
	sndnote $20
	sndnote $1D
	sndnote $1B
	sndnote $23
	sndnote $22
	sndnote $20
	sndnote $24
	sndnote $23
	sndnote $1B
	sndnote $1D
	sndnote $1F
	sndnote $20
	sndnote $22
	sndnote $23
	sndnote $24
	sndnote $26
	sndloopcnt $01, 2, .loop1
	sndnote $27
	sndlen 72
	sndnote $24
	sndlen 24
	sndnote $27
	sndlen 36
	sndlen 24
	sndnote $29
	sndlen 36
	sndnote $26
	sndlen 96
	sndnote $00
	sndnote $25
	sndnote $25
	sndlen 36
	sndlen 24
	sndnote $27
	sndlen 36
	sndnote $24
	sndlen 96
	sndnote $27
	sndlen 6
	sndnote $27
	sndnote $00
	sndnote $27
	sndlen 12
	sndnote $29
	sndnote $27
	sndlen 6
	sndnote $00
	sndloop .main
SndData_BGM_Stage_Ch2:
	sndenv 11, SNDENV_DEC, 6
	sndenach SNDOUT_CH2R
	sndnr21 2, 0
.main:
	sndnote $00
	sndlen 42
.loop1:
	sndnote $24
	sndlen 24
	sndnote $23
	sndnote $22
	sndnote $20
	sndnote $20
	sndlen 6
	sndnote $20
	sndnote $1D
	sndnote $20
	sndlen 12
	sndnote $20
	sndnote $1D
	sndlen 6
	sndnote $1B
	sndnote $1B
	sndnote $18
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndnote $22
	sndlen 6
	sndnote $20
	sndnote $1F
	sndnote $00
	sndnote $18
	sndnote $00
	sndnote $18
	sndnote $00
	sndnote $1D
	sndlen 2
	sndnote $1E
	sndnote $1F
	sndlen 14
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $25
	sndlen 2
	sndnote $26
	sndnote $27
	sndlen 20
	sndnote $29
	sndlen 6
	sndnote $27
	sndnote $00
	sndnote $24
	sndnote $00
	sndnote $22
	sndnote $00
	sndnote $20
	sndnote $1B
	sndnote $18
	sndnote $19
	sndnote $1A
	sndnote $21
	sndnote $20
	sndnote $1F
	sndnote $26
	sndnote $24
	sndlen 24
	sndnote $23
	sndnote $22
	sndnote $20
	sndnote $20
	sndlen 6
	sndnote $20
	sndnote $1D
	sndnote $20
	sndlen 12
	sndnote $20
	sndnote $1D
	sndlen 6
	sndnote $1B
	sndnote $1B
	sndnote $18
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndnote $22
	sndlen 6
	sndnote $20
	sndnote $1F
	sndnote $00
	sndnote $18
	sndnote $00
	sndnote $18
	sndnote $00
	sndnote $1D
	sndlen 2
	sndnote $1E
	sndnote $1F
	sndlen 14
	sndnote $1D
	sndlen 6
	sndnote $00
	sndnote $25
	sndlen 2
	sndnote $26
	sndnote $27
	sndlen 20
	sndnote $29
	sndlen 6
	sndnote $27
	sndnote $24
	sndnote $27
	sndnote $25
	sndnote $22
	sndnote $20
	sndnote $24
	sndnote $22
	sndnote $20
	sndnote $22
	sndnote $20
	sndnote $1F
	sndlen 4
	sndnote $1E
	sndnote $1D
	sndnote $1B
	sndlen 6
	sndnote $29
	sndnote $18
	sndlen 12
	sndnote $00
	sndnote $1A
	sndlen 6
	sndnote $18
	sndnote $19
	sndnote $1A
	sndnote $00
	sndlen 12
	sndnote $26
	sndlen 6
	sndnote $24
	sndnote $25
	sndnote $26
	sndnote $00
	sndnote $20
	sndlenpre $18
	sndnote $20
	sndlen 12
	sndnote $1D
	sndlen 6
	sndnote $20
	sndlen 12
	sndnote $20
	sndnote $1D
	sndlen 6
	sndnote $18
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $24
	sndnote $15
	sndnote $15
	sndnote $00
	sndlen 24
	sndnote $15
	sndlen 6
	sndnote $15
	sndnote $00
	sndnote $15
	sndnote $10
	sndlen 12
	sndnote $13
	sndnote $14
	sndlen 6
	sndnote $14
	sndnote $18
	sndnote $18
	sndnote $00
	sndlen 24
	sndnote $18
	sndlen 6
	sndnote $18
	sndnote $00
	sndnote $18
	sndnote $18
	sndlen 12
	sndnote $18
	sndnote $18
	sndlen 6
	sndnote $18
	sndnote $18
	sndlen 12
	sndnote $00
	sndnote $1A
	sndlen 6
	sndnote $18
	sndnote $19
	sndnote $1A
	sndnote $00
	sndlen 12
	sndnote $26
	sndlen 6
	sndnote $24
	sndnote $25
	sndnote $26
	sndnote $00
	sndnote $20
	sndlenpre $18
	sndnote $20
	sndlen 12
	sndnote $1D
	sndlen 6
	sndnote $20
	sndlen 12
	sndnote $20
	sndnote $1D
	sndlen 6
	sndnote $18
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $24
	sndnote $15
	sndnote $15
	sndnote $00
	sndlen 24
	sndnote $15
	sndlen 6
	sndnote $15
	sndnote $00
	sndnote $15
	sndnote $10
	sndlen 12
	sndnote $13
	sndnote $14
	sndlen 6
	sndnote $14
	sndnote $1B
	sndlen 12
	sndnote $1B
	sndnote $1D
	sndlen 6
	sndnote $1B
	sndlen 12
	sndnote $18
	sndnote $17
	sndnote $16
	sndlen 6
	sndnote $17
	sndnote $1B
	sndnote $20
	sndnote $00
	sndloopcnt $01, 2, .loop1
	sndnote $24
	sndlen 24
	sndnote $20
	sndnote $24
	sndnote $1F
	sndnote $22
	sndlen 18
	sndnote $22
	sndnote $22
	sndlen 24
	sndnote $26
	sndlen 12
	sndnote $24
	sndnote $22
	sndnote $20
	sndlen 18
	sndnote $20
	sndnote $1D
	sndlen 12
	sndnote $1F
	sndlen 18
	sndnote $1D
	sndnote $1B
	sndlen 6
	sndnote $18
	sndnote $1D
	sndnote $1D
	sndnote $18
	sndlen 12
	sndnote $20
	sndnote $1F
	sndlen 6
	sndnote $1D
	sndlen 12
	sndnote $1D
	sndnote $1B
	sndlen 6
	sndnote $18
	sndlen 12
	sndnote $16
	sndnote $22
	sndlen 18
	sndnote $20
	sndnote $1D
	sndlen 12
	sndnote $24
	sndnote $22
	sndnote $20
	sndlen 6
	sndnote $1D
	sndnote $19
	sndnote $1D
	sndnote $1F
	sndlen 18
	sndnote $1D
	sndnote $19
	sndlen 12
	sndnote $19
	sndnote $1D
	sndnote $1F
	sndlen 6
	sndnote $1D
	sndnote $19
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $20
	sndnote $18
	sndnote $20
	sndnote $20
	sndnote $18
	sndnote $1B
	sndnote $1D
	sndnote $1F
	sndnote $20
	sndnote $22
	sndnote $23
	sndnote $24
	sndnote $25
	sndnote $27
	sndnote $29
	sndnote $24
	sndnote $24
	sndnote $00
	sndnote $24
	sndlen 12
	sndnote $26
	sndnote $24
	sndlen 6
	sndnote $00
	sndloop .main
SndData_BGM_Stage_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3L
	sndwave $04
	sndnote $00
	sndlen 42
.main:
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $00
	sndlen 24
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $00
	sndnote $11
	sndnote $0C
	sndlen 12
	sndnote $0F
	sndnote $10
	sndlen 6
	sndnote $10
	sndloopcnt $02, 7, .main
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0D
	sndnote $00
	sndnote $0C
	sndnote $00
	sndnote $0B
	sndnote $00
	sndnote $0A
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $00
.loop1:
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $00
	sndlen 24
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $00
	sndnote $11
	sndnote $0C
	sndlen 12
	sndnote $0F
	sndnote $10
	sndlen 6
	sndnote $10
	sndloopcnt $02, 7, .loop1
	sndnote $0F
	sndlen 12
	sndnote $0F
	sndnote $11
	sndlen 6
	sndnote $0F
	sndlen 12
	sndnote $0C
	sndnote $0B
	sndnote $0A
	sndlen 6
	sndnote $0B
	sndnote $0F
	sndnote $14
	sndnote $00
	sndloopcnt $01, 2, .main
	sndnote $14
	sndlen 24
	sndnote $0F
	sndlen 12
	sndnote $0C
	sndlen 6
	sndnote $14
	sndlen 12
	sndnote $14
	sndnote $0F
	sndlen 6
	sndnote $0C
	sndnote $0F
	sndnote $14
	sndlen 12
	sndnote $13
	sndlen 24
	sndnote $0F
	sndlen 12
	sndnote $0A
	sndlen 6
	sndnote $13
	sndlen 12
	sndnote $13
	sndnote $0F
	sndlen 6
	sndnote $0A
	sndnote $0F
	sndnote $13
	sndlen 12
	sndnote $11
	sndnote $11
	sndnote $0F
	sndnote $0C
	sndlen 6
	sndnote $0A
	sndlen 12
	sndnote $0C
	sndnote $0F
	sndlen 6
	sndnote $11
	sndnote $13
	sndnote $14
	sndlen 12
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $0C
	sndlen 12
	sndnote $14
	sndnote $13
	sndlen 6
	sndnote $11
	sndlen 12
	sndnote $11
	sndnote $0F
	sndlen 6
	sndnote $0C
	sndlen 12
	sndnote $0A
	sndnote $0D
	sndlen 6
	sndnote $0D
	sndnote $11
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $11
	sndnote $0D
	sndlen 12
	sndnote $0D
	sndnote $0D
	sndlen 6
	sndnote $0D
	sndnote $11
	sndnote $14
	sndlen 12
	sndnote $0D
	sndlen 6
	sndnote $0D
	sndnote $11
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $11
	sndnote $0D
	sndlen 12
	sndnote $0D
	sndnote $0D
	sndlen 6
	sndnote $0F
	sndnote $11
	sndnote $16
	sndlen 12
	sndnote $18
	sndnote $18
	sndnote $16
	sndlen 6
	sndnote $14
	sndlen 12
	sndnote $13
	sndnote $11
	sndnote $0F
	sndlen 6
	sndnote $0C
	sndnote $0D
	sndnote $0C
	sndlen 12
	sndnote $0F
	sndlen 6
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndlen 12
	sndnote $11
	sndnote $0F
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 42
	sndloop .main
SndData_BGM_Stage_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $30
	sndch4 8, 0, 0
	sndlen 42
.main:
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndloopcnt $02, 2, .main
.loop1:
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndloopcnt $02, 3, .loop1
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 2
	sndlen 4
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
.loop2:
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 4
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $03, 3, .loop2
	sndch4 8, 0, 1
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndloopcnt $02, 2, .loop2
	sndloopcnt $01, 2, .main
.loop3:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 7, .loop3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndloop .main

