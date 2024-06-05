SndHeader_SFX_ProjLg:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_ProjLg_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_ProjLg_Ch4:
	sndenv 15, SNDENV_DEC, 7
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 5, 0, 4
	sndlen 3
	sndch4 5, 0, 3
	sndlen 3
	sndch4 5, 0, 2
	sndlen 3
	sndch4 5, 0, 1
	sndlen 3
	sndch4 5, 0, 0
	sndlen 5
	sndenv 15, SNDENV_DEC, 1
	sndch4 4, 0, 0
	sndlen 4
	sndendch

