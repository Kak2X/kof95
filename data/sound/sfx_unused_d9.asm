SndHeader_SFX_Unused_D9:
	db $01 ; Number of channels
.ch3:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_D9_Ch3 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_D9_Ch3:
	wave_vol $C0
	wave_id $08
	panning $44
	chan_stop
