SndHeader_BGM_CharSelect:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_CharSelect_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_CharSelect_Ch1:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 2, 0
	sndtinc $00F6
.main:
	sndnote $25
	sndlen 96
	sndnote $1E
	sndlen 12
	sndenv 3, SNDENV_DEC, 0
	sndnote $1E
	sndlen 6
	sndenv 10, SNDENV_DEC, 7
	sndnote $1E
	sndlen 12
	sndenv 3, SNDENV_DEC, 0
	sndnote $1E
	sndlen 6
	sndenv 10, SNDENV_DEC, 7
	sndnote $1E
	sndlen 6
	sndenv 4, SNDENV_DEC, 0
	sndnote $1E
	sndenv 10, SNDENV_DEC, 7
	sndnote $1C
	sndlen 48
	sndloop .main
SndData_BGM_CharSelect_Ch2:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH2L
	sndnr21 2, 0
.main:
	sndnote $19
	sndlen 48
	sndnote $20
	sndnote $19
	sndlen 38
	sndnote $00
	sndlen 10
	sndnote $14
	sndlen 24
	sndnote $23
	sndloop .main
SndData_BGM_CharSelect_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $03
.main:
	sndnote $0D
	sndlen 6
	sndnote $0D
	sndnote $0B
	sndnote $0D
	sndnote $00
	sndlen 12
	sndnote $14
	sndlen 6
	sndnote $00
	sndlen 18
	sndnote $12
	sndlen 4
	sndnote $17
	sndnote $19
	sndnote $1E
	sndlen 6
	sndnote $00
	sndnote $19
	sndlen 4
	sndnote $17
	sndnote $14
	sndnote $12
	sndlen 6
	sndnote $00
	sndnote $12
	sndnote $12
	sndnote $00
	sndnote $12
	sndnote $12
	sndnote $00
	sndnote $17
	sndnote $00
	sndnote $17
	sndnote $17
	sndnote $00
	sndnote $17
	sndnote $17
	sndnote $00
	sndloop .main
SndData_BGM_CharSelect_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndenv 11, SNDENV_DEC, 1
.main:
	sndch4 8, 0, 1
	sndlen 24
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 3
	sndlen 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 0
	sndlen 18
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndlen 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 0
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndloop .main

