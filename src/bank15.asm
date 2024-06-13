IF VER_EN
; =============== TextPrinter_MultiFrameFar_* ===============
; Sets of subroutines, one for each mode, that print a string across multiple frames,
; taking exclusive control of the current task until it finishes.
;
; Interestingly, this is almost identical to the improved TextPrinter used in 96, which
; does not exist in the Japanese version.
; In this game, the code doesn't fit in BANK $00, so it gets copied to WRAM instead.
;
; IN
; - HL: Ptr to TextDef structure
; - B: Bank number of TextDef structure
; - C: Delay between letter printing
TextPrinter_MultiFrameFarCode: ; ROM label
LOAD "Cutscene TextPrinter", WRAM0[$CC00]
TextPrinter_MultiFrameFar: ; RAM label
	dw TextPrinter_MultiFrameFar_End-.start ; Bytes to copy ($0194)
.start:

; =============== TextPrinter_MultiFrameFar_AllowFast ===============
TextPrinter_MultiFrameFar_AllowFast:
	ld   a, TXT_ALLOWFAST
	ld   [wTextPrintFlags], a
	jr   TextPrinter_MultiFrameFar_Custom
	
; =============== TextPrinter_MultiFrameFar_AllowSkip ===============	
TextPrinter_MultiFrameFar_AllowSkip:
	ld   a, TXT_ALLOWSKIP
	ld   [wTextPrintFlags], a
	jr   TextPrinter_MultiFrameFar_Custom
	
; =============== TextPrinter_MultiFrameFar_NoCtrl ===============	
TextPrinter_MultiFrameFar_NoCtrl:
	ld   a, TXT_NOCTRL
	ld   [wTextPrintFlags], a
	jr   TextPrinter_MultiFrameFar_Custom
	
; =============== TextPrinter_MultiFrameFar_AllowFastBlinkPic ===============	
TextPrinter_MultiFrameFar_AllowFastBlinkPic:
	ld   a, TXT_ALLOWFAST_BLINKPIC
	ld   [wTextPrintFlags], a
	; Fall-through
	
; =============== TextPrinter_MultiFrameFar_Custom ===============	
TextPrinter_MultiFrameFar_Custom:

	ldh  a, [hROMBank]			; Save cur bank
	push af
		ld   a, b				; Switch to bank with TextDef
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		
		ld   a, c			; A = Delay
		ld   e, [hl]		; DE = Tilemap ptr
		inc  hl
		ld   d, [hl]
		inc  hl
		ld   b, [hl]		; B = String length
		inc  hl				; Next byte
		
	.loop:
		; In this first part inside the "push af", write a letter to the screen.
		; NOTE: Unless we're handling a newline, the printing should be done instantly,
		;       as the waiting only happens later (to allow the speedup controls to work)
		push af				; Save delay
			push bc
				ldi  a, [hl]		; Read letter from string
				cp   C_NL			; Is it the newline character?
				jr   z, .doNewline	; If so, jump

				push hl

					;
					; Write the character to the screen
					;

					; Convert letter to the tile ID, by indexing the conversion table
					; and then adding the offset previously passed s 
					ld   hl, TextPrinter_CutsceneCharsetToTileTbl
					ld   b, $00		; BC = Letter
					ld   c, a
					add  hl, bc		; HL = Ptr to tile ID
					mWaitForVBlankOrHBlankFast
					
					ld   b, [hl]	; B = Base Tile ID
					ld   a, [wTextPrintTileOffset]
					add  b			; B += Offset
					ld   [de], a	; Write the letter tile

					;
					; Play the typewriter SGB sound for modes TXT_ALLOWSKIP and TXT_NOCTRL.
					; In practice, they are enabled for the Intro (TXT_ALLOWSKIP) and the Epilogue/Unlock screens (TXT_NOCTRL).
					;
					ld   a, [wTextPrintFlags]
					cp   TXT_ALLOWSKIP	; Are we on the intro?
					jr   z, .withSfx	; If so, play SFX
					cp   TXT_NOCTRL		; Are we on the epilogue/unlock screen?
					jr   z, .withSfx	; If so, play SFX
					jr   .sfxDone 		; Otherwise, skip it
				.withSfx:
					; Use a different sound effect when printing the space character
					ld   a, b
					or   a							; TileID != 0?
					jr   nz, .sfxSpace				; If so, jump
				.sfxChar:
					ld   hl, (SGB_SND_A_SELECT_B << 8)|$02
					call SGB_PrepareSoundPacketA
					jr   .sfxDone
				.sfxSpace:
					ld   hl, (SGB_SND_A_PUNCH_B << 8)|$07
					call SGB_PrepareSoundPacketA
				.sfxDone:
					inc  de ; Move tilemap pos right
				pop  hl
			pop  bc
		pop  af
		jr   .charPrinted
				;------
				;
				; Newline handler
				; Moves to the *start* of the next tilemap row.
				; The side effect of this is strings starting with at least 1 empty space.
				;
			.doNewline:
				push hl

					; DE += BG_TILECOUNT_H
					ld   hl, BG_TILECOUNT_H
					add  hl, de
					push hl
					pop  de
					; Align to $20 boundary
					ld   a, e
					and  a, $FF^(BG_TILECOUNT_H-1)
					ld   e, a

					; Wait 6 frames before continuing
					call Task_PassControl_NoDelay
					call Cutscene_BlinkPic
					ld   b, $05
				.newlineWait:
					call Task_PassControl_NoDelay
					call Cutscene_BlinkPic
					dec  b
					jr   nz, .newlineWait
				;-------

				pop  hl
			pop  bc
		pop  af				; Restore delay
		
	.charPrinted:
		;
		; Handle speedup controls
		;

		; If we enabled the line skipping mode in the delay counter, that's it.
		; Instantly print text as fast as possible (but still delay for a bit when printing newlines).
		bit  TXCB_INSTANT, a		; Instant print enabled?
		jr   nz, .chkStringEnd		; If so, skip and immediately write the next char
		push af

		.delayLoop:
			push af
				; There are three different ways to handle controls.
				; In 96, these were turned into bit checks.
				ld   a, [wTextPrintFlags]
				cp   TXT_ALLOWSKIP			; Allowing skipping?
				jr   z, .chkCtrlWithSkip	; If so, jump
				cp   TXT_NOCTRL				; Are controls disabled?
				jr   z, .actNone			; If so, jump
				
				; Otherwise, allow speedup controls (TXT_ALLOWFAST / TXT_ALLOWFAST_BLINKPIC)
				; Pressing A in this mode will speed up the text printing.
				; It's also possible to press START to enable instant text mode.
			.chkCtrlFast:
				ldh  a, [hJoyNewKeys]
				bit  KEYB_START, a			; Pressed START?
				jr   nz, .actInstant		; If so, jump
				ldh  a, [hJoyKeys]
				bit  KEYB_A, a				; Holding A?
				jr   nz, .actSpeedup		; If so, jump
				; Check the same for controller 2
				ldh  a, [hJoyNewKeys2]
				bit  KEYB_START, a
				jr   nz, .actInstant
				ldh  a, [hJoyKeys2]
				bit  KEYB_A, a
				jr   nz, .actSpeedup
				jr   .actNone				; Otherwise, no action
			.chkCtrlWithSkip:
				; TXTB_ALLOWSKIP mode
				; Pressing START in this mode will mark the text printing as finished,
				; skipping the rest completely.
				ldh  a, [hJoyNewKeys]
				bit  KEYB_START, a			; Pressed START?
				jr   nz, .actAbort			; If so, jump
				; Check the same for controller 2
				ldh  a, [hJoyNewKeys2]
				bit  KEYB_START, a
				jr   nz, .actAbort
				jr   .actNone				; Otherwise, no action

			;
			; Action: Abort
			; Exit from here, marking the printing as finished
			;
			.actAbort:
			pop  af
		pop  af

		; Restore bank
		pop  af
		ld   [MBC1RomBank], a
		ldh  [hROMBank], a
		scf			; C flag = 1, aborted
		ret
		;--
			;
			; Action: Instant text
			; Enable instant text mode permanently
			;
			.actInstant:
			pop  af
		pop  af					; Extra pop to apply the changes permanently
		set  TXCB_INSTANT, a 	; here
		jr   .chkStringEnd
		;--
			;
			; Action: Speed up
			; Sets the text printing delay to 1 frame temporarily
			;
			.actSpeedup:
			pop  af
			ld   a, $01			; A = Frames to wait (temp copy)
			jr   .waitFrame
		;--
			;
			; Action: None
			; ...well
			;
			.actNone:
			pop  af				; Restore delay counter
		;--
		; Common wait between text printing
		.waitFrame:
			push af
				call Task_PassControl_NoDelay
				call Cutscene_BlinkPic
			pop  af
			dec  a				; Waited all frames?
			jr   nz, .delayLoop	; If not, loop
		pop  af					; Restore original text speed

	.chkStringEnd:
		dec  b					; Printed all letters?
		jp   nz, .loop			; If not, loop

	; Exit from here
	pop  af
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	scf				; C flag = 0, not aborted
	ccf
	ret
	
; =============== Cutscene_BlinkPic ===============
; Flashes Omega Rugal's pic.
; This is accomplished by quickly toggling wOBJInfo_PicBlink's visibility,
; which is a black square that fully covers the pic if visible.
Cutscene_BlinkPic:

	; Only in mode $03
	ld   a, [wTextPrintFlags]
	cp   TXT_ALLOWFAST_BLINKPIC
	ret  nz

	push af
		push bc
			push hl
				
				;
				; Visible = wTimer & wCutBlinkPicMask == 0
				; The lower the mask value is, the more the blocker object is visible.
				;
				ld   a, [wCutBlinkPicMask]
				ld   b, a			; B = Flash Mask
				ld   a, [wTimer]	; A = Timer
				and  b				; Timer & Mask != 0?
				jr   nz, .hide		; If so, jump (hide object)
			.show:
				ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
				set  OSTB_VISIBLE, [hl]
				jr   .end
			.hide:
				ld   hl, wOBJInfo_PicBlink+iOBJInfo_Status
				res  OSTB_VISIBLE, [hl]
			.end:
			
			pop  hl
		pop  bc
	pop  af
	ret
; =============== TextPrinter_CutsceneCharsetToTileTbl ===============
; Maps the ASCII-like character set used for cutscene strings in the ROM to tile IDs.
; The tile IDs correspond to the cutscene 1bpp font (FontDef_Cutscene).
; TODO: Maps
TextPrinter_CutsceneCharsetToTileTbl:
	;      ; $ID ;EN ; NOTES
	db $00 ; $00 ; 
	db $48 ; $01 ; ↑ ; Arrows ↓
	db $49 ; $02 ; ↗ ; Arrows ↓
	db $4A ; $03 ; → ; Arrows ↓
	db $4B ; $04 ; ↘ ; Arrows ↓
	db $4C ; $05 ; ↓ ; Arrows ↓
	db $4D ; $06 ; ↙ ; Arrows ↓
	db $4E ; $07 ; ← ; Arrows ↓
	db $4F ; $08 ; ↖ ; Arrows ↓
	db $00 ; $09 ; 
	db $00 ; $0A ; 
	db $00 ; $0B ; 
	db $00 ; $0C ; 
	db $00 ; $0D ; 
	db $00 ; $0E ; 
	db $00 ; $0F ; 
	db $00 ; $10 ; 
	db $00 ; $11 ; 
	db $00 ; $12 ; 
	db $00 ; $13 ; 
	db $00 ; $14 ; 
	db $00 ; $15 ; 
	db $00 ; $16 ; 
	db $00 ; $17 ; 
	db $00 ; $18 ; 
	db $00 ; $19 ; 
	db $00 ; $1A ; 
	db $00 ; $1B ; 
	db $00 ; $1C ; 
	db $00 ; $1D ; 
	db $00 ; $1E ; 
	db $00 ; $1F ; 
	db $00 ; $20 ; (space)
	db $3F ; $21 ; !
	db $44 ; $22 ; "
	db $00 ; $23 ; 
	db $00 ; $24 ; 
	db $00 ; $25 ; 
	db $00 ; $26 ; 
	db $43 ; $27 ; '	
	db $45 ; $28 ; (
	db $46 ; $29 ; )
	db $00 ; $2A ; 
	db $47 ; $2B ; +
	db $42 ; $2C ; ,
	db $00 ; $2D ;
	db $41 ; $2E ; .
	db $00 ; $2F ; 
	db $01 ; $30 ; 0
	db $02 ; $31 ; 1
	db $03 ; $32 ; 2
	db $04 ; $33 ; 3
	db $05 ; $34 ; 4
	db $06 ; $35 ; 5
	db $07 ; $36 ; 6
	db $08 ; $37 ; 7
	db $09 ; $38 ; 8
	db $0A ; $39 ; 9
	db $00 ; $3A ;
	db $00 ; $3B ; 
	db $00 ; $3C ; 
	db $00 ; $3D ; 
	db $00 ; $3E ; 
	db $40 ; $3F ; ?
	db $00 ; $40 ; 
	db $0B ; $41 ; A
	db $0C ; $42 ; B
	db $0D ; $43 ; C
	db $0E ; $44 ; D
	db $0F ; $45 ; E
	db $10 ; $46 ; F
	db $11 ; $47 ; G
	db $12 ; $48 ; H
	db $13 ; $49 ; I
	db $14 ; $4A ; J
	db $15 ; $4B ; K
	db $16 ; $4C ; L
	db $17 ; $4D ; M
	db $18 ; $4E ; N
	db $19 ; $4F ; O
	db $1A ; $50 ; P
	db $1B ; $51 ; Q
	db $1C ; $52 ; R
	db $1D ; $53 ; S
	db $1E ; $54 ; T
	db $1F ; $55 ; U
	db $20 ; $56 ; V
	db $21 ; $57 ; W
	db $22 ; $58 ; X
	db $23 ; $59 ; Y
	db $24 ; $5A ; Z
	db $00 ; $5B ; 
	db $00 ; $5C ; 
	db $00 ; $5D ; 
	db $00 ; $5E ; 
	db $00 ; $5F ; 
	db $43 ; $60 ; ` ; Points to same tile as '
	db $25 ; $61 ; a
	db $26 ; $62 ; b
	db $27 ; $63 ; c
	db $28 ; $64 ; d
	db $29 ; $65 ; e
	db $2A ; $66 ; f
	db $2B ; $67 ; g
	db $2C ; $68 ; h
	db $2D ; $69 ; i
	db $2E ; $6A ; j
	db $2F ; $6B ; k
	db $30 ; $6C ; l
	db $31 ; $6D ; m
	db $32 ; $6E ; n
	db $33 ; $6F ; o
	db $34 ; $70 ; p
	db $35 ; $71 ; q
	db $36 ; $72 ; r
	db $37 ; $73 ; s
	db $38 ; $74 ; t
	db $39 ; $75 ; u
	db $3A ; $76 ; v
	db $3B ; $77 ; w
	db $3C ; $78 ; x
	db $3D ; $79 ; y
	db $3E ; $7A ; z
	db $00 ; $7B ; 
	db $00 ; $7C ; 
	db $00 ; $7D ; 
	db $00 ; $7E ; 
	db $00 ; $7F ; 

TextPrinter_MultiFrameFar_End:
ENDL

PUSHC
SETCHARMAP ascii
TextDef_IntroEn0:
	dw $9960
	db .end-.start
.start:
	db C_NL
	db "Announcing the 1995", C_NL
	db C_NL
	db " King Of Fighters", C_NL
	db C_NL
	db "  tournament."
.end:
TextDef_IntroEn1:
	dw $9980
	db .end-.start
.start:
	db "We welcome both", C_NL
	db C_NL
	db " new and old teams."
.end:
TextDef_IntroEn2:
	dw $9A03
	db .end-.start
.start:
	db "             R...", C_NL
	db C_NL
.end:
TextDef_CutsceneIntAEn0T:
	dw $9980
	db .end-.start
.start:
	db "Mr. RUGAL,", C_NL
	db " The new team", C_NL
	db " has won 3 matches!"
.end:
TextDef_CutsceneIntAEn1:
	dw $9980
	db .end-.start
.start:
	db "      Heh, Heh,", C_NL
	db "       Interesting.", C_NL
	db C_NL
	db "      Let`s watch."
.end:
TextDef_CutsceneIntAEn0S:
	dw $9980
	db .end-.start
.start:
	db "Mr. RUGAL,", C_NL
	db " That person", C_NL
	db " has won 6 matches!"
.end:
TextDef_CutsceneIntBEn0:
	dw $9980
	db .end-.start
.start:
	db "Heh, Heh, Heh.", C_NL
	db C_NL
	db "Hurry up,", C_NL
	db "I`m waiting for you!", C_NL
	db C_NL
	db "Yah, Hah, Hah!"
.end:
TextDef_CutsceneSaisyuEn0T:
	dw $9980
	db .end-.start
.start:
	db "Welcome, My friends."
.end:
TextDef_CutsceneSaisyuEn0S:
	dw $9980
	db .end-.start
.start:
	db "Welcome, My friend."
.end:
TextDef_CutsceneSaisyuEn1:
	dw $9980
	db .end-.start
.start:
	db "RUGAL!"
.end:
TextDef_CutsceneSaisyuEn2:
	dw $9980
	db .end-.start
.start:
	db "Now it`s time", C_NL
	db " for you to join me."
.end:
TextDef_CutsceneSaisyuEn3:
	dw $9980
	db .end-.start
.start:
	db "What?"
.end:
TextDef_CutsceneSaisyuEn4:
	dw $9980
	db .end-.start
.start:
	db "I`m going to make", C_NL
	db " you into cyborg", C_NL
	db " warriors.", C_NL
	db C_NL
	db "Then, I`ll show you", C_NL
	db " what I mean."
.end:
TextDef_CutsceneSaisyuEn5:
	dw $9980
	db .end-.start
.start:
	db "My name is", C_NL
	db " SAISYU KUSANAGI.", C_NL
	db C_NL
	db "Let`s have a", C_NL
	db " little fun."
.end:
TextDef_CutsceneSaisyuEn6:
	dw $9980
	db .end-.start
.start:
	db "I don`t believe it."
.end:
TextDef_CutsceneSaisyuEn7:
	dw $9980
	db .end-.start
.start:
	db "Yes,", C_NL
	db " He is KYO`s father.", C_NL
	db C_NL
	db "I gave life to him!", C_NL
	db C_NL
	db "Surrender or die!"
.end:
TextDef_CutsceneRugalEn0:
	dw $9980
	db .end-.start
.start:
	db "My fate was to lose.", C_NL
	db C_NL
	db "I`m impressed."
.end:
TextDef_CutsceneRugalEn1:
	dw $9980
	db .end-.start
.start:
	db "You did well", C_NL
	db " for a product.", C_NL
	db C_NL
	db "But now,", C_NL
	db " you are going to", C_NL
	db " give me your power!"
.end:
TextDef_CutsceneRugalEn2:
	dw $9980
	db .end-.start
.start:
	db "  WOOOOOoooooo...."
.end:
TextDef_CutsceneRugalDefeatEn0:
	dw $9980
	db .end-.start
.start:
	db "What?", C_NL
	db C_NL
	db "Am I defeated again?"
.end:
IF VER_US
; Blanked
TextDef_CutsceneRugalDefeatEn1:
	dw $9980
	db .end-.start
.start:
	db " "
.end:
TextDef_CutsceneRugalDefeatEn2:
	dw $9980
	db .end-.start
.start:
	db "You did well,", C_NL
	db " but rest assured", C_NL 
	db " I shall return."
.end:
ELSE
TextDef_CutsceneRugalDefeatEn1:
	dw $9980
	db .end-.start
.start:
	db "You did well, Guys."
.end:
TextDef_CutsceneRugalDefeatEn2:
	dw $9980
	db .end-.start
.start:
	db "But I shall return", C_NL
	db " as long as", C_NL
	db " the world requires", C_NL
	db " myself."
.end:
ENDC

TextDef_CutsceneRugalDefeatEn3:
	dw $9980
	db .end-.start
.start:
	db "See you again..."
.end:
TextDef_CutsceneEpilogueEn:
	dw $9860
	db .end-.start
.start:
	db "Finally you beat", C_NL
	db C_NL
	db " RUGAL and won the", C_NL
	db C_NL
	db " King Of Fighters`95.", C_NL
	db C_NL
	db "          ", C_NL
	db "And now,", C_NL
	db C_NL
IF VER_US
	db " get ready for", C_NL
	db C_NL
	db " the next fight.", C_NL
	db "                   ", C_NL
ELSE
	db "You make a step", C_NL
	db C_NL
	db " toward next fight.", C_NL
	db "                   ", C_NL
ENDC
.end:
TextDef_CutsceneNakoruruEn0:
	dw $9980
	db .end-.start
.start:
	db "Wait!!", C_NL
	db "           ", C_NL
	db "My name is NAKORURU!"
.end:
TextDef_CutsceneNakoruruEn1:
	dw $9980
	db .end-.start
.start:
	db "I`m coming", C_NL
	db " here to beat you!!"
.end:
TextDef_CutsceneNakoruruDefeatEn0:
	dw $9980
	db .end-.start
.start:
	db "Uh... Am I no match", C_NL
	db " for you?"
.end:
TextDef_CutsceneNakoruruDefeatEn1:
	dw $9980
	db .end-.start
.start:
	db "\"KIIIIiiii...\"", C_NL
	db "                    ", C_NL
	db "What`s wrong,", C_NL
	db " MAMAHAHA?"
.end:
TextDef_CutsceneNakoruruDefeatEn2:
	dw $9980
	db .end-.start
.start:
	db "What? Did I fight", C_NL
	db " wrong person!?", C_NL
.end:
TextDef_CutsceneNakoruruDefeatEn3:
	dw $9980
	db .end-.start
.start:
	db "That person has", C_NL
	db " already beaten", C_NL
	db " RUGAL?", C_NL
	db "                              ", C_NL
	db "(Hey! Why didn`t you", C_NL
	db " tell me earlier?)"
.end:
TextDef_CutsceneNakoruruDefeatEn4:
	dw $9980
	db .end-.start
.start:
	db "Sorry, I mistook you", C_NL
	db " for him and ..."
.end:
TextDef_CutsceneNakoruruDefeatEn5:
	dw $9980
	db .end-.start
.start:
	db "!!!!!", C_NL
	db C_NL
	db "This feeling!"
.end:
TextDef_CutsceneNakoruruDefeatEn6:
	dw $9980
	db .end-.start
.start:
	db "Heh,Heh,Heh.", C_NL
	db "                    ", C_NL
	db "I shall return!"
.end:
POPC

ENDC
GFX_Char_Kim_Idle0_A: INCBIN "data/gfx/char/kim_idle0_a.bin"
GFX_Char_Kim_Idle0_B: INCBIN "data/gfx/char/kim_idle0_b.bin"
GFX_Char_Kim_Idle1: INCBIN "data/gfx/char/kim_idle1.bin"
GFX_Char_Kim_Idle2_A: INCBIN "data/gfx/char/kim_idle2_a.bin"
GFX_Char_Kim_Idle2_B: INCBIN "data/gfx/char/kim_idle2_b.bin"
GFX_Char_Kim_WalkF1: INCBIN "data/gfx/char/kim_walkf1.bin"
GFX_Char_Kim_WalkF2: INCBIN "data/gfx/char/kim_walkf2.bin"
GFX_Char_Kim_Crouch0_A: INCBIN "data/gfx/char/kim_crouch0_a.bin"
GFX_Char_Kim_Crouch0_B: INCBIN "data/gfx/char/kim_crouch0_b.bin"
GFX_Char_Kim_CrouchWalkF1: INCBIN "data/gfx/char/kim_crouchwalkf1.bin"
GFX_Char_Kim_CrouchWalkF2: INCBIN "data/gfx/char/kim_crouchwalkf2.bin"
GFX_Char_Kim_JumpN1: INCBIN "data/gfx/char/kim_jumpn1.bin"
GFX_Char_Kim_JumpF2: INCBIN "data/gfx/char/kim_jumpf2.bin"
GFX_Char_Kim_BlockG0: INCBIN "data/gfx/char/kim_blockg0.bin"
GFX_Char_Kim_BlockC0: INCBIN "data/gfx/char/kim_blockc0.bin"
GFX_Char_Kim_Hit0Mid0: INCBIN "data/gfx/char/kim_hit0mid0.bin"
GFX_Char_Kim_Hit1Mid1: INCBIN "data/gfx/char/kim_hit1mid1.bin"
GFX_Char_Kim_HitLow0: INCBIN "data/gfx/char/kim_hitlow0.bin"
GFX_Char_Kim_LaunchUB1: INCBIN "data/gfx/char/kim_launchub1.bin"
GFX_Char_Kim_LaunchUB2: INCBIN "data/gfx/char/kim_launchub2.bin"
GFX_Char_Kim_PunchLN0: INCBIN "data/gfx/char/kim_punchln0.bin"
GFX_Char_Kim_PunchLN1: INCBIN "data/gfx/char/kim_punchln1.bin"
GFX_Char_Kim_PunchLM1: INCBIN "data/gfx/char/kim_punchlm1.bin"
GFX_Char_Kim_PunchHM2: INCBIN "data/gfx/char/kim_punchhm2.bin"
GFX_Char_Kim_PunchHN1: INCBIN "data/gfx/char/kim_punchhn1.bin"
GFX_Char_Kim_PunchHN2: INCBIN "data/gfx/char/kim_punchhn2.bin"
GFX_Char_Kim_PunchHM0: INCBIN "data/gfx/char/kim_punchhm0.bin"
GFX_Char_Kim_KickLN1_A: INCBIN "data/gfx/char/kim_kickln1_a.bin"
GFX_Char_Kim_KickLN1_B: INCBIN "data/gfx/char/kim_kickln1_b.bin"
GFX_Char_Kim_KickLM1: INCBIN "data/gfx/char/kim_kicklm1.bin"
GFX_Char_Kim_KickHN0: INCBIN "data/gfx/char/kim_kickhn0.bin"
GFX_Char_Kim_KickHN1: INCBIN "data/gfx/char/kim_kickhn1.bin"
GFX_Char_Kim_KickHM4_A: INCBIN "data/gfx/char/kim_kickhm4_a.bin"
GFX_Char_Kim_KickHM4_B: INCBIN "data/gfx/char/kim_kickhm4_b.bin"
GFX_Char_Kim_PunchCL1_A: INCBIN "data/gfx/char/kim_punchcl1_a.bin"
GFX_Char_Kim_PunchCH0: INCBIN "data/gfx/char/kim_punchch0.bin"
GFX_Char_Kim_PunchCH1: INCBIN "data/gfx/char/kim_punchch1.bin"
GFX_Char_Kim_KickCL1: INCBIN "data/gfx/char/kim_kickcl1.bin"
GFX_Char_Kim_KickCH0: INCBIN "data/gfx/char/kim_kickch0.bin"
GFX_Char_Kim_KickCH1: INCBIN "data/gfx/char/kim_kickch1.bin"
GFX_Char_Kim_PunchALI0: INCBIN "data/gfx/char/kim_punchali0.bin"
GFX_Char_Kim_PunchAHI0: INCBIN "data/gfx/char/kim_punchahi0.bin"
GFX_Char_Kim_KickALI0: INCBIN "data/gfx/char/kim_kickali0.bin"
GFX_Char_Kim_KickAHI0: INCBIN "data/gfx/char/kim_kickahi0.bin"
GFX_Char_Kim_Dodge0: INCBIN "data/gfx/char/kim_dodge0.bin"
GFX_Char_Kim_DodgeCounter1: INCBIN "data/gfx/char/kim_dodgecounter1.bin"
GFX_Char_Kim_DodgeCounter2: INCBIN "data/gfx/char/kim_dodgecounter2.bin"
GFX_Char_Kim_ThrowG0: INCBIN "data/gfx/char/kim_throwg0.bin"
GFX_Char_Kim_ThrowG1: INCBIN "data/gfx/char/kim_throwg1.bin"
GFX_Char_Kim_ThrowG2: INCBIN "data/gfx/char/kim_throwg2.bin"
GFX_Char_Kim_ChargeMeter0_A: INCBIN "data/gfx/char/kim_chargemeter0_a.bin"
GFX_Char_Kim_ChargeMeter0_B: INCBIN "data/gfx/char/kim_chargemeter0_b.bin"
GFX_Char_Kim_ChargeMeter1_A: INCBIN "data/gfx/char/kim_chargemeter1_a.bin"
GFX_Char_Kim_Strike1_B: INCBIN "data/gfx/char/kim_strike1_b.bin"
GFX_Char_Kim_AttackA0: INCBIN "data/gfx/char/kim_attacka0.bin"
GFX_Char_Kim_Intro5: INCBIN "data/gfx/char/kim_intro5.bin"
GFX_Char_Kim_Intro6_A: INCBIN "data/gfx/char/kim_intro6_a.bin"
GFX_Char_Kim_Intro6_B: INCBIN "data/gfx/char/kim_intro6_b.bin"
GFX_Char_Kim_Intro7_A: INCBIN "data/gfx/char/kim_intro7_a.bin"
GFX_Char_Kim_Intro8: INCBIN "data/gfx/char/kim_intro8.bin"
GFX_Char_Kim_Taunt0_A: INCBIN "data/gfx/char/kim_taunt0_a.bin"
GFX_Char_Kim_Taunt0_B: INCBIN "data/gfx/char/kim_taunt0_b.bin"
GFX_Char_Kim_Taunt1_A: INCBIN "data/gfx/char/kim_taunt1_a.bin"
GFX_Char_Kim_Taunt2_A: INCBIN "data/gfx/char/kim_taunt2_a.bin"
GFX_Char_Kim_Win1_A: INCBIN "data/gfx/char/kim_win1_a.bin"
GFX_Char_Kim_Win1_B: INCBIN "data/gfx/char/kim_win1_b.bin"
GFX_Char_Kim_Win2_A: INCBIN "data/gfx/char/kim_win2_a.bin"
GFX_Char_Kim_Win3_A: INCBIN "data/gfx/char/kim_win3_a.bin"
GFX_Char_Kim_Win4_A: INCBIN "data/gfx/char/kim_win4_a.bin"
GFX_Char_Kim_Win4_B: INCBIN "data/gfx/char/kim_win4_b.bin"
GFX_Char_Kim_Win5_A: INCBIN "data/gfx/char/kim_win5_a.bin"
GFX_Char_Kim_Win6_A: INCBIN "data/gfx/char/kim_win6_a.bin"
GFX_Char_Kim_HanGetsuZan0: INCBIN "data/gfx/char/kim_hangetsuzan0.bin"
GFX_Char_Kim_HanGetsuZan1: INCBIN "data/gfx/char/kim_hangetsuzan1.bin"
GFX_Char_Kim_HanGetsuZan3_A: INCBIN "data/gfx/char/kim_hangetsuzan3_a.bin"
GFX_Char_Kim_HanGetsuZan3_B: INCBIN "data/gfx/char/kim_hangetsuzan3_b.bin"
GFX_Char_Kim_HanGetsuZan4_A: INCBIN "data/gfx/char/kim_hangetsuzan4_a.bin"
GFX_Char_Kim_HienZan1: INCBIN "data/gfx/char/kim_hienzan1.bin"
GFX_Char_Kim_HienZan2: INCBIN "data/gfx/char/kim_hienzan2.bin"
GFX_Char_Kim_HishouKyaku0_A: INCBIN "data/gfx/char/kim_hishoukyaku0_a.bin"
GFX_Char_Kim_HishouKyaku1_B: INCBIN "data/gfx/char/kim_hishoukyaku1_b.bin"
GFX_Char_Kim_HishouKyaku0_B: INCBIN "data/gfx/char/kim_hishoukyaku0_b.bin"
GFX_Char_Kim_RyuuseiRanku0: INCBIN "data/gfx/char/kim_ryuuseiranku0.bin"
GFX_Char_Kim_RyuuseiRanku2: INCBIN "data/gfx/char/kim_ryuuseiranku2.bin"
GFX_Char_Kim_RyuuseiRanku3: INCBIN "data/gfx/char/kim_ryuuseiranku3.bin"
GFX_Char_Kim_HouOuKyaku1: INCBIN "data/gfx/char/kim_hououkyaku1.bin"

; =============== END OF BANK ===============
; Junk area below.
IF VER_US
	mIncJunk "../padding_us/L157FDF"
ELIF !VER_EN
	mIncJunk "L157880"
ENDC