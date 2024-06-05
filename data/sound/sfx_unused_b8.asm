SndHeader_SFX_Unused_B8:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_B8_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_B8_Ch3:
	sndenvch3 1 ;X
	sndenach SNDOUT_CH3L ;X
	sndwave $09 ;X
	sndendch ;X

