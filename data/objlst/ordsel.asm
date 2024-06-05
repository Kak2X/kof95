OBJLstPtrTable_OrdSel_Cursor:
	dw OBJLstHdrA_OrdSel_Cursor, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_OrdSel_Cursor:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $02 ; OBJ Count
	;    Y   X  ID+FLAG
	db $00,$00,$00 ; $00
	db $00,$08,$02 ; $01