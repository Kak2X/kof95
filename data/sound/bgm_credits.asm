SndHeader_BGM_Credits:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch3 ; Data ptr
	db $0C ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Credits_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Credits_Ch1:
	sndenv 8, SNDENV_DEC, 6
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 0, 0
	sndtinc $00A1
.main:
	sndenv 8, SNDENV_DEC, 6
	sndnr11 0, 0
	sndnote $28
	sndlen 2
	sndnote $29
	sndnote $2A
	sndlen 6
	sndnote $00
	sndnote $27
	sndlen 80
	sndenv 7, SNDENV_DEC, 7
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 8
	sndnote $22
	sndlen 2
	sndnote $23
	sndlen 6
	sndnote $00
	sndlen 8
	sndnote $21
	sndlen 2
	sndnote $22
	sndnote $23
	sndlen 12
	sndnote $21
	sndlen 8
	sndnote $00
	sndnote $1F
	sndnote $1E
	sndenv 8, SNDENV_DEC, 7
	sndnote $28
	sndlen 2
	sndnote $29
	sndnote $2A
	sndlen 6
	sndnote $00
	sndnote $27
	sndlen 80
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 8
	sndnote $22
	sndlen 2
	sndnote $23
	sndlen 6
	sndnote $00
	sndlen 8
	sndnote $21
	sndlen 2
	sndnote $22
	sndnote $23
	sndlen 12
	sndnote $21
	sndlen 8
	sndnote $00
	sndnote $1F
	sndnote $1E
	sndenv 8, SNDENV_DEC, 7
	sndnote $20
	sndlen 96
	sndnote $00
	sndlen 80
	sndnr11 3, 0
	sndnote $26
	sndlen 2
	sndnote $27
	sndlen 6
	sndnote $25
	sndlen 8
	sndnote $23
	sndlen 2
	sndnote $24
	sndlen 6
	sndnote $20
	sndlen 8
	sndnote $1B
	sndlen 64
	sndlen 8
	sndnote $1B
	sndnote $1B
	sndlen 2
	sndnote $1C
	sndlen 6
	sndnote $22
	sndlen 8
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 36
	sndnote $14
	sndlen 8
	sndnote $16
	sndnote $18
	sndnote $19
	sndnote $1B
	sndnote $16
	sndnote $14
	sndnote $1F
	sndlen 2
	sndnote $20
	sndlen 62
	sndnr11 0, 0
	sndnote $23
	sndlen 2
	sndnote $24
	sndlen 6
	sndnote $23
	sndlen 2
	sndnote $24
	sndlen 6
	sndnote $25
	sndlen 2
	sndnote $26
	sndnote $27
	sndlen 12
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $27
	sndlen 40
	sndnr11 3, 0
	sndnote $26
	sndlen 2
	sndnote $27
	sndlen 6
	sndnote $25
	sndlen 8
	sndnote $23
	sndlen 2
	sndnote $24
	sndlen 6
	sndnote $20
	sndlen 8
	sndnote $1B
	sndlen 64
	sndlen 8
	sndnote $1B
	sndnote $1B
	sndlen 2
	sndnote $1C
	sndlen 6
	sndnote $22
	sndlen 8
	sndnote $20
	sndlen 2
	sndnote $21
	sndnote $22
	sndlen 36
	sndnote $14
	sndlen 8
	sndnote $16
	sndnote $18
	sndnote $19
	sndnote $1B
	sndnote $16
	sndnote $14
	sndnote $1F
	sndlen 2
	sndnote $20
	sndlen 78
	sndnr11 0, 0
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 32
	sndnr11 3, 0
	sndnote $23
	sndlen 8
	sndnote $24
	sndnote $25
	sndnote $28
	sndnote $2A
	sndnote $2F
	sndlen 16
	sndlen 40
	sndnote $2D
	sndlen 8
	sndnote $2C
	sndnote $2A
	sndnote $25
	sndnote $26
	sndnote $27
	sndnote $28
	sndnote $2A
	sndnote $27
	sndnote $23
	sndlen 48
	sndlen 8
	sndnote $24
	sndnote $2C
	sndnote $2A
	sndlen 64
	sndnote $28
	sndlen 24
	sndnote $27
	sndlen 96
	sndnote $00
	sndloop .main
SndData_BGM_Credits_Ch2:
	sndenv 8, SNDENV_DEC, 6
	sndenach SNDOUT_CH2L
	sndnr21 0, 0
.main:
	sndenv 8, SNDENV_DEC, 6
	sndnote $21
	sndlen 2
	sndnote $22
	sndnote $23
	sndlen 6
	sndnote $00
	sndnote $23
	sndlen 80
	sndenv 7, SNDENV_DEC, 7
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 8
	sndnote $1B
	sndlen 2
	sndnote $1C
	sndlen 6
	sndnote $00
	sndlen 8
	sndnote $1A
	sndlen 2
	sndnote $1B
	sndnote $1C
	sndlen 12
	sndnote $1A
	sndlen 8
	sndnote $00
	sndnote $1A
	sndnote $1A
	sndenv 8, SNDENV_DEC, 7
	sndnote $21
	sndlen 2
	sndnote $22
	sndnote $23
	sndlen 6
	sndnote $00
	sndnote $23
	sndlen 80
	sndnote $00
	sndlen 24
	sndnote $00
	sndlen 8
	sndnote $1B
	sndlen 2
	sndnote $1C
	sndlen 6
	sndnote $00
	sndlen 8
	sndnote $1A
	sndlen 2
	sndnote $1B
	sndnote $1C
	sndlen 12
	sndnote $1A
	sndlen 8
	sndnote $00
	sndnote $1A
	sndnote $1A
	sndnote $1D
	sndlen 96
	sndnote $00
	sndenv 8, SNDENV_DEC, 6
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 16
	sndnote $1B
	sndlen 8
	sndnote $1F
	sndnote $1E
	sndnote $1D
	sndnote $1B
	sndlen 24
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $1B
	sndnote $1B
	sndnote $1C
	sndnote $22
	sndnote $22
	sndlen 32
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 56
	sndnote $1F
	sndlen 2
	sndnote $20
	sndlen 6
	sndnote $1F
	sndlen 2
	sndnote $20
	sndlen 6
	sndnote $22
	sndlen 16
	sndnote $22
	sndlen 8
	sndnote $00
	sndnote $00
	sndnote $22
	sndlen 40
	sndnote $00
	sndlen 16
	sndnote $24
	sndnote $24
	sndlen 8
	sndnote $00
	sndlen 16
	sndnote $1B
	sndlen 8
	sndnote $1F
	sndnote $1E
	sndnote $1D
	sndnote $1B
	sndlen 24
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $1B
	sndnote $1B
	sndnote $1C
	sndnote $22
	sndnote $22
	sndlen 32
	sndnote $24
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 72
	sndnote $20
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 24
	sndnote $23
	sndnote $20
	sndnote $23
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 72
	sndnote $23
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 72
	sndnote $21
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $21
	sndnote $21
	sndnote $1C
	sndnote $1B
	sndnote $19
	sndnote $25
	sndlen 24
	sndnote $23
	sndlen 16
	sndlen 8
	sndnote $00
	sndlen 72
	sndnote $25
	sndlen 96
	sndloop .main
SndData_BGM_Credits_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $03
.main:
	sndnote $0D
	sndlen 36
	sndnote $00
	sndlen 4
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $13
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $12
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 36
	sndnote $00
	sndlen 12
	sndnote $15
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $17
	sndlen 22
	sndnote $00
	sndlen 2
	sndloopcnt $01, 2, .main
	sndnote $0D
	sndlen 36
	sndnote $00
	sndlen 4
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $15
	sndlen 2
	sndnote $16
	sndnote $17
	sndnote $18
	sndnote $19
	sndlen 16
	sndnote $0D
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $00
	sndlen 48
.loop1:
	sndnote $0D
	sndlen 36
	sndnote $00
	sndlen 4
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 22
	sndnote $00
	sndlen 2
	sndloopcnt $01, 7, .loop1
	sndnote $0D
	sndlen 36
	sndnote $00
	sndlen 4
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $12
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $0D
	sndlen 16
	sndnote $0D
	sndlen 8
	sndnote $00
	sndlen 8
	sndnote $0E
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $17
	sndlen 16
	sndnote $15
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0E
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 16
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $13
	sndlen 16
	sndnote $13
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $11
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $10
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0E
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $0C
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $12
	sndlen 8
	sndnote $00
	sndnote $12
	sndnote $00
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $12
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $0D
	sndlen 22
	sndnote $00
	sndlen 18
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 22
	sndnote $00
	sndlen 2
	sndnote $0D
	sndlen 24
	sndnote $00
	sndlen 72
	sndloop .main
SndData_BGM_Credits_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $30
.main:
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 5, .main
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 24
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 8
.loop1:
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 7, .loop1
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 4
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 2
.loop2:
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 3, .loop2
	sndch4 8, 0, 3
	sndlen 8
	sndch4 0, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 4
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndlen 8
	sndch4 8, 0, 0
	sndlen 16
	sndloop .main

