OBJLstPtrTable_Title:
	dw OBJLstHdrA_Title_PushStart, OBJLSTPTR_NONE
	dw OBJLstHdrA_Title_Menu, OBJLSTPTR_NONE ; GAME SELECT / OPTIONS
	dw OBJLstHdrA_Title_CursorR, OBJLSTPTR_NONE
	dw OBJLstHdrA_Title_SNKCopyright, OBJLSTPTR_NONE
	dw OBJLstHdrA_Title_CursorU, OBJLSTPTR_NONE
	dw OBJLSTPTR_NONE
		
OBJLstHdrA_Title_PushStart:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $09 ; OBJ Count
	;    Y   X  ID+FLAG
	db $34,$00,$10 ; $00
	db $34,$08,$18 ; $01
	db $34,$10,$14 ; $02
	db $34,$18,$06 ; $03
	db $34,$28,$14 ; $04
	db $34,$30,$16 ; $05
	db $34,$38,$00 ; $06
	db $34,$40,$12 ; $07
	db $34,$48,$16 ; $08
		
OBJLstHdrA_Title_Menu:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $0F ; OBJ Count
	;    Y   X  ID+FLAG
	db $38,$00,$0E ; $00
	db $38,$08,$10 ; $01
	db $38,$10,$16 ; $02
	db $38,$18,$08 ; $03
	db $38,$20,$0E ; $04
	db $38,$28,$0C ; $05
	db $30,$00,$04 ; $06
	db $30,$08,$00 ; $07
	db $30,$10,$0A ; $08
	db $30,$18,$02 ; $09
	db $30,$28,$14 ; $0A
	db $30,$30,$16 ; $0B
	db $30,$38,$00 ; $0C
	db $30,$40,$12 ; $0D
	db $30,$48,$16 ; $0E
		
OBJLstHdrA_Title_CursorR:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F6,$1A ; $00
		
OBJLstHdrA_Title_CursorU:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $01 ; OBJ Count
	;    Y   X  ID+FLAG
	db $30,$F8,$1C ; $00
		
OBJLstHdrA_Title_SNKCopyright:
	db OLF_NOBUF ; iOBJLstHdrA_Flags
	db COLIBOX_00 ; iOBJLstHdrA_ColiBoxId
	db $00 ; iOBJLstHdrA_HitboxId
	db $FF,$FF,$FF ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw .bin ; iOBJLstHdrA_DataPtr
	db $00 ; iOBJLstHdrA_YOffset
.bin:
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $48,$00,$1E ; $00
	db $48,$08,$20 ; $01
	db $48,$10,$22 ; $02
	db $48,$18,$24 ; $03
	db $48,$20,$26 ; $04
	db $48,$28,$28 ; $05
		
