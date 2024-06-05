OBJLstPtrTable_Play_RoundText:
	dw OBJLstHdrA_Play_RoundText0_A, OBJLstHdrB_Play_RoundText0_B
	dw OBJLstHdrA_Play_RoundText0_A, OBJLstHdrB_Play_RoundText1_B
	dw OBJLstHdrA_Play_RoundText0_A, OBJLstHdrB_Play_RoundText2_B
	dw OBJLstHdrA_Play_RoundText3, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText4, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText5, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText6, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText7, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText8, OBJLSTPTR_NONE
	dw OBJLstHdrA_Play_RoundText9, OBJLSTPTR_NONE ;X
	dw OBJLstHdrA_Play_RoundText10_A, OBJLstHdrB_Play_RoundText10_B
	dw OBJLstHdrA_Play_RoundText10_A, OBJLstHdrB_Play_RoundText11_B
	dw OBJLstHdrA_Play_RoundText12_A, OBJLstHdrB_Play_RoundText12_B ;X
	dw OBJLstHdrA_Play_RoundText13_A, OBJLstHdrB_Play_RoundText12_B ;X
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Play_RoundText0_A:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$04,$1E ; $00
	db $00,$0C,$1A ; $01
	db $00,$14,$24 ; $02
	db $00,$1C,$18 ; $03
	db $00,$24,$04 ; $04
		
OBJLstHdrB_Play_RoundText0_B:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$34,$22 ; $00
		
OBJLstHdrB_Play_RoundText1_B:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$34,$24 ; $00
		
OBJLstHdrB_Play_RoundText2_B:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$34,$26 ; $00
		
OBJLstHdrA_Play_RoundText3:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$F4,$08 ; $00
	db $00,$FC,$0E ; $01
	db $00,$04,$18 ; $02
	db $00,$0C,$00 ; $03
	db $00,$14,$12 ; $04
	db $00,$24,$1E ; $05
	db $00,$2C,$1A ; $06
	db $00,$34,$24 ; $07
	db $00,$3C,$18 ; $08
	db $00,$44,$04 ; $09
		
OBJLstHdrA_Play_RoundText4:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$08,$08 ; $00
	db $00,$10,$0E ; $01
	db $00,$18,$0A ; $02
	db $00,$20,$0C ; $03
	db $00,$28,$22 ; $04
	db $00,$30,$32 ; $05
		
OBJLstHdrA_Play_RoundText5:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$0C,$1E ; $00
	db $00,$14,$06 ; $01
	db $00,$1C,$00 ; $02
	db $00,$24,$04 ; $03
	db $00,$2C,$2A ; $04
		
OBJLstHdrA_Play_RoundText6:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$14,$0A ; $00
	db $00,$1C,$1A ; $01
	db $00,$24,$32 ; $02
		
OBJLstHdrA_Play_RoundText7:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $08 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$00,$22 ; $00
	db $00,$08,$0E ; $01
	db $00,$10,$14 ; $02
	db $00,$18,$16 ; $03
	db $00,$19,$06 ; $04
	db $00,$29,$24 ; $05
	db $00,$31,$1C ; $06
	db $00,$39,$32 ; $07
		
OBJLstHdrA_Play_RoundText8:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$10,$04 ; $00
	db $00,$18,$1E ; $01
	db $00,$20,$00 ; $02
	db $00,$28,$26 ; $03
	db $00,$30,$28 ; $04
		
OBJLstHdrA_Play_RoundText9: ;X
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$F8,$04 ; $00
	db $00,$00,$1A ; $01
	db $00,$08,$24 ; $02
	db $00,$10,$02 ; $03
	db $00,$18,$12 ; $04
	db $00,$20,$06 ; $05
	db $00,$30,$10 ; $06
	db $00,$38,$1A ; $07
	db $00,$40,$32 ; $08
		
OBJLstHdrA_Play_RoundText10_A:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $03 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$00,$2A ; $00
	db $00,$08,$1A ; $01
	db $00,$10,$24 ; $02
		
OBJLstHdrB_Play_RoundText10_B:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$20,$0C ; $00
	db $00,$28,$14 ; $01
	db $00,$30,$1A ; $02
	db $00,$38,$1C ; $03
		
OBJLstHdrB_Play_RoundText11_B:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$20,$20 ; $00
	db $00,$28,$22 ; $01
	db $00,$29,$14 ; $02
	db $00,$31,$12 ; $03
	db $00,$39,$2C ; $04
		
OBJLstHdrA_Play_RoundText12_A: ;X
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$04,$2C ; $00
		
OBJLstHdrA_Play_RoundText13_A: ;X
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$04,$2E ; $00
		
OBJLstHdrB_Play_RoundText12_B: ;X
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db $00,$00,$00 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin: ;X
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$0C,$1A ; $00
	db $00,$1C,$24 ; $01
	db $00,$24,$26 ; $02
	db $00,$25,$18 ; $03
	db $00,$2D,$16 ; $04
	db $00,$35,$30 ; $05