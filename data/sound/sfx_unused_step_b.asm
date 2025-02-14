SndHeader_SFX_Unused_StepB:
	db $01 ; Number of channels
.ch4:
	db SIS_SFX|SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_SFX_Unused_StepB_Ch4 ; Data ptr
	db 0 ; Initial fine tune
	db $81 ; Unused
SndData_SFX_Unused_StepB_Ch4:
	envelope $F5
	panning $88
	note4 D#,5,0, 1
	note4 G#,4,0, 1
	note4x $80, 2 ; Nearest: B_,3,0
	note4 D_,5,0, 1
	note4x $58, 1 ; Nearest: B_,4,1
	note4x $80, 1 ; Nearest: B_,3,0
	note4 C#,5,0, 1
	note4x $59, 1 ; Nearest: A#,4,1
	note4x $80, 2 ; Nearest: B_,3,0
	chan_stop
