; 
; =============== START OF MODULE Intro ===============
;

GFXDef_Intro_Letter:
	db $34 ; Number of tiles
GFX_Intro_Letter: INCBIN "data/gfx/intro_letter.bin"
BG_Intro_Letter: INCBIN "data/bg/intro_letter.bin"	
GFXDef_Intro_Font:
	db $3A ; Number of tiles
GFX_Intro_Font: INCBIN "data/gfx/intro_font.bin"

PUSHC
SETCHARMAP intro
Text_Intro0:
	db "1995年。"
	db "      "
Text_Intro1:
	db "KING OF FIGHTERS"
	db "                "
	db "を開催する。         "
	db "                 "
Text_Intro2:
	db "対戦方式は前回同様   "
	db "            "
	db "チ-ム対戦にてとり行う。"
	db "            "
Text_Intro3:
	db "前大会参加者の再参加を "
	db "            "
	db "心待ちにしている。   "
	db "            "
Text_Intro4:
	db "以上・・・・・・・[<R>]"
	db "            "
POPC

GFXDef_IntroBG0: 
	db $80 ; Number of tiles
GFX_IntroBG0: INCBIN "data/gfx/intro_bg0.bin"
GFXDef_IntroBG1:
	db $34 ; Number of tiles
GFX_IntroBG1: INCBIN "data/gfx/intro_bg1.bin"
BG_Intro_Sun: INCBIN "data/bg/intro_sun.bin"
BG_Intro_Moon: INCBIN "data/bg/intro_moon.bin"
BG_Intro_Logo: INCBIN "data/bg/intro_logo.bin"
GFXDef_IntroOBJ: 
	db $6A ; Number of tiles
GFX_IntroOBJ: INCBIN "data/gfx/intro_obj.bin"

; =============== Module_Intro ===============
; EntryPoint for Intro.
;
; The intro is made of two parts:
; - Letter + Text Writer
; - Character Scenes
;
; The parts are mostly independent of each other, but the palette and music
; are only set in the first one.
Module_Intro:
	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	ld   hl, wMisc_C028			; Use normal scrolling
	res  MISCB_USE_SECT, [hl]
	
	; Reset DMG Pal & vars
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ld   [wIntroScene], a
	
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Reset screen & coords
	call ClearBGMap
	call ClearWINDOWMap
	
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	
	; Load VRAM for the intro text
	ld   hl, GFXDef_Intro_Letter
	ld   de, $9000
	call CopyTilesAutoNum
	ld   hl, GFXDef_Intro_Font
	ld   de, $9400
	call CopyTilesAutoNum
	ld   de, BG_Intro_Letter
	ld   hl, $9885
	ld   b, $0A
	ld   c, $06
	call CopyBGToRect
	
	;--
	; [TCRF] Two slots are initialized with otherwise unused sprite mappings tables, but are hidden.
	call ClearOBJInfo
	ld   hl, wOBJInfo_IntroKyo
	ld   de, OBJInfoInit_Intro_Unused
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]

	ld   hl, wOBJInfo_IntroIori
	ld   de, OBJInfoInit_Intro_Unused
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	;--
		
	; Hide WINDOW
	ld   a, $90
	ldh  [rWY], a
	ld   a, $07
	ldh  [rWX], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	ei   
	
	; Wait $3C frames
	ld   b, $3C
.wait0:
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .wait0
	
	
	; Set DMG pal
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Just in case?
	xor  a
	ld   [wIntroActPtr_High], a
	ld   [wIntroActPtr_Low], a
	
	;--
	; Wait 60 frames
	ld   bc, 60
	call Intro_Delay
	jp   c, .end
	
	; Play Intro BGM
	ld   a, BGM_INTRO
	call HomeCall_Sound_ReqPlayExId_Stub
	call Task_PassControl_NoDelay
	
	; Wait 30 frames
	ld   bc, $001E
	call Intro_Delay
	jp   c, .end
	
	;---
	
	; Write the first screen of text
	ld   de, Text_Intro0	; Text
	ld   hl, $9987		; Destination
	ld   a, $06			; Letter delay
	ld   b, $06			; Width
	ld   c, $02			; Height
	call TextPrinter_MultiFrame_WithAbort
	jp   c, .end
	
	; Wait 25 frames
	ld   bc, $0019
	call Intro_Delay
	jp   c, .end
	
	; Wipe the previously written text
	ld   hl, $9987
	ld   b, $06
	ld   c, $02
	ld   d, $40
	call FillBGRect
	call Task_PassControl_NoDelay
	
	;--
	
	ld   de, Text_Intro1
	ld   hl, $9982
	ld   a, $04
	ld   b, $10
	ld   c, $04
	call TextPrinter_MultiFrame_WithAbort
	jp   c, .end
	
	ld   bc, $0019
	call Intro_Delay
	jp   c, .end
	
	ld   hl, $9982
	ld   b, $10
	ld   c, $04
	ld   d, $40
	call FillBGRect
	call Task_PassControl_NoDelay
	
	;--
	
	ld   de, Text_Intro2
	ld   hl, $9984
	ld   a, $04
	ld   b, $0C
	ld   c, $04
	call TextPrinter_MultiFrame_WithAbort
	jp   c, .end
	
	ld   bc, $0019
	call Intro_Delay
	jp   c, .end
	
	ld   hl, $9984
	ld   b, $0C
	ld   c, $04
	ld   d, $40
	call FillBGRect
	call Task_PassControl_NoDelay
	
	;--
	
	ld   de, Text_Intro3
	ld   hl, $9984
	ld   a, $04
	ld   b, $0C
	ld   c, $04
	call TextPrinter_MultiFrame_WithAbort
	jp   c, .end
	
	ld   bc, $0019
	call Intro_Delay
	jp   c, .end
	
	ld   hl, $9984
	ld   b, $0C
	ld   c, $04
	ld   d, $40
	call FillBGRect
	call Task_PassControl_NoDelay
	
	;--
	
	ld   de, Text_Intro4
	ld   hl, $9984
	ld   a, $04
	ld   b, $0C
	ld   c, $02
	call TextPrinter_MultiFrame_WithAbort
	jp   c, .end
	
	ld   bc, $003C
	call Intro_Delay
	jp   c, .end
	
	; Made it through without ending it early
	call Task_PassControl_NoDelay
	jp   SubModule_Intro_Chars
.end:
	; Intro cut off short, skip to the title screen
	call Task_PassControl_NoDelay
	ld   b, BANK(Module_Title) ; BANK $1E
	ld   hl, Module_Title
	jp   FarJump
	
; =============== Intro_Delay ===============
; Pauses/delays the cutscene for the specified amount of frames.
; Pressing START will cut the wait short and signal it out the caller.
; In practice, it's always used to end the intro early if START is pressed.
; IN
; - A: Frames to wait
; OUT
; - C flag: If set, START is pressed on any controller.
Intro_Delay:
	call Task_PassControl_NoDelay
	call Intro_Base_IsStartPressed	; Pressed START?
	jp   c, .pressed				; If so, return
	dec  bc
	ld   a, b
	or   a, c
	jr   nz, Intro_Delay
.not:
	xor  a		; clear C flag
	ret  
.pressed:
	scf  		; set C flag
	ret  
; =============== Intro_Base_IsStartPressed ===============
; Checks if START is pressed on any controller.
; OUT
; - C flag: If set, START is pressed on any controller.
Intro_Base_IsStartPressed:
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a		; Pressed START on controller 1?
	jp   nz, .pressed1P		; If so, jump
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a		; Pressed START on controller 1?
	jp   nz, .pressed2P		; If so, jump
.not:
	xor  a	; clear C flag
	ret
.pressed1P:
	;--
	; [POI] This sets the active side to whoever pressed START,
	;       which is completely useless here. 
	;       Removed in 96.
	ld   a, PL1
	ld   [wIntro_Unused_JoyActivePl], a
	;--
	scf		; set C flag 
	ret  
.pressed2P:
	ld   a, PL2
	ld   [wIntro_Unused_JoyActivePl], a
	scf		; set C flag 
	ret
	
OBJInfoInit_Intro_Unused:
	db OST_VISIBLE ; iOBJInfo_Status
	db $00 ; iOBJInfo_OBJLstFlags
	db $00 ; iOBJInfo_OBJLstFlagsView
	db $28 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db $40 ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $00 ; iOBJInfo_TileIDBase
	db LOW($8000) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8000) ; iOBJInfo_VRAMPtr_High
	db BANK(OBJLstPtrTable_Intro_Unused) ; iOBJInfo_BankNum (BANK $1C)
	db LOW(OBJLstPtrTable_Intro_Unused) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Intro_Unused) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNumView
	db LOW(OBJLstPtrTable_Intro_Unused) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_Intro_Unused) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High

INCLUDE "data/objlst/intro_unused.asm"

; =============== SubModule_Intro_Chars ===============
; This handles the scene with scrolling Kyo and Iori.
SubModule_Intro_Chars:
	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	
	; Blank screen while this is happening
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ld   [wIntroScene], a
	call ClearBGMap
	call ClearWINDOWMap
	
	; Set initial scrolling
	xor  a
	ldh  [hScrollY], a
	; Kyo scrolls in from the right, so put the "sprite viewport" on the left.
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	; The background will display a sun slowly scrolling from right to left.
	ld   a, $2C
	ldh  [hScrollX], a
	
	;
	; Load VRAM for scene
	;
	ld   hl, GFXDef_IntroOBJ	; Kyo/Iori sprites
	ld   de, $8000
	call CopyTilesAutoNum
	ld   hl, GFXDef_IntroBG0	; Backgrounds, logo
	ld   de, $9000
	call CopyTilesAutoNum
	ld   hl, GFXDef_IntroBG1	; Second part of logo
	ld   de, $8800
	call CopyTilesAutoNum
	
	ld   de, BG_Intro_Sun		; Kyo BG on the top
	ld   hl, $9800
	ld   b, $20
	ld   c, $10
	call CopyBGToRect
	ld   de, BG_Intro_Moon		; Iori BG on the bottom
	ld   hl, $9A00
	ld   b, $20
	ld   c, $10
	call CopyBGToRect
	ld   de, BG_Intro_Logo		; Logo on the WINDOW
	ld   hl, $9C00
	ld   b, $14
	ld   c, $12
	call CopyBGToRect
	
	;
	; Load the large Kyo and Iori sprites
	;
	call ClearOBJInfo
	
	;
	; OBJ0 - Kyo sprite (visible)
	;
	ld   hl, wOBJInfo_IntroKyo
	ld   de, OBJInfoInit_Intro_Char
	call OBJLstS_InitFrom
	; Off-screen to the right
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_X
	ld   [hl], $B8
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_XSub
	ld   [hl], $80
	; Aligned with the bottom background
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Y
	ld   [hl], $30
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], INTRO_OBJ_KYO*OBJLSTPTR_ENTRYSIZE
	
	;
	; OBJ1 - Iori's sprite, hidden for now
	;
	ld   hl, wOBJInfo_IntroIori
	ld   de, OBJInfoInit_Intro_Char
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	; Off-screen to the left
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_X
	ld   [hl], $40
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Y
	ld   [hl], $30
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], INTRO_OBJ_IORI*OBJLSTPTR_ENTRYSIZE
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_TileIDBase
	ld   [hl], $3C
	
	; Hide the logo
	ld   a, $90
	ldh  [rWY], a
	ld   a, $07
	ldh  [rWX], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	
	; Set DMG pal
	ld   a, $8C
	ldh  [rOBP0], a
	ld   a, $4C
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Start with Kyo's scene code
	ld   hl, IntroAct_KyoMvLeft
	ld   a, h
	ld   [wIntroActPtr_High], a
	ld   a, l
	ld   [wIntroActPtr_Low], a
	xor  a
	ld   [wIntroActTimer], a
	
.mainLoop:
	;
	; Main loop of the intro.
	; It is similar to how 96 handles it... in theory.
	; In practice, there's only one scene (making the purpose of Intro_ExecScene dubious),
	; which executes the code wIntroActPtr points to.
	;
	
	call Intro_ExecScene
	call Task_PassControl_NoDelay
	jp   .mainLoop
	
; =============== Intro_ExecScene ===============
; DynJump with a table containing only one entry.
Intro_ExecScene:
	ld   hl, .sceneTbl
	ld   d, $00		; DE = wIntroScene
	ld   a, [wIntroScene]
	ld   e, a
	add  hl, de		; Offset it
	ld   e, [hl]	; Read out ptr to DE
	inc  hl
	ld   d, [hl]
	push de			; Move it to HL and jump there
	pop  hl
	jp   hl
.sceneTbl:
	dw IntroScene_ExecCustom
	
; =============== IntroScene_ExecCustom ===============
; Jumps to a function pointer and allows to end the intro early by pressing START at any point.
IntroScene_ExecCustom:
	; Check for input
	call IntroChars_IsStartPressed	; Did we abort prematurely?
	jp   c, .end					; If so, end the intro.
	; Execute the scene
	call .exec						; Is the intro over?
	jp   c, .end					; If so, we're done
	ret  
.end:
	;--
	; Useless loop
	ld   b, $01
.waitEnd:
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .waitEnd
	;--
	jp   Intro_SwitchToTitle
	
; =============== .exec ===============
; Executes the actual code for the act.
; Every act uses these parameters:
; OUT
; - C flag: If set, the intro has ended
.exec:
	ld   a, [wIntroActPtr_High]
	ld   h, a
	ld   a, [wIntroActPtr_Low]
	ld   l, a
	jp   hl
	
; =============== IntroAct_KyoMvLeft ===============
; ACT 0	
; Kyo (OBJ) and a sun (BG) will scroll in from the right.
IntroAct_KyoMvLeft:
	
	; 
	; Move the sun left at 0.5px/frame.
	; This scrolls the viewport right until it reaches X pos $80.
	;
	xor  a
	ld   hl, hScrollX
	ld   a, [hl]
	cp   $80			; Reached the target already? (hScrollX >= $80)
	jp   nc, .mvObj		; If so, skip
	
	ld   hl, hScrollX	; DE = hScrollX
	ld   d, [hl]
	inc  hl
	ld   e, [hl]
	
	push de				; DE += 0.5px
	pop  hl
	ld   bc, +$0080
	add  hl, bc
	push hl
	pop  de
	
	ld   hl, hScrollX	; hScrollX = DE
	ld   [hl], d
	inc  hl
	ld   [hl], e
	
.mvObj:
	; 
	; Move Kyo left at 1px/frame, until it reaches X pos $10.
	;
	xor  a
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_X
	ld   a, [hl]
	cp   $10							; Reached the target already? (iOBJInfo_X < $10)
	jp   c, .chkWait					; If so, skip
	
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_X	; DE = iOBJInfo_X
	ld   d, [hl]
	inc  hl
	ld   e, [hl]
	
	push de								; DE -= 1px
	pop  hl
	ld   bc, -$0100
	add  hl, bc
	push hl
	pop  de
	
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_X	; iOBJInfo_X = DE
	ld   [hl], d
	inc  hl
	ld   [hl], e
	
	xor  a
	ret  
	
.chkWait:
	;
	; Next scene after 80 frames
	;
	call Task_PassControl_NoDelay
	ld   a, [wIntroActTimer]		; Timer++
	inc  a
	ld   [wIntroActTimer], a
	cp   $50						; Timer == $50?
	jr   z, .next					; If so, jump
.notYet:
	xor  a
	ret  
.next:
	ld   hl, IntroAct_IoriMvRightInit
	ld   a, h
	ld   [wIntroActPtr_High], a
	ld   a, l
	ld   [wIntroActPtr_Low], a
	xor  a
	ret  
	
; =============== IntroAct_IoriMvRightInit ===============
; ACT 1	
; Initializes the next scene.
IntroAct_IoriMvRightInit:
	; Next scene
	ld   hl, IntroAct_IoriMvRight
	ld   a, h
	ld   [wIntroActPtr_High], a
	ld   a, l
	ld   [wIntroActPtr_Low], a
	; Reset timer
	xor  a
	ld   [wIntroActTimer], a
	
	; Hide Kyo
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Show Iori
	ld   a, OST_VISIBLE
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	xor  a, [hl]	; By toggling the visibility state for some reason
	ld   [hl], a
	
	; Put Iori off-screen to the left
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_X
	ld   [hl], -$40
	
	; And the moon barely on-screen to the left
	ld   a, $80
	ldh  [hScrollY], a
	ld   a, $30
	ldh  [hScrollX], a
	
	xor  a
	ret  
	
; =============== IntroAct_IoriMvRight ===============
; ACT 2	
; Iori (OBJ) and a moon (BG) will scroll in from the left.
IntroAct_IoriMvRight:

	;
	; Next scene after 135 frames
	;
	ld   a, [wIntroActTimer]
	cp   $87				; Timer == $50?
	jp   z, .next			; If so, jump
	inc  a					; Timer++
	ld   [wIntroActTimer], a
	
	;--
	; 
	; Move the moon right at 0.5px/frame with no upper bound.
	;
	ld   hl, hScrollX		; DE = hScrollX
	ld   d, [hl]
	inc  hl
	ld   e, [hl]
	
	push de					; DE -= 0.5px
	pop  hl
	ld   bc, -$0080
	add  hl, bc
	push hl
	pop  de
	
	ld   hl, hScrollX		; hScrollX = DE
	ld   [hl], d
	inc  hl
	ld   [hl], e
	
	;--
	; 
	; Move Iori right at 1px/frame with no upper bound.
	;
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_X	; DE = iOBJInfo_X
	ld   d, [hl]
	inc  hl
	ld   e, [hl]
	
	push de					; DE += 1px
	pop  hl
	ld   bc, +$0100
	add  hl, bc
	push hl
	pop  de
	
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_X	; iOBJInfo_X = DE
	ld   [hl], d
	inc  hl
	ld   [hl], e
	;--
	
	xor  a
	ret  
	
.next:
	ld   hl, IntroAct_IoriWait
	ld   a, h
	ld   [wIntroActPtr_High], a
	ld   a, l
	ld   [wIntroActPtr_Low], a
	xor  a
	ld   [wIntroActTimer], a
	ret 
	
; =============== IntroAct_IoriWait ===============
; ACT 3
; Delays the scene for 50 frames.
IntroAct_IoriWait:
	call Task_PassControl_NoDelay
	ld   a, [wIntroActTimer]
	inc  a
	ld   [wIntroActTimer], a
	cp   $32
	jr   z, .next
	xor  a
	ret  
.next:
	ld   hl, IntroAct_Logo
	ld   a, h
	ld   [wIntroActPtr_High], a
	ld   a, l
	ld   [wIntroActPtr_Low], a
	; Reset the three subscene timers
	xor  a
	ld   [wIntroActTimer], a
	ld   [wIntroIoriLogoTimer], a
	ld   [wIntroLogoOnlyTimer], a
	ret  
; =============== IntroAct_Logo ===============
; ACT 4
; Handles the part with the logo visible.
IntroAct_Logo:

	; Next subscene after 10 * 3 * 2 frames
	ld   a, [wIntroActTimer]
	cp   $0A
	jp   z, .ioriLogo
	inc  a
	ld   [wIntroActTimer], a

.kyoLogo:
	;
	; ACT 4.1
	; Kyo's finalized scene position and the KOF logo alternate every 3 frames.
	;
	
	; Delay 3
	call IntroChars_Delay
	jp   c, Intro_SwitchToTitle
	
	;
	; Show Kyo
	;
	
	; Hide WINDOW with logo
	ld   a, $FF
	ldh  [rWY], a
	
	; Hide Iori
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Show Kyo
	ld   a, OST_VISIBLE
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Status
	ld   [hl], a
	
	; Set final scene position
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_X
	ld   [hl], $10
	xor  a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	ld   a, $70
	ldh  [hScrollX], a
	
	; Delay 3
	call IntroChars_Delay
	jp   c, Intro_SwitchToTitle
	
	;
	; Show KOF logo
	;
	
	; Show WINDOW
	ld   a, $07
	ldh  [rWX], a
	xor  a
	ldh  [rWY], a
	
	; Hide Kyo
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret  
	
.ioriLogo:

	; Next subscene after 10 * 3 * 2 frames
	ld   a, [wIntroIoriLogoTimer]
	cp   $0A
	jp   z, IntroAct_LogoOnly
	inc  a
	ld   [wIntroIoriLogoTimer], a
	
	;
	; ACT 4.2
	; Iori's finalized scene position and the KOF logo alternate every 3 frames.
	;
	
	; Delay 3
	call IntroChars_Delay
	jp   c, Intro_SwitchToTitle
	
	;
	; Show Iori
	;
	
	; Hide WINDOW with logo
	ld   a, $FF
	ldh  [rWY], a
	
	; Hide Kyo
	ld   hl, wOBJInfo_IntroKyo+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Show Iori
	ld   a, OST_VISIBLE
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	ld   [hl], a
	
	; Set final scene position
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_X
	ld   [hl], $48
	xor  a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	ld   a, $80
	ldh  [hScrollY], a
	ld   a, $F0
	ldh  [hScrollX], a
	
	; Delay 3
	call IntroChars_Delay
	jp   c, Intro_SwitchToTitle
	
	;
	; Show KOF logo
	;
	
	; Show WINDOW with logo
	ld   a, $07
	ldh  [rWX], a
	xor  a
	ldh  [rWY], a
	
	; Hide Iori
	ld   hl, wOBJInfo_IntroIori+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	ret
	
Intro_SwitchToTitle:
	ld   b, BANK(Module_Title) ; BANK $1E
	ld   hl, Module_Title
	jp   FarJump
	
IntroAct_LogoOnly:
	;
	; ACT 4.3
	; Only the KOF logo is different.
	;
	
	; Show the logo for 80 frames before signaling out the intro's over.
	ld   a, [wIntroLogoOnlyTimer]
	cp   $50
	jp   z, .end
	inc  a
	ld   [wIntroLogoOnlyTimer], a
.notEnd:
	xor  a
	ret  
.end:
	scf  
	ret  
	
; =============== IntroChars_Delay ===============
; Identical to Intro_Delay, except it waits for an hardcoded amount of 3 frames.
; OUT
; - C flag: If set, START is pressed on any controller.
IntroChars_Delay:
	ld   bc, $0003					; Frames to wait
.loop:
	call Task_PassControl_NoDelay
	call IntroChars_IsStartPressed	; Pressed START?
	jp   c, .pressed				; If so, return
	dec  bc
	ld   a, b
	or   a, c
	jr   nz, .loop
.not:
	xor  a		; clear C flag
	ret  
.pressed:
	scf  		; set C flag
	ret  
	
; =============== IntroChars_IsStartPressed ===============
; Identical to Intro_Base_IsStartPressed.
; Checks if START is pressed on any controller.
; OUT
; - C flag: If set, START is pressed on any controller.
IntroChars_IsStartPressed:
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a		; Pressed START on controller 1?
	jp   nz, .pressed1P		; If so, jump
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a		; Pressed START on controller 1?
	jp   nz, .pressed2P		; If so, jump
.not:
	xor  a	; clear C flag
	ret
.pressed1P:
	;--
	; [POI] This sets the active side to whoever pressed START,
	;       which is completely useless here. 
	;       Removed in 96.
	ld   a, PL1
	ld   [wIntro_Unused_JoyActivePl], a
	;--
	scf		; set C flag 
	ret  
.pressed2P:
	ld   a, PL2
	ld   [wIntro_Unused_JoyActivePl], a
	scf		; set C flag 
	ret

OBJInfoInit_Intro_Char:
	db OST_VISIBLE ; iOBJInfo_Status
	db $00 ; iOBJInfo_OBJLstFlags
	db $00 ; iOBJInfo_OBJLstFlagsView
	db $28 ; iOBJInfo_X
	db $00 ; iOBJInfo_XSub
	db $40 ; iOBJInfo_Y
	db $00 ; iOBJInfo_YSub
	db $00 ; iOBJInfo_SpeedX
	db $00 ; iOBJInfo_SpeedXSub
	db $00 ; iOBJInfo_SpeedY
	db $00 ; iOBJInfo_SpeedYSub
	db $00 ; iOBJInfo_RelX (auto)
	db $00 ; iOBJInfo_RelY (auto)
	db $00 ; iOBJInfo_TileIDBase
	db LOW($8000) ; iOBJInfo_VRAMPtr_Low
	db HIGH($8000) ; iOBJInfo_VRAMPtr_High
	db BANK(OBJLstPtrTable_Intro_Char) ; iOBJInfo_BankNum (BANK $1C)
	db LOW(OBJLstPtrTable_Intro_Char) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_Intro_Char) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNumView
	db LOW(OBJLstPtrTable_Intro_Char) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_Intro_Char) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High

INCLUDE "data/objlst/intro_char.asm"
		
; =============== Title_LoadVRAM ===============
; Loads tilemaps and GFX for the title screen.
; The menus load the 1bpp text over this, and reuse the cursor already loaded here.
Title_LoadVRAM:
	; Title screen & menu sprites
	ld   hl, GFXDef_TitleOBJ
	ld   de, $8000
	call CopyTilesAutoNum
	
	; Title screen logo GFX (2 parts)
	ld   hl, GFXDef_Title_Logo0
	ld   de, $9000				; Block 3
	call CopyTilesAutoNum
	
	ld   hl, GFXDef_Title_Logo1
	ld   de, $8800				; Block 2
	call CopyTilesAutoNum
	
	; KOF95 Title logo tilemap
	ld   de, BG_Title_Logo
	ld   hl, $9C00
	ld   b, $14
	ld   c, $0D
	call CopyBGToRect
	
	; BG layer for cloud parallax
	ld   de, BG_Title_Clouds
	ld   hl, $9800
	ld   b, $20
	ld   c, $04
	call CopyBGToRect
	ret  
	
; =============== Title_LoadVRAM_Mini ===============
; Loads the title screen GFX which were overwritten by the 1bpp font.
Title_LoadVRAM_Mini:
	; Title screen logo GFX (2nd part, at $9000)
	
	; This just uploads the entire first chunk of logo graphics
	ld   hl, GFXDef_Title_Logo0
	ld   de, $9000
	call CopyTilesHBlankAutoNum
	ret  
	
GFXDef_Title_Logo0: mGfxDef "data/gfx/title_logo0.bin"
GFXDef_Title_Logo1: mGfxDef "data/gfx/title_logo1.bin"
BG_Title_Logo: INCBIN "data/bg/title_logo.bin"
BG_Title_Clouds: INCBIN "data/bg/title_clouds.bin"
GFXDef_TitleOBJ: mGfxDef "data/gfx/title_obj.bin"

Play_ColiBoxTbl: 
	db $00,$00,$00,$00 ; $00
	db $00,$FC,$08,$10 ; $01
	db $F7,$00,$0D,$09 ; $02
	db $00,$00,$10,$10 ; $03
	db $00,$00,$10,$12 ; $04
	db $00,$00,$7F,$7F ; $05
	db $0D,$02,$10,$08 ; $06
	db $00,$04,$08,$08 ; $07
	db $00,$F8,$10,$18 ; $08
	db $00,$EE,$10,$20 ; $09
	db $00,$FC,$08,$08 ; $0A
	db $00,$FC,$06,$10 ; $0B
	db $00,$FC,$0A,$10 ; $0C
	db $00,$FC,$14,$14 ; $0D
	db $00,$00,$10,$7F ; $0E
	db $E1,$FC,$13,$08 ; $0F
	db $D4,$FC,$22,$08 ; $10
	db $CC,$FC,$28,$08 ; $11
	db $E2,$E1,$12,$11 ; $12
	db $FF,$FE,$13,$11 ; $13
	db $EA,$FC,$08,$0E ; $14
	db $F5,$F4,$0D,$10 ; $15
	db $F9,$F9,$19,$14 ; $16
	db $EB,$F9,$0A,$0A ; $17
	db $EC,$F9,$10,$11 ; $18
	db $F0,$FC,$0D,$09 ; $19
	db $10,$FC,$0D,$09 ; $1A
	db $00,$FF,$0C,$09 ; $1B
	db $E9,$FC,$0D,$09 ; $1C
	db $F1,$F4,$0D,$09 ; $1D
	db $F0,$00,$13,$11 ; $1E
	db $EF,$EC,$0F,$0D ; $1F
	db $E9,$F8,$0D,$12 ; $20
	db $02,$EE,$13,$0D ; $21
	db $F4,$F7,$0E,$16 ; $22
	db $E9,$F7,$0F,$12 ; $23
	db $EE,$00,$0E,$09 ; $24
	db $FE,$EC,$13,$0F ; $25
	db $F2,$FC,$0D,$0D ; $26
	db $EB,$FD,$0E,$13 ; $27
	db $FE,$FC,$14,$0E ; $28
	db $F0,$FC,$0D,$0F ; $29
	db $E1,$F7,$0D,$09 ; $2A
	db $EE,$F9,$0D,$09 ; $2B
	db $EE,$F7,$0D,$0D ; $2C
	db $FB,$F4,$13,$13 ; $2D
	db $FF,$F3,$18,$14 ; $2E
	db $F7,$03,$14,$0B ; $2F
	db $03,$02,$0E,$0A ; $30
	db $FE,$F8,$13,$11 ; $31
	db $EF,$F9,$0D,$15 ; $32
	db $00,$00,$11,$11 ; $33
	db $01,$FD,$12,$11 ; $34
.end

; =============== Play_CopyColiBoxToRAM ===============
; Copies the collision box array to WRAM, presumably because it didn't fit in the allotted bank.
; [BUG] The number of array entries to copy isn't initialized properly.
;       This copies much more than it's supposed to, including this subroutine and the junk
;       padding data around it to RAM.
;       Removed in 96 since the collision array fits in the bank with the collision check code.
Play_CopyColiBoxToRAM:
	IF FIX_BUGS == 1
		ld   b, (Play_ColiBoxTbl.end-Play_ColiBoxTbl)/ 4 ; B = Number of entries to copy
	ELSE
		ld   b, $00				; B = Number of entries to copy
	ENDC
	ld   hl, wColiBoxTbl		; HL = Ptr to Destination
	ld   de, Play_ColiBoxTbl	; DE = Ptr to source
.loop:
	; Each collision box has 4 borders, so copy 4 bytes at a time
REPT 4
	ld   a, [de]
	inc  de
	ldi  [hl], a
ENDR
	dec  b				; Are we done?
	jp   nz, .loop		; If not, loop
	ret
	
IF SKIP_JUNK == 0
Test_Junk2:
	mIncJunk "L1D7A8E"
ENDC