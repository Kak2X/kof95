SndHeader_BGM_Ending:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Ending_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Ending_Ch1:
	sndenv 11, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 3, 0
	sndtinc $00CE
.main:
	sndnote $24
	sndlen 44
	sndnote $00
	sndlen 4
	sndnote $27
	sndlen 18
	sndnote $2E
	sndnote $2C
	sndlen 12
	sndnote $2B
	sndlen 24
	sndnote $22
	sndlen 12
	sndnote $27
	sndlen 36
	sndnote $30
	sndlen 12
	sndnote $2E
	sndnote $2E
	sndlen 18
	sndnote $27
	sndlen 54
	sndnote $30
	sndlen 12
	sndnote $2E
	sndnote $2E
	sndlen 18
	sndnote $26
	sndlen 78
	sndnote $24
	sndlen 44
	sndnote $00
	sndlen 4
	sndnote $27
	sndlen 18
	sndnote $2E
	sndnote $2C
	sndlen 12
	sndnote $2B
	sndlen 24
	sndnote $22
	sndlen 12
	sndnote $27
	sndlen 36
	sndnote $30
	sndlen 12
	sndnote $2E
	sndnote $2E
	sndlen 18
	sndnote $27
	sndlen 54
	sndnote $30
	sndlen 12
	sndnote $2E
	sndnote $2E
	sndlen 18
	sndnote $26
	sndlen 54
	sndnote $24
	sndlen 6
	sndnote $26
	sndnote $27
	sndnote $29
	sndnote $2B
	sndnote $00
	sndlen 18
	sndnote $27
	sndlen 6
	sndnote $00
	sndnote $29
	sndnote $00
	sndlen 18
	sndnote $26
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $27
	sndlen 12
	sndlenpre $48
	sndnote $24
	sndlen 6
	sndnote $26
	sndnote $27
	sndnote $29
	sndnote $2B
	sndnote $00
	sndlen 18
	sndnote $27
	sndlen 6
	sndnote $00
	sndnote $29
	sndnote $00
	sndlen 18
	sndnote $26
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $27
	sndlen 12
	sndlenpre $60
	sndloop .main
SndData_BGM_Ending_Ch2:
	sndenv 11, SNDENV_DEC, 3
	sndenach SNDOUT_CH2R
	sndnr21 3, 0
.main:
	sndnote $1F
	sndlen 6
	sndnote $1B
	sndnote $18
	sndnote $1F
	sndnote $1B
	sndnote $18
	sndnote $1F
	sndnote $24
	sndnote $24
	sndnote $1B
	sndnote $1F
	sndnote $18
	sndnote $24
	sndnote $1D
	sndnote $22
	sndnote $1D
	sndnote $1B
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $1A
	sndnote $1B
	sndnote $1F
	sndnote $1F
	sndlen 12
	sndnote $1D
	sndnote $1B
	sndnote $1F
	sndlen 6
	sndnote $20
	sndnote $24
	sndnote $1F
.loop1:
	sndnote $24
	sndlen 6
	sndnote $22
	sndnote $1B
	sndnote $24
	sndnote $22
	sndnote $1B
	sndnote $24
	sndnote $22
	sndloopcnt $02, 2, .loop1
	sndnote $22
	sndlen 6
	sndnote $20
	sndnote $1A
	sndnote $22
	sndnote $20
	sndnote $1A
	sndnote $22
	sndnote $20
	sndnote $22
	sndnote $1F
	sndnote $1A
	sndnote $22
	sndnote $1F
	sndnote $1A
	sndnote $22
	sndnote $1F
	sndloopcnt $01, 2, .main
	sndnote $26
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $22
	sndlen 6
	sndnote $00
	sndnote $24
	sndnote $00
	sndlen 18
	sndnote $21
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $22
	sndlen 12
	sndlenpre $48
	sndnote $1F
	sndlen 6
	sndnote $21
	sndnote $22
	sndnote $24
	sndnote $26
	sndnote $00
	sndlen 18
	sndnote $22
	sndlen 6
	sndnote $00
	sndnote $24
	sndnote $00
	sndlen 18
	sndnote $21
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $22
	sndlen 12
	sndlenpre $60
	sndloop .main
SndData_BGM_Ending_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3L
	sndwave $04
.main:
	sndnote $18
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $18
	sndnote $00
	sndlen 12
	sndnote $18
	sndnote $00
	sndnote $18
	sndnote $00
	sndlen 6
	sndlen 12
	sndnote $17
	sndlen 6
	sndnote $16
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $16
	sndnote $00
	sndlen 12
	sndnote $16
	sndnote $00
	sndnote $16
	sndlen 6
	sndnote $00
	sndnote $0E
	sndnote $0F
	sndnote $13
	sndnote $0E
	sndnote $0C
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $0F
	sndnote $00
	sndlen 12
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndlen 6
	sndlen 12
	sndlen 6
	sndnote $16
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $0E
	sndnote $00
	sndlen 12
	sndnote $0E
	sndnote $00
	sndnote $0E
	sndnote $00
	sndlen 6
	sndnote $0F
	sndlen 12
	sndnote $0E
	sndlen 6
	sndnote $0C
	sndlen 12
	sndnote $0A
	sndnote $0C
	sndlen 24
	sndlen 12
	sndnote $0C
	sndnote $00
	sndlen 6
	sndlen 12
	sndnote $0B
	sndlen 6
	sndnote $16
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $16
	sndnote $00
	sndlen 12
	sndnote $16
	sndnote $00
	sndnote $16
	sndlen 6
	sndnote $00
	sndnote $0E
	sndnote $0F
	sndnote $13
	sndnote $0E
	sndnote $0C
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $0F
	sndnote $00
	sndlen 12
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndlen 6
	sndlen 12
	sndlen 6
	sndnote $16
	sndlen 12
	sndnote $00
	sndlen 6
	sndnote $0E
	sndnote $00
	sndlen 12
	sndnote $0E
	sndnote $00
	sndnote $0E
	sndnote $00
	sndlen 6
	sndnote $0F
	sndlen 12
	sndnote $0E
	sndlen 6
	sndnote $13
	sndnote $00
	sndlen 18
	sndnote $0F
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndlen 18
	sndnote $00
	sndlen 12
	sndnote $0E
	sndnote $0F
	sndlenpre $0C
	sndnote $18
	sndlen 6
	sndnote $13
	sndnote $0F
	sndnote $16
	sndlen 12
	sndnote $17
	sndnote $18
	sndnote $16
	sndnote $17
	sndnote $18
	sndlen 6
	sndnote $13
	sndnote $00
	sndlen 18
	sndnote $0F
	sndlen 6
	sndnote $00
	sndnote $11
	sndnote $00
	sndlen 18
	sndnote $00
	sndlen 12
	sndnote $0E
	sndnote $0F
	sndlenpre $18
	sndnote $00
	sndlen 12
	sndnote $0C
	sndlen 4
	sndnote $0F
	sndnote $13
	sndnote $18
	sndlen 12
	sndnote $16
	sndlen 6
	sndnote $13
	sndnote $11
	sndnote $0F
	sndnote $0E
	sndnote $0C
	sndloop .main
SndData_BGM_Ending_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $30
.main:
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndloopcnt $02, 3, .main
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndloopcnt $01, 2, .main
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndlen 18
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndlen 12
	sndch4 0, 0, 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 12
	sndch4 0, 0, 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 4
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndloop .main

