SndHeader_SFX_CharSelected:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_CharSelected_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_CharSelected_Ch2:
	sndenv 15, SNDENV_DEC, 1
	sndenach SNDOUT_CH2R|SNDOUT_CH2L
	sndnr21 0, 0
	sndnote $19
	sndlen 1
	sndnote $1B
	sndnote $1D
	sndnote $1E
	sndnote $20
	sndnote $22
	sndnote $24
	sndnote $25
	sndlen 1
	sndnote $29
	sndnote $30
	sndnote $35
	sndlen 3
	sndenv 7, SNDENV_DEC, 1
	sndnote $25
	sndlen 1
	sndnote $29
	sndnote $30
	sndnote $35
	sndlen 3
	sndenv 4, SNDENV_DEC, 1
	sndnote $25
	sndlen 1
	sndnote $29
	sndnote $30
	sndnote $35
	sndlen 3
	sndenv 1, SNDENV_DEC, 1
	sndnote $25
	sndlen 1
	sndnote $29
	sndnote $30
	sndnote $35
	sndlen 3
	sndendch

