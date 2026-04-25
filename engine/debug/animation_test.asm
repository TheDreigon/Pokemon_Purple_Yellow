; Debug-only Animation Test screen for Pokémon Purple Yellow.
;
; Lets the developer pick a move from a scrollable LIST and watch its
; animation auto-loop in PLAY view. Reached from the debug menu (ANIM
; entry).
;
; UX:
;   * LIST view (entry point):
;       UP/DOWN move cursor by 1, LEFT/RIGHT page by 10, A enters PLAY,
;       B exits to debug menu. Window of 10 items visible at a time.
;   * PLAY view:
;       Auto-loops the current move's animation with a short (~1s)
;       pause between plays. LEFT/RIGHT cycle prev/next move (with
;       wrap from NUM_ATTACKS back to 1 and vice-versa) — re-enters
;       PLAY for the new move. A replays immediately. B returns to LIST.
;
; Layout (PLAY view mirrors a real battle so the engine's mon-sprite
; animations have something to animate):
;   * Enemy front sprite (Rattata) at hlcoord (12, 0), top-right 7x7.
;   * Player back sprite (Pikachu) at hlcoord (1, 5), mid-left 7x7.
;   * Move ID + name on row 13 (bottom dialogue area).
;   * Hints on rows 15-16.
;
; Implementation notes:
;   * wWhichPokemon is reused as the current move ID storage. It's
;     scratch in this debug context; the next thing to read it (a real
;     battle/menu) re-initialises it.
;   * Music is stopped on entry and wAudioROMBank is forced to
;     BANK(Audio2_PlaySound) so the SFX dispatcher routes battle SFX
;     to SFX_Headers_2 (the only header table that actually contains
;     the move SFX implementations).
;   * Sprites are reloaded at the start of every PLAY iteration so
;     animations like Transform (which copies the enemy pic over the
;     player back-pic in VRAM) don't leave the player permanently
;     stuck as the enemy. Cheap (a few frames per iteration).
;   * AnimTest_DrawPlayHeader only redraws the bottom text rows so the
;     sprite tilemap entries survive.

DEF ANIM_TEST_VISIBLE_ITEMS    EQU 10
DEF ANIM_TEST_LIST_FIRST_ROW   EQU 2
DEF ANIM_TEST_LIST_CURSOR_COL  EQU 1
DEF ANIM_TEST_LIST_TEXT_COL    EQU 2

AnimationTestMenu::
IF DEF(_DEBUG)
	; --- Stop title-screen music so move SFX is audible ---
	xor a                         ; instant fade-out (0 frames)
	ld [wAudioFadeOutControl], a
	call StopAllMusic
.waitMusicStop
	ld a, [wAudioFadeOutControl]
	and a
	jr nz, .waitMusicStop
	call StopAllSounds

	; --- Point the audio engine at the battle SFX bank (Audio2) ---
	ld a, BANK(Audio2_PlaySound)
	ld [wAudioROMBank], a

	; --- Setup screen + battle UI tiles + palette ---
	call ClearScreen
	call ClearSprites
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns

	; Set the CGB battle palette NOW (not just on PLAY entry) so the
	; LIST view also renders in clean greys instead of inheriting the
	; title-screen yellow/red. Also resets the BG attribute map so
	; residual title-screen tile palettes don't bleed into our text.
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand

	; Animation context defaults
	xor a
	ldh [hWhoseTurn], a
	ld [wAnimationType], a
	ld [wAnimSoundID], a
	ld [wSubAnimSubEntryAddr], a
	ld [wSubAnimTransform], a

	; Default to first move
	ld a, 1
	ld [wWhichPokemon], a

; ---------------------------------------------------------------
; LIST view: scrollable list of all NUM_ATTACKS moves
; ---------------------------------------------------------------
.listView
	call AnimTest_DrawList
.listInputLoop
	call DelayFrame
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	bit BIT_A_BUTTON, a
	jp nz, .enterPlayView
	bit BIT_B_BUTTON, a
	jp nz, .exit
	bit BIT_D_UP, a
	jr nz, .listUp
	bit BIT_D_DOWN, a
	jr nz, .listDown
	bit BIT_D_LEFT, a
	jr nz, .listPageUp
	bit BIT_D_RIGHT, a
	jr nz, .listPageDown
	jr .listInputLoop
.listUp
	ld a, [wWhichPokemon]
	dec a
	jr nz, .storeListMove
	ld a, NUM_ATTACKS                 ; wrap from 1 to NUM_ATTACKS
	jr .storeListMove
.listDown
	ld a, [wWhichPokemon]
	inc a
	cp NUM_ATTACKS + 1
	jr c, .storeListMove
	ld a, 1                            ; wrap from NUM_ATTACKS to 1
	jr .storeListMove
.listPageUp
	ld a, [wWhichPokemon]
	sub 10
	jr c, .pageUnderflow
	jr nz, .storeListMove
.pageUnderflow
	ld a, 1
	jr .storeListMove
.listPageDown
	ld a, [wWhichPokemon]
	add 10
	jr c, .pageOverflow                ; carry from 8-bit add (move id > 255)
	cp NUM_ATTACKS + 1
	jr c, .storeListMove
.pageOverflow
	ld a, NUM_ATTACKS
.storeListMove
	ld [wWhichPokemon], a
	jp .listView

; ---------------------------------------------------------------
; PLAY view: load sprites once, then auto-loop the animation
; ---------------------------------------------------------------
.enterPlayView
	; Initial setup that's the same for every PLAY entry: clear screen,
	; load both mon sprites with the proper CGB battle palette.
	call AnimTest_LoadBattleSceneAndSprites

.playAnim
	; Re-load sprites BEFORE every play so anims like Transform that
	; rewrite the back-pic VRAM area don't persist between iterations.
	; The reload now disables auto-BG-transfer internally so the
	; tilemap clear inside LoadMonBackPic isn't briefly visible (was
	; causing Pikachu to blink in/out at the start of every iteration).
	call AnimTest_ReloadSprites

	; Play the current move's animation
	ld a, [wWhichPokemon]
	ld [wAnimationID], a
	predef MoveAnimation
	callfar Func_78e98

	; Func_78e98 saved/restored the tilemap; the bottom text rows may
	; have been clobbered by the animation so redraw them.
	call AnimTest_DrawPlayHeader

	; Inter-loop pause, ~30 frames (~0.5s) at 60Hz, polling input.
	; v0.7: switched from JoypadLowSensitivity/hJoy5 to plain Joypad/hJoyHeld.
	; Reason: JoypadLowSensitivity reads hJoyPressed (edge-triggered, set
	; only on the single frame a button transitions from released to held)
	; AND has a 30-frame deadband after any registered press. During an
	; animation (1s+), DelayFrame is called repeatedly inside MoveAnimation,
	; refreshing Joypad each frame and clearing hJoyPressed the frame after
	; it was set. So any tap that happens DURING the animation is lost
	; before the pause loop runs — the user has to time their press exactly
	; into the 30-frame pause window AND hit just on the first frame.
	; Reading hJoyHeld instead means: any frame the button is being held
	; during the pause window registers. Hold L/R briefly and the next
	; move plays. Much more forgiving.
	ld c, 30
.pauseFrame
	push bc
	call DelayFrame
	call Joypad
	pop bc
	ldh a, [hJoyHeld]
	bit BIT_B_BUTTON, a
	jp nz, .listView                   ; B in PLAY = back to LIST
	bit BIT_D_LEFT, a
	jr nz, .playPrev
	bit BIT_D_RIGHT, a
	jr nz, .playNext
	bit BIT_A_BUTTON, a
	jp nz, .playAnim                   ; A = replay now
	dec c
	jr nz, .pauseFrame
	jp .playAnim                       ; auto-replay after pause
.playNext
	ld a, [wWhichPokemon]
	inc a
	cp NUM_ATTACKS + 1
	jr c, .storePlayMove
	ld a, 1
	jr .storePlayMove
.playPrev
	ld a, [wWhichPokemon]
	dec a
	jr nz, .storePlayMove
	ld a, NUM_ATTACKS
.storePlayMove
	ld [wWhichPokemon], a
	; v0.7: redraw the move name/ID line IMMEDIATELY after L/R presses.
	; Previously it only updated after the new move's animation finished
	; playing — so the user saw old-name → animation → new-name with
	; seconds of lag. Now the name updates before the animation starts,
	; giving instant visual feedback that the press registered.
	call AnimTest_DrawPlayHeader
	jp .playAnim

.exit
	jp DebugMenu


; ===============================================================
; LIST view rendering
; ===============================================================
AnimTest_DrawList:
	call ClearScreen

	hlcoord 3, 0
	ld de, .listTitle
	call PlaceString

	; Compute window_start = current - 4, clamped to [1, NUM_ATTACKS - 9]
	ld a, [wWhichPokemon]
	sub 4
	jr nc, .startNotNeg
	ld a, 1
	jr .startClampLow
.startNotNeg
	or a
	jr nz, .startClampLow
	ld a, 1
.startClampLow
	cp NUM_ATTACKS - 9 + 1
	jr c, .startOk
	ld a, NUM_ATTACKS - 9
.startOk
	; b = window_start = first item to display
	ld b, a

	; Draw 10 items
	ld c, ANIM_TEST_VISIBLE_ITEMS      ; remaining count
	ld d, ANIM_TEST_LIST_FIRST_ROW     ; current row
.drawLoop
	push bc
	push de
	call AnimTest_DrawListItem         ; b = item ID, d = row
	pop de
	pop bc
	inc b
	inc d
	dec c
	jr nz, .drawLoop

	; Draw cursor "▶" at the row of the current item
	ld a, [wWhichPokemon]
	sub b                              ; b is now (window_start + 10), too late
	; ^ wrong, b mutated by loop. Recompute window_start instead.
	; Cleanest: recompute from current.
	ld a, [wWhichPokemon]
	sub 4
	jr nc, .cursorStartNotNeg
	ld a, 1
	jr .cursorStartClampLow
.cursorStartNotNeg
	or a
	jr nz, .cursorStartClampLow
	ld a, 1
.cursorStartClampLow
	cp NUM_ATTACKS - 9 + 1
	jr c, .cursorStartOk
	ld a, NUM_ATTACKS - 9
.cursorStartOk
	ld b, a                            ; b = window_start
	ld a, [wWhichPokemon]
	sub b                              ; a = offset within window (0..9)
	add ANIM_TEST_LIST_FIRST_ROW       ; a = row of current item
	; Compute hl for col CURSOR_COL, row a
	push af
	call AnimTest_RowToCoord
	pop af
	; hl now points to col 0 of row a; offset by cursor col
	ld bc, ANIM_TEST_LIST_CURSOR_COL
	add hl, bc
	ld [hl], "▶"

	; Footer hints
	hlcoord 0, 13
	ld de, .listHints1
	call PlaceString
	hlcoord 0, 14
	ld de, .listHints2
	call PlaceString
	hlcoord 0, 15
	ld de, .listHints3
	call PlaceString
	ret

.listTitle
	db "ANIMATION TEST@"
.listHints1
	db "UP/DN: select@"
.listHints2
	db "L/R:   page x10@"
.listHints3
	db "A: play  B: exit@"


; In: b = move ID (1..NUM_ATTACKS), d = display row
; Renders one list row: " NNN MOVENAME"
AnimTest_DrawListItem:
	; Save item ID to wd11e IMMEDIATELY — `ld bc, ...` and
	; AnimTest_RowToCoord both clobber b before we'd otherwise have a
	; chance to stash it. wd11e is read by both PrintNumber (via de) and
	; GetMoveName (directly), so a single store covers both calls.
	ld a, b
	ld [wd11e], a

	; Compute hl for col TEXT_COL, row d
	ld a, d
	call AnimTest_RowToCoord
	ld bc, ANIM_TEST_LIST_TEXT_COL
	add hl, bc

	; Print 3-digit ID at hl
	push hl
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber
	pop hl
	; Advance hl by 4 (3 digits + 1 space) for the name column
	ld bc, 4
	add hl, bc

	; Print move name (wd11e still has the item ID)
	push hl
	call GetMoveName
	pop hl
	call PlaceString
	ret


; In: a = row (0..17)
; Out: hl = wTileMap + row * SCREEN_WIDTH (col 0 of that row)
; Trashes: bc
AnimTest_RowToCoord:
	ld h, 0
	ld l, a
	add hl, hl                          ; * 2
	add hl, hl                          ; * 4
	ld c, l
	ld b, h                             ; bc = row * 4
	add hl, hl                          ; * 8
	add hl, hl                          ; * 16
	add hl, bc                          ; * 20 = SCREEN_WIDTH
	ld bc, wTileMap
	add hl, bc
	ret


; ===============================================================
; PLAY view rendering
; ===============================================================
AnimTest_LoadBattleSceneAndSprites:
	call ClearScreen
	call ClearSprites
	call AnimTest_ReloadSprites

	; CGB battle palette
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	ret


AnimTest_ReloadSprites:
	; v0.7: disable auto-BG-transfer for the duration of the reload.
	; LoadMonBackPic internally calls ClearScreenArea which blanks the
	; tilemap region where the sprite is shown — with auto-transfer on,
	; the next vblank flushes that blank state to VRAM and the user
	; sees Pikachu briefly disappear before the new tile IDs are
	; written. Disable -> reload -> re-enable means the BG map only
	; updates atomically once the new sprite is fully in place.
	xor a
	ldh [hAutoBGTransferEnabled], a

	; --- Enemy front sprite (Rattata) ---
	ld a, RATTATA
	ld [wd0b5], a
	ld [wcf91], a
	ld [wEnemyMonSpecies], a
	ld [wEnemyMonSpecies2], a
	call GetMonHeader
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ldh [hStartTileID], a
	hlcoord 12, 0
	predef CopyUncompressedPicToTilemap

	; --- Player back sprite (Pikachu) ---
	ld a, PIKACHU
	ld [wd0b5], a
	ld [wcf91], a
	ld [wBattleMonSpecies], a
	ld [wBattleMonSpecies2], a
	call GetMonHeader
	callfar LoadMonBackPic              ; lives in bank $3D, needs farcall
	ld a, $31
	ldh [hStartTileID], a
	hlcoord 1, 5
	predef CopyUncompressedPicToTilemap

	; Re-enable auto-BG-transfer; next vblank flushes the new tilemap.
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ret


AnimTest_DrawPlayHeader:
	; Clear ONLY the bottom text rows (12-17) so the sprites survive.
	hlcoord 0, 12
	lb bc, 6, SCREEN_WIDTH
	call ClearScreenArea

	; Move ID + name on row 13
	hlcoord 1, 13
	ld de, .moveLabel
	call PlaceString

	hlcoord 6, 13
	ld a, [wWhichPokemon]
	ld [wd11e], a
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber

	hlcoord 10, 13
	ld a, [wWhichPokemon]
	ld [wd11e], a
	push hl
	call GetMoveName
	pop hl
	call PlaceString

	; Footer hints
	hlcoord 1, 15
	ld de, .footer1
	call PlaceString
	hlcoord 1, 16
	ld de, .footer2
	call PlaceString
	ret

.moveLabel
	db "MOVE@"
.footer1
	db "L/R: PREV/NEXT@"
.footer2
	db "A:REPLAY  B:LIST@"

ELSE
	ret
ENDC
