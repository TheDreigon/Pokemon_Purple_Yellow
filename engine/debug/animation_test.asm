; Debug-only Animation Test screen for Pokémon Purple Yellow.
;
; Lets the developer cycle through every move animation with the d-pad
; and watch them on auto-loop. Reached from the debug menu (ANIM entry).
;
; UX:
;   * Auto-loops the current move's animation, with a ~2s pause between
;     plays.
;   * LEFT/RIGHT during the pause: prev/next move (with wrap from
;     NUM_ATTACKS back to 1 and vice-versa).
;   * A during the pause: replay immediately.
;   * B during the pause: exit back to the debug menu.
;
; Layout (mirrors a real battle so the engine's mon-sprite animations
; have something to animate):
;   * Enemy front sprite (Rattata) at hlcoord (12, 0), top-right 7x7.
;   * Player back sprite (Pikachu) at hlcoord (1, 5), mid-left 7x7.
;   * Move ID + name on row 13 (bottom dialogue area).
;   * Hints on rows 15-16.
;
; Implementation notes:
;   * wWhichPokemon is reused as the current move ID storage. It's
;     scratch in this debug context; the next thing to read it (a real
;     battle/menu) re-initialises it.
;   * Music is stopped on entry (otherwise the title-screen song keeps
;     playing and drowns out move SFX). It's not restarted on exit —
;     the debug menu doesn't expect music either.
;   * Sprites are loaded once at entry. AnimTest_DrawHeader only
;     redraws the bottom text rows so the sprites survive across
;     animation iterations. Func_78e98 (the cleanup that runs after
;     each MoveAnimation predef) saves/restores the tilemap so the
;     sprites' tile IDs in wTileMap are preserved too.

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

	; --- Setup screen + battle UI tiles ---
	call ClearScreen
	call ClearSprites
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns

	; --- Load enemy front sprite (Rattata) into vFrontPic + tilemap ---
	ld a, RATTATA
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

	; --- Load player back sprite (Pikachu) into vBackPic + tilemap ---
	ld a, PIKACHU
	ld [wcf91], a
	ld [wBattleMonSpecies], a
	ld [wBattleMonSpecies2], a
	call GetMonHeader
	callfar LoadMonBackPic ; v0.7 fix: LoadMonBackPic lives in bank $3D
	                       ; ("Battle Engine 9"); we are in bank $3F
	                       ; ("Overworld Pikachu"). Plain `call` would
	                       ; jump to whatever's at that offset in $3F
	                       ; and freeze/crash.
	ld a, $31
	ldh [hStartTileID], a
	hlcoord 1, 5
	predef CopyUncompressedPicToTilemap

	; --- Set CGB battle palette (greys) ---
	; pokeyellow is a CGB game; rBGP/rOBP* DMG regs are mostly ignored.
	; The proper way to set a battle-context palette is via the high-level
	; RunPaletteCommand, which sets up the CGB palette banks for both the
	; mon sprites and the UI text. Without this, tiles render with the
	; previous context's CGB palette (e.g. yellow/red title-screen).
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand

	; Animation context: player attacks, no post-anim screen effect,
	; clean any leftover sub-anim state from a prior battle.
	xor a
	ldh [hWhoseTurn], a
	ld [wAnimationType], a
	ld [wAnimSoundID], a
	ld [wSubAnimSubEntryAddr], a
	ld [wSubAnimTransform], a

	; Start at move ID 1 (the first slot in move_constants.asm).
	ld a, 1
	ld [wWhichPokemon], a    ; reused as current animation move ID

.redrawHeader
	call AnimTest_DrawHeader

.playAnim
	ld a, [wWhichPokemon]
	ld [wAnimationID], a
	predef MoveAnimation
	callfar Func_78e98

	; Func_78e98 captured the post-animation tilemap into buffer2 and
	; replayed it — so the sprite tilemap entries survive but the bottom
	; text rows may have been clobbered by the animation. Redraw them.
	call AnimTest_DrawHeader

	; Inter-loop pause, ~120 frames (~2s) at 60Hz, polling input.
	ld c, 120
.pauseFrame
	push bc
	call DelayFrame
	call JoypadLowSensitivity
	pop bc
	ldh a, [hJoy5]
	bit BIT_B_BUTTON, a
	jp nz, .exit
	bit BIT_D_LEFT, a
	jr nz, .prev
	bit BIT_D_RIGHT, a
	jr nz, .next
	bit BIT_A_BUTTON, a
	jp nz, .playAnim         ; replay immediately
	dec c
	jr nz, .pauseFrame
	jp .playAnim             ; auto-replay after pause

.next
	ld a, [wWhichPokemon]
	inc a
	cp NUM_ATTACKS + 1
	jr c, .storeMove
	ld a, 1                  ; wrap from NUM_ATTACKS back to 1
	jr .storeMove
.prev
	ld a, [wWhichPokemon]
	dec a
	jr nz, .storeMove
	ld a, NUM_ATTACKS        ; wrap from 1 back to NUM_ATTACKS
.storeMove
	ld [wWhichPokemon], a
	jp .redrawHeader

.exit
	jp DebugMenu


AnimTest_DrawHeader:
	; Clear ONLY the bottom text rows (rows 12-17) so the sprites survive.
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
	db "A:REPLAY  B:EXIT@"

ELSE
	ret
ENDC
