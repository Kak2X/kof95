SndHeader_SFX_Unused_D5:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_D5_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_D5_Ch2:
	sndenv 15, SNDENV_DEC, 5 ;X
	sndenach SNDOUT_CH2R|SNDOUT_CH2L ;X
	sndnr21 2, 0 ;X
	sndendch ;X

