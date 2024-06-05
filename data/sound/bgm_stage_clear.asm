SndHeader_BGM_StageClear:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_StageClear_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_StageClear_Ch1:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 2, 0
	sndtinc $00E7
	sndnote $00
	sndlen 12
	sndnote $2E
	sndlen 6
	sndnote $00
	sndlen 12
	sndnote $22
	sndlen 18
	sndnote $25
	sndlen 6
	sndnote $00
	sndnote $2E
	sndnote $00
	sndlen 12
	sndnote $25
	sndlen 18
	sndnote $27
	sndnote $28
	sndlen 96
	sndlen 6
	sndnote $27
	sndnote $25
	sndnote $22
	sndnote $27
	sndnote $25
	sndnote $22
	sndnote $27
	sndnote $00
	sndendch
SndData_BGM_StageClear_Ch2:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH2L
	sndnr21 2, 0
	sndnote $00
	sndlen 12
	sndnote $29
	sndlen 6
	sndnote $00
	sndlen 12
	sndnote $1D
	sndlen 18
	sndnote $20
	sndlen 6
	sndnote $00
	sndnote $29
	sndnote $00
	sndlen 12
	sndnote $20
	sndlen 18
	sndnote $22
	sndnote $23
	sndlen 96
	sndlen 6
	sndnote $22
	sndnote $20
	sndnote $1D
	sndnote $22
	sndnote $20
	sndnote $1D
	sndnote $22
	sndnote $00
	sndendch
SndData_BGM_StageClear_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R
	sndwave $07
	sndnote $00
	sndlen 30
	sndnote $0A
	sndlen 18
	sndnote $0D
	sndlen 6
	sndnote $00
	sndnote $16
	sndnote $00
	sndlen 12
	sndnote $0D
	sndlen 18
	sndnote $0F
	sndnote $10
	sndlen 96
	sndlen 6
	sndnote $0F
	sndnote $0D
	sndnote $0A
	sndnote $0F
	sndnote $0D
	sndnote $0A
	sndnote $0F
	sndnote $00
	sndendch
SndData_BGM_StageClear_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $30
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 0
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 0
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 18
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 24
	sndch4 0, 0, 6
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndlen 12
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 4
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndlen 12
	sndendch

