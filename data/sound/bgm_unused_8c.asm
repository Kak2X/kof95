SndHeader_BGM_Unused_8C:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch3 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Unused_8C_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Unused_8C_Ch1:
	sndenv 11, SNDENV_DEC, 2 ;X
	sndenach SNDOUT_CH1R|SNDOUT_CH1L ;X
	sndnr11 3, 0 ;X
	sndtinc $009C ;X
	sndendch ;X
SndData_BGM_Unused_8C_Ch2:
	sndenv 11, SNDENV_DEC, 2 ;X
	sndenach SNDOUT_CH2R ;X
	sndnr21 3, 0 ;X
	sndendch ;X
SndData_BGM_Unused_8C_Ch3:
	sndenvch3 1 ;X
	sndenach SNDOUT_CH3L ;X
	sndwave $07 ;X
	sndendch ;X
SndData_BGM_Unused_8C_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L ;X
	sndnotebase $10 ;X
	sndenv 10, SNDENV_DEC, 1 ;X
	sndendch ;X

