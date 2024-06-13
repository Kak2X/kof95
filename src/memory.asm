
; Portrait locations in Order Select screen
vBGOrdSelP1CharSel0 EQU $9843
vBGOrdSelP1CharSel1 EQU $98C3
vBGOrdSelP1CharSel2 EQU $9943
vBGOrdSelP2CharSel0 EQU $984E
vBGOrdSelP2CharSel1 EQU $98CE
vBGOrdSelP2CharSel2 EQU $994E

vBGHealthBar1P          EQU $9C20
vBGHealthBar1P_Last     EQU vBGHealthBar1P+$08

vBGRoundTime            EQU $9C29

vBGHealthBar2P          EQU $9C2B
vBGHealthBar2P_Last     EQU vBGHealthBar2P+$08

vBGPowBar1P_Left        EQU $9C61
vBGPowBar2P_Left        EQU $9C6C

vBGPause1P              EQU $9C41
vBGPause2P              EQU $9C4E

vBGBoxWin1P0            EQU $9C84
vBGBoxWin1P1            EQU $9C86
vBGBoxWin2P0            EQU $9C8E
vBGBoxWin2P1            EQU $9C8C

; EQUs relative to the Japanese version

SECTION "Sound RAM", WRAM0[$C000]
wSndSet                   :db ; EQU $C000 ; Request playback of this sound ID 
wSndTimerIncSpeedSub      :db ; EQU $C001 ; Added to the song subframe timer (iSndInfo_LengthTimerSub) every frame.
wSndTimerIncSpeed         :db ; EQU $C002 ; Added to the song timer (iSndInfo_LengthTimer) every frame.
; [TCRF] The game never uses the fade in/out functionality
wSndFadeStatus            :db ; EQU $C003 ; Fade control
wSndFadeTimer             :db ; EQU $C004 ; Fade timer. When it reaches the target, a sound channel gets muted.
wSndFadeTarget            :db ; EQU $C005 ; Fade timer target.

wSnd_Unused_ChUsed        :db ; EQU $C006 ; [TCRF] Bitmask intended to mark the used sound channels, but it doesn't in this game.
wSnd_Unused_EnaChBGM      :db ; EQU $C007 ; [TCRF] Keeps track of the last rNR51 value used modified by a BGM SndInfo.
wSnd_Unused_Ch3StopLength :db ; EQU $C008 ; [TCRF] Not used in this game

db

wSndChProcLeft          :db     ; EQU $C00A ; Number of remaining wBGMCh*Info/wSFXCh*Info structs to process
wSndInfoCur             :ds $20 ; EQU $C00B ; Current channel playback struct

wSndIdReqTbl            :ds $08 ; EQU $C02B ; Sound IDs to play are written here. Not used by 95.

; Channel playback status (separate lanes for BGM and SFX)
wBGMCh1Info             :ds $20 ; EQU $C033
wBGMCh2Info             :ds $20 ; EQU $C053
wBGMCh3Info             :ds $20 ; EQU $C073
wBGMCh4Info             :ds $20 ; EQU $C093
wSFXCh1Info             :ds $20 ; EQU $C0B3
wSFXCh2Info             :ds $20 ; EQU $C0D3
wSFXCh3Info             :ds $20 ; EQU $C0F3
wSFXCh4Info             :ds $20 ; EQU $C113


SECTION "Settings RAM", WRAM0[$C600]
wDifficulty             :db ; EQU $C600
wMatchStartTime         :db ; EQU $C601
wDipSwitch              :db ; EQU $C602 ; DIP-SWITCH options

SECTION "Main RAM", WRAM0[$C605]
wTimer                  :db ; EQU $C605 ; Global timer
wLCDCSectId             :db ; EQU $C606 ; Starts at $00 on every frame, incremented when LCDC hits (to determine the parallax sections)
wVBlankNotDone          :db ; EQU $C607 ; If != 0, the VBlank handler hasn't finished
wRand                   :db ; EQU $C608 ; Last random value for the Rand function not using LY
wRandLY                 :db ; EQU $C609 ; Last random value for the Rand function using LY

ds 3

wNoCopyGFXBuf           :db ; EQU $C60D ; If set, disables the GFX copy during VBlank
wWorkOAMCurPtr_Low      :db ; EQU $C60E ; Next OBJ will be written at this location
wWorkOAMCurPtr_High     :db ; EQU $C60F ;
UNION
wOBJLstTmpROMFlags      :db ; EQU $C610 ; Calculated status flags for the sprite mapping
NEXTU
wOBJLstTmpStatusNew     :db ; EQU $C610 ; For OBJLstS_UpdateGFXBufInfo
ENDU
wOBJLstCurStatus        :db ; EQU $C611 ; Temporary copy of iOBJInfo_Status
wOBJLstTmpStatusOld     :db ; EQU $C612 ; For OBJLstS_UpdateGFXBufInfo


wOBJLstOrigFlags        :db ; EQU $C613 ; Original copy of the correct iOBJInfo_OBJLstFlags* field for the currently processed sprite mapping
wOBJLstCurRelX          :db ; EQU $C614 ; Calculated relative position/origin of the sprite mapping
wOBJLstCurRelY          :db ; EQU $C615 ; Calculated relative position/origin of the sprite mapping
wOBJLstCurFlags         :db ; EQU $C616 ; Calculated flags for the sprite mapping (merge of wOBJLstCurFlags and wOBJLstOrigFlags)
wOBJLstCurYOffset       :db ; EQU $C617 ; Offset added to wOBJLstCurRelY, and the result goes to wOBJLstCurDispY


ds 4

wMisc_C025              :db ; EQU $C61C ; Serial + SGB
wMisc_C026              :db ; EQU $C61D ; Task
wMisc_C027              :db ; EQU $C61E ; Gameplay
wMisc_C028              :db ; EQU $C61F ; Sect

UNION
wTitleMode              :db ; EQU $C620
NEXTU
wIntroScene             :db ; EQU $C620 ; Offset to scene ID in scene pointer table. There's only one scene though.
NEXTU
wWinResult              :db ; EQU $C620 ; Win screen result
ENDU

ds 1

wSGBSendPacketAtFrameEnd    :db     ; EQU $C622 ; If set, there are SGB packets to send after all tasks are processed
wSGBSoundPacket             :ds $10 ; EQU $C623 ; Data for the sound effect packet to be sent at the end of the frame.

wSerialIntPtr_Low                  :db     ; EQU $C633
wSerialIntPtr_High                 :db     ; EQU $C634
wSerialDataReceiveBuffer           :ds $80 ; EQU $C635
wSerialDataSendBuffer              :ds $80 ; EQU $C6B5
wSerialDataReceiveBufferIndex_Head :db     ; EQU $C735
wSerialDataReceiveBufferIndex_Tail :db     ; EQU $C736
wSerialDataReceiveBuffer_End       EQU wSerialDataSendBuffer
wSerialDataSendBuffer_End          EQU wSerialDataReceiveBufferIndex_Head
wSerialDataSendBufferIndex_Head    :db     ; EQU $C737 ; Index of most recent buffer entry
wSerialDataSendBufferIndex_Tail    :db     ; EQU $C738 ; Index of last buffer entry - used for current player input in VS serial
; These mark the balance for increasing the head/tail indexes
wSerialReceivedLeft                :db     ; EQU $C739 ; Number of received bytes wSerialDataReceiveBufferIndex_Tail is behind of. 
wSerialSentLeft                    :db     ; EQU $C73A ; Number of sent bytes wSerialDataReceiveBufferIndex_Tail is behind of.
wSerial_Unknown_Unused_C144        :db     ; EQU $C73B
wSerialPlayerId                    :db     ; EQU $C73C ; Determines who is 1P/2P due to an implementation detail of how MODESELECT_SBCMD_* is sent.
wSerialTransferDone                :db     ; EQU $C73D ; Marks if the serial handler was executed for the frame? otherwise waits
wSerialPendingJoyKeys              :db     ; EQU $C73E ; Player 1 Only - Next inputs to send after receiving a byte
wSerialPendingJoyNewKeys           :db     ; EQU $C73F
wSerialPendingJoyKeys2             :db     ; EQU $C740 ; Player 2 Only - Next inputs to send after receiving a byte
wSerialPendingJoyNewKeys2          :db     ; EQU $C741 ;
wSerialInputMode                   :db     ; EQU $C742 ; If set, controls are enabled during serial mode
wFontLoadBit1Col                   :db     ; EQU $C743 ; 2pp color mapped to bit1 on 1bpp graphics
wFontLoadBit0Col                   :db     ; EQU $C744 ; 2pp color mapped to bit0 on 1bpp graphics
wFontLoadTmpGFX                    :ds 2   ; EQU $C745 ; 2 bytes (size of a line)

IF VER_EN
wTextPrintTileOffset               :db ; EQU $C747 ; Offset added to the tile ID after the ASCII to Tile conversion. Set to something other than 0 when the cutscene font is loaded at an alternate address.
wTextPrintFlags                    :db ; EQU $C748 ; Text printer modifiers
ENDC


wOBJScrollX                 :db ; EQU $C747 ; X position *subtracted* to every OBJ.
ds 1 ; Missing subpixel position
wOBJScrollY                 :db ; EQU $C749 ; Y position *subtracted* to every OBJ.
ds 1 ; Missing subpixel position
wScreenShakeY               :db ; EQU $C74B ; Y offset "subtracted" from hScrollY, for vertical screen shake effects. won't alter sprites.

wColiBoxTbl                 :ds $400 ; EQU $C74C ; The table of collision boxes is copied to this location in WRAM at startup.

wStageDraw                  :db ; EQU $CB4C ; If set, forces the "DRAW" screen to appear in single mode when the stage ends. Single-mode specific.
wLastWinner                 :db ; EQU $CB4D ; Marks using bits the player who won the last round.
wPlayMode                   :db ; EQU $CB4E ; Single/Team 1P/VS
wJoyActivePl                :db ; EQU $CB4F ; Determines the active player side in 1P modes. (PL*)
wStageId                    :db ; EQU $CB50 ; Stage ID. Determines music, backdrop and palette.
wRoundNum                   :db ; EQU $CB51 ; Round number in a stage
ds 1
wRoundTime                  :db ; EQU $CB53 ; Round timer
wRoundTimeSub               :db ; EQU $CB54 ; Round subsecond timer

wPlayMaxPowDrawLast1P       :db ; EQU $CB55 ; What was last drawn on the MAX Power bar.
wPlayMaxPowDrawLast2P       :db ; EQU $CB56 ; ""

wPlayHitstopSet             :db ; EQU $CB57 ; Requests hitstop for the next frame.
wPlayHitstop                :db ; EQU $CB58 ; If set, hitstop is applied. Due to how tasks are carefully managed, this is only applied to the player who got hit.
wPlayPlThrowActId           :db ; EQU $CB59 ; Act ID for a throw. This is global since two throws can't be active at once.
wPlayPlThrowOpMode          :db ; EQU $CB5A ; PLAY_THROWOP_*
wPlayPlThrowDir             :db ; EQU $CB5B ; Throw direction (PLAY_THROWDIR_*)

wPlaySlowdownTimer          :db ; EQU $CB5C ; Countdown timer. When it's > 0, slowdown is enabled during gameplay. When it reaches 0, the slowdown stops.
wPlaySlowdownSpeed          :db ; EQU $CB5D ; Determines how much the game should slow down. Execution is 1 every (wPlaySlowdownSpeed) frames.
wPauseFlags                 :db ; EQU $CB5E ; Contains flags for the pause state
wUnused_ContinueUsed        :db ; EQU $CB5F ; If set, a continue was used. Not read by anything.
wCharSeqId                  :db ; EQU $CB60 ; "Stage sequence number". Index to the char sequence table, essentially the number of beat opponents after clearing a stage
wCharSeqTbl                 :ds $12 ; EQU $CB61 ; "Stage sequence". Sequence of CPU opponents in order, containing initially CHARSEL_ID_* for normal rounds and CHAR_ID_* for bosses
wCharSelIdMapTbl            :ds $12 ; EQU $CB73 ; Table indexed by character ID cursor locations in the char select screen to character IDs.
wCharSelIdMapTbl_End        EQU wCharSelIdMapTbl+$12

;ds $0A




; Mode-specific block starting from $CB85
 
UNION
;
; GENERAL
;
ds $1A
wSerialLagCounter           :db ; EQU $CB9F ; Amount of frames the serial lags for the slave
wSerial_Unknown_Unused_C1C6 :db ; EQU $CBA0
wSGBWinPacketMid            :ds $10 ; EQU $CBA1 ; SGB Packet - Win screen center pic
wSGBWinPacketSide           :ds $10 ; EQU $CBB1 ; SGB Packet - Win screen side pic

NEXTU
;
; TAKARA LOGO
;
ds $1C
wCheatBossKeysLeft          :db ; EQU $CBA1 ; Amount of times to press the button before cheat activates
wCheatAllCharKeysLeft       :db ; EQU $CBA2 ; each for the 4 cheats
wCheatInfMeterKeysLeft      :db ; EQU $CBA3
wCheatEasyMovesKeysLeft     :db ; EQU $CBA4

NEXTU
;
; INTRO
;
ds $0A
wIntro_Unused_JoyActivePl   :db ; EQU $CB8F ; [TCRF] Marks the player that skipped the Intro. Only written to.
ds $11
wIntroActPtr_High           :db ; EQU $CBA1 ; Intro phase, for the chars scene
wIntroActPtr_Low            :db ; EQU $CBA2
wIntroActTimer              :db ; EQU $CBA3 ; Times the phases in the chars scene
wIntroIoriLogoTimer         :db ; EQU $CBA4
wIntroLogoOnlyTimer         :db ; EQU $CBA5

NEXTU
;
; TITLE / OPTIONS
;
ds $0B
wTitleMenuOptId             :db ; EQU $CB90 ; Cursor location in title screen
wTitleMenuCursorXBak        :db ; EQU $CB91 ; Backup location of cursor X position
wTitleMenuCursorYBak        :db ; EQU $CB92 ; Backup location of cursor Y position
wTitleSubMenuOptId          :db ; EQU $CB93 ; Cursor location for Game Select / Option menus
wOptionsSGBSndOptId         :db ; EQU $CB94 ; Vertical cursor location in the SGB Sound Test
wOptionsBGMId               :db ; EQU $CB95 ; ID of the selected music in the BGM Test
wOptionsSFXId               :db ; EQU $CB96 ; ID of the selected sound effect in the SFX Test
wOptionsMenuMode            :db ; EQU $CB97 ; $00 -> Normal, $02 -> SGB Sound Test
wTitleBlinkTimer            :db ; EQU $CB98 ; Increments in the title screen, determines when to hide or show blinking sprites
; These are ordered in the same way as OPTION_SITEM_*
wOptionsSGBSndIdA           :db ; EQU $CB99 ; Selected SGB Sound Id - Set A
wOptionsSGBSndBankA         :db ; EQU $CB9A ; Selected SGB Bank number Id - Set A
wOptionsSGBSndIdB           :db ; EQU $CB9B ; Selected SGB Sound Id - Set B
wOptionsSGBSndBankB         :db ; EQU $CB9C ; Selected SGB Bank number Id - Set B
wOptionsSGBBase                   EQU wOptionsSGBSndIdA
wTitleResetTimer_High       :db ; EQU $CB9D
wTitleResetTimer_Low        :db ; EQU $CB9E
ds 2
wOptionsSGBPacketSnd        :db ; EQU $CBA1 ; Start of SGB packet used when selecting a song in the sound test
wOptionsSGBPacketSndIdA     :db ; EQU $CBA2 ; Byte 1 determines Sound ID A
wOptionsSGBPacketSndIdB     :db ; EQU $CBA3 ; Byte 2 determines Sound ID B
wOptionsSGBPacketSndBank    :db ; EQU $CBA4 ; Byte 3 determines Sound Bank
NEXTU
;
; CHARACTER SELECT
;
wCharSelP1CursorPos         :db ; EQU $CB85 ; Player 1 cursor position, CHARSEL_ID_*
wCharSelP2CursorPos         :db ; EQU $CB86 ; Player 2 cursor position, CHARSEL_ID_*
; Character ID selected for both players
wCharSelP1Char0             :db ; EQU $CB87
wCharSelP1Char1             :db ; EQU $CB88
wCharSelP1Char2             :db ; EQU $CB89
wCharSelP2Char0             :db ; EQU $CB8A
wCharSelP2Char1             :db ; EQU $CB8B
wCharSelP2Char2             :db ; EQU $CB8C
wCharSelRandom1P            :db ; EQU $CB8D ; Randomize team on 1P side
wCharSelRandom2P            :db ; EQU $CB8E ; Randomize team on 2P side
wCharSelTeamFull            :db ; EQU $CB8F ; Temporary value when adding characters, determines if more can be added
wCharSelP1CursorMode        :db ; EQU $CB90
wCharSelP2CursorMode        :db ; EQU $CB91
wCharSelCurPl               :db ; EQU $CB92 ; Player num currently handled in the character select screen.
wCharSelRandomDelay1P       :db ; EQU $CB93 ; Delay until the CPU autopicks the next character
wCharSelRandomDelay2P       :db ; EQU $CB94 ; Delay until the CPU autopicks the next character
NEXTU
;
; ORDER SELECT
;
ds 8
wOrdSelCPUDelay1P           :db ; EQU $CB8D ; Delay between CPU picks
wOrdSelCPUDelay2P           :db ; EQU $CB8E ; Delay between CPU picks
ds 1
wOrdSelP1CharsSelected      :db ; EQU $CB90
wOrdSelP2CharsSelected      :db ; EQU $CB91
wOrdSelCurPl                :db ; EQU $CB92 ; Player num currently handled in the character select screen.
ds $0E
wOrdSelP1CursorPos          :db ; EQU $CBA1
wOrdSelP2CursorPos          :db ; EQU $CBA2
; [POI] For some reason, there are two addresses used to keep track of the characters selected.
;       Both copies are always kept syncronized, so what's the point?
;       96 repurposed these for wOrdSelTmpP*CharId.
wOrdSelP1CharsSelected_Copy   :db ; EQU $CBA3
wOrdSelP2CharsSelected_Copy   :db ; EQU $CBA4
; The last number of these labels doesn't have the same meaning in these pairs.
; wOrdSelP*CharSel -> number of the character slot (ie: 0 is leftmost for 1P, rightmost for 2P)
; wOrdSelP*CharId -> team member order (ie: at 0 is the first picked character)
wOrdSelP1CharSel0             :db ; EQU $CBA5
wOrdSelP1CharId0              :db ; EQU $CBA6
wOrdSelP1CharSel1             :db ; EQU $CBA7
wOrdSelP1CharId1              :db ; EQU $CBA8
wOrdSelP1CharSel2             :db ; EQU $CBA9
wOrdSelP1CharId2              :db ; EQU $CBAA
wOrdSelP2CharSel0             :db ; EQU $CBAB
wOrdSelP2CharId0              :db ; EQU $CBAC
wOrdSelP2CharSel1             :db ; EQU $CBAD
wOrdSelP2CharId1              :db ; EQU $CBAE
wOrdSelP2CharSel2             :db ; EQU $CBAF
wOrdSelP2CharId2              :db ; EQU $CBB0

; Temporary values containing selected character ID. Reuse existing variables because they can.
wOrdSelTmpP1CharId                  EQU wOrdSelP1CharId1 ; Can get away with it
wOrdSelTmpP2CharId                  EQU wOrdSelP2CharId1 ; Can get away with it

NEXTU

;
; GAMEPLAY
;
ds $1C
; Temporary variables used for collision box overlap checks between two boxes (marked as A and B)
wPlayTmpColiA_OBJLstFlags     :db ; EQU $CBA1 ; Sprite mapping flags, to determine if it should be flipped
wPlayTmpColiB_OBJLstFlags     :db ; EQU $CBA2
ds 8
wPlayTmpColiA_OriginH         :db ; EQU $CBAB ; Left side of collision box, relative to player X pos (usually negative or 0)
wPlayTmpColiA_OriginV         :db ; EQU $CBAC ; Top side of collision box, relative to player Y pos (usually negative or 0)
wPlayTmpColiA_RadH            :db ; EQU $CBAD ; Collision box horizontal radius (extends to both sides of origin)
wPlayTmpColiA_RadV            :db ; EQU $CBAE ; Collision box vertical radius (extends to both sides of origin)
wPlayTmpColiA                       EQU wPlayTmpColiA_OriginH

; See above, but for other player
ds 6
wPlayTmpColiB_OriginH         :db ; EQU $CBB5
wPlayTmpColiB_OriginV         :db ; EQU $CBB6
wPlayTmpColiB_RadH            :db ; EQU $CBB7
wPlayTmpColiB_RadV            :db ; EQU $CBB8
wPlayTmpColiB                       EQU wPlayTmpColiB_OriginH

NEXTU
;
; WIN SCREEN / CUTSCENES
;
ds $0A
wWinPlInfoPtr_Low             :db ; EQU $CB8F ; Ptr to the wPlInfo that won the stage (low byte)
wWinPlInfoPtr_High            :db ; EQU $CB90 ; "" (high byte)
ds $10
wCutBlinkPicMask              :db ; EQU $CBA1 ; Visibility mask, determines when to hide or show Omega Rugal's pic.
NEXTU
;
; CONTINUE
;
ds $0A
wWinContinueTimer             :db ; EQU $CB8F ; Continue timer - seconds left
wWinContinueTimerSub          :db ; EQU $CB90 ; Continue timer - frames left before decrementing second
ENDU

SECTION "GFXBuf RAM", WRAM0[$CF00]
wGFXBufInfo_Pl1             :ds $20 ; EQU $CF00
wGFXBufInfo_Pl2             :ds $20 ; EQU $CF20

SECTION "OBJInfo RAM", WRAM0[$D000]
;
; SPRITE MAPPINGS
;
wOBJInfo0                   :ds $40 ; EQU $D000
wOBJInfo1                   :ds $40 ; EQU $D040
wOBJInfo2                   :ds $40 ; EQU $D080
wOBJInfo3                   :ds $40 ; EQU $D0C0
wOBJInfo4                   :ds $40 ; EQU $D100
wOBJInfo5                   :ds $40 ; EQU $D140
wOBJInfo6                   :ds $40 ; EQU $D180
wOBJInfo7                   :ds $40 ; EQU $D1C0
wOBJInfo8                   :ds $40 ; EQU $D200

; Special purpose mappings
; General
wOBJInfo_Pl1                EQU wOBJInfo0
wOBJInfo_Pl2                EQU wOBJInfo1
 
; Intro
wOBJInfo_IntroKyo           EQU wOBJInfo0
wOBJInfo_IntroIori          EQU wOBJInfo1

; Title screen
wOBJInfo_CursorR            EQU wOBJInfo0
wOBJInfo_MenuText           EQU wOBJInfo1
wOBJInfo_SnkText            EQU wOBJInfo2
wOBJInfo_CursorU            EQU wOBJInfo3
; Gameplay
wOBJInfo_RoundText          EQU wOBJInfo2 ; Pre-round text and post-round text
wOBJInfo_Pl1Projectile      EQU wOBJInfo2
wOBJInfo_Pl2Projectile      EQU wOBJInfo3
wOBJInfo_Pl1Bird            EQU wOBJInfo4 ; Mamahaha, 1P
wOBJInfo_Pl2Bird            EQU wOBJInfo5 ; Mamahaha, 2P
wOBJInfo_TerryHat           EQU wOBJInfo2
; Cutscene
wOBJInfo_PicBlink           EQU wOBJInfo0
; 
SECTION "PlInfo RAM", WRAM0[$D800]
wPlInfo_Pl1                 :ds $100 ; EQU $D800
wPlInfo_Pl2                 :ds $100 ; EQU $D900
; 
SECTION "OAM Mirror", WRAM0[$DF00]
wWorkOAM                    :ds OBJ_SIZE*OBJCOUNT_MAX ; EQU $DF00
wWorkOAM_End                EQU wWorkOAM+OBJ_SIZE*OBJCOUNT_MAX ; $DFA0


SECTION "HRAM", HRAM[$FF80]
;
; HIGH RAM
;
hOAMDMA                     :ds $18 ; EQU $FF80 ; OAMDMA routine
hJoyKeys                    :db     ; EQU $FF98 ; Player 1 - (Held) Joypad keys
hJoyNewKeys                 :db     ; EQU $FF99 ; Player 1 - Newly pressed keys
ds 1
hJoyKeysDelayTbl            :ds $10 ; EQU $FF9B ; Player 1 - Menu hold delay info ($10 bytes, 2 for each KEY_*)

hJoyKeys2                   :db     ; EQU $FFAB ; Player 2 - (Held) Joypad keys
hJoyNewKeys2                :db     ; EQU $FFAC ; Player 2 - Newly pressed keys
ds 1
hJoyKeys2DelayTbl           :ds $10 ; EQU $FFAE

ds 2
hTaskStats                  :db     ; EQU $FFC0 ; Global task system info
hCurTaskId                  :db     ; EQU $FFC1 ; Current task id ($01-$03)
ds 6
hTaskTbl                    :ds $03*TASK_SIZE ; EQU $FFC8 ; Task struct list

hTaskPl1 EQU hTaskTbl+($01*TASK_SIZE)
hTaskPl2 EQU hTaskTbl+($02*TASK_SIZE)


hROMBank                    :db     ; EQU $FFE0 ; Currently loaded ROM bank


ds 1
hScrollY                    :db ; EQU $FFE2 ; Y screen position
hScrollYSub                 :db ; EQU $FFE3 ; Y screen subpixel position
hScrollX                    :db ; EQU $FFE4 ; X screen position
hScrollXSub                 :db ; EQU $FFE5 ; X screen subpixel position
hTitleParallax1X            :db ; EQU $FFE6 ; X screen position
hTitleParallax1XSub         :db ; EQU $FFE7
hTitleParallax2X            :db ; EQU $FFE8
hTitleParallax2XSub         :db ; EQU $FFE9
hTitleParallax3X            :db ; EQU $FFEA
hTitleParallax3XSub         :db ; EQU $FFEB
hTitleParallax4X            :db ; EQU $FFEC
hTitleParallax4XSub         :db ; EQU $FFED
hTitleParallax5X            :db ; EQU $FFEE
hTitleParallax5XSub         :db ; EQU $FFEF

hScreenSect0BGP             :db ; EQU $FFF0 ; BG Palette for the first screen section
hScreenSect1BGP             :db ; EQU $FFF1 ; ...
hScreenSect2BGP             :db ; EQU $FFF2
ds 8
hSndInfoCurPtr_Low          :db ; EQU $FFFB ; Ptr to Currently processed SNDInfo structure
hSndInfoCurPtr_High         :db ; EQU $FFFC ; Ptr to Currently processed SNDInfo structure
hSndPlayCnt                 :db ; EQU $FFFD ; [TCRF] Sound Played Counter (bits3-0)
hSndPlaySetCnt              :db ; EQU $FFFE ; [TCRF] Sound Req Counter (bits3-0) (if != hSndPlaySetCnt, start a new track)

;--------------------------
;
; STRUCTS
;

; Elements in hTaskTbl entry struct
iTaskType                   EQU $00 ; Task type (TASK_EXEC_*)
iTaskPauseTimer             EQU $01 ; Decrements every frame. If != 0, the task isn't marked in its TODO state.
iTaskPtr_Low                EQU $02 ; Code or stack pointer
iTaskPtr_High               EQU $03

; Elements in hJoyKeysDelayTbl entry struct
iKeyMenuHeld                EQU $00
iKeyMenuTimer               EQU $01

; Elements in wGFXBufInfo struct
; Set A -> Primary sprite mapping
; Set B -> Secondary sprite mapping, not always present
iGFXBufInfo_DestPtr_Low     EQU $00 ; Shared - VRAM destination ptr
iGFXBufInfo_DestPtr_High    EQU $01	
iGFXBufInfo_SrcPtrA_Low     EQU $02 ; Set A - Source GFX ptr
iGFXBufInfo_SrcPtrA_High    EQU $03
iGFXBufInfo_BankA           EQU $04 ; Set A - Source GFX bank
iGFXBufInfo_TilesLeftA      EQU $05 ; Set A - (8x8) Tiles remaining
iGFXBufInfo_SrcPtrB_Low     EQU $06 ; Set B - Source GFX ptr
iGFXBufInfo_SrcPtrB_High    EQU $07
iGFXBufInfo_BankB           EQU $08 ; Set B - Source GFX bank
iGFXBufInfo_TilesLeftB      EQU $09 ; Set B - (8x8) Tiles remaining
iGFXBufInfo_SetKey          EQU $0A ; 5 bytes. Current set "Id". Combination of Set A settings.
iGFXBufInfo_SetKeyView      EQU $10 ; 5 bytes. Last completed set "id".

; Some of the fields that have the "View" suffix also have a field without it.
; They are used to help with double buffering, and are completely unrelated to the "Set A" and "Set B" of wGFXBufInfo.
;
; ie:
; - iOBJInfo_OBJLstFlags: Flags for the *internal* current sprite mapping.
;                         When loading new graphics, this is treated as the pending value.
; - iOBJInfo_OBJLstFlagsView: Flags for the *visible* current sprite mapping.
;                             When a sprite mapping uses the GFX buffer system, this is guaranteed to always
;                             match what's visible on screen, even if the internal value is what gets used.
;
; The "View" fields however are only used when graphics are loading on the pending buffer, so they
; are referred to as the "Old" set. This is for compatibility with sprite mappings that don't load
; dynamic graphics -- because of how the data/system was set up, those don't have valid entries in the "Old" set.
; As those don't load graphics, they'll always use the internal fields.
iOBJInfo_Status                    EQU $00 ; Both sets - OBJInfo flags + X/Y OBJLst flip flags (OR'd over ROM flags)
iOBJInfo_OBJLstFlags               EQU $01 ; Current - HW OBJ flags used for the entire OBJLst (XOR'd over ROM flags after above)
iOBJInfo_OBJLstFlagsView           EQU $02 ; Old - See above
iOBJInfo_X                         EQU $03 ; X Position
iOBJInfo_XSub                      EQU $04 ; X Subpixel Position
iOBJInfo_Y                         EQU $05 ; Y Position
iOBJInfo_YSub                      EQU $06 ; Y Subpixel Position
iOBJInfo_SpeedX                    EQU $07 ; X speed - Added to iOBJInfo_X every frame
iOBJInfo_SpeedXSub                 EQU $08 ; X Subpixel speed - Added to iOBJInfo_XSub every frame
iOBJInfo_SpeedY                    EQU $09 ; Y speed
iOBJInfo_SpeedYSub                 EQU $0A ; Y Subpixel speed 
iOBJInfo_RelX                      EQU $0B ; Relative X Position (autogenerated)
iOBJInfo_RelY                      EQU $0C ; Relative Y Position (autogenerated)
iOBJInfo_TileIDBase                EQU $0D ; Starting tile ID (all tile IDs in the OBJ list are relative to this)
iOBJInfo_VRAMPtr_Low               EQU $0E ; VRAM GFX Pointer (low byte) - GFX is written to this address for buffer A, typically is $8000 or $8400
iOBJInfo_VRAMPtr_High              EQU $0F ; VRAM GFX Pointer (high byte)
iOBJInfo_BankNum                   EQU $10 ; Current - Bank number for OBJLstPtrTable (animation table)
iOBJInfo_OBJLstPtrTbl_Low          EQU $11 ; Current - Ptr to OBJLstPtrTable (low byte)
iOBJInfo_OBJLstPtrTbl_High         EQU $12 ; Current - Ptr to OBJLstPtrTable (high byte)
iOBJInfo_OBJLstPtrTblOffset        EQU $13 ; Current - Table offset (multiple of $04)
iOBJInfo_BankNumView               EQU $14 ; Old - Bank number for OBJLstPtrTable (animation table)
iOBJInfo_OBJLstPtrTbl_LowView      EQU $15 ; Old - Ptr to OBJLstPtrTable (low byte)
iOBJInfo_OBJLstPtrTbl_HighView     EQU $16 ; Old - Ptr to OBJLstPtrTable (high byte)
iOBJInfo_OBJLstPtrTblOffsetView    EQU $17 ; Old - Table offset (multiple of $04)
iOBJInfo_ColiBoxId                 EQU $18 ; Hurtbox/Collision box ID (copied from iOBJLstHdrA_ColiBoxId)
iOBJInfo_HitboxId                  EQU $19 ; Hitbox ID (copied from iOBJLstHdrA_HitBoxId)
iOBJInfo_ForceHitboxId             EQU $1A ; If set, overrides the specified Hitbox ID (ignores iOBJInfo_HitboxId and the flags disabling the hitbox). Not for unblockables, as the guard check is still made. Used for temporary throw hitboxes. 
iOBJInfo_FrameLeft                 EQU $1B ; Number of frames left before switching to the next anim frame.
iOBJInfo_FrameTotal                EQU $1C ; Animation speed. New frames will have iOBJInfo_FrameLeft set to this.
iOBJInfo_BufInfoPtr_Low            EQU $1D ; GFX Buffer info struct pointer (low byte)
iOBJInfo_BufInfoPtr_High           EQU $1E ; GFX Buffer info struct pointer (high byte)
iOBJInfo_RangeMoveAmount           EQU $1F ; How many pixels the player is moved to keep him in range
iOBJInfo_Custom                    EQU $20 ; $20 bytes of free space

; Things going into said free space:

; Default custom values used by multiple ExOBJ, mostly by projectiles.
; Some of these, in practice, are *only* used by those, like the damage flags.
iOBJInfo_Play_CodeBank             EQU iOBJInfo_Custom+$00 ; Bank number for the CodePtr
iOBJInfo_Play_CodePtr_Low          EQU iOBJInfo_Custom+$01 ; Custom code for ExOBJ (low byte)
iOBJInfo_Play_CodePtr_High         EQU iOBJInfo_Custom+$02 ; Custom code for ExOBJ (high byte)
iOBJInfo_Play_DamageVal            EQU iOBJInfo_Custom+$03 ; Damage given the ExOBJ hits the opponent.
iOBJInfo_Play_DamageHitTypeId      EQU iOBJInfo_Custom+$04 ; Animation playing when the projectile hits the opponent (HITTYPE_*)
iOBJInfo_Play_DamageFlags3         EQU iOBJInfo_Custom+$05 ; Damage flags applied when the opponent gets hit (they get copied to iPlInfo_Flags3)
iOBJInfo_Play_HitMode              EQU iOBJInfo_Custom+$06 ; If set, marks what happens when the projectile hits a target
iOBJInfo_Play_FlashTimer           EQU iOBJInfo_Custom+$07 ; Times flash animation for sprites. Exists because there's no wPlayTimer in 95.
iOBJInfo_Play_Priority             EQU iOBJInfo_Custom+$07 ; Higher priority projectiles erase others
iOBJInfo_Play_EnaTimer             EQU iOBJInfo_Custom+$08 ; Visibility timer. When it elapses, the ExOBJ disappears.
;--
; For Benimaru's Raikouken
iOBJInfo_Proj_ThunderBall_Despawn  EQU iOBJInfo_Custom+$08 ; Set to $FF to despawn the ball.
; ; For Athena's Shining Crystal Bit (before throw)
iOBJInfo_Proj_ShCrystCharge_OrigX           EQU iOBJInfo_Custom+$08 ; X Origin for the projectile. The small spheres are positioned relative to this.
iOBJInfo_Proj_ShCrystCharge_OrigY           EQU iOBJInfo_Custom+$09 ; Y Origin for the projectile.
iOBJInfo_Proj_ShCrystCharge_XPosId          EQU iOBJInfo_Custom+$0A ; Coords table index for X position
iOBJInfo_Proj_ShCrystCharge_YPosId          EQU iOBJInfo_Custom+$0B ; Coords table index for Y position
iOBJInfo_Proj_ShCrystCharge_XPosMul         EQU iOBJInfo_Custom+$0C ; Exponential multiplier for X position
iOBJInfo_Proj_ShCrystCharge_YPosMul         EQU iOBJInfo_Custom+$0D ; Exponential multiplier for Y position
iOBJInfo_Proj_ShCrystCharge_XPosMulUpdTimer EQU iOBJInfo_Custom+$0E ; Timer for incrementing/decrementing XPosMul
iOBJInfo_Proj_ShCrystCharge_YPosMulUpdTimer EQU iOBJInfo_Custom+$0F ; Timer for incrementing/decrementing YPosMul
iOBJInfo_Proj_ShCrystCharge_OrbitMode       EQU iOBJInfo_Custom+$10 ; Projectile movement mode
iOBJInfo_Proj_ShCrystCharge_OrigMoveLeft    EQU iOBJInfo_Custom+$11 ; Origin UB movements left. When it elapses, we switch to Hold mode.
iOBJInfo_Proj_ShCrystCharge_DespawnTimer    EQU iOBJInfo_Custom+$11 ; In spiral mode
iOBJInfo_Proj_ShCrystCharge_OrigMoveTimer   EQU iOBJInfo_Custom+$12 ; Incrementing timer to time the origin movements.

; For Nakoruru's Mamahaha, which is not a projectile
iOBJInfo_Bird_Mode      EQU iOBJInfo_Custom+$07 ; Bird animation mode
iOBJInfo_Bird_Timer     EQU iOBJInfo_Custom+$08 ; Mode-specific timer
iOBJInfo_Bird_Unused_29 EQU iOBJInfo_Custom+$09 ; Never read from


; Sprite mapping fields.

; OBJLstPtrTable A entry elements
iOBJLstHdrA_Flags                  EQU $00
iOBJLstHdrA_ColiBoxId              EQU $01 ; Hurtbox ID
iOBJLstHdrA_HitBoxId               EQU $02 ; Hitbox ID
iOBJLstHdrA_GFXPtr_Low             EQU $03 ; Ptr to uncompressed GFX (low byte) - will be copied to the GfxInfo
iOBJLstHdrA_GFXPtr_High            EQU $04 ; Ptr to uncompressed GFX (high byte)
iOBJLstHdrA_GFXBank                EQU $05 ; Bank num with GFX
iOBJLstHdrA_DataPtr_Low            EQU $06 ; Ptr to iOBJLst (low byte)
iOBJLstHdrA_DataPtr_High           EQU $07 ; Ptr to iOBJLst (high byte)
iOBJLstHdrA_YOffset                EQU $08

; OBJLstPtrTable B entry elements
iOBJLstHdrB_Flags                  EQU $00
iOBJLstHdrB_GFXPtr_Low             EQU $01
iOBJLstHdrB_GFXPtr_High            EQU $02
iOBJLstHdrB_GFXBank                EQU $03
iOBJLstHdrB_DataPtr_Low            EQU $04
iOBJLstHdrB_DataPtr_High           EQU $05
iOBJLstHdrB_YOffset                EQU $06

; Actual OBJLst format
iOBJLst_OBJCount                   EQU $00
; List of OBJ in "compressed" format, right after iOBJLst_OBJCount
iOBJ_Y                             EQU $00
iOBJ_X                             EQU $01
iOBJ_TileIDAndFlags                EQU $02

; Player struct (wPlInfo) format

; Tables with 8 entries of 2 byte each (KEY_* + length)
; These are the locations move input is checked from.
; [TODO] Rough/Incomplete graph, should be visual
;                                        o---------------------------------------o
;                                        |                                       |
; (joy reader) -> hJoyKeys    -> iPlInfo_JoyKeys    -> iPlInfo_Joy*Buffer   2    v
;              -> hJoyNewKeys -> iPlInfo_JoyNewKeys -> iPlInfo_JoyNewKeysLH -> iPlInfo_JoyKeysLH
;                                                              | 1               ^
;                                                              v                 |
;                                                      iPlInfo_JoyBufKeysLH -----o
iPlInfo_JoyBtnBuffer               EQU $00 ; A/B buttons
iPlInfo_JoyDirBuffer               EQU $10 ; Directional keys
iPlInfo_Flags0                     EQU $20 ; Player flags (byte 0)
iPlInfo_Flags1                     EQU $21 ; Player flags (byte 1)
iPlInfo_Flags2                     EQU $22 ; Player flags (byte 2)
iPlInfo_Flags3                     EQU $23 ; Player flags (byte 3 - related to damage)
;-- 
; from master tbl
;
iPlInfo_MoveAnimTblPtr_High        EQU $24 ; Ptr to move anim data ptr table (high byte) [BANK $05]
iPlInfo_MoveAnimTblPtr_Low         EQU $25 ; Ptr to move anim data ptr table (low byte) [BANK $05]
iPlInfo_MoveCodePtrTbl_High        EQU $26 ; Ptr to move code ptr table (high byte) [BANK $06]
iPlInfo_MoveCodePtrTbl_Low         EQU $27 ; Ptr to move code ptr table (low byte) [BANK $06]
iPlInfo_MoveInputCodePtr_High      EQU $28 ; Ptr to special move reader code (high byte)
iPlInfo_MoveInputCodePtr_Low       EQU $29 ; Ptr to special move reader code (low byte)
iPlInfo_MoveInputCodePtr_Bank      EQU $2A ; Bank num for special move reader code
;-- 
iPlInfo_PlId                       EQU $2B ; Player number (PL1 or PL2), fixed per side
iPlInfo_CharId                     EQU $2C ; Character ID
iPlInfo_MoveId                     EQU $2E ; ID of the current move. (multiplied by 2)
iPlInfo_HitTypeId                  EQU $2F ; ID of the currently playing hit effect. (HITTYPE_*)
iPlInfo_IntroMoveId                EQU $30 ; Intro/outro move ID. When set, iPlInfo_MoveId should be set to the same value.
iPlInfo_SingleWinCount             EQU $31 ; Single mode - Win count. If it reaches 2 the stage ends.   
iPlInfo_OBJLstPtrTblOffsetMoveEnd  EQU $32 ; iOBJInfo_OBJLstPtrTblOffset must match this for the move to end. 
                                           ; Must be less or equal to the animation/OBJLstPtrTable's length.
                                           ; This is mostly to reuse truncated animations.
; Move damage fields - current
iPlInfo_MoveDamageVal              EQU $33 ; Damage given when hitting the opponent directly
iPlInfo_MoveDamageHitTypeId        EQU $34 ; Animation playing when getting hit (HITTYPE_*)
iPlInfo_MoveDamageFlags3           EQU $35 ; Source damage flags applied when getting hit (they get copied to iPlInfo_Flags3)
; Move damage fields - pending (for currently loading frame)
iPlInfo_MoveDamageValNext          EQU $36
iPlInfo_MoveDamageHitTypeIdNext    EQU $37
iPlInfo_MoveDamageFlags3Next       EQU $38

iPlInfo_JoyKeysLH                  EQU $3C ; Held directional keys + *New* A/B light/heavy info + Cumulative A/B light heavy info. Used for the standard punch/kick check when starting moves (both normal and specials).
iPlInfo_JoyNewKeys                 EQU $3D ; Newly pressed joypad keys. Copied directly from hJoyNewKeys,
iPlInfo_JoyKeys                    EQU $3E ; Held joypad Keys. Copied directly from hJoyKeys.
iPlInfo_JoyNewKeysLH               EQU $3F ; Newly pressed directional keys + new A/B light/heavy info
iPlInfo_JoyKeysPreJump             EQU $40 ; Backup of iPlInfo_JoyKeys set before jumping
iPlInfo_JoyNewKeysLHPreJump        EQU $41 ; Backup of iPlInfo_JoyNewKeysLH set before jumping
iPlInfo_JoyBufKeysLH               EQU $42 ; Holds a buffer of the current and previous A/B light/heavy info. This field is essentially a manual version of "iPlInfo_JoyKeys" for LH info, which normally isn't saved in iPlInfo_JoyKeysLH.
iPlInfo_JoyHeavyCountA             EQU $43 ; Counter to detect light/heavy punches, result saved to iPlInfo_JoyNewKeysLH
iPlInfo_JoyHeavyCountB             EQU $44 ; Counter to detect light/heavy kicks, result saved to iPlInfo_JoyNewKeysLH.
iPlInfo_JoyDirBufferOffset         EQU $45 ; Current offset to iPlInfo_JoyDirBuffer
iPlInfo_JoyBtnBufferOffset         EQU $46 ; Current offset to iPlInfo_JoyBtnBuffer

iPlInfo_Health                     EQU $47 ; Player health
iPlInfo_HealthVisual               EQU $48 ; Player health as it appears on the health bar
iPlInfo_Pow                        EQU $49 ; POW meter
iPlInfo_PowVisual                  EQU $4A ; POW meter as it appears on the POW bar
iPlInfo_MaxPow                     EQU $4B ; MAX Power meter timer. When elapsed, MAX Pow ends.
iPlInfo_DizzyTimeLeft              EQU $4C ; Countdown timer before the player snaps out of the dizzy state.
iPlInfo_DizzyHitCount              EQU $4D ; Hit combo counter (not shown on screen in this game).
iPlInfo_DizzyHitTarget             EQU $4E ; Combo count required to dizzy.
iPlInfo_NoThrowTimer               EQU $4F ; Wake up timer set when a player drops on the ground. Prevents getting thrown.
iPlInfo_Unused_ThrowKeyTimer       EQU $50 ; [TCRF] Countdown timer related to throws, but non-functional.
iPlInfo_PlDistance                 EQU $51 ; Distance between players (the same across players)
iPlInfo_ProjDistance               EQU $52 ; Distance between player and the other player's projectile
iPlInfo_ColiFlags                  EQU $53 ; Collision flags for Set A
iPlInfo_ColiBoxOverlapX            EQU $54 ; How much the collision boxes of the two players overlap, in px. Positive value, always identical between the two players. 
;--
; from master tbl
; [TCRF?] None of this is used in this game. These movement functions use hardcoded values instead, hinting
;         the feature wasn't quite finished (they are properly hooked up in 96).

; Word value must be positive
iPlInfo_SpeedX                     EQU $55 ; Horizontal movement speed when moving forwards or jumping (pixels)
iPlInfo_SpeedX_Sub                 EQU $56 ; Horizontal movement speed when moving forwards or jumping (subpixels)

; Word value must be negative
iPlInfo_BackSpeedX                 EQU $57 ; Horizontal movement speed when moving backwards. (pixels)
iPlInfo_BackSpeedX_Sub             EQU $58 ; Horizontal movement speed when moving backwards (subpixels)

; Word value must be negative
iPlInfo_JumpSpeed                  EQU $59 ; Vertical speed when starting a jump (pixels).
iPlInfo_JumpSpeed_Sub              EQU $5A ; Vertical speed when starting a jump (subpixels).

; Word value must be positive
iPlInfo_Gravity                    EQU $5B ; Gravity applied when jumping (pixels).
iPlInfo_Gravity_Sub                EQU $5C ; Gravity applied when jumping (subpixels).
;--
iPlInfo_TeamLossCount              EQU $5D ; Team Mode - Loss count. If it reaches 3 the stage ends.
iPlInfo_TeamCharId0                EQU $5E ; 1st team member ID (*2)
iPlInfo_TeamCharId1                EQU $5F ; 2nd team member ID (*2)
iPlInfo_TeamCharId2                EQU $60 ; 3rd team member ID (*2)
;--
; All of those marked as "Other" are copied of data from the other player.
; Additionally, those marked as "OBJInfo" come from the respective wOBJInfo struct.
iPlInfo_Flags0Other                EQU $61
iPlInfo_Flags1Other                EQU $62
iPlInfo_Flags2Other                EQU $63
iPlInfo_Flags3Other                EQU $64
iPlInfo_CharIdOther                EQU $65 ; Copy of iPlInfo_CharId
iPlInfo_MoveIdOther                EQU $66
iPlInfo_HitTypeIdOther             EQU $67
iPlInfo_MoveDamageValOther         EQU $68
iPlInfo_MoveDamageHitTypeIdOther   EQU $69
iPlInfo_MoveDamageFlags3Other      EQU $6A
iPlInfo_MoveDamageValNextOther     EQU $6B
iPlInfo_MoveDamageFlags3NextOther  EQU $6D
iPlInfo_NoThrowTimerOther          EQU $6E
iPlInfo_Unused_ThrowKeyTimerOther  EQU $6F
iPlInfo_PhysHitRecv                EQU $70 ; If set, marks that we've been directly hit by the other player (ie: not from a projectile)
iPlInfo_PushSpeedHRecv             EQU $71 ; Copied from the other player's iPlInfo_PushSpeedHReq.
iPlInfo_PushSpeedHReq              EQU $72 ; Horizontal push speed used for multiple purposes. ie: after receiving a hit when cornered. This is given to the other player to make him move out of the way.
iPlInfo_OBJInfoFlagsOther          EQU $73 ; Copy of iOBJInfo_OBJLstFlags
iPlInfo_OBJInfoXOther              EQU $74 ; Copy of iOBJInfo_X
iPlInfo_OBJInfoYOther              EQU $75 ; Copy of iOBJInfo_Y
iPlInfo_PowOther                   EQU $76

; CPU block
iPlInfo_CPUIdleTimer               EQU $7A ; Delays picking a new idle move. Until it elapses, the existing iPlInfo_CPUIdleMove is valid.
iPlInfo_CPUIdleMove                EQU $7B ; ID of the idle movement mode. (CMA_*)
iPlInfo_CPUWaitTimer               EQU $7D ; Delays CPU input logic until it elapses

iPlInfo_Benimaru_ShinkuuKatateGoma_LoopCount  EQU $77 ; Spinny attack loop
iPlInfo_Ryo_Zanretsuken_VShift                EQU $77 ; Opponent position is shifted up by this amount on hit
iPlInfo_Joe_Bakuretsuken_LoopFlag             EQU $77 ; If set, the attack loops
iPlInfo_Heidern_NeckRoller_LoopCount          EQU $77 ; Attack loop count
iPlInfo_Heidern_StormBringer_FromSuper        EQU $77 ; If $01, we're coming from the super move (which transitions to this move)
iPlInfo_Ralf_VulcanPunch_LoopCount            EQU $77 ;
iPlInfo_Athena_PsychoReflector_LoopCount      EQU $77 ;
iPlInfo_Athena_PsychoSword_77                 EQU $77 ; Not used
iPlInfo_Athena_ShCryst_LoopTimer              EQU $77 ; Phase 1 loop timer
iPlInfo_Kensou_RyuuGakuSai_FromSuper          EQU $77 ; If $01, we're coming from the super move (which transitions to this move)
iPlInfo_Rugal_DarkBarrier_LoopCount           EQU $77 ;
iPlInfo_Nakoruru_MamahahaFlight_Mode          EQU $77 ; Move mode, PBM_*
iPlInfo_Nakoruru_MamahahaFlight_TimeLeft      EQU $78 ; Flight timer, when it elapses, you hop off automatically.

iPlInfo_Hit_SwoopUp_OkSpeedY                  EQU $77

; D-Pad Move input (MoveInput_*)
; Format: <iMoveInput_Length>[<iMoveInputItem*> last, <iMoveInputItem*> last-1, ...]		
iMoveInput_Length                  EQU $00 ; Number of iMoveInputItem structures following this
iMoveInputItem_JoyKeys             EQU $01 ; Keys to press (JOY_*)
iMoveInputItem_JoyMaskKeys         EQU $02 ; Only these keys are checked from the input buffer
iMoveInputItem_MinLength           EQU $03 ; The key must be held >= this value
iMoveInputItem_MaxLength           EQU $04 ; The key must be held <= this value

iCPUMoveListItem_MoveInputPtr_Low  EQU $00 ; Ptr to any MoveInput_* structure, low byte
iCPUMoveListItem_MoveInputPtr_High EQU $01 ; Ptr to any MoveInput_* structure, high byte
iCPUMoveListItem_LastLHKeyA        EQU $02 ; iPlInfo_JoyNewKeysLH value, choice #0
iCPUMoveListItem_LastLHKeyB        EQU $03 ; iPlInfo_JoyNewKeysLH value, choice #1

; Sound channel data header (ROM)
; =============== SONG FORMAT ===============
iSndHeader_NumChannels             EQU $00 ; Number of channels (array of iSndChHeader structs comes next)
iSndChHeader_Status                EQU $00 ; Matches iSndInfo_Status and so on
iSndChHeader_RegPtr                EQU $01
iSndChHeader_DataPtr_Low           EQU $02
iSndChHeader_DataPtr_High          EQU $03
iSndChHeader_FreqDataIdBase        EQU $04
iSndChHeader_Unused5               EQU $05

; Sound channel info (RAM)
iSndInfo_Status                    EQU $00 ; SndInfo status bitmask
iSndInfo_RegPtr                    EQU $01 ; Determines sound channel. Always points to rNR*3, and is never changed after being set.
iSndInfo_DataPtr_Low               EQU $02 ; Pointer to song data (low byte)
iSndInfo_DataPtr_High              EQU $03 ; Pointer to song data (high byte)
iSndInfo_FreqDataIdBase            EQU $04 ; Base index/note id to Sound_FreqDataTbl for indexes > 0
iSndInfo_Unused05                  EQU $05 ; Unused. Always $81 unless audio is interrupted.
iSndInfo_DataPtrStackIdx           EQU $06 ; Stack index for data pointers saved and restored by Sound_Cmd_Call and Sound_Cmd_Ret. Initialized to $20 (end of SndInfo) and decremented on pushes.
iSndInfo_LengthTarget              EQU $07 ; Handles delays -- the current sound register settings are kept until it matches iSndInfo_LengthTarget Set by song data.
iSndInfo_LengthTimer               EQU $08 ; Increases every time a SndInfo isn't paused/disabled. Once it reaches iSndInfo_LengthTarget it resets.
iSndInfo_LengthTimerSub            EQU $09 ; Subframe timer for the above.
iSndInfo_Unknown_Unused_0A         EQU $0A ; Unknown, only used in an unused command.
iSndInfo_RegNRx1Data               EQU $0B ; Last value written to rNR*1 | $FF00+(iSndInfo_RegPtr-2). Only written by Command IDs -- this isn't updated by the standard Sound_UpdateCustomRegs.
iSndInfo_Unknown_Unused_NR10Data   EQU $0C ; Last value written to NR10 by the unused sound command Sound_Cmd_Unused_WriteToNR10.
iSndInfo_VolPredict                EQU $0D ; "Volume timer" which predicts the effective volume level (due to sweeps) at any given frame, used when restoring BGM playback. Low nybble is the timer, upper nybble is the predicted volume.
iSndInfo_RegNRx2Data               EQU $0E ; Last value written to rNR*2 | $FF00+(iSndInfo_RegPtr-1)
iSndInfo_RegNRx3Data               EQU $0F ; Last value written to rNR*3 | $FF00+(iSndInfo_RegPtr)
iSndInfo_RegNRx4Data               EQU $10 ; Last value written to rNR*4 | $FF00+(iSndInfo_RegPtr+1)
iSndInfo_ChEnaMask                 EQU $11 ; Default rNR51 bitmask, used when a sound channel is enabled
iSndInfo_WaveSetId                 EQU $12 ; Id of last wave set loaded
iSndInfo_LoopTimerTbl              EQU $13 ; Table with timers counting down, used to determine how many times to "jump" the data pointer elsewhere before continuing.
iSndInfo_End                       EQU $20 ; Pointer stack moving up