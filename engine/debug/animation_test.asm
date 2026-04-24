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
; Limitations / known artifacts:
;   * No Pokémon sprites are loaded into VRAM. Animations that *overlay*
;     the screen (most of them — Thunderbolt, Fire Blast, Solar Beam,
;     particles, etc.) display correctly. Animations that animate the
;     mon sprites themselves (Tackle, Body Slam, sprite slides) will
;     animate blank/garbage tiles. For full-fidelity review of those
;     specific moves, use the real battle (debug FIGHT mode).
;   * Input is only sampled during the inter-loop pause, not during
;     animation playback. Worst-case responsiveness for a long animation
;     (Hyper Beam, Solar Beam) is ~3s before a d-pad press takes effect.
;     Acceptable trade-off for keeping the implementation simple.
;
; Implementation notes:
;   * wWhichPokemon is reused as the current move ID storage. It's
;     scratch in this debug context; the next thing to read it (a real
;     battle/menu) re-initialises it.
;   * Animations require a few wBattle/wAnim* WRAM bytes set sanely
;     before the predef call. We zero what matters and leave the rest.
;   * After each play, Func_78e98 restores the screen tiles from a
;     buffer it captures *after* the animation runs — meaning our
;     header text gets clobbered. We just redraw it explicitly each
;     iteration (cheap; ~1 frame of work).

AnimationTestMenu::
IF DEF(_DEBUG)
	; --- Setup screen + palettes + battle context ---
	call ClearScreen
	call ClearSprites
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns

	; Standard 4-greys palette
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	call UpdateGBCPal_BGP
	call UpdateGBCPal_OBP0
	call UpdateGBCPal_OBP1

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
	; replayed it — meaning our header is gone. Redraw it before pause.
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
	call ClearScreen

	hlcoord 3, 1
	ld de, .titleText
	call PlaceString

	hlcoord 1, 4
	ld de, .moveLabel
	call PlaceString

	; Move ID, 3 digits with leading zeros
	hlcoord 6, 4
	ld a, [wWhichPokemon]
	ld [wd11e], a
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber

	; Move name (GetMoveName returns de = wcd6d)
	hlcoord 10, 4
	ld a, [wWhichPokemon]
	ld [wd11e], a
	push hl
	call GetMoveName
	pop hl
	call PlaceString

	; Footer hints
	hlcoord 1, 14
	ld de, .footer1
	call PlaceString
	hlcoord 1, 16
	ld de, .footer2
	call PlaceString
	ret

.titleText
	db "ANIMATION TEST@"
.moveLabel
	db "MOVE@"
.footer1
	db "L/R: PREV/NEXT@"
.footer2
	db "A:REPLAY  B:EXIT@"

ELSE
	ret
ENDC
