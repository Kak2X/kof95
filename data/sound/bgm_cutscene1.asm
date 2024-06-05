SndHeader_BGM_Cutscene1:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Cutscene1_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Cutscene1_Ch1:
	sndenv 11, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 2, 0
	sndtinc $00BF
.main:
	sndnote $20
	sndlen 12
	sndenv 3, SNDENV_DEC, 0
	sndnote $20
	sndlen 12
	sndenv 2, SNDENV_DEC, 0
	sndnote $20
	sndlen 12
	sndenv 11, SNDENV_DEC, 7
	sndnote $27
	sndnote $26
	sndenv 2, SNDENV_DEC, 0
	sndnote $26
	sndenv 11, SNDENV_DEC, 7
	sndnote $20
	sndlen 24
	sndnote $23
	sndlen 36
	sndnote $2C
	sndlen 4
	sndenv 2, SNDENV_DEC, 0
	sndnote $2C
	sndlen 8
	sndenv 11, SNDENV_DEC, 7
	sndnote $2C
	sndlen 4
	sndenv 2, SNDENV_DEC, 0
	sndnote $2C
	sndlen 8
	sndenv 11, SNDENV_DEC, 7
	sndnote $2E
	sndlen 4
	sndenv 2, SNDENV_DEC, 0
	sndnote $2E
	sndlen 8
	sndenv 11, SNDENV_DEC, 7
	sndnote $2F
	sndlen 4
	sndenv 2, SNDENV_DEC, 0
	sndnote $2F
	sndlen 8
	sndenv 11, SNDENV_DEC, 7
	sndnote $2E
	sndlen 4
	sndenv 2, SNDENV_DEC, 0
	sndnote $2E
	sndlen 8
	sndenv 11, SNDENV_DEC, 7
	sndnote $00
	sndlen 36
	sndnote $27
	sndlen 12
	sndnote $26
	sndlen 24
	sndnote $20
	sndnote $23
	sndlen 72
	sndnote $22
	sndlen 6
	sndnote $00
	sndlen 18
	sndloop .main
SndData_BGM_Cutscene1_Ch2:
	sndenv 11, SNDENV_DEC, 5
	sndenach SNDOUT_CH2L
	sndnr21 1, 0
.main:
	sndnote $17
	sndlen 48
	sndnote $14
	sndnote $13
	sndlen 36
	sndnote $29
	sndlen 4
	sndnote $00
	sndlen 8
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $2C
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $2B
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $0F
	sndlen 6
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $0F
	sndnote $00
	sndnote $12
	sndlen 48
	sndnote $13
	sndlen 24
	sndnote $11
	sndlen 6
	sndnote $00
	sndlen 18
	sndloop .main
SndData_BGM_Cutscene1_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $07
	sndnote $14
	sndlen 12
	sndnote $00
	sndnote $00
	sndnote $0F
	sndnote $0E
	sndlen 24
	sndnote $14
	sndnote $17
	sndlen 36
	sndnote $14
	sndlen 6
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $0A
	sndnote $00
	sndlen 18
.main:
	sndnote $14
	sndlen 6
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndnote $14
	sndnote $00
	sndloop .main
SndData_BGM_Cutscene1_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndenv 9, SNDENV_DEC, 1
.main:
	sndch4 8, 0, 2
	sndlen 18
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndloop .main

