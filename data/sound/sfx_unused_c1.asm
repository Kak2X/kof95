SndHeader_SFX_Unused_C1:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_C1_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_C1_Ch3:
	sndenach SNDOUT_CH3R ;X
	sndwave $09 ;X
	sndendch ;X

