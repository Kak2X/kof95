SndHeader_SFX_Unused_D4:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_D4_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_D4_Ch4:
	sndenv 13, SNDENV_DEC, 1 ;X
	sndenach SNDOUT_CH4R|SNDOUT_CH4L ;X
	sndendch ;X

