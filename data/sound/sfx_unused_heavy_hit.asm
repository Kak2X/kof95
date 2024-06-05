SndHeader_SFX_Unused_HeavyHit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_HeavyHit_Ch4 ; Data ptr
	db $FC ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_HeavyHit_Ch4:
	sndenv 15, SNDENV_DEC, 4
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
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
	sndendch

