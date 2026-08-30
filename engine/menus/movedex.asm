; v0.7: the MOVEDEX.
;
; Named MOVEDEX, not ATTACKDEX: every use of "ATTACK" in this game's own text is
; the STAT ("Raises ATTACK", "X ATTACK", "high ATTACK!"), including on the very
; card this list opens. One word, one meaning.
;
; A browsable list of every move in the game, opened with START from the Pokedex
; list and shaped like it -- number above, name below, seven entries a screen.
; A on a move opens the same card that START opens on the FIGHT menu; B closes
; the list and hands the Pokedex back.
;
; START rather than SELECT (which is what pureRGB uses for the same job) so that
; the button which means "tell me about this move" is the same button in both
; places.
;
; 🔴 Deliberately NO side menu. Every navigation bug found by playtesting this
; project -- the two on the Celadon information desk, the Bill quiz, the Purple
; quiz -- has been a list with a second cursor beside it. There is one cursor
; here and two buttons, which removes the whole class.
;
; Moves are listed only once SEEN -- watched being used in a battle, or known by
; one of the player's own party. Everything else reads as a dashed line, and the
; count in the corner is how many of the 219 are open. See home/movedex_seen.asm
; for the two ways a move becomes seen and why the party counts.
;
; (This file used to argue the opposite, on the grounds that the bitfield needed
; 28 bytes of WRAM and WRAM is full at 8192/8192. It is: the 28 bytes came out of
; dead padding INSIDE the saved block instead, so they cost no WRAM and save
; themselves. See ram/wram.asm at wMovedexSeen.)

DEF MOVEDEX_ROWS EQU 7

ShowMovedexMenu::
; Do this before anything is drawn: it is what makes the list non-empty on a
; fresh save, and the SEEN count in the corner has to include it.
	call MarkPartyMovesSeen
; The Pokedex owns the list-position variables. Borrow them and give them back,
; or backing out of the movedex would leave the Pokedex scrolled somewhere the
; player never put it.
	ld a, [wListScrollOffset]
	push af
	ld a, [wCurrentMenuItem]
	push af
	ld a, [wLastMenuItem]
	push af
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a

; v0.7: the Pokedex's own tile patterns stay loaded, because this list is now
; drawn in the Pokedex's style -- one vertical rule down column 14 rather than
; text boxes. Only the move card needs the text-box border tiles, and .showCard
; swaps them in and back out again.
.redraw
	call Movedex_DrawInterface
.loop
	call Movedex_PlaceMoveList
	call GBPalNormal
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	xor a
	ld [hli], a ; top menu item X
	inc hl      ; leave wCurrentMenuItem where it is
	inc hl      ; wTileBehindCursor
	ld a, MOVEDEX_ROWS - 1
	ld [hli], a ; max menu item ID
; 🔴 D_UP and D_DOWN are deliberately NOT watched, exactly as the Pokedex list
; does it. A watched direction is returned to the caller *as well as* moving the
; cursor, so every Down both stepped the cursor and scrolled the list and the
; selection advanced by two. Unwatched, HandleMenuInput moves the cursor itself
; and only hands Up/Down back at the ends of the window -- which is when .up and
; .down should be scrolling and the only time they now run.
	ld [hl], D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON | START
; ...and that hand-back is what wMenuWatchMovingOutOfBounds buys. The Pokedex
; sets it before calling here so the value is inherited today; set it anyway,
; because inheriting a flag from the screen that happened to call you is not a
; thing to rely on.
	ld a, 1
	ld [wMenuWatchMovingOutOfBounds], a
	call HandleMenuInput

	bit BIT_B_BUTTON, a
	jr nz, .done
	bit BIT_START, a
	jr nz, .done ; START closes it the same way it opened it
	bit BIT_A_BUTTON, a
	jr nz, .showCard
	bit BIT_D_UP, a
	jr nz, .up
	bit BIT_D_DOWN, a
	jr nz, .down
	bit BIT_D_RIGHT, a
	jr nz, .pageDown
	bit BIT_D_LEFT, a
	jr nz, .pageUp
	jp .loop

.done
; 🔴 Hand the screen back BLANK. Pokedex_DrawInterface writes its panel cell by
; cell and never clears, so anything this list left in a cell the Pokedex does
; not itself write survived the handover -- the SEEN box and the old hint box
; came back interleaved with the dex's own SEEN/OWN counts and its side menu.
;
; But blank in WRAM, not on the LCD (2026-08-30): with the transfer left on,
; ClearScreen's wipe reached the screen and the player stared at white for 18
; frames while the dex reloaded tiles and redrew (measured on the emulated
; LCD; the forward handover shows 0). Auto-transfer stays off from here until
; Pokedex_PlacePokemonList re-enables it, so the first frame that reaches the
; LCD is the finished Pokedex - the same over-draw the forward direction does.
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call LoadPokedexTilePatterns_Movedex
	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	pop af
	ld [wListScrollOffset], a
	ret

.showCard
; wCurrentMenuItem is the row on screen; the move is that plus the scroll.
	ld a, [wListScrollOffset]
	ld b, a
	ld a, [wCurrentMenuItem]
	add b
	inc a ; move ids are 1-based
; 🔴 The move id is parked in b, NOT pushed. `push af` / `pop af` around the
; call would restore F as well as A and throw away the answer -- which is
; exactly the bug this line replaces: every dashed row still opened a card.
; IsMoveSeen preserves bc.
	ld b, a
	call IsMoveSeen
	jr z, .notSeenYet
	ld a, b
	ld [wPlayerSelectedMove], a
; The card is drawn with TextBoxBorder, so it needs the text-box tiles; the list
; behind it needs the Pokedex's. Swap either side of the call.
	call LoadTextBoxTilePatterns
	farcall ShowMoveInfo
	call LoadPokedexTilePatterns_Movedex
	jp .redraw

; A dashed line has no card behind it. Say so with the sound the game already
; uses for "that does nothing" rather than swallowing the press, which reads as
; a frozen menu.
.notSeenYet
	ld a, SFX_DENIED
	call PlaySound
	jp .loop

.up
	ld a, [wListScrollOffset]
	and a
	jr z, .wrapToBottom
	dec a
	ld [wListScrollOffset], a
	jp .loop

.down
	ld a, NUM_ATTACKS - MOVEDEX_ROWS
	ld b, a
	ld a, [wListScrollOffset]
	cp b
	jr z, .wrapToTop
	inc a
	ld [wListScrollOffset], a
	jp .loop

.pageDown
	ld a, [wListScrollOffset]
	add MOVEDEX_ROWS
	cp NUM_ATTACKS - MOVEDEX_ROWS
	jr c, .storePage
	ld a, NUM_ATTACKS - MOVEDEX_ROWS
.storePage
	ld [wListScrollOffset], a
	jp .loop

.pageUp
	ld a, [wListScrollOffset]
	sub MOVEDEX_ROWS
	jr nc, .storePage
	xor a
	jp .storePage

; Wrapping, the same courtesy the Pokedex list got: the ends of a 219-entry list
; are a long way apart.
.wrapToBottom
	ld a, NUM_ATTACKS - MOVEDEX_ROWS
	ld [wListScrollOffset], a
	ld a, MOVEDEX_ROWS - 1
	ld [wCurrentMenuItem], a
	jp .loop
.wrapToTop
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	jp .loop

; v0.7: drawn the way the POKéDEX draws itself, not with text boxes. The two
; lists sit one button apart and used to look like screens from different games:
; the dex rules its columns apart with a single alternating line down column 14
; and puts its labels in the open, while this one was framed in boxes.
;
; Same geometry as Pokedex_DrawInterface, so the eye does not have to move when
; START swaps them: rule down column 14, list heading at (1,1), the count in the
; right-hand column at (16,1)-(16,2).
Movedex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	hlcoord 14, 0
	ld [hl], $71 ; vertical line tile
	hlcoord 14, 1
	call Movedex_DrawVerticalLine
	hlcoord 14, 9
	call Movedex_DrawVerticalLine
	hlcoord 1, 1
	ld de, MovedexContentsText
	call PlaceString
; SEEN count. It cannot change while the list is open, so it is drawn with the
; interface rather than with the list; .redraw comes back through here after the
; card closes.
	hlcoord 16, 1
	ld de, MovedexSeenText
	call PlaceString
	call CountMovedexSeen
	ld [wd11e], a
	hlcoord 16, 2
	ld de, wd11e
	lb bc, 1, 3
	call PrintNumber
	ret

; A copy of the Pokedex's DrawPokedexVerticalLine: nine tiles down from hl,
; alternating between the two halves of the rule. It is copied rather than
; called because the Pokedex lives in another bank and this is ten bytes.
Movedex_DrawVerticalLine:
	ld c, 9 ; height of line
	ld de, SCREEN_WIDTH
	ld a, $71 ; vertical line tile
.loop
	ld [hl], a
	add hl, de
	xor 1 ; toggle between vertical line tile and box tile
	dec c
	jr nz, .loop
	ret

Movedex_PlaceMoveList:
	xor a
	ldh [hAutoBGTransferEnabled], a
; Same window the Pokedex clears for its own list, one column wider: move names
; run longer than species names and the rule is at column 14 either way.
	hlcoord 1, 2
	lb bc, 14, 12
	call ClearScreenArea
	hlcoord 1, 3
	ld a, [wListScrollOffset]
	ld [wd11e], a
	ld d, MOVEDEX_ROWS
.printLoop
	ld a, [wd11e]
	inc a
	ld [wd11e], a
	push af
	push de
	push hl
; the number sits on the row above the name, as it does in the Pokedex
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber
	pop hl
	push hl
	ld a, [wd11e]
	call IsMoveSeen
	jr z, .unseen
	call GetMoveName ; de = wcd6d
	jr .placeName
.unseen
	ld de, MovedexUnseenText
.placeName
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	pop af
	ld [wd11e], a
	dec d
	jr nz, .printLoop
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

; LoadPokedexTilePatterns lives in another bank and the Pokedex reaches it with
; callfar; wrap it so the exit path reads as one call.
LoadPokedexTilePatterns_Movedex:
	callfar LoadPokedexTilePatterns
	ret

MovedexContentsText:
	db "MOVES:@"

MovedexSeenText:
	db "SEEN@"

; Same dashes the POKéDEX list uses for an unseen species, for the same reason.
MovedexUnseenText:
	db "----------@"

