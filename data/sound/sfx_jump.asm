SndHeader_SFX_Jump:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Jump_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Jump_Ch4:
	sndenv 1, SNDENV_INC, 1
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 4, 1, 0
	sndlen 3
	sndenv 15, SNDENV_DEC, 1
	sndch4 4, 0, 0
	sndlen 6
	sndendch

