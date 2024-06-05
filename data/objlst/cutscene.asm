; Fully black square covering the opponent pic
OBJLstPtrTable_Cutscene_PicBlink:
	dw OBJLstHdrA_Cutscene_PicBlink0, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Cutscene_PicBlink0:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $12 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$00,$00 ; $00
	db $00,$08,$00 ; $01
	db $00,$10,$00 ; $02
	db $00,$18,$00 ; $03
	db $00,$20,$00 ; $04
	db $00,$28,$00 ; $05
	db $10,$00,$00 ; $06
	db $10,$08,$00 ; $07
	db $10,$10,$00 ; $08
	db $10,$18,$00 ; $09
	db $10,$20,$00 ; $0A
	db $10,$28,$00 ; $0B
	db $20,$00,$00 ; $0C
	db $20,$08,$00 ; $0D
	db $20,$10,$00 ; $0E
	db $20,$18,$00 ; $0F
	db $20,$20,$00 ; $10
	db $20,$28,$00 ; $11