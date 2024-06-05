INCLUDE "data/objlst/char/billy.asm"
INCLUDE "data/objlst/char/saisyu.asm"
INCLUDE "data/objlst/char/rugal.asm"
INCLUDE "data/objlst/char/nakoruru.asm"

; 
; =============== START OF MODULE Win/Cutscene ===============
;
		
GFXDef_Cutscene_Font_Epilogue: mGfxDef "data/gfx/cutscene_font_epilogue.bin"

PUSHC
SETCHARMAP epilogue

Text_CutsceneEpilogue0:
	db "こうして、       "
	db "            "
	db "みごとルガールをたおし、"
Text_CutsceneEpilogue1:
	db "キングオブファイターズ95に"
	db "              "
	db "ゆうしようした・・・。   "
Text_CutsceneEpilogue2:
	db "そして、"
Text_CutsceneEpilogue3:
	db "あらたなるもくてきにむかって"
	db "              "
	db "あるきだしていった・・・。 "
Text_CutsceneEpilogue4:
	db "ときにせいれき1995年のこと "
	db "                "
	db "であった・・・。        "
POPC

; =============== SubModule_CutsceneEpilogue ===============
; This submodule handles the text dump after the Rugal defeat cutscene.
SubModule_CutsceneEpilogue:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Not necessary
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; [BUG] This doesn't reload SGB palettes, causing a gray square to show up.
	;ld   de, SCRPAL_INTRO
	;call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the cutscene font
	ld   hl, GFXDef_Cutscene_Font_Epilogue
	ld   de, $9000
	call CopyTilesAutoNum
	
	; Delete all sprite mappings
	call ClearOBJInfo
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start ending cutscene music
	ld   a, BGM_ENDING
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; Text 0
	ld   de, Text_CutsceneEpilogue0
	ld   hl, $98E1
	ld   b, $0C
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene0A_PostTextWrite
	call Cutscene0A_ClearText
	
	; Text 1
	ld   de, Text_CutsceneEpilogue1
	ld   hl, $98E1
	ld   b, $0E
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene0A_PostTextWrite
	call Cutscene0A_ClearText
	
	; Text 2
	ld   de, Text_CutsceneEpilogue2
	ld   hl, $98E1
	ld   b, $04
	ld   c, $01
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene0A_PostTextWrite
	call Cutscene0A_ClearText
	
	; Text 3
	ld   de, Text_CutsceneEpilogue3
	ld   hl, $98E1
	ld   b, $0E
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene0A_PostTextWrite
	call Cutscene0A_ClearText
	
	; Text 4
	ld   de, Text_CutsceneEpilogue4
	ld   hl, $98E1
	ld   b, $10
	ld   c, $03
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene0A_PostTextWrite
	
	; Delay 5 frames
	ld   b, $05
.eLoop:
	call Task_PassControl_Delay3B
	dec  b
	jp   nz, .eLoop
	
	; End
	jp   Cutscene0A_ClearText
	
; =============== SubModule_Credits ===============
; Displays the credits, shared across all difficulties.
SubModule_Credits:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; We're not in gameplay
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; [BUG] This doesn't reload SGB palettes, causing a gray square to show up.
	;ld   de, SCRPAL_INTRO
	;call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the standard font
	call LoadGFX_1bppFont_Default
	
	; Delete all sprite mappings, if any
	call ClearOBJInfo
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start credits music
	ld   a, BGM_CREDITS
	call HomeCall_Sound_ReqPlayExId_Stub
	
.showText:
	;
	; Print all screens of text in one go.
	; When all text for a screen is printed, wait for a bit before continuing.
	;
	
	; 0
	ld   hl, TextDef_Credits0_0
	call TextPrinter_Instant
	call Task_PassControl_Delay3B
	call ClearBGMap
	
	; 1
	ld   hl, TextDef_Credits1_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits1_1
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 2
	ld   hl, TextDef_Credits2_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits2_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits2_2
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	
	; 3
	call ClearBGMap
	ld   hl, TextDef_Credits3_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits3_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits3_2
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 4
	ld   hl, TextDef_Credits4_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits4_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits4_2
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 5
	ld   hl, TextDef_Credits5_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits5_1
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 6
	ld   hl, TextDef_Credits6_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits6_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits6_2
	call TextPrinter_Instant
	ld   hl, TextDef_Credits6_3
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 7
	ld   hl, TextDef_Credits7_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits7_1
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 8
	ld   hl, TextDef_Credits8_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits8_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits8_2
	call TextPrinter_Instant
	ld   hl, TextDef_Credits8_3
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; 9
	ld   hl, TextDef_Credits9_0
	call TextPrinter_Instant
	ld   hl, TextDef_Credits9_1
	call TextPrinter_Instant
	ld   hl, TextDef_Credits9_2
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; A
	ld   hl, TextDef_CreditsA_0
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_1
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_2
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_3
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_4
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_5
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsA_6
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; B
	ld   hl, TextDef_CreditsB_0
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_1
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_2
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_3
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_4
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_5
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_6
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_7
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_8
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_9
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_A
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_B
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsB_C
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; C
	ld   hl, TextDef_CreditsC_0
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsC_1
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; D
	ld   hl, TextDef_CreditsD_0
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsD_1
	call TextPrinter_Instant
	ld   hl, TextDef_CreditsD_2
	call TextPrinter_Instant
REPT 4
	call Task_PassControl_Delay3B
ENDR
	call ClearBGMap
	
	; E
	ld   hl, TextDef_CreditsE_0
	call TextPrinter_Instant
	
	; Wait 590 frames before returning
	ld   b, $0A
.loop:
	call Task_PassControl_Delay3B
	dec  b
	jp   nz, .loop
	call ClearBGMap
	
	ret
	
; =============== SubModule_TheEnd ===============
; Displays "THE END" on the screen.
SubModule_TheEnd:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; We're not in gameplay
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; ==============================
	
	; Load the standard font
	call LoadGFX_1bppFont_Default
	
	; Delete all sprite mappings
	call ClearOBJInfo
	
	; Disable sectors
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set actual DMG pals
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; THE END
	ld   hl, TextDef_TheEnd
	call TextPrinter_Instant
	
	; Stop all sound
	ld   a, SND_MUTE
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; Wait 590 frames before returning
	ld   b, $0A
.loop:
	call Task_PassControl_Delay3B
	dec  b
	jp   nz, .loop
	
	jp   ClearBGMap
	
; =============== Cutscene0A_ClearText ===============
; Blank out any existing text.
Cutscene0A_ClearText:
	; Clear all 4 rows
	ld   hl, BGMap_Begin+$00E0 ; BG Ptr
	ld   b, $18	; Rect Width
	ld   c, $04 ; Rect Height
	ld   d, $00 ; Tile ID
	jp   FillBGRect
	
; =============== Cutscene0A_PostTextWrite ===============
; Shared code executed after text finishes writing for a cutscene.
; This delays the cutscene from continuing, until the timer elapses or START is pressed.
; IN
; - B: Max number of frames to wait
; OUT
; - C flag: If set, it was aborted early
Cutscene0A_PostTextWrite:
	; Check early abort
	call Cutscene0A_IsStartPressed	; Did anyone press START?
	ret  c							; If so, return
.contWait:
	call Task_PassControl_NoDelay	; Wait frame
	dec  b							; Are we done?
	jp   nz, Cutscene0A_PostTextWrite	; If not, loop
.end:
	xor  a	; C flag clear
	ret

; =============== Cutscene0A_IsStartPressed ===============
; Checks if any player pressed START.
; Similar to Win_IsStartPressed, but with an useless player branch.
; OUT
; - C flag: If set, someone did
Cutscene0A_IsStartPressed:
	; If any player presses START, return set
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a
	jp   nz, .abort1P
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a
	jp   nz, .abort2P
	; Otherwise, return clear
	xor  a
	ret
.abort1P:
	scf
	ret
.abort2P:
	scf
	ret
TextDef_Credits0_0:
	dw $9906
	mTxtDef "-STAFF-"
TextDef_Credits1_0:
	dw $98C0
	mTxtDef "-EXECTIVE PRODUCER-"
TextDef_Credits1_1:
	dw $9943
	mTxtDef "NOBUYUKI OKUDE"
TextDef_Credits2_0:
	dw $98A4
	mTxtDef "-PRODUCER-"
TextDef_Credits2_1:
	dw $9902
	mTxtDef "TAKAYUKI NAKANO"
TextDef_Credits2_2:
	dw $9965
	mTxtDef "T.ISHIGAI"
TextDef_Credits3_0:
	dw $98C4
	mTxtDef "-DIRECTOR-"
TextDef_Credits3_1:
	dw $9921
	mTxtDef "HIROFUMI KASAKAWA"
TextDef_Credits3_2:
	dw $9983
	mTxtDef "AKIHIKO KIMURA"
TextDef_Credits4_0:
	dw $98C3
	mTxtDef "-ARRENGEMENT-"
TextDef_Credits4_1:
	dw $9926
	mTxtDef "T.M.95"
TextDef_Credits4_2:
	dw $9986
	mTxtDef "H.KOISO"
TextDef_Credits5_0:
	dw $98C4
	mTxtDef "-PROGRAMMER-"
TextDef_Credits5_1:
	dw $9926
	mTxtDef "H.KOISO"
TextDef_Credits6_0:
	dw $98A5
	mTxtDef "-DESIGNER-"
TextDef_Credits6_1:
	dw $9906
	mTxtDef "T.SAITOU"
TextDef_Credits6_2:
	dw $9946
	mTxtDef "TUYUKI"
TextDef_Credits6_3:
	dw $9986
	mTxtDef "MOMONGA"
TextDef_Credits7_0:
	dw $98C6
	mTxtDef "-SOUND-"
TextDef_Credits7_1:
	dw $9922
	mTxtDef "K.MIKUSA  ASPECT"
TextDef_Credits8_0:
	dw $98A1
	mTxtDef "-SUPER MARKETEER-"
TextDef_Credits8_1:
	dw $9901
	mTxtDef "TOSHIHIRO MORIOKA"
TextDef_Credits8_2:
	dw $9941
	mTxtDef "HIROSHI TAKEKAWA"
TextDef_Credits8_3:
	dw $9982
	mTxtDef "KATUYA TORIHAMA"
TextDef_Credits9_0:
	dw $98C2
	mTxtDef "-ARTWORK DESIGN-"
TextDef_Credits9_1:
	dw $9923
	mTxtDef "DESIGN OFFICE"
TextDef_Credits9_2:
	dw $9943
	mTxtDef "SPACE LAP INC."
TextDef_CreditsA_0:
	dw $9862
	mTxtDef "-SPECIAL THANKS-"
TextDef_CreditsA_1:
	dw $98C4
	mTxtDef "KATSUTOSHI.H"
TextDef_CreditsA_2:
	dw $98E7
	mTxtDef "NGSW.A"
TextDef_CreditsA_3:
	dw $9905
	mTxtDef "DASHIMADAH"
TextDef_CreditsA_4:
	dw $9945
	mTxtDef "SAMARAKI.Y"
TextDef_CreditsA_5:
	dw $9965
	mTxtDef "MATUNOO.H"
TextDef_CreditsA_6:
	dw $9985
	mTxtDef "J.KAWAURA"
TextDef_CreditsB_0:
	dw $9822
	mTxtDef "-SPECIAL THANKS-"
TextDef_CreditsB_1:
	dw $9883
	mTxtDef "SATOSHI KUMADA"
TextDef_CreditsB_2:
	dw $98A3
	mTxtDef "HIDEHITO NAGOYA"
TextDef_CreditsB_3:
	dw $98C4
	mTxtDef "TETSUYA IIDA"
TextDef_CreditsB_4:
	dw $9904
	mTxtDef "TATSUYA HOCHO"
TextDef_CreditsB_5:
	dw $9923
	mTxtDef "SHUNICHI OHKUSA"
TextDef_CreditsB_6:
	dw $9943
	mTxtDef "TAKESHI IKENOUE"
TextDef_CreditsB_7:
	dw $9963
	mTxtDef "NAOYUKI TAKADA"
TextDef_CreditsB_8:
	dw $9985
	mTxtDef "SATOSHI H"
TextDef_CreditsB_9:
	dw $99A2
	mTxtDef "NORIHIRO HAYASAKA"
TextDef_CreditsB_A:
	dw $99C3
	mTxtDef "MITSUNORI SHOJI"
TextDef_CreditsB_B:
	dw $99E3
	mTxtDef "FUMIHIKO OZAWA"
TextDef_CreditsB_C:
	dw $9A02
	mTxtDef "MUTSUMI NAKAMURA"
TextDef_CreditsC_0:
	dw $98C3
	mTxtDef "SPECIAL THANKS"
TextDef_CreditsC_1:
	dw $9923
	mTxtDef "SNK ALL STAFF"
TextDef_CreditsD_0:
	dw $98E5
	mTxtDef "PRESENTED"
TextDef_CreditsD_1:
	dw $9948
	mTxtDef "BY"
TextDef_CreditsD_2:
	dw $9986
	mTxtDef "TAKARA"
TextDef_CreditsE_0:
	dw $9903
	mTxtDef "YOU ARE NO.1!"
TextDef_TheEnd:
	dw $9906
	mTxtDef "THE  END"

; 
; =============== END OF MODULE Win/Cutscene ===============
;

; =============== END OF BANK ===============
; Junk area below.
	mIncJunk "L0A7D99"