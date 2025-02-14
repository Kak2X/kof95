SndHeader_SFX_Unused_SpecialB:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_SpecialB_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_SpecialB_Ch4:
	envelope $F5
	panning $88
	note4x $41, 3 ; Nearest: A#,5,0
	note4x $42, 3 ; Nearest: A_,5,0
	note4x $43, 3 ; Nearest: G#,5,0
	note4 D#,5,0, 3
	envelope $F1
	note4x $80, 10 ; Nearest: B_,3,0
	chan_stop

