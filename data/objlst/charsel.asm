
OBJLstPtrTable_CharSel_Cursor:
	dw OBJLstHdrA_CharSel_CursorPl1P, OBJLSTPTR_NONE
	dw OBJLstHdrA_CharSel_CursorPl2P, OBJLSTPTR_NONE
	dw OBJLstHdrA_CharSel_CursorCPU1P, OBJLSTPTR_NONE
	dw OBJLstHdrA_CharSel_CursorCPU2P, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_CharSel_CursorPl1P:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $29,$0B,$00 ; $00
	db $29,$13,$04 ; $01
	db $28,$08,$0C ; $02
	db $30,$18,$0C|OLR_XFLIP|OLR_YFLIP ; $03
		
OBJLstHdrA_CharSel_CursorPl2P:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $04 ; OBJ Count
	;    Y   X  ID+FLAG
	db $37,$0C,$02 ; $00
	db $37,$14,$04 ; $01
	db $28,$18,$0C|OLR_XFLIP ; $02
	db $30,$08,$0C|OLR_YFLIP ; $03
		
OBJLstHdrA_CharSel_CursorCPU1P:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $29,$08,$06 ; $00
	db $29,$10,$08 ; $01
	db $29,$18,$0A ; $02
	db $28,$08,$0C ; $03
	db $30,$18,$0C|OLR_XFLIP|OLR_YFLIP ; $04
		
OBJLstHdrA_CharSel_CursorCPU2P:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $05 ; OBJ Count
	;    Y   X  ID+FLAG
	db $37,$08,$06 ; $00
	db $37,$10,$08 ; $01
	db $37,$18,$0A ; $02
	db $28,$18,$0C|OLR_XFLIP ; $03
	db $30,$08,$0C|OLR_YFLIP ; $04
		
