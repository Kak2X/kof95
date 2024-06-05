SndHeader_BGM_GameOver:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_GameOver_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_GameOver_Ch1:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 3, 0
	sndtinc $00D3
	sndnote $2F
	sndlen 12
	sndlen 4
	sndnote $2F
	sndnote $2F
	snd_UNK_setstat6
	sndnote $36
	sndlen 44
	sndnote $00
	sndlen 4
	sndendch
SndData_BGM_GameOver_Ch2:
	sndenv 10, SNDENV_DEC, 7
	sndenach SNDOUT_CH2L
	sndnr21 1, 0
	sndnote $00
	sndlen 12
	sndnote $21
	sndlen 2
	sndnote $22
	sndnote $23
	sndnote $24
	sndnote $25
	sndnote $26
	sndnote $27
	sndlen 44
	sndnote $00
	sndlen 4
	sndendch
SndData_BGM_GameOver_Ch3:
	sndenvch3 2
	sndenach SNDOUT_CH3R
	sndwave $03
	sndnote $00
	sndlen 12
	sndnote $1D
	sndlen 2
	sndnote $1E
	sndnote $1F
	sndnote $20
	sndnote $21
	sndnote $22
	sndnote $23
	sndlen 12
	sndendch
SndData_BGM_GameOver_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 4
	sndch4 8, 0, 1
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 24
	sndendch

