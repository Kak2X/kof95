; 
; =============== START OF MODULE Title ===============
;
; =============== Module_Title ===============
; EntryPoint for Title Screen and Menus.
Module_Title:
	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   hl, wMisc_C028
	res  MISCB_USE_SECT, [hl]
	set  MISCB_TITLE_SECT, [hl]	; Enable title parallax mode
	
	; Init vars
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ld   [wTitleMode], a
	ld   [wJoyActivePl], a
	ld   [wTitleMenuOptId], a
	ld   [wTitleMenuCursorXBak], a
	ld   [wTitleMenuCursorYBak], a
	ld   [wTitleSubMenuOptId], a
	ld   [wOptionsSGBSndOptId], a
	ld   [wOptionsBGMId], a
	ld   [wOptionsSFXId], a
	ld   [wOptionsMenuMode], a
	ld   [wTitleBlinkTimer], a
	ld   [wOptionsSGBSndIdA], a
	ld   [wOptionsSGBSndBankA], a
	ld   [wOptionsSGBSndIdB], a
	ld   [wOptionsSGBSndBankB], a
	
	; After 30 seconds of inactivity in GM_TITLE_TITLE, return to the intro
	ld   a, HIGH(TITLE_RESET_TIMER)
	ld   [wTitleResetTimer_High], a
	ld   a, LOW(TITLE_RESET_TIMER)
	ld   [wTitleResetTimer_Low], a
	
	; Copy the SGB packet used to play audio in the SGB Sound Test.
	ld   hl, SGBPacketDef_Options_PlaySnd
	ldi  a, [hl]					; B = Bytes to copy
	ld   b, a						
	ld   de, wOptionsSGBPacketSnd	; DE = Target
	; The remaining bytes are copied into the buffer
.cpLoop:
	ldi  a, [hl]			
	ld   [de], a			
	inc  de
	dec  b					; Are we done?
	jp   nz, .cpLoop		; If not, loop
	
	; Load SGB palettes
	ld   de, SCRPAL_TITLE
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Init scroll positions for BG layer, used for the parallax clouds.
	xor  a
	ldh  [hScrollX], a
	ld   [wOBJScrollX], a
IF VER_EN
	; To make space for the extra two rows of copyright text at the bottom of the screen,
	; everything is shifted up by 16px.
	ld   a, $10
	ld   [wOBJScrollY], a
	ld   a, $A8
	ldh  [hScrollY], a	
ELSE
	ld   [wOBJScrollY], a
	ld   a, $98
	ldh  [hScrollY], a
ENDC

	
	; Load graphics
	ld   b, BANK(Title_LoadVRAM) ; BANK $1D
	ld   hl, Title_LoadVRAM
	rst  $08
	
	;
	; Write the menu text in the BG layer.
	;
	; Because the BG layer only contains a 3-tiles tall horizontal strip, there's enough space
	; to generate both text-only menu screens.
	; The tilemap won't be touched again when navigating through the title screen/menus,
	; only the graphics will be reloaded.
	;
	
	ld   hl, TextDef_Menu_Title
	call TextPrinter_Instant
	ld   hl, TextDef_Menu_SinglePlay
	call TextPrinter_Instant
	ld   hl, TextDef_Menu_TeamPlay
	call TextPrinter_Instant
	ld   hl, TextDef_Menu_SingleVS
	call TextPrinter_Instant
	ld   hl, TextDef_Menu_TeamVS
	call TextPrinter_Instant
	ld   hl, TextDef_Options_Title
	call TextPrinter_Instant
	ld   hl, TextDef_Options_Time
	call TextPrinter_Instant
	ld   hl, TextDef_Options_Level
	call TextPrinter_Instant
	ld   hl, TextDef_Options_BGMTest
	call TextPrinter_Instant
	ld   hl, TextDef_Options_SFXTest
	call TextPrinter_Instant
	ld   hl, TextDef_Options_Exit
	call TextPrinter_Instant
	
	; If dip switches are set, display the dip value and any extra options
	ld   a, [wDipSwitch]
	or   a						; Any dip switch set?
	jp   z, .noDip				; If not, skip
	ld   hl, TextDef_Options_Dip
	call TextPrinter_Instant
.noDip:
	; Print text for SGB sound test
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a		; Running on a SGB?
	jp   z, .initOBJ			; If not, skip
	ld   a, [wDipSwitch]
	bit  DIPB_SGB_SOUND_TEST, a	; SGB sound test enabled?
	jp   z, .initOBJ			; If not, skip
	
	ld   hl, TextDef_Options_SGBSndTest
	call TextPrinter_Instant
	ld   hl, TextDef_Options_SGBSndTypes
	call TextPrinter_Instant
	ld   hl, TextDef_Options_SGBSndPlaceholders
	call TextPrinter_Instant
.initOBJ:
	;
	; Prepare sprites.
	; These all use OBJLstPtrTable_Title, with different offsets.
	;
	
	call ClearOBJInfo
	
	; OBJ2 - (C)SNK 1995 text
	ld   hl, wOBJInfo_SnkText+iOBJInfo_Status
	ld   de, OBJInfoInit_Title
	call OBJLstS_InitFrom
IF VER_EN
	; Left aligned in the English version
	ld   hl, wOBJInfo_SnkText+iOBJInfo_X
	ld   [hl], $00
	ld   hl, wOBJInfo_SnkText+iOBJInfo_Y
	ld   [hl], $48
ELSE
	; Centered in the Japanese version (like the Takara copyright in the tilemap)
	ld   hl, wOBJInfo_SnkText+iOBJInfo_X
	ld   [hl], $34
	ld   hl, wOBJInfo_SnkText+iOBJInfo_Y
	ld   [hl], $48
ENDC
	ld   hl, wOBJInfo_SnkText+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_SNKCOPYRIGHT*OBJLSTPTR_ENTRYSIZE
	
	; OBJ1 - Title screen menu text (PUSH START, ...)
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	ld   de, OBJInfoInit_Title
	call OBJLstS_InitFrom
	; It starts hidden in the English version (as well as in 96), to facilitate the delay with disabled controls.
IF VER_EN
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
ENDC
	ld   hl, wOBJInfo_MenuText+iOBJInfo_X
	ld   [hl], $28
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Y
	ld   [hl], $43
	; Entry $00
	
	; OBJ0 - Cursor pointing right
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	ld   de, OBJInfoInit_Title
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_CursorR+iOBJInfo_X
	ld   [hl], $28
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Y
	ld   [hl], $43	; Needs to be aligned with menu text
	ld   hl, wOBJInfo_CursorR+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_CURSOR_R*OBJLSTPTR_ENTRYSIZE
	
	; OBJ3 - Cursor pointing up (for SGB Sound Test)
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	ld   de, OBJInfoInit_Title
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_CursorU+iOBJInfo_X
	ld   [hl], $50
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Y
	ld   [hl], $60
	ld   hl, wOBJInfo_CursorU+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_CURSOR_U*OBJLSTPTR_ENTRYSIZE
	
	; Put WINDOW over BG
	xor  a
	ldh  [rWY], a
	ld   a, $07
	ldh  [rWX], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	; Enable LYC, start parallax at line $66
	ldh  a, [rSTAT]
	or   a, STAT_LYC
	ldh  [rSTAT], a
IF VER_EN
	ld   a, $56
ELSE
	ld   a, $66
ENDC
	ldh  [rLYC], a
	ldh  a, [rIE]
	or   a, I_STAT|I_VBLANK
	ldh  [rIE], a
	
	ei
	
	call Task_PassControl_NoDelay
	
	; Load DMG palettes
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Stop music
	ld   a, SND_MUTE
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; Disable serial since the game shouldn't process the other GB inputs on the menu
	; (outside of when a VS mode is selected)
	call Title_DisableSerial
	
	; The English version forces you to wait for a few seconds before enabling controls,
	; presumably so you're forced to see those copyrights covering more of the screen.
IF VER_EN
	ld   b, $78		; B = Number of frames
.delayLoop:
	call Title_UpdateParallaxCoords		; Update effect
	call Task_PassControl_NoDelay		; Wait frame
	dec  b					; Are we done waiting?
	jp   nz, .delayLoop		; If not, loop
ENDC
	
.mainLoop:
	call JoyKeys_DoCursorDelayTimer
	call .execMode
	call Task_PassControl_NoDelay
	jp   .mainLoop
.execMode:
	; DynJump for title screen mode
	ld   hl, Title_ModePtrTable	; HL = Title_ModePtrTable
	ld   d, $00
	ld   a, [wTitleMode]		; DE = wTitleMode
	ld   e, a
	add  hl, de					; Offset the table
	ld   e, [hl]				; Read out jump target to DE
	inc  hl
	ld   d, [hl]
	push de
	pop  hl						; Move to HL and jump there
	jp   hl
	
Title_ModePtrTable:
	dw Title_Mode_TitleScreen
	dw Title_Mode_TitleMenu
	dw Title_Mode_ModeSelect
	dw Title_Mode_Options

; =============== Title_Mode_TitleScreen ===============
; Title screen - Initial mode.
Title_Mode_TitleScreen:
	call TitleScreen_CheckReset
	call TitleScreen_BlinkPushStartText
	call Title_UpdateParallaxCoords
	call TitleScreen_IsStartPressed ; Pressed START?
	jp   c, .switchToTitleMenu ; If so, jump
	ret
.switchToTitleMenu:
	;
	; Activate the GAME START/OPTIONS menu on the title screen
	;
	ld   a, GM_TITLE_TITLEMENU		; Next mode
	ld   [wTitleMode], a
	ld   a, $00						; Select GAME START
	ld   [wTitleMenuOptId], a
	
	; Display cursor
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Y
	ld   [hl], $43

	; Change OBJLst id to GAME START/OPTIONS text
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_MenuText+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_MENU*OBJLSTPTR_ENTRYSIZE
	ret
	
; =============== TitleScreen_CheckReset ===============
; Checks if enough time has passed without pressing START.
; If enough frames have passed, reset to the intro.
TitleScreen_CheckReset:
	; wTitleResetTimer--
	ld   hl, wTitleResetTimer_Low	
	dec  [hl]							; Decrement low byte
	jp   nz, .ret						; Is it 0 now? If not, return
	ld   [hl], LOW(TITLE_RESET_TIMER)	; Reset to 60 frames
	ld   hl, wTitleResetTimer_High	
	dec  [hl]							; Decrement high byte
	jp   nz, .ret						; Is it 0 now? If not, return
	
	; If we got here, wTitleResetTimer_Low and wTitleResetTimer_High are 0.
	; Return to the TAKARA logo.
	ld   b, BANK(Module_TakaraLogo) ; BANK $1F
	ld   hl, Module_TakaraLogo
	jp   FarJump
.ret:
	ret
	
; =============== Title_Mode_TitleMenu ===============
; Title screen - Menu.
Title_Mode_TitleMenu:
	call Title_BlinkCursorR
	call Title_UpdateParallaxCoords
	call TitleMenu_DoCtrl
	ret  nc	; If we're not switching (C flag clear), return
	
	cp   TITLEMENU_TO_TITLE
	jp   z, .toTitle
	cp   TITLEMENU_TO_MODESELECT
	jp   z, .toModeSelect
	cp   TITLEMENU_TO_OPTIONS
	jp   z, .toOptions
	ret ; We never get here
	
.toTitle:
	;
	; Return back to PUSH START prompt
	;
	ld   a, GM_TITLE_TITLE			
	ld   [wTitleMode], a
	ld   a, HIGH(TITLE_RESET_TIMER)	
	ld   [wTitleResetTimer_High], a
	ld   a, LOW(TITLE_RESET_TIMER)
	ld   [wTitleResetTimer_Low], a
	
	; Hide cursor
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	; Switch to PUSH START text
	ld   hl, wOBJInfo_MenuText+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_PUSHSTART
	ret
	
.toModeSelect:
	
	call Title_DisableSerial
	
	; Reset pal
	ld   a, $FF
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Start over SINGLE PLAY
	ld   a, $00
	ld   [wTitleSubMenuOptId], a
	
	; Next mode
	ld   a, GM_TITLE_MODESELECT
	ld   [wTitleMode], a
	
	; Set the BG scroll to where the mode select text is
	xor  a
	ldh  [hScrollX], a
	ld   a, $20
	ldh  [hScrollY], a
	
	; Move cursor sprite down 8px by pretending the screen is scrolled up by 8px.
	;
	; We aren't using sections in menus so the BG is unaffected, 
	; but the sprite mapping writer still takes this into consideration.
	ld   a, -$08					
	ld   [wOBJScrollY], a
	
	; Save current cursor location
	ld   a, [wOBJInfo_CursorR+iOBJInfo_X]
	ld   [wTitleMenuCursorXBak], a
	ld   a, [wOBJInfo_CursorR+iOBJInfo_Y]
	ld   [wTitleMenuCursorYBak], a
	
	jp   .initMenu
.toOptions:

	; Reset pal
	ld   a, $FF
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reset cursor pos
	ld   a, $00
	ld   [wTitleSubMenuOptId], a
	ld   [wOptionsSGBSndOptId], a
	ld   [wOptionsMenuMode], a
	ld   a, BGM_NAKORURU
	ld   [wOptionsBGMId], a
	ld   a, SFX_CURSORMOVE
	ld   [wOptionsSFXId], a
	
	; Next mode
	ld   a, GM_TITLE_OPTIONS
	ld   [wTitleMode], a
	
	; Set the BG scroll to where the option menu text is
	ld   a, $80
	ldh  [hScrollX], a
	ld   a, $20
	ldh  [hScrollY], a
	ld   a, $08
	ld   [wOBJScrollY], a
	
	; Save current cursor location
	ld   a, [wOBJInfo_CursorR+iOBJInfo_X]
	ld   [wTitleMenuCursorXBak], a
	ld   a, [wOBJInfo_CursorR+iOBJInfo_Y]
	ld   [wTitleMenuCursorYBak], a
		
	; Print the current option values
	call Options_PrintMatchTime
	call Options_PrintDifficulty
	call Options_PrintBGMId
	call Options_PrintSFXId
	call Options_PrintSGBSndTestVals
	call Options_PrintDipSwitch
.initMenu:

	;
	; Common menu loader
	;

	; Menu options start at the same X position
	; The screen scrolling and text positions must account for this and be aligned perfectly.
	ld   a, $20
	ld   [wOBJInfo_CursorR+iOBJInfo_X], a
	ld   a, $00
	ld   [wOBJInfo_CursorR+iOBJInfo_Y], a
	
	; Show horizontal cursor
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	; Hide title screen menu & SNK copyright
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_SnkText+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Disable title screen parallax
	ld   hl, wMisc_C028
	res  MISCB_TITLE_SECT, [hl]		; Disable parallax mode
	xor  a
	ldh  [rSTAT], a					; Disable LYC
	
	; Load generic font
	call LoadGFX_1bppFont_Default
	
	; Disable WINDOW
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	call Task_PassControl_NoDelay
	
	; Load palettes.
	; Note that the SGB palette configuration remains the same as the title screen.
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	ret
	
; =============== TitleMenu_DoCtrl ===============
; Checks for player input in the title screen menu.
; OUT
; - C flag: If set, the game should transition to another submode.
; - A: Determines the new mode (TITLEMENU_TO_*)
TitleMenu_DoCtrl:
	call Title_GetMenuInput
	bit  KEYB_DOWN, b
	jp   nz, .moveV
	bit  KEYB_UP, b
	jp   nz, .moveV
	bit  KEYB_START, a
	jp   nz, .enter
	bit  KEYB_SELECT, a
	jp   nz, .exit
	bit  KEYB_A, a
	jp   nz, .enter
	xor  a
	ret
	
.moveV:
	;--
	; Not necessary
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	;--
	
	; Change selected option
	; Because there are only two menu options, a xor is all that's needed
	ld   a, [wTitleMenuOptId]
	xor  $01
	ld   [wTitleMenuOptId], a
	
	; Move the cursor 8px up or down depending on the new selected option
	cp   TITLEMENU_TO_MODESELECT-1		; wTitleMenuOptId == 0?
	jp   z, .modeSelect					; If so, jump
.options:
	ld   a, [wOBJInfo_CursorR+iOBJInfo_Y]	; Low option, move down
	add  a, $08
	ld   [wOBJInfo_CursorR+iOBJInfo_Y], a
	xor  a
	ret
.modeSelect:
	ld   a, [wOBJInfo_CursorR+iOBJInfo_Y]	; High option, move up
	sub  a, $08
	ld   [wOBJInfo_CursorR+iOBJInfo_Y], a
	xor  a
	ret
.enter:
	; RetVal = wTitleMenuOptId+1
	; Will be TITLEMENU_TO_MODESELECT or TITLEMENU_TO_OPTIONS
	ld   a, [wTitleMenuOptId]
	inc  a
	scf			; Change mode
	ret
.exit:
	ld   a, TITLEMENU_TO_TITLE
	scf			; Change mode
	ret
	
; =============== Title_Mode_ModeSelect ===============
; Mode selection menu.
Title_Mode_ModeSelect:
	call ModeSelect_SetSerialIdle	; Every time so the GBs are always ready to listen to each other.
	call Title_BlinkCursorR
	call ModeSelect_DoCtrl
	jr   nc, .checkOtherPl			; No action returned? If so, jump
.chkAct:
	cp   MODESELECT_ACT_EXIT
	jp   z, TitleSubMenu_Exit
IF VER_96F
	; Fake 96 switches the two strings around
	cp   MODESELECT_ACT_TEAM1P
	jp   z, .single1P
	cp   MODESELECT_ACT_SINGLE1P
	jp   z, .team1P
ELSE
	cp   MODESELECT_ACT_SINGLE1P
	jp   z, .single1P
	cp   MODESELECT_ACT_TEAM1P
	jp   z, .team1P
ENDC
	cp   MODESELECT_ACT_SINGLEVS
	jp   z, .singleVS
	cp   MODESELECT_ACT_TEAMVS
	jp   z, .teamVS
	ret ; We never get here
.checkOtherPl:
	; Check if the other player (over serial only) sent us a mode id value.
	; If so, start the mode directly.
	call ModeSelect_GetCtrlFromSerial
	cp   MODESELECT_SBCMD_TEAMVS
	jp   z, .startTeamVS
	cp   MODESELECT_SBCMD_SINGLEVS
	jp   z, .startSingleVS
	ret
	
.single1P:
	; 1P Modes don't need special checks
	ld   a, MODE_SINGLE1P
	ld   [wPlayMode], a
	jp   ModeSelect_PrepSingle
.team1P:
	ld   a, MODE_TEAM1P
	ld   [wPlayMode], a
	jp   ModeSelect_PrepSingle
	
.singleVS:
	;
	; Verify that there's a second player
	;
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a		; Playing on SGB?
	jp   nz, .startSingleVS		; If so, skip the serial checks
	
	; [Master 1/3] Send out VS mode option
	ld   a, MODESELECT_SBCMD_SINGLEVS
	call ModeSelect_Serial_SendAndWait
	; Try to send the rest for sync
	call ModeSelect_TrySendVSData
	cp   MODESELECT_SBCMD_IDLE		; Did the other GB listen to the original request? 
	jr   z, .startSingleVS			; If so, jump
	ld   a, SFX_ERROR
	jp   HomeCall_Sound_ReqPlayExId
.startSingleVS:
	ld   a, MODE_SINGLEVS
	ld   [wPlayMode], a
	jp   ModeSelect_PrepVS
	
.teamVS:
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a		; Playing on SGB?
	jp   nz, .startTeamVS		; If so, skip the serial checks
	; [Master 1/3] Send out VS mode option
	ld   a, MODESELECT_SBCMD_TEAMVS
	call ModeSelect_Serial_SendAndWait
	; Try to send the rest for sync
	call ModeSelect_TrySendVSData
	cp   MODESELECT_SBCMD_IDLE		; Did the other GB listen to the original request? 
	jr   z, .startTeamVS			; If so, jump
	; Otherwise, play an error sound
	ld   a, SFX_ERROR
	jp   HomeCall_Sound_ReqPlayExId
.startTeamVS: 
	ld   a, MODE_TEAMVS
	ld   [wPlayMode], a
	jp   ModeSelect_PrepVS
	
; =============== ModeSelect_Prep* ===============
; Sets of functions to set which players are controlled by the CPU, depending on the mode.

ModeSelect_PrepSingle:
	; SGB-only, wJoyActivePl is always PL1 in DMG
	ld   a, [wJoyActivePl]
	cp   PL1		; Does player 1 have control?
	jp   nz, .pl2	; If not, jump
.pl1:
	; P1: Player, P2: CPU
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	res  PF0B_CPU, [hl]
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	set  PF0B_CPU, [hl]
	call ModeSelect_MakeStageSeq
	jp   ModeSelect_SwitchToCharSelect
.pl2:
	; P1: CPU, P2: Player
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	set  PF0B_CPU, [hl]
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	res  PF0B_CPU, [hl]
	call ModeSelect_MakeStageSeq
	jp   ModeSelect_SwitchToCharSelect
	
ModeSelect_PrepVS:
	; P1: Player, P2: Player
	; Removed in the English version since it gets done earlier.
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	res  PF0B_CPU, [hl]
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	res  PF0B_CPU, [hl]
	; No stage sequence in 2P mode
	ld   hl, wCharSeqId
	ld   [hl], $00
	jp   ModeSelect_SwitchToCharSelect

; [TCRF] Unreferenced code.
;        Sets up a CPU vs CPU battle in VS mode, which can't be triggered by one player.
ModeSelect_Unused_PrepVSCPU:
	; P1: CPU, P2: CPU
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	set  PF0B_CPU, [hl]
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	set  PF0B_CPU, [hl]
	; No stage sequence in 2P mode
	ld   hl, wCharSeqId
	ld   [hl], $00
	; Fall-through
	
ModeSelect_SwitchToCharSelect:
	call ModeSelect_CheckCPUvsCPU
	
	; Initialize character select vars
	ld   a, $00
	ld   [wLastWinner], a
	ld   [wUnused_ContinueUsed], a
	ld   a, $00
	ld   [wCharSelP1CursorPos], a
	ld   a, $05
	ld   [wCharSelP2CursorPos], a
	ld   a, $FF
	ld   [wCharSelP1Char0], a
	ld   [wCharSelP1Char1], a
	ld   [wCharSelP1Char2], a
	ld   [wCharSelP2Char0], a
	ld   [wCharSelP2Char1], a
	ld   [wCharSelP2Char2], a
	
	; Force cursor to be visible while waiting
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	
	; Wait $3C frames
	ld   b, $3C
.wait:
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .wait
	
	ld   hl, wMisc_C028
	res  MISCB_TITLE_SECT, [hl]		; Not necessary
	
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Reset screen coords
	xor  a
	ldh  [rWY], a
	ldh  [rWX], a
	ldh  [rSTAT], a
	
	; These two influence Rand and should be kept in sync across GBs
	ld   [wRand], a		
	ld   [wTimer], a
	
	; Jump to the character select screen
	ld   b, BANK(Module_CharSel) ; BANK $1E
	ld   hl, Module_CharSel
	jp   FarJump
	
; =============== ModeSelect_DoCtrl ===============
; Checks for player input in the mode select menu.
; OUT
; - C flag: If set, the returned value should be used
; - A: Action id (MODESELECT_ACT_*)
ModeSelect_DoCtrl:
	call Title_GetMenuInput
	bit  KEYB_START, a
	jp   nz, .select
	bit  KEYB_A, a
	jp   nz, .select
	bit  KEYB_SELECT, a
	jp   nz, .exit
	bit  KEYB_DOWN, b
	jp   nz, .moveD
	bit  KEYB_UP, b
	jp   nz, .moveU
	xor  a
	ret
.moveU:
	; Move cursor up, and wrap around
	ld   a, [wTitleSubMenuOptId]
	dec  a
	and  a, $03
	ld   [wTitleSubMenuOptId], a
	jp   .setYPos
.moveD:
	; Move cursor down, and wrap around
	ld   a, [wTitleSubMenuOptId]
	inc  a
	and  a, $03
	ld   [wTitleSubMenuOptId], a
.setYPos:
	; Set the cursor's Y position (Y = wTitleSubMenuOptId * 10) and show it, even if for a single frame
	; See also: SetCursorYPos on Options_DoCtrl
	swap a
	ld   [wOBJInfo_Pl1+iOBJInfo_Y], a
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	xor  a
	ret
.select:
	; A = wTitleSubMenuOptId + 1
	; MODESELECT_ACT_* follows the same order as the mode entries (which are identical to MODE_*)
	ld   a, [wTitleSubMenuOptId]
	inc  a
	scf
	ret
.exit:
	; Exit to GM_TITLE_TITLEMENU
	ld   a, MODESELECT_ACT_EXIT
	scf
	ret
	
; =============== Title_Mode_Options ===============
; Options menu.
Title_Mode_Options:
	;
	; Execute different code depending on the selected menu option.
	; Each jump target will handle controls its own way.
	;
	ld   hl, .targetPtrs			; HL = Jump Table	
	ld   d, $00
	ld   a, [wTitleSubMenuOptId]	; DE = wTitleSubMenuOptId * 2
	sla  a
	ld   e, a
	add  hl, de						; Index this table
	ld   e, [hl]					; E = Low byte target
	inc  hl
	ld   d, [hl]					; D = High byte target
	push de
	pop  hl							; Move DE to HL and jump there
	jp   hl
.targetPtrs:
	dw Options_Item_Time
	dw Options_Item_Level
	dw Options_Item_BGMTest
	dw Options_Item_SFXTest
	dw Options_Item_SGBSndTest
	dw Options_Item_Exit
	
; =============== mOptionMin ===============
; A = MIN(Value - 1, MinValue)
; IN
; - 1: Ptr to value
; - 2: Min value
; - 3: Target location on fail
MACRO mOptionMin
	ld   a, [\1]
	cp   \2			; Value == MinValue?
	jp   z, \3		; If so, skip
	dec  a			; Value--
ENDM

; =============== mOptionMax ===============
; A = MAX(Value + 1, MaxValue)
; IN
; - 1: Ptr to value
; - 2: Min value
; - 3: Target location on fail
MACRO mOptionMax
	ld   a, [\1]
	cp   \2			; Value == MaxValue?
	jp   z, \3		; If so, skip
	inc  a			; Value++
ENDM
	
; =============== Options_Item_Exit ===============
; EXIT option selected.
Options_Item_Exit:
	call Title_BlinkCursorR
	call Options_DoCtrl
	ret  nc
	cp   OPTIONS_ACT_EXIT		; Exiting the menu?
	jp   z, TitleSubMenu_Exit	; If so, exit
	cp   OPTIONS_ACT_A			; Pressed A on the EXIT option?
	jp   z, TitleSubMenu_Exit	; If so, exit
	ret
	
; =============== Options_Item_Time ===============	
Options_Item_Time:
	call Title_BlinkCursorR
	call Options_DoCtrl			; Check for current action
	ret  nc						; None specified? If so, return
	cp   OPTIONS_ACT_EXIT		; Act == OPTIONS_ACT_EXIT?
	jp   z, TitleSubMenu_Exit	; If so, jump
	cp   OPTIONS_ACT_L			; ...
	jp   z, .decTimer
	cp   OPTIONS_ACT_R
	jp   z, .incTimer
	ret
.decTimer:
	; Decrement the timer unless it reached the low limit.
	ld   a, [wMatchStartTime]
	cp   OPTIONS_TIMER_MIN		; Time == MinValue? 
	jp   z, .save				; If so, don't decrement
	; Special case to jump from the special Infinite value to the normal max
	cp   TIMER_INFINITE			; Time == Infinite?
	jp   nz, .doDec				; If not, jump
	ld   a, OPTIONS_TIMER_MAX					
	jp   .save
.doDec:
	sub  a, OPTIONS_TIMER_INC	; Time -= Interval
	jp   .save
.incTimer:
	; Increment the timer unless it's at the max.
	ld   a, [wMatchStartTime]	
	cp   TIMER_INFINITE			; Time == Infinite? 
	jp   z, .save				; If so, don't increment
	; Special case to jump from the normal max value to Infinite
	cp   OPTIONS_TIMER_MAX		; Time == MaxValue?
	jp   nz, .doInc				; If not, jump
	ld   a, TIMER_INFINITE
	jp   .save
.doInc:
	add  a, OPTIONS_TIMER_INC	; Time += Interval
.save:
	ld   [wMatchStartTime], a	; Save timer setting
	call Options_PrintMatchTime	; Update tilemap
	ret
	
; =============== Options_PrintMatchTime ===============
; Prints the current value of the match timer.
Options_PrintMatchTime:
	ld   a, [wMatchStartTime]
	cp   TIMER_INFINITE				; Infinite time set?
	jp   z, .infinite				; If so, jump
.num:
	ld   de, $98FE					; Otherwise print A as number
	call NumberPrinter_Instant
	ld   hl, TextDef_Options_ClrOff	; Remove "O" from OFF
	call TextPrinter_Instant
	ret
.infinite:
	ld   hl, TextDef_Options_Off	; Print "OFF"
	call TextPrinter_Instant
	ret
	
; =============== Options_Item_Level ===============	
Options_Item_Level:
	call Title_BlinkCursorR
	call Options_DoCtrl
	ret  nc
	cp   OPTIONS_ACT_EXIT
	jp   z, TitleSubMenu_Exit
	cp   OPTIONS_ACT_L
	jp   z, .dec
	cp   OPTIONS_ACT_R
	jp   z, .inc
	ret
.dec:
	mOptionMin wDifficulty, DIFFICULTY_EASY, .save
	jp   .save
.inc:
	mOptionMax wDifficulty, DIFFICULTY_HARD, .save
.save:
	ld   [wDifficulty], a
	call Options_PrintDifficulty
	ret
	
; =============== Options_PrintDifficulty ===============
; Prints the current difficulty setting.
Options_PrintDifficulty:
	ld   a, [wDifficulty]
	cp   DIFFICULTY_EASY
	jp   z, .easy
	cp   DIFFICULTY_NORMAL
	jp   z, .normal
	cp   DIFFICULTY_HARD
	jp   z, .hard
.easy:
	ld   hl, TextDef_Options_Easy
	call TextPrinter_Instant
	ret
.normal:
	ld   hl, TextDef_Options_Normal
	call TextPrinter_Instant
	ret
.hard:
	ld   hl, TextDef_Options_Hard
	call TextPrinter_Instant
	ret
	
; =============== Options_Item_BGMTest ===============	
Options_Item_BGMTest:
	call Title_BlinkCursorR
	call Options_DoCtrl
	ret  nc
	cp   $00
	jp   z, TitleSubMenu_Exit
	cp   $01
	jp   z, .dec
	cp   $02
	jp   z, .inc
	cp   $03
	jp   z, .play
	cp   $04
	jp   z, .stop
	ret ; We don't get here
.play:
	; Directly play the sound ID that appears on screen.
	ld   a, [wOptionsBGMId]
	ld   [wSndSet], a
	ret  
.stop:
	xor  a
	ld   [wSndSet], a
	ret  
.dec:
	mOptionMin wOptionsBGMId, BGM_NAKORURU, .save
	jp   .save
.inc:
	mOptionMax wOptionsBGMId, BGM_ENDING, .save
.save:
	ld   [wOptionsBGMId], a
	call Options_PrintBGMId
	ret	
	
; =============== Options_PrintBGMId ===============
; Prints the current BGM number.
Options_PrintBGMId:
	ld   a, [wOptionsBGMId]		; A = wOptionsBGMId
	ld   de, $997E				; DE = Location
	call NumberPrinter_Instant
	ret
	
; =============== Options_Item_SFXTest ===============
Options_Item_SFXTest:
	call Title_BlinkCursorR
	call Options_DoCtrl
	ret  nc
	cp   $00
	jp   z, TitleSubMenu_Exit
	cp   $01
	jp   z, .dec
	cp   $02
	jp   z, .inc
	cp   $03
	jp   z, .play
	cp   $04
	jp   z, .stop
	ret ; We don't get here
.play:
	; Directly play the sound ID that appears on screen.
	ld   a, [wOptionsSFXId]
	ld   [wSndSet], a
	ret  
.stop:
	xor  a
	ld   [wSndSet], a
	ret  
.dec:
	mOptionMin wOptionsSFXId, SFX_CURSORMOVE, .save
	jp   .save
.inc:
	mOptionMax wOptionsSFXId, SFX_PROJ_LG, .save
.save:
	ld   [wOptionsSFXId], a
	call Options_PrintSFXId
	ret	
; =============== Options_PrintSFXId ===============
; Prints the current SFX number.
Options_PrintSFXId:
	ld   a, [wOptionsSFXId]
	ld   de, $99BE
	call NumberPrinter_Instant
	ret
	
; =============== Options_Item_SGBSndTest ===============
Options_Item_SGBSndTest:
	;
	; There are two cursor modes here because selecting this option
	; activates a submenu.
	;
	ld   hl, .modePtrs			; HL = Jump table
	ld   d, $00
	ld   a, [wOptionsMenuMode]	; DE = wOptionsMenuMode
	ld   e, a
	add  hl, de						
	ld   e, [hl]					
	inc  hl
	ld   d, [hl]
	push de
	pop  hl
	jp   hl
  
.modePtrs:
 	dw SGBSndTest_Hover
	dw SGBSndTest_SubMenu
	
; =============== SGBSndTest_Hover =============== 
; When hovering over the main SGB Test option.
SGBSndTest_Hover:
	call Title_BlinkCursorR
	call Options_DoCtrl
	ret  nc
	cp   a, OPTIONS_ACT_EXIT
	jp   z, TitleSubMenu_Exit
	cp   a, OPTIONS_ACT_R
	jp   z, .enterSubMenu
	ret 
	
.enterSubMenu:
	; Start on leftmost option
	ld   a, $00
	ld   [wOptionsSGBSndOptId], a
	; Enter option
	ld   a, OPTION_MENU_SGBTEST
	ld   [wOptionsMenuMode], a
	; Show both cursors
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	; Set initial CursorU position for leftmost option
	ld   hl, wOBJInfo_CursorU+iOBJInfo_X
	ld   [hl], $3C
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Y
	ld   [hl], $60
	ret 
	
; =============== SGBSndTest_SubMenu =============== 
; Selecting a digit.
SGBSndTest_SubMenu:
	call Title_BlinkCursorU
	call Options_SGBSndTest_DoCtrl
	ret  nc
	cp   a, OPTIONS_SACT_EXIT
	jp   z, TitleSubMenu_Exit
	cp   a, OPTIONS_SACT_UP
	jp   z, SGBSndTest_Act_DecNum
	cp   a, OPTIONS_SACT_DOWN
	jp   z, SGBSndTest_Act_IncNum
	cp   a, OPTIONS_SACT_A
	jp   z, SGBSndTest_Act_PlaySound
	cp   a, OPTIONS_SACT_B
	jp   z, SGBSndTest_Act_StopSound
	cp   a, OPTIONS_SACT_SUBEXIT
	jp   z, SGBSndTest_Act_Exit
	ret ; We never get here
	
; =============== SGBSndTest_SubMenu =============== 
; Returns to the main options selection.
SGBSndTest_Act_Exit:
	ld   a, $00						; Reset CursorU pos
	ld   [wOptionsSGBSndOptId], a
	ld   a, OPTION_MENU_NORMAL		; Back to options
	ld   [wOptionsMenuMode], a
	; Hide up cursor
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret  
	
; =============== SGBSndTest_Act_DecNum =============== 
; Decreases the selected option digit.
SGBSndTest_Act_DecNum:                  
	; Get the address where the number is stored
	ld   a, [wOptionsSGBSndOptId]		; D = OptionId
	ld   d, a
	call SGBSndTest_GetOptPtr			; HL = Option value
	
	ld   a, [hl]						; A = Current digit
	bit  0, d							; Editing the bank number? (OptionId == 1 || OptionId == 3)
	jp   nz, .dec						; If so, always decrease it (allow wraparound)
.isSet:
	cp   a, $00							; Digit == $00?
	jp   z, SGBSndTest_Act_IncNum.end	; If so, skip
.dec:
	dec  a								; Digit--
	ld   [hl], a						; Save it back
	jp   SGBSndTest_Act_IncNum.end
	
; =============== SGBSndTest_Act_DecNum =============== 
; Increases the selected option digit.
SGBSndTest_Act_IncNum:
	; Get the address where the number is stored
	ld   a, [wOptionsSGBSndOptId]	; D = OptionId
	ld   d, a
	call SGBSndTest_GetOptPtr		; HL = Option value
	
	; There are different upper limits for each number.
	; The bit checks work due to how the Option IDs are ordered.
	ld   a, [hl]			; A = Current digit
	bit  0, d				; Editing the bank number? (OptionId == 1 || OptionId == 3)
	jp   nz, .inc			; If so, always increase (allow wraparound)
	bit  1, d				; Is this for Set B? (OptionId == 2 || OptionId == 3)
	jp   nz, .setB			; If so, jump
.setA:
	cp   a, $30				; Set A max sound ID
	jp   z, .end			; A == $30? If so, don't increase it
	jp   .inc
.setB:
	cp   a, $19				; Set B max sound ID
	jp   z, .end			; A == $19? If so, don't increase it
.inc:
	inc  a					; Digit++
	ld   [hl], a			; Save it back
.end:
	call Options_PrintSGBSndTestVals
	ret  
	
; =============== SGBSndTest_Act_PlaySound =============== 
SGBSndTest_Act_PlaySound:
	ld   a, [wOptionsSGBSndOptId]
	bit  1, a							; Set B selected?
	jp   nz, .setB						; If so, jump
.setA:
	; Set the options in the SGB packet.
	ld   hl, wOptionsSGBPacketSndIdA	; HL = Ptr to SGB Sound Packet byte1
	; Set A Sound ID
	ld   a, [wOptionsSGBSndIdA]			; wOptionsSGBPacketSndIdA = wOptionsSGBSndIdA
	ldi  [hl], a						
	; Nothing in Set B
	ld   a, $00							; wOptionsSGBPacketSndIdB = 0
	ldi  [hl], a				
	; Low nybble -> Bank number for Set A
	ld   a, [wOptionsSGBSndBankA]		; wOptionsSGBPacketSndBank = wOptionsSGBSndBankA & $0F
	and  a, $0F							; filter valid values
	ldi  [hl], a
	jp   .sendPkg
.setB:
	ld   hl, wOptionsSGBPacketSndIdA	; HL = Ptr to SGB Sound Packet byte1
	; Nothing in Set A
	ld   a, $80							; wOptionsSGBPacketSndIdA = $80
	ldi  [hl], a
	; Set B Sound ID
	ld   a, [wOptionsSGBSndIdB]			; wOptionsSGBPacketSndIdB = wOptionsSGBSndIdB
	ldi  [hl], a
	; High nybble -> Bank number for Set B
	ld   a, [wOptionsSGBSndBankB]		; wOptionsSGBPacketSndBank = (wOptionsSGBSndBankB & $0F) << 4
	and  a, $0F							; filter valid values
	swap a
	ldi  [hl], a
.sendPkg:
	call Task_PassControl_NoDelay
	ld   hl, wOptionsSGBPacketSnd
	call SGB_SendPackets
	ret  
	
; =============== SGBSndTest_Act_StopSound =============== 
SGBSndTest_Act_StopSound:
	call Task_PassControl_NoDelay
	ld   hl, SGBPacket_Options_StopSnd
	call SGB_SendPackets
	ei   
	ret  
	
; =============== SGBSndTest_GetOptPtr ===============
; HL = wOptionsSGBBase[wOptionsSGBSndOptId]
; OUT
; - HL: Ptr to value of the currently selected option
SGBSndTest_GetOptPtr:
	; The current values for the four SGB options start at wOptionsSGBBase.
	; They are ordered by OPTION_SITEM_*, so getting their address is like indexing a table.
	ld   hl, wOptionsSGBBase		; HL = Starting address
	ld   a, [wOptionsSGBSndOptId]	; BC = SGB Option Id
	ld   b, $00
	ld   c, a
	add  hl, bc						; Index it
	ret
	
; =============== Options_PrintSGBSndTestVals ===============
; Prints the digits displayed in the SGB sound test.
Options_PrintSGBSndTestVals:

	; SGB Mode only
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a
	jp   z, .ret
	
	; Don't print if the SGB sound test isn't enabled
	ld   a, [wDipSwitch]
	bit  DIPB_SGB_SOUND_TEST, a
	jp   z, .ret
	
	; Print out all of the digits
	ld   a, [wOptionsSGBSndIdA]
	ld   de, $9A56
	call NumberPrinter_Instant
	
	ld   a, [wOptionsSGBSndBankA]
	ld   de, $9A58
	call NumberPrinter_Instant
	
	ld   a, [wOptionsSGBSndIdB]
	ld   de, $9A5C
	call NumberPrinter_Instant
	
	ld   a, [wOptionsSGBSndBankB]
	ld   de, $9A5E
	call NumberPrinter_Instant
	
	; Blank out high digit of banks A & B
	ld   hl, TextDef_Options_ClrSGBSndA
	call TextPrinter_Instant
	ld   hl, TextDef_Options_ClrSGBSndB
	call TextPrinter_Instant
.ret:
	ret 
	
; =============== Options_PrintDipSwitch ===============
; Prints the current dip switch value.
Options_PrintDipSwitch:
	; Don't reveal the feature if no dipswitches are enabled.
	ld   a, [wDipSwitch]
	or   a					; wDipSwitch == 0?
	jp   z, .ret			; If so, return
.ok:
	ld   de, $9ABE
	call NumberPrinter_Instant
.ret:
	ret
	
; =============== Options_DoCtrl ===============
; Checks for player input in the options menu.
; OUT
; - C flag: If set, the returned value should be used
; - A: Action id (OPTIONS_ACT_*), handled by the option-specific code
Options_DoCtrl:
	call Title_GetMenuInput
	bit  KEYB_START, a
	jp   nz, Options_DoCtrl_Exit
	bit  KEYB_SELECT, a
	jp   nz, Options_DoCtrl_Exit
	bit  KEYB_B, a
	jp   nz, Options_DoCtrl_PressB
	bit  KEYB_DOWN, b
	jp   nz, Options_DoCtrl_MoveD
	bit  KEYB_UP, b
	jp   nz, Options_DoCtrl_MoveU
	bit  KEYB_LEFT, b
	jp   nz, Options_DoCtrl_MoveL
	bit  KEYB_RIGHT, b
	jp   nz, Options_DoCtrl_MoveR
	bit  KEYB_A, b
	jp   nz, Options_DoCtrl_PressA
	xor  a
	ret
	
; =============== Options_DoCtrl_Exit ===============
Options_DoCtrl_Exit:
	ld   a, OPTIONS_ACT_EXIT	; Action
	scf							; Enable action
	ret
; =============== Options_DoCtrl_MoveU ===============
Options_DoCtrl_MoveU:
	;
	; Wrap around from OPTION_ITEM_TIME to OPTION_ITEM_EXIT
	;
	ld   a, [wTitleSubMenuOptId]
	or   a							; Are we over the highest option? (OPTION_ITEM_TIME)
	jp   nz, .chkOpen				; If not, jump
	ld   a, OPTION_ITEM_EXIT		; Otherwise, wrap around
	jp   .end
.chkOpen:
	;
	; Skip the SGB sound test option if it's disabled
	;
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]			; Are we in SGB mode?
	jp   z, .noSGBTest				; If not, jump
	ld   hl, wDipSwitch
	bit  DIPB_SGB_SOUND_TEST, [hl]	; Is the SGB sound test enabled?
	jp   nz, .moveUp				; If so, we can always move up
.noSGBTest:
	; If we got here there's no SGB sound test, so skip it
	cp   OPTION_ITEM_EXIT			; Are we over the EXIT option?
	jp   nz, .moveUp				; If not, move up
	ld   a, OPTION_ITEM_SFXTEST		; Otherwise, skip directly to SFX Test
	jp   .end
.moveUp:
	dec  a							; Move selected option up		
.end:
	ld   [wTitleSubMenuOptId], a
	jp   Options_DoCtrl_SetCursorYPos
	
; =============== Options_DoCtrl_MoveD ===============
Options_DoCtrl_MoveD:
	;
	; Wrap around from OPTION_ITEM_EXIT to OPTION_ITEM_TIME
	;
	ld   a, [wTitleSubMenuOptId]
	cp   OPTION_ITEM_EXIT			; Are we over the lowest option?
	jp   nz, .chkOpen				; If not, jump
	ld   a, OPTION_ITEM_TIME		; Otherwise, wrap around
	jp   .end
.chkOpen:
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]			; Are we in SGB mode?
	jp   z, .noSGBTest				; If not, jump
	ld   hl, wDipSwitch
	bit  DIPB_SGB_SOUND_TEST, [hl]	; Is the SGB sound test enabled?
	jp   nz, .moveDown				; If so, we can always move down
.noSGBTest:
	; If we got here there's no SGB sound test, so skip it
	cp   OPTION_ITEM_SFXTEST		; Are we over the SFX Test option?
	jp   nz, .moveDown				; If not, move down
	ld   a, OPTION_ITEM_EXIT		; Otherwise, skip directly to EXIT
	jp   Options_DoCtrl_MoveU.end	; (Does the same thing as the line below)
	jp   .end						; [TCRF] Unreachable duplicate jump
.moveDown:
	inc  a							; Move selected option down
.end:
	ld   [wTitleSubMenuOptId], a
	; Fall-through
; =============== Options_DoCtrl_SetCursorYPos ===============
; Common code for setting the new cursor Y position.
; The X position is never changed in menus.
; IN
; - A: wTitleSubMenuOptId
Options_DoCtrl_SetCursorYPos:
	cp   OPTION_ITEM_EXIT			; Are we now over the EXIT option?
	jp   nz, .otherY				; If not, jump
.exitY:
	ld   a, $68						; Otherwise, Y pos = $68
	jp   .setY
.otherY:
	; ID trickery.
	; The menu options (outside of EXIT) are positioned in a way so that:
	; CursorY = wTitleSubMenuOptId * 4
	swap a
.setY:
	ld   [wOBJInfo_CursorR+iOBJInfo_Y], a		; Set the Y cursor
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]						; Force cursor visibility, at least for 1 frame
	xor  a
	ret
; =============== Options_DoCtrl_MoveL ===============
Options_DoCtrl_MoveL:
	ld   a, OPTIONS_ACT_L
	scf
	ret
; =============== Options_DoCtrl_MoveR ===============
Options_DoCtrl_MoveR:
	ld   a, OPTIONS_ACT_R
	scf
	ret
; =============== Options_DoCtrl_PressA ===============
Options_DoCtrl_PressA:
	ld   a, OPTIONS_ACT_A
	scf
	ret
; =============== Options_DoCtrl_PressB ===============
Options_DoCtrl_PressB:
	ld   a, OPTIONS_ACT_B
	scf
	ret
	
	
; =============== Options_SGBSndTest_DoCtrl ===============	
; Special version of Options_DoCtrl used for the SGB Sound Test.
; This uses an up cursor moving horizontally, so movement is handled differently.
; OUT
; - C flag: If set, the returned value should be used
; - A: Action id (OPTIONS_SACT_*), handled by the option-specific code
Options_SGBSndTest_DoCtrl:
	call Title_GetMenuInput
	bit  KEYB_START, a
	jp   nz, .exit
	bit  KEYB_SELECT, a
	jp   nz, .exit
	bit  KEYB_LEFT, a
	jp   nz, .moveL
	bit  KEYB_RIGHT, a
	jp   nz, .moveR
	bit  KEYB_B, a
	jp   nz, .b
	bit  KEYB_DOWN, b
	jp   nz, .down
	bit  KEYB_UP, b
	jp   nz, .up
	bit  KEYB_A, b
	jp   nz, .a
	xor  a
	ret
.exit:
	ld   a, OPTIONS_SACT_EXIT
	scf  
	ret  
.up:
	ld   a, OPTIONS_SACT_UP
	scf  
	ret  
.down:
	ld   a, OPTIONS_SACT_DOWN
	scf  
	ret  
.a:
	ld   a, OPTIONS_SACT_A
	scf  
	ret  
.b:
	ld   a, OPTIONS_SACT_B
	scf  
	ret  
;--
.moveL:
	; If we're moving left from the leftmost option, signal out the exit from the submenu
	ld   a, [wOptionsSGBSndOptId]
	cp   a, OPTION_SITEM_ID_A		; OptionId == 0?
	jp   z, .leftMin				; If so, jump
	; Otherwise decrement the option
	dec  a				
	and  a, $03						; And force it in range ($00-$03)
	jp   .setCursorXPos
.leftMin:
	ld   a, OPTIONS_SACT_SUBEXIT
	scf  
	ret 
;--
.moveR:
	; If we're moving right from the leftmost option, ignore it
	ld   a, [wOptionsSGBSndOptId]
	cp   a, OPTION_SITEM_BANK_B		; OptionId == $03?
	jp   z, .setCursorXPos			; If so, jump
	; Otherwise increment the option
	inc  a
	and  a, $03						; And force it in range ($00-$03)
	
.setCursorXPos:
	;
	; Determine the up cursor's X position.
	; Unlike Options_DoCtrl, there's no trickery here, it's just a series of id checks.
	;
	ld   [wOptionsSGBSndOptId], a
	cp   a, OPTION_SITEM_BANK_A		; OptionId == $01?
	jp   z, .x1						; If so, jump
	cp   a, OPTION_SITEM_ID_B		; ...
	jp   z, .x2
	cp   a, OPTION_SITEM_BANK_B
	jp   z, .x3
	; Otherwise, OptionId == $00
.x0:
	ld   a, $3C
	jp   .saveX
.x1:
	ld   a, $50
	jp   .saveX
.x2:
	ld   a, $6C
	jp   .saveX
.x3:
	ld   a, $80
.saveX:
	; Show up cursor and set its position
	ld   [wOBJInfo_CursorU+iOBJInfo_X], a
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	xor  a
	ret
	
; =============== TitleSubMenu_Exit ===============
; Exits from the mode select or options menu back to the title menu.
TitleSubMenu_Exit:
	
	; Disable serial (Mode Select)
	xor  a
	ldh  [rSB], a
	
	; Stop DMG sound (for options)
	ld   [wSndSet], a
	
	; Reset DMG pal
	ld   a, $FF
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Next mode
	ld   a, GM_TITLE_TITLEMENU
	ld   [wTitleMode], a
	
	; Load GFX
	ld   b, BANK(Title_LoadVRAM_Mini) ; BANK $1D
	ld   hl, Title_LoadVRAM_Mini
	rst  $08
	
	; Enable title screen parallax mode
	ld   hl, wMisc_C028
	set  MISCB_TITLE_SECT, [hl]
	
	; Restore cursor position & visibility
	ld   a, [wTitleMenuCursorXBak]
	ld   [wOBJInfo_CursorR+iOBJInfo_X], a
	ld   a, [wTitleMenuCursorYBak]
	ld   [wOBJInfo_CursorR+iOBJInfo_Y], a
	ld   hl, wOBJInfo_CursorR+iOBJInfo_OBJLstPtrTblOffset
	ld   [hl], TITLE_OBJ_CURSOR_R*OBJLSTPTR_ENTRYSIZE
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	
	; Hide vertical cursor
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	
	; Show menu text and SNK copyright
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ld   hl, wOBJInfo_SnkText+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	
	; Reset cloud layer position, same values as the title init code
IF VER_EN
	ld   a, $10
	ld   [wOBJScrollY], a
	ld   a, $A8
	ldh  [hScrollY], a	
ELSE
	ld   a, $98 		
	ldh  [hScrollY], a
	ld   a, $00
	ld   [wOBJScrollY], a
ENDC
	
	; Enable WINDOW
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	; Enable LYC interrupt
	ldh  a, [rSTAT]
	or   a, STAT_LYC
	ldh  [rSTAT], a
IF VER_EN
	ld   a, $56			; Same as title init code
ELSE
	ld   a, $66
ENDC
	ldh  [rLYC], a
	ldh  a, [rIE]
	or   a, I_STAT|I_VBLANK
	ldh  [rIE], a
	
	call Task_PassControl_NoDelay
	
	; Set DMG title pal
	ld   a, $3F
	ldh  [rOBP0], a
	ld   a, $00
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	ret

; =============== TitleScreen_IsStartPressed ===============
; OUT
; - C flag: If set, START was pressed on either controller
TitleScreen_IsStartPressed:
	; Serial is disabled, so hJoyNewKeys2 will only come from the SGB side.
	
	; Whoever presses START on the PUSH START screen takes control of the main menu,
	; while the other player won't be able to do anything.
	
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a		; Pressing START on P1 side?
	jp   nz, .pressed1		; If so, jump
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a		; Pressing START on P2 side?	
	jp   nz, .pressed2		; If so, jump
.notPressed:
	xor  a					; C = 0, not pressed
	ret
.pressed1:
	ld   a, PL1				; Player 1 pressed it
	ld   [wJoyActivePl], a
	scf						; C = 1, pressed
	ret
.pressed2:
	ld   a, PL2				; Player 2 pressed it
	ld   [wJoyActivePl], a
	scf						; C = 1, pressed
	ret
	
; =============== ModeSelect_CheckCPUvsCPU ===============
; [POI] Handles the secret where holding B when selecting a mode activates a CPU vs CPU battle.
ModeSelect_CheckCPUvsCPU:

	; Curiously, there's no serial check in the Japanese version.
	; It doesn't matter anyway, since with serial, the opponent's inputs aren't sent in the Mode Select screen.
IF VER_EN
	ld   a, [wMisc_C025]
	bit  MISCB_SERIAL_MODE, a		; Setting up a VS battle?
	ret  nz							; If so, return
ENDC

	; Check both controllers
	ldh  a, [hJoyKeys]
	bit  KEYB_B, a					; Holding B on controller 1?
	jp   z, .chkPl2					; If not, jump
	ld   hl, wPlInfo_Pl1+iPlInfo_Flags0
	set  PF0B_CPU, [hl]				; Otherwise, set P1 as CPU
.chkPl2:
	ldh  a, [hJoyKeys2]
	bit  KEYB_B, a					; Holding B on controller 2?
	jp   z, .ret					; If not, jump
	ld   hl, wPlInfo_Pl2+iPlInfo_Flags0
	set  PF0B_CPU, [hl]				; Otherwise, set P2 as CPU
.ret:
	ret
	
; =============== Title_GetMenuInput ===============
; Gets the player input for the menu screens.
; This merges the key info from the delayed held input fields set in JoyKeys_DoCursorDelayTimer.
; OUT
; - B: Pressed KEY_*
Title_GetMenuInput:
	
	;
	; Pick the controller from the active side
	;
	ld   a, [wJoyActivePl]
	cp   PL1					; Is pad 1 active?
	jp   nz, .usePl2			; If not, jump
.usePl1:
	ld   hl, hJoyKeys			; HL = Controller 1 input
	jp   .getKeys
.usePl2:
	ld   hl, hJoyKeys2			; HL = Controller 2 input

.getKeys:

	;
	; If we're holding any key, force blinking sprites to be visible (in practice, the cursor)
	;
	ld   a, [hl]				; A = Held keys
	or   a						; Holding anything?
	jp   z, .calcKeys			; If not, skip
	xor  a						; Otherwise, reset the blink timer
	ld   [wTitleBlinkTimer], a
	
.calcKeys:
	inc  hl						; Seek to hJoyNewKeys
	ld   a, [hl]				; A = Newly pressed keys
	push af
		inc  hl
		inc  hl					; Seek to hJoyKeysDelayTbl
		
		;
		; Merge back the bits in the 8 iKeyMenuHeld fields into a into a KEY_* bitmask.
		;
		
		; For each DelayTbl entry mark the MSB if needed and rotate left.
		
		ld   b, $00				; B = Output KEY_* mask
		ld   c, $08				; C = Bits in byte
	.loop:
		ldi  a, [hl]			; A = iKeyMenuHeld
		inc  hl					; Skip to next entry
		; Only use key entries with value $01, which means that either:
		; - The key was just pressed
		; - The delay countdown reached 0, which set the key entry to $01
		cp   $01				; iKeyMenuHeld == $01?
		jp   nz, .next			; If not, skip
		set  7, b				; Set the MSB
	.next:
		rlc  b					; Next bit (<<R 1)
		dec  c					; BitsLeft--
		jp   nz, .loop			; Are we done? If not, loop
	pop  af
	ret
	
; =============== TitleScreen_BlinkPushStartText ===============
; Blinks the PUSH START text every $10 frames.
TitleScreen_BlinkPushStartText:
	ld   a, [wTitleBlinkTimer]		; Timer++
	inc  a
	ld   [wTitleBlinkTimer], a
	bit  4, a						; Timer & $10 == 0?
	jp   z, .show					; If so, show it
.hide:								; Otherwise, hide it
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret
.show:
	ld   hl, wOBJInfo_MenuText+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ret
; =============== Title_BlinkCursorR ===============
; Blinks the horizontal cursor every $08 frames.
Title_BlinkCursorR:
	ld   a, [wTitleBlinkTimer]		; Timer++
	inc  a
	ld   [wTitleBlinkTimer], a
	bit  3, a						; Timer & $08 == 0?
	jp   z, .show					; If so, show it
.hide:								; Otherwise, hide it
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret
.show:
	ld   hl, wOBJInfo_CursorR+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ret
; =============== Title_BlinkCursorU ===============
; Blinks the vertical cursor every $08 frames.
Title_BlinkCursorU:
	ld   a, [wTitleBlinkTimer]		; Timer++
	inc  a
	ld   [wTitleBlinkTimer], a
	bit  3, a						; Timer & $08 == 0?
	jp   z, .show					; If so, show it
.hide:								; Otherwise, hide it
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret
.show:
	ld   hl, wOBJInfo_CursorU+iOBJInfo_Status
	set  OSTB_VISIBLE, [hl]
	ret
	
; =============== Title_UpdateParallaxCoords ===============
; Updates the positions of the entire cloud layer for the parallax effect.
Title_UpdateParallaxCoords:

	;
	; Move the clouds right by scrolling the BG left at 0.25px frame.
	;
	ld   hl, hScrollX	; DE = hScrollX
	ld   d, [hl]
	inc  hl
	ld   e, [hl]
	
	ld   hl, -$0040		; DE -= $00.40
	add  hl, de
IF VER_96F
	; The cloud layer doesn't scroll here, DE stays the same
	nop
	nop
ELSE
	push hl
	pop  de
ENDC

	
	ld   hl, hScrollX	; hScrollX = DE
	ld   [hl], d
	inc  hl
	ld   [hl], e
	ret
	
; =============== ModeSelect_MakeStageSeq ===============
; Generates the sequence of opponents to fight in 1P modes.
ModeSelect_MakeStageSeq:
	; Reset starting stage
	ld   hl, wCharSeqId
	ld   [hl], $00
	
	;
	; Fill the sequence with $FF values.
	;
	ld   b, $12				; B = Total number of opponents
	ld   hl, wCharSeqTbl	; HL = Ptr to start of table
	ld   a, $FF				; A = Overwrite with
.fillLoop:
	ldi  [hl], a			
	dec  b
	jp   nz, .fillLoop
	
	;
	; Randomize the first 14 opponents (all of the normal ones).
	;
	
	; This is done by going through character IDs from highest allowed to lowest,
	; and placing that character in a randomly generated slot in wCharSeqTbl.
	ld   b, $0E				; B = Current CHAR_ID_* / Remaining chars
.getRand:
	call RandLY				; A = Random opponent slot
	and  a, $0F				; Filter valid IDs only
	cp   $0F				; Did we get Saisyu's slot? ($0F's character in the sequence)
	jp   z, .getRand		; If so, reroll again
	
	; HL = Ptr to generated slot
	ld   d, $00				; DE = Current index
	ld   e, a
	ld   hl, wCharSeqTbl	; HL = wCharSeqTbl
	add  hl, de				; Index it
	
	; Avoid overwriting already filled slots, which don't have the $FF placeholder anymore
	ld   a, [hl]			; A = SlotVal
	cp   $FF				; SlotVal != $FF?
	jp   nz, .getRand		; If so, reroll
	
.setCharId:
	ld   [hl], b			; Write value
	dec  b					; CharsLeft--
	ld   a, b				
	cp   $FF				; CharsLeft < 0?
	jp   nz, .getRand		; If not, generate the next one
	
	;
	; Add the 2 bosses and the secret at the end.
	;
	ld   hl, wCharSeqTbl+$0F
	ld   [hl], CHAR_ID_SAISYU/2 ; STAGESEQ_SAISYU
	inc  hl
	ld   [hl], CHAR_ID_RUGAL/2 ; STAGESEQ_RUGAL
	inc  hl
	ld   [hl], CHAR_ID_NAKORURU/2 ; STAGESEQ_NAKORURU
	ret
	
OBJInfoInit_Title: 
	db OST_VISIBLE
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
	db BANK(OBJLstPtrTable_Title)
	db LOW(OBJLstPtrTable_Title)
	db HIGH(OBJLstPtrTable_Title)
	db TITLE_OBJ_PUSHSTART*OBJLSTPTR_ENTRYSIZE ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNumView
	db LOW(OBJLstPtrTable_Title) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_Title) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High
	
INCLUDE "data/objlst/title.asm"

TextDef_Menu_Title:
	dw $98C4
	mTxtDef "GAME SELECT"
	
; Fake 96 switches around the two strings, and alters the code to account for it. (see Title_Mode_ModeSelect)
TextDef_Menu_SinglePlay:
	dw $9924
IF VER_96F
	mTxtDef "TEAM PLAY"
ELSE
	mTxtDef "SINGLE PLAY"
ENDC

TextDef_Menu_TeamPlay:
	dw $9964
IF VER_96F
	mTxtDef "SINGLE PLAY"
ELSE
	mTxtDef "TEAM PLAY"
ENDC

TextDef_Menu_SingleVS: 
	dw $99A4
	mTxtDef "SINGLE VS"
TextDef_Menu_TeamVS:
	dw $99E4
	mTxtDef "TEAM VS"
TextDef_Options_Title:
	dw $98B7
	mTxtDef "OPTION"
TextDef_Options_Time:
	dw $98F4
	mTxtDef "TIME      XX"
TextDef_Options_Level:
	dw $9934
	mTxtDef "LEVEL NORMAL"
TextDef_Options_BGMTest:
	dw $9974
	mTxtDef "BGM TEST  XX"
TextDef_Options_SFXTest:
	dw $99B4
	mTxtDef "S.E.TEST  XX"
TextDef_Options_SGBSndTest:
	dw $99F4
	mTxtDef "SGB S.E.TEST"
TextDef_Options_Exit:
	dw $9A94
	mTxtDef "EXIT"
TextDef_Options_Dip:
	dw $9AB8
	mTxtDef "DIPSW-00"
TextDef_Options_Off:
	dw $98FD
	mTxtDef "OFF"
; Removes the O from OFF when printing a number
TextDef_Options_ClrOff:
	dw $98FD
	mTxtDef " "
TextDef_Options_Easy:
	dw $993A
	mTxtDef "  EASY"
TextDef_Options_Normal:
	dw $993A
	mTxtDef "NORMAL"
TextDef_Options_Hard:
	dw $993A
	mTxtDef "  HARD"
TextDef_Options_SGBSndTypes:
	dw $9A36
	mTxtDef "SE-A  SE-B"
TextDef_Options_SGBSndPlaceholders: 
	dw $9A56
	mTxtDef "XX X  XX X"

; NumberPrinter_Instant always prints two digits.
; These spaces are used to cover the upper digit for the SGB sound test.
TextDef_Options_ClrSGBSndA:
	dw $9A58
	mTxtDef " "
TextDef_Options_ClrSGBSndB:
	dw $9A5E
	mTxtDef " "
	
; =============== SGBPacket_Options_PlaySnd ===============
; Used to play a SGB sound in the SGB Sound Test.
; This is copied to RAM to allow updating the bytes marking the Sound IDs to play.

SGBPacketDef_Options_PlaySnd: 
	db SGBPacket_Options_PlaySnd.end-SGBPacket_Options_PlaySnd ; Copy $10 bytes
SGBPacket_Options_PlaySnd:
	pkg SGB_PACKET_SOUND, $01
	db $00 ; wOptionsSGBPacketSndIdAA
	db $00 ; wOptionsSGBPacketSndIdAB
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
.end:

; =============== SGBPacket_Options_StopSnd ===============
; Used to stop any SGB Sound currently playing.
SGBPacket_Options_StopSnd:
	pkg SGB_PACKET_SOUND, $01
	db $80 ; Stop A
	db $80 ; Stop B
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00

; 
; =============== END OF MODULE Title ===============
;

; 
; =============== START OF MODULE CharSel ===============
;

GFXDef_CharSel_BG0: mGfxDef "data/gfx/charsel_bg0.bin"

IF VER_96F
; Altered cross and placeholder slots
GFXDef_CharSel_BG1: mGfxDef "data/gfx/96f/charsel_bg1.bin"
GFXDef_CharSel_Cross: mGfxDef "data/gfx/96f/charsel_cross.bin"
GFX_CharSel_Cross_Mask: INCBIN "data/gfx/96f/charsel_cross_mask.bin"
ELSE
GFXDef_CharSel_BG1: mGfxDef "data/gfx/charsel_bg1.bin"
GFXDef_CharSel_Cross: mGfxDef "data/gfx/charsel_cross.bin"
GFX_CharSel_Cross_Mask: INCBIN "data/gfx/charsel_cross_mask.bin"
ENDC

GFXDef_CharSel_OBJ: mGfxDef "data/gfx/charsel_obj.bin"

OBJInfoInit_CharSel_Cursor: 
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
	db BANK(OBJLstPtrTable_CharSel_Cursor) ; iOBJInfo_BankNum (BANK $1E)
	db LOW(OBJLstPtrTable_CharSel_Cursor) ; iOBJInfo_OBJLstPtrTbl_Low
	db HIGH(OBJLstPtrTable_CharSel_Cursor) ; iOBJInfo_OBJLstPtrTbl_High
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_BankNumView (N/A)
	db LOW(OBJLstPtrTable_CharSel_Cursor) ; iOBJInfo_OBJLstPtrTbl_LowView
	db HIGH(OBJLstPtrTable_CharSel_Cursor) ; iOBJInfo_OBJLstPtrTbl_HighView
	db $00 ; iOBJInfo_OBJLstPtrTblOffset
	db $00 ; iOBJInfo_ColiBoxId (auto)
	db $00 ; iOBJInfo_HitboxId (auto)
	db $00 ; iOBJInfo_ForceHitboxId
	db $00 ; iOBJInfo_FrameLeft
	db $00 ; iOBJInfo_FrameTotal
	db LOW(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_Low
	db HIGH(wGFXBufInfo_Pl1) ; iOBJInfo_BufInfoPtr_High

INCLUDE "data/objlst/charsel.asm"
		
; =============== Module_CharSel ===============
; EntryPoint for character select screen.
Module_CharSel:
	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   hl, wMisc_C028
	; Not gameplay yet
	res  MISCB_USE_SECT, [hl]
	
	
	; Mark every character as unlocked
	xor  a
	ld   hl, wCharSelIdMapTbl						; HL = Destination
	ld   b, wCharSelIdMapTbl_End-wCharSelIdMapTbl	; B = Bytes to wipe
.clInitLoop:
	ldi  [hl], a
	dec  b
	jp   nz, .clInitLoop
	
	; Reset palette as usual
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Init
	ld   [wCharSelTeamFull], a
	ld   [wCharSelP1CursorMode], a
	ld   [wCharSelP2CursorMode], a
	ld   [wCharSelCurPl], a
	ld   [wCharSelRandom1P], a
	ld   [wCharSelRandom2P], a
	
	
	; Set the delay timers used to ranzomize the cursor before picking the character.
	;
	; For both players, it may take anything between $07 and $26 frames
	; before the CPU picks the next character in the sequence:
	; Delay = (Rand & $1F) + 7
	;
	; See also: CharSel_SetRandomPortrait
	call Rand
	and  a, $1F
	add  a, $07
	ld   [wCharSelRandomDelay1P], a
	
	; wCharSelRandomDelay2P = (Rand & $1F) + 7
	call Rand
	and  a, $1F
	add  a, $07
	ld   [wCharSelRandomDelay2P], a
	
	;--
	;
	; In single modes, the CPU *opponent* (the inactive side) has the autopicker enabled
	; to have it automatically select the characters in the previously generated CPU sequence.
	;
	; This behaviour is toggled by wCharSelRandom1P and wCharSelRandom2P, and can be
	; also enabled by 1P/2P through a button combination (though it skips the sequence code and does set random characters)
	; 	
	

	ld   a, [wPlayMode]
	bit  MODEB_VS, a			; Is VS mode?
	jp   nz, .initVSMode		; If so, jump
	
.init1PMode:
	;
	; Check which player is the CPU opponent.
	; See also: CharSelect_IsCPUOpponent
	;
	ld   a, [wJoyActivePl]
	or   a						; Playing on the Pl1 side? (== PL1)
	jp   z, .cpu2P				; If so, jump
.cpu1P:
	; We're playing on the 2P side, and the CPU is 1P
	
	ld   a, $01							; 1P CPU autopicks team
	ld   [wCharSelRandom1P], a
	
	;
	; If the CPU lost, clear out its selected opponents.
	; Since wCharSelRandom1P is set, a new set of opponents will be quickly filled in (elsewhere).
	;
	ld   hl, wCharSelP1Char0			; HL = Team start
	ld   de, wCharSelP1CursorPos		; DE = Cursor position
	
	ld   a, [wLastWinner]		
	bit  PLB1, a						; Did the CPU win?
	jp   z, .clearCPUTeam				; If not, jump
	jp   .lost				
	
.cpu2P:
	; Same thing as above, except when playing as 1P
	
	ld   a, $01							; 2P CPU autopicks team
	ld   [wCharSelRandom2P], a
	
	ld   hl, wCharSelP2Char0			; HL = Cursor position
	ld   de, wCharSelP2CursorPos		; DE = Cursor position
	ld   a, [wLastWinner]
	bit  PLB2, a						; Did the other player win?
	jp   z, .clearCPUTeam				; If not, jump
	
.lost:
	; The player lost the previous match, so the CPU keeps its opponents.
	
	; Additionally, if we lost to a boss, we have to set their selected "team" manually.
	; This is because they go alone instead of being part of a team. 
	; If we didn't check this, the game would try to select three characters anyway.
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU		; Did we lose to Saisyu?
	jp   z, .lostOnBoss			; If so, jump
	cp   STAGESEQ_RUGAL			; Did we lose to Rugal?
	jp   z, .lostOnBoss			; If so, jump
	cp   STAGESEQ_NAKORURU		; Did we lose to Nakoruru?
	jp   z, .lostOnBoss			; If so, jump
	jp   .chkInitialMode
.lostOnBoss:
	; Set the boss as part of the team
	ld   [de], a		; Whatever
	ldi  [hl], a		; 1st opponent: Boss
	ld   a, CHAR_ID_NONE
	ldi  [hl], a		; 2nd opponent: Nobody
	ld   [hl], a		; 3rd opponent: Nobody
	jp   .chkInitialMode
	
.clearCPUTeam:
	; The CPU lost.
	; Clear its three characters off the team.
	ld   a, CHAR_ID_NONE
	ldi  [hl], a
	ldi  [hl], a
	ld   [hl], a
	
.initVSMode:
	; (Nothing!) The special Watch Mode autopicker logic isn't implemented in this game.
.chkInitialMode:
	;
	; Determine which mode to start with.
	; If a player has at least the first character set when initializing
	; the char select screen, he's considered ready (cursor frozen, blinking START).
	;
	; This way it works universally for Single mode, Team mode and bosses.
	;
	ld   a, [wCharSelP1Char0]
	cp   CHAR_ID_NONE					; Is the first character empty?
	jp   z, .chkInitialModeP2			; If so, skip
	ld   a, CHARSEL_MODE_READY			; Otherwise, skip to the next mode for P1
	ld   [wCharSelP1CursorMode], a
.chkInitialModeP2:
	ld   a, [wCharSelP2Char0]			; Same as above, for P2
	cp   CHAR_ID_NONE
	jp   z, .loadVRAM
	ld   a, CHARSEL_MODE_READY
	ld   [wCharSelP2CursorMode], a
	
.loadVRAM:
	; Apply SGB palette for characters
	ld   de, SCRPAL_CHARSELECT
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Reset tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	; Reset screen coords to top-left corner
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	
	;
	; Copy graphics
	;
	
	; We're displaying character names here.
	; Unlike 96, as the default font is much smaller, only one letter (the "!") gets overwritten
	; with player tiles.
	call LoadGFX_1bppFont_Default
	
	ld   hl, GFXDef_CharSel_OBJ			; All OBJ (cursors) 58DE
	ld   de, $8000
	call CopyTilesAutoNum
	
	ld   hl, GFXDef_CharSel_BG0			; Player portraits (block 3)
	ld   de, $92F0
	call CopyTilesAutoNum
	
	ld   hl, GFXDef_CharSel_BG1			; Player portraits (block 2) 56DC
	ld   de, $8800
	call CopyTilesAutoNum
	
	;--
	; Draw a cross over all defeated characters.
	; Extracted to CharSel_DrawCrossOnDefeatedChars in 96.
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; In VS mode?
	jp   nz, .drawBG		; If so, skip

	ld   hl, wCharSeqTbl	; HL = Stage sequence table
	ld   b, $12				; HL = Number of slots remaining
.crLoop:
	ldi  a, [hl]			; A = Char ID
	push bc
	push hl
	call CharSel_DrawCrossOver
	pop  hl
	pop  bc
	dec  b					; Next char
	jp   nz, .crLoop		; Processed all chars? If not, loop
	;--
	
.drawBG:
	call CharSel_DrawUnlockedChars
	call IsInTeamMode
	jp   c, .drawBG_Team
	
	ld   hl, TextDef_CharSel_SingleTitle
	call TextPrinter_Instant
	
	ld   hl, BG_CHARSEL_P1ICON0
	ld   c, $D1
	call CharSel_DrawEmptyIcon
	ld   hl, BG_CHARSEL_P2ICON0
	ld   c, $D1
	call CharSel_DrawEmptyIcon
	
.singleChkIconP1:
	ld   a, [wCharSelP1Char0]
	cp   $FF
	jp   z, .singleChkIconP2
	
	; Otherwise, draw the character icon
	sla  a							; A *= 2 (Character ID)
	ld   de, $8DD0					; Where to load GFX
	ld   hl, BG_CHARSEL_P1ICON0+1	; Top-right corner of icon in tilemap
	ld   c, TILE_CHARSEL_P1ICON0	; Starting tile ID 
	call Char_DrawIconFlipX
	
.singleChkIconP2:
	ld   a, [wCharSelP2Char0]
	cp   $FF
	jp   z, .initOBJ
	
	; Otherwise, draw the character icon
	sla  a							; A *= 2 (Character ID)
	ld   de, $8E90					; Where to load GFX
	ld   hl, BG_CHARSEL_P2ICON0		; Top-left corner of icon in tilemap
	ld   c, TILE_CHARSEL_P2ICON0	; Starting tile ID 
	call Char_DrawIcon
	jp   .initOBJ
	
;--
.drawBG_Team:
	ld   hl, TextDef_CharSel_TeamTitle
	call TextPrinter_Instant
	
	;
	; Draw the placeholders for the icons of selected characters at the bottom of the screen.
	; In team mode, draw either one or three icon slots for each player.
	;
	
.team1PDraw:
	
	; The first placeholder is always drawn
	ld   hl, BG_CHARSEL_P1ICON0	; 1P side, leftmost	
	ld   c, TILE_CHARSEL_ICONEMPTY1
	call CharSel_DrawEmptyIcon
	
	; Don't draw the two other placeholders if we're in a boss stage.
	; No "boss rounds" in VS mode
	ld   a, [wPlayMode]
	bit  MODEB_VS, a			; Playing in VS mode?
	jp   nz, .team1PDrawEmpty	; If so, jump
	; 2P should be the active player
	ld   a, [wJoyActivePl]
	or   a						; Are we playing on the 1P side? (wJoyActivePl == PL1)
	jp   z, .team1PDrawEmpty	; If so, jump
	
	; Stage sequence check
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU		; Fighting Kagura next?
	jp   z, .team2PDraw			; If so, skip
	cp   STAGESEQ_RUGAL			; Fighting Goenitz next?
	jp   z, .team2PDraw			; If so, skip
	cp   STAGESEQ_NAKORURU		; Fighting Nakoruru next?
	jp   z, .team2PDraw			; If so, skip
.team1PDrawEmpty:
	; Draw second and third placeholder
	ld   hl, BG_CHARSEL_P1ICON1
	ld   c, TILE_CHARSEL_ICONEMPTY2
	call CharSel_DrawEmptyIcon
	ld   hl, BG_CHARSEL_P1ICON2
	ld   c, TILE_CHARSEL_ICONEMPTY3
	call CharSel_DrawEmptyIcon
	
.team2PDraw:
	;
	; Do the same for the
	; 2P SIDE
	;
	
	; The first placeholder is always drawn
	ld   hl, BG_CHARSEL_P2ICON0	; 2P side, rightmost	
	ld   c, TILE_CHARSEL_ICONEMPTY1		
	call CharSel_DrawEmptyIcon
	
	; Don't draw the two other placeholders if we're in a boss stage.
	; No "boss rounds" in VS mode
	ld   a, [wPlayMode]
	bit  MODEB_VS, a			; Playing in VS mode?
	jp   nz, .team2PDrawEmpty	; If so, jump
	; 1P should be the active player
	ld   a, [wJoyActivePl]
	or   a						; Are we playing on the 1P side? (wJoyActivePl == PL1)
	jp   nz, .team2PDrawEmpty	; If *not*, jump
	
	; Stage sequence check
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU		; Fighting Kagura next?
	jp   z, .fillSelChars1P		; If so, skip
	cp   STAGESEQ_RUGAL			; Fighting Goenitz next?
	jp   z, .fillSelChars1P		; If so, skip
	cp   STAGESEQ_NAKORURU		; Fighting Nakoruru next?
	jp   z, .fillSelChars1P		; If so, skip
.team2PDrawEmpty:
	; Draw second and third placeholder
	ld   hl, BG_CHARSEL_P2ICON1
	ld   c, TILE_CHARSEL_ICONEMPTY2
	call CharSel_DrawEmptyIcon
	ld   hl, BG_CHARSEL_P2ICON2
	ld   c, TILE_CHARSEL_ICONEMPTY3
	call CharSel_DrawEmptyIcon
	
.fillSelChars1P:

	;
	; The placeholder numeric icons are written.
	; Now replace them, in order, with the icons of the actual selected characters.
	;
	; Unlike 96, the character names aren't written yet.
	;
	
	ld   a, [wCharSelP1Char0]
	cp   CHAR_ID_NONE				; Is there a character on the first slot?
	jp   z, .fillSelChars2P			; If not, skip
	
	; Because the player 1 icons are X flipped, the BG_CHARSEL_P1ICON* are offset by 1
	; to point to the top-right tile of the icon. See also: Char_DrawIconFlipX
	
	; Set the icon in slot 1
	sla  a							; CharId *= 2
	ld   de, $8DD0					; Where to load the GFX
	ld   hl, BG_CHARSEL_P1ICON0+1	; Top-right corner of icon in tilemap
	ld   c, TILE_CHARSEL_P1ICON0	; Tile ID of DE
	call Char_DrawIconFlipX
	
	; Player 1 - Icon 2
	ld   a, [wCharSelP1Char1]
	cp   CHAR_ID_NONE
	jp   z, .fillSelChars2P	
	sla  a
	ld   de, $8E10
	ld   hl, BG_CHARSEL_P1ICON1+1
	ld   c, TILE_CHARSEL_P1ICON1
	call Char_DrawIconFlipX
	
	; Player 1 - Icon 3
	ld   a, [wCharSelP1Char2]
	cp   CHAR_ID_NONE
	jp   z, .fillSelChars2P
	sla  a
	ld   de, $8E50
	ld   hl, BG_CHARSEL_P1ICON2+1
	ld   c, TILE_CHARSEL_P1ICON2
	call Char_DrawIconFlipX
	
.fillSelChars2P:

	; Player 2 - Icon 1
	ld   a, [wCharSelP2Char0]
	cp   CHAR_ID_NONE
	jp   z, .initOBJ
	sla  a
	ld   de, $8E90
	ld   hl, BG_CHARSEL_P2ICON0
	ld   c, TILE_CHARSEL_P2ICON0
	call Char_DrawIcon
	
	; Player 2 - Icon 2
	ld   a, [wCharSelP2Char1]
	cp   CHAR_ID_NONE
	jp   z, .initOBJ
	sla  a
	ld   de, $8ED0
	ld   hl, BG_CHARSEL_P2ICON1
	ld   c, TILE_CHARSEL_P2ICON1
	call Char_DrawIcon
	
	; Player 2 - Icon 3
	ld   a, [wCharSelP2Char2]
	cp   CHAR_ID_NONE
	jp   z, .initOBJ
	sla  a
	ld   de, $8F10
	ld   hl, BG_CHARSEL_P2ICON2
	ld   c, TILE_CHARSEL_P2ICON2
	call Char_DrawIcon
	
.initOBJ:

	;
	; Set the initial sprite mappings for the cursors
	;
	
	call ClearOBJInfo
	
.cursor_1P:
	;
	; Player 1 Cursor
	;
	
	; Initialize the sprite
	ld   hl, wOBJInfo_Pl1
	ld   de, OBJInfoInit_CharSel_Cursor
	call OBJLstS_InitFrom
	
	; Draw the currently hovered name. This is always the last selected character.
	ld   a, [wCharSelP1CursorPos]
	ld   de, wOBJInfo_Pl1
	call CharSel_PrintCharName
	
	; Set the correct sprites for the 1P/CPU versions
	ld   hl, wOBJInfo_Pl1+iOBJInfo_OBJLstPtrTblOffset
	ld   a, [wPlInfo_Pl1+iPlInfo_Flags0]
	bit  7, a
	jp   nz, .cursorCPU_1P
.cursorPl_1P:
	ld   [hl], CHARSEL_OBJ_CURSOR1P
	jp   .cursor_2P
.cursorCPU_1P:
	ld   [hl], CHARSEL_OBJ_CURSORCPU1P
	
.cursor_2P:
	;
	; Player 2 Cursor
	;
	; Do the same thing, but for player 2
	
	; Initialize the sprite
	ld   hl, wOBJInfo_Pl2
	ld   de, OBJInfoInit_CharSel_Cursor
	call OBJLstS_InitFrom
	
	; 2P cursor uses its own palette.
	; This allows unique flashing speed for both players.
	ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstFlags
	ld   [hl], SPR_OBP1
	
	; Draw the currently hovered name. This is always the last selected character.
	ld   a, [wCharSelP2CursorPos]
	ld   de, wOBJInfo_Pl2
	call CharSel_PrintCharName
	
	; Set the correct sprites for the normal/wide 2P/CPU versions
	ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstPtrTblOffset
	ld   a, [wPlInfo_Pl2+iPlInfo_Flags0]
	bit  PF0B_CPU, a		; Is this character a CPU?
	jp   nz, .cursorCPU_2P	; If so, jump
.cursorPl_2P:
	ld   [hl], CHARSEL_OBJ_CURSOR2P
	jp   .initMisc
.cursorCPU_2P:
	ld   [hl], CHARSEL_OBJ_CURSORCPU2P
	
.initMisc:
	call Pl_InitBeforeStageLoad
	call Serial_DoHandshake
	
	;
	; Randomize the three possible stages, as in this game
	; stages aren't assigned to characters.
	;
	; In 96, this code was kept for VS Mode only.
	;
	call Rand
	and  a, $03
	ld   [wStageId], a
	
.initEnd:
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	; Set DMG palette
	ld   a, $74
	ldh  [rOBP0], a
	ld   a, $74
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	; Play character select BGM
	ld   a, BGM_CHARSELECT
	call HomeCall_Sound_ReqPlayExId_Stub
	call Task_PassControl_NoDelay
	
.mainLoop:
	call JoyKeys_DoCursorDelayTimer
	call CharSel_DoMode1P
	call CharSel_DoMode2P
	
	; Unless both players have confirmed their characters, continue looping
	ld   a, [wCharSelP1CursorMode]
	cp   CHARSEL_MODE_CONFIRMED		; Did player 1 confirm their character(s)?
	jp   nz, .noEnd					; If not, jump
	ld   a, [wCharSelP2CursorMode]
	cp   CHARSEL_MODE_CONFIRMED		; Did player 2 confirm their character(s)?
	jp   nz, .noEnd					; If not, jump
	jp   .end						; Otherwise, we're done
.noEnd:
	call Task_PassControl_NoDelay
	jp   .mainLoop
.end:

	; Wait for 60 frames before switching
	ld   b, 60
.endDelayLoop:
	call Task_PassControl_NoDelay
	dec  b
	jp   nz, .endDelayLoop
	
	; 
	; If we aren't in team mode, gameplay can start right away.
	; Otherwise, we've still got to choose the team order.
	;
	call IsInTeamMode		; Are we in team mode?
	jp   nc, Module_Play	; If not, jump
	jp   Module_OrdSel
	
; =============== CharSel_DoMode1P ===============	
; Handles the character select mode for Player 1.
CharSel_DoMode1P:
	ld   a, CHARSEL_1P
	ld   [wCharSelCurPl], a
	ld   a, [wCharSelP1CursorMode]
	call CharSel_DoMode
	ret
; =============== CharSel_DoMode2P ===============	
; Handles the character select mode for Player 2.
CharSel_DoMode2P:
	ld   a, CHARSEL_2P
	ld   [wCharSelCurPl], a
	ld   a, [wCharSelP2CursorMode]
	call CharSel_DoMode
	ret
; =============== CharSel_DoMode ===============
; IN
; - A: Mode ID
CharSel_DoMode:
	ld   hl, .tbl	; HL = Jump table
	ld   d, $00		; DE = Mode ID
	ld   e, a
	add  hl, de		; Index the table
	ld   e, [hl]	; Read it out to DE
	inc  hl
	ld   d, [hl]
	push de
	pop  hl			; Move to HL and jump there
	jp   hl
.tbl:
	dw CharSel_Mode_Select
	dw CharSel_Mode_Ready
	dw CharSel_Mode_Confirmed
	
; =============== CharSel_Mode_Confirmed ===============
; After all characters are confirmed.
; This does nothing at all - the game uses this mode to wait until both players are 
; in this mode before continuing.
CharSel_Mode_Confirmed:
	ret
	
; =============== CharSel_Mode_Ready ===============
; After all three characters are selected.
CharSel_Mode_Ready:
	call CharSel_AnimCursorPalSlow
	call CharSel_BlinkStartText
	
	; Autoconfirm checks
	call CharSelect_IsCPUOpponent		; Is the current player the CPU opponent?
	jp   c, .confirm					; If so, autoconfirm the choice
	call CharSelect_IsLastWinner		; Did we win last time? (single mode only)
	jp   c, .confirm					; If so, autoconfirm
	
	; Input checks
	call CharSel_GetInput
	
	; - START or A -> Confirm selected characters
	bit  KEYB_START, a
	jp   nz, .confirm
	; - SELECT -> Remove all characters from team (like in CHARSEL_MODE_SELECT)
	bit  KEYB_SELECT, a
	jp   nz, .removeAll
	;
	bit  KEYB_A, a
	jp   nz, .confirm
	; - B -> Remove last character from team (like in CHARSEL_MODE_SELECT)
	bit  KEYB_B, a
	jp   nz, .removeOne
	ret
	
; =============== .removeAll ===============
.removeAll
	; Remove all three characters from the team.
	call CharSel_HideStartText	; For changing mode
	call CharSel_RemoveChar
	call CharSel_RemoveChar
	call CharSel_RemoveChar
	jp   .switchToSelectMode
	
; =============== .removeOne ===============
.removeOne:
	; Remove the third character from the team
	call CharSel_HideStartText	; For changing mode
	call CharSel_RemoveChar
	
; =============== .switchToSelectMode ===============
.switchToSelectMode:
	; Enable controllable cursor for current player
	ld   a, [wCharSelCurPl]
	or   a					; Currently handling player 1?
	jp   nz, .selectP2		; If not, jump
.selectP1:
	ld   a, CHARSEL_MODE_SELECT
	ld   [wCharSelP1CursorMode], a
	ret
.selectP2:
	ld   a, CHARSEL_MODE_SELECT
	ld   [wCharSelP2CursorMode], a
	ret
	
; =============== .confirm ===============
.confirm:
	; Disable controls for current player by switching to the next mode.
	call CharSel_HideStartText
	call CharSel_HideCursor
	call CharSel_SetPlInfo
	; Switch for the current player
	ld   a, [wCharSelCurPl]
	or   a					
	jp   nz, .confirmPl2
.confirmPl1:
	ld   a, $04
	ld   [wCharSelP1CursorMode], a
	ret
.confirmPl2:
	ld   a, $04
	ld   [wCharSelP2CursorMode], a
	ret
	
; =============== CharSel_Mode_Select ===============
; Initial mode when characters are selectable.
CharSel_Mode_Select:
	call CharSel_AnimCursorPalFast
	
	;
	; Detect if we're randomizing/autopicking characters
	;
	ld   a, [wCharSelCurPl]
	or   a						; Are we handling player 1? (== CHARSEL_1P)
	jp   nz, .pl2				; If not, jump
.pl1:
	ld   a, [wCharSelRandom1P]
	or   a						; Randomizing 1P characters?
	jp   z, .doCtrl				; If not, jump
	jp   .randomPick
.pl2:
	ld   a, [wCharSelRandom2P]
	or   a						; Randomizing 2P characters?
	jp   z, .doCtrl				; If not, jump
.randomPick:	
	call CharSel_RandomPick			; Randomize selected character
	jp   c, CharSel_Select_DoCtrl_A	; Signaled to add it to the team? If so, jump
	ret
	
.doCtrl:
	call CharSel_GetInput
	; Input list:

	; START + B -> Enable autopicker
	bit  KEYB_START, a						; Holding START?
	jp   nz, CharSel_Select_DoCtrl_Start	; If so, jump
	
	; SELECT -> Returns to the title screen
	bit  KEYB_SELECT, a						; Pressed SELECT?
	jp   nz, CharSel_Select_DoCtrl_Select	; If so, jump
	
	; B -> Removes the last selected character
	bit  KEYB_B, a							; Pressed B?
	jp   nz, CharSel_Select_DoCtrl_B		; If so, jump
	
	; A -> Selects a character
	bit  KEYB_A, a							; Pressed A?
	jp   nz, CharSel_Select_DoCtrl_A		; If so, jump
	
	; Directional keys -> Move cursor
	bit  KEYB_DOWN, b						; Holding down?
	jp   nz, CharSel_Select_DoCtrl_Down		; If so, jump
	bit  KEYB_UP, b							; Holding up?
	jp   nz, CharSel_Select_DoCtrl_Up		; If so, jump
	bit  KEYB_LEFT, b						; Holding left?
	jp   nz, CharSel_Select_DoCtrl_Left		; If so, jump
	bit  KEYB_RIGHT, b						; Holding right?
	jp   nz, CharSel_Select_DoCtrl_Right	; If so, jump
	ret  
	
; =============== CharSel_Select_DoCtrl_Select ===============
CharSel_Select_DoCtrl_Select:
	;##
	; Determine if it's possible to return to the title screen.
	;
	; This is NOT possible when:
	; - Playing VS mode through serial
	; - A character is selected
	; - In Single mode, at least one stage is beaten (prevents exit after a game over)
	;
	; Extracted to CharSel_CanExitToTitle in 96.

	; In single mode, check which stage we're in
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   z, .chkRound		; If not, jump
	
	; In VS *serial* mode, don't allow exiting
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]	; Running on a SGB?
	ret  z					; If not, return
	
.chkRound:
	;--
	; This could have been a "jr .toTitle" right above .chkRound
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   nz, .toTitle		; If so, jump
	;--
	
	; No exit on next rounds
	ld   a, [wCharSeqId]
	or   a				; Beaten at least one stage? (not the first char select screen)
	jp   z, .toTitle		; If not, jump
	
	ret						; Otherwise, no exiting
	;##
.toTitle:
	ld   b, BANK(Module_Title) ; BANK $1E
	ld   hl, Module_Title
	jp   FarJump
	
; =============== CharSel_Select_DoCtrl_Select ===============
CharSel_Select_DoCtrl_Start:
	bit  5, c			; Holding B as well?
	ret  z				; If not, return
	;
	; Do not enable the autopicker when playing through serial, otherwise things will desync.
	; VS mode under the SGB is fine, since everything is handled locally.
	;
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   z, .setRandom		; If not, jump
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]	; Playing on a SGB?
	ret  z					; If not, return
.setRandom:
	; Enable random picker for current player
	ld   a, [wCharSelCurPl]
	or   a					; Are we handling player 1?
	jp   nz, .pl2			; If not, jump
	ld   a, $01				; Set random for 1P
	ld   [wCharSelRandom1P], a
	ret  
.pl2:
	ld   a, $01				; Set random for 2P
	ld   [wCharSelRandom2P], a
	ret  

; =============== CharSel_Select_DoCtrl_A ===============	
CharSel_Select_DoCtrl_A:
	call CharSel_AddChar
	
	;
	; When the full team is set, switch to the next mode
	;
	ld   a, [wCharSelTeamFull]
	or   a						; Is the team full now?
	ret  z						; If not, return
	ld   a, [wCharSelCurPl]
	or   a						; Are we handling player 1?
	jp   nz, .ready2P			; If not, jump
.ready1P:
	ld   a, CHARSEL_MODE_READY
	ld   [wCharSelP1CursorMode], a
	ret
.ready2P:
	ld   a, CHARSEL_MODE_READY
	ld   [wCharSelP2CursorMode], a
	ret
; =============== CharSel_Select_DoCtrl_B ===============		
CharSel_Select_DoCtrl_B:
	call CharSel_RemoveChar
	ret
; =============== CharSel_Select_DoCtrl_Down ===============
CharSel_Select_DoCtrl_Down:
	call CharSel_MoveCursorD
	ld   a, SFX_CURSORMOVE						; Play cursor move SFX
	call HomeCall_Sound_ReqPlayExId
	ret  
; =============== CharSel_Select_DoCtrl_Up ===============
CharSel_Select_DoCtrl_Up:
	call CharSel_MoveCursorU
	ld   a, SFX_CURSORMOVE
	call HomeCall_Sound_ReqPlayExId
	ret  
; =============== CharSel_Select_DoCtrl_Left ===============
CharSel_Select_DoCtrl_Left:
	call CharSel_MoveCursorL
	ld   a, SFX_CURSORMOVE
	call HomeCall_Sound_ReqPlayExId
	ret  
; =============== CharSel_Select_DoCtrl_Right ===============
CharSel_Select_DoCtrl_Right:
	call CharSel_MoveCursorR
	ld   a, SFX_CURSORMOVE
	call HomeCall_Sound_ReqPlayExId
	ret  

; =============== CharSel_RandomPick ===============
; Handles the automatic cursor picker.
;
; OUT
; - C flag: If set, the character should be added to the team
;           (bubbled up from CharSel_SetRandomPortrait)
CharSel_RandomPick:
	ld   a, [wCharSelCurPl]
	or   a						; Currently handling player 1?
	jp   nz, .pl2				; If not, jump
.pl1:
	; Randomize 1P cursor position
	ld   bc, wCharSelRandomDelay1P
	ld   hl, wCharSelP1CursorPos
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call CharSel_SetRandomPortrait
	; If it was requested to add the character, return (preserving the C flag)
	jp   c, .ret							
	jp   .refresh
.pl2:
	; Randomize 2P cursor position
	ld   bc, wCharSelRandomDelay2P
	ld   hl, wCharSelP2CursorPos
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call CharSel_SetRandomPortrait
	; If it was requested to add the character, return (preserving the C flag)
	jp   c, .ret
.refresh:
	call CharSel_PrintCharName
.ret:
	ret  	
; =============== CharSel_SetRandomPortrait ===============	
; Randomizes the cursor position on the character select screen
; and decides if it should be selected or not.
;
; IN
; - BC: Ptr to CPU delay timer. Not applicable on user-triggered randomizer.
; - HL: Ptr to selected character. The new character ID will be set here.
; - DE: Ptr to cursor OBJLst
; OUT
; - C flag: If set, the character should be added to the team
CharSel_SetRandomPortrait:
	;
	; Wait until the delay timer expires before signaling that the character should be selected.
	;
	ld   a, [bc]
	or   a					; DelayTimer == 0?
	jp   z, .setPick		; If so, jump
	dec  a					; DelayTimer--
	ld   [bc], a
.genRandomPos:

	;--
	;
	; Generate a random character ID
	; A = HIGH(Rand * $12)
	;
	call Rand			; A = Random byte
	push hl
		ld   h, $00		; HL = A
		ld   l, a
		push hl
REPT 4
			sla  l		; HL *= $10
			rl   h
ENDR
			push hl
			pop  bc		; Move to BC
		pop  hl
		
		sla  l			; HL = A * 2
		rl   h
		add  hl, bc		; Merge those (HL = A * $12)
		ld   a, h		; Only pick the high byte (which will always be in $00-$11 range)
	pop  hl
	;--
	
	; Regenerate it if the character is locked 
	push af
		call CharSel_IsPortraitLocked	; Is this a locked character?
		jp   nc, .setRandomPos			; If not, jump
	pop  af
	jp   .genRandomPos					; Otherwise, rerand
.setRandomPos:
	pop  af
	ld   [hl], a			; Set selected character ID
	scf
	ccf						; C flag = 0
	ret
	
.setPick:
	push de
		push hl
			
			; Generate a new random delay value identically to the init code.
			call Rand
			and  a, $1F
			add  a, $07
			ld   [bc], a
			;--
			
			;
			; If the current player is the CPU opponent, replace whatever character is selected
			; with the correct value from the CPU opponent sequence.
			;
			; See also: CharSelect_IsCPUOpponent
			;
			
			; No stage sequence in VS modes
			ld   a, [wPlayMode]
			bit  MODEB_VS, a		; Playing in VS mode?
			jp   nz, .noChange		; If so, skip
			
			; The current player must be a CPU opponent (ie: no way to control cursor movement)
			ld   a, [wCharSelCurPl]
			or   a					; Currently handling player 1?
			jp   nz, .chkPl2		; If not, jump
		.chkPl1:
			; If the active player is 2P, 1P is the CPU opponent
			ld   a, [wJoyActivePl]
			or   a					; Is 1P the active player?
			jp   z, .noChange		; If so, skip
			ld   hl, wCharSelP1Char0
			jp   .getSeqOffset
		.chkPl2:
			; If the active player is 1P, 2P is the CPU opponent
			ld   a, [wJoyActivePl]
			or   a					; Is 1P the active player?
			jp   nz, .noChange		; If not, skip
			ld   hl, wCharSelP2Char0
		.getSeqOffset:
			;--
			
			;
			; Get the char ID off the sequence of CPU opponents.
			;
			; CharId = wCharSeqTbl[wCharSeqId + TeamPos]
			;          Where TeamPos is the 0-based number of the first free slot found.
			;
			
			; Index wCharSeqTbl by wCharSeqId
			ld   a, [wCharSeqId]	; A = SeqId
			ld   de, wCharSeqTbl	; DE = SeqTbl
			add  a, e				; DE += A
			jp   nc, .chkFreeSlot
			inc  d 					; We never get here
		.chkFreeSlot:
			ld   e, a				

			; Add TeamPos by incrementing DE for every filled slot
			ldi  a, [hl]			; A = First slot, TeamSlot++
			cp   CHAR_ID_NONE		; Is the first slot filled?
			jp   z, .setChar		; If so, fill it
			inc  de					; + 1
			
			ldi  a, [hl]			; A = Second slot, TeamSlot++
			cp   CHAR_ID_NONE		; Is the first slot filled?
			jp   z, .setChar		; If so, fill it
			inc  de					; + 2
		.setChar:
			ld   a, [de]			; Get character ID from sequence
		pop  hl
	pop  de
	
	; Update cursor position with new CharId we just got
	ld   [hl], a				
	; Reload screen due to update
	call CharSel_PrintCharName
	; C flag set, request char select
	scf		
	ret
	
		.noChange:
		
		pop  hl
	pop  de
	; C flag set, request char select
	scf		
	ret  
 
; =============== CharSel_MoveCursorD ===============
; Moves the cursor for the current player down in the character select screen.
CharSel_MoveCursorD:
	; Pick current player args
	ld   a, [wCharSelCurPl]
	or   a
	jp   nz, .pl2
.pl1:
	ld   hl, wCharSelP1CursorPos
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call CharSel_MoveCursorPosD
	jp   .redraw
.pl2: 
	ld   hl, wCharSelP2CursorPos
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call CharSel_MoveCursorPosD
.redraw:
	; Refesh the cursor OBJInfo and char name for the new position
	call CharSel_PrintCharName
	ret
	
; =============== CharSel_MoveCursorPosD ===============
; Moves the specified cursor position down by 1 in the character select screen.
; IN
; - HL: Ptr to cursor position
CharSel_MoveCursorPosD:
	; The character select grid is 6x3, which is $12 slots.
	ld   a, [hl]				; A = CursorPos
.moveD:
	; Move down by 1 portrait 
	add  a, CHARSEL_GRID_W		; CursorPos += RowSize
.chkBound:
	; Handle the bounds check.
	; If we moved past the last entry, wrap back to the top
	cp   CHARSEL_GRID_SIZE		; CursorPos >= GridSize?
	jp   c, .chkLock			; If not, skip
	sub  a, CHARSEL_GRID_SIZE	; CursorPos -= GridSize
.chkLock:
	; Skip locked characters
	push af
		call CharSel_IsPortraitLocked	; Is the cursor over a locked character?
		jp   nc, .save					; If not, save the value back
	pop  af
	jp   .moveD			; Otherwise, move down again
.save:
	pop  af
	ld   [hl], a		; Save back CursorPos
	ret
	
; =============== CharSel_MoveCursorU ===============
; Moves the cursor for the current player up in the character select screen.
; See also: CharSel_MoveCursorD
CharSel_MoveCursorU:
	ld   a, [wCharSelCurPl]
	or   a
	jp   nz, .pl2
.pl1:
	ld   hl, wCharSelP1CursorPos
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call CharSel_MoveCursorPosU
	jp   .redraw
.pl2:
	ld   hl, wCharSelP2CursorPos
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call CharSel_MoveCursorPosU
.redraw:
	call CharSel_PrintCharName
	ret
	
; =============== CharSel_MoveCursorPosU ===============
; IN
; - HL: Ptr to cursor position
CharSel_MoveCursorPosU:
	ld   a, [hl]			; A = CursorPos
.moveU:
	; Move up by 1 portrait
	sub  a, CHARSEL_GRID_W	; CursorPos -= RowSize
.chkBound:
	; Handle the bounds check.
	; If we underflowed (could have been a "jr c"), wrap to the bottom
	bit  7, a					; CursorPos < 0?
	jp   z, .chkLock			; If not, skip
	add  a, CHARSEL_GRID_SIZE	; CursorPos += GridSize
.chkLock:
	; Skip locked characters
	push af
		call CharSel_IsPortraitLocked	; Is the cursor over a locked character?
		jp   nc, .save					; If not, save the value back
	pop  af
	jp   .moveU			; Otherwise, move up again
.save:
	pop  af
	ld   [hl], a		; Save back CursorPos
	ret
	
; =============== CharSel_MoveCursorL ===============
; Moves the cursor for the current player left in the character select screen.
; See also: CharSel_MoveCursorD
CharSel_MoveCursorL:
	ld   a, [wCharSelCurPl]
	or   a
	jp   nz, .pl2
.pl1:
	ld   hl, wCharSelP1CursorPos
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call CharSel_MoveCursorPosL
	jp   .refresh
.pl2:
	ld   hl, wCharSelP2CursorPos
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call CharSel_MoveCursorPosL
.refresh:
	call CharSel_PrintCharName
	ret
	
; =============== CharSel_MoveCursorPosL ===============
; IN
; - HL: Ptr to cursor position
CharSel_MoveCursorPosL:
	ld   a, [hl]			; A = CursorPos
.moveL:
	; Handle row wrapping
	cp   CHARSEL_GRID_W*0	; First row
	jp   z, .wrapH
	cp   CHARSEL_GRID_W*1	; Second row
	jp   z, .wrapH
	cp   CHARSEL_GRID_W*2	; Third row
	jp   z, .wrapH
	
.moveNorm:
	dec  a					; Otherwise, move left once
	jp   .chkLock
.wrapH:
	add  a, CHARSEL_GRID_W-1	; Move to rightmost portrait in row
.chkLock:
	; Skip locked characters
	push af
		call CharSel_IsPortraitLocked	; Is the cursor over a locked character?
		jp   nc, .save					; If not, save the value back
	pop  af
	jp   .moveL			; Otherwise, move left again
.save:
	pop  af
	ld   [hl], a		; Save back CursorPos
	ret
	
; =============== CharSel_MoveCursorR ===============
; Moves the cursor for the current player right in the character select screen.
; See also: CharSel_MoveCursorD
CharSel_MoveCursorR:
	ld   a, [wCharSelCurPl]
	or   a
	jp   nz, .pl2
.pl1:
	ld   hl, wCharSelP1CursorPos
	ld   de, wOBJInfo_Pl1+iOBJInfo_Status
	call CharSel_MoveCursorPosR
	jp   .refresh
.pl2:
	ld   hl, wCharSelP2CursorPos
	ld   de, wOBJInfo_Pl2+iOBJInfo_Status
	call CharSel_MoveCursorPosR
.refresh:
	call CharSel_PrintCharName
	ret
	
; =============== CharSel_MoveCursorPosR ===============
; IN
; - HL: Ptr to cursor position
CharSel_MoveCursorPosR:
	ld   a, [hl]		; A = CursorPos
.moveR:
	; Handle row wrapping
	cp   (CHARSEL_GRID_W*1)-1	; First row
	jp   z, .wrapH
	cp   (CHARSEL_GRID_W*2)-1	; Second row
	jp   z, .wrapH
	cp   (CHARSEL_GRID_W*3)-1	; Third row
	jp   z, .wrapH
	
.moveNorm:
	inc  a					; Otherwise, move right once
	jp   .chkLock
.wrapH:
	sub  a, CHARSEL_GRID_W-1	; Move to leftmost portrait in row
.chkLock:
	; Skip locked characters
	push af
		call CharSel_IsPortraitLocked	; Is the cursor over a locked character?
		jp   nc, .save					; If not, save the value back
	pop  af
	jp   .moveR			; Otherwise, move right again
.save:
	pop  af
	ld   [hl], a		; Save back CursorPos
	ret
	
; =============== CharSel_IsPortraitLocked ===============
; Determines if the specified cursor is over a locked character.
;
; IN
; - A: Character ID (cursor position)
; OUT
; - C flag: If set, the cursor is over a locked character
CharSel_IsPortraitLocked:
	; The table wCharSelIdMapTbl flags locked characters by ID.
	; Entries with non-zero values will mark that character as locked.
	push hl
		ld   hl, wCharSelIdMapTbl	; HL = Mapping table
		; Index it with the character ID
		; HL += A
		add  a, l
		jp   nc, .noInc
		inc  h
	.noInc:
		ld   l, a
		;--
		ld   a, [hl]			; A = Character Locked flag
		or   a					; Is it 0?
		jp   z, .isUnlocked		; If so, jump
.isLocked:
	pop  hl
	scf		; C flag set, locked
	ret
.isUnlocked:
	pop  hl
	xor  a	; C flag clear, unlocked
	ret
	
; =============== CharSel_RemoveChar ===============
; Removes the last selected character for the current player.
CharSel_RemoveChar:

	; Pick the player-specific initial address
	ld   a, [wCharSelCurPl]
	or   a						; Playing as 1P?
	jp   nz, .pl2				; If so, jump
.pl1:
	ld   de, wCharSelP1Char2
	call CharSel_ClearSlot		; Try to clear a slot
	jp   c, .ret				; If nothing found, return
	call CharSel_ClearTopIcon1P	; Otherwise, also remove the char icon
	jp   .ret
.pl2:
	ld   de, wCharSelP2Char2
	call CharSel_ClearSlot
	jp   c, .ret
	call CharSel_ClearTopIcon2P
.ret:
	ret
	
; =============== CharSel_ClearSlot ===============
; Clears the first filled slot found, searching from highest to lowest.
; IN
; - DE: Ptr to third selected character
; OUT
; - B: Updated number of selected characters
; - C flag: If set, no slot was found
CharSel_ClearSlot:
	;
	; In single mode, there's only one slot to check.
	;
	call IsInTeamMode		; Are we in team mode?
	jp   c, .team			; If so, jump
.single:
	ld   b, $00				; B = No characters selected
	
	push de					; Seek back to first character slot
	pop  hl
	dec  hl					; HL -= 2
	dec  hl
	
	ld   a, CHAR_ID_NONE	; A = Comparison valye
	jp   .chkSlot0
	
	;
	; In Team mode, check all 3 characters.
	;
.team:
	; Start B with the highest value, and decrement it as slot
	ld   b, $02				; 3 characters (with 1 removed)
	push de
	pop  hl					; HL = Third team slot
	ld   a, CHAR_ID_NONE	; A = Comparison valye
.chkSlot2:
	cp   a, [hl]			; Is the third character empty?
	jp   nz, .clearSlot		; If not, clear it
	dec  b					; RemNum--
	dec  hl					; Seek to previous slot
.chkSlot1:
	cp   a, [hl]			; Is the second character empty?
	jp   nz, .clearSlot		; If not, clear it
	dec  b					; RemNum--
	dec  hl					; Seek to previous slot
.chkSlot0:
	cp   a, [hl]			; Is the first character empty?
	jp   nz, .clearSlot		; If not, clear it
	; Otherwise, there's nothing to clear
	scf						; C flag cleared, no slot found
	ret
.clearSlot:
	ld   [hl], CHAR_ID_NONE	; Clear out slot
	xor  a					; C flag cleared, slot found
	ret
; =============== CharSel_ClearTopIcon1P ===============
; Clears the icon for the deselected character, replacing it with the numeric placeholder.
; IN
; - B: Updated number of selected characters (passed by CharSel_ClearSlot)
CharSel_ClearTopIcon1P:
	ld   a, b
	cp   $01			; Is there 1 selected character now (down from 2)?
	jp   z, .blank2		; If so, jump
	cp   $02			; Are there 2 selected characters now (down from 3)?
	jp   z, .blank3		; If so, jump
	; Otherwise, there are no selected characters (down from 1).
.blank1:
	; Blank out the icon for the first slot.
	ld   hl, BG_CHARSEL_P1ICON0
	ld   c, TILE_CHARSEL_ICONEMPTY1
	jp   .go
.blank2:
	; Blank out the icon for the second slot.
	ld   hl, BG_CHARSEL_P1ICON1
	ld   c, TILE_CHARSEL_ICONEMPTY2
	jp   .go
.blank3:
	; Blank out the icon for the third slot.
	ld   hl, BG_CHARSEL_P1ICON2
	ld   c, TILE_CHARSEL_ICONEMPTY3
.go:
	call CharSel_DrawEmptyIcon
	ret
	
; =============== CharSel_ClearTopIcon2P ===============
; Clears the icon for the deselected character, replacing it with the numeric placeholder.
; IN
; - B: Updated number of selected characters	
CharSel_ClearTopIcon2P:
	ld   a, b
	cp   $01			; Is there 1 selected character now (down from 2)?
	jp   z, .blank2		; If so, jump
	cp   $02			; Are there 2 selected characters now (down from 3)?
	jp   z, .blank3		; If so, jump
	; Otherwise, there are no selected characters (down from 1).
.blank1:
	; Blank out the icon for the first slot.
	ld   hl, BG_CHARSEL_P2ICON0
	ld   c, TILE_CHARSEL_ICONEMPTY1
	jp   .go
.blank2:
	; Blank out the icon for the second slot.
	ld   hl, BG_CHARSEL_P2ICON1
	ld   c, TILE_CHARSEL_ICONEMPTY2
	jp   .go
.blank3:
	; Blank out the icon for the third slot.
	ld   hl, BG_CHARSEL_P2ICON2
	ld   c, TILE_CHARSEL_ICONEMPTY3
.go:
	call CharSel_DrawEmptyIcon
	ret

; =============== CharSel_DrawEmptyIcon ===============
; Draws an empty 2x2 square, for blank slots in the list of selected characters.
; Used when initializing the character select screen, or when removing a selected character.
; - HL: Ptr to tilemap
; - C: Base tile ID (TILE_CHARSEL_ICONEMPTY*)
;      The icon will use the four next tiles starting from this one.
CharSel_DrawEmptyIcon:
	mWaitForVBlankOrHBlank
	
	; Top left corner -> TileId
	ld   a, c		
	ldi  [hl], a	; BGPtr++
	inc  a		
	; Top right corner -> TileId+1	
	ldd  [hl], a	; BGPtr--
	inc  a
	
	; Move down 1 tile
	ld   de, BG_TILECOUNT_H	; BgPtr += $20
	add  hl, de
	
	; Wait for next HBlank
	push af
		mWaitForVBlankOrHBlank
	pop  af
	
	; Bottom left corner -> TileId+2
	ldi  [hl], a
	inc  a
	
	; Bottom right corner -> TileId+3
	ld   [hl], a
	ret
; =============== CharSel_AddChar ===============
; Adds the character the cursor is placed on to the team.
CharSel_AddChar:
	; Default with $00, to mark that further characters are selectable
	ld   a, CHARSEL_TEAM_REMAIN
	ld   [wCharSelTeamFull], a
	
	; Depending on the current player...
	ld   a, [wCharSelCurPl]
	or   a
	jp   nz, .pl2
.pl1:
	ld   de, wCharSelP1Char0			; DE = 1st char in 1P team
	ld   a, [wCharSelP1CursorPos]		; C = Selected character id
	ld   c, a
	call CharSel_AddCharToFirstFreeSlot	; Was the character added?
	jp   c, .ret						; If not, return
	; Otherwise, draw icon and play its specific SFX
	call CharSel_DrawP1CharIconForNew	
	ld   a, SFX_CHARSELECTED
	call HomeCall_Sound_ReqPlayExId
	jp   .ret
.pl2:
	ld   de, wCharSelP2Char0			; DE = 1st char in 2P team
	ld   a, [wCharSelP2CursorPos]		; C = Selected character id
	ld   c, a
	call CharSel_AddCharToFirstFreeSlot	; Was the character added?
	jp   c, .ret						; If not, return
	; Otherwise, draw icon and play its specific SFX
	call CharSel_DrawP2CharIconForNew
	ld   a, SFX_CHARSELECTED
	call HomeCall_Sound_ReqPlayExId
.ret:
	ret

; =============== CharSel_AddCharToFirstFreeSlot ===============
; Adds the specified character to the first free team slot.
; IN
; - DE: Ptr to first character in team
; - C: Character ID
; OUT
; - B: Team slot number the character was added to (0-based)
; - C: Character ID (as it passes through CharSel_GetCharIdByPortraitId)
; - C flag: If set, the character couldn't be added
CharSel_AddCharToFirstFreeSlot:
	;
	; In team mode, prevent selecting duplicate characters,
	; unless the cheat for it is enablead.
	;
	call IsInTeamMode		; Are we in team mode?
	jp   nc, .single		; If not, jump
	ld   a, [wDipSwitch]
	bit  DIPB_TEAM_DUPL, a	; Allow selecting duplicate characters?
	jp   nz, .teamSet		; If so, skip check
	
	ld   a, c				; A = CharID
	push de
	pop  hl					; HL = wCharSelP*Char0
	
	; If the character is already in the team, return
	cp   a, [hl]			; Is it already the first member?
	jp   z, .noAdd			; If so, jump
	inc  hl
	cp   a, [hl]			; 2
	jp   z, .noAdd
	inc  hl
	cp   a, [hl]			; 3
	jp   z, .noAdd
	; OK
	jp   .teamSet
.single:
	ld   b, $00				; Slot 0 (only one)
	
	; In single mode, only one character can be selected, so only wCharSelP*Char0 is checked.
	
	;--
	; This can never jump, as this is never called when a character is already selected.
	ld   a, CHAR_ID_NONE	; Comparison value
	push de
	pop  hl					; HL = First slot
	cp   a, [hl]			; Is this slot free?
	jp   nz, .noAdd			; If not, jump
	;--
	
	; Write the char ID to the first slot
	ld   a, c
	ld   [hl], a
	; Mark that no further characters can be added
	ld   a, CHARSEL_TEAM_FILLED
	ld   [wCharSelTeamFull], a
	; C flag cleared, added OK
	xor  a
	ret
	
.teamSet:
	ld   b, $00				; Slot 0
	
	; Find the first free slot in the team
	ld   a, CHAR_ID_NONE	; A = Comparison value (no char)
	push de
	pop  hl					; HL = Ptr to first slot
	;--
	cp   a, [hl]			; Is the first char slot empty?
	jp   z, .setSlot		; If so, write CharID here
	inc  hl					; Otherwise, check the next
	inc  b					; Slot 1
	;--
	cp   a, [hl]			; Is the second char slot empty?
	jp   z, .setSlot		; If so, write CharID here
	inc  hl					; Otherwise, check the next
	inc  b					; Slot 2
	
	;--
	; This can never jump, as this is never called when the team is full
	cp   a, [hl]			; Is the second char in the team set?
	jp   nz, .noAdd			; If so, don't add anything
	;--
	; Mark that no further characters can be added
	ld   a, CHARSEL_TEAM_FILLED
	ld   [wCharSelTeamFull], a
.setSlot:
	; Write the char ID to the picked slot
	ld   a, c
	ld   [hl], a			
	; C flag cleared, added OK
	xor  a
	ret
.noAdd:
	; C flag set, not added
	scf
	ret
	
; =============== CharSel_DrawP1CharIconForNew ===============
; Draws the icon for a newly selected character on the 1P side.
;
; IN
; - B: Slot number (0-based)
; - C: Character ID
CharSel_DrawP1CharIconForNew:
	;
	; Depending on the slot the character was added to, pick a different location
	; and tile numbers to draw the icon to.
	;
	ld   a, b
	cp   $01			; Is this the second character in the team?
	jp   z, .char1		; If so, jump
	cp   $02			; Is this the third character in the team?
	jp   z, .char2		; If so, jump
	
	; Otherwise, it's the first.
	; In single mode, this is the only one available.
.char0:
	ld   a, c						; A = Character ID
	ld   de, $8DD0					; DE = GFX Ptr
	ld   hl, BG_CHARSEL_P1ICON0+1	; HL = Tilemap ptr (top-right)
	ld   c, TILE_CHARSEL_P1ICON0	; C = Tile ID pointing to DE
	jp   .draw
.char1:
	ld   a, c
	ld   de, $8E10
	ld   hl, BG_CHARSEL_P1ICON1+1
	ld   c, TILE_CHARSEL_P1ICON1
	jp   .draw
.char2:
	ld   a, c
	ld   de, $8E50
	ld   hl, BG_CHARSEL_P1ICON2+1
	ld   c, TILE_CHARSEL_P1ICON2
.draw:
	sla  a							; CharId *= 2
	call Char_DrawIconFlipX
	ret
	
; =============== CharSel_DrawP2CharIconForNew ===============
; Draws the icon for a newly selected character on the 2P side.
; See also: CharSel_DrawP1CharIconForNew
;
; IN
; - B: Slot number (0-based)
; - C: Character ID
CharSel_DrawP2CharIconForNew:
	ld   a, b
	cp   $01
	jp   z, .char1
	cp   $02
	jp   z, .char2
.char0:
	ld   a, c
	ld   de, $8E90
	ld   hl, BG_CHARSEL_P2ICON0
	ld   c, TILE_CHARSEL_P2ICON0
	jp   .draw
.char1:
	ld   a, c
	ld   de, $8ED0
	ld   hl, BG_CHARSEL_P2ICON1
	ld   c, TILE_CHARSEL_P2ICON1
	jp   .draw
.char2:
	ld   a, c
	ld   de, $8F10
	ld   hl, BG_CHARSEL_P2ICON2
	ld   c, TILE_CHARSEL_P2ICON2
.draw:
	sla  a							; CharId *= 2
	call Char_DrawIcon
	ret
	
; =============== CharSel_GetInput ===============
; Gets the player input for the character select screen.
; This merges the key info from the delayed held input fields set in JoyKeys_DoCursorDelayTimer.
; See also: Title_GetMenuInput
; OUT
; - A: Newly pressed KEY_*
; - B: Intermittent KEY_*
; - C: Held KEY_*
CharSel_GetInput:

	;
	; Pick the controller from the active side
	;
	ld   a, [wCharSelCurPl]
	cp   CHARSEL_1P			; Playing as player 1?
	jp   nz, .pl2			; If not, jump
.pl1:
	ld   hl, hJoyKeys
	jp   .go
.pl2:
	ld   hl, hJoyKeys2
.go:
	ld   c, [hl]		; C = Held keys
	inc  hl				; Seek to hJoyNewKeys
	ld   a, [hl]		; A = Newly held keys
	
	push af
		push bc
			inc  hl
			inc  hl					; Seek to hJoyKeysDelayTbl
			
			;
			; Merge back the bits in the 8 iKeyMenuHeld fields into a into a KEY_* bitmask.
			;
			
			; For each DelayTbl entry mark the MSB if needed and rotate left.
			
			ld   b, $00				; B = Output KEY_* mask
			ld   c, $08				; C = Bits in byte
		.loop:
			ldi  a, [hl]			; A = iKeyMenuHeld
			inc  hl					; Skip to next entry
			; Only use key entries with value $01, which means that either:
			; - The key was just pressed
			; - The delay countdown reached 0, which set the key entry to $01
			cp   $01				; iKeyMenuHeld == $01?
			jp   nz, .next			; If not, skip
			set  7, b				; Set the MSB
		.next:
			rlc  b					; Next bit (<<R 1)
			dec  c					; BitsLeft--
			jp   nz, .loop			; Are we done? If not, loop	

			ld   d, b		; Save B
		pop  bc				; Restore C
		ld   b, d			; Restore B
	pop  af
	ret
; =============== CharSel_DrawCrossOver ===============
; Draws a cross over the specified character portrait in VRAM.
; IN
; - A: CHAR_ID_* value
; - HL: Ptr to start of wCharSeqTbl 
CharSel_DrawCrossOver:
	bit  CHARSEL_POSFB_DEFEATED, a	; Did we beat this opponent yet?
	ret  z							; If not, return
	and  a, $FF^CHARSEL_POSF_DEFEATED	; Filter out flag to get real cursor pos id
	sla  a							; A *= 2
	ld   de, CharSel_IdTilesMapTbl	; DE = Table of VRAM pointers
	ld   h, $00						; HL = A * 2
	ld   l, a
	add  hl, de						; Index it
	ld   e, [hl]					; DE = Ptr to portrait GFX in VRAM
	inc  hl
	ld   d, [hl]
	ld   hl, GFXDef_CharSel_Cross	; HL = Ptr to (Tile count + cross GFX)
	ld   bc, GFX_CharSel_Cross_Mask	; DE = Ptr to transparency mask
	call CopyTilesOver				; Draw the cross
	ret  
	
; =============== CharSel_IdTilesMapTbl ===============
; This table maps character IDs to the position of their portrait GFX in VRAM.
;
; These pointers of course are based on the location GFXDef_CharSel_BG0 and GFXDef_CharSel_BG1 are loaded to.
;
; [TCRF] These also contains an unique pointer for Nakoruru, which isn't possible
;        to see normally.
CharSel_IdTilesMapTbl:
	dw $92F0 ; CHAR_ID_KYO     
	dw $9380 ; CHAR_ID_BENIMARU
	dw $9410 ; CHAR_ID_RYO     
	dw $94A0 ; CHAR_ID_YURI    
	dw $9530 ; CHAR_ID_TERRY   
	dw $95C0 ; CHAR_ID_JOE     
	dw $9650 ; CHAR_ID_HEIDERN 
	dw $96E0 ; CHAR_ID_RALF    
	dw $9770 ; CHAR_ID_ATHENA  
	dw $8800 ; CHAR_ID_KENSOU  
	dw $8890 ; CHAR_ID_KIM     
	dw $8920 ; CHAR_ID_MAI     
	dw $89B0 ; CHAR_ID_IORI    
	dw $8A40 ; CHAR_ID_EIJI    
	dw $8AD0 ; CHAR_ID_BILLY   
	dw $8B60 ; CHAR_ID_SAISYU  
	dw $8BF0 ; CHAR_ID_RUGAL   
	dw $8C80 ; CHAR_ID_NAKORURU (impossible to see)

; =============== CharSel_PrintCharName ===============
; Writes the name for the specified character to the tilemap.
; This also updates the cursor's position, which was moved to its own function in 96.
; IN
; -  A: Character ID
; - DE: Ptr to start of wOBJInfo, marks player
CharSel_PrintCharName:
	push af
		push de
			ld   b, a			; B = CharId
			
			; Determine the player we're printing text for through wOBJInfo's location.
			; This is checked since player 1 and player 2 align the text differently.
			ld   a, LOW(wOBJInfo_Pl1)	; A = Player 1 location
			cp   a, e					; Does it match with what we sent?
			jp   nz, .pl2				; If not, it's player 2
			
		.pl1:
			; Blank out the old name
			push bc
				ld   hl, TextC_Char_None
				ld   de, BG_CHARSEL_P1NAME
				call TextPrinter_Instant_CustomPos
			pop  bc
			
			; Player 1 aligns the name to the left.
			; There's nothing special to do, the starting location is always the same.
			ld   de, BG_CHARSEL_P1NAME
			jp   .printString
			
		.pl2:
			; Blank out the old name
			push bc
				ld   hl, TextC_Char_None
			IF VER_96F
				; [BUG] The fake 96 targets the next row by mistake
				ld   de, BG_CHARSEL_P2NAME-$07+BG_TILECOUNT_H
			ELSE
				ld   de, BG_CHARSEL_P2NAME-$07
			ENDC
				
				call TextPrinter_Instant_CustomPos
			pop  bc
			
			; Player 2 aligns the name to the right.
			
			; The strings here aren't padded (as they are shared between players),
			; so the starting location depends on the character and is obtained through a table.
			; DE = CharSel_CharNameBGPtrTbl[CharId]
			push bc
				ld   a, b							; A = CharId * 2
				sla  a
				ld   bc, CharSel_CharNameBGPtrTbl	; BC = VRAM Ptr table
				ld   h, $00							; HL = A
				ld   l, a
				add  hl, bc							; Index it
				ld   e, [hl]						; Read it out to DE
				inc  hl
				ld   d, [hl]
			pop  bc
			
		.printString:
			; Get the ptr to the TextC structure off the table
			; HL = CharSel_CharNamePtrTable[CharId]
			ld   a, b							; A = CharId * 2
			sla  a
			ld   bc, CharSel_CharNamePtrTable	; BC = Text ptr table
			ld   h, $00							; HL = A
			ld   l, a
			add  hl, bc							; Index it
			ld   c, [hl]						; Read it out to BC
			inc  hl
			ld   b, [hl]
			push bc
			pop  hl								; Move it to HL
			
			; HL = Ptr to TextC structure
			; DE = Tilemap ptr
			call TextPrinter_Instant_CustomPos
		pop  de
	pop  af
	
	; Everything below was moved to CharSel_RefreshCursor in 96, where it
	; also updated the cursor size.
	
	;
	; Determine the X and Y positions of the cursor.
	; This is determined by a table of coordinates.
	;
	push bc
	
		; Seek to the table entry.
		sla  a				; PicId * 2 since entries are 2 bytes
		ld   bc, CharSel_CursorPosTable	; BC = Table start
		ld   h, $00			; HL = A
		ld   l, a
		add  hl, bc			; Offset the table
		push hl
		pop  bc				; Move result to BC
		
		; 
		ld   hl, iOBJInfo_X	; Seek to iOBJInfo_X
		add  hl, de
		ld   a, [bc]		; Read X position from byte0
		ld   [hl], a		; Write it
		inc  bc				; Seek to byte1
		ld   hl, iOBJInfo_Y	; Seek to iOBJInfo_Y
		add  hl, de
		ld   a, [bc]		; Read Y position from byte1
		ld   [hl], a		; Write it
	pop  bc
	ret
	
; =============== CharSel_CursorPosTable ===============
; Maps character IDs to cursor sprite positions.
CharSel_CursorPosTable:
IF VER_96F
YOFFSET = $28 ; Shifted down
ELSE
YOFFSET = 0
ENDC
	db $00,$00+YOFFSET ; CHAR_ID_KYO     
	db $18,$00+YOFFSET ; CHAR_ID_BENIMARU
	db $30,$00+YOFFSET ; CHAR_ID_RYO     
	db $48,$00+YOFFSET ; CHAR_ID_YURI    
	db $60,$00+YOFFSET ; CHAR_ID_TERRY   
	db $78,$00+YOFFSET ; CHAR_ID_JOE     
	db $00,$18+YOFFSET ; CHAR_ID_HEIDERN 
	db $18,$18+YOFFSET ; CHAR_ID_RALF    
	db $30,$18+YOFFSET ; CHAR_ID_ATHENA  
	db $48,$18+YOFFSET ; CHAR_ID_KENSOU  
	db $60,$18+YOFFSET ; CHAR_ID_KIM     
	db $78,$18+YOFFSET ; CHAR_ID_MAI     
	db $00,$30+YOFFSET ; CHAR_ID_IORI    
	db $18,$30+YOFFSET ; CHAR_ID_EIJI    
	db $30,$30+YOFFSET ; CHAR_ID_BILLY   
	db $48,$30+YOFFSET ; CHAR_ID_SAISYU  
	db $60,$30+YOFFSET ; CHAR_ID_RUGAL   
	db $78,$30+YOFFSET ; CHAR_ID_NAKORURU
	
; =============== CharSel_CharNameBGPtrTbl ===============
; Ptr table to the starting tilemap positions on 2P side, indexed by character ID.
; The pointer for each character should always be equal to $99B3-(name length).
CharSel_CharNameBGPtrTbl:
IF VER_96F
TOFFSET = -(BG_TILECOUNT_H*7) ; Shifted up 7 tiles
ELSE
TOFFSET = 0
ENDC
	dw $99B0+TOFFSET ; CHAR_ID_KYO     
	dw $99AB+TOFFSET ; CHAR_ID_BENIMARU
	dw $99B0+TOFFSET ; CHAR_ID_RYO     
	dw $99AF+TOFFSET ; CHAR_ID_YURI    
	dw $99AE+TOFFSET ; CHAR_ID_TERRY   
	dw $99B0+TOFFSET ; CHAR_ID_JOE     
	dw $99AC+TOFFSET ; CHAR_ID_HEIDERN 
	dw $99AF+TOFFSET ; CHAR_ID_RALF    
	dw $99AD+TOFFSET ; CHAR_ID_ATHENA  
	dw $99AD+TOFFSET ; CHAR_ID_KENSOU  
	dw $99B0+TOFFSET ; CHAR_ID_KIM     
	dw $99B0+TOFFSET ; CHAR_ID_MAI     
	dw $99AF+TOFFSET ; CHAR_ID_IORI    
	dw $99AF+TOFFSET ; CHAR_ID_EIJI    
	dw $99AE+TOFFSET ; CHAR_ID_BILLY   
	dw $99AD+TOFFSET ; CHAR_ID_SAISYU  
	dw $99AE+TOFFSET ; CHAR_ID_RUGAL   
	dw $99AB+TOFFSET ; CHAR_ID_NAKORURU
	
; =============== CharSel_CharNamePtrTable ===============
; Ptr table to the character names, indexed by character ID.
CharSel_CharNamePtrTable:
	dw TextC_Char_Kyo
	dw TextC_Char_Benimaru
	dw TextC_Char_Ryo
	dw TextC_Char_Yuri
	dw TextC_Char_Terry
	dw TextC_Char_Joe
	dw TextC_Char_Heidern
	dw TextC_Char_Ralf
	dw TextC_Char_Athena
	dw TextC_Char_Kensou
	dw TextC_Char_Kim
	dw TextC_Char_Mai
	dw TextC_Char_Iori
	dw TextC_Char_Eiji
	dw TextC_Char_Billy
	dw TextC_Char_Saisyu
	dw TextC_Char_Rugal
	dw TextC_Char_Nakoruru

; =============== TextC_Char_* ===============
; These lack the tilemap offset, as they are passed to TextPrinter_Instant_CustomPos.

; Empty line used to clear out the old character name.
TextC_Char_None:     mTxtDef "        "
; Actual player names.
TextC_Char_Kyo:      mTxtDef "KYO"
TextC_Char_Benimaru: mTxtDef "BENIMARU"
TextC_Char_Ryo:      mTxtDef "RYO"
TextC_Char_Yuri:     mTxtDef "YURI"
TextC_Char_Terry:    mTxtDef "TERRY"
TextC_Char_Joe:      mTxtDef "JOE"
; [BUG] Bizzarely, the English versions have a typo.
IF VER_EN && !FIX_BUGS
TextC_Char_Heidern:  mTxtDef "JEIDERN"
ELSE
TextC_Char_Heidern:  mTxtDef "HEIDERN"
ENDC
TextC_Char_Ralf:     mTxtDef "RALF"
TextC_Char_Athena:   mTxtDef "ATHENA"
TextC_Char_Kensou:   mTxtDef "KENSOU"
TextC_Char_Kim:      mTxtDef "KIM"
TextC_Char_Mai:      mTxtDef "MAI"
TextC_Char_Iori:     mTxtDef "IORI"
TextC_Char_Eiji:     mTxtDef "EIJI"
TextC_Char_Billy:    mTxtDef "BILLY"
TextC_Char_Saisyu:   mTxtDef "SAISYU"
TextC_Char_Rugal:    mTxtDef "RUGAL"
TextC_Char_Nakoruru: mTxtDef "NAKORURU"

; =============== CharSel_AnimCursorPalFast ===============
; Cycles the cursor palette fast, used when still selecting something.
; OUT
; - Z: If set, the cursor isn't visible
CharSel_AnimCursorPalFast:
	; A = (Timer % 8) / 2
	ld   a, [wTimer]
	and  a, $07
	srl  a			; / 2 for fast speed
	jp   CharSel_AnimCursorPal
; =============== CharSel_AnimCursorPalSlow ===============
; Cycles the cursor palette slowly, used after selecting all characters.
; OUT
; - Z: If set, the cursor isn't visible
CharSel_AnimCursorPalSlow:
	; A = (Timer % $10) / 4
	ld   a, [wTimer]
	and  a, $0F
	srl  a			; / 2 for slow speed
	srl  a
; =============== CharSel_AnimCursorPal ===============
; IN
; - A: Palette ID (0-3)
; OUT
; - Z: If set, the cursor isn't visible
CharSel_AnimCursorPal:
	cp   $01			; A == 1?
	jp   z, .pal1		; If so, jump
	cp   $02			; ...
	jp   z, .pal2
	cp   $03
	jp   z, .pal3
	; Otherwise, A == 0
.pal0:
	ld   a, $3C			; A = OBP pal 0
	jp   .setPal
.pal1:
	ld   a, $34
	jp   .setPal
.pal2:
	ld   a, $F0
	jp   .setPal
.pal3:
	ld   a, $F4
	
.setPal:
	ld   hl, wCharSelCurPl
	bit  0, [hl]			; Are we player 1?
	jp   nz, .pl2			; If not, jump
.pl1:
	; Set the previously specified palette
	ldh  [rOBP0], a
	ret
.pl2:
	; Set the previously specified palette
	ldh  [rOBP1], a
	ret
	
; =============== CharSel_BlinkStartText ===============
; Blinks the "START" text under the character icons.
CharSel_BlinkStartText:

	; Alternate every 8 frames between showing and hiding the string
	ld   a, [wTimer]
	bit  3, a						; (wTimer & 8) != 0?
	jp   nz, CharSel_PrintStartText	; If so, jump
	; Fall-through
	
; =============== CharSel_HideStartText ===============
; Hides the START text for the current character.
CharSel_HideStartText:
	ld   hl, TextC_CharSel_StartBlank
	
	; Different tilemap ptr between players
	ld   a, [wCharSelCurPl]
	bit  0, a				; Handling player 1? (CurPl == 0)
	jp   nz, .pl2			; If not, jump
.pl1:
	ld   de, $9A21
	jp   .print
.pl2:
	ld   de, $9A2E
.print:
	call TextPrinter_Instant_CustomPos
	ret
	
; =============== CharSel_PrintStartText ===============
; Displays the START text for the current character.
CharSel_PrintStartText:
	ld   hl, TextC_CharSel_Start
	; Different tilemap ptr between players
	ld   a, [wCharSelCurPl]
	bit  0, a				; Handling player 1? (CurPl == 0)
	jp   nz, .pl2		; If not, jump
.pl1:
	ld   de, $9A21
	jp   .print
.pl2:
	ld   de, $9A2E
.print:
	call TextPrinter_Instant_CustomPos
	ret
	
TextC_CharSel_Start:      mTxtDef "START"
TextC_CharSel_StartBlank: mTxtDef "     "
	
; =============== CharSel_HideCursor ===============
; Hides the cursor for the current player.
CharSel_HideCursor:
	ld   a, [wCharSelCurPl]
	or   a					; wCharSelCurPl == CHARSEL_1P?
	jp   nz, .pl2			; If not, jump
.pl1:
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret
.pl2:;J
	ld   hl, wOBJInfo_Pl2+iOBJInfo_Status
	res  OSTB_VISIBLE, [hl]
	ret
	
; =============== CharSel_SetPlInfo ===============
; Sets the selected characters into the player struct (wPlInfo).
CharSel_SetPlInfo:
	ld   a, [wCharSelCurPl]
	or   a					; wCharSelCurPl == CHARSEL_1P?
	jp   nz, .pl2			; If not, jump
.pl1:
	; Set the first team member for 1P, which always exist.
	;
	; Note that the character IDs written to the player struct are
	; all multiplied by 2, to work as-is with ptr tables.
	ld   de, wCharSelP1Char0		; DE = Ptr to 1st team member
	ld   a, [de]					; A = CharId * 2
	sla  a
	
	; Copy to current character ID (first to fight)
	ld   hl, wPlInfo_Pl1+iPlInfo_CharId
	ld   [hl], a
	; Write to 1st team member ID
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamCharId0
	ld   [hl], a
	
	;
	; Write the 2nd and 3rd team members.
	;
REPT 2
	inc  hl			; Seek to next iPlInfo_TeamCharId*
	inc  de			; Seek to next wCharSelP1Char*
	ld   a, [de]	; A = CharId
	sla  a			; CharId *= 2
	ld   [hl], a	; Write it
ENDR
	ret  
.pl2:
	; Like the other, but for 2P
	ld   de, wCharSelP2Char0
	ld   a, [de]
	sla  a
	
	ld   hl, wPlInfo_Pl2+iPlInfo_CharId
	ld   [hl], a
	
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamCharId0
	ld   [hl], a
	
REPT 2
	inc  hl		
	inc  de		
	ld   a, [de]
	sla  a		
	ld   [hl], a
ENDR
	ret  
	
; =============== CharSel_DrawUnlockedChars ===============
; Draws all of the portraits for unlocked characters.
; This also sets the values that prevent the cursor from moving over
; the locked characters.
CharSel_DrawUnlockedChars:
	; Go in the CHARSEL_ID_* order, since it's the order of the characters
	ld   b, $00		; B = Starting character id
	ld   c, $00		; C = Starting tile id base
.loop:
	;
	; Hide locked characters.
	;
	; Hiding locked characters is simply accomplished by skipping the
	; call to draw the portrait to the tilemap.
	; Additionally, it also sets the wCharSelIdMapTbl entries for locked
	; characters to a non-zero value, which prevents access to those.
	;

	; Nakoruru is only drawn when the "All Characters" dip switch is set
	ld   a, b
IF VER_96F
	; Fake 96 draws all characters by causing the check to always fail, same for the bosses.
	cp   $18
ELSE
	cp   CHAR_ID_NAKORURU/2		; Trying to draw Nakoruru's portrait?
ENDC
	jp   z, .chkUnlockNakoruru	; If so, jump
	jp   .chkBoss
.chkUnlockNakoruru:
	ld   a, [wDipSwitch]
	bit  DIPB_UNLOCK_OTHER, a	; Are all characters unlocked?
	jp   nz, .charOk			; If so, jump
	; Otherwise, disable his slots and skip him
	ld   a, $01
	ld   [wCharSelIdMapTbl+CHAR_ID_NAKORURU/2], a
	jp   .nextChar
.chkBoss:;J
	ld   a, b
	
IF VER_96F
	cp   $18
ELSE
	cp   CHAR_ID_SAISYU/2		; Trying to draw Saisyu's portrait?
ENDC
	jp   z, .chkUnlockBoss		; If so, jump
	
IF VER_96F
	cp   $18
ELSE
	cp   CHAR_ID_RUGAL/2		; Trying to Rugal's Saisyu's portrait?
ENDC
	jp   z, .chkUnlockBoss		; If so, jump
	jp   .charOk				; Everything else can be drawn
.chkUnlockBoss:
	ld   a, [wDipSwitch]
	bit  DIPB_UNLOCK_BOSS, a	; Is Goenitz unlocked?
	jp   nz, .charOk			; If so, jump
	; Otherwise, disable their slots and skip them
	ld   a, $01
	ld   [wCharSelIdMapTbl+CHAR_ID_SAISYU/2], a
	ld   [wCharSelIdMapTbl+CHAR_ID_RUGAL/2], a
	jp   .nextChar
.charOk:
	push bc
	;## Extracted to CharSel_DrawPortrait in 96. ##
	;
	; Draws a character portrait.
	;
	; IN
	; - B: Character ID (CHAR_ID_* / 2)
	;      Determines the portrait position.
	; - C: Base tile ID.
	;      
	
		;
		; Index CharSel_IdBGMapTbl with B and read out its pointer to HL.
		; 
		ld   hl, CharSel_IdBGMapTbl	; HL = Map index
		ld   a, b					; A = L + (CharId * 2)			
		sla  a
		add  a, l
		jp   nc, .noInc				; Did we overflow? If not, skip
		inc  h						; If so, H++ (never happens)
	.noInc:
		ld   l, a					; HL = CharSel_IdBGMapTbl entry
		; Read out the tilemap ptr to DE
		ld   e, [hl]				
		inc  hl
		ld   d, [hl]				
		push de						; And move it to HL
		pop  hl						; HL = Tilemap ptr
		
		;
		; Draw the portrait.
		; The tilemap for the portrait is always the same as it uses 9 consecutive tiles.
		; What makes the difference is the base tile ID CopyBGToRectWithBase.
		;
		ld   de, BG_CharSel_Portrait; DE = Relative tile IDs
		ld   a, c					; A = Tile ID base
		ld   b, $03					; B = Portrait width
		ld   c, $03					; C = Portrait height
		call CopyBGToRectWithBase
	;##
	pop  bc
.nextChar:
	; Set the info for the next portrait.
	; Each portrait uses 9 continuous tiles, and they are also ordered by CHAR_ID_* in the GFX.
	; Therefore, increasing the TileId offset by 9 is all that's needed to seek to the next. 
	ld   a, $09				; TileId += 9
	add  c					
	ld   c, a
	inc  b					; Next character id
	ld   a, b
	cp   CHAR_COUNT			; Went past the last valid portrait?
	jp   nz, .loop			; If so, jump
	ret
	
; =============== CharSel_IdBGMapTbl ===============
; This table maps character IDs to their origin in the tilemap.
;
; Portraits are 3 tiles wide and 3 tiles high, and their origin is the top-left tile.
;
CharSel_IdBGMapTbl:
IF VER_96F
TOFFSET = BG_TILECOUNT_H*5 ; 5 tiles down
ELSE
TOFFSET = 0
ENDC
	dw $9861+TOFFSET ; CHAR_ID_KYO     
	dw $9864+TOFFSET ; CHAR_ID_BENIMARU
	dw $9867+TOFFSET ; CHAR_ID_RYO     
	dw $986A+TOFFSET ; CHAR_ID_YURI    
	dw $986D+TOFFSET ; CHAR_ID_TERRY   
	dw $9870+TOFFSET ; CHAR_ID_JOE     
	dw $98C1+TOFFSET ; CHAR_ID_HEIDERN 
	dw $98C4+TOFFSET ; CHAR_ID_RALF    
	dw $98C7+TOFFSET ; CHAR_ID_ATHENA  
	dw $98CA+TOFFSET ; CHAR_ID_KENSOU  
	dw $98CD+TOFFSET ; CHAR_ID_KIM     
	dw $98D0+TOFFSET ; CHAR_ID_MAI     
	dw $9921+TOFFSET ; CHAR_ID_IORI    
	dw $9924+TOFFSET ; CHAR_ID_EIJI    
	dw $9927+TOFFSET ; CHAR_ID_BILLY   
	dw $992A+TOFFSET ; CHAR_ID_SAISYU  
	dw $992D+TOFFSET ; CHAR_ID_RUGAL   
	dw $9930+TOFFSET ; CHAR_ID_NAKORURU

; =============== CharSelect_IsCPUOpponent ===============
; Checks if the current player is a CPU opponent, meaning it's not actively
; controlled by the GB's joypad input.
;
; Note that this is separate from a player being CPU-controlled, as in
; CPU vs CPU matches the player does get to control one of the cursors.
;
; OUT
; - C flag: If set, this player is the CPU opponent
CharSelect_IsCPUOpponent:

	; No CPU opponents in VS modes
	ld   a, [wPlayMode]
	bit  MODEB_VS, a			; Are we in VS mode?
	jp   nz, .retClear			; If so, return clear
	
	; Depending on the current player...
	ld   a, [wCharSelCurPl]
	or   a						; Currently handling player 1? (== CHARSEL_1P)
	jp   nz, .chkCpu2P			; If not, jump
.chkCpu1P:
	; Currently handling 1P.
	; For 1P to be a CPU opponent, P2 must have control on the char select screen
	ld   a, [wJoyActivePl]
	or   a						; Playing on the 1P side? (== PL1)
	jp   z, .retClear			; If so, return clear
	
	jp   .retSet
.chkCpu2P:
	; Currently handling 2P.
	; For 2P to be a CPU opponent, 1P must have control on the char select screen
	ld   a, [wJoyActivePl]
	or   a						; Playing on the 2P side? (!= PL1)
	jp   nz, .retClear			; If so, return clear 
.retSet:
	scf		; C flag = 1, not controllable by player
	ret
.retClear:
	scf
	ccf		; C flag = 0, controllable by player
	ret
	
; =============== CharSelect_IsLastWinner ===============
; Checks if, in single modes, the active player won the last round.
;
; This is used to prevent the player from changing team between rounds,
; unless it's after a game over.
; OUT
; - C flag: If set, the active side won
CharSelect_IsLastWinner:
	; Not applicable in VS mode, since both players are allowed to change teams
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   nz, .retClear		; If so, return clear
	
	; Depending on the current player...
	ld   a, [wCharSelCurPl]
	or   a					; Are we handling 1P?
	jp   nz, .pl2			; If not, jump
.pl1:
	; Not applicable here if 1P is the CPU opponent
	ld   a, [wJoyActivePl]
	or   a					; Playing on the 1P side?
	jp   nz, .retClear		; If not, return clear
	
	; Final check
	ld   a, [wLastWinner]
	bit  PLB1, a			; Did 1P win the last round?
	jp   nz, .retSet		; If so, return set
	
	; Otherwise, we game over'd before.
	; Allow changing the team.
	jp   .retClear
.pl2:
	; Not applicable here if 2P is the CPU opponent
	ld   a, [wJoyActivePl]
	or   a					; Playing on the 1P side?
	jp   z, .retClear		; If so, return clear
	
	; Final check
	ld   a, [wLastWinner]
	bit  PLB2, a			; Did 2P win the last round?
	jp   nz, .retSet		; If so, return set
	
	; Otherwise, we game over'd before.
	; Allow changing the team.
	jp   .retClear
.retSet:
	scf		; C flag = 1
	ret
.retClear:
	scf
	ccf		; C flag = 0
	ret
	
; Relative tile IDs for portraits
BG_CharSel_Portrait: INCBIN "data/bg/charsel_portrait.bin"
TextDef_CharSel_SingleTitle:
	dw $9823
	mTxtDef "PLAYER  SELECT"
TextDef_CharSel_TeamTitle:
	dw $9824
	mTxtDef "TEAM  SELECT"
	
; 
; =============== END OF MODULE CharSel ===============
;

; 
; =============== START OF MODULE OrdSel ===============
;

IF VER_96F
GFXDef_OrdSel_NumPic: mGfxDef "data/gfx/96f/ordsel_numpic.bin"
ELSE
GFXDef_OrdSel_NumPic: mGfxDef "data/gfx/ordsel_numpic.bin"
ENDC
BG_OrdSel_VS: INCBIN "data/bg/ordsel_vs.bin"
BG_OrdSel_Pic1: INCBIN "data/bg/ordsel_pic1.bin"
BG_OrdSel_Pic2: INCBIN "data/bg/ordsel_pic2.bin"
BG_OrdSel_Pic3: INCBIN "data/bg/ordsel_pic3.bin"
GFXDef_OrdSel_OBJ: mGfxDef "data/gfx/ordsel_obj.bin"
INCLUDE "data/objlst/ordsel.asm"

; =============== Module_OrdSel ===============
; EntryPoint for team order select screen.
Module_OrdSel:
	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Initialize all variables
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ld   [wCharSelTeamFull], a
	
	ld   [wOrdSelP1CharsSelected], a
	ld   [wOrdSelP2CharsSelected], a
	ld   [wOrdSelCurPl], a
	ld   [wOrdSelCPUDelay1P], a
	ld   [wOrdSelCPUDelay2P], a
	ld   [wOrdSelP1CursorPos], a
	ld   [wOrdSelP2CursorPos], a
	ld   [wOrdSelP1CharsSelected_Copy], a
	ld   [wOrdSelP2CharsSelected_Copy], a
	ld   [wOrdSelP1CharSel0], a
	ld   [wOrdSelP1CharId0], a
	ld   [wOrdSelP1CharSel1], a
	ld   [wOrdSelP1CharId1], a
	ld   [wOrdSelP1CharSel2], a
	ld   [wOrdSelP1CharId2], a
	ld   [wOrdSelP2CharSel0], a
	ld   [wOrdSelP2CharId0], a
	ld   [wOrdSelP2CharSel1], a
	ld   [wOrdSelP2CharId1], a
	ld   [wOrdSelP2CharSel2], a
	ld   [wOrdSelP2CharId2], a
	
	;
	; Initialize the delay timers, used by the CPU to wait for a bit
	; between selections.
	;
	ld   a, [wPlayMode]
	cp   MODE_TEAM1P		; Playing in 1P mode?				
	jp   nz, .loadVRAM		; If not, skip
.singleMode:
	; In single mode, randomize the inactive side
	ld   a, [wJoyActivePl]
	or   a					; Playing on the 1P side?
	jp   z, .random2P		; If so, jump
.random1P:
	; Playing as 2P, so set the delay on 1P side
	ld   a, $01				
	ld   [wOrdSelCPUDelay1P], a
	jp   .loadVRAM
.random2P:
	; Playing as 1P, so autopick on 2P side
	ld   a, $01
	ld   [wOrdSelCPUDelay2P], a
	
.loadVRAM:
	; Load SGB palettes
	ld   de, SCRPAL_INTRO 					; No specific SGB palette here
	call HomeCall_SGB_ApplyScreenPalSet
	
	; Clear tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset scrolling to top left
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	
	; All OBJ tiles
	ld   hl, GFXDef_OrdSel_OBJ
	ld   de, $8000
	call CopyTilesAutoNum
	
	; Reload the player portrait graphics from the character select screen.
	; This is necessary when that screen is skipped, like after a cutscene.
	ld   hl, GFXDef_CharSel_BG0
	ld   de, $92F0
	call CopyTilesAutoNum
	ld   hl, GFXDef_CharSel_BG1
	ld   de, $8800
	call CopyTilesAutoNum
	
	; Numbered portraits for unfilled slots
	ld   hl, GFXDef_OrdSel_NumPic
	ld   de, $9000
	call CopyTilesAutoNum
	
	; Tilemap for "VS" graphic
	ld   de, BG_OrdSel_VS
	ld   hl, $98E8
	ld   b, $04
	ld   c, $03
	call CopyBGToRect
	
	; Player 1 - Team Member 1 (unfilled)
	ld   de, BG_OrdSel_Pic1
	ld   hl, vBGOrdSelP1CharSel0
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	; Player 1 - Team Member 2 (unfilled)
	ld   de, BG_OrdSel_Pic2
	ld   hl, vBGOrdSelP1CharSel1
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	; Player 1 - Team Member 3 (unfilled)
	ld   de, BG_OrdSel_Pic3
	ld   hl, vBGOrdSelP1CharSel2
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	; Player 2 - Team Member 1 (unfilled)
	ld   de, BG_OrdSel_Pic1
	ld   hl, vBGOrdSelP2CharSel0
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	; Player 2 - Team Member 2 (unfilled)
	ld   de, BG_OrdSel_Pic2
	ld   hl, vBGOrdSelP2CharSel1
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	; Player 2 - Team Member 3 (unfilled)
	ld   de, BG_OrdSel_Pic3
	ld   hl, vBGOrdSelP2CharSel2
	ld   b, $03
	ld   c, $03
	call CopyBGToRect
	
	;
	; Write character icons.
	;
	; These are copied to VRAM as needed to fixed location for each member.
	;
.drawIcon1P:
	; Player 1 - Team Member 1
	; This is always defined.
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId0]
	ld   de, $8DD0				; Destination ptr in VRAM
	ld   hl, $99E2				; Destination ptr in tilemap
	ld   c, $DD					; Tile ID that DE points to
	call Char_DrawIconFlipX
	
	; The other two icons are skipped when fighting bosses in Single Mode if
	; we're playing on the 2P side.
	ld   a, [wPlayMode]
	cp   MODE_TEAM1P			; Are we in 1P mode?
	jp   nz, .drawOther1P		; If not, jump (VS mode has no bosses)
	
	ld   a, [wJoyActivePl]
	or   a						; Playing on the Pl1 side? (== PL1)
	jp   z, .drawOther1P		; If so, jump (we always have 3 players)
	
	ld   a, [wCharSeqId]		
	cp   STAGESEQ_SAISYU		; Are we fighting a boss?
	jp   z, .drawIcon2P			; If so, skip drawing the other two icons
	cp   STAGESEQ_RUGAL			; ""
	jp   z, .drawIcon2P			; ""
	cp   STAGESEQ_NAKORURU		; ""
	jp   z, .drawIcon2P			; ""
	
.drawOther1P:
	; Player 1 - Team Member 2
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId1]
	ld   de, $8E10
	ld   hl, $99E4
	ld   c, $E1
	call Char_DrawIconFlipX
	
	; Player 1 - Team Member 3
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId2]
	ld   de, $8E50
	ld   hl, $99E6
	ld   c, $E5
	call Char_DrawIconFlipX
	
.drawIcon2P:
	; Same thing as above, for the 2P side playing as 1P
	
	; Player 2 - Team Member 1
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId0]
	ld   de, $8E90
	ld   hl, $99F1
	ld   c, $E9
	call Char_DrawIcon

	ld   a, [wPlayMode]
	cp   MODE_TEAM1P
	jp   nz, .drawOther2P
	
	ld   a, [wJoyActivePl]
	or   a
	jp   nz, .drawOther2P
	
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU
	jp   z, .initOBJ
	cp   STAGESEQ_RUGAL	
	jp   z, .initOBJ
	cp   STAGESEQ_NAKORURU
	jp   z, .initOBJ
	
.drawOther2P:
	; Player 2 - Team Member 2
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId1]
	ld   de, $8ED0
	ld   hl, $99EF
	ld   c, $ED
	call Char_DrawIcon
	
	; Player 2 - Team Member 3
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId2]
	ld   de, $8F10
	ld   hl, $99ED
	ld   c, $F1
	call Char_DrawIcon
	
.initOBJ:
	;
	; Load sprite mappings for cursors
	; These reuse the base OBJInfo from character select screen
	;
	
	call ClearOBJInfo

	;
	; Player 1 cursor
	;
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status
	ld   de, OBJInfoInit_CharSel_Cursor
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_Pl1+iOBJInfo_OBJLstPtrTbl_Low
	ld   [hl], LOW(OBJLstPtrTable_OrdSel_Cursor)
	inc  hl
	ld   [hl], HIGH(OBJLstPtrTable_OrdSel_Cursor)
	; Start at the leftmost position
	ld   a, $08
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
	ld   a, $80
	ld   [wOBJInfo_Pl1+iOBJInfo_Y], a
	
	;
	; Player 2 cursor
	;
	ld   hl, wOBJInfo_Pl2+iOBJInfo_Status
	ld   de, OBJInfoInit_CharSel_Cursor
	call OBJLstS_InitFrom
	ld   hl, wOBJInfo_Pl2+iOBJInfo_OBJLstPtrTbl_Low
	ld   [hl], LOW(OBJLstPtrTable_OrdSel_Cursor)
	inc  hl
	ld   [hl], HIGH(OBJLstPtrTable_OrdSel_Cursor)
	; Start at the rightmost position
	ld   a, $88
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
	ld   a, $80
	ld   [wOBJInfo_Pl2+iOBJInfo_Y], a
	
	call Pl_InitBeforeStageLoad	; In case we skipped the character select screen (ie: after cutscene)
	call Serial_DoHandshake
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $74
	ldh  [rOBP0], a
	ld   a, $74
	ldh  [rOBP1], a
	ld   a, $1B
	ldh  [rBGP], a
	
	; Reuse character select music
	ld   a, BGM_CHARSELECT
	call HomeCall_Sound_ReqPlayExId_Stub
	call Task_PassControl_Delay1D
	
	
.mainLoop:
	;
	; The goal of this module is to fill in all wOrdSelP*CharId* variables.
	; Once that's done, they get copied back to the player structs.
	;
	call JoyKeys_DoCursorDelayTimer
	
.doPl1:
	;
	; Handle Player 1
	;
	ld   a, PL1
	ld   [wOrdSelCurPl], a
	call OrdSel_DoMode
	; Hide the cursor when all characters are selected
	ld   a, [wOrdSelP1CharsSelected]
	cp   ORDSEL_SELDONE						; CursorMode == ORDSEL_SELDONE?
	jp   nz, .doPl2							; If not, skip
	ld   hl, wOBJInfo_Pl1+iOBJInfo_Status	; Otherwise, hide the 1P cursor sprite
	res  OSTB_VISIBLE, [hl]
.doPl2:

	;
	; Handle Player 2
	;
	ld   a, PL2
	ld   [wOrdSelCurPl], a
	call OrdSel_DoMode
	; Hide the cursor when all characters are selected
	ld   a, [wOrdSelP2CharsSelected]
	cp    ORDSEL_SELDONE					; CursorMode == ORDSEL_SELDONE?
	jp   nz, .chkEnd						; If not, skip
	ld   hl, wOBJInfo_Pl2+iOBJInfo_Status	; Otherwise, hide the 2P cursor sprite
	res  OSTB_VISIBLE, [hl]
	
.chkEnd:
	;
	; If both players have selected all characters, switch to gameplay after a small delay
	;
	ld   a, [wOrdSelP1CharsSelected]	; A = P1Cursor
	ld   hl, wOrdSelP2CharsSelected	; HL = P2Cursor Ptr
	cp   a, [hl]					; Are both cursors in the same mode?
	jp   nz, .noEnd					; If not, jump
	cp   ORDSEL_SELDONE			; Has 1P finished selecting characters?
	jp   nz, .noEnd					; If not, jump
	; Otherwise, it means ORDSEL_SELDONE is set to both players.
	; We're done.
	jp   .end
.noEnd:
	; Wait for the end of the frame and continue
	call Task_PassControl_NoDelay
	jp   .mainLoop
	
.end:
	;
	; Save the new team order from the temp vars back to the player struct.
	;
	ld   a, [wOrdSelP1CharId0]
	ld   [wPlInfo_Pl1+iPlInfo_TeamCharId0], a
	ld   a, [wOrdSelP1CharId1]
	ld   [wPlInfo_Pl1+iPlInfo_TeamCharId1], a
	ld   a, [wOrdSelP1CharId2]
	ld   [wPlInfo_Pl1+iPlInfo_TeamCharId2], a
	ld   a, [wOrdSelP2CharId0]
	ld   [wPlInfo_Pl2+iPlInfo_TeamCharId0], a
	ld   a, [wOrdSelP2CharId1]
	ld   [wPlInfo_Pl2+iPlInfo_TeamCharId1], a
	ld   a, [wOrdSelP2CharId2]
	ld   [wPlInfo_Pl2+iPlInfo_TeamCharId2], a
	
	; Wait $3B frames, and then init gameplay
	call Task_PassControl_Delay3B
	jp   Module_Play
	
; =============== OrdSel_DoMode ===============
OrdSel_DoMode:
	ld   a, [wOrdSelCurPl]
	or   a						; Handling player 1?
	jp   nz, .pl2				; If not, jump
.pl1:
	;
	; [CPU-only]
	; 
	; Wait for the specified amount of frames before automatically selecting the character
	; the cursor is hovering.
	;
	; This is used to delay the CPU from picking characters, otherwise it would instantly
	; pick all 3 of them in 3 frames.
	; The timer is reset when it reaches $01, and the character the CPU cursor is over is autopicked.
	; Because of this, the CPU always selects the characters in order (ie: from right to left if 2P is the CPU).
	;
	; For human players, the delay is always $00, which allows full control.
	;
	ld   a, [wOrdSelCPUDelay1P]
	and  a					; Delay == 0?
	jp   z, .checkCtrl		; If so, ignore completely (we're a human player)
	cp   a, $01				; Is it exactly 1?
	jp   z, .pl1CPUSel		; If so, jump (the CPU can pick the character)
	; Otherwise, wait
	dec  a					; Delay--
	ld   [wOrdSelCPUDelay1P], a
	ret  
.pl2:
	; Same thing, but for player 2.
	
	; Wait a bit for CPUs
	ld   a, [wOrdSelCPUDelay2P]
	and  a
	jp   z, .checkCtrl
	cp   $01
	jp   z, .pl2CPUSel
	dec  a
	ld   [wOrdSelCPUDelay2P], a
	ret
.checkCtrl:
	;
	; Handle human player controls
	;
	call CharSel_GetInput
	bit  KEYB_A, a
	jp   nz, OrdSel_Ctrl_SelChar
	bit  KEYB_LEFT, b
	jp   nz, OrdSel_Ctrl_MoveL
	bit  KEYB_RIGHT, b
	jp   nz, OrdSel_Ctrl_MoveR
	ret
.pl1CPUSel:
	; Reset 1P delay timer and pick character
	ld   a, $3C
	ld   [wOrdSelCPUDelay1P], a
	jr   OrdSel_Ctrl_SelChar
.pl2CPUSel:
	; Reset 2P delay timer and pick character
	ld   a, $3C
	ld   [wOrdSelCPUDelay2P], a
	
; =============== OrdSel_Ctrl_SelChar ===============
; Selects the character the cursor points to.
OrdSel_Ctrl_SelChar:
	ld   a, [wOrdSelCurPl]
	or   a							; Handling player 1?
	jp   nz, OrdSel_Ctrl_SelChar_P2	; If not, jump
	; Fall-through
	
; =============== OrdSel_Ctrl_SelChar_P1 ===============
OrdSel_Ctrl_SelChar_P1:
	; Don't select any more characters if we've selected them all
	ld   a, [wOrdSelP1CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	;
	; Determine which character we've selected, based on the cursor's position.
	; Iterate over CursorPos until it reaches 0. 
	;
	ld   a, [wOrdSelP1CursorPos]
	ld   b, a									; B = CursorPos						
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId1]	; Char 2 settings
	ld   hl, wOrdSelP1CharSel1
	dec  b										; CursorPos == 1?
	jr   z, .char01Chk							; If so, jump
	
	; Otherwise, check we're over the third character
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId2]	; Char 3 settings
	ld   hl,wOrdSelP1CharSel2
	dec  b										; CursorPos == 2?
	jr   z, .char2Chk							; If so, jump
	
	; Otherwise, we must have selected the first character
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId0]
	ld   hl, wOrdSelP1CharSel0
	
	; Characters are in forward order on the 1P side.
.char01Chk:
	;
	; Move the cursor right. From the 1st to 2nd / 2nd to 3rd character.
	;
	push af
	
		; Move cursor sprite two tiles to the right
		ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
		add  a, TILE_H*2				; iOBJInfo_X += $10
		ld   [wOBJInfo_Pl1+iOBJInfo_X], a
		
		; Increment cursor position
		ld   a, [wOrdSelP1CursorPos]
		inc  a
		ld   [wOrdSelP1CursorPos], a
	pop  af
	jr   .setChar
	
.char2Chk:
	;
	; Move the cursor left. From the 3rd to 2nd character.
	;
	push af
	
		; Move cursor sprite two tiles to the right
		ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
		sub  a, TILE_H*2				; iOBJInfo_X -= $10
		ld   [wOBJInfo_Pl1+iOBJInfo_X], a
		
		; Increment cursor position
		ld   a, [wOrdSelP1CursorPos]
		dec  a
		ld   [wOrdSelP1CursorPos], a
	pop  af
	
.setChar:
	;
	; Mark the character as selected.
	;
	
	; Prevent the cursor from moving over this position again.
	ld   [hl], $01		; Set wOrdSelP1CharSel*
	
	; Remember the character ID for later, as we haven't yet determined where to save it.
	; [POI] In this game only, wOrdSelTmpP1CharId points to the same memory location as
	;       wOrdSelP1CharId1 (the selected 2nd team member).
	;       This shortcut is only done so the game won't need to copy the value when getting to .setNum2.
	ld   [wOrdSelTmpP1CharId], a
	
	;
	; Determine the starting rel. tile for the portrait
	;
	call OrdSel_GetTileOffsetToCharPic		; A = Rel. Tile ID
	
	;
	; Determine where to draw the portrait
	;
	push af
		ld   hl, vBGOrdSelP1CharSel0			; HL = Tilemap ptr for 1st character
		ld   a, [wOrdSelP1CharsSelected_Copy]	; A = Number of selected characters
		and  a									; SelCount == 0?
		jr   z, .chkDrawNum						; If so, jump
		ld   hl, vBGOrdSelP1CharSel1			; HL = Tilemap ptr for 2nd character
		dec  a									; SelCount == 1?
		jr   z, .chkDrawNum						; If so, jump
		ld   hl, vBGOrdSelP1CharSel2			; [POI] We never get here, picking the 2nd immediately autopicks the 3rd.
	.chkDrawNum:
	pop  af
	
	;
	; Draw the resulting portrait
	;
	ld   de, BG_CharSel_Portrait
	ld   b, $03						; Width
	ld   c, $03						; Height
	call CopyBGToRectWithBase
	
	; Increment num. of selected characters, both copies
	ld   a, [wOrdSelP1CharsSelected_Copy]
	inc  a
	ld   [wOrdSelP1CharsSelected_Copy], a
	ld   a, [wOrdSelP1CharsSelected]
	inc  a
	ld   [wOrdSelP1CharsSelected], a
	
	;
	; Determine the order for the character in the team.
	;
	cp   $01						; Did we just select the 1st member?					
	jr   nz, .setNum2				; If not, jump
	
.setNum1:
	; Save current character as first one
	ld   a, [wOrdSelTmpP1CharId]
	ld   [wOrdSelP1CharId0], a
	
	; Stop prematurely if this is a boss
	ld   a, [wPlayMode]
	cp   MODE_TEAM1P			; In Single Mode?
	ret  nz						; If not, return (no boss teams in VS mode)
	ld   a, [wJoyActivePl]
	or   a						; Playing on the Pl1 side? (== PL1)
	ret  z						; If so, return (no boss teams on the player side)
	; Check if this is a boss stage
	ld   a, [wCharSeqId]		
	cp   STAGESEQ_SAISYU
	jp   z, .endPremature
	cp   STAGESEQ_RUGAL
	jp   z, .endPremature
	cp   STAGESEQ_NAKORURU
	jp   z, .endPremature
	; Otherwise, no premature end
	ret
	
.endPremature:
	;--
	; [POI] Pointless, the cursor is hidden on ORDSEL_SELDONE.
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	sub  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
	;--
	; Set that all characters were selected
	ld   a, ORDSEL_SELDONE
	ld   [wOrdSelP1CharsSelected], a
	ret
	
.setNum2:
	; wOrdSelTmpP1CharId points to wOrdSelP1CharId1, so the 2nd character is already selected.

.setNum3:
	;
	; Autoselect the 3rd team member, depending on which slot isn't marked as selected yet.
	;
	ld   a, [wOrdSelP1CharSel0]
	and  a							; Is the 1st character selected?
	jr   z, .setNum3A				; If not, jump
	ld   a, [wOrdSelP1CharSel1]
	and  a							; Is the 2nd character selected?
	jr   z, .setNum3B				; If not, jump
	ld   a, [wOrdSelP1CharSel2]
	and  a							; Is the 3rd character selected?
	jr   z, .setNum3C				; If not, jump
	ret ; We never get here
.setNum3A:
	; 1st slot is the 3rd team member
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId0]	
	ld   [wOrdSelP1CharId2], a					; Set team member
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP1CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase					; Write to tilemap
	ret
.setNum3B:
	; 2nd slot is the 3rd team member
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId1]
	ld   [wOrdSelP1CharId2], a
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP1CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase
	ret
.setNum3C:
	; 3rd slot is the 3rd team member
	ld   a, [wPlInfo_Pl1+iPlInfo_TeamCharId2]
	ld   [wOrdSelP1CharId2], a
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP1CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase
	ret
	
; =============== OrdSel_Ctrl_SelChar_P2 ===============
OrdSel_Ctrl_SelChar_P2:
	; Don't select any more characters if we've selected them all
	ld   a, [wOrdSelP2CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	;
	; Determine which character we've selected, based on the cursor's position.
	; Iterate over CursorPos until it reaches 0. 
	;
	ld   a, [wOrdSelP2CursorPos]
	ld   b, a									; B = CursorPos						
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId1]	; Char 2 settings
	ld   hl, wOrdSelP2CharSel1
	dec  b										; CursorPos == 1?
	jr   z, .char01Chk							; If so, jump
	
	; Otherwise, check we're over the third character
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId2]	; Char 3 settings
	ld   hl,wOrdSelP2CharSel2
	dec  b										; CursorPos == 2?
	jr   z, .char2Chk							; If so, jump
	
	; Otherwise, we must have selected the first character
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId0]
	ld   hl, wOrdSelP2CharSel0
	
	; Characters are in reverse order on the 2P side.
.char01Chk:
	;
	; Move the cursor left. From the 1st to 2nd / 2nd to 3rd character.
	;
	push af
	
		; Move cursor sprite two tiles to the left
		ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
		sub  a, TILE_H*2				; iOBJInfo_X += $10
		ld   [wOBJInfo_Pl2+iOBJInfo_X], a
		
		; Increment cursor position
		ld   a, [wOrdSelP2CursorPos]
		inc  a
		ld   [wOrdSelP2CursorPos], a
	pop  af
	jr   .setChar
	
.char2Chk:
	;
	; Move the cursor right. From the 3rd to 2nd character.
	;
	push af
	
		; Move cursor sprite two tiles to the right
		ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
		add  a, TILE_H*2				; iOBJInfo_X -= $10
		ld   [wOBJInfo_Pl2+iOBJInfo_X], a
		
		; Increment cursor position
		ld   a, [wOrdSelP2CursorPos]
		dec  a
		ld   [wOrdSelP2CursorPos], a
	pop  af
	
.setChar:
	;
	; Mark the character as selected.
	;
	
	; Prevent the cursor from moving over this position again.
	ld   [hl], $01		; Set wOrdSelP2CharSel*
	
	; Remember the character ID for later, as we haven't yet determined where to save it.
	; [POI] In this game only, wOrdSelTmpP2CharId points to the same memory location as
	;       wOrdSelP2CharId1 (the selected 2nd team member).
	;       This confusing shortcut is only done so the game won't need to copy the value when getting to .setNum2.
	ld   [wOrdSelTmpP2CharId], a
	
	;
	; Determine the starting rel. tile for the portrait
	;
	call OrdSel_GetTileOffsetToCharPic		; A = Rel. Tile ID
	
	;
	; Determine where to draw the portrait
	;
	push af
		ld   hl, vBGOrdSelP2CharSel0			; HL = Tilemap ptr for 1st character
		ld   a, [wOrdSelP2CharsSelected_Copy]	; A = Number of selected characters
		and  a									; SelCount == 0?
		jr   z, .chkDrawNum						; If so, jump
		ld   hl, vBGOrdSelP2CharSel1			; HL = Tilemap ptr for 2nd character
		dec  a									; SelCount == 1?
		jr   z, .chkDrawNum						; If so, jump
		ld   hl, vBGOrdSelP2CharSel2			; [POI] We never get here, picking the 2nd immediately autopicks the 3rd.
	.chkDrawNum:
	pop  af
	
	;
	; Draw the resulting portrait
	;
	ld   de, BG_CharSel_Portrait
	ld   b, $03						; Width
	ld   c, $03						; Height
	call CopyBGToRectWithBase
	
	; Increment num. of selected characters, both copies
	ld   a, [wOrdSelP2CharsSelected_Copy]
	inc  a
	ld   [wOrdSelP2CharsSelected_Copy], a
	ld   a, [wOrdSelP2CharsSelected]
	inc  a
	ld   [wOrdSelP2CharsSelected], a
	
	;
	; Determine the order for the character in the team.
	;
	cp   $01						; Did we just select the 1st member?					
	jr   nz, .setNum2				; If not, jump
	
.setNum1:
	; Save current character as first one
	ld   a, [wOrdSelTmpP2CharId]
	ld   [wOrdSelP2CharId0], a
	
	; Stop prematurely if this is a boss
	ld   a, [wPlayMode]
	cp   MODE_TEAM1P			; In Single Mode?
	ret  nz						; If not, return (no boss teams in VS mode)
	ld   a, [wJoyActivePl]
	or   a						; Playing on the Pl2 side? (== Pl2)
	ret  nz						; If not, return (no boss teams on the player side)
	; Check if this is a boss stage
	ld   a, [wCharSeqId]		
	cp   STAGESEQ_SAISYU
	jp   z, .endPremature
	cp   STAGESEQ_RUGAL
	jp   z, .endPremature
	cp   STAGESEQ_NAKORURU
	jp   z, .endPremature
	; Otherwise, no premature end
	ret
	
.endPremature:
	;--
	; [POI] Pointless, the cursor is hidden on ORDSEL_SELDONE.
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	add  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
	;--
	; Set that all characters were selected
	ld   a, ORDSEL_SELDONE
	ld   [wOrdSelP2CharsSelected], a
	ret
	
.setNum2:
	; wOrdSelTmpP2CharId points to wOrdSelP2CharId1, so the 2nd character is already selected.

.setNum3:
	;
	; Autoselect the 3rd team member, depending on which slot isn't marked as selected yet.
	;
	ld   a, [wOrdSelP2CharSel0]
	and  a							; Is the 1st character selected?
	jr   z, .setNum3A				; If not, jump
	ld   a, [wOrdSelP2CharSel1]
	and  a							; Is the 2nd character selected?
	jr   z, .setNum3B				; If not, jump
	ld   a, [wOrdSelP2CharSel2]
	and  a							; Is the 3rd character selected?
	jr   z, .setNum3C				; If not, jump
	ret ; We never get here
.setNum3A:
	; 1st slot is the 3rd team member
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId0]	
	ld   [wOrdSelP2CharId2], a					; Set team member
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP2CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase					; Write to tilemap
	ret
.setNum3B:
	; 2nd slot is the 3rd team member
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId1]
	ld   [wOrdSelP2CharId2], a
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP2CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase
	ret
.setNum3C:
	; 3rd slot is the 3rd team member
	ld   a, [wPlInfo_Pl2+iPlInfo_TeamCharId2]
	ld   [wOrdSelP2CharId2], a
	call OrdSel_GetTileOffsetToCharPic
	ld   hl, vBGOrdSelP2CharSel2
	ld   de, BG_CharSel_Portrait
	ld   b, $03
	ld   c, $03
	call CopyBGToRectWithBase
	ret
	
; =============== OrdSel_GetTileOffsetToCharPic ===============
; Gets the tile offset to the character's 9x9 portrait, relative to the first portrait at tile ID $2F.
; This value should be directly passed to CopyBGToRectWithBase.
; IN
; - A: Character ID
; OUT
; - A: Tile offset
OrdSel_GetTileOffsetToCharPic:
	and  a			; Picked KYO? (first character by id)
	ret  z			; If so, the offset is 0.
	
	; TileOffset = $09 * CharId / 2
	ld   b, a		; B = CharId
	xor  a			; A = 0
.loop:
	add  a, $09		; A += 9 (size of a portrait in tiles)
	dec  b			; B -= 2 (character IDs are multiplied by 2 for pointer tables, which we don't use here)
	dec  b
	jr   nz, .loop	; Are we done? If not, loop
	ret
	
; =============== OrdSel_Ctrl_MoveL ===============
; Moves the cursor to the left.
OrdSel_Ctrl_MoveL:
	; Depending on the player side...
	ld   a, [wOrdSelCurPl]
	or   a
	jp   nz, OrdSel_Ctrl_MoveL_P2
	; Fall-through
	
; =============== OrdSel_Ctrl_MoveL_P1 ===============
; Moves the player 1 cursor to the left, decreasing the cursor position.
OrdSel_Ctrl_MoveL_P1:
	; No movement when all characters are picked
	ld   a, [wOrdSelP1CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	; Decrement cursor position unless it's already at the leftmost one.
	ld   a, [wOrdSelP1CursorPos]
	and  a							; CursorPos == 0?
	ret  z							; If so, return
	dec  a							; Otherwise, CursorPos--
	ld   [wOrdSelP1CursorPos], a
	
	;
	; Make the cursor skip over any already selected characters.
	; If the leftmost boundary is reached, restore the old wOrdSelP1CursorPos value.
	;
	jr   nz, .chkMid				; On the middle position now? If so, jump
.chkLeft:
	; Otherwise, we're on the leftmost one.
	ld   a, [wOrdSelP1CharSel0]
	and  a							; Is the leftmost char already selected? (wOrdSelP1CharSel0 != 0)
	jr   z, .moveOk					; If not, jump
	; Otherwise, increment the cursor position back
	ld   a, [wOrdSelP1CursorPos]
	inc  a
	ld   [wOrdSelP1CursorPos], a
	ret
.chkMid:
	ld   a, [wOrdSelP1CharSel1]
	and  a							; Is the middle char already selected?	
	jr   z, .moveOk					; If not, jump
.moveSkipOk:
	; Move cursor again to the left, to skip the middle char
	ld   a, [wOrdSelP1CursorPos]
	dec  a
	ld   [wOrdSelP1CursorPos], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	sub  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
.moveOk:
	; Finally, move the cursor sprite to the left
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	sub  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
	ret
; =============== OrdSel_Ctrl_MoveL_P2 ===============
; Moves the player 2 cursor to the left, increasing the cursor position.
OrdSel_Ctrl_MoveL_P2:

	; No movement when all characters are picked
	ld   a, [wOrdSelP2CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	; Increment cursor position unless it's already at the leftmost one.
	ld   a, [wOrdSelP2CursorPos]
	cp   a, $02						; CursorPos == 2?
	ret  z							; If so, return
	inc  a							; Otherwise, CursorPos++
	ld   [wOrdSelP2CursorPos], a
	
	;
	; Make the cursor skip over any already selected characters.
	; If the leftmost boundary is reached, restore the old wOrdSelP2CursorPos value.
	;
	cp   a, $02						; On the middle position now (wOrdSelP2CursorPos != 2)? If so, jump
	jr   nz, .chkMid
.chkLeft:
	; Otherwise, we're on the leftmost one.
	ld   a, [wOrdSelP2CharSel2]
	and  a							; Is the leftmost char already selected? (wOrdSelP2CharSel2 != 0)
	jr   z, .moveOk					; If not, jump
	
	; Otherwise, decrement the cursor position back
	ld   a, [wOrdSelP2CursorPos]
	dec  a
	ld   [wOrdSelP2CursorPos], a
	ret  
	
.chkMid:
	ld   a, [wOrdSelP2CharSel1]
	and  a							; Is the middle char already selected?	
	jr   z, .moveOk					; If not, jump
.moveSkipOk:
	; Move cursor again to the left, to skip the middle char
	ld   a, [wOrdSelP2CursorPos]
	inc  a
	ld   [wOrdSelP2CursorPos], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	sub  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
.moveOk:
	; Finally, move the cursor sprite to the left
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	sub  a, TILE_H*2			; iOBJInfo_X -= $10
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
	ret  
	
; =============== OrdSel_Ctrl_MoveR ===============
; Moves the cursor to the right.
OrdSel_Ctrl_MoveR:
	; Depending on the player side...
	ld   a, [wOrdSelCurPl]
	or   a
	jp   nz, OrdSel_Ctrl_MoveR_P2

; =============== OrdSel_Ctrl_MoveR_P1 ===============
; Moves the player 1 cursor to the right, increasing the cursor position.	
OrdSel_Ctrl_MoveR_P1:
	; No movement when all characters are picked
	ld   a, [wOrdSelP1CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	; Increment cursor position unless it's already at the rightmost one.
	ld   a, [wOrdSelP1CursorPos]
	cp   $02						; CursorPos == 2?
	ret  z							; If so, return
	inc  a							; Otherwise, CursorPos++
	ld   [wOrdSelP1CursorPos], a
	
	;
	; Make the cursor skip over any already selected characters.
	; If the rightmost boundary is reached, restore the old wOrdSelP2CursorPos value.
	;
	cp   $02						; On the middle position now (wOrdSelP1CursorPos != 2)? If so, jump
	jr   nz, .chkMid
.chkRight:
	; Otherwise, we're on the rightmost one.
	ld   a, [wOrdSelP1CharSel2]
	and  a							; Is the rightmost char already selected? (wOrdSelP1CharSel2 != 0)
	jr   z, .moveOk					; If not, jump
	
	; Otherwise, decrement the cursor position back
	ld   a, [wOrdSelP1CursorPos]
	dec  a
	ld   [wOrdSelP1CursorPos], a
	ret
	
.chkMid:
	ld   a, [wOrdSelP1CharSel1]
	and  a							; Is the middle char already selected?	
	jr   z, .moveOk					; If not, jump
.moveSkipOk:
	; Move cursor again to the right, to skip the middle char
	ld   a, [wOrdSelP1CursorPos]
	inc  a
	ld   [wOrdSelP1CursorPos], a
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	add  a, TILE_H*2			; iOBJInfo_X += $10
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
.moveOk:
	; Finally, move the cursor sprite to the right
	ld   a, [wOBJInfo_Pl1+iOBJInfo_X]
	add  a, TILE_H*2			; iOBJInfo_X += $10
	ld   [wOBJInfo_Pl1+iOBJInfo_X], a
	ret
	
; =============== OrdSel_Ctrl_MoveR_P2 ===============
; Moves the player 2 cursor to the right, decreasing the cursor position.	
OrdSel_Ctrl_MoveR_P2:
	; No movement when all characters are picked
	ld   a, [wOrdSelP2CharsSelected]
	cp   ORDSEL_SELDONE
	ret  z
	
	; Decrement cursor position unless it's already at the rightmost one.
	ld   a, [wOrdSelP2CursorPos]
	and  a							; CursorPos == 0?
	ret  z							; If so, return
	dec  a							; Otherwise, CursorPos--
	ld   [wOrdSelP2CursorPos], a
	
	;
	; Make the cursor skip over any already selected characters.
	; If the rightmost boundary is reached, restore the old wOrdSelP2CursorPos value.
	;
	jr   nz, .chkMid				; On the middle position now? If so, jump
.chkRight:
	; Otherwise, we're on the rightmost one.
	ld   a, [wOrdSelP2CharSel0]
	and  a							; Is the rightmost char already selected? (wOrdSelP2CharSel0 != 0)
	jr   z, .moveOk					; If not, jump
	; Otherwise, increment the cursor position back
	ld   a, [wOrdSelP2CursorPos]
	inc  a
	ld   [wOrdSelP2CursorPos], a
	ret  
.chkMid:
	ld   a, [wOrdSelP2CharSel1]
	and  a							; Is the middle char already selected?	
	jr   z, .moveOk					; If not, jump
.moveSkipOk:
	; Move cursor again to the right, to skip the middle char
	ld   a, [wOrdSelP2CursorPos]
	dec  a
	ld   [wOrdSelP2CursorPos], a
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	add  a, TILE_H*2			; iOBJInfo_X += $10
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
.moveOk:
	; Finally, move the cursor sprite to the right
	ld   a, [wOBJInfo_Pl2+iOBJInfo_X]
	add  a, TILE_H*2			; iOBJInfo_X += $10
	ld   [wOBJInfo_Pl2+iOBJInfo_X], a
	ret

; 
; =============== END OF MODULE OrdSel ===============
;

; 
; =============== START OF MODULE Win/Cutscene ===============
;
GFXDef_Cutscene_Font_Nakoruru: mGfxDef "data/gfx/cutscene_font_nakoruru.bin"

PUSHC
SETCHARMAP nakoruru
Text_CutsceneNakoruru0:
	db "まちなさい!! "
	db "        "
Text_CutsceneNakoruru1:
	db "私はカムイコタンの戦士ナコルル!"
	db "                "
Text_CutsceneNakoruru2:
	db "大自然にかわって    "
	db "            "
	db "あなたをたおします!! "
	db "            "
Text_CutsceneNakoruru3:
	db "かくごしなさい!オロチいちぞく!! "
	db "                  "
Text_CutsceneNakoruruDefeat0:
	db "く・・・            "
	db "                "
	db "大自然のてきにまけるなんて・・・"
	db "                "
Text_CutsceneNakoruruDefeat1:
	db "ケーッ!"
	db "    "
Text_CutsceneNakoruruDefeat2:
	db "なに、ママハハ?"
	db "        "
Text_CutsceneNakoruruDefeat3:
	db "えっ?ちがうの!? "
	db "          "
Text_CutsceneNakoruruDefeat4:
	db "ダークパワーは         "
	db "                "
	db "この人が封じたですって・・・? "
	db "                "
Text_CutsceneNakoruruDefeat5:
	db "・・・。"
	db "    "
Text_CutsceneNakoruruDefeat6:
	db "(もう!)             "
	db "                  "
	db "(そういうことはさきにいってよ!) "
	db "                  "
Text_CutsceneNakoruruDefeat7:
	db "・・・ごめんなさい。"
	db "          "
Text_CutsceneNakoruruDefeat8:
	db "あなたが大自然のてきだとおもったの "
	db "                  "
	db "・・・それで・・・         "
	db "                  "
Text_CutsceneNakoruruDefeat9:
	db "!!!!! "
	db "      "
Text_CutsceneNakoruruDefeatA:
	db "この気は! "
	db "      "
Text_CutsceneNakoruruDefeatB:
	db "フフフフ、私はほろびん!  "
	db "              "
	db "ハッハッハッハッ・・・・・ "
	db "              "
POPC

; =============== SubModule_CutsceneNakoruru ===============
; This submodule handles the cutscene when Nakoruru appears after the credits in HARD mode.
SubModule_CutsceneNakoruru:

	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
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
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_Nakoruru
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	; Draw Nakoruru pic
	ld   a, CHAR_ID_NAKORURU
	call Cutscene_DrawOpponentPicScreen
	
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
	
	; Play what would have been Rugal's theme
	ld   a, BGM_NAKORURU
	call HomeCall_Sound_ReqPlayExId_Stub
	
IF VER_EN
	; Text 0
	ld   hl, TextDef_CutsceneNakoruruEn0
	ld   b, BANK(TextDef_CutsceneNakoruruEn0) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	
	; Text 1
	ld   hl, TextDef_CutsceneNakoruruEn1
	ld   b, BANK(TextDef_CutsceneNakoruruEn1) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	jp   Cutscene1E_ClearText ; End
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneNakoruru0
	ld   hl, $99C1
	ld   b, $08
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #1 - Text 1
	ld   de, Text_CutsceneNakoruru1
	ld   hl, $99C1
	ld   b, $10
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #2 - Text 2
	ld   de, Text_CutsceneNakoruru2
	ld   hl, $99C1
	ld   b, $0C
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #3 - Text 3
	ld   de, Text_CutsceneNakoruru3
	ld   hl, $99C1
	ld   b, $12
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	jp   Cutscene1E_ClearText ; End
	;--
ENDC
	
; =============== SubModule_CutsceneNakoruruDefeat ===============
; This submodule handles the cutscene when Nakoruru is defeated.
SubModule_CutsceneNakoruruDefeat:
	; =============== Cutscene_SharedInit ===============
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Clear DMG palettes
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reuse the SGB palette from the Intro
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
	
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
IF VER_EN
	ld   a, $00 ; Tile ID Offset
	ld   de, $9000
	call Cutscene_InitFont
ELSE
	ld   hl, GFXDef_Cutscene_Font_Nakoruru
	ld   de, $9000
	call CopyTilesAutoNum
ENDC
	
	
	; Draw Nakoruru pic
	ld   a, CHAR_ID_NAKORURU
	call Cutscene_DrawOpponentPicScreen
	
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
	
	; Start 2nd cutscene music
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	
IF VER_EN
	; Text 0
	ld   hl, TextDef_CutsceneNakoruruDefeatEn0
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn0) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	
	; Text 1
	ld   hl, TextDef_CutsceneNakoruruDefeatEn1
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn1) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
ELSE
	;--
	; #0 - Text 0
	ld   de, Text_CutsceneNakoruruDefeat0
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #1 - Text 1
	ld   de, Text_CutsceneNakoruruDefeat1
	ld   hl, $99C1
	ld   b, $04
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #2 - Text 2	
	ld   de, Text_CutsceneNakoruruDefeat2
	ld   hl, $99C1
	ld   b, $08
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
ENDC
	
	;--
	; #3 - Start 1st cutscene music
	ld   a, BGM_CUTSCENE1
	call HomeCall_Sound_ReqPlayExId_Stub
	;--
	
IF VER_EN
	; Text 2
	ld   hl, TextDef_CutsceneNakoruruDefeatEn2
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn2) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	
	; Text 3
	ld   hl, TextDef_CutsceneNakoruruDefeatEn3
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn3) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	
	; Text 4
	ld   hl, TextDef_CutsceneNakoruruDefeatEn4
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn4) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	
	; Text 5
	ld   hl, TextDef_CutsceneNakoruruDefeatEn5
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn5) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
ELSE
	;--
	; #4 - Text 3	
	ld   de, Text_CutsceneNakoruruDefeat3
	ld   hl, $99C1
	ld   b, $0A
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #5 - Text 4	
	ld   de, Text_CutsceneNakoruruDefeat4
	ld   hl, $99C1
	ld   b, $10
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #6 - Text 5	
	ld   de, Text_CutsceneNakoruruDefeat5
	ld   hl, $99C1
	ld   b, $04
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #7 - Text 6	
	ld   de, Text_CutsceneNakoruruDefeat6
	ld   hl, $99C1
	ld   b, $12
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #8 - Text 7	
	ld   de, Text_CutsceneNakoruruDefeat7
	ld   hl, $99C1
	ld   b, $0A
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #9 - Text 8	
	ld   de, Text_CutsceneNakoruruDefeat8
	ld   hl, $99C1
	ld   b, $12
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #A - Text 9	
	ld   de, Text_CutsceneNakoruruDefeat9
	ld   hl, $99C1
	ld   b, $06
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
	
	;--
	; #B - Text A	
	ld   de, Text_CutsceneNakoruruDefeatA
	ld   hl, $99C1
	ld   b, $06
	ld   c, $02
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	call Cutscene1E_ClearText
	;--
ENDC
	
	;--
	; #C - Draw Omega Rugal pic
	call ClearBGMap
	;-----------------------------------
	rst  $10				; Stop LCD
	ld   a, CHAR_ID_RUGAL
	call Cutscene_DrawOpponentPicScreen
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ld   a, BGM_CUTSCENE0
	call HomeCall_Sound_ReqPlayExId_Stub
	;--
	
IF VER_EN
	; Text 6
	ld   hl, TextDef_CutsceneNakoruruDefeatEn6
	ld   b, BANK(TextDef_CutsceneNakoruruDefeatEn6) ; BANK $15
	ld   c, $04
	call TextPrinter_MultiFrameFar_AllowFast
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	jp   Cutscene1E_ClearText ; End
ELSE
	;--
	; #D - Text B	
	ld   de, Text_CutsceneNakoruruDefeatB
	ld   hl, $99C1
	ld   b, $0E
	ld   c, $04
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
	call Task_PassControl_NoDelay
	ld   b, $B4
	call Cutscene1E_PostTextWrite
	jp   Cutscene1E_ClearText ; End
	;--
ENDC
	
; =============== Cutscene1E_ClearText ===============
; Blank out any existing text.
Cutscene1E_ClearText:
	; Clear all 4 rows (7 in the English version)
IF VER_EN
	ld   hl, BGMap_Begin+$0180 ; BG Ptr (En)
ELSE
	ld   hl, BGMap_Begin+$01C0 ; BG Ptr (Jp)
ENDC
	ld   b, $18	; Rect Width
IF VER_EN
	ld   c, $07 ; Rect Height (En)
ELSE
	ld   c, $04 ; Rect Height (Jp)
ENDC
	ld   d, $00 ; Tile ID
	jp   FillBGRect
	
; =============== Cutscene1E_PostTextWrite ===============
; Shared code executed after text finishes writing for a cutscene.
; This delays the cutscene from continuing, until the timer elapses or START is pressed.
; IN
; - B: Max number of frames to wait
; OUT
; - C flag: If set, it was aborted early
Cutscene1E_PostTextWrite:
	; Check early abort
	call Cutscene1E_IsStartPressed	; Did anyone press START?
IF VER_EN
	jr   nc, .contWait				; If not, jump
	call Task_PassControl_NoDelay	; Otherwise wait a frame, then return
	ret
ELSE
	ret  c							; If so, return
ENDC
.contWait:
	call Task_PassControl_NoDelay	; Wait frame
	dec  b							; Are we done?
	jp   nz, Cutscene1E_PostTextWrite	; If not, loop
.end:
	xor  a	; C flag clear
	ret

; =============== Cutscene1E_IsStartPressed ===============
; Checks if any player pressed START.
; Identical to Win_IsStartPressed.
; OUT
; - C flag: If set, someone did
Cutscene1E_IsStartPressed:
	; If any player presses START, return set
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a
	jp   nz, .abort
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a
	jp   nz, .abort
	; Otherwise, return clear
	xor  a
	ret
.abort:
	scf
	ret
; 
; =============== END OF MODULE Win/Cutscene ===============
;
	
; =============== MoveC_Eiji_ThrowG ===============
; Move code for Eiji's Ground Throw (MOVE_SHARED_THROW_G).
; This is more similar to an air throw.
MoveC_Eiji_ThrowG:
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .doGravity
		mMvC_ChkFrame $04, .chkEnd
	jp   .anim ; We never get here
; --------------- frame #0 ---------------
.obj0:
	; Grab opponent
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $06
		mMvC_SetDamageNext $06, HITTYPE_GRAB_UB_SYNC, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	; Start high jump
	mMvC_ValFrameStartFast .obj1_cont
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		mMvC_SetSpeedH +$0100
		mMvC_SetSpeedV -$0600
.obj1_cont:
	; Throw diagonally down
	mMvC_ValFrameEnd .doGravity
		mMvC_SetAnimSpeed $04
		mMvC_SetDamageNext $06, HITTYPE_LAUNCH_FAST_DB, $00
		jp   .doGravity
; --------------- frame #2 ---------------
.obj2:
	; Freeze in the air for a bit, then jump back
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		mMvC_SetSpeedH -$0040 ; at a very slow horz speed
		mMvC_SetSpeedV +$0100
		jp   .anim
; --------------- common gravity check / frames #1-3 ---------------
.doGravity:
	; When touching the ground, switch to #4
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $04, $05
		jp   .ret
; --------------- frame #4 ---------------
; Recovery.
.chkEnd:
	mMvC_ValFrameEnd .anim
		mMvC_EndThrow
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_KickHN ===============
; Move code for Eiji's Near Heavy Kick. (MOVE_SHARED_KICK_HN)
; Identical to MoveC_Athena_KickHN other than for adjusted timing.
MoveC_Eiji_KickHN:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $02, .obj0
		mMvC_ChkFrame $05, .chkEnd
; --------------- frames #0-1,3-4 ---------------
	jp   .anim
; --------------- frame #2 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetDamageNext $06, HITTYPE_HIT_MID0, PF3_HEAVYHIT
		jp   .anim
; --------------- frame #5 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveC_Eiji_KickHM ===============
; Move code for Eiji's Far Heavy Kick (MOVE_SHARED_KICK_HM).	
MoveC_Eiji_KickHM:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj0
		mMvC_ChkFrame $02, .obj2
	jp   .anim ; We never get here
; --------------- frames #0-1 ---------------
.obj0:
	mMvC_ValFrameStartFast .obj0_cont
		mMvC_SetMoveH +$0400
.obj0_cont:
	jp   .anim
; --------------- frame #2 ---------------
.obj2:
	mMvC_ValFrameStartFast .chkEnd
		mMvC_SetMoveH +$0400
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jr   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret  
	
; =============== MoveInputReader_Eiji ===============
; Special move input checker for EIJI.
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
; OUT
; - C flag: If set, a move was started
MoveInputReader_Eiji:
	mMvIn_Validate Eiji, 2
	
.chkGround:
	;             SELECT + B                       SELECT + A
	mMvIn_ChkEasy MoveInit_Eiji_ZantetsuTourouken, MoveInit_Eiji_KageUtsushi
	mMvIn_ChkGA Eiji, .chkPunch, .chkKick, CHKGA_KICK|CHKGA_PUNCH
	
.chkPunch:
	; DFDB+P -> Zantetsuha
	mMvIn_ChkDir MoveInput_DFDB, MoveInit_Eiji_Zantetsuha
	; BDF+P -> Ryuu Eijin
	mMvIn_ChkDir MoveInput_BDF, MoveInit_Eiji_RyuuEijin
	; DB+P -> Kasumi Geri
	mMvIn_ChkDir MoveInput_DB, MoveInit_Eiji_KasumiGeri
	; DF+P -> Kikouhou
	mMvIn_ChkDir MoveInput_DF, MoveInit_Eiji_Kikouhou
	; End
	jp   MoveInputReader_Eiji_NoMove
.chkKick:
	mMvIn_ValSuper .chkKickNoSuper
	; BDFB+K -> Zantetsu Tourouken
	mMvIn_ChkDir MoveInput_BDFB, MoveInit_Eiji_ZantetsuTourouken
.chkKickNoSuper:
	; FDB+K -> Kotsu Hazaki Kiri
	mMvIn_ChkDir MoveInput_FDB, MoveInit_Eiji_KotsuHazakiKiri
	; DF+K -> Tenbakyaku
	mMvIn_ChkDir MoveInput_DF, MoveInit_Eiji_Tenbakyaku
	; DB+K -> Kage Utsushi
	mMvIn_ChkDir MoveInput_DB, MoveInit_Eiji_KageUtsushi
	; End
	jp   MoveInputReader_Eiji_NoMove
	
; =============== MoveInit_Eiji_Kikouhou ===============
MoveInit_Eiji_Kikouhou:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_EIJI_KIKOUHOU_L, MOVE_EIJI_KIKOUHOU_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_KotsuHazakiKiri ===============
MoveInit_Eiji_KotsuHazakiKiri:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_EIJI_KOTSU_HAZAKI_KIRI_L, MOVE_EIJI_KOTSU_HAZAKI_KIRI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_RyuuEijin ===============
MoveInit_Eiji_RyuuEijin:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_EIJI_RYUU_EIJIN_L, MOVE_EIJI_RYUU_EIJIN_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREFLECT, [hl]
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_KasumiGeri ===============
MoveInit_Eiji_KasumiGeri:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_EIJI_KASUMI_GERI_L, MOVE_EIJI_KASUMI_GERI_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags0
	add  hl, bc
	set  PF0B_PROJREM, [hl]
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_Zantetsuha ===============
MoveInit_Eiji_Zantetsuha:
	mMvIn_ValProjActive MoveInputReader_Eiji_NoMove
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHP MOVE_EIJI_ZANTETSUHA_L, MOVE_EIJI_ZANTETSUHA_H
	call MoveInputS_SetSpecMove_StopSpeed
	call Play_Proj_CopyMoveDamageFromPl
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_KageUtsushi ===============
MoveInit_Eiji_KageUtsushi:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_EIJI_KAGE_UTSUSHI_L, MOVE_EIJI_KAGE_UTSUSHI_H
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_Tenbakyaku ===============
MoveInit_Eiji_Tenbakyaku:
	call Play_Pl_ClearJoyDirBuffer
	mMvIn_GetLHK MOVE_EIJI_TENBAKYAKU_L, MOVE_EIJI_TENBAKYAKU_H
	call MoveInputS_SetSpecMove_StopSpeed
	ld   hl, iPlInfo_Flags2
	add  hl, bc
	set  PF2B_NOCOLIBOX, [hl]
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInit_Eiji_ZantetsuTourouken ===============
MoveInit_Eiji_ZantetsuTourouken:
	call Play_Pl_ClearJoyDirBuffer
	ld   a, MOVE_EIJI_ZANTETSU_TOUROUKEN_S
	call MoveInputS_SetSpecMove_StopSpeed
	jp   MoveInputReader_Eiji_MoveSet
	
; =============== MoveInputReader_Eiji_MoveSet ===============
MoveInputReader_Eiji_MoveSet:
	scf  
	ret  
; =============== MoveInputReader_Eiji_NoMove ===============
MoveInputReader_Eiji_NoMove:
	or   a
	ret
; =============== MoveC_Eiji_Kikouhou ===============
; Move code for Eiji's:
; - Kikouhou (MOVE_EIJI_KIKOUHOU_L, MOVE_EIJI_KIKOUHOU_H)
; - Kasumi Geri (MOVE_EIJI_KASUMI_GERI_L, MOVE_EIJI_KASUMI_GERI_H)
MoveC_Eiji_Kikouhou:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
	mMvC_ChkFrame $01, .obj1
	mMvC_ChkFrame $03, .chkEnd
; --------------- frames #0,2 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .anim
	
		; Depending on the move...
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_EIJI_KASUMI_GERI_H
		jp   z, .obj1_kasH
		cp   MOVE_EIJI_KASUMI_GERI_L
		jp   z, .obj1_kasL
		jp   .obj1_kik
	.obj1_kasH:
		; Heavy Kasumi Geri -> Move 8px forward
		mMvC_SetMoveH $0800
		jp   .obj1_kasL
	.obj1_kik:
		; Kikouhou -> Play an unique SFX
		mMvC_PlaySound SCT_KIKOUHOU
		jp   .anim
	.obj1_kasL:
		; Light Kasumi Geri -> Play a different unique SFX
		mMvC_PlaySound SCT_MULTIHIT
		jp   .anim
; --------------- frame #3 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_RyuuEijin ===============
; Move code for Eiji's Ryuu Eijin (MOVE_EIJI_RYUU_EIJIN_L, MOVE_EIJI_RYUU_EIJIN_H).
MoveC_Eiji_RyuuEijin:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $06, .chkEnd
; --------------- frames #0,1-5 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .anim
		mMvC_PlaySound SCT_PROJ_LG_B
		jp   .anim
; --------------- frame #6 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_Zantetsuha ===============
; Move code for Eiji's Zantetsuha (MOVE_EIJI_ZANTETSUHA_L, MOVE_EIJI_ZANTETSUHA_H).
MoveC_Eiji_Zantetsuha:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
; --------------- frame #0 ---------------
	jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameEnd .anim
		;
		; The heavy version keeps Eiji in the "throw" frame for longer.
		;
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]					; A = Move ID
		ld   hl, iOBJInfo_FrameTotal
		add  hl, de						; Seek to anim speed
		cp   MOVE_EIJI_ZANTETSUHA_H		; Doing the heavy version?
		jp   z, .heavy					; If so, jump
	.light:
		ld   [hl], $0A					; iOBJInfo_FrameTotal = $0A
		jp   .anim
	.heavy:
		ld   [hl], $14					; iOBJInfo_FrameTotal = $14
		jp   .anim
; --------------- frame #2 ---------------
.obj2:
	; Spawn the projectile at the start
	mMvC_ValFrameStartFast .chkEnd
		call ProjInit_Eiji_Zantetsuha
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	jp   OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_KotsuHazakiKiri ===============
; Move code for Eiji's:
; - Kotsu Hazaki Kiri (MOVE_EIJI_KOTSU_HAZAKI_KIRI_L, MOVE_EIJI_KOTSU_HAZAKI_KIRI_H)
; - Tenbakyaku (MOVE_EIJI_TENBAKYAKU_L, MOVE_EIJI_TENBAKYAKU_H)
; Fast dash moves, the former dealing damage.
MoveC_Eiji_KotsuHazakiKiri:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .obj4
		mMvC_ChkFrame $05, .chkEnd
; --------------- frame #0 ---------------
.obj0:
	mMvC_ValFrameEnd .anim
		; 8 frames to reach opponent
		mMvC_SetAnimSpeed $08
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		
		; Set dash speed depending on the move strength
		ld   hl, iPlInfo_MoveId
		add  hl, bc
		ld   a, [hl]
		cp   MOVE_EIJI_KOTSU_HAZAKI_KIRI_H
		jp   z, .obj1_setDashH
		cp   MOVE_EIJI_TENBAKYAKU_H
		jp   z, .obj1_setDashH
	.obj1_setDashL: ; Light
		mMvC_SetSpeedH +$0500
		jp   .obj1_cont
	.obj1_setDashH: ; Heavy
		mMvC_ChkMaxPow .obj1_setDashE
		mMvC_SetSpeedH +$0600
		jp   .obj1_cont
	.obj1_setDashE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700		
.obj1_cont:

	;
	; Both Kotsu Hazaki Kiri and Tenbakyaku have the player move forward at a constant speed.
	;
	; Kotsu Hazaki Kiri deals damage, so it has a few extra frames for the damage animation
	; which are skipped by Tenbakyaku.
	;

	; Move at that fixed speed
	call OBJLstS_ApplyXSpeed
	; If the frame ends, skip to #5
	mMvC_ValFrameEnd .chkNear
		mMvC_SetFrame $05, $04
		jp   .ret
		
.chkNear:

	; If the player is doing Kotsu Hazaki Kiri and is within $38px from the opponent, continue to #2
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_EIJI_TENBAKYAKU_L		; Doing the light one?
	jp   z, .anim					; If so, skip
	cp   MOVE_EIJI_TENBAKYAKU_H		; Doing the heavy one?
	jp   z, .anim					; If so, skip
	mMvIn_ValClose .anim, $38		; Distance check
		mMvC_SetFrame $02, $00
		jp   .ret
; --------------- frame #2 ---------------
; Post-hit animation.
.obj2:
	mMvC_DoFrictionH $0080
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $03
		jp   .anim
; --------------- frame #3 ---------------
; Post-hit animation.
.obj3:
	mMvC_DoFrictionH $0080
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $01
		jp   .anim
; --------------- frame #4 ---------------
; Post-hit animation.
.obj4:
	mMvC_DoFrictionH $0080
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $02
		jp   .anim
; --------------- frame #5 ---------------
; Recovery.
.chkEnd:
	mMvC_DoFrictionH $0100
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_KageUtsushi ===============
; Move code for Eiji's Kage Utsushi (MOVE_EIJI_KAGE_UTSUSHI_L, MOVE_EIJI_KAGE_UTSUSHI_H).
MoveC_Eiji_KageUtsushi:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .obj2
		mMvC_ChkFrame $03, .obj3
		mMvC_ChkFrame $04, .chkEnd
	jp   .doGravity ; We never get here
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		; Set manual ctrl for near check
		mMvC_SetAnimSpeed ANIMSPEED_NONE
		jp   .anim
; --------------- frame #1 ---------------
.obj1:
	mMvC_ValFrameStartFast .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		;--
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		set  PF0B_AIR, [hl]
		;--
		; Set jumpkick settings
		mMvC_ChkMove MOVE_EIJI_KAGE_UTSUSHI_H, .obj1_setJumpH
	.obj1_setJumpL: ; Light
		mMvC_SetSpeedH +$0200
		mMvC_SetSpeedV -$0400
		jp   .doGravity
	.obj1_setJumpH: ; Heavy
		mMvC_ChkMaxPow .obj1_setJumpE
		mMvC_SetSpeedH +$0400
		mMvC_SetSpeedV -$0500
		jp   .doGravity
	.obj1_setJumpE: ; Max Power Heavy
		mMvC_SetSpeedH +$0700
		mMvC_SetSpeedV -$0500
		jp   .doGravity
.obj1_cont:
	; Switch to #2 only when close to the opponent
	mMvIn_ValClose .doGravity
		mMvC_SetFrame $02, $00
		jp   .ret
; --------------- frame #2 ---------------
; Kick loop
.obj2:
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $05, HITTYPE_HIT_MID0, PF3_CONTHIT
		jp   .doGravity
; --------------- frame #3 ---------------
; Kick loop
.obj3:
	; If we didn't touch the ground by the end of #3, loop to #2
	mMvC_ValFrameEnd .doGravity
		mMvC_SetDamageNext $05, HITTYPE_HIT_MID1, PF3_CONTHIT
		mMvC_SetFrameOnEnd $02
		jp   .doGravity
; --------------- common gravity check / frames #1-3 ---------------
.doGravity:
	; Switch to #4 when touching the ground
	mMvC_ChkGravityHV $0060, .anim
		;--
		; Allow special cancel
		ld   hl, iPlInfo_Flags0
		add  hl, bc
		res  PF0B_AIR, [hl]
		inc  hl
		res  PF1B_NOSPECSTART, [hl]
		;--
		mMvC_SetLandFrame $04, $05
		jp   .ret
; --------------- frame #4 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret
	
; =============== MoveC_Eiji_ZantetsuTourouken ===============
; Move code for Eiji's Zantetsu Tourouken (MOVE_EIJI_ZANTETSU_TOUROUKEN_S).
; See also: MoveC_Iori_KinYaOtome
MoveC_Eiji_ZantetsuTourouken:
	call Play_Pl_MoveByColiBoxOverlapX
	mMvC_ValLoaded .ret
	
	; Depending on the visible frame...
	mMvC_StartChkFrame
		mMvC_ChkFrame $00, .obj0
		mMvC_ChkFrame $01, .obj1
		mMvC_ChkFrame $02, .setDamage0
		mMvC_ChkFrame $03, .setDamage1
		mMvC_ChkFrame $05, .setDamage1
		mMvC_ChkFrame $07, .setDamage1
		mMvC_ChkFrame $09, .setDamage1
		mMvC_ChkFrame $0B, .setDamage1
		mMvC_ChkFrame $0D, .setDamage1
		mMvC_ChkFrame $0F, .setDamage1
		mMvC_ChkFrame $11, .setDamage1
		mMvC_ChkFrame $12, .setDamage1_chkOtherBlock
		mMvC_ChkFrame $13, .anim
		mMvC_ChkFrame $14, .chkEnd
		mMvC_ChkFrame $15, .setDamageFinisher
	jp   .setDamage0_chkOtherBlock
; --------------- frame #0 ---------------
; Startup.
.obj0:
	mMvC_ValFrameEnd .anim
		mMvC_SetAnimSpeed $09
		jp   .anim
; --------------- frame #1 ---------------
; Run towards the opponent.
; We have $12 frames to hit the opponent, otherwise the move ends.
.obj1:
	mMvC_ValFrameStart .obj1_cont
		mMvC_PlaySound SCT_MOVEJUMP_A
		; Move forward near 8px/frame at the start
		mMvC_SetSpeedH +$07FF
.obj1_cont:
	; Move forwards. If the frame ends, switch to #15
	call OBJLstS_ApplyXSpeed
	mMvC_ValFrameEnd .obj1_chkGuard
		mMvC_SetFrame $15, $08
		jp   .ret
.obj1_chkGuard:
	;
	; Continue moving forwards until we collided (last frame) with the opponent.
	;
	ld   hl, iPlInfo_ColiFlags
	add  hl, bc
	bit  PCFB_HITOTHER, [hl]			; Did we reach?
	jp   z, .obj1_chkGuard_noHit		; If not, skip
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]				; Is the opponent invulnerable?
	jp   nz, .obj1_chkGuard_noHit		; If so, skip
	bit  PF1B_HITRECV, [hl]				; Did the opponent get hit?
	jp   z, .obj1_chkGuard_noHit		; If not, skip	
	
	bit  PF1B_GUARD, [hl]				; Is the opponent blocking?
	jp   nz, .obj1_chkGuard_slowdown	; If so, the slowdown significantly
	
	.obj1_chkGuard_noGuard:
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		mMvC_SetFrame $02, $00
		mMvC_SetSpeedH $0000
		jp   .ret
.obj1_chkGuard_slowdown:
	mMvC_SetSpeedH +$0100
.obj1_chkGuard_noHit:
	jp   .anim
	
; --------------- odd frames #3,5,7,9,B,D,F - line damage + block check ---------------
.setDamage1:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI1, PF3_CONTHIT
		jp   .chkOtherEscape
; --------------- frame #2 ---------------
.setDamage0:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		jp   .anim
; --------------- even frames - line damage ---------------
.setDamage0_chkOtherBlock:
	mMvC_ValFrameStart .anim
		mMvC_SetDamageNext $01, HITTYPE_HIT_MULTI0, PF3_CONTHIT
		jp   .chkOtherEscape
; --------------- frame #12 - line damage + block check ---------------		
.setDamage1_chkOtherBlock:
	mMvC_ValFrameStart .anim
	IF VER_EN
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT
	ELSE
		mMvC_SetDamageNext $10, HITTYPE_LAUNCH_HIGH_UB, PF3_HEAVYHIT|PF3_CONTHIT
	ENDC
		jp   .anim
; --------------- common escape check ---------------
; Done at the start of about half of the frames.
	.chkOtherEscape:
		;
		; [POI] If the opponent somehow isn't in one of the hit effects 
		;       this move sets, hop back instead of continuing.
		;       This can happen if the opponent gets hit by a previously thrown
		;       fireball in the middle of the move.
		;
		ld   hl, iPlInfo_HitTypeIdOther
		add  hl, bc
		ld   a, [hl]
		cp   HITTYPE_HIT_MULTI0	; A == HITTYPE_HIT_MULTI0?
		jp   z, .anim			; If so, skip
		cp   HITTYPE_HIT_MULTI1	; A == HITTYPE_HIT_MULTI1?
		jp   z, .anim			; If so, skip
			ld   a, MOVE_SHARED_HOP_B
			call Pl_SetMove_StopSpeed
			jp   .ret
; --------------- frame #15 ---------------
; Deals the big boy damage.
.setDamageFinisher:
	mMvC_DoFrictionH +$0080
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- frame #14 ---------------
.chkEnd:
	mMvC_ValFrameEnd .anim
		call Play_Pl_EndMove
		jp   .ret
; --------------- common ---------------
.anim:
	call OBJLstS_DoAnimTiming_Loop_by_DE
.ret:
	ret

; =============== ProjInit_Eiji_Zantetsuha ===============
; Initialized the projectile for Eiji's Zantetsuha (MOVE_EIJI_ZANTETSUHA_L, MOVE_EIJI_ZANTETSUHA_H).
ProjInit_Eiji_Zantetsuha:
	mMvC_PlaySound SCT_PROJ_LG_B

	push bc
		push de

			; --------------- common projectile init code ---------------

			;
			; C flag = If set, we're at max power
			;
			ld   hl, iPlInfo_Pow
			add  hl, bc
			ld   a, [hl]		; A = Pow meter
			cp   PLAY_POW_MAX	; Are we at max power?
			jp   z, .initMaxPow	; If so, jump
			xor  a				; C flag clear
			jp   .getFlags2
		.initMaxPow:
			scf					; C flag set
		.getFlags2:
		
			;
			; A = Move ID
			;
			ld   hl, iPlInfo_MoveId
			push af				; Preserve C flag for this
				add  hl, bc		; Seek to iPlInfo_MoveId
			pop  af
			ld   a, [hl]		; Read out to A
			push af ; Save A & C flag
			
				; =============== ProjInitS_InitAndGetOBJInfo ===============
				; Gets the projectile's wOBJInfo for the current player and initializes its common properties.
				;
				; Extracted to ProjInitS_InitAndGetOBJInfo in 96.
				;
				; IN
				; - BC: Ptr to wPlInfo
				; - DE: Ptr to respective wOBJInfo
				; OUT
				; - DE: Ptr to projectile wOBJInfo (wOBJInfo_Pl*Projectile)
				; WIPES
				; - BC
				
				;
				; A = Player marker (for the tile ID check)
				;
				ld   hl, iPlInfo_PlId
				add  hl, bc
				ld   a, [hl]

				;
				; Seek to the wOBJInfo for the current player's projectile.
				; This will either be a Ptr to wOBJInfo_Pl1Projectile or a Ptr to wOBJInfo_Pl2Projectile.
				; Save its ptr to DE and HL.
				;
				push af ; Pointless push/pop
					push de			; BC = Ptr to player wOBJInfo
					pop  bc
					ld   hl, (OBJINFO_SIZE*2)+iOBJInfo_Status
					add  hl, bc		; Seek to 2 slots after
					push hl
					pop  de			; Copy it to DE

					;
					; Show the projectile
					;
					ld   [hl], OST_VISIBLE
				pop  af
				
				;
				; Set the tile ID base for the projectile depending on the player we're playing as.
				; The values must be consistent with that's written in Play_LoadProjectileOBJInfo
				;
				or   a				; iPlInfo_PlId != PL1?
				jp   nz, .tileId2P	; If so, jump
			.tileId1P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $80	; Graphics from $8800
				jp   .tileIdRet
			.tileId2P:
				ld   hl, iOBJInfo_TileIDBase
				add  hl, de		; Seek to iOBJInfo_TileIDBase
				ld   [hl], $A4	; Graphics from $8A40
			.tileIdRet:
				; ==============================
			

				; --------------- main ---------------

				; Set code pointer
				ld   hl, iOBJInfo_Play_CodeBank
				add  hl, de
				ld   [hl], BANK(ProjC_Horz)	; BANK $03 ; iOBJInfo_Play_CodeBank
				inc  hl
				ld   [hl], LOW(ProjC_Horz)	; iOBJInfo_Play_CodePtr_Low
				inc  hl
				ld   [hl], HIGH(ProjC_Horz)	; iOBJInfo_Play_CodePtr_High

				; Write sprite mapping ptr for this projectile.
				ld   hl, iOBJInfo_BankNum
				add  hl, de
				ld   [hl], BANK(OBJLstPtrTable_Proj_Eiji_Zantetsuha)	; BANK $01 ; iOBJInfo_BankNum
				inc  hl
				ld   [hl], LOW(OBJLstPtrTable_Proj_Eiji_Zantetsuha)	; iOBJInfo_OBJLstPtrTbl_Low
				inc  hl
				ld   [hl], HIGH(OBJLstPtrTable_Proj_Eiji_Zantetsuha)	; iOBJInfo_OBJLstPtrTbl_High
				inc  hl
				ld   [hl], $00	; iOBJInfo_OBJLstPtrTblOffset


				; Set animation speed.
				ld   hl, iOBJInfo_FrameLeft
				add  hl, de
				ld   [hl], $00	; iOBJInfo_FrameLeft
				inc  hl
				ld   [hl], ANIMSPEED_INSTANT	; iOBJInfo_FrameTotal

				; Set priority value
				ld   hl, iOBJInfo_Play_Priority
				add  hl, de
				ld   [hl], $01

				; Set initial position relative to the player's origin
		
				; =============== OBJLstS_Overlap ===============
				; Moves an wBJInfo to exactly overlap another one.
				; This copies the coordinates and OBJLstFlags from the source (BC) to destination (DE).
				;
				; Extracted to OBJLstS_Overlap in 96.
				;
				; IN
				; - DE: Ptr to the wOBJInfo structure to be moved
				; - BC: Ptr to target wOBJInfo structure (the "other" one)
				push bc
					;
					; Set up source and destination pointers
					;

					; BC = Ptr to source iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, bc			; HL = BC + iOBJInfo_X
					push hl
					pop  bc				; Move back to BC

					; DE = Ptr to destination iOBJInfo_X
					ld   hl, iOBJInfo_X
					add  hl, de			; HL = DE + iOBJInfo_X

					;
					; Copy the next 4 bytes over (iOBJInfo_X-iOBJInfo_YSub)
					;
			REPT 4
					ld   a, [bc]	; A = Source byte
					inc  bc			; SrcPtr++
					ldi  [hl], a	; Write to dest; DestPtr++
			ENDR
				pop  bc

				;
				; Copy over the byte with sprite mapping flags
				;

				; A = Source iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, bc
				ld   a, [hl]
				; HL = Ptr to dest iOBJInfo_OBJLstFlags
				ld   hl, iOBJInfo_OBJLstFlags
				add  hl, de
				; Write it over
				ld   [hl], a
				; ==============================
				mMvC_SetMoveH +$1000
				mMvC_SetMoveV -$0800
			pop  af	; Restore A & C flag

			;
			; Determine projectile horizontal speed.
			;

			jp   nc, .fldMaxPow				; Are we at max power? If not, jump
			cp   MOVE_EIJI_ZANTETSUHA_H		; Was this an heavy attack?
			jp   z, .fldHeavy				; If so, jump
			jp   .fldLight
		.fldMaxPow:
			cp   MOVE_EIJI_ZANTETSUHA_H		; Was this an heavy attack?
			jp   z, .fldHeavyMaxPow			; If so, jump
		.fldLight:
			ld   hl, +$0100
			jp   .setSpeed
		.fldHeavyMaxPow:
			ld   hl, +$0200
			jp   .setSpeed
		.fldHeavy:
			ld   hl, +$0400
		.setSpeed:
			call Play_OBJLstS_SetSpeedH_ByXFlipR

		pop  de
	pop  bc
	ret
	
; =============== Title_DisableSerial ===============
Title_DisableSerial:
	xor  a
	ldh  [rSB], a
	ld   [wSerialDataReceiveBuffer], a
	ld   [wSerialPlayerId], a
	ld   [wSerialTransferDone], a
	ld   [wSerialDataSendBuffer], a
	ret  
	
; =============== ModeSelect_SetSerialIdle ===============
; Marks that the GB is ready to listen to the other player.
ModeSelect_SetSerialIdle:
	; Prepare default the serial settings with what we're replying to 
	; if the other GB sends something through serial.
	ld   a, MODESELECT_SBCMD_IDLE			; Set idle flag
	ldh  [rSB], a							; It will be checked by the other GB in ModeSelect_TrySendVSData
	ld   a, START_TRANSFER_EXTERNAL_CLOCK	; Autoreply MODESELECT_SBCMD_IDLE when the other GB sends something
	ldh  [rSC], a
	ret
	
; =============== ModeSelect_Serial_SendAndWait ===============
; Sends a byte through the serial cable, and waits a reply from the other GB.
; This marks us as master, overwriting what was set in ModeSelect_SetSerialIdle.
; IN
; - A: Byte to send (MODESELECT_SBCMD_*)
ModeSelect_Serial_SendAndWait:
	ldh  [rSB], a
	ld   a, START_TRANSFER_INTERNAL_CLOCK	; Start master transfer
	ldh  [rSC], a
	
	
; =============== ModeSelect_Serial_Wait ===============
; Waits for a byte to be fully received.
ModeSelect_Serial_Wait:
	ld   a, [wSerialTransferDone]
	and  a							; Are we done?
	jr   z, ModeSelect_Serial_Wait	; If not, wait
	xor  a							; Reset marker before exit
	ld   [wSerialTransferDone], a
	ret
	
; =============== ModeSelect_TrySendVSData ===============
; Attempts to send the additional data to sync up both players.
; OUT
; - A: Value received from the slave
ModeSelect_TrySendVSData:
	; [Master 1/3 Recv] If the slave didn't isn't ready (see: not at the Mode Select menu), return
	ld   a, [wSerialDataReceiveBuffer]
	cp   MODESELECT_SBCMD_IDLE			; RecByte == MODESELECT_SBCMD_IDLE?
	jr   z, .send						; If so, jump
	ret
.send: 
	; Save the received byte for later in wSerialPlayerId.
	; This also has the effect of always writing SERIAL_PL1_ID, marking the current
	; player as being 1P / using hJoyKeys for the serial input handler.
	;
	; This works because only the master can ever write MODESELECT_SBCMD_IDLE here (which has the same value as SERIAL_PL1_ID),
	; while the slave can only write in ModeSelect_GetCtrlFromSerial the command IDs we send
	; (MODESELECT_SBCMD_TEAMVS or MODESELECT_SBCMD_SINGLEVS).
	ld   [wSerialPlayerId], a 		; Save received byte
	
	; Set ourselves as master
	ld   hl, wMisc_C025
	set  MISCB_SERIAL_MODE, [hl]
	res  MISCB_SERIAL_SLAVE, [hl]
	
	; Wait for a bit.
	; This also disables wSerialTransferDone on VBlank.
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	
	; [Master 2/3] Send out the timer setting and wait some more
	ld   a, [wMatchStartTime]
	call ModeSelect_Serial_SendAndWait
	; Wait for a bit and reset wSerialTransferDone
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	call Task_PassControl_NoDelay
	
	; [Master 3/3] Send out the dip settings (unlocked chars, etc...)
	ld   a, [wDipSwitch]
	call ModeSelect_Serial_SendAndWait
	
	ld   a, [wSerialPlayerId]		; Restore received byte
	ret  
	
; =============== ModeSelect_GetCtrlFromSerial ===============
; Listens to the serial port to check if the other player selected a VS mode.
; If so, it syncs up the options.
; OUT
; - A: Action id (MODESELECT_SBCMD_*) received by master, if it's there
ModeSelect_GetCtrlFromSerial:
	; If we were sent a VS Mode option ID, also listen to the next two settings bytes.
	ld   a, [wSerialDataReceiveBuffer] ; A = Value from master
	cp   MODESELECT_SBCMD_TEAMVS			
	jr   z, .receiveVSData
	cp   MODESELECT_SBCMD_SINGLEVS
	jr   z, .receiveVSData
	; Otherwise, nothing happened.
	ret
.receiveVSData:
	; Save the MODESELECT_ACT_* value we were sent here.
	; This also has the effect of marking the current player as being 2P / using hJoyKeys2.
	; See also: ModeSelect_TrySendVSData.
	ld   [wSerialPlayerId], a
	
	; Set ourselves as slave, since we're on the receiving end.
	ld   hl, wMisc_C025
	set  MISCB_SERIAL_MODE, [hl]
	set  MISCB_SERIAL_SLAVE, [hl]
	
	; [Slave 2/3] Wait for the other GB to send wMatchStartTime
	xor  a
	ld   [wSerialTransferDone], a
	call ModeSelect_Serial_Wait
	ld   a, [wSerialDataReceiveBuffer]
	ld   [wMatchStartTime], a
	
	; [Slave 3/3] Wait for the other GB to send wDipSwitch
	xor  a
	ld   [wSerialTransferDone], a
	call ModeSelect_Serial_Wait
	ld   a, [wSerialDataReceiveBuffer]
	ld   [wDipSwitch], a
	
	; Return the action ID
	ld   a, [wSerialPlayerId]		; Restore MODESELECT_ACT_* value
	ret
	
; =============== END OF BANK ===============
; Junk area below, contains a repeated duplicate of the above subroutines.
IF VER_US
	mIncJunk "../padding_us/L1E7ED6"
ELIF VER_EN
	mIncJunk "L1E7ED6"
ELSE
	mIncJunk "L1E7F7C"
ENDC