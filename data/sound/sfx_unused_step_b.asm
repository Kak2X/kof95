SndHeader_SFX_Unused_StepB:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_StepB_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_StepB_Ch4:
	sndenv 15, SNDENV_DEC, 5
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 4, 0, 4
	sndlen 1
	sndch4 5, 0, 7
	sndlen 1
	sndch4 8, 0, 0
	sndlen 2
	sndch4 4, 0, 5
	sndlen 1
	sndch4 5, 1, 0
	sndlen 1
	sndch4 8, 0, 0
	sndlen 1
	sndch4 4, 0, 6
	sndlen 1
	sndch4 5, 1, 1
	sndlen 1
	sndch4 8, 0, 0
	sndlen 2
	sndendch

