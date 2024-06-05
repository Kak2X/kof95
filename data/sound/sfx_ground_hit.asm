SndHeader_SFX_GroundHit:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_GroundHit_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_GroundHit_Ch4:
	sndenv 14, SNDENV_DEC, 4
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndch4 4, 0, 4
	sndlen 2
	sndch4 4, 0, 3
	sndlen 2
	sndch4 4, 0, 4
	sndlen 2
	sndch4 6, 0, 4
	sndlen 18
	sndenv 4, SNDENV_DEC, 4
	sndch4 4, 0, 4
	sndlen 2
	sndch4 4, 0, 3
	sndlen 2
	sndch4 4, 0, 4
	sndlen 2
	sndch4 6, 0, 4
	sndlen 18
	sndendch

