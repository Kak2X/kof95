SndHeader_SFX_Error:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Error_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Error_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R|SNDOUT_CH3L
	sndwave $04
	sndnote $1D
	sndlen 48
	sndendch

