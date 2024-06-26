; Keys (as bit numbers)
DEF KEYB_RIGHT       EQU 0
DEF KEYB_LEFT        EQU 1
DEF KEYB_UP          EQU 2
DEF KEYB_DOWN        EQU 3
DEF KEYB_A           EQU 4
DEF KEYB_B           EQU 5
DEF KEYB_SELECT      EQU 6
DEF KEYB_START       EQU 7

; Keys (values)
DEF KEY_NONE         EQU 0
DEF KEY_RIGHT        EQU 1 << KEYB_RIGHT
DEF KEY_LEFT         EQU 1 << KEYB_LEFT
DEF KEY_UP           EQU 1 << KEYB_UP
DEF KEY_DOWN         EQU 1 << KEYB_DOWN
DEF KEY_A            EQU 1 << KEYB_A
DEF KEY_B            EQU 1 << KEYB_B
DEF KEY_SELECT       EQU 1 << KEYB_SELECT
DEF KEY_START        EQU 1 << KEYB_START

; Flags for iPlInfo_JoyNewKeysLH in the upper nybble
; (low nybble is the same as KEYB_*)
DEF KEPB_A_LIGHT EQU 4 ; A button pressed and released before 6 frames
DEF KEPB_B_LIGHT EQU 5 ; B button pressed and released before 6 frames
DEF KEPB_A_HEAVY EQU 6 ; A button held for 6 frames
DEF KEPB_B_HEAVY EQU 7 ; B button held for 6 frames
DEF KEP_A_LIGHT EQU 1 << KEPB_A_LIGHT
DEF KEP_B_LIGHT EQU 1 << KEPB_B_LIGHT
DEF KEP_A_HEAVY EQU 1 << KEPB_A_HEAVY
DEF KEP_B_HEAVY EQU 1 << KEPB_B_HEAVY

IF VER_EN
DEF CMLB_BTN EQU 0 ; For iCPUMoveListItem_LastLHKeyA. 
               ; If set, the MoveInput iCPUMoveListItem_MoveInputPtr points to contains button (LH) keys.
               ; If clear, it contains directional keys.
DEF CML_BTN EQU 1 << CMLB_BTN
ELSE
DEF CML_BTN EQU 0 ; Disabled
ENDC

; CPU idle actions
DEF CMA_MOVEF  EQU $00 ; Move or run forwads
DEF CMA_MOVEB  EQU $01 ; Move or hop backwards
DEF CMA_CHARGE EQU $02 ; Charge meter
DEF CMA_NONE   EQU $FF ; Nothing. Player stands still.

DEF DIFFICULTY_EASY		EQU $00
DEF DIFFICULTY_NORMAL	EQU $01
DEF DIFFICULTY_HARD		EQU $02

DEF BORDER_NONE			EQU $00
DEF BORDER_MAIN 		EQU $01
DEF BORDER_ALTERNATE 	EQU $02

DEF TIMER_INFINITE		EQU $FF

DEF MODEB_TEAM    EQU 0
DEF MODEB_VS      EQU 1
DEF MODE_SINGLE1P EQU $00
DEF MODE_TEAM1P   EQU $01
DEF MODE_SINGLEVS EQU $02
DEF MODE_TEAMVS   EQU $03

; Player IDs used across multiple variables
DEF PL1  EQU $00		
DEF PL2  EQU $01
DEF PLB1 EQU 0 ; $01
DEF PLB2 EQU 1 ; $02

; Character IDs
DEF CHAR_ID_KYO      EQU $00
DEF CHAR_ID_BENIMARU EQU $02
DEF CHAR_ID_RYO      EQU $04
DEF CHAR_ID_YURI     EQU $06
DEF CHAR_ID_TERRY    EQU $08
DEF CHAR_ID_JOE      EQU $0A
DEF CHAR_ID_HEIDERN  EQU $0C
DEF CHAR_ID_RALF     EQU $0E
DEF CHAR_ID_ATHENA   EQU $10
DEF CHAR_ID_KENSOU   EQU $12
DEF CHAR_ID_KIM      EQU $14
DEF CHAR_ID_MAI      EQU $16
DEF CHAR_ID_IORI     EQU $18
DEF CHAR_ID_EIJI     EQU $1A
DEF CHAR_ID_BILLY    EQU $1C
DEF CHAR_ID_SAISYU   EQU $1E
DEF CHAR_ID_RUGAL    EQU $20
DEF CHAR_ID_NAKORURU EQU $22
DEF CHAR_COUNT       EQU (CHAR_ID_NAKORURU/2)+1 ; Total characters
DEF CHAR_ID_NONE     EQU $FF

DEF STAGE_ID_00 EQU $00
DEF STAGE_ID_01 EQU $01
DEF STAGE_ID_02 EQU $02
DEF STAGE_ID_03 EQU $03
DEF STAGE_ID_04 EQU $04
DEF STAGE_ID_05 EQU $05
DEF STAGE_ID_06 EQU $06

; Special hardcoded stages for bosses or secrets.
; They match the character IDs here.
DEF STAGESEQ_SAISYU     EQU CHAR_ID_SAISYU / 2
DEF STAGESEQ_RUGAL      EQU CHAR_ID_RUGAL / 2
DEF STAGESEQ_NAKORURU   EQU CHAR_ID_NAKORURU / 2

DEF PLAY_BORDER_X       EQU $08 ; Threshold value for being treated as being on the wall.
DEF OBJLSTPTR_NONE      EQU $FFFF ; Placeholder pointer that marks the lack of a secondary sprite mapping and the end separator
DEF OBJLSTPTR_ENTRYSIZE EQU $04 ; Size of each OBJLstPtrTable entry (pair of OBJLstHdrA_* and OBJLstHdrB_* pointers)
DEF ANIMSPEED_INSTANT   EQU $00 ; Close enough
DEF ANIMSPEED_NONE      EQU $FF ; Slowest possible animation speed, set when we want manual control over the animation since it will always be done quicker than 255 frames.

; FLAGS
DEF DIPB_EASY_MOVES       EQU 2 ; SELECT + A/B for easy super moves
DEF DIPB_POWERUP          EQU 2 ; Powered up moves. Tied to DIPB_EASY_MOVES in this game.
DEF DIPB_MAXPOW           EQU 3 ; Unlimited POW Meter + infinite Mamahaha flight 
DEF DIPB_SGB_SOUND_TEST   EQU 4 ; Adds SGB S.E TEST to the options menu
DEF DIPB_TEAM_DUPL        EQU 5 ; Allow duplicate characters in a team
DEF DIPB_UNLOCK_BOSS      EQU 6 ; Unlock Saisyu/Rugal
DEF DIPB_UNLOCK_OTHER     EQU 7 ; Unlock everyone else (Mr Karate, Boss Kagura, Orochi Iori and Orochi Leona)

; $C61C (aka "C025")
DEF MISCB_SERIAL_LAG      EQU 3 ; If set, it freezes the game. Essentially a version of MISCB_LAG_FRAME for the other GB.
                                ; Used to force the slave to wait (and not read new player inputs) until the master sends new bytes.
DEF MISCB_SERIAL_SLAVE    EQU 5 ; If set, the GB is the slave (matches PL2), otherwise it's the master (PL1)
DEF MISCB_SERIAL_MODE     EQU 6 ; Marks a VS battle through serial cable. Not in SGB mode.
DEF MISCB_IS_SGB          EQU 7 ; Enables SGB features
; $C61D (aka "C026")
DEF MISCB_LAG_FRAME       EQU 3 ; Is set when the task cycler is called, and unset right before the VBlank wait loop.
; $C61E (aka "C027")
DEF MISCB_PLAY_STOP       EQU 7 ; If set, the game stops processing input and the timer. Used on the intro and when a round ends.
; $C61F (aka "C028")
DEF MISCB_USE_SECT        EQU 1 ; If set, the screen uses the three-section mode (SetSectLYC was called). Otherwise there's a single section governed by hScrollX and hScrollY.
                                ; In this game, it shares the same bit as MISCB_PL_RANGE_CHECK.
                                ; In 96 this was moved to bit 0, but curiously enough, code there still tends to clear bit 1
                                ; when the presumed intention is to disable the three-section mode.		
DEF MISCB_PL_RANGE_CHECK  EQU 1 ; Enables the player range enforcement, which is part of the sprite drawing routine.
DEF MISCB_TITLE_SECT      EQU 2 ; Allows parallax for the title screen

DEF MISC_USE_SECT         EQU 1 << MISCB_USE_SECT
;--
DEF TXCB_INSTANT EQU 7 ; If set, instant text printing was enabled

DEF OBJINFO_SIZE     EQU $40 ; wOBJInfo size
DEF GFXBUF_TILECOUNT EQU $20 ; Number of tiles in a GFX buffer

; iOBJInfo_Status bits
DEF OSTB_GFXLOAD    EQU 0 ; If set, the graphics are still being copied to the *opposite* buffer than the current one at OSTB_GFXBUF2
DEF OSTB_GFXBUF2    EQU 1 ; If set, the second GFX buffer is used for the *current* frame
DEF OSTB_GFXNEWLOAD EQU 3 ; If set, the graphics have just finished loading. Effectively valid for 1 frame only, since the animation routines resets it.
DEF OSTB_ANIMEND    EQU 4 ; Animation has ended, repeat last frame indefinitely
DEF OSTB_XFLIP      EQU 5 ; Horizontal flip
DEF OSTB_YFLIP      EQU 6 ; Vertical flip
DEF OSTB_VISIBLE    EQU 7 ; If not set, the sprite mapping is hidden

DEF OST_GFXLOAD     EQU 1 << OSTB_GFXLOAD
DEF OST_GFXBUF2     EQU 1 << OSTB_GFXBUF2
DEF OST_GFXNEWLOAD  EQU 1 << OSTB_GFXNEWLOAD
DEF OST_ANIMEND     EQU 1 << OSTB_ANIMEND
DEF OST_XFLIP       EQU 1 << OSTB_XFLIP
DEF OST_YFLIP       EQU 1 << OSTB_YFLIP
DEF OST_VISIBLE     EQU 1 << OSTB_VISIBLE

; Additional iOBJInfo_OBJLstFlags for internal purposes.
; These aren't related to the hardware flags.
DEF SPRXB_BIT0 EQU 0
DEF SPRXB_BIT1 EQU 1
DEF SPRXB_OTHERPROJR EQU 2 ; If set, the other player's projectile is on the right
DEF SPRXB_PLDIR_R EQU 3 ; If set, the player is internally facing right (nonvisual equivalent of the X flip flag)


; OBJLST / SPRITE MAPPINGS FLAGS from ROM
; These are almost the same as the iOBJInfo_OBJLstFlags* bits.
; iOBJLstHdrA_Flags / iOBJLstHdrB_Flags
DEF OLFB_USETILEFLAGS EQU 4 ; If set, in the OBJ data, the upper two bits of a tile ID count as X/Y flip flags
DEF OLFB_XFLIP        EQU 5 ; User-controlled
DEF OLFB_YFLIP        EQU 6
DEF OLFB_NOBUF        EQU 7 ; Sprite mapping doesn't use the buffer copy

DEF OLF_USETILEFLAGS EQU 1 << OLFB_USETILEFLAGS ; $10
DEF OLF_XFLIP        EQU 1 << OLFB_XFLIP ; $20
DEF OLF_YFLIP        EQU 1 << OLFB_YFLIP ; $40
DEF OLF_NOBUF        EQU 1 << OLFB_NOBUF

; Raw versions of the above from inside the ROM, which are shifted up before getting converted
DEF OLR_XFLIP EQU OLF_XFLIP << 1
DEF OLR_YFLIP EQU OLF_YFLIP << 1

; iOBJInfo_Play_HitMode
DEF PHM_NONE    EQU $00
DEF PHM_REMOVE  EQU $01
DEF PHM_REFLECT EQU $02


DEF TASK_SIZE EQU $08

; Task types
DEF TASK_EXEC_NONE EQU $00 ; No task here
DEF TASK_EXEC_DONE EQU $01 ; Already executed this frame
DEF TASK_EXEC_CUR  EQU $02 ; Currently executing
DEF TASK_EXEC_TODO EQU $04 ; Not executed yet, but was executed previously already. Stack pointer type.
DEF TASK_EXEC_NEW  EQU $08 ; Never executed before. Likely init code which will set a new task. Jump HL type.

DEF PLINFO_SIZE EQU $100

; Note that there isn't a single flag marking if we got hit and damaged.
; A combination of at least one of these is checked:
; PCFB_HIT -> opponent collided with our hitbox (the move can still whiff)
; PF1B_INVULN -> Invulnerability
; PF1B_HITRECV -> damage string, aka hit received (definitely no whiff)
; PF1B_GUARD -> blocked the hit
; Moves that manually check for collision tend to handle them like this, generally for
; attacks where the player moves forward until colliding with the player:
; - PCFB_HIT = 0 or PF1B_INVULN = 1 -> not hit yet
; - PF1B_HITRECV = 1 and PF1B_GUARD = 1 -> opponent blocked the attack (from last frame)
; - PF1B_HITRECV = 1 and PF1B_GUARD = 0 -> opponent got hit successfully (from last frame)

; iPlInfo_Flags0 flags
DEF PF0B_PROJ           EQU 0 ; If set, a projectile is active on-screen (ie: a new one can't be thrown)
DEF PF0B_SPECMOVE       EQU 1 ; If set, the player is performing a special move
DEF PF0B_AIR            EQU 2 ; If set, the player is in the air
DEF PF0B_PROJHIT        EQU 3 ; If set, the player got hit by a projectile
DEF PF0B_PROJREM        EQU 4 ; If set, the player can currently remove projectiles with its hitbox
DEF PF0B_PROJREFLECT    EQU 5 ; If set, the player can currently reflect projectiles with its hitbox
DEF PF0B_SUPERMOVE      EQU 6 ; If set, the player is performing a super move
DEF PF0B_CPU            EQU 7 ; If set, the player is CPU-controlled (1P mode) or autopicks characters (VS mode)
DEF PF0_SPECMOVE        EQU 1 << PF0B_SPECMOVE
DEF PF0_PROJREM         EQU 1 << PF0B_PROJREM
DEF PF0_PROJREFLECT     EQU 1 << PF0B_PROJREFLECT
DEF PF0_SUPERMOVE       EQU 1 << PF0B_SUPERMOVE
DEF PF0_CPU             EQU 1 << PF0B_CPU

; iPlInfo_Flags1 flags
DEF PF1B_NOBASICINPUT   EQU 0 ; Prevents basic input from being handled. See also: BasicInput_ChkDDDDDDDDD
DEF PF1B_XFLIPLOCK      EQU 1 ; Locks the direction the player is facing
DEF PF1B_NOSPECSTART    EQU 2 ; If set, the current move can't be cancelled into a new special.
                              ; Primarily used to prevent starting new specials during certain non-special moves (rolling, taking damage, ...)+
                              ; though starting specials also sets this for consistency.
                              ; Overridden by PF1B_ALLOWHITCANCEL.
DEF PF1B_GUARD          EQU 3 ; If set, the player is guarding, and will receive less damage on hit.
                              ; Primarily set when blocking, but some special moves set this as well to have the same effects as blocking when getting hit out of them.
DEF PF1B_HITRECV        EQU 4 ; If set, the player is on the receiving end of a damage string.
                              ; This is set when the player is attacked at least once (hit or blocked), and
                              ; resets on its own if not cancelling the attack into one that hits.
DEF PF1B_CROUCH         EQU 5 ; If set, the player is crouching
DEF PF1B_ALLOWHITCANCEL EQU 6 ; If set, it's possible to cancel a move into a new special, set after hitting the opponent. This bypasses PF1B_NOSPECSTART.
DEF PF1B_INVULN         EQU 7 ; If set, the player is completely invulnerable. 
    						  ; This value isn't always checked during collision -- phyisical hurtbox collisions pass,
    						  ; but they are blocked before they can deal damage.
; iPlInfo_Flags2 flags
DEF PF2B_MOVESTART      EQU 0 ; Marks that a new move has been set
DEF PF2B_HEAVY          EQU 1 ; To distinguish between light/heavy when starting an attack
DEF PF2B_NODAMAGERATE   EQU 2 ; If set, it disables the damage rate limit. (only the case when special canceling a move, before the first hit triggers)
DEF PF2B_NOHURTBOX      EQU 6 ; If set, the player has no hurtbox (this separate from the collision box only here)
DEF PF2B_NOCOLIBOX      EQU 7 ; If set, the player has no collision box
; iPlInfo_Flags3, related to the move we got attacked with
DEF PF3B_HEAVYHIT       EQU 0 ; Used by "heavy" hits (not to be confused with heavy moves). Getting attacked shakes the player longer (doesn't cut the shake count in half).
DEF PF3B_FIRE           EQU 1 ; Used by firey hits. Getting hit causes the player to flash slowly.
DEF PF3B_HITLOW         EQU 2 ; The attack hits low (must block crouching)
DEF PF3B_OVERHEAD       EQU 3 ; The attack is an overhead (must block standing)
DEF PF3B_CONTHIT        EQU 4 ; For HitTypeC_Drop* only. If set, the combo string can continue (can juggle), otherwise the opponent is made invulnerable until wakeup.
DEF PF3B_HALFSPEED      EQU 5 ; Getting hit runs the game at half speed
DEF PF3B_SUPERALT       EQU 6 ; Used by a few super moves to make them use an alternate palette cycle.
DEF PF3B_LIGHTHIT       EQU 7 ; Used by "light" hits (not to be confused with light moves). Getting attacked shakes the player once.

DEF PF3_HEAVYHIT        EQU 1 << PF3B_HEAVYHIT   
DEF PF3_FIRE            EQU 1 << PF3B_FIRE
DEF PF3_HITLOW          EQU 1 << PF3B_HITLOW      
DEF PF3_OVERHEAD        EQU 1 << PF3B_OVERHEAD      
DEF PF3_CONTHIT         EQU 1 << PF3B_CONTHIT        
DEF PF3_HALFSPEED       EQU 1 << PF3B_HALFSPEED        
DEF PF3_SUPERALT        EQU 1 << PF3B_SUPERALT
DEF PF3_LIGHTHIT        EQU 1 << PF3B_LIGHTHIT   

; Flags for iPlInfo_ColiFlags
; One half is for our collision status, the other is for the opponent.

DEF PCFB_PUSHED       EQU 0 ; Player is being pushed 
DEF PCFB_HITOTHER     EQU 1 ; The other player got hit (hitbox collided, though it can't be used alone as the opponent may be invulnerable)
DEF PCFB_PROJHITOTHER EQU 2 ; The other player got hit by a projectile
DEF PCFB_PROJREMOTHER EQU 3 ; The other player removed/reflected a projectile
DEF PCFB_PUSHEDOTHER  EQU 4 ; The other player is being pushed
DEF PCFB_HIT          EQU 5 ; Player is hit by a physical attack (hitbox collided, though it can't be used alone as the player may be invulnerable)
DEF PCFB_PROJHIT      EQU 6 ; Player is by a projectile
DEF PCFB_PROJREM      EQU 7 ; Player removed/reflected a projectile

DEF PCF_PUSHED        EQU 1 << PCFB_PUSHED
DEF PCF_HITOTHER      EQU 1 << PCFB_HITOTHER
DEF PCF_PROJHITOTHER  EQU 1 << PCFB_PROJHITOTHER
DEF PCF_PROJREMOTHER  EQU 1 << PCFB_PROJREMOTHER
DEF PCF_PUSHEDOTHER   EQU 1 << PCFB_PUSHEDOTHER
DEF PCF_HIT           EQU 1 << PCFB_HIT
DEF PCF_PROJHIT       EQU 1 << PCFB_PROJHIT
DEF PCF_PROJREM       EQU 1 << PCFB_PROJREM

DEF SNDIDREQ_SIZE      EQU $08
DEF SNDINFO_SIZE       EQU $20 ; Size of iSndInfo struct
DEF SND_CH1_PTR        EQU LOW(rNR13)
DEF SND_CH2_PTR        EQU LOW(rNR23)
DEF SND_CH3_PTR        EQU LOW(rNR33)
DEF SND_CH4_PTR        EQU LOW(rNR43)

; iSndInfo_Status
DEF SISB_PAUSE            EQU 0 ; If set, iSndInfo processing is paused for that channel
DEF SISB_SKIPNRx2         EQU 1 ; If set, rNR*2 won't be updated
DEF SISB_USEDBYSFX        EQU 2 ; wBGMCh*Info only. If set, it marks that a sound effect is currently using the channel.
DEF SISB_SFX              EQU 3 ; If set, the SndInfo is handled as a sound effect. If clear, it's a BGM.
DEF SISB_UNUSED_6         EQU 6 ; Not used, only set by the Game Over song.
DEF SISB_ENABLED          EQU 7 ; If set, iSndInfo processing is enabled for that channel

DEF SIS_PAUSE             EQU 1 << SISB_PAUSE
DEF SIS_SKIPNRx2          EQU 1 << SISB_SKIPNRx2    
DEF SIS_USEDBYSFX         EQU 1 << SISB_USEDBYSFX   
DEF SIS_SFX               EQU 1 << SISB_SFX         
DEF SIS_UNUSED_6          EQU 1 << SISB_UNUSED_6
DEF SIS_ENABLED           EQU 1 << SISB_ENABLED 

; wSndFadeStatus, never used basically
DEF SFDB_FADEOUT          EQU 0 ; If set, the song fades out
DEF SFDB_FADEOUTDONE      EQU 1 ; If set, the song has finished fading out
DEF SFDB_UNUSED_2         EQU 2 ; Not used
DEF SFDB_FADEIN           EQU 4 ; If set, the song fades it
DEF SFDB_FADEINPROC       EQU 5 ; Used to only execute once some fade in code.
DEF SFDB_FADEINDONE       EQU 6 ; If set, the song has finished fading in

DEF SNDCMD_BASE           EQU $E0
DEF SNDNOTE_BASE          EQU $80

;--------------

; DMG Sound List
DEF SND_MUTE              EQU $00
DEF SND_BASE              EQU $80
DEF SND_NONE              EQU SND_BASE+$00

DEF BGM_NAKORURU          EQU SND_BASE+$01
DEF BGM_CHARSELECT        EQU SND_BASE+$02
DEF BGM_INTRO             EQU SND_BASE+$03
DEF BGM_BOSS              EQU SND_BASE+$04
DEF BGM_STAGECLEAR        EQU SND_BASE+$05
DEF BGM_CUTSCENE0         EQU SND_BASE+$06
DEF BGM_CUTSCENE1         EQU SND_BASE+$07
DEF BGM_GAMEOVER          EQU SND_BASE+$08
DEF BGM_CREDITS           EQU SND_BASE+$09
DEF BGM_STAGE             EQU SND_BASE+$0A
DEF BGM_ENDING            EQU SND_BASE+$0B
;DEF SND_ID_8C EQU SND_BASE+$0C
;DEF SND_ID_8D EQU SND_BASE+$0D
;DEF SND_ID_8E EQU SND_BASE+$0E
;DEF SND_ID_8F EQU SND_BASE+$0F
;DEF SND_ID_90 EQU SND_BASE+$10
;DEF SND_ID_91 EQU SND_BASE+$11
;DEF SND_ID_92 EQU SND_BASE+$12
;DEF SND_ID_93 EQU SND_BASE+$13
;DEF SND_ID_94 EQU SND_BASE+$14
;DEF SND_ID_95 EQU SND_BASE+$15
;DEF SND_ID_96 EQU SND_BASE+$16
;DEF SND_ID_97 EQU SND_BASE+$17
;DEF SND_ID_98 EQU SND_BASE+$18
;DEF SND_ID_99 EQU SND_BASE+$19
;DEF SND_ID_9A EQU SND_BASE+$1A
;DEF SND_ID_9B EQU SND_BASE+$1B
;DEF SND_ID_9C EQU SND_BASE+$1C
;DEF SND_ID_9D EQU SND_BASE+$1D
;DEF SND_ID_9E EQU SND_BASE+$1E
;DEF SND_ID_9F EQU SND_BASE+$1F
DEF SFX_CURSORMOVE        EQU SND_BASE+$20
DEF SFX_CHARSELECTED      EQU SND_BASE+$21
DEF SFX_HIT               EQU SND_BASE+$22
DEF SFX_UNUSED_HEAVYHIT   EQU SND_BASE+$23
DEF SFX_FIREHIT           EQU SND_BASE+$24
DEF SFX_BLOCK             EQU SND_BASE+$25
DEF SFX_GROUNDHIT         EQU SND_BASE+$26
DEF SFX_LIGHT             EQU SND_BASE+$27
DEF SFX_HEAVY             EQU SND_BASE+$28
DEF SFX_TAUNT             EQU SND_BASE+$29
DEF SFX_STEP              EQU SND_BASE+$2A
DEF SFX_JUMP              EQU SND_BASE+$2B
DEF SFX_UNUSED_BOMB       EQU SND_BASE+$2C
DEF SFX_UNUSED_BOUNCE     EQU SND_BASE+$2D
DEF SFX_CHARGEMETER       EQU SND_BASE+$2E
DEF SFX_UNUSED_STEP_B     EQU SND_BASE+$2F
DEF SFX_SPECIAL           EQU SND_BASE+$30
DEF SFX_UNUSED_SPECIAL_B  EQU SND_BASE+$31
DEF SFX_REFLECT           EQU SND_BASE+$32
DEF SFX_ERROR             EQU SND_BASE+$33
DEF SFX_BARRIER           EQU SND_BASE+$34
DEF SFX_PROJ_LG           EQU SND_BASE+$35
DEF SFX_DIZZY             EQU SND_BASE+$36
;DEF SND_ID_B7 EQU SND_BASE+$37
;DEF SND_ID_B8 EQU SND_BASE+$38
;DEF SND_ID_B9 EQU SND_BASE+$39
;DEF SND_ID_BA EQU SND_BASE+$3A
;DEF SND_ID_BB EQU SND_BASE+$3B
;DEF SND_ID_BC EQU SND_BASE+$3C
;DEF SND_ID_BD EQU SND_BASE+$3D
;DEF SND_ID_BE EQU SND_BASE+$3E
;DEF SND_ID_BF EQU SND_BASE+$3F
;DEF SND_ID_C0 EQU SND_BASE+$40
;DEF SND_ID_C1 EQU SND_BASE+$41
;DEF SND_ID_C2 EQU SND_BASE+$42
;DEF SND_ID_C3 EQU SND_BASE+$43
;DEF SND_ID_C4 EQU SND_BASE+$44
;DEF SND_ID_C5 EQU SND_BASE+$45
;DEF SND_ID_C6 EQU SND_BASE+$46
;DEF SND_ID_C7 EQU SND_BASE+$47
;DEF SND_ID_C8 EQU SND_BASE+$48
;DEF SND_ID_C9 EQU SND_BASE+$49
;DEF SND_ID_CA EQU SND_BASE+$4A
;DEF SND_ID_CB EQU SND_BASE+$4B
;DEF SND_ID_CC EQU SND_BASE+$4C
;DEF SND_ID_CD EQU SND_BASE+$4D
;DEF SND_ID_CE EQU SND_BASE+$4E
;DEF SND_ID_CF EQU SND_BASE+$4F
;DEF SND_ID_D0 EQU SND_BASE+$50
;DEF SND_ID_D1 EQU SND_BASE+$51
;DEF SND_ID_D2 EQU SND_BASE+$52
;DEF SND_ID_D3 EQU SND_BASE+$53
;DEF SND_ID_D4 EQU SND_BASE+$54
;DEF SND_ID_D5 EQU SND_BASE+$55
;DEF SND_ID_D6 EQU SND_BASE+$56
;DEF SND_ID_D7 EQU SND_BASE+$57
;DEF SND_ID_D8 EQU SND_BASE+$58
;DEF SND_ID_D9 EQU SND_BASE+$59
;DEF SND_ID_DA EQU SND_BASE+$5A
;DEF SND_ID_DB EQU SND_BASE+$5B
;DEF SND_ID_DC EQU SND_BASE+$5C
;DEF SND_ID_DD EQU SND_BASE+$5D
;DEF SND_ID_DE EQU SND_BASE+$5E

DEF SND_LAST_VALID        EQU SND_BASE+$5E ; Dunno why this late
DEF SNC_FADEOUT           EQU SND_BASE+$70

; Sound Action List (offset by 1, since $00 is handled as SND_NONE) 
DEF SCT_PROJ_SM           EQU $01 ; Medium Projectile thrown
DEF SCT_MOVEJUMP_A        EQU $02 ; Automatic jump as part of a special move
DEF SCT_MOVEJUMP_B        EQU $03 ; ""
DEF SCT_UNUSED_MOVEJUMP_C EQU $04 ; Unreferenced. Slotted in between other MOVEJUMPs though
DEF SCT_UNUSED_MOVEJUMP_D EQU $05 ; Unused copy of SCT_MOVEJUMP_A
DEF SCT_FIREHIT           EQU $06 ; Hit with PF3B_FIRE
DEF SCT_PROJ_LG_A         EQU $07 ; Large projectile spawned
DEF SCT_PHYSFIRE          EQU $08 ; Phyisical fire atttack
DEF SCT_PROJ_LG_B         EQU $09 ; Large projectile spawned
DEF SCT_GROUNDHIT         EQU $0A ; Hitting the ground and rebounding off it
DEF SCT_UNUSED_SWORD      EQU $0B ; Unused, SGB-only, mapped to SGB_SND_A_SWORDSWING_02
DEF SCT_MULTIHIT          EQU $0C ; In-between hits for move that hit multiple times
DEF SCT_TAUNT             EQU $0D ; Taunt
DEF SCT_SHCRYSTSPAWN      EQU $0E ; Shining Crystal Bit projectile spawned
DEF SCT_BARRIER           EQU $0F ; Barrier spawned (Athena or Rugal)
DEF SCT_REFLECT           EQU $10 ; Projectile reflected
DEF SCT_KIKOUHOU          EQU $11 ; Unique SFX for Eiji's Kikouhou

; Screen Palette IDs, passed to SGB_ApplyScreenPalSet 
DEF SCRPAL_INTRO          EQU $00
DEF SCRPAL_TAKARALOGO     EQU $01
DEF SCRPAL_TITLE          EQU $02
DEF SCRPAL_CHARSELECT     EQU $03
DEF SCRPAL_STAGECLEAR     EQU $04
DEF SCRPAL_STAGE_00       EQU $05
DEF SCRPAL_STAGE_01       EQU $06
DEF SCRPAL_STAGE_04       EQU $07
DEF SCRPAL_STAGE_02       EQU $08
DEF SCRPAL_STAGE_03       EQU $09
IF VER_EN
DEF SCRPAL_LAGUNALOGO     EQU $0A
ENDC

;
; MODE IDs & CONSTANTS
;

; ============================================================
; INTRO

DEF INTRO_OBJ_KYO            EQU $00
DEF INTRO_OBJ_IORI           EQU $01

; ============================================================
; TITLE SCREEN / MENUS

DEF GM_TITLE_TITLE          EQU $00
DEF GM_TITLE_TITLEMENU      EQU $02 
DEF GM_TITLE_MODESELECT     EQU $04
DEF GM_TITLE_OPTIONS        EQU $06

; SHARED
DEF TITLE_OBJ_PUSHSTART     EQU $00
DEF TITLE_OBJ_MENU          EQU $01
DEF TITLE_OBJ_CURSOR_R      EQU $02
DEF TITLE_OBJ_SNKCOPYRIGHT  EQU $03
DEF TITLE_OBJ_CURSOR_U      EQU $04

; TITLE
DEF TITLE_RESET_TIMER       EQU (30 << 8) | 60 ; 30 seconds

; TITLEMENU
DEF TITLEMENU_TO_TITLE      EQU $00
DEF TITLEMENU_TO_MODESELECT EQU $01
DEF TITLEMENU_TO_OPTIONS    EQU $02

; MODESELECT
DEF MODESELECT_ACT_EXIT     EQU $00
DEF MODESELECT_ACT_SINGLE1P EQU MODE_SINGLE1P+1
DEF MODESELECT_ACT_TEAM1P   EQU MODE_TEAM1P+1
DEF MODESELECT_ACT_SINGLEVS EQU MODE_SINGLEVS+1
DEF MODESELECT_ACT_TEAMVS   EQU MODE_TEAMVS+1

; Mode IDs sent out through the serial
DEF MODESELECT_SBCMD_IDLE     EQU $02
DEF MODESELECT_SBCMD_SINGLEVS EQU MODESELECT_ACT_SINGLEVS
DEF MODESELECT_SBCMD_TEAMVS   EQU MODESELECT_ACT_TEAMVS

; Implementation detail leads to this
DEF SERIAL_PL1_ID             EQU MODESELECT_SBCMD_IDLE
; SERIAL_PL2_ID is not a constant, but any val != $00 && != $02

; OPTIONS

; Main options
DEF OPTION_ITEM_TIME        EQU $00
DEF OPTION_ITEM_LEVEL       EQU $01
DEF OPTION_ITEM_BGMTEST     EQU $02
DEF OPTION_ITEM_SFXTEST     EQU $03
DEF OPTION_ITEM_SGBSNDTEST  EQU $04
DEF OPTION_ITEM_EXIT        EQU $05

; SGB sound test options
DEF OPTION_SITEM_ID_A       EQU $00
DEF OPTION_SITEM_BANK_A     EQU $01
DEF OPTION_SITEM_ID_B       EQU $02
DEF OPTION_SITEM_BANK_B     EQU $03


DEF OPTIONS_ACT_EXIT EQU $00
DEF OPTIONS_ACT_L EQU $01
DEF OPTIONS_ACT_R EQU $02
DEF OPTIONS_ACT_A EQU $03
DEF OPTIONS_ACT_B EQU $04

DEF OPTIONS_SACT_EXIT    EQU $00
DEF OPTIONS_SACT_UP      EQU $01
DEF OPTIONS_SACT_DOWN    EQU $02
DEF OPTIONS_SACT_A       EQU $03
DEF OPTIONS_SACT_B       EQU $04
DEF OPTIONS_SACT_SUBEXIT EQU $05

DEF OPTIONS_TIMER_MIN EQU $10
DEF OPTIONS_TIMER_INC EQU $10
DEF OPTIONS_TIMER_MAX EQU $90

DEF OPTION_MENU_NORMAL  EQU $00
DEF OPTION_MENU_SGBTEST EQU $02

; ============================================================
; CHARACTER SELECT

DEF CHARSEL_POSFB_DEFEATED EQU 7
DEF CHARSEL_POSF_DEFEATED EQU 1 << CHARSEL_POSFB_DEFEATED

DEF CHARSEL_MODE_SELECT    EQU $00
DEF CHARSEL_MODE_READY     EQU $02
DEF CHARSEL_MODE_CONFIRMED EQU $04

DEF CHARSEL_1P EQU $00
DEF CHARSEL_2P EQU $01	

DEF CHARSEL_TEAM_REMAIN EQU $00
DEF CHARSEL_TEAM_FILLED EQU $FF

DEF CHARSEL_GRID_W    EQU $06
DEF CHARSEL_GRID_H    EQU $03
DEF CHARSEL_GRID_SIZE EQU CHARSEL_GRID_W * CHARSEL_GRID_H

DEF CHARSEL_OBJ_CURSOR1P        EQU $00
DEF CHARSEL_OBJ_CURSOR2P        EQU $04
DEF CHARSEL_OBJ_CURSORCPU1P     EQU $08
DEF CHARSEL_OBJ_CURSORCPU2P     EQU $0C

; Fake 96 adjusts the positions of these to move them above the grid.
IF VER_96F
DEF BG_CHARSEL_P1ICON0 EQU $9861
DEF BG_CHARSEL_P1ICON1 EQU $9863
DEF BG_CHARSEL_P1ICON2 EQU $9865
DEF BG_CHARSEL_P2ICON0 EQU $9871
DEF BG_CHARSEL_P2ICON1 EQU $986F
DEF BG_CHARSEL_P2ICON2 EQU $986D

DEF BG_CHARSEL_P1NAME  EQU $98C1 ; Left side
DEF BG_CHARSEL_P2NAME  EQU $98D2 ; Right side

ELSE
DEF BG_CHARSEL_P1ICON0 EQU $99E1
DEF BG_CHARSEL_P1ICON1 EQU $99E3
DEF BG_CHARSEL_P1ICON2 EQU $99E5
DEF BG_CHARSEL_P2ICON0 EQU $99F1
DEF BG_CHARSEL_P2ICON1 EQU $99EF
DEF BG_CHARSEL_P2ICON2 EQU $99ED

DEF BG_CHARSEL_P1NAME  EQU $99A1 ; Left side
DEF BG_CHARSEL_P2NAME  EQU $99B2 ; Right side
ENDC

; Blank boxes with numbers
DEF TILE_CHARSEL_ICONEMPTY1 EQU $D1 ; $EC
DEF TILE_CHARSEL_ICONEMPTY2 EQU $D5 ; $F0
DEF TILE_CHARSEL_ICONEMPTY3 EQU $D9 ; $F4

DEF TILE_CHARSEL_P1ICON0 EQU $DD
DEF TILE_CHARSEL_P1ICON1 EQU $E1
DEF TILE_CHARSEL_P1ICON2 EQU $E5

DEF TILE_CHARSEL_P2ICON0 EQU $E9
DEF TILE_CHARSEL_P2ICON1 EQU $ED
DEF TILE_CHARSEL_P2ICON2 EQU $F1

; ============================================================
; ORDER SELECT
DEF ORDSEL_SEL0 EQU $00
DEF ORDSEL_SEL1 EQU $01
DEF ORDSEL_SELDONE EQU $02

; ============================================================
; GAMEPLAY

; Terminology:
; - F -> Forward
; - B -> Back
; - G -> Ground
; - C -> Crouch
; - A -> Air
; - L -> Light
; - H -> Heavy
; - S -> Super
; - N -> Near
; - M -> Far
; - I -> Neutral
; - X -> Non-Neutral

DEF MOVE_SHARED_NONE            EQU $00
DEF MOVE_SHARED_IDLE            EQU $02 ; Stand
DEF MOVE_SHARED_WALK_F          EQU $04 ; Walk forward
DEF MOVE_SHARED_WALK_B          EQU $06 ; Walk back
DEF MOVE_SHARED_CROUCH          EQU $08 ; Crouch
DEF MOVE_SHARED_CROUCHWALK_F    EQU $0A ; Crouch walk forwards
DEF MOVE_SHARED_JUMP_N          EQU $0C ; Neutral jump
DEF MOVE_SHARED_JUMP_F          EQU $0E ; Forward jump
DEF MOVE_SHARED_JUMP_B          EQU $10 ; Backwards jump
DEF MOVE_SHARED_BLOCK_G         EQU $12 ; Ground block / mid
DEF MOVE_SHARED_BLOCK_C         EQU $14 ; Crouch block / low
DEF MOVE_SHARED_HOP_F           EQU $16 ; Forward hop
DEF MOVE_SHARED_HOP_B           EQU $18 ; Backwards hop
DEF MOVE_SHARED_CHARGEMETER     EQU $1A ; Charge meter
DEF MOVE_SHARED_TAUNT           EQU $1C ; Taunt
DEF MOVE_SHARED_DODGE           EQU $1E ; Dodge
DEF MOVE_SHARED_WAKEUP          EQU $20 ; Get up
DEF MOVE_SHARED_DIZZY           EQU $22 ; Dizzy
DEF MOVE_SHARED_WIN             EQU $24 ; Win 
DEF MOVE_SHARED_LOST_TIMEOVER   EQU $26 ; Time over
DEF MOVE_SHARED_INTRO           EQU $28 ; Intro
; Basic attacks & Command Normals
DEF MOVE_SHARED_PUNCH_LN        EQU $2A ; Light punch (Near)
DEF MOVE_SHARED_PUNCH_HN        EQU $2C ; Heavy punch (Near)
DEF MOVE_SHARED_PUNCH_LM        EQU $2E ; Light punch (Far)
DEF MOVE_SHARED_PUNCH_HM        EQU $30 ; Heavy punch (Far)
DEF MOVE_SHARED_KICK_LN         EQU $32 ; Light kick (Near)
DEF MOVE_SHARED_KICK_HN         EQU $34 ; Heavy kick (Near)
DEF MOVE_SHARED_KICK_LM         EQU $36 ; Light kick (Far)
DEF MOVE_SHARED_KICK_HM         EQU $38 ; Heavy kick (Far)
DEF MOVE_SHARED_PUNCH_CL        EQU $3A ; Crouch punch light
DEF MOVE_SHARED_PUNCH_CH        EQU $3C ; Crouch punch heavy
DEF MOVE_SHARED_KICK_CL         EQU $3E ; Crouch kick light
DEF MOVE_SHARED_KICK_CH         EQU $40 ; Crouch kick heavy
DEF MOVE_SHARED_DODGE_COUNTER   EQU $42 ; Dodge Counter
DEF MOVE_SHARED_STRIKE          EQU $44 ; Ground A + B + Forward (Strike attack)
DEF MOVE_SHARED_PUNCH_FH        EQU $46 ; Heavy punch (Forward)
DEF MOVE_SHARED_KICK_FH         EQU $48 ; Heavy kick (Forward)
DEF MOVE_SHARED_KICK_FCH        EQU $4A ; Crouch kick heavy (Forward)
DEF MOVE_SHARED_PUNCH_ALI       EQU $4C ; Air light punch (Neutral)
DEF MOVE_SHARED_PUNCH_AHI       EQU $4E ; Air heavy punch (Neutral)
DEF MOVE_SHARED_KICK_ALI        EQU $50 ; Air light kick (Neutral)
DEF MOVE_SHARED_KICK_AHI        EQU $52 ; Air heavy kick (Neutral)
DEF MOVE_SHARED_PUNCH_ALX       EQU $54 ; Air light punch (Non-Neutral)
DEF MOVE_SHARED_PUNCH_AHX       EQU $56 ; Air heavy punch (Non-Neutral)
DEF MOVE_SHARED_KICK_ALX        EQU $58 ; Air light kick (Non-Neutral)
DEF MOVE_SHARED_KICK_AHX        EQU $5A ; Air heavy kick (Non-Neutral)
DEF MOVE_SHARED_ATTACK_A        EQU $5C ; Air A + B
DEF MOVE_SHARED_PUNCH_AHD       EQU $5E ; Air heavy punch (Downward)
DEF MOVE_SHARED_KICK_AHD        EQU $60 ; Air heavy kick (Downward)
DEF MOVE_SHARED_KICK_AHB        EQU $62 ; Air heavy kick (Backward)
; Specials (placeholders)
DEF MOVE_SPEC_0_L               EQU $64
DEF MOVE_SPEC_0_H               EQU $66
DEF MOVE_SPEC_1_L               EQU $68
DEF MOVE_SPEC_1_H               EQU $6A
DEF MOVE_SPEC_2_L               EQU $6C
DEF MOVE_SPEC_2_H               EQU $6E
DEF MOVE_SPEC_3_L               EQU $70
DEF MOVE_SPEC_3_H               EQU $72
DEF MOVE_SPEC_4_L               EQU $74
DEF MOVE_SPEC_4_H               EQU $76
DEF MOVE_SPEC_5_L               EQU $78
DEF MOVE_SPEC_5_H               EQU $7A
DEF MOVE_SPEC_6_L               EQU $7C
DEF MOVE_SPEC_6_H               EQU $7E
DEF MOVE_SHARED_SUPER           EQU $80
; Throws
DEF MOVE_SHARED_THROW_G         EQU $82 ; Ground throw
DEF MOVE_SHARED_THROW_A         EQU $84 ; Air throw
; Attacked
DEF MOVE_SHARED_POST_BLOCKSTUN  EQU $86 ; After blockstun knockback
DEF MOVE_SHARED_HIT0MID         EQU $88 ; Mid Hit #0
DEF MOVE_SHARED_HIT1MID         EQU $8A ; Mid Hit #1
DEF MOVE_SHARED_HITLOW          EQU $8C ; Low Hit
DEF MOVE_SHARED_LAUNCH_UB       EQU $8E ; Up-Back launch/throw arc
DEF MOVE_SHARED_LAUNCH_DB_SHAKE EQU $90 ; Down-Back launch/throw arc, shake screen when hitting the ground
DEF MOVE_SHARED_LAUNCH_SWOOPUP  EQU $92 ; Straight up launch/throw arc
DEF MOVE_SHARED_HIT_SWEEP       EQU $94 ; Hit by crouching heavy kick (fell off)
DEF MOVE_SHARED_LAUNCH_UB_REC   EQU $96 ; Up-Back launch with mid-air recovery.
DEF MOVE_SHARED_HIT_MULTIMID0   EQU $98 ; Multi-hit special move, pre-last hit #0
DEF MOVE_SHARED_HIT_MULTIMID1   EQU $9A ; Multi-hit special move, pre-last hit #1
DEF MOVE_SHARED_LAUNCH_UB_SHAKE EQU $9C ; Up-Back launch/throw arc, shake screen when hitting the ground
DEF MOVE_SHARED_GRAB_UB_NOSYNC  EQU $9E ; Up-Back Grab - no position sync
DEF MOVE_SHARED_GRAB_FG_NOSYNC  EQU $A0 ; Forward Ground Grab - no position sync
DEF MOVE_SHARED_GRAB_UB_SYNC    EQU $A2 ; Up-Back Grab - with position sync
DEF MOVE_TASK_REMOVE            EQU $FF ; Magic value - Kill current task

; Character-specific
DEF MOVE_KYO_YAMI_BARAI_L                    EQU $64
DEF MOVE_KYO_YAMI_BARAI_H                    EQU $66
DEF MOVE_KYO_ONI_YAKI_L                      EQU $68
DEF MOVE_KYO_ONI_YAKI_H                      EQU $6A
DEF MOVE_KYO_OBORO_GURUMA_L                  EQU $6C
DEF MOVE_KYO_OBORO_GURUMA_H                  EQU $6E
DEF MOVE_KYO_KOTOTSUKI_YOU_L                 EQU $70
DEF MOVE_KYO_KOTOTSUKI_YOU_H                 EQU $72
DEF MOVE_KYO_KAI_L                           EQU $74
DEF MOVE_KYO_KAI_H                           EQU $76
DEF MOVE_KYO_78                              EQU $78
DEF MOVE_KYO_7A                              EQU $7A
DEF MOVE_KYO_7C                              EQU $7C
DEF MOVE_KYO_7E                              EQU $7E
DEF MOVE_KYO_URA_OROCHI_NAGI_S               EQU $80

DEF MOVE_BENIMARU_RAIJINKEN_L                EQU $64
DEF MOVE_BENIMARU_RAIJINKEN_H                EQU $66
DEF MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L      EQU $68
DEF MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H      EQU $6A
DEF MOVE_BENIMARU_IAI_GERI_L                 EQU $6C
DEF MOVE_BENIMARU_IAI_GERI_H                 EQU $6E
DEF MOVE_BENIMARU_SUPER_INAZUMA_KICK_L       EQU $70
DEF MOVE_BENIMARU_SUPER_INAZUMA_KICK_H       EQU $72
DEF MOVE_BENIMARU_74                         EQU $74
DEF MOVE_BENIMARU_76                         EQU $76
DEF MOVE_BENIMARU_78                         EQU $78
DEF MOVE_BENIMARU_7A                         EQU $7A
DEF MOVE_BENIMARU_7C                         EQU $7C
DEF MOVE_BENIMARU_7E                         EQU $7E
DEF MOVE_BENIMARU_RAIKOUKEN_S                EQU $80

DEF MOVE_RYO_KO_OU_KEN_GL                    EQU $64
DEF MOVE_RYO_KO_OU_KEN_GH                    EQU $66
DEF MOVE_RYO_HIEN_SHIPPUU_KYAKU_L            EQU $68
DEF MOVE_RYO_HIEN_SHIPPUU_KYAKU_H            EQU $6A
DEF MOVE_RYO_ZENRETSUKEN_L                   EQU $6C
DEF MOVE_RYO_ZENRETSUKEN_H                   EQU $6E
DEF MOVE_RYO_KO_HOU_L                        EQU $70
DEF MOVE_RYO_KO_HOU_H                        EQU $72
DEF MOVE_RYO_KO_OU_KEN_AL                    EQU $74
DEF MOVE_RYO_KO_OU_KEN_AH                    EQU $76
DEF MOVE_RYO_HAOH_SHOKOU_KEN_L               EQU $78
DEF MOVE_RYO_HAOH_SHOKOU_KEN_H               EQU $7A
DEF MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_L        EQU $7C
DEF MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_H        EQU $7E
DEF MOVE_RYO_RYU_KO_RANBU_S                  EQU $80

DEF MOVE_YURI_KO_OU_KEN_L                    EQU $64
DEF MOVE_YURI_KO_OU_KEN_H                    EQU $66
DEF MOVE_YURI_SAI_HA_L                       EQU $68
DEF MOVE_YURI_SAI_HA_H                       EQU $6A
DEF MOVE_YURI_HYAKU_RETSU_BINTA_L            EQU $6C
DEF MOVE_YURI_HYAKU_RETSU_BINTA_H            EQU $6E
DEF MOVE_YURI_KUU_GA_L                       EQU $70
DEF MOVE_YURI_KUU_GA_H                       EQU $72
DEF MOVE_YURI_RAI_OH_KEN_L                   EQU $74
DEF MOVE_YURI_RAI_OH_KEN_H                   EQU $76
DEF MOVE_YURI_HAOH_SHOUKOU_KEN_L             EQU $78
DEF MOVE_YURI_HAOH_SHOUKOU_KEN_H             EQU $7A
DEF MOVE_YURI_7C                             EQU $7C
DEF MOVE_YURI_7E                             EQU $7E
DEF MOVE_YURI_HIEN_HOU_OU_KYA_KU_S           EQU $80

DEF MOVE_TERRY_POWER_WAVE_L                  EQU $64
DEF MOVE_TERRY_POWER_WAVE_H                  EQU $66
DEF MOVE_TERRY_BURN_KNUCKLE_L                EQU $68
DEF MOVE_TERRY_BURN_KNUCKLE_H                EQU $6A
DEF MOVE_TERRY_CRACK_SHOT_L                  EQU $6C
DEF MOVE_TERRY_CRACK_SHOT_H                  EQU $6E
DEF MOVE_TERRY_RISING_TACKLE_L               EQU $70
DEF MOVE_TERRY_RISING_TACKLE_H               EQU $72
DEF MOVE_TERRY_POWER_DUNK_L                  EQU $74
DEF MOVE_TERRY_POWER_DUNK_H                  EQU $76
DEF MOVE_TERRY_78                            EQU $78
DEF MOVE_TERRY_7A                            EQU $7A
DEF MOVE_TERRY_7C                            EQU $7C
DEF MOVE_TERRY_7E                            EQU $7E
DEF MOVE_TERRY_POWER_GEYSER_S                EQU $80

DEF MOVE_JOE_HURRICANE_UPPER_L               EQU $64
DEF MOVE_JOE_HURRICANE_UPPER_H               EQU $66
DEF MOVE_JOE_SLASH_KICK_L                    EQU $68
DEF MOVE_JOE_SLASH_KICK_H                    EQU $6A
DEF MOVE_JOE_BAKURETSUKEN_L                  EQU $6C
DEF MOVE_JOE_BAKURETSUKEN_H                  EQU $6E
DEF MOVE_JOE_TIGER_KICK_L                    EQU $70
DEF MOVE_JOE_TIGER_KICK_H                    EQU $72
DEF MOVE_JOE_OUGON_NO_KAKATO_L               EQU $74
DEF MOVE_JOE_OUGON_NO_KAKATO_H               EQU $76
DEF MOVE_JOE_78                              EQU $78
DEF MOVE_JOE_7A                              EQU $7A
DEF MOVE_JOE_7C                              EQU $7C
DEF MOVE_JOE_7E                              EQU $7E
DEF MOVE_JOE_SCREW_UPPER_S                   EQU $80

DEF MOVE_HEIDERN_CROSS_CUTTER_L              EQU $64
DEF MOVE_HEIDERN_CROSS_CUTTER_H              EQU $66
DEF MOVE_HEIDERN_NECK_ROLLER_L               EQU $68
DEF MOVE_HEIDERN_NECK_ROLLER_H               EQU $6A
DEF MOVE_HEIDERN_STORM_BRINGER_L             EQU $6C
DEF MOVE_HEIDERN_STORM_BRINGER_H             EQU $6E
DEF MOVE_HEIDERN_MOON_SLASHER_L              EQU $70
DEF MOVE_HEIDERN_MOON_SLASHER_H              EQU $72
DEF MOVE_HEIDERN_74                          EQU $74
DEF MOVE_HEIDERN_76                          EQU $76
DEF MOVE_HEIDERN_78                          EQU $78
DEF MOVE_HEIDERN_7A                          EQU $7A
DEF MOVE_HEIDERN_7C                          EQU $7C
DEF MOVE_HEIDERN_7E                          EQU $7E
DEF MOVE_HEIDERN_FINAL_BRINGER_S             EQU $80

DEF MOVE_RALF_VULCAN_PUNCH_L                 EQU $64
DEF MOVE_RALF_VULCAN_PUNCH_H                 EQU $66
DEF MOVE_RALF_GATLING_ATTACK_L               EQU $68
DEF MOVE_RALF_GATLING_ATTACK_H               EQU $6A
DEF MOVE_RALF_BACK_BREAKER_L                 EQU $6C
DEF MOVE_RALF_BACK_BREAKER_H                 EQU $6E
DEF MOVE_RALF_BAKUDAN_PUNCH_L                EQU $70
DEF MOVE_RALF_BAKUDAN_PUNCH_H                EQU $72
DEF MOVE_RALF_74                             EQU $74
DEF MOVE_RALF_76                             EQU $76
DEF MOVE_RALF_78                             EQU $78
DEF MOVE_RALF_7A                             EQU $7A
DEF MOVE_RALF_7C                             EQU $7C
DEF MOVE_RALF_7E                             EQU $7E
DEF MOVE_RALF_BARIBARI_VULCAN_PUNCH_S        EQU $80

DEF MOVE_ATHENA_PSYCHO_BALL_L                EQU $64
DEF MOVE_ATHENA_PSYCHO_BALL_H                EQU $66
DEF MOVE_ATHENA_PSYCHO_REFLECTOR_L           EQU $68
DEF MOVE_ATHENA_PSYCHO_REFLECTOR_H           EQU $6A
DEF MOVE_ATHENA_PSYCHO_SWORD_L               EQU $6C
DEF MOVE_ATHENA_PSYCHO_SWORD_H               EQU $6E
DEF MOVE_ATHENA_PHOENIX_ARROW_L              EQU $70
DEF MOVE_ATHENA_PHOENIX_ARROW_H              EQU $72
DEF MOVE_ATHENA_74                           EQU $74
DEF MOVE_ATHENA_PHOENIX_ARROW_KICK_H         EQU $76
DEF MOVE_ATHENA_78                           EQU $78
DEF MOVE_ATHENA_7A                           EQU $7A
DEF MOVE_ATHENA_7C                           EQU $7C
DEF MOVE_ATHENA_7E                           EQU $7E
DEF MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS       EQU $80

DEF MOVE_KENSOU_CHOU_KYUU_DAN_L              EQU $64
DEF MOVE_KENSOU_CHOU_KYUU_DAN_H              EQU $66
DEF MOVE_KENSOU_RYUU_GAKU_SAI_L              EQU $68
DEF MOVE_KENSOU_RYUU_GAKU_SAI_H              EQU $6A
DEF MOVE_KENSOU_RYUU_REN_GA_L                EQU $6C
DEF MOVE_KENSOU_RYUU_REN_GA_H                EQU $6E
DEF MOVE_KENSOU_RYUU_SOU_GEKI_L              EQU $70
DEF MOVE_KENSOU_RYUU_SOU_GEKI_H              EQU $72
DEF MOVE_KENSOU_74                           EQU $74
DEF MOVE_KENSOU_76                           EQU $76
DEF MOVE_KENSOU_78                           EQU $78
DEF MOVE_KENSOU_7A                           EQU $7A
DEF MOVE_KENSOU_7C                           EQU $7C
DEF MOVE_KENSOU_7E                           EQU $7E
DEF MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S       EQU $80

DEF MOVE_KIM_HAN_GETSU_ZAN_L                 EQU $64
DEF MOVE_KIM_HAN_GETSU_ZAN_H                 EQU $66
DEF MOVE_KIM_HIEN_ZAN_L                      EQU $68
DEF MOVE_KIM_HIEN_ZAN_H                      EQU $6A
DEF MOVE_KIM_HISHOU_KYAKU_L                  EQU $6C
DEF MOVE_KIM_HISHOU_KYAKU_H                  EQU $6E
DEF MOVE_KIM_RYUUSEI_RANKU_L                 EQU $70
DEF MOVE_KIM_RYUUSEI_RANKU_H                 EQU $72
DEF MOVE_KIM_74                              EQU $74
DEF MOVE_KIM_76                              EQU $76
DEF MOVE_KIM_78                              EQU $78
DEF MOVE_KIM_7A                              EQU $7A
DEF MOVE_KIM_7C                              EQU $7C
DEF MOVE_KIM_7E                              EQU $7E
DEF MOVE_KIM_HOU_OU_KYAKU_S                  EQU $80

DEF MOVE_MAI_KA_CHO_SEN_L                    EQU $64
DEF MOVE_MAI_KA_CHO_SEN_H                    EQU $66
DEF MOVE_MAI_HISSATSU_SHINOBIBACHI_L         EQU $68
DEF MOVE_MAI_HISSATSU_SHINOBIBACHI_H         EQU $6A
DEF MOVE_MAI_RYU_EN_BU_L                     EQU $6C
DEF MOVE_MAI_RYU_EN_BU_H                     EQU $6E
DEF MOVE_MAI_HISHO_RYU_EN_JIN_L              EQU $70
DEF MOVE_MAI_HISHO_RYU_EN_JIN_H              EQU $72
DEF MOVE_MAI_CHIJOU_MUSASABI_L               EQU $74
DEF MOVE_MAI_CHIJOU_MUSASABI_H               EQU $76
DEF MOVE_MAI_KUUCHUU_MUSASABI_L              EQU $78
DEF MOVE_MAI_KUUCHUU_MUSASABI_H              EQU $7A
DEF MOVE_MAI_7C                              EQU $7C
DEF MOVE_MAI_7E                              EQU $7E
DEF MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S     EQU $80

DEF MOVE_IORI_YAMI_BARAI_L                   EQU $64
DEF MOVE_IORI_YAMI_BARAI_H                   EQU $66
DEF MOVE_IORI_ONI_YAKI_L                     EQU $68
DEF MOVE_IORI_ONI_YAKI_H                     EQU $6A
DEF MOVE_IORI_AOI_HANA_L                     EQU $6C
DEF MOVE_IORI_AOI_HANA_H                     EQU $6E
DEF MOVE_IORI_KOTO_TSUKI_IN_L                EQU $70
DEF MOVE_IORI_KOTO_TSUKI_IN_H                EQU $72
DEF MOVE_IORI_74                             EQU $74
DEF MOVE_IORI_76                             EQU $76
DEF MOVE_IORI_78                             EQU $78
DEF MOVE_IORI_7A                             EQU $7A
DEF MOVE_IORI_7C                             EQU $7C
DEF MOVE_IORI_7E                             EQU $7E
DEF MOVE_IORI_KIN_YA_OTOME_S                 EQU $80

DEF MOVE_EIJI_KIKOUHOU_L                     EQU $64
DEF MOVE_EIJI_KIKOUHOU_H                     EQU $66
DEF MOVE_EIJI_KOTSU_HAZAKI_KIRI_L            EQU $68
DEF MOVE_EIJI_KOTSU_HAZAKI_KIRI_H            EQU $6A
DEF MOVE_EIJI_RYUU_EIJIN_L                   EQU $6C
DEF MOVE_EIJI_RYUU_EIJIN_H                   EQU $6E
DEF MOVE_EIJI_KASUMI_GERI_L                  EQU $70
DEF MOVE_EIJI_KASUMI_GERI_H                  EQU $72
DEF MOVE_EIJI_ZANTETSUHA_L                   EQU $74
DEF MOVE_EIJI_ZANTETSUHA_H                   EQU $76
DEF MOVE_EIJI_KAGE_UTSUSHI_L                 EQU $78
DEF MOVE_EIJI_KAGE_UTSUSHI_H                 EQU $7A
DEF MOVE_EIJI_TENBAKYAKU_L                   EQU $7C
DEF MOVE_EIJI_TENBAKYAKU_H                   EQU $7E
DEF MOVE_EIJI_ZANTETSU_TOUROUKEN_S           EQU $80

DEF MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L   EQU $64
DEF MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H   EQU $66
DEF MOVE_BILLY_SENPUU_KON_L                  EQU $68
DEF MOVE_BILLY_SENPUU_KON_H                  EQU $6A
DEF MOVE_BILLY_SUZUME_OTOSHI_L               EQU $6C
DEF MOVE_BILLY_SUZUME_OTOSHI_H               EQU $6E
DEF MOVE_BILLY_KYOUSHUU_HISHOU_KON_L         EQU $70
DEF MOVE_BILLY_KYOUSHUU_HISHOU_KON_H         EQU $72
DEF MOVE_BILLY_74                            EQU $74
DEF MOVE_BILLY_76                            EQU $76
DEF MOVE_BILLY_78                            EQU $78
DEF MOVE_BILLY_7A                            EQU $7A
DEF MOVE_BILLY_7C                            EQU $7C
DEF MOVE_BILLY_7E                            EQU $7E
DEF MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S        EQU $80

DEF MOVE_SAISYU_YAMI_BARAI_L                 EQU $64
DEF MOVE_SAISYU_YAMI_BARAI_H                 EQU $66
DEF MOVE_SAISYU_ONI_YAKI_L                   EQU $68
DEF MOVE_SAISYU_ONI_YAKI_H                   EQU $6A
DEF MOVE_SAISYU_EN_JOU_L                     EQU $6C
DEF MOVE_SAISYU_EN_JOU_H                     EQU $6E
DEF MOVE_SAISYU_70                           EQU $70
DEF MOVE_SAISYU_72                           EQU $72
DEF MOVE_SAISYU_74                           EQU $74
DEF MOVE_SAISYU_76                           EQU $76
DEF MOVE_SAISYU_78                           EQU $78
DEF MOVE_SAISYU_7A                           EQU $7A
DEF MOVE_SAISYU_7C                           EQU $7C
DEF MOVE_SAISYU_7E                           EQU $7E
DEF MOVE_SAISYU_URA_OROCHI_NAGI_S            EQU $80

DEF MOVE_RUGAL_REPPU_KEN_L                   EQU $64
DEF MOVE_RUGAL_REPPU_KEN_H                   EQU $66
DEF MOVE_RUGAL_GOD_PRESS_L                   EQU $68
DEF MOVE_RUGAL_GOD_PRESS_H                   EQU $6A
DEF MOVE_RUGAL_DARK_BARRIER_L                EQU $6C
DEF MOVE_RUGAL_DARK_BARRIER_H                EQU $6E
DEF MOVE_RUGAL_GENOCIDE_CUTTER_L             EQU $70
DEF MOVE_RUGAL_GENOCIDE_CUTTER_H             EQU $72
DEF MOVE_RUGAL_KAISER_WAVE_L                 EQU $74
DEF MOVE_RUGAL_KAISER_WAVE_H                 EQU $76
DEF MOVE_RUGAL_78                            EQU $78
DEF MOVE_RUGAL_7A                            EQU $7A
DEF MOVE_RUGAL_7C                            EQU $7C
DEF MOVE_RUGAL_7E                            EQU $7E
DEF MOVE_RUGAL_GIGANTIC_PRESSURE_S           EQU $80

DEF MOVE_NAKORURU_AMUBE_YATORO_L             EQU $64
DEF MOVE_NAKORURU_AMUBE_YATORO_H             EQU $66
DEF MOVE_NAKORURU_ANNU_MUTSUBE_L             EQU $68
DEF MOVE_NAKORURU_ANNU_MUTSUBE_H             EQU $6A
DEF MOVE_NAKORURU_KAMUI_RIMSE_L              EQU $6C
DEF MOVE_NAKORURU_KAMUI_RIMSE_H              EQU $6E
DEF MOVE_NAKORURU_LELA_MUTSUBE_L             EQU $70
DEF MOVE_NAKORURU_LELA_MUTSUBE_H             EQU $72
DEF MOVE_NAKORURU_MAMAHAHA_FLIGHT_L          EQU $74
DEF MOVE_NAKORURU_MAMAHAHA_FLIGHT_H          EQU $76
DEF MOVE_NAKORURU_YATORO_POKKU_L             EQU $78
DEF MOVE_NAKORURU_YATORO_POKKU_H             EQU $7A
DEF MOVE_NAKORURU_KAMUI_MUTSUBE_L            EQU $7C
DEF MOVE_NAKORURU_KAMUI_MUTSUBE_H            EQU $7E
DEF MOVE_NAKORURU_ELERUSH_KAMUI_RIMSE_S      EQU $80

DEF HITTYPE_BLOCKED              EQU $00 ; Nothing happens
DEF HITTYPE_HIT_MID0             EQU $01 ; Standard hit #0
DEF HITTYPE_HIT_MID1             EQU $02 ; Standard hit #1
DEF HITTYPE_HIT_LOW              EQU $03 ; Punched or kicked while crouching
DEF HITTYPE_SWEEP                EQU $04 ; Hit by a crouching heavy kick
DEF HITTYPE_HIT_A                EQU $05 ; Hit by a normal while in the air
DEF HITTYPE_LAUNCH_HIGH_UB       EQU $06 ; High throw arc (relative to the opponent)
DEF HITTYPE_HIT_MULTI0           EQU $07 ; Mid-special move, chainable hit #0
DEF HITTYPE_HIT_MULTI1           EQU $08 ; Mid-special move, chainable hit #1
DEF HITTYPE_LAUNCH_FAST_DB       EQU $09 ; Diagonal down throw arc the player to the ground with screen shake - from air
DEF HITTYPE_LAUNCH_SWOOPUP       EQU $0A ; Throw arc straight up, to off-screen
DEF HITTYPE_LAUNCH_MID_UB_NOSTUN EQU $0B ; Medium-far throw arc, without hitstun
DEF HITTYPE_GRAB_START           EQU $0C ; Start of the grab anim / throw sequence
DEF HITTYPE_GRAB_UB_NOSYNC       EQU $0D ; Grab Rotation Frame #0, no position sync (graphic is character-specific)
DEF HITTYPE_GRAB_FG_NOSYNC       EQU $0E ; Grab Rotation Frame #1, no position sync (graphic is character-specific)
DEF HITTYPE_GRAB_UB_SYNC         EQU $0F ; Grab Rotation Frame, with position sync

DEF HITTYPE_DUMMY                EQU $81 ; Placeholder used for empty slots in the special move entries


DEF COLIBOX_00 EQU $00 ; None
DEF COLIBOX_01 EQU $01
DEF COLIBOX_02 EQU $02
DEF COLIBOX_03 EQU $03
DEF COLIBOX_04 EQU $04 ; Throw range
DEF COLIBOX_05 EQU $05
DEF COLIBOX_06 EQU $06
DEF COLIBOX_07 EQU $07
DEF COLIBOX_08 EQU $08
DEF COLIBOX_09 EQU $09
DEF COLIBOX_0A EQU $0A
DEF COLIBOX_0B EQU $0B
DEF COLIBOX_0C EQU $0C
DEF COLIBOX_0D EQU $0D
DEF COLIBOX_0E EQU $0E
DEF COLIBOX_0F EQU $0F
DEF COLIBOX_10 EQU $10
DEF COLIBOX_11 EQU $11
DEF COLIBOX_12 EQU $12
DEF COLIBOX_13 EQU $13
DEF COLIBOX_14 EQU $14
DEF COLIBOX_15 EQU $15
DEF COLIBOX_16 EQU $16
DEF COLIBOX_17 EQU $17
DEF COLIBOX_18 EQU $18
DEF COLIBOX_19 EQU $19
DEF COLIBOX_1A EQU $1A
DEF COLIBOX_1B EQU $1B
DEF COLIBOX_1C EQU $1C
DEF COLIBOX_1D EQU $1D
DEF COLIBOX_1E EQU $1E
DEF COLIBOX_1F EQU $1F
DEF COLIBOX_20 EQU $20
DEF COLIBOX_21 EQU $21
DEF COLIBOX_22 EQU $22
DEF COLIBOX_23 EQU $23
DEF COLIBOX_24 EQU $24
DEF COLIBOX_25 EQU $25
DEF COLIBOX_26 EQU $26
DEF COLIBOX_27 EQU $27
DEF COLIBOX_28 EQU $28
DEF COLIBOX_29 EQU $29
DEF COLIBOX_2A EQU $2A
DEF COLIBOX_2B EQU $2B
DEF COLIBOX_2C EQU $2C
DEF COLIBOX_2D EQU $2D
DEF COLIBOX_2E EQU $2E
DEF COLIBOX_2F EQU $2F
DEF COLIBOX_30 EQU $30
DEF COLIBOX_31 EQU $31
DEF COLIBOX_32 EQU $32
DEF COLIBOX_33 EQU $33
DEF COLIBOX_34 EQU $34

DEF PROJ_PRIORITY_NODESPAWN EQU $02

; wPlayPlThrowActId
DEF PLAY_THROWACT_NONE EQU $00
DEF PLAY_THROWACT_START EQU $01
DEF PLAY_THROWACT_NEXT02 EQU $02
DEF PLAY_THROWACT_NEXT03 EQU $03
DEF PLAY_THROWACT_NEXT04 EQU $04

; wPlayPlThrowOpMode
DEF PLAY_THROWOP_GROUND EQU $00 ; The throw works on players on the ground
DEF PLAY_THROWOP_AIR EQU $01 ; The throw works on players in the air
DEF PLAY_THROWOP_UNUSED_BOTH EQU $02 ; [TCRF] Unused, works on both.

; wPlayPlThrowDir
DEF PLAY_THROWDIR_B EQU $00
DEF PLAY_THROWDIR_F EQU $01

; iOBJInfo_Proj_ThunderBall_Despawn
DEF PROJ_TB_VISIBLE EQU $00
DEF PROJ_TB_DESPAWN EQU $FF

; iOBJInfo_Proj_ShCrystCharge_OrbitMode
DEF PROJ_SHCRYST_ORBITMODE_OVAL EQU $00 ; Phase 1 - Projectile orbits in an oval trajectory at constant speeed
DEF PROJ_SHCRYST_ORBITMODE_SLOW EQU $01 ; Phase 2 - Only horizontal movement
DEF PROJ_SHCRYST_ORBITMODE_HOLD EQU $02 ; Phase 2 - Only horizontal movement
DEF PROJ_SHCRYST_ORBITMODE_SPIRAL EQU $FF ; Projectile moves in a spiral motion, expanding outwards, when releasing it early before phase 2

; iPlInfo_Nakoruru_MamahahaFlight_Mode
DEF PBM_CHKCATCH   EQU $00 ; C backjump until touching the bird. It's possible for this to fail if the bird isn't there.
DEF PBM_FLIGHT     EQU $01 ; Normal flight mode
DEF PBM_FALL       EQU $02 ; Bird released, straight jump down

; iOBJInfo_Bird_Mode
DEF PLAY_BIRD_MODE_INIT   EQU $00 ; Intro
DEF PLAY_BIRD_MODE_IDLE   EQU $01 ; Main Gameplay
DEF PLAY_BIRD_MODE_OUTRO  EQU $02 ; Outro
DEF PLAY_BIRD_MODE_FLIGHT EQU $03 ; Flight mode

; Base gameplay
DEF PL_FLOOR_POS EQU $74

DEF PLAY_HEALTH_CRITICAL EQU $18 ; Threshold for critical health (allow infinite super & desperation supers)
DEF PLAY_HEALTH_MAX      EQU $48 ; Health cap

DEF PLAY_POW_EMPTY      EQU $00
DEF PLAY_POW_MAX        EQU $38 ; Max value for normal POW bar
DEF PLAY_POW_MAXPOW_INF EQU $FF ; Max Pow meter won't decrease with this
DEF PLAY_POW_LAST_BAR   EQU $00
DEF PLAY_POW_LAST_TEXT  EQU $01

DEF PLAY_TID_BAR_BASE   EQU $D4 ; Tile ID base for bars
DEF PLAY_TID_BAR_EMPTY  EQU $D5 ; Tile ID for an empty bar
DEF PLAY_TID_BAR_FILLED EQU PLAY_TID_BAR_BASE ; Tile ID for a filled bar
DEF PLAY_TID_BAR_SIZE   EQU $08 ; Number of tile IDs for tile parts, mapping to the LGrow/RGrow

DEF PLAY_TID_BOX_FILL   EQU $70 ; Initial tile, top left
DEF PLAY_TID_BOX_BLANK  EQU $74 ; Initial tile, top left

DEF PLAY_OBJ_ROUNDTEXT_ROUND1     EQU $00
DEF PLAY_OBJ_ROUNDTEXT_ROUND2     EQU $04
DEF PLAY_OBJ_ROUNDTEXT_ROUND3     EQU $08
DEF PLAY_OBJ_ROUNDTEXT_FINAL      EQU $0C
DEF PLAY_OBJ_ROUNDTEXT_FIGHT      EQU $10
DEF PLAY_OBJ_ROUNDTEXT_READY      EQU $14
DEF PLAY_OBJ_ROUNDTEXT_GO         EQU $18
DEF PLAY_OBJ_ROUNDTEXT_TIMEOVER   EQU $1C
DEF PLAY_OBJ_ROUNDTEXT_DRAWGAME   EQU $20
DEF PLAY_OBJ_ROUNDTEXT_DOUBLEKO   EQU $24
DEF PLAY_OBJ_ROUNDTEXT_YOULOST    EQU $28
DEF PLAY_OBJ_ROUNDTEXT_YOUWON     EQU $2C
DEF PLAY_OBJ_ROUNDTEXT_1PWON      EQU $30
DEF PLAY_OBJ_ROUNDTEXT_2PWON      EQU $34

; ============================================================
; WIN SCREEN

; wWinResult
DEF WIN_VSWON1P    EQU $00
DEF WIN_VSWON2P    EQU $01
DEF WIN_SINGLEWON  EQU $02
DEF WIN_SINGLELOST EQU $03
DEF WIN_SINGLEDRAW EQU $04
DEF WIN_VSDRAW     EQU $05

; Picture position ID, when setting screen palettes for the win screen
DEF PIC_POS_L EQU 0 ; Left
DEF PIC_POS_M EQU 1 ; Center
DEF PIC_POS_R EQU 2 ; Right

IF VER_EN

DEF C_NL EQU $FF ; Newline character in strings

; TextPrinter_MultiFrame options
DEF TXT_ALLOWFAST           EQU $00 ; Allows pressing A to speedup text printing, or START to enable instant text printing (TXCB_INSTANT)
DEF TXT_ALLOWSKIP           EQU $01 ; Allows pressing START to end prematurely the text printing.
DEF TXT_NOCTRL              EQU $02 ; Doesn't allow to control the text printing.
DEF TXT_ALLOWFAST_BLINKPIC  EQU $03 ; Like TXT_ALLOWFAST, and also blinks Omega Rugal's pic

DEF TXB_NONE EQU $FF ; No custom code when waiting idle

ENDC