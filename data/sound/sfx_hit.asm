SndHeader_SFX_Hit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Hit_Ch4 ; Data ptr
	db $FC ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Hit_Ch4:
	sndenv 15, SNDENV_DEC, 5
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 3, 0, 0
	sndlen 1
	sndsetskip
	sndch4 3, 0, 1
	sndlen 1
	sndch4 3, 0, 2
	sndlen 1
	sndch4 3, 0, 3
	sndlen 1
	sndch4 3, 0, 4
	sndlen 1
	sndch4 3, 0, 5
	sndlen 1
	sndch4 3, 0, 6
	sndlen 1
	sndendch

