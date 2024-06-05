SndHeader_SFX_Unused_BF:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_BF_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_BF_Ch2:
	sndenv 15, SNDENV_DEC, 3 ;X
	sndenach SNDOUT_CH2R ;X
	sndnr21 3, 0 ;X
	sndendch ;X

