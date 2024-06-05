SndHeader_SFX_Unused_DB:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_DB_Ch2 ; Data ptr
	db $06 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_DB_Ch2:
	sndenv 15, SNDENV_DEC, 7 ;X
	sndenach SNDOUT_CH2R ;X
	sndnr21 1, 0 ;X
	sndendch ;X

