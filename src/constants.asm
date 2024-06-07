; Keys (as bit numbers)
KEYB_RIGHT       EQU 0
KEYB_LEFT        EQU 1
KEYB_UP          EQU 2
KEYB_DOWN        EQU 3
KEYB_A           EQU 4
KEYB_B           EQU 5
KEYB_SELECT      EQU 6
KEYB_START       EQU 7

; Keys (values)
KEY_NONE         EQU 0
KEY_RIGHT        EQU 1 << KEYB_RIGHT
KEY_LEFT         EQU 1 << KEYB_LEFT
KEY_UP           EQU 1 << KEYB_UP
KEY_DOWN         EQU 1 << KEYB_DOWN
KEY_A            EQU 1 << KEYB_A
KEY_B            EQU 1 << KEYB_B
KEY_SELECT       EQU 1 << KEYB_SELECT
KEY_START        EQU 1 << KEYB_START

; Flags for iPlInfo_JoyNewKeysLH in the upper nybble
; (low nybble is the same as KEYB_*)
KEPB_A_LIGHT EQU 4 ; A button pressed and released before 6 frames
KEPB_B_LIGHT EQU 5 ; B button pressed and released before 6 frames
KEPB_A_HEAVY EQU 6 ; A button held for 6 frames
KEPB_B_HEAVY EQU 7 ; B button held for 6 frames
KEP_A_LIGHT EQU 1 << KEPB_A_LIGHT
KEP_B_LIGHT EQU 1 << KEPB_B_LIGHT
KEP_A_HEAVY EQU 1 << KEPB_A_HEAVY
KEP_B_HEAVY EQU 1 << KEPB_B_HEAVY

; CPU idle actions
CMA_MOVEF  EQU $00 ; Move or run forwads
CMA_MOVEB  EQU $01 ; Move or hop backwards
CMA_CHARGE EQU $02 ; Charge meter
CMA_NONE   EQU $FF ; Nothing. Player stands still.

DIFFICULTY_EASY		EQU $00
DIFFICULTY_NORMAL	EQU $01
DIFFICULTY_HARD		EQU $02

BORDER_NONE			EQU $00
BORDER_MAIN 		EQU $01
BORDER_ALTERNATE 	EQU $02

TIMER_INFINITE		EQU $FF

MODEB_TEAM    EQU 0
MODEB_VS      EQU 1
MODE_SINGLE1P EQU $00
MODE_TEAM1P   EQU $01
MODE_SINGLEVS EQU $02
MODE_TEAMVS   EQU $03

; Player IDs used across multiple variables
PL1  EQU $00		
PL2  EQU $01
PLB1 EQU 0 ; $01
PLB2 EQU 1 ; $02

; Character IDs
CHAR_ID_KYO      EQU $00
CHAR_ID_BENIMARU EQU $02
CHAR_ID_RYO      EQU $04
CHAR_ID_YURI     EQU $06
CHAR_ID_TERRY    EQU $08
CHAR_ID_JOE      EQU $0A
CHAR_ID_HEIDERN  EQU $0C
CHAR_ID_RALF     EQU $0E
CHAR_ID_ATHENA   EQU $10
CHAR_ID_KENSOU   EQU $12
CHAR_ID_KIM      EQU $14
CHAR_ID_MAI      EQU $16
CHAR_ID_IORI     EQU $18
CHAR_ID_EIJI     EQU $1A
CHAR_ID_BILLY    EQU $1C
CHAR_ID_SAISYU   EQU $1E
CHAR_ID_RUGAL    EQU $20
CHAR_ID_NAKORURU EQU $22
CHAR_COUNT       EQU (CHAR_ID_NAKORURU/2)+1 ; Total characters
CHAR_ID_NONE     EQU $FF

STAGE_ID_00 EQU $00
STAGE_ID_01 EQU $01
STAGE_ID_02 EQU $02
STAGE_ID_03 EQU $03
STAGE_ID_04 EQU $04
STAGE_ID_05 EQU $05
STAGE_ID_06 EQU $06

; Special hardcoded stages for bosses or secrets.
; They match the character IDs here.
STAGESEQ_SAISYU     EQU CHAR_ID_SAISYU / 2
STAGESEQ_RUGAL      EQU CHAR_ID_RUGAL / 2
STAGESEQ_NAKORURU   EQU CHAR_ID_NAKORURU / 2

PLAY_BORDER_X       EQU $08 ; Threshold value for being treated as being on the wall.
OBJLSTPTR_NONE      EQU $FFFF ; Placeholder pointer that marks the lack of a secondary sprite mapping and the end separator
OBJLSTPTR_ENTRYSIZE EQU $04 ; Size of each OBJLstPtrTable entry (pair of OBJLstHdrA_* and OBJLstHdrB_* pointers)
ANIMSPEED_INSTANT   EQU $00 ; Close enough
ANIMSPEED_NONE      EQU $FF ; Slowest possible animation speed, set when we want manual control over the animation since it will always be done quicker than 255 frames.

; FLAGS
DIPB_EASY_MOVES       EQU 2 ; SELECT + A/B for easy super moves
DIPB_POWERUP          EQU 3 ; DIPB_POWERUP Powerup mode. Unlimited POW Meter + unlimited super moves + move changes
DIPB_SGB_SOUND_TEST   EQU 4 ; Adds SGB S.E TEST to the options menu
DIPB_TEAM_DUPL        EQU 5 ; Allow duplicate characters in a team
DIPB_UNLOCK_BOSS      EQU 6 ; Unlock Saisyu/Rugal
DIPB_UNLOCK_OTHER     EQU 7 ; Unlock everyone else (Mr Karate, Boss Kagura, Orochi Iori and Orochi Leona)

; $C61C (aka "C025")
MISCB_SERIAL_LAG      EQU 3 ; If set, it freezes the game. Essentially a version of MISCB_LAG_FRAME for the other GB.
                            ; Used to force the slave to wait (and not read new player inputs) until the master sends new bytes.
MISCB_SERIAL_SLAVE    EQU 5 ; If set, the GB is the slave (matches PL2), otherwise it's the master (PL1)
MISCB_SERIAL_MODE     EQU 6 ; Marks a VS battle through serial cable. Not in SGB mode.
MISCB_IS_SGB          EQU 7 ; Enables SGB features
; $C61D (aka "C026")
MISCB_LAG_FRAME       EQU 3 ; Is set when the task cycler is called, and unset right before the VBlank wait loop.
; $C61E (aka "C027")
MISCB_PLAY_STOP       EQU 7 ; If set, the game stops processing input and the timer. Used on the intro and when a round ends.
; $C61F (aka "C028")
MISCB_USE_SECT        EQU 1 ; If set, the screen uses the three-section mode (SetSectLYC was called). Otherwise there's a single section governed by hScrollX and hScrollY.
                            ; In this game, it shares the same bit as MISCB_PL_RANGE_CHECK.
                            ; In 96 this was moved to bit 0, but curiously enough, code there still tends to clear bit 1
                            ; when the presumed intention is to disable the three-section mode.		
MISCB_PL_RANGE_CHECK  EQU 1 ; Enables the player range enforcement, which is part of the sprite drawing routine.
MISCB_TITLE_SECT      EQU 2 ; Allows parallax for the title screen

MISC_USE_SECT         EQU 1 << MISCB_USE_SECT
;--

TXCB_INSTANT EQU 7 ; If set, instant text printing was enabled

OBJINFO_SIZE     EQU $40 ; wOBJInfo size
GFXBUF_TILECOUNT EQU $20 ; Number of tiles in a GFX buffer

; iOBJInfo_Status bits
OSTB_GFXLOAD    EQU 0 ; If set, the graphics are still being copied to the *opposite* buffer than the current one at OSTB_GFXBUF2
OSTB_GFXBUF2    EQU 1 ; If set, the second GFX buffer is used for the *current* frame
OSTB_GFXNEWLOAD EQU 3 ; If set, the graphics have just finished loading. Effectively valid for 1 frame only, since the animation routines resets it.
OSTB_ANIMEND    EQU 4 ; Animation has ended, repeat last frame indefinitely
OSTB_XFLIP      EQU 5 ; Horizontal flip
OSTB_YFLIP      EQU 6 ; Vertical flip
OSTB_VISIBLE    EQU 7 ; If not set, the sprite mapping is hidden

OST_GFXLOAD     EQU 1 << OSTB_GFXLOAD
OST_GFXBUF2     EQU 1 << OSTB_GFXBUF2
OST_GFXNEWLOAD  EQU 1 << OSTB_GFXNEWLOAD
OST_ANIMEND     EQU 1 << OSTB_ANIMEND
OST_XFLIP       EQU 1 << OSTB_XFLIP
OST_YFLIP       EQU 1 << OSTB_YFLIP
OST_VISIBLE     EQU 1 << OSTB_VISIBLE

; Additional iOBJInfo_OBJLstFlags for internal purposes.
; These aren't related to the hardware flags.
SPRXB_BIT0 EQU 0
SPRXB_BIT1 EQU 1
SPRXB_OTHERPROJR EQU 2 ; If set, the other player's projectile is on the right
SPRXB_PLDIR_R EQU 3 ; If set, the player is internally facing right (nonvisual equivalent of the X flip flag)


; OBJLST / SPRITE MAPPINGS FLAGS from ROM
; These are almost the same as the iOBJInfo_OBJLstFlags* bits.
; iOBJLstHdrA_Flags / iOBJLstHdrB_Flags
OLFB_USETILEFLAGS EQU 4 ; If set, in the OBJ data, the upper two bits of a tile ID count as X/Y flip flags
OLFB_XFLIP        EQU 5 ; User-controlled
OLFB_YFLIP        EQU 6
OLFB_NOBUF        EQU 7 ; Sprite mapping doesn't use the buffer copy

OLF_USETILEFLAGS EQU 1 << OLFB_USETILEFLAGS ; $10
OLF_XFLIP        EQU 1 << OLFB_XFLIP ; $20
OLF_YFLIP        EQU 1 << OLFB_YFLIP ; $40
OLF_NOBUF        EQU 1 << OLFB_NOBUF

; Raw versions of the above from inside the ROM, which are shifted up before getting converted
OLR_XFLIP EQU OLF_XFLIP << 1
OLR_YFLIP EQU OLF_YFLIP << 1

; iOBJInfo_Play_HitMode
PHM_NONE    EQU $00
PHM_REMOVE  EQU $01
PHM_REFLECT EQU $02


TASK_SIZE EQU $08

; Task types
TASK_EXEC_NONE EQU $00 ; No task here
TASK_EXEC_DONE EQU $01 ; Already executed this frame
TASK_EXEC_CUR  EQU $02 ; Currently executing
TASK_EXEC_TODO EQU $04 ; Not executed yet, but was executed previously already. Stack pointer type.
TASK_EXEC_NEW  EQU $08 ; Never executed before. Likely init code which will set a new task. Jump HL type.

PLINFO_SIZE EQU $100

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
PF0B_PROJ           EQU 0 ; If set, a projectile is active on-screen (ie: a new one can't be thrown)
PF0B_SPECMOVE       EQU 1 ; If set, the player is performing a special move
PF0B_AIR            EQU 2 ; If set, the player is in the air
PF0B_PROJHIT        EQU 3 ; If set, the player got hit by a projectile
PF0B_PROJREM        EQU 4 ; If set, the player can currently remove projectiles with its hitbox
PF0B_PROJREFLECT    EQU 5 ; If set, the player can currently reflect projectiles with its hitbox
PF0B_SUPERMOVE      EQU 6 ; If set, the player is performing a super move
PF0B_CPU            EQU 7 ; If set, the player is CPU-controlled (1P mode) or autopicks characters (VS mode)
PF0_SPECMOVE        EQU 1 << PF0B_SPECMOVE
PF0_PROJREM         EQU 1 << PF0B_PROJREM
PF0_PROJREFLECT     EQU 1 << PF0B_PROJREFLECT
PF0_SUPERMOVE       EQU 1 << PF0B_SUPERMOVE
PF0_CPU             EQU 1 << PF0B_CPU

; iPlInfo_Flags1 flags
PF1B_NOBASICINPUT   EQU 0 ; Prevents basic input from being handled. See also: BasicInput_ChkDDDDDDDDD
PF1B_XFLIPLOCK      EQU 1 ; Locks the direction the player is facing
PF1B_NOSPECSTART    EQU 2 ; If set, the current move can't be cancelled into a new special.
                          ; Primarily used to prevent starting new specials during certain non-special moves (rolling, taking damage, ...)+
                          ; though starting specials also sets this for consistency.
                          ; Overridden by PF1B_ALLOWHITCANCEL.
PF1B_GUARD          EQU 3 ; If set, the player is guarding, and will receive less damage on hit.
                          ; Primarily set when blocking, but some special moves set this as well to have the same effects as blocking when getting hit out of them.
PF1B_HITRECV        EQU 4 ; If set, the player is on the receiving end of a damage string.
                          ; This is set when the player is attacked at least once (hit or blocked), and
                          ; resets on its own if not cancelling the attack into one that hits.
PF1B_CROUCH         EQU 5 ; If set, the player is crouching
PF1B_ALLOWHITCANCEL EQU 6 ; If set, it's possible to cancel a move into a new special, set after hitting the opponent. This bypasses PF1B_NOSPECSTART.
PF1B_INVULN         EQU 7 ; If set, the player is completely invulnerable. 
						  ; This value isn't always checked during collision -- phyisical hurtbox collisions pass,
						  ; but they are blocked before they can deal damage.
; iPlInfo_Flags2 flags
PF2B_MOVESTART      EQU 0 ; Marks that a new move has been set
PF2B_HEAVY          EQU 1 ; To distinguish between light/heavy when starting an attack
PF2B_NODAMAGERATE   EQU 2 ; If set, it disables the damage rate limit. (only the case when special canceling a move, before the first hit triggers)
PF2B_NOHURTBOX      EQU 6 ; If set, the player has no hurtbox (this separate from the collision box only here)
PF2B_NOCOLIBOX      EQU 7 ; If set, the player has no collision box
; iPlInfo_Flags3, related to the move we got attacked with
PF3B_HEAVYHIT       EQU 0 ; Used by "heavy" hits (not to be confused with heavy moves). Getting attacked shakes the player longer (doesn't cut the shake count in half).
PF3B_FIRE           EQU 1 ; Used by firey hits. Getting hit causes the player to flash slowly.
PF3B_HITLOW         EQU 2 ; The attack hits low (must block crouching)
PF3B_OVERHEAD       EQU 3 ; The attack is an overhead (must block standing)
PF3B_CONTHIT        EQU 4 ; For HitTypeC_Drop* only. If set, the combo string can continue (can juggle), otherwise the opponent is made invulnerable until wakeup.
PF3B_HALFSPEED      EQU 5 ; Getting hit runs the game at half speed
PF3B_SUPERALT       EQU 6 ; Used by a few super moves to make them use an alternate palette cycle.
PF3B_LIGHTHIT       EQU 7 ; Used by "light" hits (not to be confused with light moves). Getting attacked shakes the player once.

PF3_HEAVYHIT        EQU 1 << PF3B_HEAVYHIT   
PF3_FIRE            EQU 1 << PF3B_FIRE
PF3_HITLOW          EQU 1 << PF3B_HITLOW      
PF3_OVERHEAD        EQU 1 << PF3B_OVERHEAD      
PF3_CONTHIT         EQU 1 << PF3B_CONTHIT        
PF3_HALFSPEED       EQU 1 << PF3B_HALFSPEED        
PF3_SUPERALT        EQU 1 << PF3B_SUPERALT
PF3_LIGHTHIT        EQU 1 << PF3B_LIGHTHIT   

; Flags for iPlInfo_ColiFlags
; One half is for our collision status, the other is for the opponent.

PCFB_PUSHED       EQU 0 ; Player is being pushed 
PCFB_HITOTHER     EQU 1 ; The other player got hit (hitbox collided, though it can't be used alone as the opponent may be invulnerable)
PCFB_PROJHITOTHER EQU 2 ; The other player got hit by a projectile
PCFB_PROJREMOTHER EQU 3 ; The other player removed/reflected a projectile
PCFB_PUSHEDOTHER  EQU 4 ; The other player is being pushed
PCFB_HIT          EQU 5 ; Player is hit by a physical attack (hitbox collided, though it can't be used alone as the player may be invulnerable)
PCFB_PROJHIT      EQU 6 ; Player is by a projectile
PCFB_PROJREM      EQU 7 ; Player removed/reflected a projectile

PCF_PUSHED        EQU 1 << PCFB_PUSHED
PCF_HITOTHER      EQU 1 << PCFB_HITOTHER
PCF_PROJHITOTHER  EQU 1 << PCFB_PROJHITOTHER
PCF_PROJREMOTHER  EQU 1 << PCFB_PROJREMOTHER
PCF_PUSHEDOTHER   EQU 1 << PCFB_PUSHEDOTHER
PCF_HIT           EQU 1 << PCFB_HIT
PCF_PROJHIT       EQU 1 << PCFB_PROJHIT
PCF_PROJREM       EQU 1 << PCFB_PROJREM

SNDIDREQ_SIZE      EQU $08
SNDINFO_SIZE       EQU $20 ; Size of iSndInfo struct
SND_CH1_PTR        EQU LOW(rNR13)
SND_CH2_PTR        EQU LOW(rNR23)
SND_CH3_PTR        EQU LOW(rNR33)
SND_CH4_PTR        EQU LOW(rNR43)

; iSndInfo_Status
SISB_PAUSE            EQU 0 ; If set, iSndInfo processing is paused for that channel
SISB_SKIPNRx2         EQU 1 ; If set, rNR*2 won't be updated
SISB_USEDBYSFX        EQU 2 ; wBGMCh*Info only. If set, it marks that a sound effect is currently using the channel.
SISB_SFX              EQU 3 ; If set, the SndInfo is handled as a sound effect. If clear, it's a BGM.
SISB_UNUSED_6         EQU 6 ; Not used, only set by the Game Over song.
SISB_ENABLED          EQU 7 ; If set, iSndInfo processing is enabled for that channel

SIS_PAUSE             EQU 1 << SISB_PAUSE
SIS_SKIPNRx2          EQU 1 << SISB_SKIPNRx2    
SIS_USEDBYSFX         EQU 1 << SISB_USEDBYSFX   
SIS_SFX               EQU 1 << SISB_SFX         
SIS_UNUSED_6          EQU 1 << SISB_UNUSED_6
SIS_ENABLED           EQU 1 << SISB_ENABLED 

; wSndFadeStatus, never used basically
SFDB_FADEOUT          EQU 0 ; If set, the song fades out
SFDB_FADEOUTDONE      EQU 1 ; If set, the song has finished fading out
SFDB_UNUSED_2         EQU 2 ; Not used
SFDB_FADEIN           EQU 4 ; If set, the song fades it
SFDB_FADEINPROC       EQU 5 ; Used to only execute once some fade in code.
SFDB_FADEINDONE       EQU 6 ; If set, the song has finished fading in

SNDCMD_BASE           EQU $E0
SNDNOTE_BASE          EQU $80

;--------------

; DMG Sound List
SND_MUTE              EQU $00
SND_BASE              EQU $80
SND_NONE              EQU SND_BASE+$00

BGM_NAKORURU          EQU SND_BASE+$01
BGM_CHARSELECT        EQU SND_BASE+$02
BGM_INTRO             EQU SND_BASE+$03
BGM_BOSS              EQU SND_BASE+$04
BGM_STAGECLEAR        EQU SND_BASE+$05
BGM_CUTSCENE0         EQU SND_BASE+$06
BGM_CUTSCENE1         EQU SND_BASE+$07
BGM_GAMEOVER          EQU SND_BASE+$08
BGM_CREDITS           EQU SND_BASE+$09
BGM_STAGE             EQU SND_BASE+$0A
BGM_ENDING            EQU SND_BASE+$0B
;SND_ID_8C EQU SND_BASE+$0C
;SND_ID_8D EQU SND_BASE+$0D
;SND_ID_8E EQU SND_BASE+$0E
;SND_ID_8F EQU SND_BASE+$0F
;SND_ID_90 EQU SND_BASE+$10
;SND_ID_91 EQU SND_BASE+$11
;SND_ID_92 EQU SND_BASE+$12
;SND_ID_93 EQU SND_BASE+$13
;SND_ID_94 EQU SND_BASE+$14
;SND_ID_95 EQU SND_BASE+$15
;SND_ID_96 EQU SND_BASE+$16
;SND_ID_97 EQU SND_BASE+$17
;SND_ID_98 EQU SND_BASE+$18
;SND_ID_99 EQU SND_BASE+$19
;SND_ID_9A EQU SND_BASE+$1A
;SND_ID_9B EQU SND_BASE+$1B
;SND_ID_9C EQU SND_BASE+$1C
;SND_ID_9D EQU SND_BASE+$1D
;SND_ID_9E EQU SND_BASE+$1E
;SND_ID_9F EQU SND_BASE+$1F
SFX_CURSORMOVE        EQU SND_BASE+$20
SFX_CHARSELECTED      EQU SND_BASE+$21
SFX_HIT               EQU SND_BASE+$22
SFX_UNUSED_HEAVYHIT   EQU SND_BASE+$23
SFX_FIREHIT           EQU SND_BASE+$24
SFX_BLOCK             EQU SND_BASE+$25
SFX_GROUNDHIT         EQU SND_BASE+$26
SFX_LIGHT             EQU SND_BASE+$27
SFX_HEAVY             EQU SND_BASE+$28
SFX_TAUNT             EQU SND_BASE+$29
SFX_STEP              EQU SND_BASE+$2A
SFX_JUMP              EQU SND_BASE+$2B
SFX_UNUSED_BOMB       EQU SND_BASE+$2C
SFX_UNUSED_BOUNCE     EQU SND_BASE+$2D
SFX_CHARGEMETER       EQU SND_BASE+$2E
SFX_UNUSED_STEP_B     EQU SND_BASE+$2F
SFX_SPECIAL           EQU SND_BASE+$30
SFX_UNUSED_SPECIAL_B  EQU SND_BASE+$31
SFX_REFLECT           EQU SND_BASE+$32
SFX_ERROR             EQU SND_BASE+$33
SFX_BARRIER           EQU SND_BASE+$34
SFX_PROJ_LG           EQU SND_BASE+$35
SFX_DIZZY             EQU SND_BASE+$36
;SND_ID_B7 EQU SND_BASE+$37
;SND_ID_B8 EQU SND_BASE+$38
;SND_ID_B9 EQU SND_BASE+$39
;SND_ID_BA EQU SND_BASE+$3A
;SND_ID_BB EQU SND_BASE+$3B
;SND_ID_BC EQU SND_BASE+$3C
;SND_ID_BD EQU SND_BASE+$3D
;SND_ID_BE EQU SND_BASE+$3E
;SND_ID_BF EQU SND_BASE+$3F
;SND_ID_C0 EQU SND_BASE+$40
;SND_ID_C1 EQU SND_BASE+$41
;SND_ID_C2 EQU SND_BASE+$42
;SND_ID_C3 EQU SND_BASE+$43
;SND_ID_C4 EQU SND_BASE+$44
;SND_ID_C5 EQU SND_BASE+$45
;SND_ID_C6 EQU SND_BASE+$46
;SND_ID_C7 EQU SND_BASE+$47
;SND_ID_C8 EQU SND_BASE+$48
;SND_ID_C9 EQU SND_BASE+$49
;SND_ID_CA EQU SND_BASE+$4A
;SND_ID_CB EQU SND_BASE+$4B
;SND_ID_CC EQU SND_BASE+$4C
;SND_ID_CD EQU SND_BASE+$4D
;SND_ID_CE EQU SND_BASE+$4E
;SND_ID_CF EQU SND_BASE+$4F
;SND_ID_D0 EQU SND_BASE+$50
;SND_ID_D1 EQU SND_BASE+$51
;SND_ID_D2 EQU SND_BASE+$52
;SND_ID_D3 EQU SND_BASE+$53
;SND_ID_D4 EQU SND_BASE+$54
;SND_ID_D5 EQU SND_BASE+$55
;SND_ID_D6 EQU SND_BASE+$56
;SND_ID_D7 EQU SND_BASE+$57
;SND_ID_D8 EQU SND_BASE+$58
;SND_ID_D9 EQU SND_BASE+$59
;SND_ID_DA EQU SND_BASE+$5A
;SND_ID_DB EQU SND_BASE+$5B
;SND_ID_DC EQU SND_BASE+$5C
;SND_ID_DD EQU SND_BASE+$5D
;SND_ID_DE EQU SND_BASE+$5E

SND_LAST_VALID        EQU SND_BASE+$5E ; Dunno why this late
SNC_FADEOUT           EQU SND_BASE+$70

; Sound Action List (offset by 1, since $00 is handled as SND_NONE) 
SCT_PROJ_SM           EQU $01 ; Medium Projectile thrown
SCT_MOVEJUMP_A        EQU $02 ; Automatic jump as part of a special move
SCT_MOVEJUMP_B        EQU $03 ; ""
SCT_UNUSED_MOVEJUMP_C EQU $04 ; Unreferenced. Slotted in between other MOVEJUMPs though
SCT_UNUSED_MOVEJUMP_D EQU $05 ; Unused copy of SCT_MOVEJUMP_A
SCT_FIREHIT           EQU $06 ; Hit with PF3B_FIRE
SCT_PROJ_LG_A         EQU $07 ; Large projectile spawned
SCT_PHYSFIRE          EQU $08 ; Phyisical fire atttack
SCT_PROJ_LG_B         EQU $09 ; Large projectile spawned
SCT_GROUNDHIT         EQU $0A ; Hitting the ground and rebounding off it
SCT_UNUSED_SWORD      EQU $0B ; Unused, SGB-only, mapped to SGB_SND_A_SWORDSWING_02
SCT_MULTIHIT          EQU $0C ; In-between hits for move that hit multiple times
SCT_TAUNT             EQU $0D ; Taunt
SCT_SHCRYSTSPAWN      EQU $0E ; Shining Crystal Bit projectile spawned
SCT_BARRIER           EQU $0F ; Barrier spawned (Athena or Rugal)
SCT_REFLECT           EQU $10 ; Projectile reflected
SCT_KIKOUHOU          EQU $11 ; Unique SFX for Eiji's Kikouhou

; Screen Palette IDs, passed to SGB_ApplyScreenPalSet 
SCRPAL_INTRO          EQU $00
SCRPAL_TAKARALOGO     EQU $01
SCRPAL_TITLE          EQU $02
SCRPAL_CHARSELECT     EQU $03
SCRPAL_STAGECLEAR     EQU $04
SCRPAL_STAGE_00       EQU $05
SCRPAL_STAGE_01       EQU $06
SCRPAL_STAGE_04       EQU $07
SCRPAL_STAGE_02       EQU $08
SCRPAL_STAGE_03       EQU $09

;
; MODE IDs & CONSTANTS
;

; ============================================================
; INTRO

INTRO_OBJ_KYO            EQU $00
INTRO_OBJ_IORI           EQU $01

; ============================================================
; TITLE SCREEN / MENUS

GM_TITLE_TITLE          EQU $00
GM_TITLE_TITLEMENU      EQU $02 
GM_TITLE_MODESELECT     EQU $04
GM_TITLE_OPTIONS        EQU $06

; SHARED
TITLE_OBJ_PUSHSTART     EQU $00
TITLE_OBJ_MENU          EQU $01
TITLE_OBJ_CURSOR_R      EQU $02
TITLE_OBJ_SNKCOPYRIGHT  EQU $03
TITLE_OBJ_CURSOR_U      EQU $04

; TITLE
TITLE_RESET_TIMER       EQU (30 << 8) | 60 ; 30 seconds

; TITLEMENU
TITLEMENU_TO_TITLE      EQU $00
TITLEMENU_TO_MODESELECT EQU $01
TITLEMENU_TO_OPTIONS    EQU $02

; MODESELECT
MODESELECT_ACT_EXIT     EQU $00
MODESELECT_ACT_SINGLE1P EQU MODE_SINGLE1P+1
MODESELECT_ACT_TEAM1P   EQU MODE_TEAM1P+1
MODESELECT_ACT_SINGLEVS EQU MODE_SINGLEVS+1
MODESELECT_ACT_TEAMVS   EQU MODE_TEAMVS+1

; Mode IDs sent out through the serial
MODESELECT_SBCMD_IDLE     EQU $02
MODESELECT_SBCMD_SINGLEVS EQU MODESELECT_ACT_SINGLEVS
MODESELECT_SBCMD_TEAMVS   EQU MODESELECT_ACT_TEAMVS

; Implementation detail leads to this
SERIAL_PL1_ID             EQU MODESELECT_SBCMD_IDLE
; SERIAL_PL2_ID is not a constant, but any val != $00 && != $02

; OPTIONS

; Main options
OPTION_ITEM_TIME        EQU $00
OPTION_ITEM_LEVEL       EQU $01
OPTION_ITEM_BGMTEST     EQU $02
OPTION_ITEM_SFXTEST     EQU $03
OPTION_ITEM_SGBSNDTEST  EQU $04
OPTION_ITEM_EXIT        EQU $05

; SGB sound test options
OPTION_SITEM_ID_A       EQU $00
OPTION_SITEM_BANK_A     EQU $01
OPTION_SITEM_ID_B       EQU $02
OPTION_SITEM_BANK_B     EQU $03


OPTIONS_ACT_EXIT EQU $00
OPTIONS_ACT_L EQU $01
OPTIONS_ACT_R EQU $02
OPTIONS_ACT_A EQU $03
OPTIONS_ACT_B EQU $04

OPTIONS_SACT_EXIT    EQU $00
OPTIONS_SACT_UP      EQU $01
OPTIONS_SACT_DOWN    EQU $02
OPTIONS_SACT_A       EQU $03
OPTIONS_SACT_B       EQU $04
OPTIONS_SACT_SUBEXIT EQU $05

OPTIONS_TIMER_MIN EQU $10
OPTIONS_TIMER_INC EQU $10
OPTIONS_TIMER_MAX EQU $90

OPTION_MENU_NORMAL  EQU $00
OPTION_MENU_SGBTEST EQU $02

; ============================================================
; CHARACTER SELECT

CHARSEL_POSFB_DEFEATED EQU 7
CHARSEL_POSF_DEFEATED EQU 1 << CHARSEL_POSFB_DEFEATED

CHARSEL_MODE_SELECT    EQU $00
CHARSEL_MODE_READY     EQU $02
CHARSEL_MODE_CONFIRMED EQU $04

CHARSEL_1P EQU $00
CHARSEL_2P EQU $01	

CHARSEL_TEAM_REMAIN EQU $00
CHARSEL_TEAM_FILLED EQU $FF

CHARSEL_GRID_W    EQU $06
CHARSEL_GRID_H    EQU $03
CHARSEL_GRID_SIZE EQU CHARSEL_GRID_W * CHARSEL_GRID_H

CHARSEL_OBJ_CURSOR1P        EQU $00
CHARSEL_OBJ_CURSOR2P        EQU $04
CHARSEL_OBJ_CURSORCPU1P     EQU $08
CHARSEL_OBJ_CURSORCPU2P     EQU $0C

; Fake 96 adjusts the positions of these to move them above the grid.
IF REV_VER == 96
BG_CHARSEL_P1ICON0 EQU $9861
BG_CHARSEL_P1ICON1 EQU $9863
BG_CHARSEL_P1ICON2 EQU $9865
BG_CHARSEL_P2ICON0 EQU $9871
BG_CHARSEL_P2ICON1 EQU $986F
BG_CHARSEL_P2ICON2 EQU $986D

BG_CHARSEL_P1NAME  EQU $98C1 ; Left side
BG_CHARSEL_P2NAME  EQU $98D2 ; Right side

ELSE
BG_CHARSEL_P1ICON0 EQU $99E1
BG_CHARSEL_P1ICON1 EQU $99E3
BG_CHARSEL_P1ICON2 EQU $99E5
BG_CHARSEL_P2ICON0 EQU $99F1
BG_CHARSEL_P2ICON1 EQU $99EF
BG_CHARSEL_P2ICON2 EQU $99ED

BG_CHARSEL_P1NAME  EQU $99A1 ; Left side
BG_CHARSEL_P2NAME  EQU $99B2 ; Right side
ENDC

; Blank boxes with numbers
TILE_CHARSEL_ICONEMPTY1 EQU $D1 ; $EC
TILE_CHARSEL_ICONEMPTY2 EQU $D5 ; $F0
TILE_CHARSEL_ICONEMPTY3 EQU $D9 ; $F4

TILE_CHARSEL_P1ICON0 EQU $DD
TILE_CHARSEL_P1ICON1 EQU $E1
TILE_CHARSEL_P1ICON2 EQU $E5

TILE_CHARSEL_P2ICON0 EQU $E9
TILE_CHARSEL_P2ICON1 EQU $ED
TILE_CHARSEL_P2ICON2 EQU $F1

; ============================================================
; ORDER SELECT
ORDSEL_SEL0 EQU $00
ORDSEL_SEL1 EQU $01
ORDSEL_SELDONE EQU $02

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

MOVE_SHARED_NONE            EQU $00
MOVE_SHARED_IDLE            EQU $02 ; Stand
MOVE_SHARED_WALK_F          EQU $04 ; Walk forward
MOVE_SHARED_WALK_B          EQU $06 ; Walk back
MOVE_SHARED_CROUCH          EQU $08 ; Crouch
MOVE_SHARED_CROUCHWALK_F    EQU $0A ; Crouch walk forwards
MOVE_SHARED_JUMP_N          EQU $0C ; Neutral jump
MOVE_SHARED_JUMP_F          EQU $0E ; Forward jump
MOVE_SHARED_JUMP_B          EQU $10 ; Backwards jump
MOVE_SHARED_BLOCK_G         EQU $12 ; Ground block / mid
MOVE_SHARED_BLOCK_C         EQU $14 ; Crouch block / low
MOVE_SHARED_HOP_F           EQU $16 ; Forward hop
MOVE_SHARED_HOP_B           EQU $18 ; Backwards hop
MOVE_SHARED_CHARGEMETER     EQU $1A ; Charge meter
MOVE_SHARED_TAUNT           EQU $1C ; Taunt
MOVE_SHARED_DODGE           EQU $1E ; Dodge
MOVE_SHARED_WAKEUP          EQU $20 ; Get up
MOVE_SHARED_DIZZY           EQU $22 ; Dizzy
MOVE_SHARED_WIN             EQU $24 ; Win 
MOVE_SHARED_LOST_TIMEOVER   EQU $26 ; Time over
MOVE_SHARED_INTRO           EQU $28 ; Intro
; Basic attacks & Command Normals
MOVE_SHARED_PUNCH_LN        EQU $2A ; Light punch (Near)
MOVE_SHARED_PUNCH_HN        EQU $2C ; Heavy punch (Near)
MOVE_SHARED_PUNCH_LM        EQU $2E ; Light punch (Far)
MOVE_SHARED_PUNCH_HM        EQU $30 ; Heavy punch (Far)
MOVE_SHARED_KICK_LN         EQU $32 ; Light kick (Near)
MOVE_SHARED_KICK_HN         EQU $34 ; Heavy kick (Near)
MOVE_SHARED_KICK_LM         EQU $36 ; Light kick (Far)
MOVE_SHARED_KICK_HM         EQU $38 ; Heavy kick (Far)
MOVE_SHARED_PUNCH_CL        EQU $3A ; Crouch punch light
MOVE_SHARED_PUNCH_CH        EQU $3C ; Crouch punch heavy
MOVE_SHARED_KICK_CL         EQU $3E ; Crouch kick light
MOVE_SHARED_KICK_CH         EQU $40 ; Crouch kick heavy
MOVE_SHARED_DODGE_COUNTER   EQU $42 ; Dodge Counter
MOVE_SHARED_STRIKE          EQU $44 ; Ground A + B + Forward (Strike attack)
MOVE_SHARED_PUNCH_FH        EQU $46 ; Heavy punch (Forward)
MOVE_SHARED_KICK_FH         EQU $48 ; Heavy kick (Forward)
MOVE_SHARED_KICK_FCH        EQU $4A ; Crouch kick heavy (Forward)
MOVE_SHARED_PUNCH_ALI       EQU $4C ; Air light punch (Neutral)
MOVE_SHARED_PUNCH_AHI       EQU $4E ; Air heavy punch (Neutral)
MOVE_SHARED_KICK_ALI        EQU $50 ; Air light kick (Neutral)
MOVE_SHARED_KICK_AHI        EQU $52 ; Air heavy kick (Neutral)
MOVE_SHARED_PUNCH_ALX       EQU $54 ; Air light punch (Non-Neutral)
MOVE_SHARED_PUNCH_AHX       EQU $56 ; Air heavy punch (Non-Neutral)
MOVE_SHARED_KICK_ALX        EQU $58 ; Air light kick (Non-Neutral)
MOVE_SHARED_KICK_AHX        EQU $5A ; Air heavy kick (Non-Neutral)
MOVE_SHARED_ATTACK_A        EQU $5C ; Air A + B
MOVE_SHARED_PUNCH_AHD       EQU $5E ; Air heavy punch (Downward)
MOVE_SHARED_KICK_AHD        EQU $60 ; Air heavy kick (Downward)
MOVE_SHARED_KICK_AHB        EQU $62 ; Air heavy kick (Backward)
; Specials (placeholders)
MOVE_SPEC_0_L               EQU $64
MOVE_SPEC_0_H               EQU $66
MOVE_SPEC_1_L               EQU $68
MOVE_SPEC_1_H               EQU $6A
MOVE_SPEC_2_L               EQU $6C
MOVE_SPEC_2_H               EQU $6E
MOVE_SPEC_3_L               EQU $70
MOVE_SPEC_3_H               EQU $72
MOVE_SPEC_4_L               EQU $74
MOVE_SPEC_4_H               EQU $76
MOVE_SPEC_5_L               EQU $78
MOVE_SPEC_5_H               EQU $7A
MOVE_SPEC_6_L               EQU $7C
MOVE_SPEC_6_H               EQU $7E
MOVE_SHARED_SUPER           EQU $80
; Throws
MOVE_SHARED_THROW_G         EQU $82 ; Ground throw
MOVE_SHARED_THROW_A         EQU $84 ; Air throw
; Attacked
MOVE_SHARED_POST_BLOCKSTUN  EQU $86 ; After blockstun knockback
MOVE_SHARED_HIT0MID         EQU $88 ; Mid Hit #0
MOVE_SHARED_HIT1MID         EQU $8A ; Mid Hit #1
MOVE_SHARED_HITLOW          EQU $8C ; Low Hit
MOVE_SHARED_LAUNCH_UB       EQU $8E ; Up-Back launch/throw arc
MOVE_SHARED_LAUNCH_DB_SHAKE EQU $90 ; Down-Back launch/throw arc, shake screen when hitting the ground
MOVE_SHARED_LAUNCH_SWOOPUP  EQU $92 ; Straight up launch/throw arc
MOVE_SHARED_HIT_SWEEP       EQU $94 ; Hit by crouching heavy kick (fell off)
MOVE_SHARED_LAUNCH_UB_REC   EQU $96 ; Up-Back launch with mid-air recovery.
MOVE_SHARED_HIT_MULTIMID0   EQU $98 ; Multi-hit special move, pre-last hit #0
MOVE_SHARED_HIT_MULTIMID1   EQU $9A ; Multi-hit special move, pre-last hit #1
MOVE_SHARED_LAUNCH_UB_SHAKE EQU $9C ; Up-Back launch/throw arc, shake screen when hitting the ground
MOVE_SHARED_GRAB_UB_NOSYNC  EQU $9E ; Up-Back Grab - no position sync
MOVE_SHARED_GRAB_FG_NOSYNC  EQU $A0 ; Forward Ground Grab - no position sync
MOVE_SHARED_GRAB_UB_SYNC    EQU $A2 ; Up-Back Grab - with position sync
MOVE_TASK_REMOVE            EQU $FF ; Magic value - Kill current task

; Character-specific
MOVE_KYO_YAMI_BARAI_L                    EQU $64
MOVE_KYO_YAMI_BARAI_H                    EQU $66
MOVE_KYO_ONI_YAKI_L                      EQU $68
MOVE_KYO_ONI_YAKI_H                      EQU $6A
MOVE_KYO_OBORO_GURUMA_L                  EQU $6C
MOVE_KYO_OBORO_GURUMA_H                  EQU $6E
MOVE_KYO_KOTOTSUKI_YOU_L                 EQU $70
MOVE_KYO_KOTOTSUKI_YOU_H                 EQU $72
MOVE_KYO_KAI_L                           EQU $74
MOVE_KYO_KAI_H                           EQU $76
MOVE_KYO_78                              EQU $78
MOVE_KYO_7A                              EQU $7A
MOVE_KYO_7C                              EQU $7C
MOVE_KYO_7E                              EQU $7E
MOVE_KYO_URA_OROCHI_NAGI_S               EQU $80

MOVE_BENIMARU_RAIJINKEN_L                EQU $64
MOVE_BENIMARU_RAIJINKEN_H                EQU $66
MOVE_BENIMARU_SHINKUU_KATATE_GOMA_L      EQU $68
MOVE_BENIMARU_SHINKUU_KATATE_GOMA_H      EQU $6A
MOVE_BENIMARU_IAI_GERI_L                 EQU $6C
MOVE_BENIMARU_IAI_GERI_H                 EQU $6E
MOVE_BENIMARU_SUPER_INAZUMA_KICK_L       EQU $70
MOVE_BENIMARU_SUPER_INAZUMA_KICK_H       EQU $72
MOVE_BENIMARU_74                         EQU $74
MOVE_BENIMARU_76                         EQU $76
MOVE_BENIMARU_78                         EQU $78
MOVE_BENIMARU_7A                         EQU $7A
MOVE_BENIMARU_7C                         EQU $7C
MOVE_BENIMARU_7E                         EQU $7E
MOVE_BENIMARU_RAIKOUKEN_S                EQU $80

MOVE_RYO_KO_OU_KEN_GL                    EQU $64
MOVE_RYO_KO_OU_KEN_GH                    EQU $66
MOVE_RYO_HIEN_SHIPPUU_KYAKU_L            EQU $68
MOVE_RYO_HIEN_SHIPPUU_KYAKU_H            EQU $6A
MOVE_RYO_ZENRETSUKEN_L                   EQU $6C
MOVE_RYO_ZENRETSUKEN_H                   EQU $6E
MOVE_RYO_KO_HOU_L                        EQU $70
MOVE_RYO_KO_HOU_H                        EQU $72
MOVE_RYO_KO_OU_KEN_AL                    EQU $74
MOVE_RYO_KO_OU_KEN_AH                    EQU $76
MOVE_RYO_HAOH_SHOKOU_KEN_L               EQU $78
MOVE_RYO_HAOH_SHOKOU_KEN_H               EQU $7A
MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_L        EQU $7C
MOVE_RYO_KYOKUKEN_RYU_RENBU_KEN_H        EQU $7E
MOVE_RYO_RYU_KO_RANBU_S                  EQU $80

MOVE_YURI_KO_OU_KEN_L                    EQU $64
MOVE_YURI_KO_OU_KEN_H                    EQU $66
MOVE_YURI_SAI_HA_L                       EQU $68
MOVE_YURI_SAI_HA_H                       EQU $6A
MOVE_YURI_HYAKU_RETSU_BINTA_L            EQU $6C
MOVE_YURI_HYAKU_RETSU_BINTA_H            EQU $6E
MOVE_YURI_KUU_GA_L                       EQU $70
MOVE_YURI_KUU_GA_H                       EQU $72
MOVE_YURI_RAI_OH_KEN_L                   EQU $74
MOVE_YURI_RAI_OH_KEN_H                   EQU $76
MOVE_YURI_HAOH_SHOUKOU_KEN_L             EQU $78
MOVE_YURI_HAOH_SHOUKOU_KEN_H             EQU $7A
MOVE_YURI_7C                             EQU $7C
MOVE_YURI_7E                             EQU $7E
MOVE_YURI_HIEN_HOU_OU_KYA_KU_S           EQU $80

MOVE_TERRY_POWER_WAVE_L                  EQU $64
MOVE_TERRY_POWER_WAVE_H                  EQU $66
MOVE_TERRY_BURN_KNUCKLE_L                EQU $68
MOVE_TERRY_BURN_KNUCKLE_H                EQU $6A
MOVE_TERRY_CRACK_SHOT_L                  EQU $6C
MOVE_TERRY_CRACK_SHOT_H                  EQU $6E
MOVE_TERRY_RISING_TACKLE_L               EQU $70
MOVE_TERRY_RISING_TACKLE_H               EQU $72
MOVE_TERRY_POWER_DUNK_L                  EQU $74
MOVE_TERRY_POWER_DUNK_H                  EQU $76
MOVE_TERRY_78                            EQU $78
MOVE_TERRY_7A                            EQU $7A
MOVE_TERRY_7C                            EQU $7C
MOVE_TERRY_7E                            EQU $7E
MOVE_TERRY_POWER_GEYSER_S                EQU $80

MOVE_JOE_HURRICANE_UPPER_L               EQU $64
MOVE_JOE_HURRICANE_UPPER_H               EQU $66
MOVE_JOE_SLASH_KICK_L                    EQU $68
MOVE_JOE_SLASH_KICK_H                    EQU $6A
MOVE_JOE_BAKURETSUKEN_L                  EQU $6C
MOVE_JOE_BAKURETSUKEN_H                  EQU $6E
MOVE_JOE_TIGER_KICK_L                    EQU $70
MOVE_JOE_TIGER_KICK_H                    EQU $72
MOVE_JOE_OUGON_NO_KAKATO_L               EQU $74
MOVE_JOE_OUGON_NO_KAKATO_H               EQU $76
MOVE_JOE_78                              EQU $78
MOVE_JOE_7A                              EQU $7A
MOVE_JOE_7C                              EQU $7C
MOVE_JOE_7E                              EQU $7E
MOVE_JOE_SCREW_UPPER_S                   EQU $80

MOVE_HEIDERN_CROSS_CUTTER_L              EQU $64
MOVE_HEIDERN_CROSS_CUTTER_H              EQU $66
MOVE_HEIDERN_NECK_ROLLER_L               EQU $68
MOVE_HEIDERN_NECK_ROLLER_H               EQU $6A
MOVE_HEIDERN_STORM_BRINGER_L             EQU $6C
MOVE_HEIDERN_STORM_BRINGER_H             EQU $6E
MOVE_HEIDERN_MOON_SLASHER_L              EQU $70
MOVE_HEIDERN_MOON_SLASHER_H              EQU $72
MOVE_HEIDERN_74                          EQU $74
MOVE_HEIDERN_76                          EQU $76
MOVE_HEIDERN_78                          EQU $78
MOVE_HEIDERN_7A                          EQU $7A
MOVE_HEIDERN_7C                          EQU $7C
MOVE_HEIDERN_7E                          EQU $7E
MOVE_HEIDERN_FINAL_BRINGER_S             EQU $80

MOVE_RALF_VULCAN_PUNCH_L                 EQU $64
MOVE_RALF_VULCAN_PUNCH_H                 EQU $66
MOVE_RALF_GATLING_ATTACK_L               EQU $68
MOVE_RALF_GATLING_ATTACK_H               EQU $6A
MOVE_RALF_BACK_BREAKER_L                 EQU $6C
MOVE_RALF_BACK_BREAKER_H                 EQU $6E
MOVE_RALF_BAKUDAN_PUNCH_L                EQU $70
MOVE_RALF_BAKUDAN_PUNCH_H                EQU $72
MOVE_RALF_74                             EQU $74
MOVE_RALF_76                             EQU $76
MOVE_RALF_78                             EQU $78
MOVE_RALF_7A                             EQU $7A
MOVE_RALF_7C                             EQU $7C
MOVE_RALF_7E                             EQU $7E
MOVE_RALF_BARIBARI_VULCAN_PUNCH_S        EQU $80

MOVE_ATHENA_PSYCHO_BALL_L                EQU $64
MOVE_ATHENA_PSYCHO_BALL_H                EQU $66
MOVE_ATHENA_PSYCHO_REFLECTOR_L           EQU $68
MOVE_ATHENA_PSYCHO_REFLECTOR_H           EQU $6A
MOVE_ATHENA_PSYCHO_SWORD_L               EQU $6C
MOVE_ATHENA_PSYCHO_SWORD_H               EQU $6E
MOVE_ATHENA_PHOENIX_ARROW_L              EQU $70
MOVE_ATHENA_PHOENIX_ARROW_H              EQU $72
MOVE_ATHENA_74                           EQU $74
MOVE_ATHENA_PHOENIX_ARROW_KICK_H         EQU $76
MOVE_ATHENA_78                           EQU $78
MOVE_ATHENA_7A                           EQU $7A
MOVE_ATHENA_7C                           EQU $7C
MOVE_ATHENA_7E                           EQU $7E
MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS       EQU $80

MOVE_KENSOU_CHOU_KYUU_DAN_L              EQU $64
MOVE_KENSOU_CHOU_KYUU_DAN_H              EQU $66
MOVE_KENSOU_RYUU_GAKU_SAI_L              EQU $68
MOVE_KENSOU_RYUU_GAKU_SAI_H              EQU $6A
MOVE_KENSOU_RYUU_REN_GA_L                EQU $6C
MOVE_KENSOU_RYUU_REN_GA_H                EQU $6E
MOVE_KENSOU_RYUU_SOU_GEKI_L              EQU $70
MOVE_KENSOU_RYUU_SOU_GEKI_H              EQU $72
MOVE_KENSOU_74                           EQU $74
MOVE_KENSOU_76                           EQU $76
MOVE_KENSOU_78                           EQU $78
MOVE_KENSOU_7A                           EQU $7A
MOVE_KENSOU_7C                           EQU $7C
MOVE_KENSOU_7E                           EQU $7E
MOVE_KENSOU_SHINRYUU_TENBU_KYAKU_S       EQU $80

MOVE_KIM_HAN_GETSU_ZAN_L                 EQU $64
MOVE_KIM_HAN_GETSU_ZAN_H                 EQU $66
MOVE_KIM_HIEN_ZAN_L                      EQU $68
MOVE_KIM_HIEN_ZAN_H                      EQU $6A
MOVE_KIM_HISHOU_KYAKU_L                  EQU $6C
MOVE_KIM_HISHOU_KYAKU_H                  EQU $6E
MOVE_KIM_RYUUSEI_RANKU_L                 EQU $70
MOVE_KIM_RYUUSEI_RANKU_H                 EQU $72
MOVE_KIM_74                              EQU $74
MOVE_KIM_76                              EQU $76
MOVE_KIM_78                              EQU $78
MOVE_KIM_7A                              EQU $7A
MOVE_KIM_7C                              EQU $7C
MOVE_KIM_7E                              EQU $7E
MOVE_KIM_HOU_OU_KYAKU_S                  EQU $80

MOVE_MAI_KA_CHO_SEN_L                    EQU $64
MOVE_MAI_KA_CHO_SEN_H                    EQU $66
MOVE_MAI_HISSATSU_SHINOBIBACHI_L         EQU $68
MOVE_MAI_HISSATSU_SHINOBIBACHI_H         EQU $6A
MOVE_MAI_RYU_EN_BU_L                     EQU $6C
MOVE_MAI_RYU_EN_BU_H                     EQU $6E
MOVE_MAI_HISHO_RYU_EN_JIN_L              EQU $70
MOVE_MAI_HISHO_RYU_EN_JIN_H              EQU $72
MOVE_MAI_CHIJOU_MUSASABI_L               EQU $74
MOVE_MAI_CHIJOU_MUSASABI_H               EQU $76
MOVE_MAI_KUUCHUU_MUSASABI_L              EQU $78
MOVE_MAI_KUUCHUU_MUSASABI_H              EQU $7A
MOVE_MAI_7C                              EQU $7C
MOVE_MAI_7E                              EQU $7E
MOVE_MAI_CHO_HISSATSU_SHINOBIBACHI_S     EQU $80

MOVE_IORI_YAMI_BARAI_L                   EQU $64
MOVE_IORI_YAMI_BARAI_H                   EQU $66
MOVE_IORI_ONI_YAKI_L                     EQU $68
MOVE_IORI_ONI_YAKI_H                     EQU $6A
MOVE_IORI_AOI_HANA_L                     EQU $6C
MOVE_IORI_AOI_HANA_H                     EQU $6E
MOVE_IORI_KOTO_TSUKI_IN_L                EQU $70
MOVE_IORI_KOTO_TSUKI_IN_H                EQU $72
MOVE_IORI_74                             EQU $74
MOVE_IORI_76                             EQU $76
MOVE_IORI_78                             EQU $78
MOVE_IORI_7A                             EQU $7A
MOVE_IORI_7C                             EQU $7C
MOVE_IORI_7E                             EQU $7E
MOVE_IORI_KIN_YA_OTOME_S                 EQU $80

MOVE_EIJI_KIKOUHOU_L                     EQU $64
MOVE_EIJI_KIKOUHOU_H                     EQU $66
MOVE_EIJI_KOTSU_HAZAKI_KIRI_L            EQU $68
MOVE_EIJI_KOTSU_HAZAKI_KIRI_H            EQU $6A
MOVE_EIJI_RYUU_EIJIN_L                   EQU $6C
MOVE_EIJI_RYUU_EIJIN_H                   EQU $6E
MOVE_EIJI_KASUMI_GERI_L                  EQU $70
MOVE_EIJI_KASUMI_GERI_H                  EQU $72
MOVE_EIJI_ZANTETSUHA_L                   EQU $74
MOVE_EIJI_ZANTETSUHA_H                   EQU $76
MOVE_EIJI_KAGE_UTSUSHI_L                 EQU $78
MOVE_EIJI_KAGE_UTSUSHI_H                 EQU $7A
MOVE_EIJI_TENBAKYAKU_L                   EQU $7C
MOVE_EIJI_TENBAKYAKU_H                   EQU $7E
MOVE_EIJI_ZANTETSU_TOUROUKEN_S           EQU $80

MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_L   EQU $64
MOVE_BILLY_SANSETSU_KON_CHUUDAN_UCHI_H   EQU $66
MOVE_BILLY_SENPUU_KON_L                  EQU $68
MOVE_BILLY_SENPUU_KON_H                  EQU $6A
MOVE_BILLY_SUZUME_OTOSHI_L               EQU $6C
MOVE_BILLY_SUZUME_OTOSHI_H               EQU $6E
MOVE_BILLY_KYOUSHUU_HISHOU_KON_L         EQU $70
MOVE_BILLY_KYOUSHUU_HISHOU_KON_H         EQU $72
MOVE_BILLY_74                            EQU $74
MOVE_BILLY_76                            EQU $76
MOVE_BILLY_78                            EQU $78
MOVE_BILLY_7A                            EQU $7A
MOVE_BILLY_7C                            EQU $7C
MOVE_BILLY_7E                            EQU $7E
MOVE_BILLY_CHOU_KAEN_SENPUU_KON_S        EQU $80

MOVE_SAISYU_YAMI_BARAI_L                 EQU $64
MOVE_SAISYU_YAMI_BARAI_H                 EQU $66
MOVE_SAISYU_ONI_YAKI_L                   EQU $68
MOVE_SAISYU_ONI_YAKI_H                   EQU $6A
MOVE_SAISYU_EN_JOU_L                     EQU $6C
MOVE_SAISYU_EN_JOU_H                     EQU $6E
MOVE_SAISYU_70                           EQU $70
MOVE_SAISYU_72                           EQU $72
MOVE_SAISYU_74                           EQU $74
MOVE_SAISYU_76                           EQU $76
MOVE_SAISYU_78                           EQU $78
MOVE_SAISYU_7A                           EQU $7A
MOVE_SAISYU_7C                           EQU $7C
MOVE_SAISYU_7E                           EQU $7E
MOVE_SAISYU_URA_OROCHI_NAGI_S            EQU $80

MOVE_RUGAL_REPPU_KEN_L                   EQU $64
MOVE_RUGAL_REPPU_KEN_H                   EQU $66
MOVE_RUGAL_GOD_PRESS_L                   EQU $68
MOVE_RUGAL_GOD_PRESS_H                   EQU $6A
MOVE_RUGAL_DARK_BARRIER_L                EQU $6C
MOVE_RUGAL_DARK_BARRIER_H                EQU $6E
MOVE_RUGAL_GENOCIDE_CUTTER_L             EQU $70
MOVE_RUGAL_GENOCIDE_CUTTER_H             EQU $72
MOVE_RUGAL_KAISER_WAVE_L                 EQU $74
MOVE_RUGAL_KAISER_WAVE_H                 EQU $76
MOVE_RUGAL_78                            EQU $78
MOVE_RUGAL_7A                            EQU $7A
MOVE_RUGAL_7C                            EQU $7C
MOVE_RUGAL_7E                            EQU $7E
MOVE_RUGAL_GIGANTIC_PRESSURE_S           EQU $80

MOVE_NAKORURU_AMUBE_YATORO_L             EQU $64
MOVE_NAKORURU_AMUBE_YATORO_H             EQU $66
MOVE_NAKORURU_ANNU_MUTSUBE_L             EQU $68
MOVE_NAKORURU_ANNU_MUTSUBE_H             EQU $6A
MOVE_NAKORURU_KAMUI_RIMSE_L              EQU $6C
MOVE_NAKORURU_KAMUI_RIMSE_H              EQU $6E
MOVE_NAKORURU_LELA_MUTSUBE_L             EQU $70
MOVE_NAKORURU_LELA_MUTSUBE_H             EQU $72
MOVE_NAKORURU_MAMAHAHA_FLIGHT_L          EQU $74
MOVE_NAKORURU_MAMAHAHA_FLIGHT_H          EQU $76
MOVE_NAKORURU_YATORO_POKKU_L             EQU $78
MOVE_NAKORURU_YATORO_POKKU_H             EQU $7A
MOVE_NAKORURU_KAMUI_MUTSUBE_L            EQU $7C
MOVE_NAKORURU_KAMUI_MUTSUBE_H            EQU $7E
MOVE_NAKORURU_ELERUSH_KAMUI_RIMSE_S      EQU $80

HITTYPE_BLOCKED              EQU $00 ; Nothing happens
HITTYPE_HIT_MID0             EQU $01 ; Standard hit #0
HITTYPE_HIT_MID1             EQU $02 ; Standard hit #1
HITTYPE_HIT_LOW              EQU $03 ; Punched or kicked while crouching
HITTYPE_SWEEP                EQU $04 ; Hit by a crouching heavy kick
HITTYPE_HIT_A                EQU $05 ; Hit by a normal while in the air
HITTYPE_LAUNCH_HIGH_UB       EQU $06 ; High throw arc (relative to the opponent)
HITTYPE_HIT_MULTI0           EQU $07 ; Mid-special move, chainable hit #0
HITTYPE_HIT_MULTI1           EQU $08 ; Mid-special move, chainable hit #1
HITTYPE_LAUNCH_FAST_DB       EQU $09 ; Diagonal down throw arc the player to the ground with screen shake - from air
HITTYPE_LAUNCH_SWOOPUP       EQU $0A ; Throw arc straight up, to off-screen
HITTYPE_LAUNCH_MID_UB_NOSTUN EQU $0B ; Medium-far throw arc, without hitstun
HITTYPE_GRAB_START           EQU $0C ; Start of the grab anim / throw sequence
HITTYPE_GRAB_UB_NOSYNC       EQU $0D ; Grab Rotation Frame #0, no position sync (graphic is character-specific)
HITTYPE_GRAB_FG_NOSYNC       EQU $0E ; Grab Rotation Frame #1, no position sync (graphic is character-specific)
HITTYPE_GRAB_UB_SYNC         EQU $0F ; Grab Rotation Frame, with position sync

HITTYPE_DUMMY                EQU $81 ; Placeholder used for empty slots in the special move entries


COLIBOX_00 EQU $00 ; None
COLIBOX_01 EQU $01
COLIBOX_02 EQU $02
COLIBOX_03 EQU $03
COLIBOX_04 EQU $04 ; Throw range
COLIBOX_05 EQU $05
COLIBOX_06 EQU $06
COLIBOX_07 EQU $07
COLIBOX_08 EQU $08
COLIBOX_09 EQU $09
COLIBOX_0A EQU $0A
COLIBOX_0B EQU $0B
COLIBOX_0C EQU $0C
COLIBOX_0D EQU $0D
COLIBOX_0E EQU $0E
COLIBOX_0F EQU $0F
COLIBOX_10 EQU $10
COLIBOX_11 EQU $11
COLIBOX_12 EQU $12
COLIBOX_13 EQU $13
COLIBOX_14 EQU $14
COLIBOX_15 EQU $15
COLIBOX_16 EQU $16
COLIBOX_17 EQU $17
COLIBOX_18 EQU $18
COLIBOX_19 EQU $19
COLIBOX_1A EQU $1A
COLIBOX_1B EQU $1B
COLIBOX_1C EQU $1C
COLIBOX_1D EQU $1D
COLIBOX_1E EQU $1E
COLIBOX_1F EQU $1F
COLIBOX_20 EQU $20
COLIBOX_21 EQU $21
COLIBOX_22 EQU $22
COLIBOX_23 EQU $23
COLIBOX_24 EQU $24
COLIBOX_25 EQU $25
COLIBOX_26 EQU $26
COLIBOX_27 EQU $27
COLIBOX_28 EQU $28
COLIBOX_29 EQU $29
COLIBOX_2A EQU $2A
COLIBOX_2B EQU $2B
COLIBOX_2C EQU $2C
COLIBOX_2D EQU $2D
COLIBOX_2E EQU $2E
COLIBOX_2F EQU $2F
COLIBOX_30 EQU $30
COLIBOX_31 EQU $31
COLIBOX_32 EQU $32
COLIBOX_33 EQU $33
COLIBOX_34 EQU $34

PROJ_PRIORITY_NODESPAWN EQU $02

; wPlayPlThrowActId
PLAY_THROWACT_NONE EQU $00
PLAY_THROWACT_START EQU $01
PLAY_THROWACT_NEXT02 EQU $02
PLAY_THROWACT_NEXT03 EQU $03
PLAY_THROWACT_NEXT04 EQU $04

; wPlayPlThrowOpMode
PLAY_THROWOP_GROUND EQU $00 ; The throw works on players on the ground
PLAY_THROWOP_AIR EQU $01 ; The throw works on players in the air
PLAY_THROWOP_UNUSED_BOTH EQU $02 ; [TCRF] Unused, works on both.

; wPlayPlThrowDir
PLAY_THROWDIR_B EQU $00
PLAY_THROWDIR_F EQU $01

; iOBJInfo_Proj_ThunderBall_Despawn
PROJ_TB_VISIBLE EQU $00
PROJ_TB_DESPAWN EQU $FF

; iOBJInfo_Proj_ShCrystCharge_OrbitMode
PROJ_SHCRYST_ORBITMODE_OVAL EQU $00 ; Phase 1 - Projectile orbits in an oval trajectory at constant speeed
PROJ_SHCRYST_ORBITMODE_SLOW EQU $01 ; Phase 2 - Only horizontal movement
PROJ_SHCRYST_ORBITMODE_HOLD EQU $02 ; Phase 2 - Only horizontal movement
PROJ_SHCRYST_ORBITMODE_SPIRAL EQU $FF ; Projectile moves in a spiral motion, expanding outwards, when releasing it early before phase 2

; iPlInfo_Nakoruru_MamahahaFlight_Mode
PBM_CHKCATCH   EQU $00 ; C backjump until touching the bird. It's possible for this to fail if the bird isn't there.
PBM_FLIGHT     EQU $01 ; Normal flight mode
PBM_FALL       EQU $02 ; Bird released, straight jump down

; iOBJInfo_Bird_Mode
PLAY_BIRD_MODE_INIT   EQU $00 ; Intro
PLAY_BIRD_MODE_IDLE   EQU $01 ; Main Gameplay
PLAY_BIRD_MODE_OUTRO  EQU $02 ; Outro
PLAY_BIRD_MODE_FLIGHT EQU $03 ; Flight mode

; Base gameplay
PL_FLOOR_POS EQU $74

PLAY_HEALTH_CRITICAL EQU $18 ; Threshold for critical health (allow infinite super & desperation supers)
PLAY_HEALTH_MAX      EQU $48 ; Health cap

PLAY_POW_EMPTY      EQU $00
PLAY_POW_MAX        EQU $38 ; Max value for normal POW bar
PLAY_POW_MAXPOW_INF EQU $FF ; Max Pow meter won't decrease with this
PLAY_POW_LAST_BAR   EQU $00
PLAY_POW_LAST_TEXT  EQU $01

PLAY_TID_BAR_BASE   EQU $D4 ; Tile ID base for bars
PLAY_TID_BAR_EMPTY  EQU $D5 ; Tile ID for an empty bar
PLAY_TID_BAR_FILLED EQU PLAY_TID_BAR_BASE ; Tile ID for a filled bar
PLAY_TID_BAR_SIZE   EQU $08 ; Number of tile IDs for tile parts, mapping to the LGrow/RGrow

PLAY_TID_BOX_FILL   EQU $70 ; Initial tile, top left
PLAY_TID_BOX_BLANK  EQU $74 ; Initial tile, top left

PLAY_OBJ_ROUNDTEXT_ROUND1     EQU $00
PLAY_OBJ_ROUNDTEXT_ROUND2     EQU $04
PLAY_OBJ_ROUNDTEXT_ROUND3     EQU $08
PLAY_OBJ_ROUNDTEXT_FINAL      EQU $0C
PLAY_OBJ_ROUNDTEXT_FIGHT      EQU $10
PLAY_OBJ_ROUNDTEXT_READY      EQU $14
PLAY_OBJ_ROUNDTEXT_GO         EQU $18
PLAY_OBJ_ROUNDTEXT_TIMEOVER   EQU $1C
PLAY_OBJ_ROUNDTEXT_DRAWGAME   EQU $20
PLAY_OBJ_ROUNDTEXT_DOUBLEKO   EQU $24
PLAY_OBJ_ROUNDTEXT_YOULOST    EQU $28
PLAY_OBJ_ROUNDTEXT_YOUWON     EQU $2C
PLAY_OBJ_ROUNDTEXT_1PWON      EQU $30
PLAY_OBJ_ROUNDTEXT_2PWON      EQU $34

; ============================================================
; WIN SCREEN

; wWinResult
WIN_VSWON1P    EQU $00
WIN_VSWON2P    EQU $01
WIN_SINGLEWON  EQU $02
WIN_SINGLELOST EQU $03
WIN_SINGLEDRAW EQU $04
WIN_VSDRAW     EQU $05

; Picture position ID, when setting screen palettes for the win screen
PIC_POS_L EQU 0 ; Left
PIC_POS_M EQU 1 ; Center
PIC_POS_R EQU 2 ; Right
