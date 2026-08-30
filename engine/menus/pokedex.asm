ShowPokedexMenu:
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wLastMenuItem], a
	inc a
	ld [wd11e], a
	ldh [hJoy7], a
.setUpGraphics
	callfar LoadPokedexTilePatterns
.loop
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
.doPokemonListMenu
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	xor a
	ld [hli], a ; top menu item X
	inc a
	ld [wMenuWatchMovingOutOfBounds], a
	inc hl
	inc hl
	ld a, 6
	ld [hli], a ; max menu item ID
	; v0.7: START is watched here so it can open the MOVEDEX -- the same
	; button that opens a move's card from the FIGHT menu.
	ld [hl], D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON | START
	call HandlePokedexListMenu
	jr c, .goToSideMenu ; if the player chose a pokemon from the list
	ld a, b ; b = 1 when the list wants the MOVEDEX (see .startPressed)
	and a
	jr nz, .goToMovedex
.exitPokedex
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ldh [hJoy7], a
	ld [wUnusedCD3A], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	pop af
	ld [wListScrollOffset], a
	call GBPalWhiteOutWithDelay3
	call RunDefaultPaletteCommand
	jp ReloadMapData

.goToSideMenu
	call HandlePokedexSideMenu
	dec b
	jr z, .exitPokedex ; if the player chose Quit
	dec b
	jr z, .doPokemonListMenu ; if pokemon not seen or player pressed B button
	dec b
	jr z, .loop
	jp .setUpGraphics ; if pokemon data or area was shown

.goToMovedex
	farcall ShowMovedexMenu
; the movedex's .done already cleared the screen (in WRAM, transfer off) and
; restored the dex tile patterns, so reloading them via .setUpGraphics only
; lengthened the white handover (2026-08-30). Straight back to the list.
	jp .loop

; handles the menu on the lower right in the pokedex screen
; OUTPUT:
; b = reason for exiting menu
; 00: showed pokemon data or area
; 01: the player chose Quit
; 02: the pokemon has not been seen yet or the player pressed the B button
HandlePokedexSideMenu:
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	push af
	ld b, a
	ld a, [wLastMenuItem]
	push af
	ld a, [wListScrollOffset]
	push af
	add b
	inc a
	ld [wd11e], a
	ld a, [wd11e]
	push af
	ld a, [wDexMaxSeenMon]
	push af ; this doesn't need to be preserved
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	ld b, 2
	jr z, .exitSideMenu
	call PokedexToIndex
	ld hl, wTopMenuItemY
	ld a, 8
	ld [hli], a ; top menu item Y
	ld a, 15
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 4 ; DATA, CRY, AREA, EVO, MOVE -- v0.7 dropped QUIT, #24 added EVO
	ld [hli], a ; max menu item ID
	ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; menu watched keys (A button and B button)
	xor a
	ld [hli], a ; old menu item ID
	ld [wMenuWatchMovingOutOfBounds], a
	ldh [hJoy7], a
.handleMenuInput
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	ld b, 2
	jr nz, .buttonBPressed
	ld a, [wCurrentMenuItem]
	and a
	jr z, .choseData
	dec a
	jr z, .choseCry
	dec a
	jr z, .choseArea
	dec a
	jr z, .choseEvo
	dec a
	jr z, .choseMoves
; Unreachable since QUIT left the menu: wMaxMenuItem is 3 and all four items are
; dispatched above. Kept as a landing pad, and it now behaves like B (back to
; the list) rather than slamming the whole POKéDEX shut, which is the safer of
; the two if a future edit ever lets the cursor out of range.
.choseQuit
	ld b, 2
.exitSideMenu
	pop af
	ld [wDexMaxSeenMon], a
	pop af
	ld [wd11e], a
	pop af
	ld [wListScrollOffset], a
	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	ld a, $1
	ldh [hJoy7], a
	push bc
	hlcoord 0, 3
	ld de, 20
	lb bc, " ", 13
	call DrawTileLine ; cover up the menu cursor in the pokemon list
	pop bc
	ret

.buttonBPressed
	push bc
	hlcoord 15, 8
	ld de, 20
	lb bc, " ", 9
	call DrawTileLine ; cover up the menu cursor in the side menu
	pop bc
	jr .exitSideMenu

.choseData
	ld a, 0
	ld [wMoveListCounter], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

; play pokemon cry
.choseCry
	ld a, [wd11e]
	call GetCryData
	call PlaySound
	jr .handleMenuInput

.choseArea
	predef LoadTownMap_Nest ; display pokemon areas
	ld b, 0
	jr .exitSideMenu

; The EVO side-menu item (#24). b = 0 on the way out like DATA and MOVE, so the
; caller reloads the dex tile patterns and redraws the list.
.choseEvo
	ld a, 2
	ld [wMoveListCounter], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

; The MOVE side-menu item. It took over the slot the Game Boy Printer's PRINT
; used to occupy; v0.7 removed the printer outright, so nothing is repurposed
; here any more.
.choseMoves
	ld a, 1
	ld [wMoveListCounter], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

; handles the list of pokemon on the left of the pokedex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandlePokedexListMenu:
	call Pokedex_DrawInterface
.loop
	call Pokedex_PlacePokemonList
	call GBPalNormal
	call HandleMenuInput
	bit BIT_B_BUTTON, a ; was the B button pressed?
	jp nz, .buttonBPressed
	bit BIT_A_BUTTON, a ; was the A button pressed?
	jp nz, .buttonAPressed
	bit BIT_START, a ; v0.7: hand over to the MOVEDEX
	jp nz, .startPressed
.checkIfUpPressed
	bit BIT_D_UP, a ; was Up pressed?
	jr z, .checkIfDownPressed
.upPressed ; scroll up one row
	ld a, [wListScrollOffset]
	and a
	jp z, .wrapToBottom ; already at the very top: wrap to the bottom
	dec a
	ld [wListScrollOffset], a
	jp .loop

.checkIfDownPressed
	bit BIT_D_DOWN, a ; was Down pressed?
	jr z, .checkIfRightPressed
.downPressed ; scroll down one row
	ld a, [wDexMaxSeenMon]
	cp 7
	jp c, .wrapToTop ; whole list fits and we're at the bottom: wrap up
	sub 7
	ld b, a
	ld a, [wListScrollOffset]
	cp b
	jp z, .wrapToTop ; at the last scroll position: wrap to the top
	inc a
	ld [wListScrollOffset], a
	jp .loop

.checkIfRightPressed
	bit BIT_D_RIGHT, a ; was Right pressed?
	jr z, .checkIfLeftPressed
.rightPressed ; scroll down 7 rows
	ld a, [wDexMaxSeenMon]
	cp 7
	jp c, .loop ; can't if the list is shorter than 7
	sub 6
	ld b, a
	ld a, [wListScrollOffset]
	add 7
	ld [wListScrollOffset], a
	cp b
	jp c, .loop
	dec b
	ld a, b
	ld [wListScrollOffset], a
	jp .loop

.checkIfLeftPressed ; scroll up 7 rows
	bit BIT_D_LEFT, a ; was Left pressed?
	jr z, .buttonAPressed
.leftPressed
	ld a, [wListScrollOffset]
	sub 7
	ld [wListScrollOffset], a
	jp nc, .loop
	xor a
	ld [wListScrollOffset], a
	jp .loop

.wrapToBottom
	; QoL wrap: from the top of the dex list, jump to the very last entry.
	ld a, [wDexMaxSeenMon]
	and a
	jp z, .loop ; empty list guard: nothing to wrap to
	cp 7
	jr c, .wrapBottomFits
	sub 7 ; long list: scroll so the last 7 rows show...
	ld [wListScrollOffset], a
	ld a, 6 ; ...and put the cursor on the bottom row
	ld [wCurrentMenuItem], a
	jp .loop
.wrapBottomFits
	xor a ; short list (< 7): no scroll...
	ld [wListScrollOffset], a
	ld a, [wDexMaxSeenMon]
	dec a ; ...cursor on the last seen entry
	ld [wCurrentMenuItem], a
	jp .loop
.wrapToTop
	; QoL wrap: from the bottom of the dex list, jump back to the top.
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	jp .loop

.buttonAPressed
	scf
	ret

.buttonBPressed
	ld b, 0
	and a
	ret

.startPressed
; Reported in b rather than acted on here: this routine's caller owns the
; screen, and its carry already means "a Pokemon was chosen". b costs nothing,
; and WRAM has no byte to spare -- it is full at 8192/8192.
	ld b, 1
	and a ; clear carry: no Pokemon was chosen
	ret

Pokedex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
; draw the horizontal line separating the seen and owned amounts from the menu
	hlcoord 15, 6
	ld a, "─"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	hlcoord 14, 0
	ld [hl], $71 ; vertical line tile
	hlcoord 14, 1
	call DrawPokedexVerticalLine
	hlcoord 14, 9
	call DrawPokedexVerticalLine
	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 2
	lb bc, 1, 3
	call PrintNumber ; print number of seen pokemon
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 5
	lb bc, 1, 3
	call PrintNumber ; print number of owned pokemon
	hlcoord 16, 1
	ld de, PokedexSeenText
	call PlaceString
	hlcoord 16, 4
	ld de, PokedexOwnText
	call PlaceString
	hlcoord 1, 1
	ld de, PokedexContentsText
	call PlaceString
	hlcoord 16, 8
	ld de, PokedexMenuItemsText
	call PlaceString
; find the highest pokedex number among the pokemon the player has seen
	ld hl, wPokedexSeenEnd - 1
	ld b, (wPokedexSeenEnd - wPokedexSeen) * 8 + 1
.maxSeenPokemonLoop
	ld a, [hld]
	ld c, 8
.maxSeenPokemonInnerLoop
	dec b
	sla a
	jr c, .storeMaxSeenPokemon
	dec c
	jr nz, .maxSeenPokemonInnerLoop
	jr .maxSeenPokemonLoop

.storeMaxSeenPokemon
	ld a, b
	ld [wDexMaxSeenMon], a
	ret

DrawPokedexVerticalLine:
	ld c, 9 ; height of line
	ld de, SCREEN_WIDTH ; width of screen
	ld a, $71 ; vertical line tile
.loop
	ld [hl], a
	add hl, de
	xor 1 ; toggle between vertical line tile and box tile
	dec c
	jr nz, .loop
	ret

PokedexSeenText:
	db "SEEN@"

PokedexOwnText:
	db "OWN@"

; v0.7: was "CONTENTS". The MOVEDEX next door heads its list "MOVES:", and this
; one names itself the same way. ("#" is the POKé control code.)
PokedexContentsText:
	db "#DEX:@"

; v0.7: QUIT is gone. It only ever appeared once you had already opened a
; Pokémon's side menu, so it never quit the POKéDEX -- it quit the side menu,
; which is what B does from anywhere including the list itself. A menu entry
; that duplicates B and names itself after something it does not do is worse
; than no entry.
; #24: EVO sits between AREA and MOVE, which puts it on row 16 - the last row
; the panel has. A sixth entry would need row 18 and there isn't one.
; The cursor erase on the B path (lb bc, " ", 9 above) wants 2 * wMaxMenuItem + 1
; and already said 9: it was left over from when this menu had five entries,
; PRNT and QUIT among them. It is exactly right again now. Do not tidy it.
PokedexMenuItemsText:
	db   "DATA"
	next "CRY"
	next "AREA"
	next "EVO"
	next "MOVE@"

Pokedex_PlacePokemonList:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 2
	lb bc, 14, 10
	call ClearScreenArea
	hlcoord 1, 3
	ld a, [wListScrollOffset]
	ld [wd11e], a
	ld d, 7
	ld a, [wDexMaxSeenMon]
	cp 7
	jr nc, .printPokemonLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a
; loop to print pokemon pokedex numbers and names
; if the player has owned the pokemon, it puts a pokeball beside the name
.printPokemonLoop
	ld a, [wd11e]
	inc a
	ld [wd11e], a
	push af
	push de
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; print the pokedex number
	ld de, SCREEN_WIDTH
	add hl, de
	dec hl
	push hl
	ld hl, wPokedexOwned
	call IsPokemonBitSet
	pop hl
	ld a, " "
	jr z, .writeTile
	ld a, $72 ; pokeball tile
.writeTile
	ld [hl], a ; put a pokeball next to pokemon that the player has owned
	push hl
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	jr nz, .getPokemonName ; if the player has seen the pokemon
	ld de, .dashedLine ; print a dashed line in place of the name if the player hasn't seen the pokemon
	jr .skipGettingName
.dashedLine ; for unseen pokemon in the list
	db "----------@"
.getPokemonName
	call PokedexToIndex
	call GetMonName
.skipGettingName
	pop hl
	inc hl
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	pop af
	ld [wd11e], a
	dec d
	jr nz, .printPokemonLoop
	ld a, 01
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

; tests if a pokemon's bit is set in the seen or owned pokemon bit fields
; INPUT:
; [wd11e] = pokedex number
; hl = address of bit field
IsPokemonBitSet:
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret

; function to display pokedex data from outside the pokedex
ShowPokedexData:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	callfar LoadPokedexTilePatterns ; load pokedex tiles

; function to display pokedex data from inside the pokedex
ShowPokedexDataInternal:
	ld hl, wd72c
	set 1, [hl]
	ld a, $33 ; 3/7 volume
	ldh [rNR50], a
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	call GBPalWhiteOut ; zero all palettes
	ld a, [wd11e] ; pokemon ID
	ld [wcf91], a
	push af
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	ld a, [wMoveListCounter] ; using this as a temp variable
	cp 1
	jr z, .PrintMoves
	cp 2
	jr z, .PrintEvolutions
	pop af
	ld [wd11e], a
	call DrawDexEntryOnScreen
; v0.7: DATA opens on the typing and the base stats, and the description
; follows it. Carry clear means the mon has only been SEEN, and then the whole
; area below the divider stays empty exactly as before - no height, no weight,
; no description, and now no stats either. Forte's call: you have to have
; caught it.
	jr nc, .waitForButtonPress
	push hl ; DrawDexEntryOnScreen leaves the description pointer here, and
	        ; everything below walks all over hl
	call Pokedex_PrintBaseStats
	call NewPageButtonPressCheck
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea ; the same rectangle the move pages turn over
	pop hl
	call Pokedex_PrintFlavorTextAtRow11
	jr .waitForButtonPress
.PrintEvolutions
	pop af
	ld [wd11e], a
	call DrawDexEntryOnScreen
	call c, Pokedex_PrintEvolutions ; carry clear = only SEEN, and then nothing
	                                ; goes below the divider, same as DATA
	jr .waitForButtonPress
.PrintMoves
	pop af
	ld [wd11e], a
	call DrawDexEntryOnScreen
	call c, Pokedex_PrintMovesText
.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress
	pop af
	ldh [hTileAnimations], a
	call GBPalWhiteOut
	call ClearScreen
	call RunDefaultPaletteCommand
	call LoadTextBoxTilePatterns
	call GBPalNormal
	ld hl, wd72c
	res 1, [hl]
	ld a, $77 ; max volume
	ldh [rNR50], a
	ret

HeightWeightText:
; v0.7 metric dex: height shown as M.D m, weight as ???.? kg
	db   "HT   ?<DOT>?m"
	next "WT   ???kg@"

; XXX does anything point to this?
PokeText:
	db "#@"

; horizontal line that divides the pokedex text description from the rest of the data
PokedexDataDividerLine:
	db $68, $69, $6B, $69, $6B, $69, $6B, $69, $6B, $6B
	db $6B, $6B, $69, $6B, $69, $6B, $69, $6B, $69, $6A
	db "@"

DrawDexEntryOnScreen:
	call ClearScreen

	hlcoord 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLine ; draw top border

	hlcoord 0, 17
	ld b, $6f
	call DrawTileLine ; draw bottom border

	hlcoord 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLine ; draw left border

	hlcoord 19, 1
	ld b, $67
	call DrawTileLine ; draw right border

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 9
	ld de, PokedexDataDividerLine
	call PlaceString ; draw horizontal divider line

	hlcoord 9, 6
	ld de, HeightWeightText
	call PlaceString

	call GetMonName
	hlcoord 9, 2
	call PlaceString

	ld hl, PokedexEntryPointers
	ld a, [wd11e]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl] ; de = address of pokedex entry

	hlcoord 9, 4
	call PlaceString ; print species name

	ld h, b
	ld l, c
	push de
	ld a, [wd11e]
	push af
	call IndexToPokedex

	hlcoord 2, 8
	ld a, "№"
	ld [hli], a
	ld a, "<DOT>"
	ld [hli], a
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; print pokedex number

	ld hl, wPokedexOwned
	call IsPokemonBitSet
	pop af
	ld [wd11e], a
	ld a, [wcf91]
	ld [wd0b5], a
	pop de

	push af
	push bc
	push de
	push hl

	call Delay3
	call GBPalNormal
	call GetMonHeader ; load pokemon picture location
	hlcoord 1, 1
	call LoadFlippedFrontSpriteByMonIndex ; draw pokemon picture
	ld a, [wcf91]
	call PlayCry ; play pokemon cry

	pop hl
	pop de
	pop bc
	pop af

	ld a, c
	and a
	ret z ; if the pokemon has not been owned, don't print the height, weight, or description

; v0.7 metric dex: the two height bytes store meters, decimeters.
; Both are single digits written directly to the tilemap — PrintNumber
; only supports 2-7 digits (its 1-digit call falls through to a 7-tile
; field; see home/print_num.asm).
	inc de ; de = address of meters (height)
	ld a, [de]
	add "0"
	hlcoord 14, 6
	ld [hl], a ; whole meters (the template supplies the dot)
	inc de ; de = address of decimeters (height)
	ld a, [de]
	add "0"
	hlcoord 16, 6
	ld [hl], a ; decimeters (the template supplies the "m")
; now print the weight (stored in tenths of KILOGRAMS since v0.7)
	inc de
	inc de ; de = address of upper byte of weight (PrintNumber used to
	       ; leave de one byte behind; direct writes do not, hence one
	       ; fewer inc than the vanilla ft/in flow)
	push de
; put weight in big-endian order at hDexWeight
	ld hl, hDexWeight
	ld a, [hl] ; save existing value of [hDexWeight]
	push af
	ld a, [de] ; a = upper byte of weight
	ld [hli], a ; store upper byte of weight in [hDexWeight]
	ld a, [hl] ; save existing value of [hDexWeight + 1]
	push af
	dec de
	ld a, [de] ; a = lower byte of weight
	ld [hl], a ; store lower byte of weight in [hDexWeight + 1]
	ld de, hDexWeight
	hlcoord 11, 8
	lb bc, 2, 5 ; 2 bytes, 5 digits
	call PrintNumber ; print weight
	hlcoord 14, 8
	ldh a, [hDexWeight + 1]
	sub 10
	ldh a, [hDexWeight]
	sbc 0
	jr nc, .next
	ld [hl], "0" ; if the weight is less than 10, put a 0 before the decimal point
.next
	inc hl
	ld a, [hli]
	ld [hld], a ; make space for the decimal point by moving the last digit forward one tile
	ld [hl], "<DOT>" ; decimal point tile
	pop af
	ldh [hDexWeight + 1], a ; restore original value of [hDexWeight + 1]
	pop af
	ldh [hDexWeight], a ; restore original value of [hDexWeight]
	pop hl
	inc hl ; hl = address of pokedex description text
	scf
	ret

Pokedex_PrintMovesText:
	ld a, [wd11e]
	ld [wWhichPokemon], a
	ld [wcf91], a

	farcall PrepareLevelUpMoveList
	ld de, wRelearnableMoves

	ld b, 0 ; counter

	ld a, [wMoveListCounter]
	cp 0
	jp z, .done

.PrintLevelUpMovesLoop
	push de
	push bc
	ld de, LevelUpMovesText
	hlcoord 1, 11
	call PlaceString
	pop bc
	pop de

	push bc
	ld a, [de]
	hlcoord 1, 12
	lb bc, 1, 3
	call PrintNumber ; print the move's learn level
	inc de
	inc de
	ld a, [de]
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 5, 12
	call PlaceString
	pop de
	pop bc

	inc b
	ld a, [wMoveListCounter]
	cp b
	jp z, .done

	push bc
	inc de
	ld a, [de]
	hlcoord 1, 13
	lb bc, 1, 3
	call PrintNumber ; print the move's learn level
	inc de
	inc de
	ld a, [de]
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 5, 13
	call PlaceString
	pop de
	pop bc

	inc b
	ld a, [wMoveListCounter]
	cp b
	jp z, .done

	push bc
	inc de
	ld a, [de]
	hlcoord 1, 14
	lb bc, 1, 3
	call PrintNumber ; print the move's learn level
	inc de
	inc de
	ld a, [de]
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 5, 14
	call PlaceString
	pop de
	pop bc

	inc b
	ld a, [wMoveListCounter]
	cp b
	jr z, .done

	push bc
	inc de
	ld a, [de]
	hlcoord 1, 15
	lb bc, 1, 3
	call PrintNumber ; print the move's learn level
	inc de
	inc de
	ld a, [de]
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 5, 15
	call PlaceString
	pop de
	pop bc

	inc b
	ld a, [wMoveListCounter]
	cp b
	jr z, .done

	push bc
	inc de
	ld a, [de]
	hlcoord 1, 16
	lb bc, 1, 3
	call PrintNumber ; print the move's learn level
	inc de
	inc de
	ld a, [de]
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 5, 16
	call PlaceString
	pop de
	pop bc

	inc b
	ld a, [wMoveListCounter]
	cp b
	jr z, .done

	inc de

	push de
	push bc
	call NewPageButtonPressCheck
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	pop bc
	pop de
	jp .PrintLevelUpMovesLoop
.done
	call NewPageButtonPressCheck
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea

.tmMoveset
	farcall GetTMMoves
	ld de, wRelearnableMoves
	ld a, [de]

.PrintTMMovesLoop
	push de
	ld de, TMHMMovesText
	hlcoord 1, 11
	call PlaceString
	pop de

	ld a, [de]
	cp 0
	jp z, .done2
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 2, 12
	call PlaceString
	pop de

	inc de
	ld a, [de]
	cp 0
	jp z, .done2
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 2, 13
	call PlaceString
	pop de

	inc de
	ld a, [de]
	cp 0
	jp z, .done2
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 2, 14
	call PlaceString
	pop de

	inc de
	ld a, [de]
	cp 0
	jp z, .done2
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 2, 15
	call PlaceString
	pop de

	inc de
	ld a, [de]
	cp 0
	jp z, .done2
	push de
	ld [wd11e], a
	call GetMoveName
	hlcoord 2, 16
	call PlaceString
	pop de

	inc de
	ld a, [de]
	cp 0
	jp z, .done2

	; wait for button press
	push de
	call NewPageButtonPressCheck

	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	pop de
	jp .PrintTMMovesLoop
.done2
	ret

NewPageButtonPressCheck::
.waitForButtonPressLetGo
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr nz, .waitForButtonPressLetGo
.waitForButtonPress
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress
	ret

LevelUpMovesText:
	db   "LEVEL UP MOVES:@"

TMHMMovesText:
	db   "TM/HM MOVES:@"

Pokedex_PrintEvolutions:
; #24. The mon's evolution family, in the seven rows under the divider that
; DrawDexEntryOnScreen already put on row 9, vertically centred, with the one
; whose entry this is marked:
;
;   row11 | CATERPIE
;   row12 |   LEVEL  8
;   row13 |▶METAPOD
;   row14 |   LEVEL 11
;   row15 | BUTTERFREE
;
; The walking is not here. PrepareEvolutionList (engine/pokemon/evos_moves.asm,
; in the bank the data lives in) has already flattened the family into
; wRelearnableMoves as a root species byte, then a (method, parameter, target)
; triple per step, then 0. Everything below is layout - which is the only way
; this fits, bank $10 being what it is.
	ld a, [wd11e]
	ld [wWhichPokemon], a
	farcall PrepareEvolutionList

; One line for the root, two for every step after it.
	ld hl, wRelearnableMoves + 1
	ld c, 1
.countLoop
	ld a, [hl]
	and a
	jr z, .counted
	inc hl
	inc hl
	inc hl
	inc c
	inc c
	jr .countLoop
.counted
	ld a, c
	cp 1
	jr z, .doesNotEvolve

; Centre the block in rows 10-16: the first line is 10 + (7 - lines) / 2.
	ld a, 7
	sub c
	srl a
	push af
	hlcoord 1, 10
	ld bc, SCREEN_WIDTH
	pop af
	call AddNTimes

	ld de, wRelearnableMoves
.familyLoop
	ld a, [de] ; a species
	inc de
	push de
	push hl
	call Pokedex_PlaceEvoSpecies
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop de
	ld a, [de] ; the method that leads to the next one, or the terminator
	and a
	ret z
	inc de ; de -> the parameter
	push hl
	push de
	call Pokedex_PlaceEvoMethod
	pop de
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc de ; past the parameter, so de -> the target species
	jr .familyLoop

.doesNotEvolve
; 85 of the 155 species land here, so it is not an edge case - it is the most
; common page this menu entry draws.
	hlcoord 2, 13
	ld de, PokedexNoEvolutionText
	jp PlaceString

Pokedex_PlaceEvoSpecies:
; in: a = species internal index, hl = the row's column 1
; The marker goes in column 1 and the name in column 2, so a ten-letter name
; still ends at column 11 with room to spare.
	ld [wd11e], a
	ld b, a
	ld a, [wcf91] ; the mon whose POKeDEX entry this is - DrawDexEntryOnScreen
	              ; does not touch wcf91, so it is still the right one here
	cp b
	ld a, " "
	jr nz, .notThisOne
	ld a, "▶"
.notThisOne
	ld [hli], a
	call GetMonName
	jp PlaceString

Pokedex_PlaceEvoMethod:
; in: a = EVOLVE_*, de -> the parameter byte, hl = the row's column 1
	ld bc, 3
	add hl, bc ; column 4, indented under the species above it
	cp EVOLVE_ITEM
	jr z, .item
	cp EVOLVE_TRADE
	jr z, .trade
; A level. PlaceString hands back the screen address just past the text in bc,
; so the number goes straight after it with no coordinate arithmetic.
	push de
	ld de, PokedexEvoLevelText
	call PlaceString
	ld h, b
	ld l, c
	pop de ; -> the level byte
	lb bc, 1, 2
	jp PrintNumber
.item
	ld a, [de]
	ld [wd11e], a
	call GetItemName
	jp PlaceString
.trade
	ld de, PokedexEvoTradeText
	jp PlaceString

PokedexEvoLevelText:
; The trailing space is load-bearing: PrintNumber right-aligns into two digits,
; so a level below ten already brings its own space and one at or above ten
; does not. Without this, "LEVEL 8" and "LEVEL11".
	db "LEVEL @"

PokedexEvoTradeText:
	db "TRADE@"

PokedexNoEvolutionText:
	db "DOES NOT EVOLVE@"

Pokedex_PrintBaseStats:
; The first page of DATA: what the word "DATA" ought to have meant all along.
; Draws below the divider the entry screen already put on row 9, so everything
; above it - picture, name, species word, height, weight, №. - simply stays.
;
;        0123456789012345678
;   row9 ├─────────────────┤
;  row10 |        BASE STATS|
;  row11 |TYPE1/   HP    100|
;  row12 | GRASS   ATK    85|
;  row13 |TYPE2/   DEF    90|
;  row14 | POISON  SPD    80|
;  row15 |         SPC   105|
;  row16 |    TOTAL      460|
;
; Nothing here has to go and FETCH anything. DrawDexEntryOnScreen already
; called GetMonHeader with wd0b5 = the internal index, to find the front
; sprite, so wMonHBaseStats and wMonHTypes are sitting in WRAM by the time this
; runs. That is the same free ride pureRGB and kep-hack take, and it is why
; this needs no dex→index conversion and no far call for the data.
	hlcoord 9, 10
	ld de, BaseStatsHeaderText
	call PlaceString

; The type labels go down BEFORE the names, because PrintMonType erases the
; "TYPE2/" label itself for a single-typed mon - and it erases six tiles at
; hl + $13, which is one row below and one column left of where it puts the
; first name. Names at (2,12) therefore need the labels at (1,11) and (1,13).
; That is the same relative shape the status screen uses, which is what makes
; the stock predef fit here without an adapter.
	hlcoord 1, 11
	ld de, PokedexTypeLabelsText
	call PlaceString
	hlcoord 2, 12
	predef PrintMonType

; Six labels on six CONSECUTIVE rows. "next" moves two rows unless bit 2 of
; hUILayoutFlags is set (home/text.asm), so it goes on here and comes straight
; back off - the type labels above want the ordinary two-row spacing, and
; TOTAL hangs one column left of the rest on purpose, so the sum does not read
; as a sixth stat.
	ldh a, [hUILayoutFlags]
	push af
	set 2, a
	ldh [hUILayoutFlags], a
	hlcoord 11, 11
	ld de, BaseStatLabelsText
	call PlaceString
	pop af
	ldh [hUILayoutFlags], a
	hlcoord 9, 16
	ld de, BaseStatTotalText
	call PlaceString

; The five stats, right-aligned into columns 16-18, one row apart. Three digits
; is enough for every one of them and for the total; the assert in the
; base_stat_row macro is what keeps that true.
; 🔴 Only HP, ATK and DEF walk the struct in order. SPECIAL and SPEED are
; printed by hand, in THAT order, because the struct stores them the other way
; round (wMonHBaseSpeed then wMonHBaseSpecial) and this game shows SPECIAL
; first -- see the party stats screen, engine/pokemon/status_screen.asm, which
; prints ATTACK / DEFENSE / SPECIAL / SPEED. Vanilla has SPEED before SPECIAL in
; both places; this hack swapped the stats screen and this page was left behind,
; so the dex and the stats screen disagreed with each other. Forte caught it on
; a NIDORAN.
	ld de, wMonHBaseStats
	hlcoord 16, 11
	ld c, 3
.statLoop
	push bc
	push de
	push hl
	lb bc, 1, 3
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	pop bc
	dec c
	jr nz, .statLoop
; hl is on the fourth row now, and the loop left it there
	push hl
	ld de, wMonHBaseSpecial
	lb bc, 1, 3
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	ld de, wMonHBaseSpeed
	lb bc, 1, 3
	call PrintNumber

; The total, summed here rather than stored anywhere: there is no room in the
; base stats struct for a byte that is only ever the sum of five others.
	ld hl, 0
	ld de, wMonHBaseStats
	ld c, NUM_STATS
.sumLoop
	ld a, [de]
	inc de
	add l
	ld l, a
	ld a, 0 ; not xor a - the carry out of the low byte has to survive
	adc h
	ld h, a
	dec c
	jr nz, .sumLoop

; PrintNumber reads its number big-endian out of memory, so it needs an
; address. The two bytes are borrowed from hDexWeight and put back, which is
; exactly what the weight printing in DrawDexEntryOnScreen does with the same
; two bytes a few dozen lines above. Borrowing is not free there or here:
; hDexWeight is a union member (it shares with hBaseTileID and hOAMTile) and
; hDexWeight + 1 is hSpriteIndexOrTextID.
	ldh a, [hDexWeight]
	push af
	ldh a, [hDexWeight + 1]
	push af
	ld a, h
	ldh [hDexWeight], a
	ld a, l
	ldh [hDexWeight + 1], a
	ld de, hDexWeight
	hlcoord 16, 16
	lb bc, 2, 3
	call PrintNumber
	pop af
	ldh [hDexWeight + 1], a
	pop af
	ldh [hDexWeight], a
	ret

BaseStatsHeaderText:
	db "BASE STATS@"

BaseStatLabelsText:
	db   "HP"
	next "ATK"
	next "DEF"
	next "SPC"
	next "SPD@"

BaseStatTotalText:
	db "TOTAL@"

PokedexTypeLabelsText:
	db   "TYPE1/"
	next "TYPE2/@"

Pokedex_PrintFlavorTextAtRow11:
	bccoord 1, 11
Pokedex_PrintFlavorTextAtBC:
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor ; print pokedex description text
	xor a
	ldh [hClearLetterPrintingDelayFlags], a
	ret

; v0.7: Pokedex_PrepareDexEntryForPrinting lived here. It laid a dex entry out
; as a printer page, and only PrintPokedexEntry ever called it, so it went with
; the Game Boy Printer.

; draws a line of tiles
; INPUT:
; b = tile ID
; c = number of tile ID's to write
; de = amount to destination address after each tile (1 for horizontal, 20 for vertical)
; hl = destination address
DrawTileLine:
	push bc
	push de
.loop
	ld [hl], b
	add hl, de
	dec c
	jr nz, .loop
	pop de
	pop bc
	ret

INCLUDE "data/pokemon/dex_entries.asm"

PokedexToIndex:
	; converts the Pokédex number at wd11e to an index
	push bc
	push hl
	ld a, [wd11e]
	ld b, a
	ld c, 0
	ld hl, PokedexOrder

.loop ; go through the list until we find an entry with a matching dex number
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, c
	ld [wd11e], a
	pop hl
	pop bc
	ret

IndexToPokedex:
	; converts the index number at wd11e to a Pokédex number
	push bc
	push hl
	ld a, [wd11e]
	dec a
	ld hl, PokedexOrder
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/dex_order.asm"
