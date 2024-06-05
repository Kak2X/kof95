SndHeader_SFX_Unused_Bounce:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_Bounce_Ch3 ; Data ptr
	db $07 ; Base freq/note id
	db $81 ; Unused
SndData_SFX_Unused_Bounce_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3R|SNDOUT_CH3L
	sndwave $02
	sndnote $0F
	sndlen 1
	sndnote $11
	sndlen 1
	sndnote $0D
	sndlen 1
.loop0:
	sndnote $0F
	sndlen 1
	sndnotebase $01
	sndloopcnt $00, 12, .loop0
	sndnotebase $F4
	sndenvch3 3
.loop1:
	sndnote $0F
	sndlen 1
	sndnotebase $01
	sndloopcnt $00, 12, .loop1
	sndendch

