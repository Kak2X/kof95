SndHeader_SFX_Unused_Bounce:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_Bounce_Ch3 ; Data ptr
	db 7 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_Bounce_Ch3:
	wave_vol $C0
	panning $44
	wave_id $02
	note D_,3, 1
	note E_,3, 1
	note C_,3, 1
.main:
	note D_,3, 1
	fine_tune 1
	snd_loop .main, $00, 12
	fine_tune -12
	wave_vol $40
.loop1:
	note D_,3, 1
	fine_tune 1
	snd_loop .loop1, $00, 12
	chan_stop
