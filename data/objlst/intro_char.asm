
OBJLstPtrTable_Intro_Char:
	dw OBJLstHdrA_Intro_Kyo, OBJLSTPTR_NONE
	dw OBJLstHdrA_Intro_Iori, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Intro_Kyo:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $1E ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$FF,$00 ; $00
	db $00,$07,$02 ; $01
	db $00,$0F,$04 ; $02
	db $00,$17,$06 ; $03
	db $00,$1F,$08 ; $04
	db $00,$27,$0A ; $05
	db $00,$2F,$0C ; $06
	db $10,$FF,$0E ; $07
	db $10,$07,$10 ; $08
	db $10,$0F,$12 ; $09
	db $10,$17,$14 ; $0A
	db $10,$1F,$16 ; $0B
	db $10,$27,$18 ; $0C
	db $10,$2F,$1A ; $0D
	db $20,$FF,$1C ; $0E
	db $20,$07,$1E ; $0F
	db $20,$0F,$20 ; $10
	db $20,$17,$22 ; $11
	db $20,$1F,$24 ; $12
	db $20,$27,$26 ; $13
	db $20,$2F,$28 ; $14
	db $20,$37,$2A ; $15
	db $30,$07,$2C ; $16
	db $30,$0F,$2E ; $17
	db $30,$17,$30 ; $18
	db $30,$1F,$32 ; $19
	db $30,$27,$34 ; $1A
	db $30,$2F,$36 ; $1B
	db $30,$37,$38 ; $1C
	db $30,$3F,$3A ; $1D
		
OBJLstHdrA_Intro_Iori:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $17 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$17,$00 ; $00
	db $00,$1F,$02 ; $01
	db $00,$27,$04 ; $02
	db $10,$0F,$06 ; $03
	db $10,$17,$08 ; $04
	db $10,$1F,$0A ; $05
	db $10,$27,$0C ; $06
	db $10,$2F,$0E ; $07
	db $10,$37,$10 ; $08
	db $20,$0F,$12 ; $09
	db $20,$17,$14 ; $0A
	db $20,$1F,$16 ; $0B
	db $20,$27,$18 ; $0C
	db $20,$2F,$1A ; $0D
	db $20,$37,$1C ; $0E
	db $30,$FF,$1E ; $0F
	db $30,$07,$20 ; $10
	db $30,$0F,$22 ; $11
	db $30,$17,$24 ; $12
	db $30,$1F,$26 ; $13
	db $30,$27,$28 ; $14
	db $30,$2F,$2A ; $15
	db $30,$37,$2C ; $16