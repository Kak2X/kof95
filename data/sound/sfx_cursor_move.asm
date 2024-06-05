SndHeader_SFX_CursorMove:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_CursorMove_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_CursorMove_Ch2:
	sndenv 15, SNDENV_DEC, 1
	sndenach SNDOUT_CH2R|SNDOUT_CH2L
	sndnr21 1, 0
	sndnote $25
	sndlen 2
	sndnote $29
	sndnote $2C
	sndenv 8, SNDENV_DEC, 1
	sndnote $25
	sndlen 2
	sndnote $29
	sndnote $2C
	sndenv 4, SNDENV_DEC, 1
	sndnote $25
	sndlen 2
	sndnote $29
	sndnote $2C
	sndendch

