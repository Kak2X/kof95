SndHeader_SFX_Step:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Step_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Step_Ch4:
	sndenv 2, SNDENV_INC, 1
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 4, 0, 0
	sndlen 2
	sndenv 15, SNDENV_DEC, 1
	sndsetskip
	sndch4 4, 0, 2
	sndlen 1
	sndch4 4, 0, 3
	sndlen 1
	sndendch

