SndHeader_SFX_Unused_C2:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_C2_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_C2_Ch3:
	sndenach SNDOUT_CH3L ;X
	sndwave $09 ;X
	sndendch ;X

