SndHeader_BGM_Cutscene0:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene0_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Cutscene0_Ch1:
	sndenv 11, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 2, 0
	sndtinc $00BA
.main:
	sndenv 9, SNDENV_DEC, 7
	sndnote $1E
	sndlen 48
	sndnote $25
	sndlen 36
	sndnote $24
	sndlen 96
	sndnote $23
	sndnote $1D
	sndnote $00
	sndlen 12
	sndnote $1E
	sndlen 48
	sndnote $25
	sndlen 36
	sndnote $24
	sndlen 96
	sndnote $23
	sndnote $29
	sndnote $00
	sndlen 12
	sndnote $0D
	sndnote $0D
	sndlen 6
	sndnote $00
	sndnote $00
	sndnote $17
	sndnote $15
	sndlen 12
	sndnote $00
	sndlen 42
	sndenv 9, SNDENV_DEC, 1
	sndnote $27
	sndlen 6
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndenv 9, SNDENV_DEC, 7
	sndnote $0D
	sndlen 12
	sndnote $0D
	sndlen 6
	sndnote $00
	sndnote $00
	sndnote $17
	sndnote $15
	sndlen 12
	sndnote $00
	sndlen 48
	sndnote $00
	sndlen 96
	sndnote $0D
	sndlen 12
	sndnote $0D
	sndlen 6
	sndnote $00
	sndnote $00
	sndnote $17
	sndnote $15
	sndlen 12
	sndnote $00
	sndlen 42
	sndenv 9, SNDENV_DEC, 1
	sndnote $27
	sndlen 6
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndnote $28
	sndnote $27
	sndnote $28
	sndenv 9, SNDENV_DEC, 7
	sndnote $0D
	sndlen 12
	sndnote $0D
	sndlen 6
	sndnote $00
	sndnote $00
	sndnote $17
	sndnote $15
	sndlen 12
	sndnote $00
	sndlen 48
	sndnote $00
	sndlen 54
	sndnote $12
	sndlen 6
	sndnote $15
	sndnote $12
	sndnote $15
	sndnote $17
	sndnote $19
	sndnote $1E
	sndnote $1E
	sndlen 24
	sndnote $23
	sndlen 96
	sndlenpre $0C
	sndnote $21
	sndnote $20
	sndlen 24
	sndnote $1F
	sndnote $1E
	sndnote $27
	sndlen 96
	sndlenpre $18
	sndnote $26
	sndnote $25
	sndnote $1E
	sndnote $23
	sndlen 96
	sndlenpre $0C
	sndnote $21
	sndnote $20
	sndlen 24
	sndnote $1F
	sndnote $1E
	sndnote $27
	sndlen 96
	sndlenpre $0C
	sndnote $25
	sndnote $2D
	sndlen 24
	sndnote $25
	sndlen 96
	sndlenpre $60
	sndloop .main
SndData_BGM_Cutscene0_Ch2:
	sndenv 11, SNDENV_DEC, 7
	sndenach SNDOUT_CH2L
	sndnr21 1, 0
.main:
	sndenv 9, SNDENV_DEC, 7
	sndnote $00
	sndlen 1
	sndnote $0D
	sndlen 48
	sndnote $19
	sndlen 36
	sndnote $18
	sndlen 96
	sndnote $17
	sndnote $11
	sndnote $00
	sndlen 12
	sndnote $0D
	sndlen 48
	sndnote $19
	sndlen 36
	sndnote $18
	sndlen 96
	sndnote $17
	sndnote $1D
	sndnote $00
	sndlen 11
.loop1:
	sndnote $00
	sndlen 90
	sndenv 9, SNDENV_DEC, 1
	sndnote $24
	sndlen 6
	sndnote $25
	sndnote $25
	sndnote $24
	sndnote $25
	sndnote $25
	sndnote $24
	sndnote $25
	sndnote $25
	sndnote $24
	sndnote $25
	sndnote $25
	sndnote $24
	sndnote $25
	sndnote $25
	sndnote $24
	sndnote $25
	sndnote $00
	sndlen 96
	sndnote $00
	sndloopcnt $01, 2, .loop1
	sndenv 9, SNDENV_DEC, 7
	sndnote $0D
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $00
	sndlen 12
	sndnote $16
	sndnote $16
	sndlen 36
	sndnote $12
	sndlen 12
	sndnote $10
	sndlen 36
	sndlen 12
	sndnote $0F
	sndlen 24
	sndnote $0E
	sndnote $0D
	sndnote $00
	sndlen 12
	sndnote $15
	sndnote $16
	sndlen 36
	sndnote $12
	sndlen 12
	sndnote $10
	sndlen 36
	sndlen 12
	sndnote $0F
	sndlen 24
	sndnote $0E
	sndnote $0D
	sndnote $00
	sndlen 12
	sndnote $15
	sndnote $16
	sndlen 36
	sndnote $12
	sndlen 12
	sndnote $10
	sndlen 36
	sndlen 12
	sndnote $0F
	sndlen 24
	sndnote $0E
	sndnote $0D
	sndnote $00
	sndlen 12
	sndnote $15
	sndnote $16
	sndlen 36
	sndnote $12
	sndlen 12
	sndnote $10
	sndlen 36
	sndnote $12
	sndlen 12
	sndnote $13
	sndlen 24
	sndnote $14
	sndlen 96
	sndlenpre $60
	sndloop .main
	sndendch ;X
SndData_BGM_Cutscene0_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $03
.main:
	sndwave $03
	sndnote $12
	sndlen 48
	sndlen 12
	sndnote $14
	sndnote $15
	sndnote $12
	sndlen 60
	sndnote $18
	sndlen 12
	sndnote $19
	sndnote $1B
	sndnote $12
	sndlen 60
	sndnote $17
	sndlen 12
	sndnote $19
	sndnote $1A
	sndnote $19
	sndlen 24
	sndnote $1A
	sndlen 12
	sndnote $17
	sndnote $19
	sndnote $15
	sndnote $00
	sndnote $00
	sndlen 6
	sndnote $11
	sndnote $00
	sndlen 12
	sndloopcnt $01, 2, .main
	sndwave $06
	sndnote $12
	sndlen 12
	sndnote $12
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 72
	sndnote $00
	sndlen 54
	sndnote $12
	sndlen 6
	sndnote $19
	sndnote $17
	sndnote $12
	sndnote $17
	sndnote $19
	sndnote $1C
	sndnote $12
	sndlen 12
	sndnote $12
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 72
	sndnote $10
	sndlen 54
	sndnote $12
	sndlen 6
	sndnote $15
	sndnote $12
	sndnote $15
	sndnote $17
	sndnote $18
	sndnote $19
	sndnote $12
	sndlen 12
	sndnote $12
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 72
	sndnote $00
	sndlen 54
	sndnote $12
	sndlen 6
	sndnote $19
	sndnote $17
	sndnote $12
	sndnote $17
	sndnote $19
	sndnote $1C
	sndnote $12
	sndlen 12
	sndnote $12
	sndlen 6
	sndnote $00
	sndnote $00
	sndlen 72
	sndnote $00
	sndlen 96
	sndnote $12
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $00
	sndlen 12
	sndnote $1A
	sndnote $1B
	sndlen 36
	sndnote $17
	sndlen 12
	sndnote $15
	sndlen 36
	sndlen 12
	sndnote $14
	sndlen 24
	sndnote $13
	sndnote $12
	sndnote $00
	sndlen 12
	sndnote $1A
	sndnote $1B
	sndlen 36
	sndnote $17
	sndlen 12
	sndnote $15
	sndlen 36
	sndlen 12
	sndnote $14
	sndlen 24
	sndnote $13
	sndnote $12
	sndnote $00
	sndlen 12
	sndnote $1A
	sndnote $1B
	sndlen 36
	sndnote $17
	sndlen 12
	sndnote $15
	sndlen 36
	sndlen 12
	sndnote $14
	sndlen 24
	sndnote $13
	sndnote $12
	sndnote $00
	sndlen 12
	sndnote $1A
	sndnote $1B
	sndlen 36
	sndnote $17
	sndlen 12
	sndnote $15
	sndlen 36
	sndnote $0B
	sndlen 12
	sndnote $0C
	sndlen 24
	sndnote $0D
	sndlen 96
	sndnote $00
	sndlen 96
	sndloop .main
	sndendch ;X
SndData_BGM_Cutscene0_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndenv 10, SNDENV_DEC, 1
.main:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndlen 12
	sndloopcnt $01, 2, .main
.loop1:
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 0
	sndloopcnt $01, 3, .loop1
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 4
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop2:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 4, .loop2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndloop .main
	sndendch ;X

