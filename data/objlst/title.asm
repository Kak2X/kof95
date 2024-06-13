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
IF VER_EN
; "PRESS START"
	db $0A ; OBJ Count
	;    Y   X  ID+FLAG
	db $34,$FC,$10 ; $00
	db $34,$04,$12 ; $01
	db $34,$0C,$02 ; $02
	db $34,$14,$14 ; $03
	db $34,$1C,$14 ; $04
	db $34,$2C,$14 ; $05
	db $34,$34,$16 ; $06
	db $34,$3C,$00 ; $07
	db $34,$44,$12 ; $08
	db $34,$4C,$16 ; $09
ELSE
; "PUSH START"
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
ENDC
		
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
IF VER_US
; "(C) SNK 1995" (lowered)
; "LICENSED TO NINTENDO"
	db $10 ; OBJ Count
	;    Y   X  ID+FLAG
	db $50,$00,$1E ; $00
	db $50,$08,$20 ; $01
	db $50,$10,$22 ; $02
	db $50,$18,$24 ; $03
	db $50,$20,$26 ; $04
	db $50,$28,$28 ; $05
	db $60,$00,$2A ; $06
	db $60,$08,$2C ; $07
	db $60,$10,$2E ; $08
	db $60,$18,$30 ; $09
	db $60,$20,$32 ; $0A
	db $60,$28,$34 ; $0B
	db $60,$30,$36 ; $0C
	db $60,$38,$38 ; $0D
	db $60,$40,$3A ; $0E
	db $60,$48,$3C ; $0F
ELIF VER_EN
; "(C) SNK 1995"
; "LICENSED BY NINTENDO"
	db $10 ; OBJ Count
	;    Y   X  ID+FLAG
	db $48,$00,$1E ; $00
	db $48,$08,$20 ; $01
	db $48,$10,$22 ; $02
	db $48,$18,$24 ; $03
	db $48,$20,$26 ; $04
	db $48,$28,$28 ; $05
	db $60,$00,$2A ; $06
	db $60,$08,$2C ; $07
	db $60,$10,$2E ; $08
	db $60,$18,$30 ; $09
	db $60,$20,$32 ; $0A
	db $60,$28,$34 ; $0B
	db $60,$30,$36 ; $0C
	db $60,$38,$38 ; $0D
	db $60,$40,$3A ; $0E
	db $60,$48,$3C ; $0F
ELSE
; "(C) SNK 1995"
	db $06 ; OBJ Count
	;    Y   X  ID+FLAG
	db $48,$00,$1E ; $00
	db $48,$08,$20 ; $01
	db $48,$10,$22 ; $02
	db $48,$18,$24 ; $03
	db $48,$20,$26 ; $04
	db $48,$28,$28 ; $05
ENDC	
