SndHeader_SFX_Unused_D3:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_D3_Ch4 ; Data ptr
	db 24 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_D3_Ch4:
	envelope $FF
	panning $80
	chan_stop
