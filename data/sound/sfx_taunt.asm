SndHeader_SFX_Taunt:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_Taunt_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Taunt_Ch2:
	sndenv 10, SNDENV_INC, 1
	sndenach SNDOUT_CH2R|SNDOUT_CH2L
	sndnr21 0, 0
	sndnote $3A
	sndlen 6
	sndsetskip
	sndnote $38
	sndlen 1
	sndnote $36
	sndlen 1
	sndnote $35
	sndlen 1
	sndnote $33
	sndlen 1
	sndnote $31
	sndlen 1
	sndendch

