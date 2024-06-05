; [TCRF] Unused sprite mapping for large objects, no surviving graphics.
;        Quite similar to the large Iori/Kyo ones.
OBJLstPtrTable_Intro_Unused:
	dw OBJLstHdrA_Intro_Unused0, OBJLSTPTR_NONE
	dw OBJLstHdrA_Intro_Unused1, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Intro_Unused0:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $1D ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$00,$00 ; $00
	db $00,$08,$02 ; $01
	db $00,$10,$04 ; $02
	db $00,$18,$06 ; $03
	db $00,$20,$08 ; $04
	db $00,$28,$0A ; $05
	db $00,$30,$0C ; $06
	db $10,$00,$0E ; $07
	db $10,$08,$10 ; $08
	db $10,$10,$12 ; $09
	db $10,$18,$14 ; $0A
	db $10,$20,$16 ; $0B
	db $10,$28,$18 ; $0C
	db $10,$30,$1A ; $0D
	db $20,$00,$1C ; $0E
	db $20,$08,$1E ; $0F
	db $20,$10,$20 ; $10
	db $20,$18,$22 ; $11
	db $20,$20,$24 ; $12
	db $20,$28,$26 ; $13
	db $20,$30,$28 ; $14
	db $30,$08,$2A ; $15
	db $30,$10,$2C ; $16
	db $30,$18,$2E ; $17
	db $30,$20,$30 ; $18
	db $30,$28,$32 ; $19
	db $30,$30,$34 ; $1A
	db $30,$38,$36 ; $1B
	db $30,$40,$38 ; $1C
		
OBJLstHdrA_Intro_Unused1:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $16 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$18,$00 ; $00
	db $00,$20,$02 ; $01
	db $10,$10,$04 ; $02
	db $10,$18,$06 ; $03
	db $10,$20,$08 ; $04
	db $10,$28,$0A ; $05
	db $10,$30,$0C ; $06
	db $10,$38,$0E ; $07
	db $20,$10,$10 ; $08
	db $20,$18,$12 ; $09
	db $20,$20,$14 ; $0A
	db $20,$28,$16 ; $0B
	db $20,$30,$18 ; $0C
	db $20,$38,$1A ; $0D
	db $30,$00,$1C ; $0E
	db $30,$08,$1E ; $0F
	db $30,$10,$20 ; $10
	db $30,$18,$22 ; $11
	db $30,$20,$24 ; $12
	db $30,$28,$26 ; $13
	db $30,$30,$28 ; $14
	db $30,$38,$2A ; $15