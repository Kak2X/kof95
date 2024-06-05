SndHeader_BGM_Intro:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Intro_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Intro_Ch1:
	sndenv 8, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 1, 0
	sndtinc $00C9
.loop0:
	sndenv 7, SNDENV_DEC, 5
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 6
	sndnote $00
	sndlen 6
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $2B
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $2C
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $1B
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1B
	sndlen 2
	sndnote $00
	sndlen 4
	sndloopcnt $00, 4, .loop0
	sndenv 9, SNDENV_DEC, 7
	sndnr11 2, 0
	sndnote $00
	sndlen 24
	sndnote $1F
	sndlen 12
	sndnote $20
	sndlen 48
	sndnote $1B
	sndlen 12
	sndenv 11, SNDENV_DEC, 7
	sndnote $1D
	sndlen 96
	sndlenpre $24
	sndnote $29
	sndlen 6
	sndnote $00
	sndnote $29
	sndlen 12
	sndnote $27
	sndlen 6
	sndnote $24
	sndnote $27
	sndnote $24
	sndnote $22
	sndlen 12
	sndnote $1D
	sndlen 96
	sndlenpre $24
	sndnote $29
	sndlen 6
	sndnote $00
	sndnote $29
	sndlen 12
	sndnote $27
	sndlen 6
	sndnote $24
	sndnote $27
	sndnote $24
	sndnote $1D
	sndlen 12
	sndnote $2A
	sndnote $29
	sndlen 6
	sndnote $27
	sndnote $29
	sndnote $25
	sndnote $27
	sndlen 12
	sndnote $2C
	sndnote $2A
	sndlen 6
	sndnote $29
	sndnote $2A
	sndnote $27
	sndnote $29
	sndlen 12
	sndnote $22
	sndlen 48
	sndendch
SndData_BGM_Intro_Ch2:
	sndenv 8, SNDENV_DEC, 7
	sndenach SNDOUT_CH2L
	sndnr21 3, 0
.loop0:
	sndenv 7, SNDENV_DEC, 2
	sndnr21 1, 0
	sndnote $2B
	sndlen 6
	sndnote $27
	sndnote $24
	sndnote $1D
	sndnote $1F
	sndnote $18
	sndnote $1B
	sndnote $1D
	sndnote $24
	sndnote $1F
	sndnote $27
	sndnote $29
	sndnote $2B
	sndnote $24
	sndnote $18
	sndlen 4
	sndnote $18
	sndnote $18
	sndnote $1F
	sndlen 6
	sndnote $18
	sndnote $13
	sndnote $18
	sndnote $1F
	sndnote $18
	sndnote $1F
	sndnote $24
	sndnote $1D
	sndnote $24
	sndnote $1F
	sndnote $29
	sndnote $2B
	sndnote $29
	sndnote $30
	sndnote $24
	sndloopcnt $00, 4, .loop0
	sndenv 11, SNDENV_DEC, 7
	sndnr21 3, 0
	sndnote $00
	sndlen 24
	sndnote $1A
	sndlen 12
	sndnote $1B
	sndlen 48
	sndnote $16
	sndlen 12
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $1F
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $24
	sndlen 6
	sndnote $00
	sndnote $24
	sndlen 12
	sndnote $22
	sndlen 6
	sndnote $1F
	sndnote $22
	sndnote $1F
	sndnote $1D
	sndlen 12
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $20
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $1F
	sndlen 12
	sndnote $24
	sndlen 6
	sndnote $00
	sndnote $24
	sndlen 12
	sndnote $22
	sndlen 6
	sndnote $1F
	sndnote $22
	sndnote $1F
	sndnote $18
	sndlen 12
	sndnote $25
	sndnote $24
	sndlen 6
	sndnote $22
	sndnote $24
	sndnote $20
	sndnote $22
	sndlen 12
	sndnote $27
	sndnote $25
	sndlen 6
	sndnote $24
	sndnote $25
	sndnote $22
	sndnote $24
	sndlen 12
	sndnote $1D
	sndlen 48
	sndendch
SndData_BGM_Intro_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $03
	sndnotebase $0C
	sndnote $11
	sndlen 96
	sndlenpre $54
	sndnote $0C
	sndlen 12
	sndnote $11
	sndlen 96
	sndlenpre $54
	sndnote $0C
	sndlen 12
	sndnote $11
	sndlen 96
	sndlenpre $54
	sndnote $0C
	sndlen 12
	sndnote $11
	sndlen 96
	sndlenpre $60
	sndwave $04
	sndnotebase $F4
	sndnote $00
	sndlen 24
	sndnote $13
	sndlen 12
	sndnote $14
	sndlen 48
	sndnote $0F
	sndlen 12
.loop0:
	sndnote $11
	sndlen 12
	sndnote $0C
	sndnote $0F
	sndnote $11
	sndnote $11
	sndnote $0C
	sndnote $0F
	sndnote $0C
	sndloopcnt $00, 4, .loop0
	sndnote $12
	sndlen 12
	sndnote $11
	sndnote $0D
	sndnote $0F
	sndnote $14
	sndnote $12
	sndnote $0F
	sndnote $11
	sndnote $0A
	sndlen 48
	sndendch
SndData_BGM_Intro_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndenv 11, SNDENV_DEC, 1
.loop0:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndloopcnt $00, 8, .loop0
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 0
	sndlen 18
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop1:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $00, 3, .loop1
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 24
	sndendch

