SndHeader_SFX_ChargeMeter:
	db $01 ; Number of channels
.ch2:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_SFX_ChargeMeter_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_ChargeMeter_Ch2:
	sndenv 15, SNDENV_DEC, 1
	sndenach SNDOUT_CH2R|SNDOUT_CH2L
	sndnr21 0, 0
.loop0:
	sndnote $22
	sndlen 1
	sndnote $23
	sndnote $24
	sndloopcnt $00, 6, .loop0
.loop1:
	sndnote $22
	sndlen 1
	sndnote $23
	sndnote $24
	sndnotebase $01
	sndloopcnt $00, 28, .loop1
	sndendch

