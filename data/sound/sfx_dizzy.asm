SndHeader_SFX_Dizzy:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Dizzy_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Dizzy_Ch4:
	sndenv 15, SNDENV_DEC, 4
	sndenach SNDOUT_CH4L
	sndendch

