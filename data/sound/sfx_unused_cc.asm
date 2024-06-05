SndHeader_SFX_Unused_CC:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_CC_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_CC_Ch2:
	sndenv 13, SNDENV_DEC, 1 ;X
	sndenach SNDOUT_CH2R|SNDOUT_CH2L ;X
	sndnr21 0, 0 ;X
	sndendch ;X

