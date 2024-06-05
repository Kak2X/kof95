SndHeader_SFX_Heavy:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Heavy_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Heavy_Ch4:
	sndenv 14, SNDENV_DEC, 4
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 5, 1, 5
	sndlen 2
	sndsetskip
	sndch4 5, 1, 4
	sndlen 1
	sndch4 5, 1, 3
	sndlen 1
	sndch4 5, 1, 2
	sndlen 1
	sndch4 5, 1, 1
	sndlen 1
	sndch4 5, 1, 0
	sndlen 1
	sndendch

