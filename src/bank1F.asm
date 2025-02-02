; 
; =============== START OF MODULE Sound ===============
;

; =============== INTERFACE ===============
Sound_Do:
	jp   Sound_Main_Do
Sound_Init:
	jp   Sound_Init_Do
Sound_Unused_PauseChPlayback:
	jp   Sound_Unused_PauseChPlayback_Do
Sound_Unused_UnpauseChPlayback:
	jp   Sound_Unused_UnpauseChPlayback_Do
	
; =============== Sound_Main_Do ===============
; Entry point of the main sound code.
Sound_Main_Do:
	; Check if there's anything new that we want to play
	call Sound_ChkNewSnd
	
	; Update the "SFX playing, mute BGM" flag for each channel
	call Sound_MarkAllSFXChUse
	
	;
	; Handle all of the sound channels.
	;
	ld   hl, wBGMCh1Info	; HL = Ptr to first SndInfo structure
	ld   a, $08			; Remaining SndInfo (4 channels, 2 sets (BGM + SFX))
	ld   [wSndChProcLeft], a
.loop:
	; Save a copy of the SndInfo ptr to RAM
	ld   a, l
	ldh  [hSndInfoCurPtr_Low], a
	ld   a, h
	ldh  [hSndInfoCurPtr_High], a

	push hl						; Save ptr to SndInfo
		ld   a, [hl]			; Read iSndInfo_Status
		bit  SISB_ENABLED, a	; Processing for the channel enabled?
		call nz, Sound_DoChSndInfo	; If so, call
		ld   hl, wSndChProcLeft ; SndInfoLeft--
		dec  [hl]				;
	pop  hl						; Restore SndInfo ptr

	; Seek to the next channel
	ld   de, SNDINFO_SIZE	; Ptr += SNDINFO_SIZE
	add  hl, de

	jr   nz, .loop			; If there are channels left to process, jump

	; Update the volume level timer
	ld   hl, wBGMCh1Info + iSndInfo_VolPredict
	ld   de, wBGMCh1Info + iSndInfo_RegNRx2Data
	call Sound_UpdateVolPredict
	ld   hl, wBGMCh2Info + iSndInfo_VolPredict
	ld   de, wBGMCh2Info + iSndInfo_RegNRx2Data
	call Sound_UpdateVolPredict
	ld   hl, wBGMCh4Info + iSndInfo_VolPredict
	ld   de, wBGMCh4Info + iSndInfo_RegNRx2Data
	call Sound_UpdateVolPredict
	
	; Handle fade ins/outs
	call Sound_ChkFade
	ret  
	
; =============== Sound_ChkNewSnd ===============
; Checks if we're trying to start a new BGM or SFX.
Sound_ChkNewSnd:

	;##
	; [TCRF] This sound driver supports the playback queue that 96 uses, but this game never writes to it.
	;        Instead, the new sound ID to play is written to a fixed address, wSndSet (see below).
	
	; The first counter is (meant to be) updated every time a new music track is started,
	; while the second one is increased when the new music track is requested.
	; If these value don't match, we know that we should play a new music track.
	ld   hl, hSndPlayCnt
	ldi  a, [hl]		; Read request counter
	cp   a, [hl]		; Does it match the playback counter?
	jr   z, .noReq		; If so, there's nothing new to play (always jumps)
	; We never get here
	dec  l			; Seek back to hSndPlayCnt
	
	; Increase the sound playback index/counter, looping it back to $00 if it would index past the end of the table
	; hSndPlayCnt = (hSndPlayCnt + 1) & $07
	ld   a, [hl]
	inc  a						; TblId++
	and  a, (SNDIDREQ_SIZE-1)	; Keep range
	ld   [hl], a				; Write it to hSndPlayCnt
	
	; To determine the ID of the music track to play, use the counter as index to the table at wSndIdReqTbl.
	; The value written there is treated as the sound ID.
	ld   hl, wSndIdReqTbl		; HL = wSndIdReqTbl
	add  a, l					; L += hSndPlayCnt
	ld   l, a
	ld   a, [hl]				; Read the sound ID
	
	; In the master sound list, the valid sounds have IDs >= $00 && < $5F
	; The entries written into the sound id request table have the MSB set, so the actual range check
	; is ID >= $80 && ID < $DF. Everything outside the range is rejected and stops all currently playing BGM/SFX.
	;
	; Only after the range check, these values are subtracted by $80 (SND_BASE).

	; Opcode read as "ld   bc, $803E"
	; This useless instruction prevents "ld   a, $80" from being executed.
	db   $01
.noReq:
	; When code executes this instruction, it prevents Sound_StopAll from being called and directly returns
	ld   a, SND_NONE
	;##
	
	
	; Determine the sound to play and range validate it.
	
	; [POI] This line seems like it was patched in to bypass the queue.
	;       The queue won't work unless this is removed.
	ld   a, [wSndSet]			; A = SndId (from the actual location 95 writes to)
	bit  7, a					; SndId < $80?
	jp   z, Sound_StopAll		; If so, jump
	cp   SNC_FADEOUT			; SndId == $F0?
	jp   z, Sound_TriggerFade	; If so, jump (never happens)
	cp   SND_LAST_VALID+1		; SndId >= $DF?
	jp   nc, Sound_StopAll		; If so, jump
	; Calculate the index to the next tables
	; BC = SndId - $80
	sub  a, SND_BASE				; Remove SND_BASE from the id
	ret  z							; Is it $00? (SND_NONE) If so, return
	ld   c, a
	ld   b, $00
	
	;--
	;
	; 1: BC = Sound_SndHeaderPtrTable[BC*2]
	;
	
	; HL = Ptr table to code
	ld   hl, Sound_SndHeaderPtrTable
	; Add index twice (each entry is 2 bytes)
	add  hl, bc
	add  hl, bc
	; Read out the ptr to BC
	ldi  a, [hl]			; seek to byte1
	ld   c, a
	ld   b, [hl]
	
	;--
	;
	; Get the code ptr for the init code for the sound.
	; The pointer table for these is stored exactly $00C0 bytes after the one for sound headers.
	;
	
	; Seek ahead to respective entry in code ptr table
	; -1 because of the ldi from before
	ld   de, (Sound_SndStartActionPtrTable-Sound_SndHeaderPtrTable)-1
	add  hl, de
	
	; Read out the ptr to HL
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a

	; Jump there
	jp   hl
	
; =============== Sound_SndHeaderPtrTable ===============
; Table of sound headers, ordered by ID.
; Each of the valid ones follows the format as specified in iSndHeader_*
;
; Blank entries in the table point to code, which is in no way a valid header.
; Unused but valid entries are all blank placeholder sound effects.
Sound_SndHeaderPtrTable:
	dw Sound_StartNothing;X            ; SND_NONE
	dw SndHeader_BGM_Nakoruru          ; BGM_NAKORURU
	dw SndHeader_BGM_CharSelect        ; BGM_CHARSELECT
	dw SndHeader_BGM_Intro             ; BGM_INTRO
	dw SndHeader_BGM_Boss              ; BGM_BOSS
	dw SndHeader_BGM_StageClear        ; BGM_STAGECLEAR
	dw SndHeader_BGM_Cutscene0         ; BGM_CUTSCENE0
	dw SndHeader_BGM_Cutscene1         ; BGM_CUTSCENE1
	dw SndHeader_BGM_GameOver          ; BGM_GAMEOVER
	dw SndHeader_BGM_Credits           ; BGM_CREDITS
	dw SndHeader_BGM_Stage             ; BGM_STAGE
	dw SndHeader_BGM_Ending            ; BGM_ENDING
	dw SndHeader_BGM_Unused_8C;X       ; #SND_ID_8C
	dw SndHeader_BGM_Unused_8D;X       ; #SND_ID_8D
	dw SndHeader_BGM_Unused_8E;X       ; #SND_ID_8E
	dw SndHeader_BGM_Unused_8F;X       ; #SND_ID_8F
	dw Sound_StartNothing;X            ; #SND_ID_90
	dw Sound_StartNothing;X            ; #SND_ID_91
	dw Sound_StartNothing;X            ; #SND_ID_92
	dw Sound_StartNothing;X            ; #SND_ID_93
	dw Sound_StartNothing;X            ; #SND_ID_94
	dw Sound_StartNothing;X            ; #SND_ID_95
	dw Sound_StartNothing;X            ; #SND_ID_96
	dw Sound_StartNothing;X            ; #SND_ID_97
	dw Sound_StartNothing;X            ; #SND_ID_98
	dw Sound_StartNothing;X            ; #SND_ID_99
	dw Sound_StartNothing;X            ; #SND_ID_9A
	dw Sound_StartNothing;X            ; #SND_ID_9B
	dw Sound_StartNothing;X            ; #SND_ID_9C
	dw Sound_StartNothing;X            ; #SND_ID_9D
	dw Sound_StartNothing;X            ; #SND_ID_9E
	dw Sound_StartNothing;X            ; #SND_ID_9F
	dw SndHeader_SFX_CursorMove        ; SFX_CURSORMOVE
	dw SndHeader_SFX_CharSelected      ; SFX_CHARSELECTED
	dw SndHeader_SFX_Hit               ; SFX_HIT
	dw SndHeader_SFX_Unused_HeavyHit   ; SFX_UNUSED_HEAVYHIT ; [TCRF] Not used by anything, only playable in the sound test.
	dw SndHeader_SFX_FireHit           ; SFX_FIREHIT
	dw SndHeader_SFX_Block             ; SFX_BLOCK
	dw SndHeader_SFX_GroundHit         ; SFX_GROUNDHIT
	dw SndHeader_SFX_Light             ; SFX_LIGHT
	dw SndHeader_SFX_Heavy             ; SFX_HEAVY
	dw SndHeader_SFX_Taunt             ; SFX_TAUNT
	dw SndHeader_SFX_Step              ; SFX_STEP
	dw SndHeader_SFX_Jump              ; SFX_JUMP
	dw SndHeader_SFX_Unused_Bomb       ; SFX_UNUSED_BOMB ; [TCRF] Not used by anything, only playable in the sound test.
	dw SndHeader_SFX_Unused_Bounce     ; SFX_UNUSED_BOUNCE ; [TCRF] Not used by anything, only playable in the sound test.
	dw SndHeader_SFX_ChargeMeter       ; SFX_CHARGEMETER
	dw SndHeader_SFX_Unused_StepB      ; SFX_UNUSED_STEP_B ; [TCRF] Not used by anything, only playable in the sound test.
	dw SndHeader_SFX_Special           ; SFX_SPECIAL
	dw SndHeader_SFX_Unused_SpecialB   ; SFX_UNUSED_SPECIAL_B  ; [TCRF] Not used by anything, only playable in the sound test.
	dw SndHeader_SFX_Reflect           ; SFX_REFLECT
	dw SndHeader_SFX_Error             ; SFX_ERROR
	dw SndHeader_SFX_Barrier           ; SFX_BARRIER
	dw SndHeader_SFX_ProjLg            ; SFX_PROJ_LG
	dw SndHeader_SFX_Dizzy             ; SFX_DIZZY
	dw SndHeader_SFX_Unused_B7;X       ; #SND_ID_B7
	dw SndHeader_SFX_Unused_B8;X       ; #SND_ID_B8
	dw SndHeader_SFX_Unused_B9;X       ; #SND_ID_B9
	dw SndHeader_SFX_Unused_BA;X       ; #SND_ID_BA
	dw SndHeader_SFX_Unused_BB;X       ; #SND_ID_BB
	dw SndHeader_SFX_Unused_BC;X       ; #SND_ID_BC
	dw SndHeader_SFX_Unused_BD;X       ; #SND_ID_BD
	dw SndHeader_SFX_Unused_BE;X       ; #SND_ID_BE
	dw SndHeader_SFX_Unused_BF;X       ; #SND_ID_BF
	dw SndHeader_SFX_Unused_C0;X       ; #SND_ID_C0
	dw SndHeader_SFX_Unused_C1;X       ; #SND_ID_C1
	dw SndHeader_SFX_Unused_C2;X       ; #SND_ID_C2
	dw SndHeader_SFX_Unused_C3;X       ; #SND_ID_C3
	dw SndHeader_SFX_Unused_C4;X       ; #SND_ID_C4
	dw SndHeader_SFX_Unused_C5;X       ; #SND_ID_C5
	dw SndHeader_SFX_Unused_C6;X       ; #SND_ID_C6
	dw SndHeader_SFX_Unused_C7;X       ; #SND_ID_C7
	dw SndHeader_SFX_Unused_C8;X       ; #SND_ID_C8
	dw SndHeader_SFX_Unused_C9;X       ; #SND_ID_C9
	dw SndHeader_SFX_Unused_CA;X       ; #SND_ID_CA
	dw SndHeader_SFX_Unused_CB;X       ; #SND_ID_CB
	dw SndHeader_SFX_Unused_CC;X       ; #SND_ID_CC
	dw SndHeader_SFX_Unused_CD;X       ; #SND_ID_CD
	dw SndHeader_SFX_Unused_CE;X       ; #SND_ID_CE
	dw SndHeader_SFX_Unused_CF;X       ; #SND_ID_CF
	dw SndHeader_SFX_Unused_D0;X       ; #SND_ID_D0
	dw SndHeader_SFX_Unused_D1;X       ; #SND_ID_D1
	dw SndHeader_SFX_Unused_D2;X       ; #SND_ID_D2
	dw SndHeader_SFX_Unused_D3;X       ; #SND_ID_D3
	dw SndHeader_SFX_Unused_D4;X       ; #SND_ID_D4
	dw SndHeader_SFX_Unused_D5;X       ; #SND_ID_D5
	dw SndHeader_SFX_Unused_D6;X       ; #SND_ID_D6
	dw SndHeader_SFX_Unused_D7;X       ; #SND_ID_D7
	dw SndHeader_SFX_Unused_D8;X       ; #SND_ID_D8
	dw SndHeader_SFX_Unused_D9;X       ; #SND_ID_D9
	dw SndHeader_SFX_Unused_DA;X       ; #SND_ID_DA
	dw SndHeader_SFX_Unused_DB;X       ; #SND_ID_DB
	dw SndHeader_SFX_Unused_DC;X       ; #SND_ID_DC
	dw SndHeader_SFX_Unused_DD;X       ; #SND_ID_DD
	dw SndHeader_SFX_Unused_DE;X       ; #SND_ID_DE
	dw Sound_StartNothing;X            ; #
	
; =============== Sound_SndStartActionPtrTable ===============
; Sound command codes assignments. BGM always uses Sound_StartNewBGM, while sound effects pick it
; depending on the sound channel(s) the SFX needs to be played on.
; This is important because various subroutines pick a different base address for channel info,
; and you can only move down from there.
; (ie: when wSFXCh2Info is picked as base, the SFX can also use wSFXCh3Info and wSFXCh4Info, but not wSFXCh1Info)
;
; A few special commands are also here, like the Pause/Unpause one.
; Unused entries in the all table point to the dummy Sound_StartNothing.
Sound_SndStartActionPtrTable:
	dw Sound_StartNothing;X            ; SND_NONE
	dw Sound_StartNewBGM               ; BGM_NAKORURU
	dw Sound_StartNewBGM               ; BGM_CHARSELECT
	dw Sound_StartNewBGM               ; BGM_INTRO
	dw Sound_StartNewBGM               ; BGM_BOSS
	dw Sound_StartNewBGM               ; BGM_STAGECLEAR
	dw Sound_StartNewBGM               ; BGM_CUTSCENE0
	dw Sound_StartNewBGM               ; BGM_CUTSCENE1
	dw Sound_StartNewBGM               ; BGM_GAMEOVER
	dw Sound_StartNewBGM               ; BGM_CREDITS
	dw Sound_StartNewBGM               ; BGM_STAGE
	dw Sound_StartNewBGM               ; BGM_ENDING
	dw Sound_StartNewBGM;X             ; SND_ID_8C
	dw Sound_StartNewBGM;X             ; SND_ID_8D
	dw Sound_StartNewBGM;X             ; SND_ID_8E
	dw Sound_StartNewBGM;X             ; SND_ID_8F
	dw Sound_StartNothing;X            ; SND_ID_90
	dw Sound_StartNothing;X            ; SND_ID_91
	dw Sound_StartNothing;X            ; SND_ID_92
	dw Sound_StartNothing;X            ; SND_ID_93
	dw Sound_StartNothing;X            ; SND_ID_94
	dw Sound_StartNothing;X            ; SND_ID_95
	dw Sound_StartNothing;X            ; SND_ID_96
	dw Sound_StartNothing;X            ; SND_ID_97
	dw Sound_StartNothing;X            ; SND_ID_98
	dw Sound_StartNothing;X            ; SND_ID_99
	dw Sound_StartNothing;X            ; SND_ID_9A
	dw Sound_StartNothing;X            ; SND_ID_9B
	dw Sound_StartNothing;X            ; SND_ID_9C
	dw Sound_StartNothing;X            ; SND_ID_9D
	dw Sound_StartNothing;X            ; SND_ID_9E
	dw Sound_StartNothing;X            ; SND_ID_9F
	dw Sound_StartNewSFX234            ; SFX_CURSORMOVE
	dw Sound_StartNewSFX234            ; SFX_CHARSELECTED
	dw Sound_StartNewSFX4              ; SFX_HIT
	dw Sound_StartNewSFX4              ; SFX_UNUSED_HEAVYHIT
	dw Sound_StartNewSFX4              ; SFX_FIREHIT
	dw Sound_StartNewSFX4              ; SFX_BLOCK
	dw Sound_StartNewSFX4              ; SFX_GROUNDHIT
	dw Sound_StartNewSFX4              ; SFX_LIGHT
	dw Sound_StartNewSFX4              ; SFX_HEAVY
	dw Sound_StartNewSFX234            ; SFX_TAUNT
	dw Sound_StartNewSFX4              ; SFX_STEP
	dw Sound_StartNewSFX4              ; SFX_JUMP
	dw Sound_StartNewSFX4              ; SFX_UNUSED_BOMB
	dw Sound_StartNewSFX34             ; SFX_UNUSED_BOUNCE
	dw Sound_StartNewSFX234            ; SFX_CHARGEMETER
	dw Sound_StartNewSFX4              ; SFX_UNUSED_STEP_B
	dw Sound_StartNewSFX4              ; SFX_SPECIAL
	dw Sound_StartNewSFX4              ; SFX_UNUSED_SPECIAL_B
	dw Sound_StartNewSFX4              ; SFX_REFLECT
	dw Sound_StartNewSFX34             ; SFX_ERROR
	dw Sound_StartNewSFX4              ; SFX_BARRIER
	dw Sound_StartNewSFX4              ; SFX_PROJ_LG
	dw Sound_StartNewSFX4              ; SFX_DIZZY
	dw Sound_StartNewSFX34;X           ; SND_ID_B7
	dw Sound_StartNewSFX34;X           ; SND_ID_B8
	dw Sound_StartNewSFX4;X            ; SND_ID_B9
	dw Sound_StartNewSFX4;X            ; SND_ID_BA
	dw Sound_StartNewSFX234;X          ; SND_ID_BB
	dw Sound_StartNewSFX234;X          ; SND_ID_BC
	dw Sound_StartNewSFX234;X          ; SND_ID_BD
	dw Sound_StartNewSFX234;X          ; SND_ID_BE
	dw Sound_StartNewSFX234;X          ; SND_ID_BF
	dw Sound_StartNewSFX234;X          ; SND_ID_C0
	dw Sound_StartNewSFX34;X           ; SND_ID_C1
	dw Sound_StartNewSFX34;X           ; SND_ID_C2
	dw Sound_StartNewSFX234;X          ; SND_ID_C3
	dw Sound_StartNewSFX234;X          ; SND_ID_C4
	dw Sound_StartNewSFX4;X            ; SND_ID_C5
	dw Sound_StartNewSFX234;X          ; SND_ID_C6
	dw Sound_StartNewSFX234;X          ; SND_ID_C7
	dw Sound_StartNewSFX234;X          ; SND_ID_C8
	dw Sound_StartNewSFX234;X          ; SND_ID_C9
	dw Sound_StartNewSFX234;X          ; SND_ID_CA
	dw Sound_StartNewSFX4;X            ; SND_ID_CB
	dw Sound_StartNewSFX234;X          ; SND_ID_CC
	dw Sound_StartNewSFX234;X          ; SND_ID_CD
	dw Sound_StartNewSFX4;X            ; SND_ID_CE
	dw Sound_StartNewSFX4;X            ; SND_ID_CF
	dw Sound_StartNewSFX234;X          ; SND_ID_D0
	dw Sound_StartNewSFX234;X          ; SND_ID_D1
	dw Sound_StartNewSFX234;X          ; SND_ID_D2
	dw Sound_StartNewSFX234;X          ; SND_ID_D3
	dw Sound_StartNewSFX234;X          ; SND_ID_D4
	dw Sound_StartNewSFX234;X          ; SND_ID_D5
	dw Sound_StartNewSFX234;X          ; SND_ID_D6
	dw Sound_StartNewSFX234;X          ; SND_ID_D7
	dw Sound_StartNewSFX234;X          ; SND_ID_D8
	dw Sound_StartNewSFX34;X           ; SND_ID_D9
	dw Sound_StartNewSFX234;X          ; SND_ID_DA
	dw Sound_StartNewSFX234;X          ; SND_ID_DB
	dw Sound_StartNewSFX234;X          ; SND_ID_DC
	dw Sound_StartNewSFX4;X            ; SND_ID_DD
	dw Sound_StartNewSFX234;X          ; SND_ID_DE
	
; =============== Sound_StartNewBGM ===============
; Starts playback of a new BGM.
; IN
; - BC: Ptr to song data
Sound_StartNewBGM:
	xor  a
	ld   [wSnd_Unused_SfxPriority], a
	push bc
		call Sound_StopAll
	pop  bc
	ld   de, wBGMCh1Info
	jp   Sound_InitSongFromHeader
	
; =============== Sound_Unused_StartNewSFX1234 ===============
; [TCRF] Unreferenced code.
; Starts playback for a multi-channel SFX (uses ch1-2-3-4)
Sound_Unused_StartNewSFX1234:
	xor  a
	ldh  [rNR10], a
	ld   de, wSFXCh1Info
	call Sound_StopAll.initNR
	jr   Sound_InitSongFromHeader
	
; =============== Sound_StartNewSFX234 ===============
; Starts playback for a multi-channel SFX (uses ch2-3-4)
Sound_StartNewSFX234:
	ld   de, wSFXCh2Info
	jr   Sound_InitSongFromHeader
	
; =============== Sound_StartNewSFX234 ===============
; Starts playback for a multi-channel SFX (uses ch3-4)
Sound_StartNewSFX34:
	ld   de, wSFXCh3Info
	jr   Sound_InitSongFromHeader
	
; =============== Sound_StartNewSFX234 ===============
; Starts playback for a channel-4 only SFX (SFX4).
Sound_StartNewSFX4:
	ld   de, wSFXCh4Info
	; Fall-through
	
; =============== Sound_InitSongFromHeader ===============
; Copies song data from its header to multiple SndInfo.
; IN
; - BC: Ptr to sound header data
; - DE: Ptr to the initial SndInfo (destination)
Sound_InitSongFromHeader:
	call Sound_MuteCh4
	
	; HL = BC
	ld   l, c
	ld   h, b
	
	; A sound can take up multiple channels -- and channel info is stored into a $20 byte struct.
	; The first byte from the sound header marks how many channels ($20 byte blocks) need to be initialized.

	; B = Channels used
	ldi  a, [hl]
	ld   b, a
.chLoop:

	;
	; Copy over next 6 bytes
	; These map directly to the first six bytes of the SndInfo structure.
	;
	ld   c, $06
.sndiCpLoop:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  c
	jr   nz, .sndiCpLoop
	
	;
	; Then initialize other fields
	;
	
	; Point data "stack index" to the very end of the SndInfo structure
	ld   a, iSndInfo_End
	ld   [de], a			; Write to iSndInfo_DataPtrStackIdx
	inc  de

	; Set the lowest possible length target to handle new sound commands as soon as possible.
	ld   a, $01
	ld   [de], a			; Write to iSndInfo_LengthTarget
	inc  de

	;
	; Clear rest of the SndInfo ($18 bytes)
	;
	xor  a
	ld   c, SNDINFO_SIZE-iSndInfo_LengthTimer	; C = Bytes left
.clrLoop:
	ld   [de], a		; Clear
	inc  de
	dec  c				; Cleared all bytes?
	jr   nz, .clrLoop	; If not, loop

	dec  b				; Finished all loops?
	jr   nz, .chLoop	; If not, jump

	; Fall-through
	
; =============== Sound_StartNothing ===============
; Clears the requested sound ID, so it won't be started again in the next frame.
Sound_StartNothing:
	ld   a, SND_NONE
	ld   [wSndSet], a
	ret
	
; =============== Sound_DoChSndInfo ===============
; IN
; - HL: Ptr to start of the current sound channel info (iSndInfo_Status)
Sound_DoChSndInfo:
	; [TCRF] If the sound channel is paused, return immediately
	;        This is never set because 95 neglects to pause the music.
	bit  SISB_PAUSE, a
	ret  nz

	;------------
	;
	; HANDLE LENGTH.
	; Until the length timer reaches the target, return immediately to avoid updating the sound register settings.
	; When the values match, later on the timer is reset and a new length will be set.
	;
	; Compared to 96, this part uses subframes and the amount added to the timer isn't fixed.
	;
	
	; Get the current timer value for the channel.
	; DE = iSndInfo_LengthTimer*
	ld   bc, iSndInfo_LengthTimer	; Seek to timer
	add  hl, bc
	ld   d, [hl]			; D = iSndInfo_LengthTimer
	inc  hl
	ld   e, [hl]			; E = iSndInfo_LengthTimerSub
	
	; DE += (wSndSongSpeed << 8) + wSndSongSpeedSub
	push hl				; Save iSndInfo_LengthTimerSub ptr
		ld   a, [wSndSongSpeedSub]	; L = Subframes to add
		ld   l, a
		ld   a, [wSndSongSpeed]		; H = Frames to add
		ld   h, a
		add  hl, de						; Add them over
		ld   d, h						; DE = HL
		ld   e, l
	pop  hl				; Restore iSndInfo_LengthTimerSub ptr
	
	; Save it back
	ld   a, e			; Save subframes, seek back to iSndInfo_LengthTimer
	ldd  [hl], a		
	ld   a, d			; Save frames, seek back to iSndInfo_LengthTarget
	ldd  [hl], a
	
	; If the frame didn't reach the target yet, return
	cp   a, [hl]	; iSndInfo_LengthTarget < iSndInfo_LengthTimer?
	ret  c			; If so, return
	
	;------------

	;
	; Copy the currently processed SndInfo to its own working area.
	; After we're done we'll be copying it back.
	;
	ldh  a, [hSndInfoCurPtr_Low]	; HL = Source
	ld   l, a
	ldh  a, [hSndInfoCurPtr_High]
	ld   h, a
	ld   de, wSndInfoCur			; DE = Destination
	ld   b, SNDINFO_SIZE			; B = Bytes to copy
.toWkLoop:
	ldi  a, [hl]					; Read SndInfo
	ld   [de], a					; Write to wk
	inc  de
	dec  b							
	jr   nz, .toWkLoop
	
	;
	; DE = Song data ptr
	;
	ld   hl, wSndInfoCur+iSndInfo_DataPtr_Low
	ldi  a, [hl]
	ld   e, a
	ld   d, [hl]
	
; =============== Sound_DoChSndInfo_Loop ===============
Sound_DoChSndInfo_Loop:

	;
	; Read out a "command byte" from the data.
	; This can be either register data, a sound length, an index to frequency data or a command ID.
	;
	; If this is a command ID, most of the time, after the command is processed, a new "command byte" will
	; be immediately processed.
	;
	; If it's not a command ID or a sound length, the next data byte can optionally be a new sound length value
	; (which, again, will get applied immediately on the same frame).
	;
	ld   a, [de]		; A = Data value
	
	;
	; Point to the next data byte.
	; Later on we may be checking the new data byte.
	;
	inc  de
	
	;
	; If the value is higher than $E0, treat the "command byte" as a command ID.
	;
	cp   SNDCMD_BASE					; A >= $E0?
	jp   nc, Sound_DoCommandId			; If so, jump

.notCmd:
	;--
	;
	; Sound channel 4 is handled in a different way compared to the others.
	;
	; Checking if the 5th bit is set is enough (range >= $FF20 && < $FF40).
	;

	ld   hl, wSndInfoCur+iSndInfo_RegPtr
	bit  5, [hl]			; ptr >= $FF20?
	jr   z, .isCh123		; If not, jump
	
.isCh4:
	; If we're here, we're pointing to channel 4.
;--
	;
	; The data byte is treated differently depending on whether the SndInfo is for a sound effect or not.
	; - If it's a wSFXCh4Info, the byte is raw NR43 data.
	; - If it's a wBGMCh4Info, the byte follows similar rules to the standard case for other channels:
	;   - If the value is < $80, it's treated as a new target length
	;   - Otherwise, it's an (index - $80) to a table of NR42/NR43 data.
	;
	; A large amount of these checks are gone from 96's version.
	; In there, a data byte for channel 4 is *always* treated as raw NR43 data.
	;
	
	dec  hl					; Seek back to iSndInfo_Status
	bit  SISB_SFX, [hl]		; Is this a sound effect?
	jr   nz, .isSFXCh4		; If so, jump

.isBGMCh4:	
	;
	; If the value is < $80, directly treat it as the new target length
	; and don't update the registers.
	;
	cp   SNDNOTE_BASE			; Value < $80?
	jp   c, .setLength			; If so, treat it as a new target
	
	;------

	
	;
	; Otherwise, clear the MSB and treat it as an index to a table of NR42/NR43 data.
	;
	; HL = .ch4FreqTbl[(A - SNDNOTE_BASE) * 2]
	;
	sub  a, SNDNOTE_BASE	; Remove MSB
	ld   hl, .ch4FreqTbl	; HL = Freq Table Base
	
	ld   c, a				; Index it
	ld   b, $00
	add  hl, bc
	add  hl, bc
	
	;--
	; SOUND REG PTR
	;
	; Read the ptr to NR42
	;
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]	; NR43
	dec  a									; -1, to NR42
	ld   c, a
	
	;--
	; byte0 -> NR42 data
	;
	; A = iSndInfo_FreqDataIdBase + byte0
	;
	; Unlike other channels, iSndInfo_FreqDataIdBase is not added to the table index,
	; but directly added to the NR42 value. 
	ld   a, [wSndInfoCur+iSndInfo_FreqDataIdBase]
	add  a, [hl]
	
	;--
	; byte1 -> NR43 data
	;
	; B = byte1, without changes
	inc  hl											
	ld   b, [hl]

	; -> write A to iSndInfo_RegNRx2Data, then update the sound register
	ld   [wSndInfoCur+iSndInfo_RegNRx2Data], a
	call Sound_WriteToReg
	
	; -> reset the volume prediction timer
	and  a, $F0									; Remove low nybble
	ld   [wSndInfoCur+iSndInfo_VolPredict], a
	
	; -> write B to iSndInfo_RegNRx3Data, then update the sound register when it jumps to .updateRegs
	ld   a, b
	
.isSFXCh4:
	; (If we jumped to here, "A" will contain the raw data byte)
	ld   [wSndInfoCur+iSndInfo_RegNRx3Data], a
	
	; -> apply the changes to this channel by resetting NR44
	xor  a
	ld   [wSndInfoCur+iSndInfo_RegNRx4Data], a
	jr   .updateRegs
	
; =============== .ch4FreqTbl ===============
; Table of ch4 NR42/NR43 data.
; [TCRF] Half of these settings aren't used.
.ch4FreqTbl:
	;   42  43
	db $00,$00 ; $80 ; B-6
	db $51,$36 ; $81 ; F-5
	db $52,$24 ; $82 ; B-5
	db $31,$21 ; $83 ; Between C-6 & B-5
	db $53,$11 ; $84 ; Between D#6 & E-6
	db $53,$11 ; $85 ; Between D#6 & E-6 ;X
	db $53,$11 ; $86 ; Between D#6 & E-6 ;X
	db $52,$36 ; $87 ; F-5 ;X
	db $52,$36 ; $88 ; F-5 ;X
	db $52,$36 ; $89 ; F-5 ;X
;--

.isCh123:
	;
	; If the value is < $80, directly treat it as the new target length
	; and don't update the registers.
	;
	cp   SNDNOTE_BASE	; A < $80? (MSB clear?)
	jp   c, .setLength	; If so, skip ahead a lot


	;------

	;
	; Otherwise, clear the MSB and treat it as a secondary index to a table of NRx3/NRx4 register data.
	; If the index is != 0, add the contents of iSndInfo_FreqDataIdBase to the index.
	;

	sub  a, SNDNOTE_BASE	; Clear MSB
	jr   z, .readRegData	; If the index is $00, don't add anything else
	ld   hl, wSndInfoCur+iSndInfo_FreqDataIdBase
	add  a, [hl]			; A += *iSndInfo_FreqDataIdBase

.readRegData:

	;
	; Index the table of register data.
	; HL = Sound_FreqDataTbl[A * 2]
	;

	; offset table with 2 byte entries
	ld   hl, Sound_FreqDataTbl	; HL = Tbl
	ld   c, a					; BC = A
	ld   b, $00
	add  hl, bc					; HL += BC * 2
	add  hl, bc

	; write the entries from the table in ROM to the Frequency SndInfo in RAM
	ldi  a, [hl]								; Read out byte0, seek next
	ld   [wSndInfoCur+iSndInfo_RegNRx3Data], a
	ld   a, [hl]								; Read out byte1
	ld   [wSndInfoCur+iSndInfo_RegNRx4Data], a
	;------

.updateRegs:

	;--
	;
	; This part does the direct updates to the sound register sets, now that everything
	; has been set (through command IDs and/or note ids) in the SndInfo fields.
	;
	; Since the registers "are in HRAM" all of the pointers pass through C and the data is written through "ld [c], a" instructions.
	; Depending on the status flags, more or less data will be written in sequence.
	;

	ld   a, [wSndInfoCur+iSndInfo_Status]

	;
	; If a SFX is marked as currently playing for the channel, skip updating the sound registers.
	; This can only jump if the current handled SndInfo set is for a BGM.
	;
	bit  SISB_USEDBYSFX, a		; Is the bit set?
	jr   nz, .chkNewLength		; If so, skip ahead
;##
	;
	; Set the 'z' flag for a later check.
	; If set, we won't be updating rNRx2 (C-1).
	;

	bit  SISB_LOCKNRx2, a			; ### Is the bit set?...

	;
	; Read out the current 1-byte register pointer from iSndInfo_RegPtr to C.
	;

	ld   a, [wSndInfoCur+iSndInfo_RegPtr]	; Read out the ptr to NRx3
	ld   c, a								; Store it to C for $FF00+C access
	
	; Check if we're skipping NRx2
	jr   nz, .updateNRx3					; ### ...if so, skip
	
.updateNRx2:
	;
	; Update NRx2 with the contents of iSndInfo_RegNRx2Data
	;
	
	dec  c									; C--, to NRx2
	
	ld   a, [wSndInfoCur+iSndInfo_RegNRx2Data]	; Read out iSndInfo_RegNRx2Data
	ld   [c], a									; Write to sound register
	
	inc  c									; C++, to NRx3
	

.updateNRx3:

	;
	; Update NRx3 with the contents of iSndInfo_RegNRx3Data
	;

	ld   a, [wSndInfoCur+iSndInfo_RegNRx3Data]	; Read out iSndInfo_RegNRx3Data
	ld   [c], a									; Write to sound register
	inc  c										; Next register
	
.updateNRx4:
	;
	; Update NRx4 with the contents of iSndInfo_RegNRx4Data
	;
	ld   a, [wSndInfoCur+iSndInfo_RegNRx4Data]	; Read out iSndInfo_RegNRx4Data
	ld   [c], a									; Write to sound register
;##

.chkNewLength:


	;
	; NOTE: At the start of the loop, we incremented the data byte.
	;
	; After passing through the custom register update, an additional byte
	; may be used to specify a new length target.
	;

	;
	; If the (new) data byte is < $80, treat it as a new length target.
	; Otherwise, ignore it completely.
	;

	ld   a, [de]			; Read data byte
	cp   $80				; A >= $80?
	jr   nc, .saveDataPtr	; If so, skip
	
	; Seek to next data byte, use current as length target
	inc  de
.setLength:
	ld   [wSndInfoCur+iSndInfo_LengthTarget], a
	
.saveDataPtr:

	;
	; Save back the updated data pointer from DE back to the SndInfo
	;
	ld   hl, wSndInfoCur+iSndInfo_DataPtr_Low	; HL = Data ptr in SndInfo
	ld   a, e
	ldi  [hl], a								; Save low byte to SndInfo
	ld   [hl], d								; Save high byte to SndInfo
	
	;
	; Reset the length timer
	;
	xor  a
	ld   [wSndInfoCur+iSndInfo_LengthTimer], a

	;
	; Reset the volume prediction timer
	;
	ld   a, [wSndInfoCur+iSndInfo_VolPredict]
	and  a, $F0									; Remove low nybble
	ld   [wSndInfoCur+iSndInfo_VolPredict], a
	
	;
	; The remainder of the subroutine involves checks for muting the sound channel.
	;
	; If we're a BGM SndInfo and the channel is in use by a sound effect, 
	; return immediately to avoid interfering.
	;
	ld   a, [wSndInfoCur+iSndInfo_Status]	; Read iSndInfo_Status
	bit  SISB_USEDBYSFX, a					; Is a sound effect playing on the channel?
	jp   nz, Sound_DoChSndInfo_End			; If so, return (jumps to ret)

	;
	; If both frequency bytes are zero, mute the sound channel.
	;
.chkMuteMode:

	ld   hl, wSndInfoCur+iSndInfo_RegNRx3Data
	ldi  a, [hl]				; iSndInfo_RegNRx3Data != 0
	or   a, [hl]				; || iSndInfo_RegNRx4Data != 0?
	jr   nz, .chkReinit			; If so, skip ahead

.chkMuteCh:
	; Mute the appropriate sound channel
	call Sound_DoChSndInfo_ChkMuteCh
	jp   Sound_DoChSndInfo_End
	
.chkReinit:
	; If we skipped the NRx2 update (volume + ...), return immediately
	ld   a, [wSndInfoCur+iSndInfo_Status]
	bit  SISB_LOCKNRx2, a
	jp   nz, Sound_DoChSndInfo_End
	
	; Re-initialize the appropriate sound channel
	ld   hl, wSndInfoCur+iSndInfo_ChEnaMask
	call Sound_DoChSndInfo_Reinit
	
.noStop:
	; Restart the channel playback
	ld   a, [wSndInfoCur+iSndInfo_RegNRx4Data]
	set  SNDCHFB_RESTART, a			; Restart channel
	and  a, $FF^SNDCHF_LENSTOP		; Remove SNDCHF_LENSTOP flag
	ld   [c], a
	
	; Fall-through
	
; =============== Sound_DoChSndInfo_End ===============
; Writes the currently processed SndInfo back.
Sound_DoChSndInfo_End:

	;
	; Save back the changes from working area to the SndInfo.
	;
	ldh  a, [hSndInfoCurPtr_Low]	; HL = Destination
	ld   l, a
	ldh  a, [hSndInfoCurPtr_High]
	ld   h, a
	ld   de, wSndInfoCur			; DE = Source
	ld   b, SNDINFO_SIZE			; B = Bytes to copy
.frWkLoop:
	ld   a, [de]					; Read wk
	ldi  [hl], a					; Write to SndInfo
	inc  de
	dec  b							
	jr   nz, .frWkLoop

	ret  
	
; =============== Sound_DoChSndInfo_Reinit ===============
; Reinitializes the current sound channel (setting rNR51 status + extra registers).
;
; IN
; - HL: Ptr to iSndInfo_ChEnaMask field, where the default rNR51 status is set.
; OUT
; - C: Ptr to NRx4
Sound_DoChSndInfo_Reinit:
	
	; Read iSndInfo_RegPtr to A for the upcoming check
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]
	
	; C = A+1 for later (after this subroutine returns)
	; Increased by 1 since the high byte of the frequency is what contains extra flags
	ld   c, a
	inc  c

	; Depending on the source address enable the correct sound registers
	cp   SND_CH1_PTR	; A == SND_CH1_PTR? Handling channel 1?
	jr   z, .setCh1Ena		; If so, jump
	cp   SND_CH2_PTR	; ...
	jr   z, .setCh2Ena
	cp   SND_CH3_PTR
	jr   z, .setCh3Ena
	cp   SND_CH4_PTR
	jr   z, .setCh4Ena
	ret ; We never get here
.setCh1Ena:
	; Get the bits to OR over rNR51 from the initial sound output status
	; A = iSndInfo_ChEnaMask & $11
	ld   a, [hl]		; Read iSndInfo_ChEnaMask
	and  a, %00010001	; Filter away bits for the other channel numbers
	jr   .setChEna
.setCh2Ena:
	ld   a, [hl]
	and  a, %00100010
	jr   .setChEna
.setCh3Ena:
	; Clear and re-enable channel 3
	ld   a, SNDCH3_OFF
	ldh  [rNR30], a
	ld   a, SNDCH3_ON
	ldh  [rNR30], a

	; Update playback status
	ld   a, [hl]
	and  a, %01000100
	jr   .setChEna
.setCh4Ena:
	ld   a, [hl]
	and  a, %10001000
	jr   .setChEna
	
.setChEna:
	; OR the bits from before with rNR51 to re-enable (if needed) the sound channel playback
	ld   b, a
	ldh  a, [rNR51]
	or   b
	ldh  [rNR51], a
	ret  
	
; =============== Sound_DoChSndInfo_Reinit ===============
; Depending on the currently modified channel, decides which channel to mute.
;
; This is done by checking at the register ptr, which doubles as channel marker.
; It will only ever point to the 4th register (rNRx3) of any given sound channel, thankfully.
Sound_DoChSndInfo_ChkMuteCh:

	; Depending on the source address...
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]
	cp   SND_CH1_PTR
	jr   z, .muteCh1
	cp   SND_CH2_PTR
	jr   z, .muteCh2
	cp   SND_CH3_PTR
	jr   z, .muteCh3
	cp   SND_CH4_PTR
	jr   z, .muteCh4
	ret ; We never get here
.muteCh1:
	ldh  a, [rNR51]
	and  a, %11101110
	jr   .muteEnd
.muteCh2:
	ldh  a, [rNR51]
	and  a, %11011101
	jr   .muteEnd
.muteCh3:
	ld   a, SNDCH3_OFF		; ch3 has also its own mute register
	ldh  [rNR30], a
	ldh  a, [rNR51]
	and  a, %10111011
	jr   .muteEnd
.muteCh4:
	ldh  a, [rNR51]
	and  a, %01110111
.muteEnd:
	ldh  [rNR51], a
	ret  
	
; =============== Sound_DoCommandId ===============
; Handles the specified command ID, which mostly involves different ways of writing out data to the SndInfo.
; IN
; - A: Command ID (+ $E0)
; - DE: SndInfo base ptr
Sound_DoCommandId:

	; After the function in the jump table executes, increment the data ptr
	; *AND* return to the normal custom data update loop.
	; Make the next 'ret' instruction jump to Sound_IncDataPtr
	ld   hl, Sound_IncDataPtr
	push hl

	;
	; Index the command fetch ptr table.
	;

	; Get rid of the upper three bits of the command id (essentially subtracting $E0).
	; The resulting value is perfectly in range of the command table at Sound_CmdPtrTbl.
	and  a, $1F				; A -= SNDCMD_BASE

	ld   hl, Sound_CmdPtrTbl; HL = Ptr table
	ld   c, a				; BC = A * 2
	ld   b, $00
	add  hl, bc
	add  hl, bc
	ldi  a, [hl]			; Read out the ptr to HL
	ld   h, [hl]
	ld   l, a
	jp   hl					; Jump there
	
; =============== Sound_IncDataPtr ===============
; Increases the data pointer, then returns to the loop.
Sound_IncDataPtr:
	inc  de
	jp   Sound_DoChSndInfo_Loop
	
Sound_CmdPtrTbl:
	dw Sound_Unused_DecDataPtr;X			; $00
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Cmd_ChanStop_NoFadeChg;X
	dw Sound_Cmd_WriteToNRx2
	dw Sound_Cmd_JpFromLoop
	dw Sound_Cmd_AddToBaseFreqId
	dw Sound_Cmd_JpFromLoopByTimer
	dw Sound_Cmd_WriteToNR10;X				; $08
	dw Sound_Cmd_SetPanning
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Cmd_Call
	dw Sound_Cmd_Ret
	dw Sound_Cmd_WriteToNRx1
	dw Sound_Cmd_LockNRx2
	dw Sound_Cmd_UnlockNRx2;X				; $10
	dw Sound_Cmd_SetVibrato
	dw Sound_Cmd_ClrVibrato;X
	dw Sound_Cmd_SetWaveData
	dw Sound_Cmd_ChanStop
	dw Sound_Cmd_WriteToNR31;X
	dw Sound_Cmd_SetSpeed
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X			; $18
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Cmd_ExtendNote
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X
	dw Sound_Unused_DecDataPtr;X			; $1F

; =============== Sound_Unused_DecDataPtr ===============
; [TCRF] Unused in this game. Other commands opt to do this manually.
; Decrements the data ptr by 1.
; If called once, it balances out the Sound_IncDataPtr that's always called after Sound_DoCommandId is executed.
Sound_Unused_DecDataPtr: 
	dec  de
	ret
	
; =============== Sound_Cmd_SetSpeed ===============
; Sets a new song speed.
; This is a global value, which affects every song played from this point on.
; Command data format:
; - 0: Song speed (subframes)
; - 1: Song speed (frames)
Sound_Cmd_SetSpeed:
	ld   a, [de]					; byte0
	ld   [wSndSongSpeedSub], a
	inc  de
	ld   a, [de]					; byte1
	ld   [wSndSongSpeed], a
	ret  
	
; =============== Sound_Cmd_WriteToNR31 ===============
; [TCRF] Unused subroutine.
; Sets a new length value for channel 3 and applies it immediately.
; Command data format:
; - 0: New length value
Sound_Cmd_WriteToNR31:
	; Read a value off the data ptr.
	; wSnd_Unused_Ch3DelayCut = ^(*DE)
	; Unlike 96, this isn't read anywhere else, as NR31 isn't reset to the last written value when a new note starts.
	ld   a, [de]
	cpl  
	ld   [wSnd_Unused_Ch3DelayCut], a
	
	; [POI] In 96, this checked for $FF instead, the result of xoring 0.
	or   a
	ret  z
	ldh  [rNR31], a
	ret
	
; =============== Sound_Cmd_AddToBaseFreqId ===============
; Increases the base frequency index by the read amount.
; Command data format:
; - 0: Frequency id offset
Sound_Cmd_AddToBaseFreqId:
	; Read a value off the data ptr.
	ld   a, [de]
	
	; Add the value to iSndInfo_FreqDataIdBase
	ld   hl, wSndInfoCur+iSndInfo_FreqDataIdBase
	add  a, [hl]			; A += iSndInfo_FreqDataIdBase
	ld   [hl], a			; Save it back
	ret  
	
; =============== Sound_Cmd_SetVibrato ===============
; [TCRF] Enables vibrato in later versions of the driver, but does nothing here.
;        Bizzarely used by the Game Over song.
Sound_Cmd_SetVibrato:
	; Enable the feature
	ld   a, [wSndInfoCur+iSndInfo_Status]
	set  SISB_VIBRATO, a
	ld   [wSndInfoCur+iSndInfo_Status], a
	
	; Rewind the data offset
	xor  a
	ld   [wSndInfoCur+iSndInfo_VibratoDataOffset], a
	
	; Don't increase data ptr
	dec  de
	ret  
	
; =============== Sound_Cmd_ClrVibrato ===============
; [TCRF] Unused subroutine.
;        Disables vibrato.
Sound_Cmd_ClrVibrato:
	ld   a, [wSndInfoCur+iSndInfo_Status]
	res  SISB_VIBRATO, a
	ld   [wSndInfoCur+iSndInfo_Status], a
	
	; Don't increase data ptr
	dec  de
	ret
	
; =============== Sound_Cmd_ClrSkipNRx2 ===============
; [TCRF] Unused subroutine.
;        Clears disable flag for NRx2 writes
Sound_Cmd_UnlockNRx2:
	ld   a, [wSndInfoCur+iSndInfo_Status]
	res  SISB_LOCKNRx2, a
	ld   [wSndInfoCur+iSndInfo_Status], a

	; Don't increase data ptr
	dec  de
	ret
	
; =============== Sound_Cmd_LockNRx2 ===============
; Sets disable flag for NRx2 writes
Sound_Cmd_LockNRx2:
	ld   a, [wSndInfoCur+iSndInfo_Status]
	set  SISB_LOCKNRx2, a
	ld   [wSndInfoCur+iSndInfo_Status], a

	; Don't increase data ptr
	dec  de
	ret  
	
; =============== Sound_Cmd_ExtendNote ===============
; Extends the current note without restarting it.
; This doesn't return to the sync loop, since it counts as a note.
; Command data format:
; - 0: Length target
Sound_Cmd_ExtendNote:

	;
	; The current data byte is a length target.
	; Write it over.
	;
	ld   a, [de]
	ld   [wSndInfoCur+iSndInfo_LengthTarget], a
	
	; Seek to next byte now, do not return to Sound_IncDataPtr / data loop.
	inc  de
	pop  hl
	
	;
	; Update the data pointer
	;
	ld   hl, wSndInfoCur+iSndInfo_DataPtr_Low
	ld   a, e
	ldi  [hl], a		; Write E to iSndInfo_DataPtr_Low
	ld   [hl], d		; Write D to iSndInfo_DataPtr_High
	
	;
	; Reset the length timer.
	;
	xor  a
	ld   [wSndInfoCur+iSndInfo_LengthTimer], a
	
	; Save back changes
	jp   Sound_DoChSndInfo_End
	
; =============== Sound_Cmd_SetPanning ===============
; Sets the channel's stereo panning.
; Updates NR51, but the bits affected should only affect the current channel.
;
; Command data format:
; - 0: Channels to enable
Sound_Cmd_SetPanning:
	; C = Enabled channels
	ldh  a, [rNR51]
	ld   c, a
	
	;--
	; Merge the enabled channels with the existing settings
	;
	; If the enabled channels are the same on both the left and right side,
	; which appears to ALWAYS be the case, the operation is essentially rNR51 |= (data byte).
	;
	; When they aren't, the operation makes no sense.
	ld   a, [de]	; B = Enabled channels
	ld   b, a
	swap a			; Switch left/right sides
	cpl				; Mark disabled channels with 1
	and  a, c		; A = (A & C) | B
	or   b
	;--
	
	; Set the updated NR51 value
	ld   [wSndInfoCur+iSndInfo_ChEnaMask], a
	ldh  [rNR51], a
	
	;
	; [POI] If we did this in the context of a BGM, merge NR51 and all of their local SndInfo
	;       versions into wSnd_Unused_EnaChBGM.
	;       Problem is, wSnd_Unused_EnaChBGM is never read from anywhere else; the code that would have
	;       done so is only in 96.
	;       In 96, it was used to restore the NR51 value when a sound effect channel ended,
	;       which this game doesn't do.
	;
	ld   hl, wSndInfoCur
	bit  SISB_SFX, [hl]		; Are we a sound effect?
	ret  nz					; If so, return
	ld   hl, wBGMCh1Info+iSndInfo_ChEnaMask
	or   a, [hl]								; Merge ch1
	ld   hl, wBGMCh2Info+iSndInfo_ChEnaMask
	or   a, [hl]								; Merge ch2
	ld   hl, wBGMCh3Info+iSndInfo_ChEnaMask
	or   a, [hl]
	ld   hl, wBGMCh4Info+iSndInfo_ChEnaMask
	or   a, [hl]
	ld   [wSnd_Unused_EnaChBGM], a
	ret
	
; =============== Sound_Cmd_WriteToNRx2 ===============
; Writes the current sound channel data to NRx2, and updates the additional SndInfo fields.
; Should only be used by BGM.
;
; Command data format:
; - 0: Sound register data
Sound_Cmd_WriteToNRx2:

	;--
	; SOUND REG PTR
	;
	; First read the location we have to write to
	;
	
	; Read the ptr to NRx2
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]	; A = NRx3
	dec  a									; Seek back to NRx2
	ld   c, a
	
	;--
	; SOUND REG VALUE
	;
	; Then read the value we will be writing.
	; This will be written to multiple locations.
	;
	
	; -> write it to iSndInfo_RegNRx2Data
	;    (since we decremented C before, that's the correct place)
	ld   a, [de]
	ld   [wSndInfoCur+iSndInfo_RegNRx2Data], a

	; -> write it to the aforemented sound register if possible
	call Sound_WriteToReg
	
	; -> write it to iSndInfo_VolPredict, with the low nybble cleared
	;    (since we have set a new volume value, the prediction should restart)
	and  a, $F0									; Erase timer nybble
	ld   [wSndInfoCur+iSndInfo_VolPredict], a
	ret  
	
; =============== Sound_Cmd_WriteToNRx1 ===============
; Writes the current sound channel data to NRx1, and updates the additional SndInfo fields.
; Should only be used by BGM.
;
; Command data format:
; - 0: Sound register data
Sound_Cmd_WriteToNRx1:
	; Seek to NRx1 and...
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]
	dec  a
	dec  a
	ld   c, a
	
	; -> write the data byte to iSndInfo_RegNRx1Data
	ld   a, [de]
	ld   [wSndInfoCur+iSndInfo_RegNRx1Data], a
	
	; -> write it to the aforemented sound register if possible
	call Sound_WriteToReg
	ret
	
; =============== Sound_Cmd_WriteToNR10 ===============
; [TCRF] Unused command.
; Writes the current sound channel data to rNR10 and updates the bookkeeping value.
;
; Command data format:
; - 0: Sound channel data for NR10
Sound_Cmd_WriteToNR10:

	; Read sound channel data value to A
	ld   a, [de]
	
	; Update the bookkeeping value
	ld   [wSndInfoCur+iSndInfo_RegNR10Data], a
	
	; Write to the sound register if possible
	ld   c, LOW(rNR10)
	call Sound_WriteToReg
	ret
	
; =============== Sound_Cmd_JpFromLoopByTimer ===============
; Loops the sound channel a certain amount of times.
; Depending on the loop timer table index in data byte 0, bytes 1-2 may be set as the new hSndInfoCurDataPtr.
;
; Command data format:
; - 0: Loop timer ID
; - 1: Initial timer value (used when the existing timer is 0)
; - 2: Dest. Sound data ptr (low byte)
; - 3: Dest. Sound data ptr (high byte)
;
; This command is a superset of what's used by Sound_Cmd_JpFromLoop, so the game can seek to byte2
; and then jump directly to Sound_Cmd_JpFromLoop.
Sound_Cmd_JpFromLoopByTimer:

	; The first byte is the index to the table at iSndInfo_LoopTimerTbl
	; After indexing the value, that gets decremented. If it's already 0 the next data byte is treated as new table value.

	; byte0 - Read the timer ID to C add it to the base table offset
	; BC = iSndInfo_LoopTimerTbl + byte0
	ld   a, [de]					; Read byte0
	inc  de							; Seek to next
	add  a, iSndInfo_LoopTimerTbl	; Add table base
	ld   c, a
	ld   b, $00	
	
	; Seek to iSndInfo_LoopTimerTbl[C]
	ld   hl, wSndInfoCur
	add  hl, bc
	
	; Determine if an existing looping point was already set.
	ld   a, [hl]			; Read loop timer
	or   a					; Is it 0?
	jr   nz, .contLoop		; If not, jump
.firstLoop:
	; If the loop timer is 0, this is the first time we reached this looping point.
	; Set the initial loop timer and loop the song (set the data ptr to what's specified).

	ld   a, [de]			; Read byte1
	ld   [hl], a			; Write the byte1 to the table entry
	
.contLoop:
	; Check if the section has looped enough times
	
	inc  de							; Seek to byte2
	dec  [hl]						; Decrement loop timer
	jp   nz, Sound_Cmd_JpFromLoop	; Is it 0 now? If not, jump
	
	; Otherwise, the looping is over. Seek past the end of the data for this command.
	; While there are two bytes to to seek past, we're only incrementing by 1 due to Sound_IncDataPtr being called automatically at the end.
	inc  de
	ret
	
; =============== Sound_Cmd_JpFromLoop ===============
; If called directly as a sound command, this will always loop the sound channel without loop limit.
;
; The next two data bytes will be treated as new hSndInfoCurDataPtr.
; Command data format:
; - 0: Sound data ptr (low byte)
; - 1: Sound data ptr (high byte)
Sound_Cmd_JpFromLoop:
	; HL = Data Ptr
	ld   l, e
	ld   h, d
	
	; BC = *DE - 1
	; -1 to balance out the automatic call to Sound_IncDataPtr when the subroutine returns.
	ldi  a, [hl]
	ld   e, a
	ld   d, [hl]
	dec  de
	ret  
	
; =============== Sound_Cmd_Call ===============
; Saves the current data ptr, then sets a new one.
; This is handled like code calling a subroutine.
; Command data format:
; - 0: Sound data ptr (low byte)
; - 1: Sound data ptr (high byte)
Sound_Cmd_Call:

	;
	; Read 2 bytes of sound data to BC, and increment the data ptr
	; This will be our jump target.
	;
	ld   a, [de]
	ld   c, a		
	inc  de
	ld   a, [de]
	ld   b, a
	; No 2nd "inc de" because Sound_IncDataPtr, so it won't be needed to do it on Sound_Cmd_Ret
	
	;
	; Save the current sound data pointer in a stack-like way.
	;
	push bc		; Save for later new data ptr
		; Seek to the stack index value
		ld   hl, wSndInfoCur+iSndInfo_DataPtrStackIdx
		
		; Get the stack index decremented by one.
		; This is where the second byte of the old code ptr will get written to.
		dec  [hl]
		ld   a, [hl]
		; The stack index itself has to be decremented twice, since we're writing a pointer (2 bytes).
		dec  [hl]
		
		; Index the stack location (at the aforemented second byte of the word entry)
		ld   c, a
		ld   b, $00
		ld   hl, wSndInfoCur
		add  hl, bc
		
		; Write the second byte first
		ld   [hl], d
		dec  hl
		; Then the first byte
		ld   [hl], e
		
		; Pop out the data ptr for the "subroutine". 
		; This points to the proper place already, so decrement it once to balance out Sound_IncDataPtr.
	pop  de
	dec  de
	ret  
	
; =============== Sound_Cmd_Ret ===============
; Restores the data ptr previously saved in Sound_Cmd_Call.
; This acts like code returning from a subroutine.
Sound_Cmd_Ret:
	; Read the stack index value to A
	ld   a, [wSndInfoCur+iSndInfo_DataPtrStackIdx]
	
	; Use it to index the stack location with the data ptr
	ld   c, a
	ld   b, $00
	ld   hl, wSndInfoCur
	add  hl, bc
	
	; Restore the data ptr
	; NOTE: What is stored at HL already accounts for Sound_IncDataPtr.
	ldi  a, [hl]
	ld   e, a
	ld   d, [hl]
	
	; Increment the stack index twice
	ld   hl, wSndInfoCur+iSndInfo_DataPtrStackIdx
	inc  [hl]
	inc  [hl]
	ret  
	
; =============== Sound_Cmd_SetWaveData ===============
; Writes a complete set of wave data. This will disable ch3 playback.
;
; Command data format:
; - 0: Wave set id
Sound_Cmd_SetWaveData:

	; Ignore if the sound channel is used by a SFX
	ld   a, [wSndInfoCur]
	bit  SISB_USEDBYSFX, a
	ret  nz
	
	; Disable wave ch
	ld   a, SNDCH3_OFF
	ldh  [rNR30], a
	
	; Read wave set id from data
	ld   hl, Sound_WaveSetPtrTable
	ld   a, [de]
	ld   [wSndInfoCur+iSndInfo_WaveSetId], a
	
	; Index the ptr table with wave sets
	call Sound_IndexPtrTable
	
	; Replace the current wave data
	ld   c, LOW(rWave)						; C = Ptr to start of wave ram
	ld   b, rWave_End-rWave					; B = Bytes to copy
.loop:
	ldi  a, [hl]							; Read from wave set
	ld   [c], a								; Write it to the wave reg
	inc  c									; Ptr++
	dec  b									; Copied all bytes?
	jr   nz, .loop							; If not, loop
	ret
	
; =============== Sound_SetWaveDataCustom ===============
; Writes a complete set of wave data. This will disable ch3 playback.
;
; IN
; - HL: Ptr to a wave set id
Sound_SetWaveDataCustom:
	; Disable wave ch
	ld   a, SNDCH3_OFF
	ldh  [rNR30], a
	
	; Index the ptr table with wave sets
	ld   a, [hl]
	ld   hl, Sound_WaveSetPtrTable
	call Sound_IndexPtrTable
	
	; Replace the current wave data
	ld   c, LOW(rWave)						; C = Ptr to start of wave ram
	ld   b, rWave_End-rWave					; B = Bytes to copy
	jr   Sound_Cmd_SetWaveData.loop
	
; =============== Sound_IndexPtrTable ===============
; Indexes a pointer table.
;
; IN
; - HL: Ptr to ptr table
; -  A: Index (starting at $01)
; OUT
; - HL: Indexed value
Sound_IndexPtrTable:
	; Offset the table
	; BC = A - 1
	dec  a
	ld   c, a
	ld   b, $00
	; HL += BC * 2
	add  hl, bc
	add  hl, bc
	; Read out ptr to HL
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	ret
	
; =============== Sound_Cmd_ChanStop ===============
; Called to permanently stop channel playback (ie: the song/sfx ended and didn't loop).
; This either stops the sound channel or resumes playback of the BGM.
Sound_Cmd_ChanStop:

	; [TCRF] Nothing ever reads this bit.
	ld   a, [wSndFadeStatus]
	set  SFDB_UNUSED_2, a
	ld   [wSndFadeStatus], a
	; Fall-through
	
Sound_Cmd_ChanStop_NoFadeChg:

	; Mute the sound channel if there isn't a SFX playing on here, for good measure.
	; This isn't really needed.
	call Sound_SilenceCh

	; HL = SndInfo base
	ldh  a, [hSndInfoCurPtr_Low]
	ld   l, a
	ldh  a, [hSndInfoCurPtr_High]
	ld   h, a

	ld   a, [hl]
	bit  SISB_SFX, a		; Is this a SFX?
	jr   nz, .isSFX			; If so, jump

.isBGM:
	; If this is a BGM SndInfo, completely disable this SndInfo (but don't mute the channel)
	xor  a				; Erase the status flags
	ld   [hl], a

	; Prevent Sound_IncDataPtr from being executed
	pop  hl
	ret

.isSFX:
	; If this is a SFX SndInfo, reapply the BGM SndInfo to the sound registers.


	; Disable this SndInfo
	xor  a
	ld   [hl], a
	
	; HL -> Seek to the NRx1 info of the BGM SndInfo of the current channel.
	; The SFX SndInfo are right after the ones for the BGM, which is why we move back.
	ld   bc, -(SNDINFO_SIZE * 4) + iSndInfo_RegNRx1Data
	add  hl, bc
	
	; C -> Seek to NRx2
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]
	ld   c, a
	dec  c
	
.ch1ExtraClr:
	;
	; If we're processing ch1, clear NR10.
	; We must clear it manually since that register can't be reached otherwise.
	;
	cp   SND_CH1_PTR		; Processing ch1?
	jr   nz, .ch3SkipChk	; If not, skip
	ld   a, $08				; Otherwise, clear ch1 reg
	ldh  [rNR10], a
	
.ch3SkipChk:

	;
	; If we're processing ch3, skip updating rNR31 and *don't* handle iSndInfo_VolPredict.
	; This is because ch3 doesn't go through the volume prediction system in Sound_UpdateVolPredict,
	; so it'd be useless.
	;
	; In this sound driver, execution falls to a different code path.
	;
	cp   SND_CH3_PTR	; Processing ch3?
	jr   z, .ch3		; If so, jump

	;
	; In this sound driver specifically, ch4 also skips updating NR41.
	; 96 does it anyway.
	;
	cp   SND_CH4_PTR	; Processing ch1 or ch2?
	jr   nz, .ch12		; If so, jump
.ch4:					; Otherwise, we're processing ch4

	inc  hl				; Seek to iSndInfo_RegNR10Data
	jr   .ch124_nrx2
	
.ch12:
	; Now copy over all of the BGM SndInfo to the registers.

	;
	; NRx1
	;
	dec  c				; Seek back to NRx1, since HL is pointing to iSndInfo_RegNRx1Data
	
	ldi  a, [hl]		; Read BGM iSndInfo_RegNRx1Data, seek to SndInfo_Unknown_Unused_NR10Data
	ld   [c], a			; Update NRx1
	
	inc  c				; Seek to NRx2
	
.ch124_nrx2:

	;
	; NRx2
	;
	
	;
	; Merge the volume settings from iSndInfo_VolPredict with the existing
	; low byte of iSndInfo_RegNRx2Data.
	;
	
	inc  hl					; Seek to iSndInfo_VolPredict
	; B = BGM Volume info
	ldi  a, [hl]
	and  a, $F0				; Only in the upper nybble
	ld   b, a
	; A = BGM iSndInfo_RegNRx2Data
	ldi  a, [hl]
	and  a, $0F				; Get rid of its volume info
	add  b					; Merge it with the one from iSndInfo_VolPredict
.cpNRx2:
	ld   [c], a				; Write it to NRx2


	;
	; NRx3
	;
	inc  c
	
	; If the BGM NRx3 and NRx4 are both empty, mute the channel directly.
	ldi  a, [hl]			; A = iSndInfo_RegNRx3Data
	or   a, [hl]			; A |= iSndInfo_RegNRx4Data
	jr   z, .stopCh			; Both 0? If so, jump
	dec  hl
	
	; Otherwise, update NRx3
	ldi  a, [hl]
	ld   [c], a
	inc  c
	
	;
	; NRx4
	;
	
	; Update NRx4, and restart the tone
	ldi  a, [hl]					; Seek to iSndInfo_ChEnaMask
	or   a, SNDCHF_RESTART
	ld   [c], a
	
	; [POI] At this point 96 would have restored rNR51 from wSnd_Unused_EnaChBGM.
	
	call Sound_DoChSndInfo_Reinit
	
	; Prevent Sound_IncDataPtr from being executed, since we disabled the channel playback
	pop  hl
	ret
	
.stopCh:

	;
	; Mutes and stops the sound channel.
	;
	
	inc  hl					; Seek to iSndInfo_RegNRx4Data
	call Sound_DoChSndInfo_ChkMuteCh
	
	; Prevent Sound_IncDataPtr from being executed, since we disabled the channel playback
	pop  hl
	ret
	
.ch3:
	;
	; NRx2
	;
	
	; A = iSndInfo_RegNRx2Data
	inc  hl			; Seek to iSndInfo_RegNR10Data
	inc  hl			; Seek to iSndInfo_VolPredict
	inc  hl			; Seek to iSndInfo_RegNRx2Data
	ldi  a, [hl] 	; Read it
	ld   [c], a		; Write it to NRx2
	
	;
	; NRx3
	;
	inc  c
	; If the BGM NRx3 and NRx4 are both empty, mute the channel directly.
	ldi  a, [hl]			; A = iSndInfo_RegNRx3Data
	or   a, [hl]			; A |= iSndInfo_RegNRx4Data
	jr   z, .stopCh3		; Both 0? If so, jump
	dec  hl
	
	; Otherwise, update NRx3
	ldi  a, [hl]
	ld   [c], a
	inc  c
	
	;
	; NRx4
	;
	
	; Update NRx4, and restart the tone
	ld   a, [hl]
	set  SNDCHFB_RESTART, a
	ld   [c], a
	
	; [POI] At this point 96 would have restored rNR51 from wSnd_Unused_EnaChBGM.
	inc  hl					; Seek to iSndInfo_ChEnaMask
	call Sound_DoChSndInfo_Reinit
	
	;
	; Restore the BGM wave set
	;
	inc  hl					; Seek to iSndInfo_WaveSetId
	call Sound_SetWaveDataCustom
	
	ld   a, SNDCH3_ON
	ldh  [rNR30], a
	
	; Prevent Sound_IncDataPtr from being executed, since we disabled the channel playback
	pop  hl
	ret
	
.stopCh3:
	;
	; Restore the BGM wave set
	;
	inc  hl					; Seek to iSndInfo_ChEnaMask
	inc  hl					; Seek to iSndInfo_WaveSetId
	call Sound_SetWaveDataCustom
	
	; Mute ch3 like Sound_DoChSndInfo_Reinit does
	ldh  a, [rNR51]
	and  a, %10111011
	ldh  [rNR51], a
	
	; Prevent Sound_IncDataPtr from being executed, since we disabled the channel playback
	pop  hl
	ret
	
; =============== Sound_UpdateVolPredict ===============
; Updates the volume prediction value.
;
; Every frame, the timer in the low nybble of iSndInfo_VolPredict ticks up from $00 until
; it matches the low nybble of iSndInfo_RegNRx2Data (essentially the amount of envelope sweeps + dir flag).
;
; Once the timer/sweep count matches, the predicted volume level is decreased with a decreasing envelope sweep,
; or increased with an increasing one.
;
; IN
; - HL: Ptr to iSndInfo_VolPredict field
; - DE: Ptr to iSndInfo_RegNRx2Data field
Sound_UpdateVolPredict:
	inc  [hl]			; iSndInfo_VolPredict++

	; If the timers don't match yet, return
	ld   a, [hl]		; C = iSndInfo_VolPredict & $0F
	and  a, $0F
	ld   c, a
	ld   a, [de]		; A = iSndInfo_RegNRx2Data & $0F
	and  a, $0F
	cp   a, c			; A != C?
	ret  nz				; If so, return

	; Either increase or decrease the volume depending on the envelope direction
	bit  SNDENVB_INC, a	; Is bit 3 set?
	jr   z, .dec		; If not, decrease the volume
	;--
	; [TCRF] We never get here
	; Reset the timer and increase the volume by 1
	ld   a, [hl]		; A = (iSndInfo_VolPredict & $F0) + $10
	and  a, $F0
	add  a, $10
	ret  c				; If we overflowed, return
	ld   [hl], a		; Save it to iSndInfo_VolPredict
	ret
	;--
.dec:
	; Reset the timer and decrease the volume by 1
	ld   a, [hl]		; A = (iSndInfo_VolPredict & $F0)
	and  a, $F0
	ret  z				; If it's already 0, return
	sub  a, $10			; A -= $10
	ld   [hl], a		; Save it to iSndInfo_VolPredict
	ret 
	
; =============== Sound_SilenceCh ===============
; Writes $00 to the sound register NRx2, which silences the volume the sound channel (but doesn't disable it).
; This checks if the sound channel is being used by a sound effect, and if so, doesn't perform the write.
; IN
; - DE: SndInfo base ptr. Should be a wBGMCh*Info structure.
Sound_SilenceCh:
	call Sound_DoChSndInfo_ChkMuteCh
	
	; C = Destination register (RegPtr - 1)
	ld   a, [wSndInfoCur+iSndInfo_RegPtr]
	dec  a
	ld   c, a
	
	; A = Value to write
	xor  a
	
	ld   hl, wSndInfoCur+iSndInfo_Status
	bit  SISB_USEDBYSFX, [hl]	; Is the sound channel being used by a sound effect?
	ret  nz						; If so, return
	ld   [c], a					; Otherwise, write the $00 value to the register
	ret  
	
; =============== Sound_WriteToReg ===============
; Writes a value to the specified sound register.
; This checks if the sound channel is being used by a sound effect, and if so, doesn't perform the write.
; IN
; - A: Data to write to the sound register
; - C: Ptr to sound register
; - DE: SndInfo base ptr. Should be a wBGMCh*Info structure.
Sound_WriteToReg:
	ld   hl, wSndInfoCur+iSndInfo_Status
	bit  SISB_USEDBYSFX, [hl]	; Is the sound channel being used a sound effect?
	ret  nz						; If so, return
	ld   [c], a					; Otherwise, write the value to the register
	ret

; =============== Sound_MarkAllSFXChUse ===============
; Updates the "SFX playing, mute BGM" flag for each channel.
Sound_MarkAllSFXChUse:
	ld   de, wSFXCh1Info
	ld   hl, wBGMCh1Info
	call Sound_MarkSFXChUse
	ld   de, wSFXCh2Info
	ld   hl, wBGMCh2Info
	call Sound_MarkSFXChUse
	ld   de, wSFXCh3Info
	ld   hl, wBGMCh3Info
	call Sound_MarkSFXChUse
	ld   de, wSFXCh4Info
	ld   hl, wBGMCh4Info
	call Sound_MarkSFXChUse
	ret
	
; =============== Sound_MarkSFXChUse ===============
; Registers to the BGM Channel Info if a sound effect is currently using that channel.
; This sets/unsets the flag to mute BGM playback for the channel, in order to not cut off the sound effect.
; IN
; - DE: Ptr to SFX Channel Info (iSndInfo)
; - HL: Ptr to BGM Channel Info (iSndInfo)
Sound_MarkSFXChUse:
	; If the channel is being currently used
	ld   a, [de]		; Read iSndInfo_Status
	or   a				; Is a sound effect playing here?
	jr   z, .clrSFXPlay	; If not, jump
.setSFXPlay:
	set  SISB_USEDBYSFX, [hl]		; Mark as used
	ret
.clrSFXPlay:
	res  SISB_USEDBYSFX, [hl]		; Mark as free
	ret
	
; =============== Sound_Init_Do ===============
; Initializes the sound driver.
Sound_Init_Do:
	; Enable sound hardware
	ld   a, SNDCTRL_ON
	ldh  [rNR52], a

	; By default the timer increments by 1
	ld   a, $01
	ld   [wSndSongSpeed], a
	
	;
	; Clear channel registers.
	; This zeroes out addresses in the list at Sound_ChRegAddrTable.
	;
	ld   hl, Sound_ChRegAddrTable		; HL = Start of table
	ld   b, (Sound_ChRegAddrTable.end-Sound_ChRegAddrTable)	; B = Bytes to overwrite (table size)
	xor  a								; A = Value copied
.loop:
	ld   c, [hl]		; Read the ptr to C
	ld   [c], a			; Write $00 to $FF00+C
	inc  hl				; Ptr++
	dec  b				; Copied all bytes?
	jr   nz, .loop		; If not, loop
	; Fall-through
	
; =============== Sound_StopAll ===============
; Reloads the sound driver, which stops any currently playing song.
Sound_StopAll:
	;
	; Clear the entire memory range used by the sound driver (wBGMCh1Info-$C132)
	;
	ld   hl, wBGMCh1Info		; HL = Initial addr
	xor  a				; A = $00
	ld   c, $08			; BC = ($09*$20)
.loopH:
	ld   b, $20
.loopL:
	ldi  [hl], a		; Clear byte
	dec  b				; B == 0?
	jr   nz, .loopL		; If not, loop
	dec  c				; C == 0?
	jr   nz, .loopH		; If not, loop
	
	;
	; Initialize other regs
	;
	ld   a, %1110111	; Set max volume for both left/right speakers
	ldh  [rNR50], a
	
	xor  a				; Reset counter
	ld   [wSnd_Unused_SfxPriority], a
.initNR:
	ld   a, $08			; Use downwards sweep for ch1 (standard)
	ldh  [rNR10], a
	xor  a
	ldh  [rNR30], a		; Stop Ch3
	ldh  [rNR51], a		; Silence all channels
	
	ld   a, SND_NONE	; Don't immediately play any sound
	ld   [wSndSet], a
	ret  
	
; =============== Sound_ChRegAddrTable ===============
Sound_ChRegAddrTable:
	db LOW(rNR10)
	db LOW(rNR11)
	db LOW(rNR12)
	db LOW(rNR13)
	db LOW(rNR14)
	db LOW(rNR21)
	db LOW(rNR22)
	db LOW(rNR23)
	db LOW(rNR24)
	db LOW(rNR30)
	db LOW(rNR31)
	db LOW(rNR32)
	db LOW(rNR33)
	db LOW(rNR34)
	db LOW(rNR41)
	db LOW(rNR42)
	db LOW(rNR43)
	db LOW(rNR44)
.end:

; =============== Sound_ChkFade ===============
; Handles the fade in/fade outs.
; [TCRF] The game never makes use of it, and 96's sound driver outright lacks this feature.
Sound_ChkFade:
	ld   a, [wSndFadeStatus]
	bit  SFDB_FADEIN, a			; Doing a fade in?
	jr   nz, Sound_FadeIn		; If so, jump
	bit  SFDB_FADEOUT, a		; Doing a fade out?
	ret  z						; If not, return
	; Fall-through
	
; =============== Sound_FadeOut ===============
; [TCRF] We never get here.
; Performs a fade out.
Sound_FadeOut:

	;
	; Wait until the timer reaches the target before fading out a single sound channel.
	;
	ld   hl, wSndFadeTimer
	inc  [hl]			; wSndFadeTimer++
	ldi  a, [hl]		; Seek to wSndFadeTarget
	cp   [hl]			; wSndFadeTimer < wSndFadeTarget?
	ret  c				; If so, return
	dec  hl				; Seek back to wSndFadeTarget
	ld   [hl], $00		; Reset it
	
	;
	; Perform the actual fade out.
	; This works by decrementing the ch1-2-3 bit values while keeping ch4 untouched.
	;
	; After ch1-2-3 are all 0, only then we mark the fade as done and play SND_NONE,
	; which will kill off ch4 as well.
	;
	ldh  a, [rNR50]
	and  %01110111		; Are all sound channels muted?
	jr   z, .done		; If so, we're done
	
	; B = ch1-2-3 dec'd
	sub  %00010001		; Dec down ch1-2-3
	and  %01110111		; don't let ch4 interfere
	ld   b, a
	; A = ch4 status
	ldh  a, [rNR50]
	and  %10001000
	; Merge them both
	or   b				
	ldh  [rNR50], a
	ret
	
.done:
	; Mark fade out as done
	ld   a, [wSndFadeStatus]
	res  SFDB_FADEOUT, a
	set  SFDB_FADEOUTDONE, a
	ld   [wSndFadeStatus], a
	
	; Stop ch4 completely.
	; Doing it this way rather than just muting rNR50 has the side effect that it's
	; not possible to simply send a fade in command to resume the music, you need to set wSndSet too. 
	xor  a ; SND_NONE
	ld   [wSndSet], a
	ret  
	
; =============== Sound_FadeOut ===============
; [TCRF] We never get here.
; Performs a fade in.
; The exact opposite of Sound_FadeOut, unsurprisingly.
Sound_FadeIn:

	;
	; If this is the first time we get here, enable ch4.
	;
	ld   a, [wSndFadeStatus]
	bit  SFDB_FADEINPROC, a		; Fade just started?
	jr   z, .firstRun			; If so, jump
	
	;
	; Wait until the timer reaches the target before fading in a single sound channel.
	;
	ld   hl, wSndFadeTimer
	inc  [hl]			; wSndFadeTimer++
	ldi  a, [hl]		; Seek to wSndFadeTarget
	cp   [hl]			; wSndFadeTimer < wSndFadeTarget?
	ret  c				; If so, return
	dec  hl				; Seek back to wSndFadeTarget
	ld   [hl], $00		; Reset it
	
	;
	; Fade in logic, the other way around from Sound_FadeOut.
	; That one decremented ch1-2-3, this one increments it.
	;
	ldh  a, [rNR50]
	and  %01110111		; Are all sound channels enabled?
	cp   %01110111		;
	jr   z, .done		; If so, we're done
	
	; B = ch1-2-3 inc'd
	add  %00010001		; Inc up ch1-2-3
	and  %01110111		; don't let ch4 interfere
	ld   b, a
	; A = ch4 status
	ldh  a, [rNR50]
	and  %10001000
	; Merge them both
	or   b
	ldh  [rNR50], a
	ret
	
.done:
	; Mark fade in as done
	ld   a, [wSndFadeStatus]
	res  SFDB_FADEIN, a
	res  SFDB_FADEINPROC, a
	set  SFDB_FADEINDONE, a
	ld   [wSndFadeStatus], a
	ret
	
.firstRun:
	; Set fade in as started
	ld   a, [wSndFadeStatus]
	set  SFDB_FADEINPROC, a
	ld   [wSndFadeStatus], a
	; Enable ch4
	ldh  a, [rNR50]
	and  %10001000
	ldh  [rNR50], a
	ret
	
; =============== Sound_TriggerFade ===============
; [TCRF] Unused code.
; Triggers a fade out if a BGM is currently playing.
Sound_TriggerFade:
	;
	; Check if a BGM is currently playing.
	; Checking if wBGMCh1Info is enabled should be enough, given it's the main channel and every song defines/enables it.
	; If nothing is playing, act as if the fade out has already finished.
	;
	ld   a, [wBGMCh1Info+iSndInfo_Status]
	bit  SISB_ENABLED, a			; Any BGM playing?		
	jp   z, Sound_FadeOut.done		; If not, jump (set SFDB_FADEOUTDONE)
	
	; Otherwise, trigger the fade out.
	ld   a, [wSndFadeStatus]
	set  SFDB_FADEOUT, a
	res  SFDB_FADEOUTDONE, a
	ld   [wSndFadeStatus], a
	jp   Sound_StartNothing
	
; =============== Sound_MuteCh4 ===============
; Mutes ch4 playback without pausing the channel.
Sound_MuteCh4:
	; [POI] Stop any existing fade out
	ld   a, [wSndFadeStatus]
	res  SFDB_FADEOUT, a
	res  SFDB_FADEOUTDONE, a
	ld   [wSndFadeStatus], a
	; Mute Ch4
	ldh  a, [rNR50]
	or   a, %01110111
	ldh  [rNR50], a
	ret
	
; =============== Sound_Unused_PauseChPlayback_Do ===============
; [TCRF] Unreferenced code
Sound_Unused_PauseChPlayback_Do:
	; Pause music channels (but not SFX ones, for some reason)
	ld   hl, wBGMCh1Info+iSndInfo_Status
	set  SISB_PAUSE, [hl]
	ld   hl, wBGMCh2Info+iSndInfo_Status
	set  SISB_PAUSE, [hl]
	ld   hl, wBGMCh3Info+iSndInfo_Status
	set  SISB_PAUSE, [hl]
	ld   hl, wBGMCh4Info+iSndInfo_Status
	set  SISB_PAUSE, [hl]
	; Disable all sound channels
	xor  a
	ldh  [rNR30], a
	ldh  [rNR51], a
	ret
	
; =============== Sound_Unused_UnpauseChPlayback_Do ===============
; [TCRF] Unreferenced code
Sound_Unused_UnpauseChPlayback_Do:
	; Resume music channels 
	ld   hl, wBGMCh1Info+iSndInfo_Status
	res  SISB_PAUSE, [hl]
	ld   hl, wBGMCh2Info+iSndInfo_Status
	res  SISB_PAUSE, [hl]
	ld   hl, wBGMCh3Info+iSndInfo_Status
	res  SISB_PAUSE, [hl]
	ld   hl, wBGMCh4Info+iSndInfo_Status
	res  SISB_PAUSE, [hl]
	ret
	
; =============== Sound_FreqDataTbl ===============
; Table with pairs of frequency values for the frequency registers (sound channels 1-2-3).
; Essentially these are "musical notes" ordered from lowest to highest.
; [POI] Not all of these are used.
Sound_FreqDataTbl:
	dw $0000 ; N/A | $00 | $80 
	dw $002C ; C-2 | $01 | $81 ;X
	dw $009C ; C#2 | $02 | $82 ;X
	dw $0106 ; D-2 | $03 | $83 ;X
	dw $016B ; D#2 | $04 | $84 ;X
	dw $01C9 ; E-2 | $05 | $85 ;X
	dw $0223 ; F-2 | $06 | $86 ;X
	dw $0277 ; F#2 | $07 | $87 ;X
	dw $02C7 ; G-2 | $08 | $88
	dw $0312 ; G#2 | $09 | $89 ;X
	dw $0358 ; A-2 | $0A | $8A
	dw $039B ; A#2 | $0B | $8B
	dw $03DA ; B-2 | $0C | $8C
	dw $0416 ; C-3 | $0D | $8D
	dw $044E ; C#3 | $0E | $8E
	dw $0483 ; D-3 | $0F | $8F
	dw $04B5 ; D#3 | $10 | $90
	dw $04E5 ; E-3 | $11 | $91
	dw $0511 ; F-3 | $12 | $92
	dw $053C ; F#3 | $13 | $93
	dw $0563 ; G-3 | $14 | $94
	dw $0589 ; G#3 | $15 | $95
	dw $05AC ; A-3 | $16 | $96
	dw $05CE ; A#3 | $17 | $97
	dw $05ED ; B-3 | $18 | $98
	dw $060B ; C-4 | $19 | $99
	dw $0628 ; C#4 | $1A | $9A
	dw $0642 ; D-4 | $1B | $9B
	dw $065B ; D#4 | $1C | $9C
	dw $0672 ; E-4 | $1D | $9D
	dw $0689 ; F-4 | $1E | $9E
	dw $069E ; F#4 | $1F | $9F
	dw $06B2 ; G-4 | $20 | $A0
	dw $06C4 ; G#4 | $21 | $A1
	dw $06D6 ; A-4 | $22 | $A2
	dw $06E7 ; A#4 | $23 | $A3
	dw $06F7 ; B-4 | $24 | $A4
	dw $0705 ; C-5 | $25 | $A5
	dw $0714 ; C#5 | $26 | $A6
	dw $0721 ; D-5 | $27 | $A7
	dw $072D ; D#5 | $28 | $A8
	dw $0739 ; E-5 | $29 | $A9
	dw $0744 ; F-5 | $2A | $AA
	dw $074F ; F#5 | $2B | $AB
	dw $0759 ; G-5 | $2C | $AC
	dw $0762 ; G#5 | $2D | $AD
	dw $076B ; A-5 | $2E | $AE
	dw $0773 ; A#5 | $2F | $AF
	dw $077B ; B-5 | $30 | $B0
	dw $0783 ; C-6 | $31 | $B1
	dw $078A ; C#6 | $32 | $B2
	dw $0790 ; D-6 | $33 | $B3
	dw $0797 ; D#6 | $34 | $B4
	dw $079D ; E-6 | $35 | $B5
	dw $07A2 ; F-6 | $36 | $B6
	dw $07A7 ; F#6 | $37 | $B7
	dw $07AC ; G-6 | $38 | $B8
	dw $07B1 ; G#6 | $39 | $B9
	dw $07B6 ; A-6 | $3A | $BA
	dw $07BA ; A#6 | $3B | $BB
	dw $07BE ; B-6 | $3C | $BC
	dw $07C1 ; C-7 | $3D | $BD
	dw $07C5 ; C#7 | $3E | $BE
	dw $07C8 ; D-7 | $3F | $BF
	dw $07CB ; D#7 | $40 | $C0 ;X
	dw $07CE ; E-7 | $41 | $C1 ;X
	dw $07D1 ; F-7 | $42 | $C2 ;X
	dw $07D4 ; F#7 | $43 | $C3 ;X
	dw $07D6 ; G-7 | $44 | $C4 ;X
	dw $07D9 ; G#7 | $45 | $C5 ;X
	dw $07DB ; A-7 | $46 | $C6 ;X
	dw $07DD ; A#7 | $47 | $C7 ;X
	dw $07DF ; B-7 | $48 | $C8 ;X
	dw $07E1 ; C-8 | $49 | $C9 ;X
	
; =============== Sound_WaveSetPtrTable ===============
; Sets of Wave data for channel 3, copied directly to the rWave registers.
; [TCRF] More than half of the sets are unused!
Sound_WaveSetPtrTable:
	dw Sound_WaveSet_Unused_0
	dw Sound_WaveSet1
	dw Sound_WaveSet2
	dw Sound_WaveSet3
	dw Sound_WaveSet_Unused_4
	dw Sound_WaveSet5
	dw Sound_WaveSet6
	dw Sound_WaveSet_Unused_7
	dw Sound_WaveSet_Unused_8
	dw Sound_WaveSet_Unused_9
	dw Sound_WaveSet_Unused_A
	dw Sound_WaveSet_Unused_A
	dw Sound_WaveSet_Unused_A
	dw Sound_WaveSet_Unused_A
	dw Sound_WaveSet_Unused_A
	dw Sound_WaveSet_Unused_A

Sound_WaveSet_Unused_0: db $01,$23,$45,$67,$89,$AB,$CD,$EF,$ED,$CB,$A9,$87,$65,$43,$21,$00
Sound_WaveSet1: db $FF,$EE,$DD,$CC,$BB,$AA,$99,$88,$77,$66,$55,$44,$33,$22,$11,$00
Sound_WaveSet2: db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
Sound_WaveSet3: db $FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Sound_WaveSet_Unused_4: db $02,$46,$89,$AB,$CC,$DD,$EE,$FF,$FE,$ED,$DD,$CC,$BA,$98,$64,$31
Sound_WaveSet5: db $CF,$AF,$30,$12,$21,$01,$7F,$C2,$EA,$07,$FC,$62,$12,$5B,$FB,$12
Sound_WaveSet6: db $86,$33,$22,$11,$00,$0B,$EF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$EE
Sound_WaveSet_Unused_7: db $87,$76,$65,$54,$43,$32,$21,$10,$0F,$FE,$ED,$DC,$CB,$BA,$A9,$98
Sound_WaveSet_Unused_8: db $18,$F2,$68,$4E,$18,$76,$1A,$4C,$85,$43,$2E,$DC,$FF,$12,$84,$48
Sound_WaveSet_Unused_9: db $CC,$6B,$93,$77,$28,$BA,$6E,$35,$51,$C3,$9C,$ED,$B8,$2B,$29,$E2
Sound_WaveSet_Unused_A: db $CC,$6B,$93,$77,$28,$BA,$6E,$35,$51,$C3,$9C,$ED,$B8,$2B,$29,$E2

	mIncJunk "L1F48DC"

INCLUDE "data/sound/bgm_nakoruru.asm"
INCLUDE "data/sound/bgm_char_select.asm"
INCLUDE "data/sound/bgm_intro.asm"
INCLUDE "data/sound/bgm_boss.asm"
INCLUDE "data/sound/bgm_stage_clear.asm"
INCLUDE "data/sound/bgm_cutscene0.asm"
INCLUDE "data/sound/bgm_cutscene1.asm"
INCLUDE "data/sound/bgm_game_over.asm"
INCLUDE "data/sound/bgm_credits.asm"
INCLUDE "data/sound/bgm_stage.asm"
INCLUDE "data/sound/bgm_ending.asm"
INCLUDE "data/sound/bgm_unused_8c.asm"
INCLUDE "data/sound/bgm_unused_8d.asm"
INCLUDE "data/sound/bgm_unused_8e.asm"
INCLUDE "data/sound/bgm_unused_8f.asm"
INCLUDE "data/sound/sfx_cursor_move.asm"
INCLUDE "data/sound/sfx_char_selected.asm"
INCLUDE "data/sound/sfx_hit.asm"
INCLUDE "data/sound/sfx_unused_heavy_hit.asm"
INCLUDE "data/sound/sfx_fire_hit.asm"
INCLUDE "data/sound/sfx_block.asm"
INCLUDE "data/sound/sfx_ground_hit.asm"
INCLUDE "data/sound/sfx_light.asm"
INCLUDE "data/sound/sfx_heavy.asm"
INCLUDE "data/sound/sfx_taunt.asm"
INCLUDE "data/sound/sfx_step.asm"
INCLUDE "data/sound/sfx_jump.asm"
INCLUDE "data/sound/sfx_unused_bomb.asm"
INCLUDE "data/sound/sfx_unused_bounce.asm"
INCLUDE "data/sound/sfx_charge_meter.asm"
INCLUDE "data/sound/sfx_unused_step_b.asm"
INCLUDE "data/sound/sfx_special.asm"
INCLUDE "data/sound/sfx_unused_special_b.asm"
INCLUDE "data/sound/sfx_reflect.asm"
INCLUDE "data/sound/sfx_error.asm"
INCLUDE "data/sound/sfx_barrier.asm"
INCLUDE "data/sound/sfx_proj_lg.asm"
INCLUDE "data/sound/sfx_dizzy.asm"
INCLUDE "data/sound/sfx_unused_b7.asm"
INCLUDE "data/sound/sfx_unused_b8.asm"
INCLUDE "data/sound/sfx_unused_b9.asm"
INCLUDE "data/sound/sfx_unused_ba.asm"
INCLUDE "data/sound/sfx_unused_bb.asm"
INCLUDE "data/sound/sfx_unused_bc.asm"
INCLUDE "data/sound/sfx_unused_bd.asm"
INCLUDE "data/sound/sfx_unused_be.asm"
INCLUDE "data/sound/sfx_unused_bf.asm"
INCLUDE "data/sound/sfx_unused_c0.asm"
INCLUDE "data/sound/sfx_unused_c1.asm"
INCLUDE "data/sound/sfx_unused_c2.asm"
INCLUDE "data/sound/sfx_unused_c3.asm"
INCLUDE "data/sound/sfx_unused_c4.asm"
INCLUDE "data/sound/sfx_unused_c5.asm"
INCLUDE "data/sound/sfx_unused_c6.asm"
INCLUDE "data/sound/sfx_unused_c7.asm"
INCLUDE "data/sound/sfx_unused_c8.asm"
INCLUDE "data/sound/sfx_unused_c9.asm"
INCLUDE "data/sound/sfx_unused_ca.asm"
INCLUDE "data/sound/sfx_unused_cb.asm"
INCLUDE "data/sound/sfx_unused_cc.asm"
INCLUDE "data/sound/sfx_unused_cd.asm"
INCLUDE "data/sound/sfx_unused_ce.asm"
INCLUDE "data/sound/sfx_unused_cf.asm"
INCLUDE "data/sound/sfx_unused_d0.asm"
INCLUDE "data/sound/sfx_unused_d1.asm"
INCLUDE "data/sound/sfx_unused_d2.asm"
INCLUDE "data/sound/sfx_unused_d3.asm"
INCLUDE "data/sound/sfx_unused_d4.asm"
INCLUDE "data/sound/sfx_unused_d5.asm"
INCLUDE "data/sound/sfx_unused_d6.asm"
INCLUDE "data/sound/sfx_unused_d7.asm"
INCLUDE "data/sound/sfx_unused_d8.asm"
INCLUDE "data/sound/sfx_unused_d9.asm"
INCLUDE "data/sound/sfx_unused_da.asm"
INCLUDE "data/sound/sfx_unused_db.asm"
INCLUDE "data/sound/sfx_unused_dc.asm"
INCLUDE "data/sound/sfx_unused_dd.asm"
INCLUDE "data/sound/sfx_unused_de.asm"

; 
; =============== END OF MODULE Sound ===============
;

; 
; =============== START OF SUBMODULE Play->CPU ===============
;

; =============== Play_CPU_Do ===============
; Handles inputs for CPU players.
;
; While this handles the move inputs, not everything is handled here.
; Some moves (in particular those that have submoves) have CPU-specific
; code to randomize how to handle them.
;
; The English version made introduced changes to the logic, which
; made their way into all versions of 96.
;
; IN
; - BC: Ptr to wPlInfo
; - DE: Ptr to respective wOBJInfo
Play_CPU_Do:
IF NO_CPU_AI
	ret
ELSE
	;
	; If iPlInfo_CPUWaitTimer is set, don't do anything until it elapses.
	; This is strictly to delay the next action by a bit, as the CPU doesn't use 
	; the MoveInput_* like the player does.
	;
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, [hl]
	cp   $00			; WaitTimer == $00?
	jr   z, .resetInput	; If so, jump
	dec  a				; Otherwise, WaitTimer--
	ld   [hl], a
	ret					; and exit
.resetInput:
	;
	; Clear all joypad input fields
	;
	xor  a
	ld   hl, iPlInfo_JoyNewKeys
	add  hl, bc
	ldi  [hl], a	; iPlInfo_JoyNewKeys
	ldi  [hl], a	; iPlInfo_JoyKeys
	ldi  [hl], a	; iPlInfo_JoyNewKeysLH
	call Play_Pl_ClearJoyDirBuffer
	
	;
	; CPU AI LOGIC STARTS HERE
	;
	; First part here is reacting to what the player is doing.
	;
	
	; Handle separately what happens if there's an enemy projectile on screen
	ld   hl, iPlInfo_Flags0Other
	add  hl, bc
	bit  PF0B_PROJ, [hl]			; Does the opponent have an active fireball?
	jp   nz, Play_CPU_CheckProj		; If so, jump
	
	; Handle separately if the current or next frame from the opponent deal damage
	ld   hl, iPlInfo_MoveDamageValOther
	add  hl, bc
	ld   a, [hl]					; A = Cur Damage value
	ld   hl, iPlInfo_MoveDamageValNextOther
	add  hl, bc
	or   a, [hl]					; A |= Next damage value
	jp   nz, Play_CPU_BlockAttack_ByDifficulty				; A != 0? If so, jump
	
IF VER_EN
	; On HARD difficulty, several additional checks are made.
	; The only check that remains in this block on EASY/NORMAL difficulties
	; is the player distance one, which also activates closer to the opponent.
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD		; Playing on HARD?
	jp   nz, .valNormEasy		; If not, jump
.valHard:
	;
	; HARD ONLY
	;
	
	; If the opponent is invulnerable, move back
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]
	jp   nz, Play_CPU_SetJoyKeysB
	
	; If we're in the post-blockstun knockback, randomize return input
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_POST_BLOCKSTUN			; During knockback?
	jp   z, Play_CPU_OnBlockstunKnockback	; If so, jump
	
	; If we can cancel the current move into another, perform a random character-specific input
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	bit  PF1B_ALLOWHITCANCEL, [hl]
	jp   nz, Play_CPU_SetRandCharInput
	
	; If we're within $20px from the opponent, try to perform a random action
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $20						; iPlInfo_PlDistance < $20?
	jp   c, Play_CPU_OnPlNear		; If so, jump
	
	;
	; Every alternating $40 frames, perform a random character-specific input.
	; Notably, this only happens here, with the HARD difficulty setting.
	; On NORMAL and EASY, the CPU will never attack when far away.
	;
	ld   a, [wTimer]
	bit  6, a
	jp   nz, Play_CPU_SetRandCharInput
	; Every alternating $80 frames that don't fall into the above check, try to jump forwards.
	; This gives a window of opportunity for the jump to happen.
	bit  7, a
	jp   nz, Play_CPU_SetJoyKeysJumpUF
	
	jp   .idle
.valNormEasy:
	;
	; NORMAL/EASY ONLY
	;
ENDC
	
	; If we're within $1Apx from the opponent, try to perform a random action
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $1A						; iPlInfo_PlDistance < $1A?
	jp   c, Play_CPU_OnPlNear		; If so, jump
	
.idle:

	;
	; IDLE MOVEMENT
	;
	; If we got here, there's nothing for the CPU to react to.
	;

	; Don't pick a new action until the next block until the timer elapses
	ld   hl, iPlInfo_CPUIdleTimer
	add  hl, bc
	ld   a, [hl]
	cp   $00				; iPlInfo_CPUIdleTimer == $00?
	jr   z, .setIdleMove	; If so, jump
	dec  a					; Otherwise, iPlInfo_CPUIdleTimer--
	ld   [hl], a
	jr   .execIdleMove		; and skip
.setIdleMove:

	;
	; Set the new length of the timer value.
	; This is always $16.
	;
	
	;--
	; [POI] What's this used for? A canceled attempt at randomizing the timer?
	call Rand	; A = Rand
	or   a, $07	; Set lower three bits
	;--
	ld   a, $0B
	ld   e, a
	add  a, e			; A = $0B * 2
	ld   hl, iPlInfo_CPUIdleTimer
	add  hl, bc			; Seek to delay
	ld   [hl], a		; Write it
	
	;
	; Randomize the action.
	;
	call Rand
	; ~15.5% chance -> Attempt to move backwards (moves forward anyway if too far away from the opponent)
	cp   $28
	jr   c, .chkSetMoveB
	; ~23.5% chance -> Attempt to pause (moves forward anyway if too far away from the opponent)
	cp   $64
	jr   c, .chkSetNoMove
	; ~10% chance -> Charge meter
	cp   $7D
	jr   c, .setChargeMove
	; ~51% chance -> Move forward
.setMoveF:
	; iPlInfo_CPUIdleMove = CMA_MOVEF
	xor  a	; CMA_MOVEF
	ld   hl, iPlInfo_CPUIdleMove
	add  hl, bc
	ld   [hl], a
	jr   .execIdleMove
.chkSetMoveB:
	; Move forward instead if too far away from the opponent
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $5A			; iPlInfo_PlDistance >= $5A?
	jp   nc, .setMoveF	; If so, jump
	; iPlInfo_CPUIdleMove = CMA_MOVEB
	ld   a, CMA_MOVEB
	ld   hl, iPlInfo_CPUIdleMove
	add  hl, bc
	ld   [hl], a
	jr   .execIdleMove
.chkSetNoMove:
	; Move forward instead if too far away from the opponent
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $55			; iPlInfo_PlDistance >= $55?
	jp   nc, .setMoveF	; If so, jump
	; iPlInfo_CPUIdleMove = CMA_NONE
	ld   a, CMA_NONE
	ld   hl, iPlInfo_CPUIdleMove
	add  hl, bc
	ld   [hl], a
	jr   .execIdleMove
.setChargeMove:
	; iPlInfo_CPUIdleMove = CMA_CHARGE
	ld   a, CMA_CHARGE
	ld   hl, iPlInfo_CPUIdleMove
	add  hl, bc
	ld   [hl], a
	jr   .execIdleMove
	
.execIdleMove:
	; Execute the currently set idle move input
	ld   hl, iPlInfo_CPUIdleMove
	add  hl, bc
	ld   a, [hl]
	cp   CMA_MOVEF
	jp   z, Play_CPU_SetJoyKeysF_Far
	cp   CMA_MOVEB
	jp   z, Play_CPU_SetJoyKeysB
	cp   CMA_CHARGE
	jp   z, Play_CPU_SetJoyKeys_Charge
	ret
	
; =============== Play_CPU_SetJoyKeys_Charge ===============
; Makes the CPU charge meter. (A+B+Down)
Play_CPU_SetJoyKeys_Charge:

	; If we reached max power, abort this move early.
	ld   hl, iPlInfo_Pow
	add  hl, bc
	ld   a, [hl]		
	cp   PLAY_POW_MAX	; At max power?
	jr   z, .end		; If so, jump
	
	; Perform the charge input
	ld   a, KEY_B|KEY_A|KEY_DOWN
	ld   d, KEP_B_LIGHT|KEP_A_LIGHT
	jp   Play_CPU_SetJoyKeys
.end:
	; Reset the idle timer.
	; This will force to pick a new idle move next frame.
	xor  a
	ld   hl, iPlInfo_CPUIdleTimer
	add  hl, bc
	ld   [hl], a
	ret
; =============== Play_CPU_OnPlNear ===============
; Handles the logic when the opponent is near us.
;
; This needs to survive a gauntlet of difficulty-specific validations, which,
; if pass, make the CPU execute a random action.
Play_CPU_OnPlNear:

	;
	; The difficulty variable for this part only matters for non-boss stages.
	; The bosses and extra rounds have their own difficulty which is harder than hard.
	;

	; Depending on difficulty...
	ld   a, [wDifficulty]
	cp   DIFFICULTY_NORMAL
	jp   z, .norm
	cp   DIFFICULTY_HARD
	jp   z, .hard
.easy:
	; Check hardcoded stage difficulties
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; Are we in a boss or extra stage?
	jp   nc, .norm			; If so, jump
	
	; Don't do anything for the next 10 frames
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, $0A
	ld   [hl], a
	
	; ~39% chance of not doing anything
	call Rand
	cp   $64
	ret  c
	
	jp   .doAction
.norm:
	; Check hardcoded stage difficulties
	ld   a, [wCharSeqId]
	cp   STAGESEQ_SAISYU	; Are we in a boss or extra stage?
	jp   nc, .hard			; If so, jump
	
	; Don't do anything for the next frame
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, $01
	ld   [hl], a
	
	; ~8% chance of not doing anything
	call Rand
	cp   $14
	ret  c
	
	jp   .doAction
.hard:
	; Check hardcoded stage difficulties.
	; .hardest is like .hard, except it:
	; - respects POWERUP mode 
	; - allows hit cancel
	; - makes the CPU block/walk back if the opponent is invulnerable.
	
	; [POI] On POWERUP mode, HARD is perpetually HARDEST here
	ld   a, [wDipSwitch]
	bit  DIPB_POWERUP, a
	jp   nz, .hardest
	; [POI] The other STAGESEQ_SAISYU checks in .easy and .norm, instead of leading directly to .hardest, led here.
	;       What gives? Is it an error? Should have this been checking STAGESEQ_RUGAL?
	ld   a, [wCharSeqId]
	cp   a, STAGESEQ_SAISYU	; Are we in a boss or extra stages?
	jp   nc, .hardest		; If so, jump
	
IF VER_EN
	; If we're in the post-blockstun knockback, randomize return input
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_POST_BLOCKSTUN		; During knockback?
	jp   z, Play_CPU_SetRandCharInput	; If so, jump
ELSE
	; If we're crouch-blocking, randomize return input
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_BLOCK_C			; During knockback?
	jp   z, Play_CPU_SetRandCharInput	; If so, jump
ENDC

	; Allow the CPU to do something the next frame
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, $00
	ld   [hl], a
	
	; ~4% chance of not doing anything
	call Rand
	cp   a, $0A
	ret  c
	
	jp   .doAction
	;--
.hardest:
	; Attempt to special/super cancel if possible
	ld   hl, iPlInfo_Flags1
	add  hl, bc
	bit  PF1B_ALLOWHITCANCEL, [hl]
	jp   nz, Play_CPU_SetRandCharInput
	
IF VER_EN
	; If we're in the post-blockstun knockback, randomize return input (respecting easy moves mode)
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_POST_BLOCKSTUN			; During knockback?
	jp   z, Play_CPU_OnBlockstunKnockback	; If so, jump
ELSE
	; If we're blocking randomize return input
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_BLOCK_G			; During knockback?
	jp   z, Play_CPU_SetRandCharInput	; If so, jump
	cp   MOVE_SHARED_BLOCK_C			; During knockback?
	jp   z, Play_CPU_SetRandCharInput	; If so, jump
ENDC

	; Allow the CPU to do something the next frame
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, $00
	ld   [hl], a
	
IF VER_EN
	; If the opponent is invulnerable, try to walk back outside of the "near" range.
	ld   hl, iPlInfo_Flags1Other
	add  hl, bc
	bit  PF1B_INVULN, [hl]
	jp   nz, Play_CPU_BlockAttack_ByDifficulty
	
	; 0% chance of not doing anything.
ELSE
	; ~2% chance of not doing anything
	call Rand
	cp   a, $05
	ret  c
ENDC
	
.doAction:
	
	;
	; IDLE MODE (near player)
	;
	; There's nothing for the CPU to react to, so perform a random action.
	;
	
	call Rand
	; ~15.5% chance -> (EN) 15.5% chance of strike attack
	;                  (JP) 25% change heavy punch
	cp   $28
	jp   c, Play_CPU_SetJoyKeysStrike_C12
IF VER_EN
	; ~8%    chance -> 25% chance of heavy punch
	cp   $3C
	jp   c, Play_CPU_SetJoyKeysHP_C25
ENDC
	; ~8%    chance -> 25% chance of light punch
	cp   $50
	jp   c, Play_CPU_SetJoyKeysLP_C25
	; ~8%    chance -> Heavy kick
	cp   $64
	jp   c, Play_CPU_SetJoyKeysHK
	; ~8%    chance -> Heavy punch
	cp   $78
	jp   c, Play_CPU_SetJoyKeysLK
	; ~8%    chance -> Random character-specific input
	cp   $8C
	jp   c, Play_CPU_SetRandCharInput
	; ~8%    chance -> Move back
	cp   $A0
	jp   c, Play_CPU_SetJoyKeysB
	; ~23.5% chance -> 50% chance of throw (or heavy punch while holding back)
	cp   $DC
	jp   c, Play_CPU_SetJoyKeysB_HP_C50
	; ~14%   chance -> Nothing
	ret
	
IF VER_EN
; =============== Play_CPU_OnBlockstunKnockback ===============
; Handles the logic when in the middle of knockback after blockstun.
; These attempt to set a character-specific input that may take effect 
; as soon as knockback ends if something else doesn't write to the key buffer.
Play_CPU_OnBlockstunKnockback:

	;
	; Without powerup mode active, fall back to Play_CPU_SetRandCharInput
	;
	ld   a, [wDipSwitch]
	bit  DIPB_POWERUP, a				; Is the powerup cheat enabled?
	jp   z, Play_CPU_SetRandCharInput	; If not, jump
	
.powerup:
	ld   a, [wTimer]
	bit  0, a			; Every other frame
	jp   nz, .superH
.superL:
	ld   a, $01	; Use input #1
	scf
	ccf	; Use light version (#0)
	jp   Play_CPU_ApplyCharInput
.superH:
	ld   a, $01	; Use input #2
	scf	; Use heavy version (#1)
	jp   Play_CPU_ApplyCharInput
ENDC
	
; =============== Play_CPU_SetRandCharInput ===============
; Makes the CPU perform a random special move input / character-specific move input
; with random strength.
Play_CPU_SetRandCharInput:
	;
	; 62.5% chance of performing a light attack.
	;
	call Rand		; A = Rand
	cp   $A0		; A < $A0?
	jp   c, .light	; If so, jump
.heavy:
	call Rand	; Randomize moveinput id
	and  a, $07	; Force valid range ($00-$07)
	scf			; Use heavy version (#1)
	jp   Play_CPU_ApplyCharInput
.light:
	call Rand	; Randomize moveinput id
	and  a, $07	; Force valid range ($00-$07)
	scf
	ccf			; Use light version (#0)
	jp   Play_CPU_ApplyCharInput
	
IF VER_EN
; =============== Play_CPU_BlockAttack_ByDifficulty ===============
; Makes the opponent block the active attack (or, if we got here with no attack,
; to walk back away from the opponent), with difficulty-specific logic.
; - EASY and NORMAL both randomize between blocking mid and low every $40 frames.
;   How they differ is the action they perform every $80 frames:
;   - On EASY, the CPU will not block at all (early return)
;   - On NORMAL, the CPU will always block properly.
; - HARD makes the CPU always block properly, see Play_CPU_BlockAttack for more info.
;
; This is very similar to 96's version, but not exactly.
Play_CPU_BlockAttack_ByDifficulty:
	; Determine which difficulty we're in.
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD			; On HARD difficulty?
	jp   z, Play_CPU_BlockAttack	; If so, jump
	cp   DIFFICULTY_NORMAL			; On NORMAL difficulty?
	jp   z, .norm					; If so, jump
									; Otherwise, we're on EASY
.easy:
	; Return every alternating $80 frames
	ld   a, [wTimer]
	bit  7, a
	ret  nz
	; Every $40 frames, alternate between crouch block and block
	bit  6, a
	jp   z, Play_CPU_SetJoyKeysDB
	jp   Play_CPU_SetJoyKeysB
.norm:
	; Every alternating $80 frames, perform the proper block action.
	; 96 changed this to return every alternating $40 frames.
	ld   a, [wTimer]
	bit  7, a
	jp   z, Play_CPU_BlockAttack
	; Every $40 frames, alternate between crouch block and block
	bit  6, a
	jp   z, Play_CPU_SetJoyKeysDB
	jp   Play_CPU_SetJoyKeysB
ELSE
; =============== Play_CPU_BlockAttack_ByDifficulty ===============
; Makes the opponent block the active attack (or, if we got here with no attack, to walk back away from the opponent), with difficulty-specific logic.
; There is a base 20% chance of not blocking the attack.
;
; On EASY and NORMAL there is an additional check, which prevents the CPU
; from blocking/walking back when too far away from the opponent.
Play_CPU_BlockAttack_ByDifficulty:
	; Determine which difficulty we're in.
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD	; On HARD difficulty?
	jp   z, .chance20		; If so, skip the next check
.norm:
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $37				; iPlInfo_PlDistance >= $37?
	ret  nc					; If so, return
.chance20:
	; Fall-through
ENDC
	
; =============== Play_CPU_BlockAttack_C20 ===============
; Makes the opponent block the attack, with a 20% chance of not doing anything.
; In the English version, this is a 15% chance, as in 96.
Play_CPU_BlockAttack_C20:
IF VER_EN
	;
	; ~15.6% chance of not doing anything
	;
	call Rand	; A = Rand
	cp   $28	; A < $28?
	ret  c		; If so, return
ELSE
	;
	; ~19.5% chance of not doing anything
	;
	call Rand	; A = Rand
	cp   $32	; A < $32?
	ret  c		; If so, return
	;--
	; [TCRF] Impossible branch, removed in 96.
	cp   $32	
	jr   c, Play_CPU_Dodge
	;--
ENDC
	; Fall-through
	
; =============== Play_CPU_BlockAttack ===============
; Makes the opponent block the active attack.
; Performs actions depending on how the opponent's attack hits.
Play_CPU_BlockAttack:
	
	; Get the damage flags for the opponent's move
	ld   hl, iPlInfo_MoveDamageFlags3Other
	add  hl, bc
	ld   a, [hl]	; A = Cur flags
	ld   hl, iPlInfo_MoveDamageFlags3NextOther
	add  hl, bc
	or   a, [hl]	; A |= Next flags
	
	;
	; Move backwards/block when the attack doesn't hit low.
	; This means the CPU doesn't need to watch its feet and block low, so just block.
	;
	; If the opponent isn't attacking (ie: we got here through the PF1B_INVULN check),
	; walk back in an attempt to get out of the opponent's range.
	;
	bit  PF3B_HITLOW, a
	jp   z, Play_CPU_SetJoyKeysB
	;--
	;
	; If the attack hits low (but doesn't also hit mid), crouch block.
	;
	bit  PF3B_OVERHEAD, a			; Does the attack hit high?
	jp   z, Play_CPU_SetJoyKeysDB	; If not, jump
	
	;
	; Otherwise, this is an unblockable. Take the hit.
	; (In the English version and 96, try to block it anyway)
	;
IF VER_EN
	jp   Play_CPU_SetJoyKeysB
ENDC
	ret
	
; =============== Play_CPU_CheckProj ===============	
; Behaviour when an enemy projectile is active on-screen.
Play_CPU_CheckProj:
	;
	; On EASY difficulty, there's a 50% chance of not doing anything.
	;
	ld   a, [wDifficulty]
	cp   DIFFICULTY_EASY			; Playing on EASY?
	jp   nz, .chkAthenaCrystalBit	; If not, skip
	ld   a, [wTimer]
	cp   $80						; wTimer < $80?
	ret  c							; If so, return
	
.chkAthenaCrystalBit:

; The English version is almost identical to 96's iteration.
IF VER_EN
	;
	; Start spamming user moves if we're on HARD and attempting to hit the CPU 
	; with Athena's normal super.
	; Note the desperation version is unaffected.
	;
	
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD				; Playing on HARD?
	jp   nz, .norm						; If not, skip
	
	ld   hl, iPlInfo_CharIdOther
	add  hl, bc
	ld   a, [hl]
	cp   CHAR_ID_ATHENA					; Opponent is Athena?
	jp   nz, .chkPowerupMode			; If not, skip
	
	ld   hl, iPlInfo_MoveIdOther
	add  hl, bc
	ld   a, [hl]
	cp   a, MOVE_ATHENA_SHINING_CRYSTAL_BIT_GS	; Opponent is doing a normal super?
	jp   z, Play_CPU_SetRandCharInputH			; If so, jump

.chkPowerupMode:

	;
	; Handle the projectile distance checks differently in powerup mode.
	;
	ld   a, [wDipSwitch]
	bit  DIPB_POWERUP, a	; Is the powerup cheat enabled?
	jp   z, .norm			; If not, jump
	
.powerup:	
	;
	; If we pressed any attack button in the last few frames but no attack started,
	; perform a crouching light punch.
	; Note that switching to a new move, most of the time, clears iPlInfo_JoyBufKeysLH.
	;
	ld   hl, iPlInfo_JoyBufKeysLH
	add  hl, bc
	ld   a, [hl]
	and  a, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY	; Are we pressing any button already?
	jp   nz, Play_CPU_SetJoyKeysC_LP_C25					; If so, jump
	
	;
	; Check distance with enemy projectile.
	;
	ld   hl, iPlInfo_ProjDistance
	add  hl, bc
	ld   a, [hl]
	; Crouching light punch if distance >= $46
	cp   $46
	jp   nc, Play_CPU_SetJoyKeysC_LP_C25
	; Block/Dodge if distance in range $32-$45
	cp   $32
	jp   nc, Play_CPU_Dodge
	; Block or jump back if distance < $32
	jr   Play_CPU_BlockAttack
.norm:
ELSE

.chkPowerupMode:
	;
	; On HARD difficulty, in POWERUP mode, spam cruching light punches,
	; as they reflect projectiles.
	;
	; This was completely redone for the English version (and 96) because
	; its aggressiveness makes it impossible to use projectiles against the CPU.
	;
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD					; Playing on HARD?
	jp   nz, .chkDistance					; If not, skip
	ld   a, [wDipSwitch]
	bit  DIPB_EASY_MOVES, a					; Are the move shortcuts enabled?
	jp   nz, Play_CPU_SetJoyKeysC_LP_C25	; If so, jump
.chkDistance:
ENDC

	;
	; Check distance with enemy projectile.
	;
	ld   hl, iPlInfo_ProjDistance
	add  hl, bc
	ld   a, [hl]
	; Do a random character-specific input if distance >= $55
	cp   $55
	jp   nc, Play_CPU_SetRandCharInputH
	; Jump forward if distance in range $46-$54
	cp   $46
	jp   nc, Play_CPU_SetJoyKeysJumpUF
	; Block/Dodge if distance < $32
	cp   $32
	jp   c, Play_CPU_Dodge
	; Block or jump back if distance in range $32-$45
IF VER_EN
	jp   Play_CPU_BlockAttack_C20
ELSE
	jr   Play_CPU_BlockAttack_C20
ENDC

; =============== Play_CPU_Dodge ===============
; Makes the CPU perform the input to dodge the attack.
; On the EASY and NORMAL difficulties, there's a 20% chance of blocking the attack instead.
; On HARD, the dodge always happens.
Play_CPU_Dodge:
IF VER_EN
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD	; Playing on HARD?
	jp   z, .noBlock		; If so, skip
ENDC
	; ~20% chance of blocking/walking back immediately
	call Rand
	cp   $32
	jp   c, Play_CPU_BlockAttack
.noBlock:

	; If the CPU is currently dodging, don't press anything
	ld   hl, iPlInfo_MoveId
	add  hl, bc
	ld   a, [hl]
	cp   MOVE_SHARED_DODGE
	jp   z, .release
	
	; Don't do anything for 20 frames after starting the dodge
	ld   hl, iPlInfo_CPUWaitTimer
	add  hl, bc
	ld   a, $14
	ld   [hl], a
	
	; Perform the dodge input
	ld   a, KEY_A|KEY_B
	ld   d, KEP_A_HEAVY|KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
	
.release:
	; Release all keys
	ld   a, KEY_NONE
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeysJumpUF ===============
; Makes the CPU perform the input for a forward jump.
; Note this will always be done regardless of whatever action we're in, so it could have
; different effects if we are in the middle of a special move.
Play_CPU_SetJoyKeysJumpUF:
	;
	; Perform the forward jump input, which will get added to the buffer later
	; in the frame when Play_WriteKeysToBuffer gets executed.
	;
	
	; Determine which direction is for moving forward
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]		; Are we facing right?
	jp   nz, .setJumpR			; If so, jump
.setJumpL:	
	ld   a, KEY_LEFT|KEY_UP		; UL is forward when facing left (2P side)
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
.setJumpR:
	ld   a, KEY_RIGHT|KEY_UP	; UR is forward when facing right (1P side)
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
	
;--
; [TCRF] Unreferenced code, meant to perform an input for a backwards jump.
;        Block deleted in 96.
.unused_setBackJumpDir:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]				; Are we facing right?
	jp   nz, .setJumpBL					; If so, jump
.setJumpBR:	
	ld   a, KEY_RIGHT|KEY_UP			; UR is backwards when facing left (2P side)
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
.setJumpBL:
	ld   a, KEY_RIGHT|KEY_LEFT|KEY_UP	; UL is backwards when facing right (1P side)
	ld   d, $00							; [BUG] There's a spurious KEY_RIGHT value though.
	jp   Play_CPU_SetJoyKeys
;--

; =============== Play_CPU_SetRandCharInputH ===============
; Makes the CPU perform a random heavy special move input / character-specific move input.
Play_CPU_SetRandCharInputH:
	call Rand	; Randomize moveinput id
	and  a, $07	; Force valid range ($00-$07)
	scf			; Use heavy version (#1)
	jp   Play_CPU_ApplyCharInput
	
; =============== Play_CPU_SetJoyKeysB_HP_C50 ===============
; Makes the CPU perform an heavy punch while holding back.
; There's 50% chance for this to happen.
; Because this is called when close to the opponent, the intention
; is to start a throw, but the player may not be on the ground / in 
; throw range, so it won't always happen.
Play_CPU_SetJoyKeysB_HP_C50:
	call Rand
	bit  0, a
	ret  z
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Are we visually facing right? (1P side)
	jp   nz, .moveL			; If so, jump
	ld   a, KEY_RIGHT		; On the 2P side, right is backwards
	ld   d, KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
.moveL:
	ld   a, KEY_LEFT		; On the 1P side, left is backwards
	ld   d, KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
	

; =============== Play_CPU_SetJoyKeys*_C25 ===============
; Sets of subroutines that makes the CPU perform a punch/kick input.
; These subroutines are affected by difficulty in the same way:
; - On EASY and NORMAL difficulties, there's a 75% chance of not moving.
; - On HARD difficulty, the CPU always moves.
	
; =============== Play_CPU_SetJoyKeysLP_C25 ===============
; Makes the CPU perform a standing light punch input.
Play_CPU_SetJoyKeysLP_C25:
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD	; On HARD difficulty?
	jp   z, .setKeys		; If so, skip
	call Rand				; A = Rand
	bit  0, a				; bit0 set? (50%)
	ret  z					; If so, return
	bit  1, a				; bit1 set? (another 50%)
	ret  z					; If so, return
.setKeys:
	xor  a ; KEY_NONE
	ld   d, KEP_B_LIGHT
	jp   Play_CPU_SetJoyKeys

; =============== Play_CPU_SetJoyKeysStrike_C12 ===============
; Makes the CPU perform a standing heavy punch input.
Play_CPU_SetJoyKeysStrike_C12:
IF VER_EN
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD
	jp   z, .setKeys
	call Rand
	bit  0, a
	ret  z
	bit  1, a
	ret  z
.setKeys:
	; 50% chance of actually performing the strike input, since it requires
	; holding forwards, but L/R is randomized depending on the timer.
	
	; Every other frame...
	ld   a, [wTimer]
	bit  0, a			
	jp   nz, .setL
.setR:
	ld   a, KEY_RIGHT	; A+B+Left
	jp   .end
.setL:
	ld   a, KEY_LEFT	; A+B+Right
.end:
	ld   d, KEP_A_LIGHT|KEP_B_LIGHT|KEP_A_HEAVY|KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
ENDC

; =============== Play_CPU_SetJoyKeysHP_C25 ===============
; Makes the CPU perform a standing heavy punch input.
Play_CPU_SetJoyKeysHP_C25:
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD
	jp   z, .setKeys
	call Rand
	bit  0, a
	ret  z
	bit  1, a
	ret  z
.setKeys:
	xor  a ; KEY_NONE
	ld   d, KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
; =============== Play_CPU_SetJoyKeysC_LP_C25 ===============
; Makes the CPU perform a crouching light punch input.
Play_CPU_SetJoyKeysC_LP_C25:
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD
	jp   z, .setKeys
	call Rand
	bit  0, a
	ret  z
	bit  1, a
	ret  z
.setKeys:
	ld   a, KEY_DOWN
	ld   d, KEP_B_LIGHT
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_Unused_SetJoyKeysC_HP_C25 ===============
; [TCRF] Unreferenced code.
; Makes the CPU perform a crouching heavy punch input.
Play_CPU_Unused_SetJoyKeysC_HP_C25:
	ld   a, [wDifficulty]
	cp   DIFFICULTY_HARD
	jp   z, .setKeys
	call Rand
	bit  0, a
	ret  z
	bit  1, a
	ret  z
.setKeys:          
	ld   a, KEY_DOWN
	ld   d, KEP_B_HEAVY
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeysLK ===============
; Makes the CPU perform the light kick input.
Play_CPU_SetJoyKeysLK:
	xor  a ; KEY_NONE
	ld   d, KEP_A_LIGHT
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeysHK ===============
; Makes the CPU perform the heavy kick input.
Play_CPU_SetJoyKeysHK:
	xor  a ; KEY_NONE
	ld   d, KEP_A_HEAVY
	jp   Play_CPU_SetJoyKeys

; =============== Play_CPU_SetJoyKeysB ===============
; Makes the CPU input back.
Play_CPU_SetJoyKeysB:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Are we visually facing right? (1P side)
	jp   nz, .moveL			; If so, jump
.moveR:
	ld   a, KEY_RIGHT		; On the 2P side, right is backwards
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
.moveL:
	ld   a, KEY_LEFT		; On the 1P side, left is backwards
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeysDB ===============
; Makes the CPU input down back.
Play_CPU_SetJoyKeysDB:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Are we visually facing right? (1P side)
	jp   nz, .moveUL		; If so, jump
.moveUR:
	ld   a, KEY_DOWN|KEY_RIGHT
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
.moveUL:
	ld   a, KEY_DOWN|KEY_LEFT
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeysF_Far ===============
; Makes the CPU move forward if it's not too close to the opponent.
Play_CPU_SetJoyKeysF_Far:

	; Don't do anything if we're too close to the opponent
	ld   hl, iPlInfo_PlDistance
	add  hl, bc
	ld   a, [hl]
	cp   $1A				; iPlInfo_PlDistance < $1A?
	ret  c					; If so, return
	; Fall-through
	
; =============== Play_CPU_SetJoyKeysF ===============
; Makes the CPU input forward.
Play_CPU_SetJoyKeysF:
	ld   hl, iOBJInfo_OBJLstFlags
	add  hl, de
	bit  SPRB_XFLIP, [hl]	; Are we visually facing right? (1P side)
	jp   nz, .moveR			; If so, jump
.moveL:
	ld   a, KEY_LEFT		; On the 2P side, left is forwards
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
.moveR:
	ld   a, KEY_RIGHT		; On the 1P side, right is forwards
	ld   d, $00
	jp   Play_CPU_SetJoyKeys
	
; =============== Play_CPU_SetJoyKeys ===============
; Writes the "current" joypad keys values.
;
; Later in the frame, when Play_WriteKeysToBuffer gets executed, these inputs will
; be added to the buffer at iPlInfo_JoyDirBuffer & iPlInfo_JoyBtnBuffer.
;
; IN
; - A: Held keys (iPlInfo_JoyKeys)
; - D: Light/Heavy button info (iPlInfo_JoyNewKeysLH)
Play_CPU_SetJoyKeys:
	ld   hl, iPlInfo_JoyKeys
	add  hl, bc
	ldi  [hl], a	; Write A to iPlInfo_JoyKeys, seek to iPlInfo_JoyNewKeysLH
	ld   [hl], d	; Write D to iPlInfo_JoyNewKeysLH
	ret
	
; =============== Play_CPU_ApplyCharInput ===============
; Makes the CPU perform a character-specific move input.
;
; How this works:
;
; Each character is assigned a list of move inputs (CPU_MoveInputList_*).
; The table at CPU_MoveListPtrTable assigns one for every character.
;
; Each MoveInputList itself is a table of 8 entries with 4 bytes each:
; - 0-1: Ptr to a MoveInput_* (iCPUMoveListItem_MoveInputPtr) for the old keypresses
; - 2: Current LH button input #0 (iCPUMoveListItem_LastLHKeyA)
; - 3: Current LH button input #1 (iCPUMoveListItem_LastLHKeyB)
;
; The combination of MoveInput and button allows to define standard motions like:
; -> DF+B
; With MoveInput_DF defining DF and iCPUMoveListItem_LastLHKey* being KEP_B_LIGHT.
;
; In the English version, the MoveInput data doesn't necessarily have to point to a d-pad motion.
; If in the second byte, iCPUMoveListItem_LastLHKeyA, the flag CML_BTN is set, the
; MoveInput is treated as a button-based input (ie: pressing B 3 times).
; Since this has to be defined manually, it should be consistent with the MoveInput. 
;
; Regardless of that, iCPUMoveListItem_LastLHKey* will always be a punch or kick input
; in LH format (for iPlInfo_JoyNewKeysLH), with the CML_BTN flag stripped out.
;
; Notice that there are two possible inputs the game can choose.
; Which one is picked depends on the C flag passed to the subroutine, which is arbitrary
; for every point that calls this.
; In practice, the input lists are set so that #0 is always a light button, and #1 is always an heavy.
; This means the C flag effectively determines the strength of the move.
;
; IN
; - A: ID of the CPU_MoveInputList_* entry, should be a random value
; - C flag: If set, use LH input #1 (heavy button, iCPUMoveListItem_LastLHKeyB).
;           If clear, use #0 (light button, iCPUMoveListItem_LastLHKeyA)
Play_CPU_ApplyCharInput:

	;
	; Seek to the character-specific input list (CPU_MoveInputList_*)
	; HL = CPU_MoveListPtrTable[iPlInfo_CharId]
	;
	push af
		; A = CharId
		ld   hl, iPlInfo_CharId
		add  hl, bc
		ld   a, [hl]		
		; HL = Base char table
		ld   hl, CPU_MoveListPtrTable
		; Index the table (HL += A)
		add  a, l			; Index it
		jp   nc, .noovf		; Did we overflow? (never happens)
		inc  h 				
	.noovf:
		ld   l, a			; Save it back
		ld   e, [hl]		; Read out the ptr to DE
		inc  hl
		ld   d, [hl]
		push de				; Move it to HL
		pop  hl
	pop  af
	
	;
	; Seek to the <A>'th entry of the list and read out its bytes:
	; - DE: iCPUMoveListItem_MoveInputPtr
	; - A: iCPUMoveListItem_LastLHKeyA
	; - HL: Ptr to iCPUMoveListItem_LastLHKeyA
	;
	push af
		; As each entry is 4 bytes long, A = A * 4
		sla  a				; A = A * 4
		sla  a
		; Offset the move list table (HL += A)
		add  a, l			; Index HL by that
		jp   nc, .noovf2
		inc  h
	.noovf2:
		ld   l, a
		
		; HL now points to the start of the iCPUMoveListItem entry.
		; Read out its initial data.
		
		; [byte0-1] DE = iCPUMoveListItem_MoveInputPtr
		ld   e, [hl]
		inc  hl
		ld   d, [hl]
		inc  hl
	;
	; [TCRF] The English version of 95 (and 96) make a distinction here between move inputs that contain directional
	;        keys and those that don't, depending on the depending on the CMLB_BTN flag being set on the input's byte2.
	;
	;        This is important because there are separate input buffers for those.
	;
	;        The code is incomplete in the Japanese version though -- that flag and its respective checks doen't exist,
	;        so it always writes to the buffer meant for directional keys, which means the CPU will fail to perform 
	;        anything requiring MoveInput_PPP!
	;		
	IF VER_EN
		; [byte2] A = iCPUMoveListItem_LastLHKeyA
		;         For now, this is strictly used for the CML_BTN flag,
		;         which tells if this or the next value should be used as iPlInfo_JoyNewKeysLH
		ld   a, [hl]		; Read out byte2 to A
		
		push hl ; Save the ptr to iCPUMoveListItem_LastLHKeyA
		
			;
			; Determine what kind of MoveInput we're dealing with.
			; If A has CMLB_BTN set, treat the input as contining LH punch/kick buttons (.inptBtn)
			; Otherwise, treat it as containing d-pad keys (.inptDir).
			;
			; Note that the Play_CPU_ApplyMoveInput* subroutine called is the only difference
			; between .inptDir and .inptBtn.
			; Everything below that call is identical.
			;
	

			; Move this to HL for Play_CPU_ApplyMoveInput*
			push de			
			pop  hl
	
			bit  CMLB_BTN, a	; Is the flag set?
			jp   nz, .inptBtn	; If so, jump		
		.inptDir:
			
			;
			; Apply MoveInput to iPlInfo_JoyDirBuffer
			;
			call Play_CPU_ApplyMoveInputDir
			
			;
			; Determine which LH input to use for the button, then filter it and apply it.
			;
			
			; After the pop, HL will point to input #0.
			; If the C flag passed to the subroutine is set, increment HL once
			; to make it point to input #1.
		pop  hl				; HL = Ptr to iCPUMoveListItem_LastLHKeyA (#0)
	pop  af					; C flag = If set, use input #1
	jp   nc, .inptDir_setLH	; Is it set? If not, skip (use #0)
	inc  hl					; Otherwise, seek to #1 (iCPUMoveListItem_LastLHKeyB)
.inptDir_setLH:
	ld   a, [hl]			; Read LH input value
	and  a, $FF^CML_BTN		; Remove CML_BTN flag since it has another purpose
	ld   d, a				; D = LH Input
	ld   a, KEY_NONE		; A = Nothing
	jp   Play_CPU_SetJoyKeys
	
.inptBtn:
			call Play_CPU_ApplyMoveInputBtn
			; Rest is identical to above
		pop  hl
	pop  af
	jp   nc, .inptBtn_setLH
	inc  hl
.inptBtn_setLH:
	ld   a, [hl]
	and  a, $FF^CML_BTN			
	ld   d, a
	ld   a, KEY_NONE
	jp   Play_CPU_SetJoyKeys
ELSE		
		; Currently on [byte2]
		push hl ; Save the ptr to iCPUMoveListItem_LastLHKeyA
			
			; Move this to HL for Play_CPU_ApplyMoveInput*
			push de
			pop  hl
			
		.inptDir:
			
			;
			; Apply MoveInput to iPlInfo_JoyDirBuffer
			;
			call Play_CPU_ApplyMoveInputDir
			
			;
			; Determine which LH input to use for the button, then filter it and apply it.
			;
			
			; After the pop, HL will point to input #0.
			; If the C flag passed to the subroutine is set, increment HL once
			; to make it point to input #1.
		pop  hl				; HL = Ptr to iCPUMoveListItem_LastLHKeyA (#0)
		
	pop  af					; C flag = If set, use input #1
	jp   nc, .inpt_setLH	; Is it set? If not, skip (use #0)
	inc  hl					; Otherwise, seek to #1 (iCPUMoveListItem_LastLHKeyB)
.inpt_setLH:
	ld   a, KEY_NONE		; A = Nothing
	ld   d, [hl]			; Read LH input value
	jp   Play_CPU_SetJoyKeys
ENDC
	
; =============== Play_CPU_ApplyMoveInputBtn ===============
; Writes the "old" joypad keys values for buttons.
;
; This copies the inputs from a MoveInfo to the input buffer of A/B button keys.
;
; [TCRF] Unreferenced in the Japanese version, but it still exists.
; IN
; - HL: Ptr to a MoveInput structure containing only button inputs.
Play_CPU_ApplyMoveInputBtn:
	push bc
		push de
			; Move the ptr to DE
			push hl		; DE = HL
			pop  de
			
			;
			; The iMoveInputItem entries are stored from last to first for ease of checking when handling player inputs.
			; However, since we're replacing the input buffer with inputs from a MoveInput, we have to write
			; them in reverse.
			;
			
			;
			; Make iPlInfo_JoyBtnBufferOffset point to where the last MoveInput entry would be written.
			;
			
			; A = (iMoveInput_Length - 1) * 2
			ld   a, [de]	; A = iPlInfo_JoyBtnBufferOffset
			dec  a			; -1 since we want the last entry
			sla  a			; *2 since each iMoveInputItem is 2 bytes long
			; Set it as iPlInfo_JoyBtnBufferOffset
			ld   hl, iPlInfo_JoyBtnBufferOffset
			add  hl, bc
			ld   [hl], a
			
			; 
			; HL = Ptr to the newly set buffer location.
			;
			ld   hl, iPlInfo_JoyBtnBuffer
			add  hl, bc			; HL = Ptr to iPlInfo_JoyBtnBuffer
			add  a, l			; L += iPlInfo_JoyBtnBufferOffset
			ld   l, a
			
			;
			; A = iMoveInput_Length
			;
			ld   a, [de]		
			inc  de			; Seek to first iMoveInputItem_JoyKeys entry
			jp   Play_CPU_ApplyMoveInputCustom
; =============== Play_CPU_ApplyMoveInputDir ===============
; Writes the "old" joypad keys values for d-pad keys.
;
; Copies the inputs from a MoveInfo to the input buffer of directional keys.
; See also: Play_CPU_ApplyMoveInputBtn
; IN
; - HL: Ptr to a MoveInput structure containing only directional key inputs.
Play_CPU_ApplyMoveInputDir:
	push bc
		push de
			; DE = HL
			push hl
			pop  de
			; A = (iMoveInput_Length - 1) * 2
			ld   a, [de]
			dec  a
			sla  a
			; iPlInfo_JoyBtnBufferOffset = A
			ld   hl, iPlInfo_JoyDirBufferOffset
			add  hl, bc
			ld   [hl], a
			; HL = iPlInfo_JoyDirBuffer + A
			ld   hl, iPlInfo_JoyDirBuffer
			add  hl, bc
			add  a, l
			ld   l, a
			; A = iMoveInput_Length
			ld   a, [de]
			inc  de			; Seek to first iMoveInputItem_JoyKeys entry
			
			; Fall-through

		; =============== Play_CPU_ApplyMoveInputCustom ===============			
		; Copies inputs from a list of iMoveInputItem_* to the specified buffer.
		; The copy operation is done backwards, starting at HL and moving backwards,
		; and must point to an exact location so the last iMoveInputItem write aligns
		; to the first entry of the buffer.
		;
		; IN
		; - A: iMoveInput_Length
		; - DE: Ptr to first iMoveInputItem_JoyKeys (byte0) of MenuInput
		; - HL: Ptr to destination buffer (somewhere in iPlInfo_JoyBtnBuffer or iPlInfo_JoyDirBuffer)
		Play_CPU_ApplyMoveInputCustom:
			
			; For every iMoveInputItem entry...
			push af				; Save remaining count
			
				;
				; Copy the keypress bitmask to byte0 of the iPlInfo_Joy*Buffer entry
				;
				ld   a, [de]	; A = iMoveInputItem_JoyKeys
				ldi  [hl], a	; Copy it over to byte0, and seek to byte1
				
				;
				; Copy the max keypress length to byte1 of the of the iPlInfo_Joy*Buffer entry
				;
				inc  de			; Seek to iMoveInputItem_JoyMaskKeys
				inc  de			; Seek to iMoveInputItem_MinLength
				inc  de			; Seek to iMoveInputItem_MaxLength
				ld   a, [de]	; A = iMoveInputItem_MaxLength
				ld   [hl], a	; Copy it over to byte1
				
				;
				; Advance to next iMoveInputItem entry (source)
				; and go back to byte0 of the previous iPlInfo_Joy*Buffer entry (destination)
				;
				inc  de			; Seek to iMoveInputItem_JoyKeys of next entry
				
				dec  hl			; Seek back to byte0 of current iPlInfo_Joy*Buffer entry
				dec  hl			; Seek back to byte1 of previous iPlInfo_Joy*Buffer entry
				dec  hl			; and to byte0
				
			;
			; Are we done?
			;
			pop  af				; Restore remaining count
			dec  a				; Copied all bytes?
			jp   nz, Play_CPU_ApplyMoveInputCustom	; If not, loop
		pop  de
	pop  bc
	ret
	
; =============== CPU_MoveListPtrTable ===============
; Assigns to each character a list of move inputs they can perform.
CPU_MoveListPtrTable:
	dw CPU_MoveInputList_Kyo ; CHAR_ID_KYO     
	dw CPU_MoveInputList_Benimaru ; CHAR_ID_BENIMARU
	dw CPU_MoveInputList_Ryo ; CHAR_ID_RYO     
	dw CPU_MoveInputList_Yuri ; CHAR_ID_YURI    
	dw CPU_MoveInputList_Terry ; CHAR_ID_TERRY   
	dw CPU_MoveInputList_Joe ; CHAR_ID_JOE     
	dw CPU_MoveInputList_Heidern ; CHAR_ID_HEIDERN 
	dw CPU_MoveInputList_Ralf ; CHAR_ID_RALF    
	dw CPU_MoveInputList_Athena ; CHAR_ID_ATHENA  
	dw CPU_MoveInputList_Kensou ; CHAR_ID_KENSOU  
	dw CPU_MoveInputList_Kim ; CHAR_ID_KIM     
	dw CPU_MoveInputList_Mai ; CHAR_ID_MAI     
	dw CPU_MoveInputList_Iori ; CHAR_ID_IORI    
	dw CPU_MoveInputList_Eiji ; CHAR_ID_EIJI    
	dw CPU_MoveInputList_Billy ; CHAR_ID_BILLY   
	dw CPU_MoveInputList_Saisyu ; CHAR_ID_SAISYU  
	dw CPU_MoveInputList_Rugal ; CHAR_ID_RUGAL   
	dw CPU_MoveInputList_Nakoruru ; CHAR_ID_NAKORURU
	
; =============== CPU_MoveInputList_* ===============
; List of character-specific move inputs.
; The English version mostly switches around some slots and adds in the CML_BTN flags.
; The slot changes were likely made due to the addition of Play_CPU_OnBlockstunKnockback,
; which tries to guard-cancel using the entry in slot #1.
; See also: Play_CPU_ApplyCharInput for more info.
CPU_MoveInputList_Kyo:
IF VER_EN
	; DF+P -> 108 Shiki Yami Barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
	; DF+P -> 108 Shiki Yami Barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; BDB+K -> 101 Shiki Oboro Guruma
	dw MoveInput_BDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FDB+K -> 212 Shiki Kototsuki You 
	dw MoveInput_FDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> 75 Shiki Kai
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> 75 Shiki Kai
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> 75 Shiki Kai
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DBDF+P -> Ura 108 Shiki Orochi Nagi
	dw MoveInput_DBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Benimaru:
	; FDF+P -> Raijinken
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DU+K -> Super Inazuma Kick
	dw MoveInput_DU
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FDB+K -> Shinkuu Katate Goma
	dw MoveInput_FDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> Iai Geri
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> Iai Geri
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> Iai Geri
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K -> Iai Geri
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DFDF+P -> Raikouken
	dw MoveInput_DFDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Ryo:
	; DF+P -> Ko Ou Ken
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; FDF+P -> Ko Hou
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; BF+K -> Hien Shippuu Kyaku
	dw MoveInput_BF_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; FDB+P -> Zanretsuken
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; BF+K -> Hien Shippuu Kyaku
	dw MoveInput_BF_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; FDF+P -> Ko Hou
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DF+P -> Ko Ou Ken
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FBDF+P -> Haoh Shoukou Ken
	dw MoveInput_FBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BDF+P (close) -> Kyokuken Ryu Renbu Ken
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DFDB+P -> Ryu Ko Ranbu
	dw MoveInput_DFDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Yuri:
	; DF+P -> Ko Ou Ken
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; FDF+P -> Kuu Ga
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DB+P -> Sai Ha
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; FDB+P -> Hyaku Retsu Binta
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; DB+P -> Sai Ha
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; FDF+P -> Kuu Ga
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DF+K -> Rai'oh Ken
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FBDF+P -> Haoh Shoukou Ken
	dw MoveInput_FBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> Ko Ou Ken
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FBFDB+K -> Hien Hou'ou Kyaku
	dw MoveInput_FBFDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Terry:
	; DF+P -> Power Wave
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; DU+P -> Rising Tackle
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DB+P -> Burn Knuckle
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DB+K -> Crack Shot
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

IF VER_EN
	; DB+P -> Burn Knuckle
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DU+P -> Rising Tackle
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; FDF+K -> Power Dunk
	dw MoveInput_FDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+P -> Power Wave
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; FDF+P -> [BUG] Power Wave, likely meant to be Power Dunk though.
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DB+P -> Burn Knuckle
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DBDF+P -> Power Geyser
	dw MoveInput_DBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Joe:
	; BDF+P -> Hurricane Upper
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; DF+K -> Tiger Kick
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; BF+K -> Slash Kick
	dw MoveInput_BF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; PPP -> Bakuretsuken 
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY

IF VER_EN
	; BF+K -> Slash Kick
	dw MoveInput_BF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; DF+K -> Tiger Kick
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; DB+K -> Ougon no Kakato
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; BDF+P -> Hurricane Upper
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+K -> Tiger Kick
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FBDF+P -> Screw Upper
	dw MoveInput_FBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Heidern:
	; BF+P -> Cross Cutter
	dw MoveInput_BF_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DU+K -> Neck Roller
	dw MoveInput_DU_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FDB+P -> Storm Bringer
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DU+P -> Moon Slasher
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BF+P -> Cross Cutter
	dw MoveInput_BF_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DU+K -> Neck Roller
	dw MoveInput_DU_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DU+P -> Moon Slasher
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BDU+K -> Final Bringer
	dw MoveInput_BDU_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Ralf:
	; PPP -> Vulcan Punch
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY

	; BF+P -> Gatling Attack
	dw MoveInput_BF_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BDF+K -> Super Argentine Back Breaker
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DU+P -> Kyuukouka Bakudan Punch
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; BDF+K -> Super Argentine Back Breaker
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; PPP -> Vulcan Punch
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY
ENDC

	; BF+P -> Gatling Attack
	dw MoveInput_BF_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DU+P -> Kyuukouka Bakudan Punch
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; (DB)BF+P -> Baribari Vulcan Punch
	dw MoveInput_1BF_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Athena:

	; DB+P -> Psycho Ball
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
IF VER_EN
	; FDF+P -> Psycho Sword
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
	; BDF+K -> Psycho Reflector
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; BDF+K -> Psycho Reflector
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
	
	; FDF+P -> Psycho Sword
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DB+P -> Psycho Ball
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Psycho Ball
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Psycho Ball
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; BDF+K -> Psycho Reflector
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; BDF+P -> [BUG] Nothing
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; BFDB+P -> Shining Crystal Bit
	dw MoveInput_BFDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Kensou:
	; DB+P -> Chou Kyuu Dan
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BDB+K -> Ryuu Gaku Sai
	dw MoveInput_BDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; BDF+P -> Ryuu Ren Ga
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Chou Kyuu Dan
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Chou Kyuu Dan
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Chou Kyuu Dan
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; BDF+P -> Ryuu Ren Ga
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DFBF+K -> Shinryuu Tenbu Kyaku
	dw MoveInput_DFBF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Kim:
	; DB+K -> Han Getsu Zan
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DU+K -> Hien Zan
	dw MoveInput_DU_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+K (Air) -> Hishou Kyaku
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; BF+K -> Ryuusei Ranku
	dw MoveInput_BF_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DB+K -> Han Getsu Zan
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; BF+K -> Ryuusei Ranku
	dw MoveInput_BF_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DU+K -> Hien Zan
	dw MoveInput_DU_Charge
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DBDF+K -> Hou'ou Kyaku
	dw MoveInput_DBDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Mai:
	; DF+P -> Ka Cho Sen
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; FDF+K -> Hisho Ryu En Jin
	dw MoveInput_FDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; BDF+K -> Hissatsu Shinobibachi
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; DB+P -> Ryu En Bu
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
IF VER_EN
	; BDF+K -> Hissatsu Shinobibachi
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; FDF+K -> Hisho Ryu En Jin
	dw MoveInput_FDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; DU+P -> Chijou Musasabi no Mai
	dw MoveInput_DU_Charge
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Ryu En Bu
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FBF+K -> Cho Hissatsu Shinobibachi
	dw MoveInput_FBF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Iori:
IF VER_EN
	; DF+P -> 108 Shiki Yami-barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> 108 Shiki Yami-barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DB+P -> 127 Aoi Hana
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDB+K -> Shiki Koto Tsuki In
	dw MoveInput_FDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DF+P -> 108 Shiki Yami-barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> 108 Shiki Yami-barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> 108 Shiki Yami-barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DBDF+P -> Kin 1211 Shiki Ya Otome
	dw MoveInput_DBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Eiji:
	; DF+P -> Kikouhou
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
IF VER_EN
	; DB+K -> Kage Utsushi
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; FDB+K -> Kotsu Hazaki Kiri
	dw MoveInput_FDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; BDF+P -> Ryuu Eijin
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+P -> Kasumi Geri
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DFDB+P -> Zantetsuha
	dw MoveInput_DFDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; FDB+K -> Kotsu Hazaki Kiri
	dw MoveInput_FDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; DB+K -> Kage Utsushi
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; DF+K -> Tenbakyaku
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; BDFB+K -> Zantetsu Tourouken
	dw MoveInput_BDFB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Billy:
	; BDF+P -> Sansetsu Kon Chuudan Uchi
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; BDF+P -> Sansetsu Kon Chuudan Uchi
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; PPP -> Senpuu Kon
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY
ENDC

	; DB+P -> Suzume Otoshi
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; PPP -> Senpuu Kon
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY
ELSE
	; BDF+P -> Sansetsu Kon Chuudan Uchi
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; BDF+P -> Sansetsu Kon Chuudan Uchi
	dw MoveInput_BDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
IF VER_EN
	; DB+P -> Suzume Otoshi
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; PPP -> Senpuu Kon
	dw MoveInput_PPP
	db KEP_B_LIGHT|CML_BTN
	db KEP_B_HEAVY
ENDC

	; BDF+K -> Kyoushuu Hishou Kon
	dw MoveInput_BDF
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DFDB+P -> Chou Kaen Senpuu Kon
	dw MoveInput_DFDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Saisyu:
	; DF+P -> 108 Shiki Yami Barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDB+P -> 702 Shiki En Jou
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> 108 Shiki Yami Barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDF+P -> 100 Shiki Oni Yaki
	dw MoveInput_FDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDB+P -> 702 Shiki En Jou
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> 108 Shiki Yami Barai
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DBDF+P -> Ura 108 Shiki Orochi Nagi
	dw MoveInput_DBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

CPU_MoveInputList_Rugal:
	; DF+P -> Reppu Ken
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; DB+K -> Genocide Cutter
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ELSE
	; FDB+P -> God Press
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DF+K -> Dark Barrier
	dw MoveInput_DF
	db KEP_A_LIGHT
	db KEP_A_HEAVY
	
IF VER_EN
	; FDB+P -> God Press
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DB+K -> Genocide Cutter
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY
ENDC

	; FBDF+P -> Kaiser Wave
	dw MoveInput_FBDF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDB+P -> God Press
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DB+K -> Genocide Cutter
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; FDBFDB+K -> Gigantic Pressure
	dw MoveInput_FDBFDB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

CPU_MoveInputList_Nakoruru:
	; FDB+P -> Amube Yatoro (Bird Throw)
	dw MoveInput_FDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

IF VER_EN
	; DF+P -> Lela Mutsube (Upwards Dash)
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; BD+P -> Annu Mutsube (Horizontal Dash)
	dw MoveInput_BD
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; BDB+P -> Kamui Rimse (Cape Swing)
	dw MoveInput_BDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
	
IF VER_EN
	; BD+P -> Annu Mutsube (Horizontal Dash)
	dw MoveInput_BD
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ELSE
	; DF+P -> Lela Mutsube (Upwards Dash)
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC

	; DB+K -> Mamahaha Flight
	dw MoveInput_DB
	db KEP_A_LIGHT
	db KEP_A_HEAVY

	; DB+P (Air) -> Yatoro Pokku (Spin)
	dw MoveInput_DB
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; DF+P -> Lela Mutsube (Upwards Dash)
	dw MoveInput_DF
	db KEP_B_LIGHT
	db KEP_B_HEAVY

	; FDBFDB+P -> Elerush Kamui Rimse (Super Cape Swing)
	dw MoveInput_FDBFDB
	db KEP_B_LIGHT
	db KEP_B_HEAVY
ENDC
; 
; =============== END OF SUBMODULE Play->CPU ===============
;

IF VER_EN
GFXDef_TakaraLogo: mGfxDef "data/gfx/en/takaralogo.bin"
BG_TakaraLogo: INCBIN "data/bg/en/takaralogo.bin"
GFXDef_LagunaLogo: mGfxDef "data/gfx/en/lagunalogo.bin"
BG_LagunaLogo: INCBIN "data/bg/en/lagunalogo.bin"
ELSE

GFXDef_TakaraLogo: mGfxDef "data/gfx/takaralogo.bin"
BG_TakaraLogo: INCBIN "data/bg/takaralogo.bin"

; In BANK $18 on the English version
FontDef_Default: 
	dw $9000 	; Destination ptr
	db $30 		; Tiles to copy
.col:
	db COL_WHITE ; Bit0 color map (background)
	db COL_BLACK ; Bit1 color map (foreground)
	; 1bpp font gfx
.gfx:
	INCBIN "data/gfx/font.bin"

ENDC

; 
; =============== START OF MODULE SGB ===============
;
SGBPacket_FreezeScreen:
	pkg SGB_PACKET_MASK_EN, $01
	db $01
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
	db $00
	
SGBPacket_ResumeScreen:
	pkg SGB_PACKET_MASK_EN, $01
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
	db $00
	db $00

; Data from 7F574 to 7F583 (16 bytes)
SGBPacket_DisableMultiJoy: 
	pkg SGB_PACKET_MLT_REQ, $01
	db $00 ; No multicontroller
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
	db $00

SGBPacket_EnableMultiJoy_2Pl: 
	pkg SGB_PACKET_MLT_REQ, $01
	db $01 ; Enable multicontroller, two players
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
	db $00
	
; [TCRF] Unreferenced SGB Packet
SGBPacket_Unused_EnableMultiJoy_4Pl:
	pkg SGB_PACKET_MLT_REQ, $01
	db $03 ; Enable multicontroller, four players
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
	db $00

SGBPacket_SGB1BiosPatch7:
	pkg SGB_PACKET_DATA_SND, $01
	dw $085D ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $8C,$D0,$F4,$60,$00,$00,$00,$00,$00,$00,$00 ; Byte sequence
SGBPacket_SGB1BiosPatch6:
	pkg SGB_PACKET_DATA_SND, $01
	dw $0852 ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $A9,$E7,$9F,$01,$C0,$7E,$E8,$E8,$E8,$E8,$E0 ; Byte sequence
SGBPacket_SGB1BiosPatch5:
	pkg SGB_PACKET_DATA_SND, $01
	dw $0847 ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $C4,$D0,$16,$A5,$CB,$C9,$05,$D0,$10,$A2,$28 ; Byte sequence
SGBPacket_SGB1BiosPatch4:
	pkg SGB_PACKET_DATA_SND, $01
	dw $083C ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $F0,$12,$A5,$C9,$C9,$C8,$D0,$1C,$A5,$CA,$C9 ; Byte sequence
SGBPacket_SGB1BiosPatch3:
	pkg SGB_PACKET_DATA_SND, $01
	dw $0831 ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $0C,$A5,$CA,$C9,$7E,$D0,$06,$A5,$CB,$C9,$7E ; Byte sequence
SGBPacket_SGB1BiosPatch2:
	pkg SGB_PACKET_DATA_SND, $01
	dw $0826 ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $39,$CD,$48,$0C,$D0,$34,$A5,$C9,$C9,$80,$D0 ; Byte sequence
SGBPacket_SGB1BiosPatch1:
	pkg SGB_PACKET_DATA_SND, $01
	dw $081B ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $EA,$EA,$EA,$EA,$EA,$A9,$01,$CD,$4F,$0C,$D0 ; Byte sequence
SGBPacket_SGB1BiosPatch0:
	pkg SGB_PACKET_DATA_SND, $01
	dw $0810 ; SNES Destination - Ptr
	db $00 ; SNES Destination - Bank
	db $0B ; Write $0B bytes
	db $4C,$20,$08,$EA,$EA,$EA,$EA,$EA,$60,$EA,$EA ; Byte sequence

; =============== SGB_ApplyScreenPalSet ===============
; Applies the SGB palette and color attributes for screens.
; IN
; - DE: Screen Palette ID
SGB_ApplyScreenPalSet:
	;
	; Prepare the display for SGB packet transfer.
	;
	ldh  a, [rIE]				; Save interrupt value
	push af
		xor  a					; Disable all interrupts
		ldh  [rIE], a
		push de
			; Black out screen
			ld   a, $FF			
			ldh  [rBGP], a
			ldh  [rOBP0], a
			ldh  [rOBP1], a
			; Wait for VBLANK
			; Enable LCD otherwise the LCD stop function will not wait for VBlank
			ldh  a, [rLCDC]		
			or   a, LCDC_ENABLE
			ldh  [rLCDC], a
			; Wait 4 ticks
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
			; Stop LCD + wait VBlanl
			rst  $10
		pop  de
		
		;
		; Index the packet ptr table with DE
		;
		ld   hl, SGB_ScrPalTbl	; HL = Ptr to table start
		sla  e				; DE * 8 = Offset
		rl   d
		sla  e
		rl   d
		sla  e
		rl   d
		add  hl, de			; Seek to table entry
		
		;
		; Send out packet #1 (bytes 0-1)
		; Packet #1 is always present, and sets SGB palette entries 0 and 1.
		;
		ld   e, [hl]		; DE = Ptr to packet
		inc  hl
		ld   d, [hl]
		inc  hl
		push hl				
			push de			; HL = DE
			pop  hl
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  hl
		
		;
		; Send out packet #2 (bytes 2-3)
		;
		; Packet #2 is optional, and sets SGB palette entries 2 and 3.
		; If the ptr is null, skip it.
		ld   e, [hl]		; DE = Ptr to packet
		inc  hl
		ld   d, [hl]
		inc  hl
		ld   a, d			; DE == 0?
		or   e
		jp   z, .sendPak3	; If so, skip
		push hl
			push de			; HL = DE
			pop  hl
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  hl
		
	.sendPak3:
		;
		; Send out packet #3 (bytes 4-5)
		;
		; Packet #3 is always present, and sets color palette attributes.
		ld   e, [hl]
		inc  hl
		ld   d, [hl]
		inc  hl
		push hl
			push de
			pop  hl
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  hl
		
		
	pop  af
	ldh  [rIE], a
	ret 
	
; =============== SGB_ApplyWinPicPalSet ===============
; Applies the SGB palette and color attributes for a single large win pic.
; To draw all pics in Team Mode, this is called multiple times with different parameters.
; IN
; - D: Character ID
; - E: Pic Position ID (PIC_POS_*)
SGB_ApplyWinPicPalSet:
	;
	; Prepare the display for SGB packet transfer.
	;
	ldh  a, [rIE]				; Save interrupt value
	push af
		xor  a					; Disable all interrupts
		ldh  [rIE], a
		push de
			; Black out screen
			ld   a, $FF			
			ldh  [rBGP], a
			ldh  [rOBP0], a
			ldh  [rOBP1], a
			; Wait for VBLANK
			; Enable LCD otherwise the LCD stop function will not wait for VBlank
			ldh  a, [rLCDC]		
			or   a, LCDC_ENABLE
			ldh  [rLCDC], a
			; Wait 4 ticks
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
			; Stop LCD + wait VBlanl
			rst  $10
		pop  de
	
		; 
		; Write out the customizable middle SGB Packet for the palette change.
		; This sends the base hardcoded background palette (0-*) and the custom
		; one for the point character (1-*).
		;
		; Bizzarely, this is being done here even though the packet only gets sent
		; when we get to .picM.
		;
		ld   hl, wSGBWinPacketMid
		ld   a, $01 ; SGB_PACKET_PAL01, $01
		ldi  [hl], a
		; 0-0
		ld   a, LOW($739C)
		ldi  [hl], a
		ld   a, HIGH($739C)
		ldi  [hl], a
		; 0-1
		ld   a, LOW($3200)
		ldi  [hl], a
		ld   a, HIGH($3200)
		ldi  [hl], a
		; 0-2
		ld   a, LOW($2180)
		ldi  [hl], a
		ld   a, HIGH($2180)
		ldi  [hl], a
		; 0-3
		ld   a, LOW($0000)
		ldi  [hl], a
		ld   a, HIGH($0000)
		ldi  [hl], a
		
		;
		; Determine which pic to set the palette for
		;
		ld   a, e
		cp   PIC_POS_M			; Drawing the middle pic?
		jr   nz, .picSide		; If not, jump
	.picM:
		push de
			; Set character-specific palette
			ld   a, d
			call SGB_SetCharPalToPkg
			
			; Write terminator byte
			ld   [hl], $00
			
			; Send the packet over
			ld   hl, wSGBWinPacketMid
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  de
		jr   .chkPat

	.picSide:
		;
		; Send a separate packet to set the palettes for the team member on
		; the left (2-*) and for the one on the right (3-*).
		;
		; While these are part of the same packet, characters palettes are sent one at a time.
		; So what we do is filling the palette for 2-* and sending the incomplete packet.
		; The next time we call the subroutine, we fill in the palette for 3-* and resend both palettes again.
		;
		ld   hl, wSGBWinPacketSide
		ld   a, $09 ; SGB_PACKET_PAL23, $01
		ldi  [hl], a
		; 0-0 (must be the same as the one for SGB_PACKET_PAL01)
		ld   a, LOW($739C)
		ldi  [hl], a
		ld   a, HIGH($739C)
		ldi  [hl], a
		
		; Left or right pic?
		ld   a, e
		and  a			; E != PIC_POS_L?
		jr   nz, .picR	; If so, jump
	.picL:
		push de
			; Set character-specific palette to 2-*
			ld   a, d
			call SGB_SetCharPalToPkg
			
			; Send the potentially incomplete packet with 2-*
			ld   hl, wSGBWinPacketSide
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  de
		jr   .chkPat

	.picR:
		push de
			; Seek to 3-* palette
IF FIX_BUGS
			ld   hl, wSGBWinPacketSide+9
ELSE
			ld   hl, wSGBWinPacketSide+8
			; [BUG] Pointless write that turns palette 2-3 into $0084
			xor  a
			ldi  [hl], a
ENDC
			; Set character-specific palette to 3-*
			ld   a, d
			call SGB_SetCharPalToPkg
			
			; Write terminator
			ld   [hl], $00
			
			; Send the complete packet with 2-* and 3-*
			ld   hl, wSGBWinPacketSide
			call SGB_SendPackets
			ld   bc, $0004
			call SGB_DelayAfterPacketSendCustom
		pop  de
		
	.chkPat:
		;
		; Pick the palette map depending on the pic's position.
		;
		
		; Try middle pic first
		ld   hl, SGBPacket_WinScrPicM_Pat
		ld   a, e
		cp   PIC_POS_M		; Middle pic?
		jr   z, .applyPat	; If so, jump
		
		; Try left next
		ld   hl, SGBPacket_WinScrPicL_Pat	
		cp   PIC_POS_L		; Left pic?
		jr   z, .applyPat	; If so, jump
		
		; Otherwise, assume right pic
		ld   hl, SGBPacket_WinScrPicR_Pat
	.applyPat:
		call SGB_SendPackets
		ld   bc, $0004
		call SGB_DelayAfterPacketSendCustom
		
	pop  af
	ldh  [rIE], a
	ret

; =============== SGB_SetCharPalToPkg ===============
; Loads the character-specific palette to the specified SGB packet.
; Each character is assigned two custom SGB colors (*-1 and *-2), with 1-3 being an hardcoded black.
; IN
; - A: Character ID
; - HL: Ptr to *-1 palette location in a SGB packet in RAM (destination)
SGB_SetCharPalToPkg:
	; Read the ptr to the partial SGB packet data off the table
	push hl
		ld   hl, SGB_WinCharPalPtrTable	; HL = Ptr to base
		ld   d, $00		; Index = CharId
		ld   e, a
		add  hl, de		; Offset it
		ld   e, [hl]	; Read out the ptr to DE
		inc  hl
		ld   d, [hl]
	pop  hl
	
	; Copy the palettes
	
	; 1-1 (Custom 1)
	ld   a, [de]
	ldi  [hl], a
	inc  de
	
	ld   a, [de]
	ldi  [hl], a
	inc  de
	
	; 1-2 (Custom 2)
	ld   a, [de]
	ldi  [hl], a
	inc  de
	
	ld   a, [de]
	ldi  [hl], a
	
	; 1-3 (Fixed Black)
	ld   a, LOW($1084)
	ldi  [hl], a
	ld   a, HIGH($1084)
	ldi  [hl], a
	ret

; =============== SGB_ScrPalTbl ===============
; Defines the screen palette sets
SGB_ScrPalTbl:
	;; PAL01                            PAL23                       ATTR                      END
	dw SGBPacket_Intro_Pal01,           $0000,                      SGBPacket_Pat_AllPal0,    $0000
	dw SGBPacket_TakaraLogo_Pal01,      $0000,                      SGBPacket_Pat_AllPal0,    $0000
	dw SGBPacket_Title_Pal01,           SGBPacket_Title_Pal23,      SGBPacket_Title_Pat,      $0000
	dw SGBPacket_CharSelect_Pal01,      SGBPacket_CharSelect_Pal23, SGBPacket_CharSelect_Pat, $0000
	dw SGBPacket_StageClear_Pal01,      $0000,                      SGBPacket_Pat_AllPal0,    $0000
	dw SGBPacket_Stage_00_Pal01,        $0000,                      SGBPacket_Stage_Pat,      $0000 ; Stadium Stage (Green Blue)
	dw SGBPacket_Stage_01_Pal01,        $0000,                      SGBPacket_Stage_Pat,      $0000 ; Purple stage
	dw SGBPacket_Stage_02_Pal01,        $0000,                      SGBPacket_Stage_Pat,      $0000 ; Rugal?
	dw SGBPacket_Stage_03_Pal01,        $0000,                      SGBPacket_Stage_Pat,      $0000 ; Stadium Alternate? (Yellow Blue)
	dw SGBPacket_Stage_04_Pal01,        $0000,                      SGBPacket_Stage_Pat,      $0000 ; Pipes Stage
IF VER_EN
	dw SGBPacket_LagunaLogo_Pal01,      $0000,                      SGBPacket_Pat_AllPal0,    $0000
ENDC
	
SGBPacket_Intro_Pal01:	
	pkg SGB_PACKET_PAL01, $01
	dw $7FFF ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $0000 ; 1-1
	dw $0000 ; 1-2
	dw $0000 ; 1-3
	db $00
	
IF VER_EN
; New Red/Black Takara logo
SGBPacket_TakaraLogo_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $009C ; 0-0
	dw $0014 ; 0-1
	dw $000C ; 0-2WW
	dw $0000 ; 0-3
	dw $0000 ; 1-1
	dw $0000 ; 1-2
	dw $0000 ; 1-3
	db $00
ELSE
; Black/White Takara logo
SGBPacket_TakaraLogo_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $7FFF ; 0-0
	dw $4210 ; 0-1
	dw $2108 ; 0-2
	dw $0000 ; 0-3
	dw $0000 ; 1-1
	dw $0000 ; 1-2
	dw $0000 ; 1-3
	db $00
ENDC	

IF VER_EN
; Laguna Entertainment Logo
SGBPacket_LagunaLogo_Pal01: 
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $011C ; 0-1
	dw $7380 ; 0-2
	dw $0000 ; 0-3
	dw $0000 ; 1-1
	dw $0000 ; 1-2
	dw $0000 ; 1-3
	db $00
ENDC
	
IF VER_EN
SGBPacket_Title_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $031C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $7208 ; 1-1
	dw $7100 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Title_Pal23:
	pkg SGB_PACKET_PAL23, $01
	dw $739C ; 0-0
	dw $4210 ; 2-1
	dw $318C ; 2-2
	dw $0000 ; 2-3
	dw $029C ; 3-1
	dw $111C ; 3-2
	dw $0000 ; 3-3
	db $00
ELSE
SGBPacket_Title_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $7FFF ; 0-0
	dw $02FF ; 0-1
	dw $0C9C ; 0-2
	dw $0000 ; 0-3
	dw $7EEF ; 1-1
	dw $7900 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Title_Pal23:
	pkg SGB_PACKET_PAL23, $01
	dw $7FFF ; 0-0
	dw $6210 ; 2-1
	dw $7900 ; 2-2
	dw $0000 ; 2-3
	dw $6210 ; 3-1
	dw $3D6B ; 3-2
	dw $0000 ; 3-3
	db $00
ENDC
	
SGBPacket_CharSelect_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $229C ; 0-1
	dw $1098 ; 0-2
	dw $1084 ; 0-3
	dw $029C ; 1-1
	dw $020C ; 1-2
	dw $1084 ; 1-3
	db $00
SGBPacket_CharSelect_Pal23: 
	pkg SGB_PACKET_PAL23, $01
	dw $739C ; 0-0
	dw $229C ; 2-1
	dw $6090 ; 2-2
	dw $1084 ; 2-3
	dw $229C ; 3-1
	dw $7188 ; 3-2
	dw $1084 ; 3-3
	db $00

; Not necessary, as the 0-* colors are set again when the first character palette is loaded.
SGBPacket_StageClear_Pal01:	
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $3200 ; 0-1
	dw $2180 ; 0-2
	dw $0000 ; 0-3
	dw $0000 ; 1-1
	dw $0000 ; 1-2
	dw $0000 ; 1-3
	db $00
	
; Stage-specific palettes
SGBPacket_Stage_00_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $6B9E ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $2280 ; 1-1
	dw $5100 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Stage_01_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $229C ; 1-1
	dw $5014 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Stage_02_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $4284 ; 1-1
	dw $5000 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Stage_03_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $739C ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $031E ; 1-1
	dw $5084 ; 1-2
	dw $0000 ; 1-3
	db $00
SGBPacket_Stage_04_Pal01:
	pkg SGB_PACKET_PAL01, $01
	dw $7BDE ; 0-0
	dw $021C ; 0-1
	dw $109C ; 0-2
	dw $0000 ; 0-3
	dw $029C ; 1-1
	dw $1200 ; 1-2
	dw $0000 ; 1-3
	db $00
	
; Palette map which sets Pal01 to the entire screen
SGBPacket_Pat_AllPal0: 
	pkg SGB_PACKET_ATTR_BLK, $01
	db $01	; 1 Set
	;--
	db %00000011 ; Change inside/box border
	ads 0,0,0 ; Pals
	db $00 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $11 ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	
SGBPacket_CharSelect_Pat:
	pkg SGB_PACKET_ATTR_BLK, $03
	db $06	; 6 Sets
	;--
	; Base red palette
	db %00000011 ; Change inside/box border
	ads 0,0,0 ; Pals
	db $00 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $11 ; Y2
	;--
	; Color Heidern green
	db %00000011 ; Change inside/box border
	ads 1,1,1 ; Pals
	db $01 ; X1
	db $06 ; Y1
	db $03 ; X2
	db $08 ; Y2
	;--
	; Color Saisyu green
	db %00000011 ; Change inside/box border
	ads 1,1,1 ; Pals
	db $0A ; X1
	db $09 ; Y1
	db $0C ; X2
	db $0B ; Y2
	;--
	; Color Eiji purple
	db %00000011 ; Change inside/box border
	ads 2,2,2 ; Pals
	db $04 ; X1
	db $09 ; Y1
	db $06 ; X2
	db $0B ; Y2
	;--	
	; Color Kim blue
	db %00000011 ; Change inside/box border
	ads 3,3,3 ; Pals
	db $0D ; X1
	db $06 ; Y1
	db $0F ; X2
	db $08 ; Y2
	;--	
	; Color Kensou blue
	db %00000011 ; Change inside/box border
	ads 3,3,3 ; Pals
	db $0A ; X1
	db $06 ; Y1
	db $0C ; X2
	db $08 ; Y2
	;--
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
	db $00
	
IF VER_EN
SGBPacket_Title_Pat:
	pkg SGB_PACKET_ATTR_BLK, $04
	db $09 ; 9 Sets
	;--
	; Fill with red palette
	db %00000011 ; Change inside/box border
	ads 0,0,0 ; Pals
	db $00 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $11 ; Y2
	;--
	; Color blue the text above the title
	db %00000010 ; Change box border
	ads 1,1,1 ; Pals
	db $07 ; X1
	db $02 ; Y1
	db $0D ; X2
	db $02 ; Y2
	;--
	; Color gray the 95 digit
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $10 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $00 ; Y2
	;--
	db %00000011 ; Change inside/box border
	ads 2,2,2 ; Pals
	db $0F ; X1
	db $01 ; Y1
	db $13 ; X2
	db $0A ; Y2
	;--
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $0E ; X1
	db $05 ; Y1
	db $0E ; X2
	db $0A ; Y2
	;--
	db %00000011 ; Change box border
	ads 2,2,2 ; Pals
	db $04 ; X1
	db $07 ; Y1
	db $0D ; X2
	db $0A ; Y2	
	;--
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $02 ; X1
	db $08 ; Y1
	db $03 ; X2
	db $0A ; Y2	
	;--
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $0E ; X1
	db $02 ; Y1
	db $0E ; X2
	db $02 ; Y2	
	;--
	; Color the "cloud"/fire layer red
	db %00000011 ; Change box border
	ads 3,3,3 ; Pals
	db $00 ; X1
	db $0B ; Y1
	db $13 ; X2
	db $0E ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
ELSE
SGBPacket_Title_Pat:
	pkg SGB_PACKET_ATTR_BLK, $04
	db $09 ; 9 Sets
	;--
	; Fill with red palette
	db %00000011 ; Change inside/box border
	ads 0,0,0 ; Pals
	db $00 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $11 ; Y2
	;--
	; Color blue the text above the title
	db %00000010 ; Change box border
	ads 1,1,1 ; Pals
	db $07 ; X1
	db $04 ; Y1
	db $0D ; X2
	db $05 ; Y2
	;--
	; Alternate palette to prevent a color clash between the blue text and the gray 95 digit
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $0D ; X1
	db $04 ; Y1
	db $0E ; X2
	db $04 ; Y2
	;--
	db %00000010 ; Change box border
	ads 2,2,2 ; Pals
	db $0E ; X1
	db $05 ; Y1
	db $0E ; X2
	db $05 ; Y2
	;--
	; Color gray the 95 digit
	db %00000010 ; Change box border
	ads 3,3,3 ; Pals
	db $0D ; X1
	db $02 ; Y1
	db $13 ; X2
	db $03 ; Y2
	;--
	db %00000011 ; Change inside/box border
	ads 3,3,3 ; Pals
	db $0F ; X1
	db $04 ; Y1
	db $13 ; X2
	db $0B ; Y2
	;--
	db %00000010 ; Change box border
	ads 3,3,3 ; Pals
	db $0E ; X1
	db $07 ; Y1
	db $0E ; X2
	db $0B ; Y2
	;--
	db %00000011 ; Change inside/box border
	ads 3,3,3 ; Pals
	db $07 ; X1
	db $09 ; Y1
	db $0D ; X2
	db $0B ; Y2
	;--
	db %00000010 ; Change box border
	ads 3,3,3 ; Pals
	db $04 ; X1
	db $0A ; Y1
	db $06 ; X2
	db $0B ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
ENDC
	mIncJunk "L1F78F1"
SGBPacket_Stage_Pat:
	pkg SGB_PACKET_ATTR_BLK, $02 ; Could have been $01
	db $02 ; 2 Sets
	;--
	db %00000011 ; Change inside/box border
	ads 0,0,0 ; Pals
	db $00 ; X1
	db $00 ; Y1
	db $13 ; X2
	db $11 ; Y2
	;--
	db %00000011 ; Change inside/box border
	ads 1,1,1 ; Pals
	db $00 ; X1
	db $03 ; Y1
	db $13 ; X2
	db $0D ; Y2
	;--
	db $00
	db $00
	mIncJunk "L1F7907"

; Win Screen - Center Picture (Active Character)
SGBPacket_WinScrPicM_Pat:
	pkg SGB_PACKET_ATTR_BLK, $01
	db $01 ; 1 set
	;--
	db %00000011 ; Change filled box with border
	ads 1,1,1 ; Pals
	db $07 ; X1
	db $03 ; Y1
	db $0C ; X2
	db $08 ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	
; Left picture
SGBPacket_WinScrPicL_Pat:
	pkg SGB_PACKET_ATTR_BLK, $01
	db $01 ; 1 set
	;--
	db %00000011 ; Change filled box with border
	ads 2,2,2 ; Pals
	db $01 ; X1
	db $03 ; Y1
	db $06 ; X2
	db $08 ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00

; Right picture
SGBPacket_WinScrPicR_Pat:
	pkg SGB_PACKET_ATTR_BLK, $01
	db $01 ; 1 set
	;--
	db %00000011 ; Change filled box with border
	ads 3,3,3 ; Pals
	db $0D ; X1
	db $03 ; Y1
	db $12 ; X2
	db $08 ; Y2
	;--
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00
	db $00

; Win Screen - Color assignments for every character
SGB_WinCharPalPtrTable:
	dw SGB_WinCharPal_YlBr   ; CHAR_ID_KYO     
	dw SGB_WinCharPal_OrRd1  ; CHAR_ID_BENIMARU
	dw SGB_WinCharPal_OrRd2  ; CHAR_ID_RYO     
	dw SGB_WinCharPal_Pi1Rd3 ; CHAR_ID_YURI    
	dw SGB_WinCharPal_OrRd1  ; CHAR_ID_TERRY   
	dw SGB_WinCharPal_OrRd2  ; CHAR_ID_JOE     
	dw SGB_WinCharPal_YeGr   ; CHAR_ID_HEIDERN 
	dw SGB_WinCharPal_OrRd1  ; CHAR_ID_RALF    
	dw SGB_WinCharPal_Pi2Rd2 ; CHAR_ID_ATHENA  
	dw SGB_WinCharPal_OrBl   ; CHAR_ID_KENSOU  
	dw SGB_WinCharPal_OrBl   ; CHAR_ID_KIM     
	dw SGB_WinCharPal_Pi1Rd3 ; CHAR_ID_MAI     
	dw SGB_WinCharPal_OrRd2  ; CHAR_ID_IORI    
	dw SGB_WinCharPal_YePu   ; CHAR_ID_EIJI    
	dw SGB_WinCharPal_OrRd2  ; CHAR_ID_BILLY   
	dw SGB_WinCharPal_YeGr   ; CHAR_ID_SAISYU  
	dw SGB_WinCharPal_BrRd4  ; CHAR_ID_RUGAL   
	dw SGB_WinCharPal_Pi2Rd2 ; CHAR_ID_NAKORURU

; Yellow, Brown
SGB_WinCharPal_YlBr:
	dw $221C, $0194

; Orange, Red
SGB_WinCharPal_OrRd1:
	dw $229C, $101C

; Orange, Slightly more orange-ish red
SGB_WinCharPal_OrRd2:
	dw $229C, $111C

; Pink, Red
SGB_WinCharPal_Pi1Rd3:
	dw $429C, $109C

; Yellow, Green
SGB_WinCharPal_YeGr:
	dw $129C, $020C

; Pink (slightly different), slightly more orange-ish red
SGB_WinCharPal_Pi2Rd2:
	dw $329C, $111C

; Orange, Blue
SGB_WinCharPal_OrBl:
	dw $221C, $7100

; Yellow, Purple
SGB_WinCharPal_YePu:
	dw $129C, $6090

; Brown, Red
SGB_WinCharPal_BrRd4:
	dw $3214, $1098
; 
; =============== END OF MODULE SGB ===============
;

; 
; =============== START OF MODULE TakaraLogo ===============
;
; =============== Module_TakaraLogo ===============
; EntryPoint for TakaraLogo. Called as first task by the task handler.
Module_TakaraLogo:
	ld   sp, $DD00

	; The English version extracted the code to their own subroutines.
	; This organization was kept for 96, even with the Laguna Logo not present.
IF VER_EN

	IF VER_EU
		call LagunaLogo_Do
	ENDC
	call TakaraLogo_Do
	
	; Switch module
	ld   b, BANK(Module_Intro)
	ld   hl, Module_Intro
	jp   FarJump
	
; =============== LagunaLogo_Do ===============
; Main code for displaying the Laguna logo.
LagunaLogo_Do:
	di
	; Set base bank (self)
	ld   a, BANK(Module_TakaraLogo) 
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Use screen continuously
	ld   hl, wMisc_C028
	ld   [hl], $00
	
	; Reset DMG Pal
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	
	ld   de, SCRPAL_LAGUNALOGO
	call HomeCall_SGB_ApplyScreenPalSet
	
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset coords
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	
	; Copy logo GFX
	ld   hl, GFXDef_LagunaLogo
	ld   de, $9000
	call CopyTilesAutoNum
	
	; Copy logo tilemap
	ld   de, BG_LagunaLogo
	ld   hl, $98C2
	ld   b, $10
	ld   c, $06
	call CopyBGToRect

	; Wipe sprites
	call ClearOBJInfo
	
	; Disable window 
	xor  a
	ldh  [rWY], a
	ldh  [rWX], a
	ldh  [rSTAT], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	; (VBlank will hit now) 
	call Task_PassControl_NoDelay
	
	; Set DMG palettes
	ld   a, $E4
	ldh  [rOBP0], a
	ld   a, $FF
	ldh  [rOBP1], a
	ld   a, $E4
	ldh  [rBGP], a
	
	; Mute sound
	ld   a, SND_MUTE
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; Show this screen for 180 frames
	ld   bc, $00B4
.mainLoop:	
	call Task_PassControl_NoDelay	; Pass control
	dec  bc						; FramesLeft--
	ld   a, b
	or   a, c					; FramesLeft == 0?
	jp   nz, .mainLoop			; If not, loop
.end:
	ret							; Otherwise we're done	
	
; =============== TakaraLogo_Do ===============
; Main code for displaying the Takara logo.
TakaraLogo_Do:
ENDC

	di
	; Set base bank (self)
	ld   a, BANK(Module_TakaraLogo) 
	ld   [MBC1RomBank], a
	ldh  [hROMBank], a
	;-----------------------------------
	rst  $10				; Stop LCD
	
	; Use screen continuously
	ld   hl, wMisc_C028
	ld   [hl], $00
	
	; Reset DMG Pal
	xor  a
	ldh  [rBGP], a
	ldh  [rOBP0], a
	ldh  [rOBP1], a

	ld   de, SCRPAL_TAKARALOGO
	call HomeCall_SGB_ApplyScreenPalSet
	
	call ClearBGMap
	call ClearWINDOWMap
	
	; Reset coords
	xor  a
	ldh  [hScrollX], a
	ldh  [hScrollY], a
	
	; Copy logo GFX
	ld   hl, GFXDef_TakaraLogo
	ld   de, $9000
	call CopyTilesAutoNum
	
	; Copy logo tilemap. The newer logo is shorter.
	ld   de, BG_TakaraLogo
IF VER_EN
	ld   hl, $98E2	; VRAM Destination
	ld   b, $10		; Width
	ld   c, $03		; Height
ELSE
	ld   hl, $98C2	; VRAM Destination
	ld   b, $10		; Width
	ld   c, $05		; Height
ENDC
	call CopyBGToRect
	
	; Wipe sprites
	call ClearOBJInfo
	
	; Disable window 
	xor  a
	ldh  [rWY], a
	ldh  [rWX], a
	ldh  [rSTAT], a
	
	ld   a, LCDC_PRIORITY|LCDC_OBJENABLE|LCDC_WTILEMAP|LCDC_ENABLE
	rst  $18				; Resume LCD
	;-----------------------------------
	ei
	; (VBlank will hit now)
	call Task_PassControl_NoDelay
	
	; Set DMG palette for sprites
	ld   a, $E4
	ldh  [rOBP0], a
	ld   a, $FF
	ldh  [rOBP1], a
	
	; And for the logo itself
IF !VER_EN
	; Always white text on black background
	ld   a, $93
	ldh  [rBGP], a
ELSE
	;
	; The palette depends on the hardware.
	;
	; On a DMG, it uses black text on a white background for some reason,
	; while the proper palette is used for SGB mode (to have red text on black background).
	;
	
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a	; Running on SGB?
	jp   z, .setDMGPal		; If not, jump
.setSGBPal:
	ld   a, $93				; W on B
	jp   .setPal
.setDMGPal:
	ld   a, $6C				; B on W
.setPal:
	ldh  [rBGP], a
ENDC

	; Mute sound
	ld   a, $00
	call HomeCall_Sound_ReqPlayExId_Stub
	
	; Initialize variables for cheat count
	ld   hl, wCheatBossKeysLeft
	ld   a, 3		; wCheatBossKeysLeft
	ldi  [hl], a
	ld   a, 20		; wCheatAllCharKeysLeft
	ldi  [hl], a
	ld   a, 25		; wCheatInfMeterKeysLeft
	ldi  [hl], a
	ld   a, 30		; wCheatEasyMovesKeysLeft
	ldi  [hl], a
	
	; Show this screen for 360 frames (+ whatever it takes for the SGB features to load)
	ld   bc, 360	
.mainLoop:

	; =============== TakaraLogo_CheckCheat ===============
	; Activates dip switches when certain button combinations are pressed X times.
	; Moved to its own function in 96.
	
.TakaraLogo_CheckCheat:
	ld   hl, hJoyKeys
	ld   d, [hl]			; D = Held keys
	inc  hl
	ld   e, [hl]			; E = Newly pressed keys
	ld   hl, wDipSwitch		; HL = Dip switches
	
.chkTeamDupe:
	;
	; Duplicate chars in team
	; Hold A + B + SELECT
	;
	bit  KEYB_SELECT, e					; Pressed SELECT?
	jp   z, .chkBoss					; If not, skip
	bit  DIPB_TEAM_DUPL, [hl]			; Already unlocked?
	jp   nz, .chkBoss					; If so, skip
	ld   a, d
	cp   KEY_A|KEY_B|KEY_SELECT			; Holding the button combination?
	jp   nz, .chkBoss					; If not, skip
	; Set cheats
	set  DIPB_TEAM_DUPL, [hl]
	; Play SGB sound
	push hl
		ld   hl, (SGB_SND_A_CUPBREAK << 8)|$01
		call SGB_PrepareSoundPacketA
		ld   a, SFX_PROJ_LG
		call HomeCall_Sound_ReqPlayExId
	pop  hl

.chkBoss:
	;
	; Unlock Saisyu/Rugal
	; Press SELECT 3 times.
	;
	
	bit  KEYB_SELECT, e					; Pressed SELECT?
	jp   z, .chkAllChar					; If not, skip
	bit  DIPB_UNLOCK_BOSS, [hl]			; Already unlocked?
	jp   nz, .chkAllChar				; If so, skip
	
	; Decrement key counter. If 0, enable the cheat
	ld   a, [wCheatBossKeysLeft]
	dec  a								
	ld   [wCheatBossKeysLeft], a		
	jp   nz, .chkAllChar				
	set  DIPB_UNLOCK_BOSS, [hl]
	push hl
		ld   hl, (SGB_SND_A_ESCBUBL << 8)|$00
		call SGB_PrepareSoundPacketA
		ld   a, SFX_CURSORMOVE
		call HomeCall_Sound_ReqPlayExId
	pop  hl
	
.chkAllChar:
	;
	; Unlock other characters
	; Press SELECT 20 times.
	;
	bit  KEYB_SELECT, e				; Pressed SELECT?
	jp   z, .chkInfMeter			; If not, skip
	bit  DIPB_UNLOCK_OTHER, [hl]	; Already unlocked?
	jp   nz, .chkInfMeter			; If so, skip
	
	; Decrement key counter. If 0, enable the cheat
	; This is decremented simultaneously with the Boss counter.
	ld   a, [wCheatAllCharKeysLeft]
	dec  a
	ld   [wCheatAllCharKeysLeft], a
	jp   nz, .chkInfMeter
	
	set  DIPB_UNLOCK_OTHER, [hl]
	push hl
		ld   hl, (SGB_SND_A_ESCBUBL << 8)|$01
		call SGB_PrepareSoundPacketA
		ld   a, SFX_CHARSELECTED
		call HomeCall_Sound_ReqPlayExId
	pop  hl
	
	
.chkInfMeter:
	;
	; Infinite MAXIMUM meter.
	; Press SELECT 25 times, requires SGB mode for some reason.
	;
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a			; Running on SGB hardware?
	jp   z, .chkEasyMovesSGB		; If not, skip
	bit  KEYB_SELECT, e				; Pressed SELECT?
	jp   z, .chkEasyMovesSGB		; If not, skip
	bit  DIPB_MAXPOW, [hl]			; Already enabled?
	jp   nz, .chkEasyMovesSGB		; If so, skip
	
	; Decrement key counter. If 0, enable the cheat
	ld   a, [wCheatInfMeterKeysLeft]
	dec  a
	ld   [wCheatInfMeterKeysLeft], a
	jp   nz, .chkEasyMovesSGB
	set  DIPB_MAXPOW, [hl]
	
	push hl
		ld   hl, (SGB_SND_A_BREATH << 8)|$01
		call SGB_PrepareSoundPacketA
		ld   a, SFX_HIT
		call HomeCall_Sound_ReqPlayExId
	pop  hl
	;--
.chkEasyMovesSGB:
	;
	; Easy Moves + SGB Sound Test + Powerup mode.
	; Press LEFT + A + B + SELECT 30 times.
	; (can be done by holding LEFT + A + B and tapping SELECT 30 times)
	;
	; Locked behind SGB support here, even though DIPB_EASY_MOVES/DIPB_POWERUP doesn't require it.
	; This suggests the code originally only enabled the SGB Sound Test.
	; Whatever it was, this SGB check was deleted in 96.
	;
	ld   a, [wMisc_C025]
	bit  MISCB_IS_SGB, a					; Running on SGB hardware?
	jp   z, .chkWait						; If not, skip
	
	bit  KEYB_SELECT, e						; Pressed SELECT?
	jp   z, .chkWait						; If not, skip
	ld   a, d
	cp   KEY_LEFT|KEY_A|KEY_B|KEY_SELECT	; Holding the button combination?
	jp   nz, .chkWait						; If not, skip
	bit  DIPB_EASY_MOVES, [hl]				; Already unlocked?
	jp   nz, .chkWait						; If so, skip
	
	; Decrement key counter. If 0, enable the cheat
	ld   a, [wCheatEasyMovesKeysLeft]
	dec  a
	ld   [wCheatEasyMovesKeysLeft], a
	jp   nz, .chkWait
	
	set  DIPB_EASY_MOVES, [hl] ; and DIPB_POWERUP
	set  DIPB_SGB_SOUND_TEST, [hl]
	push hl
		ld   hl, (SGB_SND_A_PUNCH_A << 8)|$01
		call SGB_PrepareSoundPacketA
		ld   a, SFX_FIREHIT
		call HomeCall_Sound_ReqPlayExId
	pop  hl
	;--
	; ==============================
	
	; When pressing START from either controller, skip the delay
	; This got removed in the English version!
.chkWait:
IF !VER_EN
	ldh  a, [hJoyNewKeys]
	ld   d, a
	ldh  a, [hJoyNewKeys2]
	or   a, d
	bit  KEYB_START, a			; Start pressed?
	jp   nz, .end				; If so, jump
ENDC
	call Task_PassControl_NoDelay	; Pass control
	dec  bc						; FramesLeft--
	ld   a, b
	or   a, c					; FramesLeft == 0?
	jp   nz, .mainLoop			; If not, loop
	
.end:
IF VER_EN
	; It's a subroutine in the English version
	ret
ELSE
	; Otherwise we're done
	ld   b, BANK(Module_Intro) ; BANK $1D
	ld   hl, Module_Intro
	jp   FarJump
ENDC

; 
; =============== END OF MODULE TakaraLogo ===============
;

; =============== Sound_ReqPlayExId ===============
; Requests playback for the sound associated with the specified action.
; Some may be played on the SGB side if possible.
;
; Horrendous implementation that got replaced by table indexing code in 96.
;
; IN:
; - A: Action ID or DMG Sound ID
Sound_ReqPlayExId:

IF !NO_SGB_SOUND
	ld   hl, wMisc_C025
	bit  MISCB_IS_SGB, [hl]		; SGB hardware?
	jp   nz, .sgb				; If so, jump
ENDC

.dmg:
	; Check sound action IDs one by one, mapping them to DMG sound IDs.
	bit  7, a				; A >= SND_BASE ($80)?
	jp   nz, .dmgPlay		; If so, this is already a DMG sound ID, no mapping necessary.
	cp   SCT_SHCRYSTSPAWN
	jp   z, .snd_id_b4
	cp   SCT_REFLECT
	jp   z, .snd_id_b2
	cp   SCT_PROJ_SM
	jp   z, .snd_id_b4
	cp   SCT_MOVEJUMP_A
	jp   z, .snd_id_a8_2
	cp   SCT_MOVEJUMP_B
	jp   z, .snd_id_a7
	cp   SCT_UNUSED_MOVEJUMP_D
	jp   z, .snd_id_a8_2
	cp   SCT_FIREHIT
	jp   z, .snd_id_a4
	cp   SCT_PROJ_LG_A
	jp   z, .snd_id_b5
	cp   SCT_PHYSFIRE
	jp   z, .snd_id_a4
	cp   SCT_PROJ_LG_B
	jp   z, .snd_id_a4
	cp   SCT_GROUNDHIT
	jp   z, .snd_id_a6
	cp   SCT_MULTIHIT
	jp   z, .snd_id_a8
	cp   SCT_KIKOUHOU
	jp   z, .snd_id_b2
	cp   SCT_TAUNT
	jp   z, .snd_id_a9
	cp   SCT_BARRIER
	jp   z, .snd_id_b4
	jp   .dmgPlay
	
; =============== mSndDmg ===============
; Landing target for DMG playback.
; Format:
; - 1: DMG Sound ID
MACRO mSndDmg
	ld   a, \1
	jp   .dmgPlay
ENDM

.unused_snd_id_ae: mSndDmg SFX_CHARGEMETER ; [TCRF] Unreferenced, as there's no SCT_CHARGEMETER
.snd_id_a9:        mSndDmg SFX_TAUNT
.snd_id_a8:        mSndDmg SFX_HEAVY
.snd_id_a4:        mSndDmg SFX_FIREHIT
.snd_id_b4:        mSndDmg SFX_BARRIER
.unused_snd_id_b1: mSndDmg SFX_UNUSED_SPECIAL_B ; [TCRF] Unreferenced, possibly intended to go with SCT_KIKOUHOU
.snd_id_b5:        mSndDmg SFX_PROJ_LG
.snd_id_a6:        mSndDmg SFX_GROUNDHIT
.snd_id_a8_2:      mSndDmg SFX_HEAVY ; Identical to .snd_id_a8
.snd_id_a7:        mSndDmg SFX_LIGHT
.snd_id_b2:        mSndDmg SFX_REFLECT

.dmgPlay:
	ld   [wSndSet], a
	ret  
	
.sgb:
	; Replace specific sound IDs / sound action IDs with SGB sounds.
	cp   SCT_SHCRYSTSPAWN
	jp   z, .SGB_SND_A_JETSTART_01
	cp   SCT_REFLECT
	jp   z, .SGB_SND_A_WATERFALL_03
	cp   SFX_LIGHT
	jp   z, .SGB_SND_A_SELECT_B_03
	cp   SFX_HEAVY
	jp   z, .SGB_SND_A_ATTACK_B_02
	cp   SFX_CHARGEMETER
	jp   z, .SGB_SND_A_FADEIN_03
	cp   SFX_BLOCK
	jp   z, .SGB_SND_A_WINOPEN_03
	cp   SFX_HIT
	jp   z, .SGB_SND_A_PUNCH_A_03
	cp   SCT_PROJ_SM
	jp   z, .SGB_SND_A_SWORDSWING_03
	cp   SCT_MOVEJUMP_A
	jp   z, .SGB_SND_A_ATTACK_B_01
	cp   SCT_MOVEJUMP_B
	jp   z, .SGB_SND_A_ATTACK_B_01_2
	cp   SCT_UNUSED_MOVEJUMP_D
	jp   z, .SGB_SND_A_ATTACK_B_01
	cp   SCT_FIREHIT
	jp   z, .SGB_SND_A_PUNCH_A_01
	cp   SCT_PROJ_LG_A
	jp   z, .SGB_SND_A_PUNCH_A_00
	cp   SCT_PHYSFIRE
	jp   z, .SGB_SND_A_FIRE_02
	cp   SCT_PROJ_LG_B
	jp   z, .SGB_SND_A_FIRE_07
	cp   SCT_GROUNDHIT
	jp   z, .SGB_SND_A_PUNCH_B_01
	cp   SCT_MULTIHIT
	jp   z, .SGB_SND_A_ATTACK_A_03
	cp   SCT_TAUNT
	jp   z, .SGB_SND_A_FASTJUMP_02
	cp   SCT_BARRIER
	jp   z, .SGB_SND_A_PICTFLOAT_03
	cp   SCT_KIKOUHOU
	jp   z, .SGB_SND_A_JETPROJ_B_03
	cp   SCT_UNUSED_SWORD
	jp   z, .SGB_SND_A_SWORDSWING_02
	; No mapping found! Fallback to DMG playback.
	jp   .noSgbMap
	
; =============== mSndSgb ===============
; Landing target for SGB playback.
; Format:
; - 1: SGB Sound ID
; - 2: Sound Attributes
MACRO mSndSgb
	ld   h, \1
	ld   l, \2
	call SGB_PrepareSoundPacketA
	ret  
ENDM
	
.SGB_SND_A_FASTJUMP_02:        mSndSgb SGB_SND_A_FASTJUMP,   $02
.SGB_SND_A_ATTACK_A_03:        mSndSgb SGB_SND_A_ATTACK_A,   $03
.SGB_SND_A_FIRE_07:            mSndSgb SGB_SND_A_FIRE,       $07
.SGB_SND_A_FIRE_02:            mSndSgb SGB_SND_A_FIRE,       $02
.SGB_SND_A_SWORDSWING_03:      mSndSgb SGB_SND_A_SWORDSWING, $03
.SGB_SND_A_SWORDSWING_02:      mSndSgb SGB_SND_A_SWORDSWING, $02
.SGB_SND_A_PUNCH_A_00:         mSndSgb SGB_SND_A_PUNCH_A,    $00
.SGB_SND_A_PUNCH_B_01:         mSndSgb SGB_SND_A_PUNCH_B,    $01
.SGB_SND_A_ATTACK_B_01:        mSndSgb SGB_SND_A_ATTACK_B,   $01
.SGB_SND_A_ATTACK_B_01_2:      mSndSgb SGB_SND_A_ATTACK_B,   $01 ; Identical to the one above
.SGB_SND_A_PUNCH_A_01:         mSndSgb SGB_SND_A_PUNCH_A,    $01
.SGB_SND_A_PUNCH_A_03:         mSndSgb SGB_SND_A_PUNCH_A,    $03
.SGB_SND_A_WINOPEN_03:         mSndSgb SGB_SND_A_WINOPEN,    $03
.unused_SGB_SND_A_SELECT_B_03: mSndSgb SGB_SND_A_SELECT_B,   $03 ; [TCRF] Unreferenced clone of function below
.SGB_SND_A_SELECT_B_03:        mSndSgb SGB_SND_A_ATTACK_B,   $03
.SGB_SND_A_ATTACK_B_02:        mSndSgb SGB_SND_A_ATTACK_B,   $02
.SGB_SND_A_FADEIN_03:          mSndSgb SGB_SND_A_FADEIN,     $03
.SGB_SND_A_JETSTART_01:        mSndSgb SGB_SND_A_JETSTART,   $01
.SGB_SND_A_PICTFLOAT_03:       mSndSgb SGB_SND_A_PICTFLOAT,  $03
.SGB_SND_A_WATERFALL_03:       mSndSgb SGB_SND_A_WATERFALL,  $03
.SGB_SND_A_JETPROJ_B_03:       mSndSgb SGB_SND_A_JETPROJ_B,  $03

.noSgbMap:
	ld   [wSndSet], a
	ret
; =============== END OF BANK ===============
; Junk area below.
IF VER_US
	mIncJunk "../padding_us/L1F7FD7"
ELIF VER_EN
	mIncJunk "L1F7FDA"
ELSE
	mIncJunk "L1F7C92"
ENDC