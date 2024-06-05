SndHeader_BGM_Nakoruru:
	db $04 ; Number of channels
.ch1:
	db SIS_ENABLED ; Initial playback status
	db SND_CH1_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch1 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch2:
	db SIS_ENABLED ; Initial playback status
	db SND_CH2_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch2 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
.ch3:
	db SIS_ENABLED ; Initial playback status
	db SND_CH3_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch3 ; Data ptr
	db $0C ; Base freq/note id
	db $81 ; Unused
.ch4:
	db SIS_ENABLED ; Initial playback status
	db SND_CH4_PTR ; Sound channel ptr
	dw SndData_BGM_Nakoruru_Ch4 ; Data ptr
	db $00 ; Base freq/note id
	db $81 ; Unused
SndData_BGM_Nakoruru_Ch1:
	sndenv 9, SNDENV_DEC, 5
	sndenach SNDOUT_CH1R|SNDOUT_CH1L
	sndnr11 3, 0
	sndtinc $00D8
	sndnote $00
	sndlen 48
	sndnotebase $F4
.main:
	sndenv 9, SNDENV_DEC, 5
	sndcall SndCall_Nakoruru_Ch1
	sndloopcnt $01, 3, .main
	sndnote $00
	sndlen 96
	sndnotebase $0C
	sndnote $00
	sndlen 48
	sndnote $00
	sndlen 6
	sndnote $27
	sndnote $2A
	sndnote $27
	sndnote $2C
	sndnote $27
	sndnote $2E
	sndnote $27
	sndnote $31
	sndlen 12
	sndnote $2F
	sndlen 84
	sndnote $00
	sndlen 48
	sndnote $00
	sndlen 6
	sndnote $2C
	sndnote $2F
	sndnote $2C
	sndnote $31
	sndnote $2C
	sndnote $33
	sndlen 12
	sndnote $36
	sndlen 36
	sndnote $35
	sndlen 6
	sndnote $33
	sndnote $35
	sndlen 36
	sndnote $33
	sndlen 6
	sndnote $31
	sndnote $33
	sndlen 54
	sndnote $27
	sndlen 6
	sndnote $2A
	sndnote $27
	sndnote $2C
	sndnote $27
	sndnote $2E
	sndnote $27
	sndnote $31
	sndlen 12
	sndnote $2F
	sndlen 84
	sndnote $00
	sndlen 48
	sndnote $00
	sndlen 6
	sndnote $2C
	sndnote $2F
	sndnote $2C
	sndnote $31
	sndnote $2C
	sndnote $33
	sndlen 12
	sndnote $36
	sndlen 6
	sndnote $38
	sndenv 3, SNDENV_DEC, 0
	sndnote $38
	sndenv 2, SNDENV_DEC, 0
	sndnote $38
	sndnote $00
	sndlen 12
	sndenv 9, SNDENV_DEC, 5
	sndnote $36
	sndlen 6
	sndnote $38
	sndnote $38
	sndnote $3B
	sndenv 3, SNDENV_DEC, 0
	sndnote $3B
	sndenv 2, SNDENV_DEC, 0
	sndnote $3B
	sndenv 9, SNDENV_DEC, 5
	sndnote $38
	sndlen 6
	sndnote $3B
	sndlen 12
	sndnote $3D
	sndlen 6
	sndnote $3F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $3F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $3F
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $00
	sndlen 12
	sndnote $3D
	sndlen 6
	sndnote $3F
	sndnote $3D
	sndnote $3F
	sndenv 3, SNDENV_DEC, 0
	sndnote $3F
	sndenv 2, SNDENV_DEC, 0
	sndnote $3F
	sndenv 9, SNDENV_DEC, 5
	sndnote $3D
	sndlen 6
	sndnote $3F
	sndnote $3A
	sndnote $3B
	sndnotebase $F4
	sndcall SndCall_Nakoruru_Ch1
.loop1:
	sndcall SndCall_Nakoruru_Ch1
	sndnotebase $0C
	sndnote $00
	sndlen 30
	sndnote $25
	sndlen 6
	sndnote $29
	sndnote $25
	sndnote $2A
	sndnote $25
	sndnote $2C
	sndnote $25
	sndnote $2E
	sndnote $25
	sndnote $2F
	sndnote $25
	sndnote $00
	sndlen 30
	sndnote $25
	sndlen 6
	sndnote $29
	sndnote $25
	sndnote $29
	sndnote $2A
	sndnote $2C
	sndnote $2E
	sndnote $2F
	sndnote $30
	sndnote $31
	sndnote $33
	sndnotebase $F4
	sndloopcnt $01, 2, .loop1
	sndnotebase $0C
	sndenv 7, SNDENV_DEC, 2
.loop2:
	sndnote $33
	sndlen 6
	sndnote $35
	sndnote $35
	sndnote $35
	sndnote $33
	sndnote $35
	sndnote $33
	sndnote $35
	sndloopcnt $01, 4, .loop2
	sndnotebase $F4
	sndloop .main
SndData_BGM_Nakoruru_Ch2:
	sndenv 13, SNDENV_DEC, 5
	sndenach SNDOUT_CH2R
	sndnr21 3, 0
	sndnote $00
	sndlen 48
.main:
	sndcall SndCall_Nakoruru_Ch2
	sndloopcnt $01, 3, .main
	sndnote $19
	sndlen 6
	sndnote $1B
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 6
	sndnote $1B
	sndnote $1B
	sndnote $1E
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $1B
	sndlen 6
	sndnote $1E
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 6
	sndnote $16
	sndlen 6
	sndnote $16
	sndnote $14
	sndnote $16
	sndnote $14
	sndnote $16
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $14
	sndlen 6
	sndnote $16
	sndnote $11
	sndnote $12
	sndenv 7, SNDENV_DEC, 2
.loop1:
	sndnote $14
	sndlen 6
	sndnote $0F
	sndnote $0B
	sndnote $0F
	sndnote $0B
	sndnote $14
	sndnote $0F
	sndnote $17
	sndnote $0B
	sndnote $14
	sndnote $0F
	sndnote $17
	sndnote $1B
	sndnote $17
	sndnote $14
	sndnote $0F
	sndnote $20
	sndnote $1B
	sndnote $17
	sndnote $1B
	sndnote $17
	sndnote $20
	sndnote $1B
	sndnote $23
	sndnote $17
	sndnote $20
	sndnote $1B
	sndnote $23
	sndnote $27
	sndnote $23
	sndnote $20
	sndnote $1B
	sndloopcnt $01, 2, .loop1
	sndenv 13, SNDENV_DEC, 5
	sndnote $19
	sndlen 6
	sndnote $1B
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 6
	sndnote $1B
	sndnote $1B
	sndnote $1E
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $1B
	sndlen 6
	sndnote $1E
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $16
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 6
	sndnote $16
	sndlen 6
	sndnote $16
	sndnote $14
	sndnote $16
	sndnote $14
	sndnote $16
	sndnote $16
	sndlen 2
	sndnote $00
	sndlen 4
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $14
	sndlen 6
	sndnote $16
	sndnote $11
	sndnote $12
	sndnote $19
	sndnote $1B
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $19
	sndlen 6
	sndnote $1B
	sndnote $1B
	sndnote $1E
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $1B
	sndlen 6
	sndnote $1E
	sndlen 12
	sndnote $20
	sndlen 6
	sndnote $3A
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $3A
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $3A
	sndlen 4
	sndnote $00
	sndlen 8
	sndnote $00
	sndlen 12
	sndnote $38
	sndlen 6
	sndnote $3A
	sndnote $38
	sndnote $3A
	sndnote $00
	sndlen 12
	sndnote $38
	sndlen 6
	sndnote $3A
	sndnote $35
	sndnote $36
.loop2:
	sndcall SndCall_Nakoruru_Ch2
	sndloopcnt $01, 2, .loop2
	sndnote $14
	sndlen 6
	sndlen 90
	sndnote $11
	sndlen 6
	sndlen 90
	sndcall SndCall_Nakoruru_Ch2
	sndnote $14
	sndlen 6
	sndlen 90
	sndnote $11
	sndlen 6
	sndlen 90
	sndnote $1D
	sndlen 48
	sndnote $1C
	sndnote $1B
	sndnote $19
	sndloop .main
SndData_BGM_Nakoruru_Ch3:
	sndenvch3 1
	sndenach SNDOUT_CH3L
	sndwave $02
	sndnote $00
	sndlen 48
.main:
	sndcall SndCall_Nakoruru_Ch3
	sndloopcnt $01, 3, .main
.loop1:
	sndnote $1E
	sndlen 6
	sndnote $20
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $1E
	sndlen 6
	sndnote $20
	sndnote $20
	sndnote $23
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $14
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $20
	sndlen 6
	sndnote $23
	sndlen 12
	sndnote $25
	sndlen 6
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $0F
	sndlen 4
	sndnote $00
	sndlen 2
	sndnote $00
	sndlen 6
	sndnote $0F
	sndlen 6
	sndnote $0F
	sndnote $0D
	sndnote $0F
	sndnote $0D
	sndnote $0F
	sndnote $0F
	sndlen 2
	sndnote $00
	sndlen 4
	sndlen 2
	sndnote $00
	sndlen 4
	sndnote $0D
	sndlen 6
	sndnote $0F
	sndnote $0A
	sndnote $0B
	sndloopcnt $01, 5, .loop1
.loop2:
	sndcall SndCall_Nakoruru_Ch3
	sndloopcnt $01, 2, .loop2
	sndnote $0D
	sndlen 6
	sndlen 90
	sndnote $0A
	sndlen 6
	sndlen 90
	sndcall SndCall_Nakoruru_Ch3
	sndnote $0D
	sndlen 6
	sndlen 90
	sndnote $0A
	sndlen 6
	sndlen 90
.loop3:
	sndnote $11
	sndlen 6
	sndnote $11
	sndnote $10
	sndnote $10
	sndnote $0F
	sndnote $0F
	sndnote $10
	sndnote $10
	sndloopcnt $01, 4, .loop3
	sndloop .main
SndData_BGM_Nakoruru_Ch4:
	sndenach SNDOUT_CH4R|SNDOUT_CH4L
	sndnotebase $10
	sndenv 11, SNDENV_DEC, 1
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.main:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 6, .main
.loop1:
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $01, 6, .loop1
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop2:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 6, .loop2
	sndch4 8, 0, 0
	sndlen 96
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 0, 2
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndch4 8, 0, 2
	sndch4 8, 0, 2
.loop3:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 4, .loop3
.loop4:
	sndch4 8, 0, 2
	sndlen 6
	sndch4 1, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $01, 2, .loop4
.loop5:
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 3
	sndch4 8, 0, 0
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 1
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 2
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndch4 8, 0, 3
	sndloopcnt $01, 2, .loop5
.loop6:
	sndch4 8, 0, 2
	sndlen 6
	sndch4 1, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $01, 2, .loop6
.loop7:
	sndch4 8, 0, 2
	sndlen 12
	sndch4 8, 0, 1
	sndlen 6
	sndch4 8, 0, 1
	sndloopcnt $01, 8, .loop7
	sndloop .main
SndCall_Nakoruru_Ch1:
	sndch4 10, 1, 2
	sndlen 6
	sndch4 10, 1, 4
	sndenv 3, SNDENV_DEC, 0
	sndch4 10, 1, 4
	sndenv 2, SNDENV_DEC, 0
	sndch4 10, 1, 4
	sndch4 8, 0, 0
	sndlen 12
	sndenv 9, SNDENV_DEC, 5
	sndch4 10, 1, 2
	sndlen 6
	sndch4 10, 1, 4
	sndch4 10, 1, 4
	sndch4 10, 1, 7
	sndenv 3, SNDENV_DEC, 0
	sndch4 10, 1, 7
	sndenv 2, SNDENV_DEC, 0
	sndch4 10, 1, 7
	sndenv 9, SNDENV_DEC, 5
	sndch4 10, 1, 4
	sndlen 6
	sndch4 10, 1, 7
	sndlen 12
	sndch4 11, 0, 1
	sndlen 6
	sndch4 11, 0, 3
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 11, 0, 3
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 11, 0, 3
	sndlen 4
	sndch4 8, 0, 0
	sndlen 8
	sndch4 8, 0, 0
	sndlen 12
	sndch4 11, 0, 1
	sndlen 6
	sndch4 11, 0, 3
	sndch4 11, 0, 1
	sndch4 11, 0, 3
	sndenv 3, SNDENV_DEC, 0
	sndch4 11, 0, 3
	sndenv 2, SNDENV_DEC, 0
	sndch4 11, 0, 3
	sndenv 9, SNDENV_DEC, 5
	sndch4 11, 0, 1
	sndlen 6
	sndch4 11, 0, 3
	sndch4 10, 1, 6
	sndch4 10, 1, 7
	sndret
SndCall_Nakoruru_Ch3:
	sndch4 9, 0, 2
	sndlen 6
	sndch4 9, 0, 4
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 2
	sndlen 6
	sndch4 9, 0, 4
	sndch4 9, 0, 4
	sndch4 9, 0, 7
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 4
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 4
	sndlen 6
	sndch4 9, 0, 7
	sndlen 12
	sndch4 8, 1, 5
	sndlen 6
	sndch4 8, 1, 7
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 8, 1, 7
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 8, 1, 7
	sndlen 4
	sndch4 8, 0, 0
	sndlen 8
	sndch4 8, 0, 0
	sndlen 12
	sndch4 8, 1, 5
	sndlen 6
	sndch4 8, 1, 7
	sndch4 8, 1, 5
	sndch4 8, 1, 7
	sndch4 8, 1, 7
	sndlen 2
	sndch4 8, 0, 0
	sndlen 4
	sndch4 0, 0, 2
	sndch4 8, 0, 0
	sndlen 4
	sndch4 8, 1, 5
	sndlen 6
	sndch4 8, 1, 7
	sndch4 8, 1, 2
	sndch4 8, 1, 3
	sndret
SndCall_Nakoruru_Ch2:
	sndch4 8, 1, 5
	sndlen 6
	sndch4 8, 1, 7
	sndenv 3, SNDENV_DEC, 0
	sndch4 8, 1, 7
	sndenv 2, SNDENV_DEC, 0
	sndch4 8, 1, 7
	sndch4 8, 0, 0
	sndlen 12
	sndenv 9, SNDENV_DEC, 5
	sndch4 8, 1, 5
	sndlen 6
	sndch4 8, 1, 7
	sndch4 8, 1, 7
	sndch4 9, 0, 2
	sndch4 8, 1, 7
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 8, 1, 7
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 8, 1, 7
	sndlen 6
	sndch4 9, 0, 2
	sndlen 12
	sndch4 8, 1, 0
	sndlen 6
	sndch4 9, 0, 6
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 6
	sndlen 4
	sndch4 8, 0, 0
	sndlen 2
	sndch4 9, 0, 6
	sndlen 4
	sndch4 8, 0, 0
	sndlen 8
	sndch4 8, 0, 0
	sndlen 12
	sndch4 9, 0, 4
	sndlen 6
	sndch4 9, 0, 6
	sndch4 9, 0, 4
	sndch4 9, 0, 6
	sndch4 9, 0, 6
	sndlen 2
	sndch4 8, 0, 0
	sndlen 4
	sndch4 0, 0, 2
	sndch4 8, 0, 0
	sndlen 4
	sndch4 9, 0, 4
	sndlen 6
	sndch4 9, 0, 6
	sndch4 9, 0, 1
	sndch4 9, 0, 2
	sndret

