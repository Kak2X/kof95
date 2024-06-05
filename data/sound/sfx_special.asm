SndHeader_SFX_Special:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Special_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Special_Ch4:
	sndenv 15, SNDENV_DEC, 5
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
.loop0:
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
	sndloopcnt $00, 2, .loop0
.loop1:
	sndenv 15, SNDENV_DEC, 4
	sndch4 8, 0, 0
	sndlen 4
	sndsetskip
	sndch4 5, 1, 0
	sndlen 2
	sndch4 3, 0, 3
	sndlen 2
	sndch4 3, 0, 5
	sndlen 3
	sndch4 5, 0, 2
	sndlen 2
	sndloopcnt $00, 2, .loop1
	sndendch

