; 
; =============== START OF MODULE Win ===============
;

GFXDef_WinScr_Bar: mGfxDef "data/gfx/winscr_bar.bin"
BG_WinScr_Bar: INCBIN "data/bg/winscr_bar.bin"
BG_WinScr_Pic: INCBIN "data/bg/winscr_pic.bin"
GFXDef_WinScr_Kyo: mGfxDef "data/gfx/winscr_kyo.bin"
GFXDef_WinScr_Benimaru: mGfxDef "data/gfx/winscr_benimaru.bin"
GFXDef_WinScr_Ryo: mGfxDef "data/gfx/winscr_ryo.bin"
GFXDef_WinScr_Yuri: mGfxDef "data/gfx/winscr_yuri.bin"
GFXDef_WinScr_Terry: mGfxDef "data/gfx/winscr_terry.bin"
GFXDef_WinScr_Joe: mGfxDef "data/gfx/winscr_joe.bin"
GFXDef_WinScr_Heidern: mGfxDef "data/gfx/winscr_heidern.bin"
GFXDef_WinScr_Ralf: mGfxDef "data/gfx/winscr_ralf.bin"
GFXDef_WinScr_Athena: mGfxDef "data/gfx/winscr_athena.bin"
GFXDef_WinScr_Kensou: mGfxDef "data/gfx/winscr_kensou.bin"
GFXDef_WinScr_Kim: mGfxDef "data/gfx/winscr_kim.bin"
GFXDef_WinScr_Mai: mGfxDef "data/gfx/winscr_mai.bin"
GFXDef_WinScr_Iori: mGfxDef "data/gfx/winscr_iori.bin"
GFXDef_WinScr_Eiji: mGfxDef "data/gfx/winscr_eiji.bin"
GFXDef_WinScr_Billy: mGfxDef "data/gfx/winscr_billy.bin"
GFXDef_WinScr_Saisyu: mGfxDef "data/gfx/winscr_saisyu.bin"
GFXDef_WinScr_Rugal: mGfxDef "data/gfx/winscr_rugal.bin"
GFXDef_WinScr_Nakoruru: mGfxDef "data/gfx/winscr_nakoruru.bin"
GFXDef_WinScr_Font: mGfxDef "data/gfx/winscr_font.bin"

PUSHC
SETCHARMAP winscr

Text_Win_Kyo:
	db "オレの炎でもえつきちまいな!"
	db "              "
	db "よわいヤツにはようはねえぜ!"
	db "              "
Text_Win_Benimaru:
	db "よくやったとおもうがな、オレの舌に "
	db "                  "
	db "おびえる小羊みたいだったぜ!"
	db "                      "
Text_Win_Ryo:
	db "修行して強くなれ! オレはそれ以上の"
	db "                  "
	db "修行をして強くなってやる!     "
	db "                  "
Text_Win_Yuri:
	db "私ってどうしてこんなに強いのかなぁ。"
	db "                  "
	db "やっぱりさいのうかなテへへ!    "
	db "                  "
Text_Win_Terry:
	db "技はさておき、いい根性をしている。 "
	db "                  "
	db "またいつでもかかってきな!     "
	db "                  "
Text_Win_Joe:
	db "わりぃな! 強いヤツとはマジでしたく"
	db "                  "
	db "なるんでね! また、戦おうぜ!   "
	db "                  "
Text_Win_Heidern:
	db "いかなる技をしゅうとくしていようとも"
	db "                  "
	db "私にかつことなどできはしない!   "
	db "                  "
Text_Win_Ralf:
	db "がんばっても、こえられんカべってのは"
	db "                  "
	db "あるとおもうぜ!          "
	db "                  "
Text_Win_Athena:
	db "戦士にきゅうそくはないわ!     "
	db "                  "
	db "さあ、次の試合にLET'S GOよ!"
	db "                  "
Text_Win_Kensou:
	db "まあ、オレにかちたいんやったら、"
	db "                "
	db "今まで以上に修行をすることやな!"
	db "                "
Text_Win_Kim:
	db "せいぎはかつ! これはむかしから"
	db "                "
	db "きまっていることなのだ!    "
	db "                "
Text_Win_Mai:
	db "女あいてとか、そんなふうに     "
	db "                  "
	db "かんがえてるからゆだんするわけよね!"
	db "                  "
Text_Win_Iori:
	db "ムダにいのちをちらすか。"
	db "            "
	db "それもいいだろう。   "
	db "            "
Text_Win_Eiji:
	db "忍術にてちじょうさい強のけん!   "
	db "                  "
	db "わが如月流忍術のまえにてきはなし! "
	db "                  "
Text_Win_Billy:
	db "強けりゃいいんだよ!    "
	db "              "
	db "まけイヌにはようはねえなぁ!"
	db "              "
Text_Win_Saisyu:
	db "うつけモノめが!          "
	db "                  "
	db "そのていどではやぶれてとうぜんじゃ!"
	db "                  "
Text_Win_Rugal:
	db "とるにたらない存在だ! えいえんに "
	db "                  "
	db "そこではいつくばっているがいい!  "
	db "                  "
Text_Win_Nakoruru:
	db "だいしぜんのおしおきです! "
	db "              "

POPC

; =============== Module_Win ===============
; EntryPoint for Win Screen.
Module_Win:

	;
	; Shared initialization code.
	; Depending on what we're doing, other initialization code may be also called (ie: SubModule_WinScr)
	;

	ld   sp, $DD00
	di
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; We're no longer in gameplay, so disable the player/sprite range enforcement
	ld   hl, wMisc_C028
	res  MISCB_PL_RANGE_CHECK, [hl]
	
	; Reset DMG pal
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	; Reset tilemaps
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset screen scrolling
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	ld   [wOBJScrollX], a
	ld   [wOBJScrollY], a
	
	; Load font GFX
	call LoadGFX_1bppFont_Default
	
	; Clear all sprites
	call ClearOBJInfo
	
	; If serial is enabled, syncronize with other GB.
	; The win screen timing should 100% match across the two GBs, like with gameplay.
	call Serial_DoHandshake
	
	;
	; Determine which path of execution we're taking, depending on who won/lost the last round.
	;
	
	; If the last round ended in a draw, display the "DRAW" screen.
	ld   a, [wStageDraw]
	or   a
	jp   nz, .draw
	
.chkWon1P:
	; Note that wLastWinner can have only one bit set at most.
	; ie: if 1P is marked as winner, 2P definitely isn't marked.
	ld   a, [wLastWinner]
	bit  PLB1, a			; Did 1P win the last round?
	jp   z, .chkWon2P		; If not, jump
.won1P:
	; Save the address of the winner (1P) to wWinPlInfoPtr.
	; This will be the player sprite that gets animated in SubModule_WinScr.
	ld   bc, wPlInfo_Pl1
	ld   a, c
	ld   [wWinPlInfoPtr_Low], a
	ld   a, b
	ld   [wWinPlInfoPtr_High], a
	
	; VS mode doesn't distinguish between winning/losing.
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   nz, .vsWon1P		; If so, jump
	
	; Single mode, obviously, have to distinguish between those.
	; Winning lets you continue, while losing throws you
	; Determine if the active player won or lost the round.
	ld   a, [wJoyActivePl]
	or   a					; Is the current player on the 1P side? (wJoyActivePl == PL1)
	jp   nz, .lost			; If not, jump (2P lost)
	jp   .won				; (1P won)
.chkWon2P:
	
	; 1P didn't win.
	; If 2P didn't win too, this also counts as a draw.
	ld   a, [wLastWinner]
	bit  PLB2, a		; Did 2P win the stage?
	jp   z, .draw		; If not, jump
.won2P:

	; Save the address of the winner (2P) to wWinPlInfoPtr.
	; This will be the player sprite that gets animated in SubModule_WinScr.
	ld   bc, wPlInfo_Pl2
	ld   a, c
	ld   [wWinPlInfoPtr_Low], a
	ld   a, b
	ld   [wWinPlInfoPtr_High], a
	
	; VS mode doesn't distinguish between winning/losing.
	ld   a, [wPlayMode]
	bit  MODEB_VS, a		; Playing in VS mode?
	jp   nz, .vsWon2P		; If so, jump
	
	; Determine if the active player won or lost the round.
	ld   a, [wJoyActivePl]
	or   a					; Is the current player on the 1P side? (wJoyActivePl == PL1)
	jp   z, .lost			; If so, jump (1P lost)
	jp   .won				; (2P won)
	
.draw:
	; Print out "DRAW" to the center of the screen
	ld   hl, TextDef_Win_Draw
	call TextPrinter_Instant
	
	; A draw counts as a loss, and just like losing the round:
	; - In Single mode, you are thrown to the continue screen
	; - In VS mode, you return back to the character select screen
	ld   a, [wPlayMode]
	bit  MODEB_VS, a
	jp   nz, .vsDraw
	
.singleDraw:
	ld   a, WIN_SINGLEDRAW
	ld   [wWinResult], a
	jp   Win_Mode_SingleDraw
.vsDraw:
	ld   a, WIN_VSDRAW
	ld   [wWinResult], a
	jp   Win_Mode_VSDraw
; Both point to the same location, as in VS mode, regardless of winning or losing,
; both players return to the character select.
.vsWon1P:
	ld   a, WIN_VSWON1P
	ld   [wWinResult], a
	jp   Win_Mode_VS
.vsWon2P:
	ld   a, WIN_VSWON2P
	ld   [wWinResult], a
	jp   Win_Mode_VS
.won:
	ld   a, WIN_SINGLEWON
	ld   [wWinResult], a
	jp   Win_Mode_SingleWon
.lost:
	ld   a, WIN_SINGLELOST
	ld   [wWinResult], a
	jp   Win_Mode_SingleLost
	
; =============== Win_Mode_VS ===============
; VS Match ended.
Win_Mode_VS:
	; Show win screen with the character who won
	call Win_DoWinScr
	; We're done
	jp   Win_SwitchToCharSel
	
; =============== Win_Mode_SingleWon ===============
; Won a stage in Single Mode (1P or Team).
Win_Mode_SingleWon:
	; Increment stage sequence number
	call Win_IncStageSeq
	
	;
	; Do all of the cutscene checks.
	; First, it checks for the two ending cutscenes (Nakoruru defeat, Normal mode Rugal defeat),
	; which switch to the Takara logo when done.
	;
	; The rest of the normal cutscene checks follow.
	;
	
	; Fall-through
	
; =============== Win_ChkNakoruruDefeatCutscene ===============
; Tries to displays the cutscene for defeating Nakoruru.
; This also tells her moves and how to unlock her.
Win_ChkNakoruruDefeatCutscene:
	ld   a, [wCharSeqId]
	cp   STAGESEQ_NAKORURU+1				; Did we just defeat Nakoruru?
	jp   nz, Win_ChkNormEndingCutscene	; If not, skip
	
	; Display cutscene
	ld   b, BANK(SubModule_CutsceneNakoruruDefeat) ; BANK $1E
	ld   hl, SubModule_CutsceneNakoruruDefeat
	rst  $08
	; Unlock Nakoruru
	ld   b, BANK(SubModule_CutsceneCharUnlock) ; BANK $18
	ld   hl, SubModule_CutsceneCharUnlock
	rst  $08
	; THE END
	ld   b, BANK(SubModule_TheEnd) ; BANK $0A
	ld   hl, SubModule_TheEnd
	rst  $08
	; Fall-through
	
; =============== Win_SwitchToTakaraLogo ===============
; Resets the game.
Win_SwitchToTakaraLogo:
	ld   b, BANK(Module_TakaraLogo) ; BANK $1F
	ld   hl, Module_TakaraLogo
	jp   FarJump
	
; =============== Win_ChkNormEndingCutscene ===============
; Tries to displays the ending cutscene for defeating Rugal on EASY or NORMAL mode.
Win_ChkNormEndingCutscene:
	; HARD mode is handled separately, as the game doesn't end there.
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD				; Playing on HARD?
	jp   nz, .chkRound					; If not, jump
	jp   Win_ChkCutsceneSingle			; Otherwise, skip ahead
	
.chkRound:
	; Must be on the proper round
	ld   a, [wCharSeqId]
	cp   STAGESEQ_RUGAL+1				; Did we just defeat Rugal?
	jp   nz, Win_ChkCutsceneSingle		; If not, jump
	
	; Omega Rugal dies
	ld   b, BANK(SubModule_CutsceneRugalDefeat) ; BANK $03
	ld   hl, SubModule_CutsceneRugalDefeat
IF REV_VER == VER_96F
	nop ; [POI] The fake 96 disables all cutscenes.
ELSE
	rst  $08
ENDC
	; Ending text
	ld   b, BANK(SubModule_CutsceneEpilogue) ; BANK $0A
	ld   hl, SubModule_CutsceneEpilogue
IF REV_VER == VER_96F
	nop
ELSE
	rst  $08
ENDC
	; Show win screen
	call Win_DoWinScr
	; Show the credits
	ld   b, BANK(SubModule_Credits) ; BANK $0A
	ld   hl, SubModule_Credits
	rst  $08
	
	; On EASY mode, you don't get the Saisyu/Rugal unlock instructions.
	; Not even a THE END.
	ld   a, [wDifficulty]
	cp   DIFFICULTY_EASY
	jp   z, Win_SwitchToTakaraLogo
	; Show Saisyu/Rugal unlock instructions
	ld   b, BANK(SubModule_CutsceneCharUnlock) ; BANK $18
	ld   hl, SubModule_CutsceneCharUnlock
	rst  $08
	; THE END
	ld   b, BANK(SubModule_TheEnd) ; BANK $0A
	ld   hl, SubModule_TheEnd
	rst  $08
	
	jp   Win_SwitchToTakaraLogo
	
; =============== Win_ChkCutsceneSingle ===============
; Tries to display the non-ending cutscene in 1P mode.
Win_ChkCutsceneSingle:

MACRO mNoCutscene
	nop
	nop
	nop
ENDM
	
	; Team mode is handled separately, as it uses copy/pasted code with minor edits.
	ld   a, [wPlayMode]
	bit  MODEB_TEAM, a						; Playing in Team mode?
	jp   nz, Win_ChkCutsceneTeam			; If so, jump
	
IF REV_VER == VER_96F
	; [POI] The cutscene disabling causes the boss rounds to malfunction!
	;       They were never meant to go through the character select random picker.
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU
	mNoCutscene
	cp   STAGESEQ_RUGAL
	mNoCutscene
	; This one needs to stay, because the credits must show up.
	cp   STAGESEQ_RUGAL+1					; Did we just defeat RUGAL? (only in HARD mode we get here)
	jp   z, Win_RugalDefeatCutsceneSingle	; If so, jump
	cp   $05
	mNoCutscene
	cp   $0A
	mNoCutscene
ELSE
	; Display cutscenes on...
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU					; Is SAISYU's stage next?
	jp   z, Win_SaisyuCutsceneSingle		; If so, jump
	cp   STAGESEQ_RUGAL						; Is RUGAL's stage next?
	jp   z, Win_RugalCutsceneSingle			; If so, jump
	cp   STAGESEQ_RUGAL+1					; Did we just defeat RUGAL? (only in HARD mode we get here)
	jp   z, Win_RugalDefeatCutsceneSingle	; If so, jump
	cp   $05								; First cutscene reached?
	jp   z, Win_Int0Cutscene				; If so, jump
	cp   $0A								; Second cutscene reached?
	jp   z, Win_Int1Cutscene				; If so, jump
ENDC

.norm:
	; No cutscene on this round, continue as normal.
	call Win_DoWinScr
	jp   Win_SwitchToCharSel

; =============== Win_SaisyuCutsceneSingle ===============
; Displays the pre-match Saisyu cutscene. (Non-team mode)
Win_SaisyuCutsceneSingle:
	call Win_DoWinScr
	; Execute cutscene
	ld   b, BANK(SubModule_CutsceneSaisyu) ; BANK $03
	ld   hl, SubModule_CutsceneSaisyu
	rst  $08
	jp   Win_StartSpecRoundSingle
	
; =============== Win_RugalCutsceneSingle ===============
; Displays the pre-match Rugal cutscene. (Non-team mode)
Win_RugalCutsceneSingle:
	; No win screen, as it counts as the next "team" opponent after Saisyu
	
	; Execute cutscene
	ld   b, BANK(SubModule_CutsceneRugal) ; BANK $03
	ld   hl, SubModule_CutsceneRugal
	rst  $08
	
	jp   Win_StartSpecRoundSingle
	
; =============== Win_RugalDefeatCutsceneSingle ===============
; Displays the post-match Rugal cutscene. (Non-team mode)
; We only get here in HARD mode only, as NORMAL/EASY is handled before in Win_ChkNormEndingCutscene.
Win_RugalDefeatCutsceneSingle:
	; Omega Rugal dies
	ld   b, BANK(SubModule_CutsceneRugalDefeat) ; BANK $03
	ld   hl, SubModule_CutsceneRugalDefeat
IF REV_VER == VER_96F
	nop
ELSE
	rst  $08
ENDC
	; Ending text
	ld   b, BANK(SubModule_CutsceneEpilogue) ; BANK $0A
	ld   hl, SubModule_CutsceneEpilogue
IF REV_VER == VER_96F
	nop
ELSE
	rst  $08
ENDC
	; Show win screen
	call Win_DoWinScr
	; Show the credits
	ld   b, BANK(SubModule_Credits) ; BANK $0A
	ld   hl, SubModule_Credits
	rst  $08
	; Nakoruru appears
	ld   b, BANK(SubModule_CutsceneNakoruru) ; BANK $1E
	ld   hl, SubModule_CutsceneNakoruru
	rst  $08
	; Fall-through
	
; =============== Win_StartSpecRoundSingle ===============
; Directly starts the next round without going through the character select screen.
; For non-team mode cutscenes only.
Win_StartSpecRoundSingle:
	; Init player bars, needed as we're skipping the character select
	call Pl_InitBeforeStageLoad
	; In non-team mode, always write to what would be the 1st team member
	ld   bc, 0
	call Win_SetSpecRoundChar
	jp   Module_Play
	
; =============== Win_ChkCutsceneTeam ===============
; Tries to display the non-ending cutscene in Team mode.
; See also: Win_ChkCutsceneSingle
Win_ChkCutsceneTeam:

IF REV_VER == VER_96F
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU
	mNoCutscene
	cp   STAGESEQ_RUGAL
	mNoCutscene
	; This one needs to stay, because the credits must show up.
	cp   STAGESEQ_RUGAL+1					; Did we just defeat RUGAL? (only in HARD mode we get here)
	jp   z, Win_RugalDefeatCutsceneTeam		; If so, jump
	cp   $06
	mNoCutscene
	cp   $0C
	mNoCutscene
ELSE
	; Display cutscenes on...
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU					; Is SAISYU's stage next?
	jp   z, Win_SaisyuCutsceneTeam			; If so, jump
	cp   STAGESEQ_RUGAL						; Is RUGAL's stage next?
	jp   z, Win_RugalCutsceneTeam			; If so, jump
	cp   STAGESEQ_RUGAL+1					; Did we just defeat RUGAL? (only in HARD mode we get here)
	jp   z, Win_RugalDefeatCutsceneTeam		; If so, jump
	cp   $06								; First cutscene reached?
	jp   z, Win_Int0Cutscene				; If so, jump
	cp   $0C								; Second cutscene reached?
	jp   z, Win_Int1Cutscene				; If so, jump
ENDC

.norm:
	; No cutscene on this round, continue as normal.
	call Win_DoWinScr
	jp   Win_SwitchToCharSel
	
; =============== Win_SaisyuCutsceneTeam ===============
; Displays the pre-match Saisyu cutscene. (Team mode)
Win_SaisyuCutsceneTeam:
	; Show win screen
	call Win_DoWinScr
	; Execute cutscene
	ld   b, BANK(SubModule_CutsceneSaisyu) ; BANK $03
	ld   hl, SubModule_CutsceneSaisyu
	rst  $08
	; Init player bars
	call Pl_InitBeforeStageLoad
	; Set Saisyu as 1st team member
	ld   bc, 0
	call Win_SetSpecRoundChar
	; End
	ld   b, BANK(Module_OrdSel) ; BANK $1E
	ld   hl, Module_OrdSel
	jp   FarJump
	
; =============== Win_RugalCutsceneTeam ===============
; Displays the pre-match Rugal cutscene. (Team mode)
Win_RugalCutsceneTeam:
	; No win screen, as it counts as the next "team" opponent after Saisyu
	
	; Execute cutscene
	ld   b, BANK(SubModule_CutsceneRugal) ; BANK $03
	ld   hl, SubModule_CutsceneRugal
	rst  $08
	; Set Rugal as 2nd team member
	ld   bc, 1
	call Win_SetSpecRoundChar
	; No order select either, straight to gameplay
	jp   Module_Play
	
; =============== Win_RugalDefeatCutsceneSingle ===============
; Displays the post-match Rugal cutscene. (Team mode)
; We only get here in HARD mode only, as NORMAL/EASY is handled before in Win_ChkNormEndingCutscene.
Win_RugalDefeatCutsceneTeam:
	; Omega Rugal dies
	ld   b, BANK(SubModule_CutsceneRugalDefeat) ; BANK $03
	ld   hl, SubModule_CutsceneRugalDefeat
IF REV_VER == VER_96F
	nop
ELSE
	rst  $08
ENDC
	; Ending text
	ld   b, BANK(SubModule_CutsceneEpilogue) ; BANK $0A
	ld   hl, SubModule_CutsceneEpilogue
IF REV_VER == VER_96F
	nop
ELSE
	rst  $08
ENDC
	; Show win screen
	call Win_DoWinScr
	; Show the credits
	ld   b, BANK(SubModule_Credits) ; BANK $0A
	ld   hl, SubModule_Credits
	rst  $08
	; Nakoruru appears
	ld   b, BANK(SubModule_CutsceneNakoruru) ; BANK $1E
	ld   hl, SubModule_CutsceneNakoruru
	rst  $08
	; Set Nakoruru as 1st team member
	ld   bc, 0
	call Win_SetSpecRoundChar
	; Prepare for 1P non-team mode
	call Win_TeamTo1P
	; Init player bars
	call Pl_InitBeforeStageLoad
	; Start bonus round
	jp   Module_Play
	
; =============== Win_Int0Cutscene ===============
; Displays the 1st intermission cutscene.
Win_Int0Cutscene:
	; Show win screen
	call Win_DoWinScr
	; Display cutscene
	ld   b, BANK(SubModule_CutsceneIntA) ; BANK $03
	ld   hl, SubModule_CutsceneIntA
	rst  $08
	; Back to normal
	jp   Win_SwitchToCharSel
	
; =============== Win_Int1Cutscene ===============
; Displays the 2nd intermission cutscene.
Win_Int1Cutscene:
	; Show win screen
	call Win_DoWinScr
	; Display cutscene
	ld   b, BANK(SubModule_CutsceneIntB) ; BANK $03
	ld   hl, SubModule_CutsceneIntB
	rst  $08
	; Back to normal
	jp   Win_SwitchToCharSel
	
; =============== Win_TeamTo1P ===============
; Prepares the player struct for the forced Single mode bonus match.
;
; This takes the first surviving team member and sets it as active 
; character, first team member, and picked character.
; We can do this because there are no further Team mode matches,
; so the team picks can be overwritten.
Win_TeamTo1P:
	;
	; Seek to the active wPlInfo
	;
	ld   a, [wJoyActivePl]
	or   a							; Playing on the 1P side?
	jp   nz, .tm2P					; If not, jump
.tm1P:
	ld   bc, wPlInfo_Pl1			; BC = Player struct
	ld   hl, wCharSelP1Char0		; HL = 1st team member
	ld   de, wCharSelP1CursorPos	; DE = Cursor position, 
	jp   .setChars
.tm2P:
	ld   bc, wPlInfo_Pl2
	ld   hl, wCharSelP2Char0
	ld   de, wCharSelP2CursorPos
.setChars:

	;
	; Get the first surviving team member.
	; This is the team member which would have been picked if the last match had another round.
	;
	push hl
		
		; A = Team member offset
		; Matches the loss count unless all three members are marked as having lost,
		; in which case it's the 3rd one.
		ld   hl, iPlInfo_TeamLossCount
		add  hl, bc
		ld   a, [hl]			; A = Loss count
		and  a, $03				; Force in range
		cp   $03				; 3 losses?
		jp   nz, .getTeamChar	; It not, skip
		ld   a, $02				; Otherwise, move back to the last character
	.getTeamChar:
	
		; Add that offset to the base team member ptr
		ld   hl, iPlInfo_TeamCharId0
		add  hl, bc				; HL = Ptr to 1st team member
		push hl					; Save ptr
			add  a, l			; HL += A
			;--
			; [POI] We never cross a $100 byte boundary here.
			jp   nc, .noIncH	
			inc  h
		.noIncH:
			;--
			ld   l, a
			
		; Read out the character ID from there
			ld   a, [hl]		; A = Character ID
			
		; #1 - Write it to the 1st team member slot
		pop  hl			; HL = Ptr to iPlInfo_TeamCharId0
		ld   [hl], a	; Write CharId there
		
		
		; #2 - Write it to the current character ID
		ld   hl, iPlInfo_CharId
		add  hl, bc		; Seek to iPlInfo_CharId
		ld   [hl], a	; Write CharId there
	pop  hl
	
	; #3 - Write it to the character select selection and cursor position
	srl  a ; CharSel IDs are not multiplied by 2
	ld   [hl], a ; wCharSelP*Char0 = CharId
	ld   [de], a ; wCharSelP*CursorPos = CharId
	ret
	
; =============== Win_SetSpecRoundChar ===============
; Sets the CPU opponent character to fight for the new boss/extra stage.
; IN
; - BC: Team member slot number
;       In practice, 1 for Rugal (2nd team member), 0 for everyone else.
Win_SetSpecRoundChar:
	; Determine the inactive side
	ld   a, [wJoyActivePl]
	or   a				; wJoyActivePl == PL1? (Playing as 1P?)
	jp   nz, .op1P		; If not, jump (Playing as 2P)
.op2P:
	; Playing as 1P, CPU is 2P
	ld   hl, wPlInfo_Pl2+iPlInfo_TeamCharId0
	ld   de, wPlInfo_Pl2+iPlInfo_CharId
	jp   .setChar
.op1P:
	; Playing as 2P, CPU is 1P
	ld   hl, wPlInfo_Pl1+iPlInfo_TeamCharId0
	ld   de, wPlInfo_Pl1+iPlInfo_CharId
.setChar:
	; Write the character ID to the current character slot
	ld   a, [wCharSeqId]	; A = Character ID
	sla  a					; A *= 2
	ld   [de], a			; Save to iPlInfo_CharId
	; and to the specified team member slot
	add  hl, bc				; Seek to team member
	ld   [hl], a			; Write character ID there
	ret
	
; =============== Win_Mode_SingleLost ===============
; Lost a round on Single Mode by having the opponent win.
Win_Mode_SingleLost:
	; Display the opponent team's win animation
	call Win_DoWinScr
	;
	; INITIALIZE CONTINUE SCREEN
	;
	
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Black out palette
	ld   a, $FF
	ldh  [rBGP], a
	
	; Hide opponent team off-screen
	ld   a, $80
	ldh  [hScrollY], a
	
	; Load standard font
	call LoadGFX_1bppFont_Default
	
	; Delete opponent team tilemap
	call ClearBGMap
	
	; [BUG] No new SGB palette layout is loaded.
	;       The existing win screen palette leaves visible gray squares.
IF VER_EN || FIX_BUGS
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
ENDC
	
	; Display "CONTINUE 9" text
	ld   hl, TextDef_Continue
	call TextPrinter_Instant
	
	; Init continue timer
	ld   a, $09					; 9 seconds
	ld   [wWinContinueTimer], a
	ld   a, 60					; Decrement after 60 frames
	ld   [wWinContinueTimerSub], a
	
	; Set real text palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	jp   Win_Continue

; =============== Win_Mode_SingleDraw ===============
; Lost a round on Single Mode by ending the stage on a DRAW.
; Note that, by the time we get here, "DRAW" should already be in the tilemap.
Win_Mode_SingleDraw:
	; Music kills itself in shame
	ld   a, BGM_STAGECLEAR
	call HomeCall_Sound_ReqPlayExId_Stub
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	call Task_PassControl_NoDelay
	; Enable palette
	ld   a, $1B
	ldh  [rBGP], a
.wait:
	call Win_IdleWaitLong
	jp   c, .toContinue
	;--
	; [TCRF] C is always set, so we never get here.
	;        Seems like pressing START would have reset the wait timer.
	;        See also: other instances of Win_IdleWaitLong calls.
	call Task_PassControl_NoDelay
	jp   .wait
	;--
.toContinue:
	;
	; INITIALIZE CONTINUE SCREEN
	;
	
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Black out palette
	ld   a, $FF
	ldh  [rBGP], a
	
	; Hide opponent team off-screen
	ld   a, $80
	ldh  [hScrollY], a
	
	; Load standard font
	call LoadGFX_1bppFont_Default
	
	; Delete opponent team tilemap
	call ClearBGMap
	
	; [BUG] SGB Palette also not set here.
IF VER_EN || FIX_BUGS
	ld   de, SCRPAL_INTRO
	call HomeCall_SGB_ApplyScreenPalSet
ENDC
	
	; Display "CONTINUE 9" text
	ld   hl, TextDef_Continue
	call TextPrinter_Instant
	
	; Init continue timer
	ld   a, $09					; 9 seconds
	ld   [wWinContinueTimer], a
	ld   a, 60					; Decrement after 60 frames
	ld   [wWinContinueTimerSub], a
	
	; Set real text palette
	ld   a, $1B
	ldh  [rBGP], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	
	jp   Win_Continue
	
; =============== Win_Mode_VSDraw ===============
; Lost in VS mode by ending the stage on a DRAW.
; Note that, by the time we get here, "DRAW" should already be in the tilemap.
Win_Mode_VSDraw:
	; Music kills itself in shame
	ld   a, BGM_STAGECLEAR
	call HomeCall_Sound_ReqPlayExId_Stub
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	call Task_PassControl_NoDelay
	; Enable palette
	ld   a, $1B
	ldh  [rBGP], a
.wait:
	call Win_IdleWaitLong
	jp   c, .toCharSel
	;--
	; [TCRF] We never get here
	call Task_PassControl_NoDelay
	jp   .wait
.toCharSel:
	jp   Win_SwitchToCharSel
	
; =============== Win_Continue ===============
; Handles the Continue screen.
Win_Continue:
	call Task_PassControl_NoDelay
.loop:
	; Pressing START returns to the character select.
	call Win_IsStartPressed
	jp   c, .toCharSel
	
.decSubSec:
	; Decrement the subsecond timer
	ld   a, [wWinContinueTimerSub]
	or   a				; TimerSub == 0?
	jp   z, .decSec		; If so, jump
	dec  a				; Otherwise, TimerSub--
	ld   [wWinContinueTimerSub], a
	call Task_PassControl_NoDelay
	jp   .loop
.decSec:
	; Reset subtimer to 60 frames
	ld   a, 60
	ld   [wWinContinueTimerSub], a
	
	; Decrement second timer
	ld   a, [wWinContinueTimer]
	or   a				; Timer == 0?
	jp   z, .gameOver	; If so, jump
	dec  a				; Otherwise, Timer--
	ld   [wWinContinueTimer], a
	
	; Play sound when second ticks away
	ld   a, SFX_CHARSELECTED
	call HomeCall_Sound_ReqPlayExId_Stub
	
	;
	; Update tilemap with new number.
	; Because NumberPrinter_Instant writes two digits, after that
	; replace the leading 0 with a space.
	;
	ld   a, [wWinContinueTimer]
	ld   de, $9AED
	call NumberPrinter_Instant
	ld   hl, TextDef_ContinueNumSpace
	call TextPrinter_Instant
	
	call Task_PassControl_NoDelay
	jp   .loop
	
.gameOver:
	ld   a, BGM_GAMEOVER
	call HomeCall_Sound_ReqPlayExId_Stub
	
	ld   hl, TextDef_GameOver
	call TextPrinter_Instant
	jp   .toTitle
	
.toCharSel:
	;--
	; [TCRF] Mark that a continue was used. This is never read from.
	ld   a, $01
	ld   [wUnused_ContinueUsed], a
	;--
	
	;
	; When losing to Rugal in Single Team mode, you have to defeat Saisyu again.
	; The is due to the game treating Saisyu and Rugal as a single team.
	;
	ld   hl, wCharSeqId
	ld   a, [hl]			; Get single mode stage sequence
	cp   STAGESEQ_RUGAL		; Are we on RUGAL's stage? (lost to RUGAL?)
	jp   nz, .jpCharSel		; If not, skip
	ld   a, [wPlayMode]
	bit  MODEB_TEAM, a		; Are we in team mode?
	jp   z, .jpCharSel		; If not, skip
	; Otherwise, reset current match to Saisyu's
	ld   [hl], STAGESEQ_SAISYU
	; and unmark him as defeated
	ld   a, [wCharSeqTbl+STAGESEQ_SAISYU]
	and  $FF^CHARSEL_POSF_DEFEATED
	ld   [wCharSeqTbl+STAGESEQ_SAISYU], a
	
.jpCharSel:
	jp   Win_SwitchToCharSel
	
.toTitle:
	call Win_IdleWaitLong
	jp   c, Win_SwitchToTitle
	; [TCRF] Unreachable code, Win_IdleWaitLong always returns C flag set.
	call Task_PassControl_NoDelay
	jp   .toTitle
; =============== Win_SwitchToTitle ===============
; Switches to the Title screen.
Win_SwitchToTitle:
	ld   b, BANK(Module_Title) ; BANK $1C
	ld   hl, Module_Title
	jp   FarJump
; =============== Win_SwitchToCharSel ===============
; Switches to the Character Select screen.
Win_SwitchToCharSel:
	ld   b, BANK(Module_CharSel) ; BANK $1E
	ld   hl, Module_CharSel
	jp   FarJump
; =============== Win_DoWinScr ===============
; Handles the Win Screen.
Win_DoWinScr:
	; BC = Ptr to winner wPlInfo
	ld   a, [wWinPlInfoPtr_Low]
	ld   c, a
	ld   a, [wWinPlInfoPtr_High]
	ld   b, a
	
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Set SGB pal
	push bc
		ld   de, SCRPAL_STAGECLEAR
		call HomeCall_SGB_ApplyScreenPalSet
	pop  bc
	
	;
	; Load the block of shared Win Screen graphics
	;
	push bc
		; Win quote text
	IF VER_EN
		ld   a, $08 ; Tile ID Offset
		ld   de, $9080
		call Cutscene_InitFont
	ELSE
		ld   hl, GFXDef_WinScr_Font
		ld   de, $9080
		call CopyTilesAutoNum
	ENDC
		
		; BG pattern graphics
		ld   hl, GFXDef_WinScr_Bar
		ld   de, $9000
		call CopyTilesAutoNum
		
		; BG pattern tiles
		ld   de, BG_WinScr_Bar
		ld   hl, $9800
		ld   b, $14
		ld   c, $12
		call CopyBGToRect
	pop  bc
	
	; Draw the character pics
	call WinScr_InitPics
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_OBJSIZE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei   
	; Apply screen changes
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $1B
	ldh  [rBGP], a
	
	; Play stage win BGM
	ld   a, BGM_STAGECLEAR
	call HomeCall_Sound_ReqPlayExId_Stub
	
	
	call WinScr_PrintWinQuote
	
.wait:
	call WinScr_IdleWait
	jp   c, .end
	;--
	; [TCRF] C is always set, so we never get here.
	;        Seems like the game would have paused until pressing START.
	;        See also: other instances of Win_IdleWaitLong calls.
	call Task_PassControl_NoDelay
	jp   .wait
	;--
.end:
	call Task_PassControl_NoDelay
	ret  
	
; =============== Cutscene_DrawCharPicsForActivePl ===============	
; Initializes the large pictures for the player side, intended for use in Single mode.
Cutscene_DrawCharPicsForActivePl:
	ld   bc, wPlInfo_Pl1		; BC = 1P
	ld   a, [wJoyActivePl]
	or   a						; Is 1P the active player?
	jp   z, WinScr_InitPics		; If so, jump
	ld   bc, wPlInfo_Pl2		; Otherwise, BC = 2P
	; Fall-through
	
; =============== WinScr_InitPics ===============	
; Initializes the large pictures for the player characters for the Win Screen.
WinScr_InitPics:


; =============== mWinScrDrawPic ===============
; Generates code to draw a single pic.
; IN
; - 1: VRAM destination ptr
; - 2: Tilemap destination ptr
; - 3: Pic position
; - A: Character ID
MACRO mWinScrDrawPic
	; Load graphics / SGB palette for the pic
	ld   de, \1				; DE = VRAM destination ptr
	ld   b, \3				; B = Middle pic
	call WinScr_InitPicGFX
	
	; Load the tilemap for the middle pic
	ld   hl, \2				; HL = Destination Ptr in VRAM
	ld   de, BG_WinScr_Pic	; DE = Ptr to uncompressed tilemap
	
	mktid \1
	ld   a, TID				; A = Tile ID base offset
	ld   b, $06				; B = Rect Width
	ld   c, $06				; C = Rect Height
	call CopyBGToRectWithBase
ENDM

	;
	; Draw the pic for the active character in the middle.
	;
	push bc
		; Load graphics / SGB palette for the middle pic
		ld   hl, iPlInfo_CharId
		add  hl, bc
		ld   a, [hl]		; A = Active Character ID
		;              VRAM   MAP    POS
		mWinScrDrawPic $8A40, $9867, PIC_POS_M
	pop  bc
	
	;
	; Draw the other team members to the tilemap, if applicable.
	;
	
.chkRound:
	;
	; If losing on a boss/extra round, do not draw any further pics.
	; This is because these rounds only have a single opponent.
	;
	ld   a, [wWinResult]
	cp   WIN_SINGLELOST				; Lost in 1P mode?
	jp   nz, .chkSingle				; If not, skip
	ld   a, [wCharSeqId]			; Are we currently on...
	cp   STAGESEQ_SAISYU			; ... Saisyu's stage?
	jp   z, .ret					; If so, jump
	cp   STAGESEQ_RUGAL				; ""
	jp   z, .ret
	cp   STAGESEQ_NAKORURU
	jp   z, .ret
	
.chkSingle:
	;
	; In don't draw further pics in Single mode.
	;
	ld   a, [wPlayMode]
	bit  MODEB_TEAM, a
	jp   z, .ret
	
	;
	; If the round ended on a draw, roll back the winner loss count
	; to display the proper characters on the sides. (see below)
	;
	ld   a, [wPlInfo_Pl1+iPlInfo_Health]	; A = 1P Health
	ld   hl, wPlInfo_Pl2+iPlInfo_Health		; HL = Ptr to 2P health
	cp   a, [hl]							; 1PHealth != 2PHealth?
	jp   nz, .drawTeamOther					; If so, jump
	
	ld   hl, iPlInfo_TeamLossCount			; Otherwise, iPlInfo_TeamLossCount--
	add  hl, bc
	dec  [hl]
	
.drawTeamOther:

	;
	; Draw the pic for the second character on the left.
	; 
	; With no losses, this is the second team member, otherwise it's the first.
	;
	push bc
		ld   hl, iPlInfo_TeamLossCount
		add  hl, bc
		ldi  a, [hl]		; A = LossCount, seek to iPlInfo_TeamCharId0
		cp   $00			; LossCount != 0?
		jp   nz, .drawL		; If so, skip
		inc  hl				; Otherwise, seek to iPlInfo_TeamCharId1
	.drawL:
		ld   a, [hl]	; Read character ID
		;              VRAM   MAP    POS
		mWinScrDrawPic $8800, $9861, PIC_POS_L
	pop  bc
	
	;
	; Draw the pic for the third character on the right.
	; 
	; With less than two losses, this is the third member,
	; ortherwise it's the second.
	;
	push bc
		ld   hl, iPlInfo_TeamLossCount
		add  hl, bc
		ldi  a, [hl]	; A = LossCount, seek to iPlInfo_TeamCharId0
		cp   $02		; LossCount == 2? (3rd char is the active one)
		jp   z, .drawR	; If so, skip
		cp   $03		; LossCount == 3? (3rd char is the active one)
		jp   z, .drawR	; If so, skip
		inc  hl			; Otherwise, seek to iPlInfo_TeamCharId1
	.drawR:
		inc  hl			; Seek again to 2nd/3rd member
		ld   a, [hl]	; Read character ID
		;              VRAM   MAP    POS
		mWinScrDrawPic $8C80, $986D, PIC_POS_R
	pop  bc
	
.ret:
	ret 
	
; =============== WinScr_InitPicGFX ===============	
; Loads the graphics and SGB palettes for the character's win pic.
; IN
; - DE: Destinaton ptr in VRAM
; - B: Win pic position (PIC_POS_*)
; - A: Character ID
WinScr_InitPicGFX:
	; Load the graphics for it.
	push af
		push bc
			;
			; Index the Source GFX pointer off the table
			; HL = WinScr_CharGFXPtrTbl[A]
			;
			push de
				ld   hl, WinScr_CharGFXPtrTbl	; HL = Table base ptr
				ld   e, a		; DE = Char ID
				ld   d, $00
				add  hl, de		; Seek to it				
				ld   e, [hl]	; Read out ptr to DE
				inc  hl
				ld   d, [hl]
				push de			; Move to HL
				pop  hl
				
			; DE = Destination GFX ptr
			pop  de
			call CopyTilesAutoNum
		pop  bc
	pop  af
	
	; Load the SGB palette
	ld   d, a ; D = Character ID
	ld   e, b ; E = Win Pic Pos
	call HomeCall_SGB_ApplyWinPicPalSet
	ret
	
WinScr_CharGFXPtrTbl:
	dw GFXDef_WinScr_Kyo ; CHAR_ID_KYO     
	dw GFXDef_WinScr_Benimaru ; CHAR_ID_BENIMARU
	dw GFXDef_WinScr_Ryo ; CHAR_ID_RYO     
	dw GFXDef_WinScr_Yuri ; CHAR_ID_YURI    
	dw GFXDef_WinScr_Terry ; CHAR_ID_TERRY   
	dw GFXDef_WinScr_Joe ; CHAR_ID_JOE     
	dw GFXDef_WinScr_Heidern ; CHAR_ID_HEIDERN 
	dw GFXDef_WinScr_Ralf ; CHAR_ID_RALF    
	dw GFXDef_WinScr_Athena ; CHAR_ID_ATHENA  
	dw GFXDef_WinScr_Kensou ; CHAR_ID_KENSOU  
	dw GFXDef_WinScr_Kim ; CHAR_ID_KIM     
	dw GFXDef_WinScr_Mai ; CHAR_ID_MAI     
	dw GFXDef_WinScr_Iori ; CHAR_ID_IORI    
	dw GFXDef_WinScr_Eiji ; CHAR_ID_EIJI    
	dw GFXDef_WinScr_Billy ; CHAR_ID_BILLY   
	dw GFXDef_WinScr_Saisyu ; CHAR_ID_SAISYU  
	dw GFXDef_WinScr_Rugal ; CHAR_ID_RUGAL   
	dw GFXDef_WinScr_Nakoruru ; CHAR_ID_NAKORURU

; =============== Cutscene_DrawCharPic ===============
; Draws a character pic in the middle of the screen, meant for cutscenes.
; IN
; - A: Character ID
Cutscene_DrawCharPic:
		
	; Load graphics / SGB palette for the pic
	ld   de, $8A40				; DE = VRAM destination ptr
	ld   b, PIC_POS_M			; B = Middle pic
	call WinScr_InitPicGFX
	
	; Load the tilemap for the middle pic
	ld   hl, $9867			; HL = Destination Ptr in VRAM
	ld   de, BG_WinScr_Pic	; DE = Ptr to uncompressed tilemap
	
	ld   a, $A4				; A = Tile ID base offset
	ld   b, $06				; B = Rect Width
	ld   c, $06				; C = Rect Height
	call CopyBGToRectWithBase
	
	ret
	
; =============== WinScr_PrintWinQuote ===============
; Prints out the win quote to the screen.
WinScr_PrintWinQuote:
	;
	; Seek to the winner's wPlInfo
	; This could have read from wWinPlInfoPtr_* instead of checking manually.
	;
	ld   a, [wLastWinner]
	bit  PLB1, a			; Did 1P win?
	jp   z, .chkWin2P		; If not, jump
	ld   bc, wPlInfo_Pl1	; BC = 1P
	jp   .printText
.chkWin2P:
	ld   a, [wLastWinner]
	bit  PLB2, a			; Did 2P win?
	ret  z					; If not, return (this should never happen)
	ld   bc, wPlInfo_Pl2	; BC = 2P
	
.printText:
	;
	; Seek to the table entry with TextPrinter parameters.
	; HL = WinScr_CharTextPtrTbl[iPlInfo_CharId]
	;
	
	; Create the table offset.
	ld   hl, iPlInfo_CharId
	add  hl, bc
	ld   a, [hl]					; A = CharId
IF !VER_EN
	; The Japanese version needs to store a bunch of information that the raw text data
	; doesn't provide, so each table entry ends up being 8 bytes long.
	; The CharId is already multiplied by 2, so it only needs to be multiplied by 4 (<< 2).
	
	; Meanwhile, the English version (as well as 96) stores the win quotes as TextDef, so it
	; can just be a straight pointer table.
	sla  a							; A *= 4
	sla  a
ENDC
	ld   hl, WinScr_CharTextPtrTbl	; HL = Table base ptr
	ld   d, $00						; DE = A
	ld   e, a
	add  hl, de						; Offset it
	
	;
	; Get the parameters out
	;
	
IF VER_EN
	; byte0-1 -> HL
	; Ptr to TextDef
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	push de
	pop  hl
	
	ld   b, BANK(TextDef_WinEn_Marker) ; All English win quotes are in BANK $19
	ld   c, $08 ; 8 frame delay between letters 
	call TextPrinter_MultiFrameFar_AllowFast
ELSE

	; byte0-1 -> DE
	; Ptr to text data (list of tile IDs)
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	
	; byte2-3 -> BC (will be moved to HL)
	; Ptr to tilemap (Destination)
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	inc  hl

	push bc ; Save dest ptr
		; byte4 -> B
		; Text width (number of characters in a line)
		ld   b, [hl]
		inc  hl
		; byte5 -> C
		; Text width (number of characters in a line)
		ld   c, [hl]
	pop  hl ; Restore to proper reg
	
	; 4 frame delay between letters 
	ld   a, $04
	call TextPrinter_MultiFrame_WithSpeedup
ENDC
	ret
	
; =============== WinScr_CharTextPtrTbl ===============
; This table maps every character to its own win quote.
WinScr_CharTextPtrTbl:
IF VER_EN
	dw TextDef_WinEn_Kyo ; CHAR_ID_KYO     
	dw TextDef_WinEn_Benimaru ; CHAR_ID_BENIMARU
	dw TextDef_WinEn_Ryo ; CHAR_ID_RYO     
	dw TextDef_WinEn_Yuri ; CHAR_ID_YURI    
	dw TextDef_WinEn_Terry ; CHAR_ID_TERRY   
	dw TextDef_WinEn_Joe ; CHAR_ID_JOE     
	dw TextDef_WinEn_Heidern ; CHAR_ID_HEIDERN 
	dw TextDef_WinEn_Ralf ; CHAR_ID_RALF    
	dw TextDef_WinEn_Athena ; CHAR_ID_ATHENA  
	dw TextDef_WinEn_Kensou ; CHAR_ID_KENSOU  
	dw TextDef_WinEn_Kim ; CHAR_ID_KIM     
	dw TextDef_WinEn_Mai ; CHAR_ID_MAI     
	dw TextDef_WinEn_Iori ; CHAR_ID_IORI    
	dw TextDef_WinEn_Eiji ; CHAR_ID_EIJI    
	dw TextDef_WinEn_Billy ; CHAR_ID_BILLY   
	dw TextDef_WinEn_Saisyu ; CHAR_ID_SAISYU  
	dw TextDef_WinEn_Rugal ; CHAR_ID_RUGAL   
	dw TextDef_WinEn_Nakoruru ; CHAR_ID_NAKORURU
ELSE
	; CHAR_ID_KYO
	dw Text_Win_Kyo ; Text
	dw $99A1 ; Destination
	db $0E ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_BENIMARU
	dw Text_Win_Benimaru ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_RYO
	dw Text_Win_Ryo ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_YURI
	dw Text_Win_Yuri ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_TERRY
	dw Text_Win_Terry ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_JOE
	dw Text_Win_Joe ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_HEIDERN
	dw Text_Win_Heidern ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_RALF
	dw Text_Win_Ralf ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_ATHENA
	dw Text_Win_Athena ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_KENSOU
	dw Text_Win_Kensou ; Text
	dw $99A1 ; Destination
	db $10 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_KIM
	dw Text_Win_Kim ; Text
	dw $99A1 ; Destination
	db $10 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_MAI
	dw Text_Win_Mai ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_IORI
	dw Text_Win_Iori ; Text
	dw $99A1 ; Destination
	db $0C ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_EIJI
	dw Text_Win_Eiji ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_BILLY
	dw Text_Win_Billy ; Text
	dw $99A1 ; Destination
	db $0E ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_SAISYU
	dw Text_Win_Saisyu ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_RUGAL
	dw Text_Win_Rugal ; Text
	dw $99A1 ; Destination
	db $12 ; Width
	db $04 ; Height
	dw $0000 ; Padding
	
	; CHAR_ID_NAKORURU
	dw Text_Win_Nakoruru ; Text
	dw $99A1 ; Destination
	db $0E ; Width
	db $02 ; Height
	dw $0000 ; Padding
ENDC
	

; =============== WinScr_IdleWait ===============
; Waits for $F0 frames showing the Win Screen.
; OUT
; - C flag: Always set.
WinScr_IdleWait:
	ld   b, $F0	; B = Number of frames
.loop:
	; If any player presses START, the wait ends early
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a
	jp   nz, .abort
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a
	jp   nz, .abort
	
	; Wait a frame
	call Task_PassControl_NoDelay
	
	dec  b			; Are we finished?
	jp   nz, .loop	; If not, loop
	
	; Some code is missing here to return clear
	;xor  a	; C flag clear
	;ret
.abort:
	scf		; C flag set
	ret
	
; =============== Win_IdleWaitLong ===============
; Waits for $01E0 frames, or until someone presses START.
; OUT
; - C flag: Always set
Win_IdleWaitLong:
	ld   bc, $01E0			; BC = Number of frames
.loop:
	; If any player presses START, the wait ends early
	ldh  a, [hJoyNewKeys]
	bit  KEYB_START, a
	jp   nz, .abort
	ldh  a, [hJoyNewKeys2]
	bit  KEYB_START, a
	jp   nz, .abort
	; Wait a frame
	call Task_PassControl_NoDelay
	dec  bc			; FramesLeft--
	ld   a, b
	or   a, c		; B == 0 && C == 0?
	jp   nz, .loop	; If not, loop
	; Otherwise, we're done
.abort:
	scf
	ret
	
; =============== Win_IsStartPressed ===============
; Checks if any player pressed START.
; OUT
; - C flag: If set, someone did
Win_IsStartPressed:
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
	
; =============== Win_IncStageSeq ===============
; Increases the stage sequence id by the number of opponents in the stage.
;
; This also marks them as defeated, which allows CharSel_DrawCrossOnDefeatedChars
; to display crosses over defeated character icons
;
; Calling this allows the game to progress in Single Modes, and shouldn't be called in VS modes.
Win_IncStageSeq:
	;
	; Seek to the current slot in the stage sequence table.
	; DE = Ptr to current CHARSEL_ID_* entry in the opponent sequence table.
	;
	ld   hl, wCharSeqTbl	; HL = Sequence table
	ld   a, [wCharSeqId]	; A = RoundId
	add  a, l				; Index the table
	jp   nc, .noOvf			; (we never overflow L)
	inc  h
.noOvf:
	ld   l, a				; Save it back
	push hl					; Move ptr to DE
	pop  de
	
	; HL = Ptr to wCharSeqId
	; This will later be incremented for every opponent marked as defeated.
	ld   hl, wCharSeqId
	
	;
	; Determine by how much to increase the stage sequence id.
	;
	
	; There's only one opponent in the boss and extra rounds.
	ld   a, [wCharSeqId]	; A = RoundSeqId
	cp   STAGESEQ_SAISYU	; On SAISYU's stage?
	jp   z, .set1			; If so, jump
	cp   STAGESEQ_RUGAL		; ...
	jp   z, .set1
	cp   STAGESEQ_NAKORURU
	jp   z, .set1
	
	; Otherwise, if we're in team mode, there are three opponents, so the stage sequence
	; should increment by three.
	ld   b, $03				; B = Slots to mark
	ld   a, [wPlayMode]		
	bit  MODEB_TEAM, a		; Are we in team mode?
	jp   nz, .loop			; If so, skip
.set1:						; Otherwise, there's only one opponent in single modes.
	ld   b, $01				; B = Slots to mark
	
	;
	; Advance the stage progress B times.
	;
.loop:
	; Mark the opponent as defeated
	ld   a, [de]					; A = Slot
	set  CHARSEL_POSFB_DEFEATED, a	; Mark as defeated
	ld   [de], a					; Save it back
	inc  de							; Seek to next slot
	
	; Increment stage id
	inc  [hl]						; wCharSeqId++
	
	dec  b							; Are we done?
	jp   nz, .loop					; If not, loop
	ret
	
;--
; [TCRF] Unreferenced text, meant for a similar screen to the "DRAW" one.
;        These may have been placeholders from before the proper Win Screen was implemented,
;        or they were supposed to be displayed above the win pic, like FF Special did.
TextDef_Win_Unused_1PWon:
	dw $9887
	mTxtDef "1P WON"
TextDef_Win_Unused_2PWon:
	dw $9887
	mTxtDef "2P WON"
TextDef_Win_Unused_YouWon:
	dw $9886
	mTxtDef "YOU  WON"
TextDef_Win_Unused_YouLost:
	dw $9886
	mTxtDef "YOU LOST"
;--
TextDef_Win_Draw:
	dw $9888
	mTxtDef "DRAW"
TextDef_Continue:
	dw $9AE5
	mTxtDef "CONTINUE 9"
TextDef_ContinueNumSpace:
	dw $9AED
	mTxtDef " "
TextDef_GameOver:
	dw $9AE5
	mTxtDef "GAME  OVER"
; =============== END OF BANK ===============
; Junk area below.
IF VER_US
	mIncJunk "../padding_us/L1C7C6F"
ELIF VER_EN
	mIncJunk "L1C7C6F"
ELSE
	mIncJunk "L1C7CD9"
ENDC