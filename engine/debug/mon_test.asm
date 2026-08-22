; MON TEST — debug screen for browsing all 151 species (v0.7).
;
; Sibling of ANIM TEST, reached the same way: SELECT on the title screen ->
; DebugMenu -> MON. Shows each species' front sprite in its real gameplay
; colours, its dex number, name and types, and plays its cry.
;
; It exists because the dev cannot playtest right now, so this is the only way
; to check sprites and cries by hand (the same reason ANIM TEST exists for move
; animations). It also covers two playtest-checklist items directly: hearing the
; reworked Rhyhorn/Ditto/Muk cries, and eyeing the sprites the dex review touched.
;
; Controls (as specified by Forte):
;   LEFT / RIGHT  previous / next species (wraps)
;   UP / DOWN     -10 / +10 (clamps at the ends)
;   A             replay the cry
;   B             back to the debug menu
;
; Implementation notes — each of these was a trap found while researching:
;  * The browse cursor is a DEX number (1..151), converted per step with
;    PokedexToIndex. That routine has NO bounds check (it scans PokedexOrder
;    until it matches), so the clamp/wrap below must be airtight. Browsing raw
;    internal indices instead would walk the ~39 MissingNo. holes.
;  * BOTH wd0b5 (GetMonHeader / PrintMonType) and wcf91 (pic ROM bank +
;    palette) must hold the internal index. Setting only one gives the wrong
;    sprite or a crash — that was a real shipped bug once (commit c38fe87).
;  * The pic MUST be drawn at hlcoord 1, 1: SET_PAL_POKEDEX only assigns the
;    mon palette to columns 1-8 / rows 1-8. Anywhere else and the sprite comes
;    out in the background palette.
;  * RunPaletteCommand must run BEFORE GBPalNormal, and only AFTER wcf91 holds
;    this species — ANIM TEST gets that order wrong, which is why its mon shows
;    up in stale greys. Do not copy it.
;  * SET_PAL_BATTLE is NOT usable here: SetPal_Battle dereferences wPartyMon1 +
;    wPlayerMonNumber, which are uninitialised garbage on a from-title screen.
;  * The cry is started with GetCryData + PlaySound rather than PlayCry, because
;    PlayCry ends in WaitForSoundToFinish — a busy loop with no DelayFrame, so
;    d-pad presses during a cry would be swallowed while browsing quickly.

MonTestMenu::
IF DEF(_DEBUG)
	; --- Silence the title-screen music so the cries are audible ---
	xor a                         ; instant fade-out (0 frames)
	ld [wAudioFadeOutControl], a
	call StopAllMusic
.waitMusicStop
	ld a, [wAudioFadeOutControl]
	and a
	jr nz, .waitMusicStop
	call StopAllSounds

	call ClearSprites
	call LoadFontTilePatterns

	ld a, 1                       ; start at dex #001
	ld [wWhichPokemon], a

.showMon
	call MonTest_Draw
	call MonTest_StartCry
.inputLoop
	call DelayFrame
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	bit BIT_B_BUTTON, a
	jp nz, .exit
	bit BIT_A_BUTTON, a
	jr nz, .replayCry
; UP/DOWN step one, LEFT/RIGHT jump ten -- the same hand as ANIM TEST's list
; (2026-08-21, Forte). Both screens are browsed the same way on purpose.
	bit BIT_D_UP, a
	jr nz, .prev
	bit BIT_D_DOWN, a
	jr nz, .next
	bit BIT_D_LEFT, a
	jr nz, .back10
	bit BIT_D_RIGHT, a
	jr nz, .forward10
	jr .inputLoop

.replayCry
	call MonTest_StartCry
	jr .inputLoop

.prev
	ld a, [wWhichPokemon]
	dec a
	jr nz, .store
	ld a, NUM_POKEMON             ; wrap #001 -> #151
	jr .store
.next
	ld a, [wWhichPokemon]
	inc a
	cp NUM_POKEMON + 1
	jr c, .store
	ld a, 1                       ; wrap #151 -> #001
	jr .store
.back10
	ld a, [wWhichPokemon]
	sub 10
	jr c, .clampLow               ; borrowed past #001
	and a
	jr nz, .store                 ; landed on 0 exactly
.clampLow
	ld a, 1
	jr .store
.forward10
	ld a, [wWhichPokemon]
	add 10
	jr c, .clampHigh              ; 8-bit overflow
	cp NUM_POKEMON + 1
	jr c, .store
.clampHigh
	ld a, NUM_POKEMON
.store
	ld [wWhichPokemon], a
	jp .showMon

.exit
	call StopAllSounds
	jp DebugMenu

; ---------------------------------------------------------------
; Draw the whole screen for the species in wWhichPokemon (a dex number)
; ---------------------------------------------------------------
MonTest_Draw:
	call MonTest_LatchSpecies      ; wd11e/wd0b5/wcf91 = internal index
	call GetMonName                ; name -> wcd6d (reads wd11e)
	call GetMonHeader              ; sprite dims + pic pointers (reads wd0b5)

	xor a                          ; no visible half-drawn frame
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen

	hlcoord 1, 1                   ; MUST be 1,1 — see the palette note above
	call LoadFrontSpriteByMonIndex

	hlcoord 1, 0
	ld de, MonTestTitleText
	call PlaceString

	hlcoord 10, 1                  ; "No" + zero-padded dex number
	ld de, MonTestNoText
	call PlaceString
	hlcoord 12, 1
	ld de, wWhichPokemon
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber

	hlcoord 10, 3                  ; species name (GetMonName left it at wcd6d)
	ld de, wcd6d
	call PlaceString

	hlcoord 10, 5                  ; TYPE1 here, TYPE2 two rows down.
	predef PrintMonType            ; single-type mons blank 6 tiles on row 6,
	                               ; which this layout deliberately leaves empty.
	hlcoord 1, 10
	ld de, MonTestHint1Text
	call PlaceString
	hlcoord 1, 12
	ld de, MonTestHint2Text
	call PlaceString
	hlcoord 1, 14
	ld de, MonTestHint3Text
	call PlaceString

	ld b, SET_PAL_POKEDEX          ; reads wcf91; must precede GBPalNormal
	call RunPaletteCommand
	call GBPalNormal

	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

; Converts the dex number in wWhichPokemon to the internal index and leaves it
; in all three places the sprite/name/type/cry code reads it from.
MonTest_LatchSpecies:
	ld a, [wWhichPokemon]
	ld [wd11e], a
	callfar PokedexToIndex         ; lives in ROMX $10, so it needs a farcall
	ld a, [wd11e]
	ld [wd0b5], a
	ld [wcf91], a
	ret

; Starts the cry without blocking (see the note about PlayCry above).
MonTest_StartCry:
	ld a, [wd0b5]                  ; internal index
	call GetCryData                ; -> song id in a, sets freq/tempo modifiers
	jp PlaySound

MonTestTitleText:
	db "MON TEST@"
MonTestNoText:
	db "No@"
; Plain letters on purpose: the charmap has no left-arrow glyph (only "▲"/"▶"
; = $ed and "▼" = $ee), so an arrow pair would have emitted a garbage tile.
MonTestHint1Text:
	db "U/D PREV NEXT@"
MonTestHint2Text:
	db "L/R JUMP 10@"
MonTestHint3Text:
	db "A:CRY  B:BACK@" ; ":" not "=" — the charmap has no equals sign

ELSE
	ret
ENDC
