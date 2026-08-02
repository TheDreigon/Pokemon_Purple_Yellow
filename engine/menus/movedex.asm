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
; Every move is listed, with no "seen" gate. Gating would need a 28-byte
; bitfield that also had to survive a save, and WRAM is full at 8192/8192.
; A reference that hides entries is working against itself anyway.

DEF MOVEDEX_ROWS EQU 7

ShowMovedexMenu::
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

; The Pokedex swapped the text-box border tiles out for its own. Put them back,
; because this list and the move card are both drawn with TextBoxBorder.
	call LoadTextBoxTilePatterns
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
	ld [hl], D_UP | D_DOWN | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON | START
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
	ld [wPlayerSelectedMove], a
	farcall ShowMoveInfo
	jp .redraw

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

Movedex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	hlcoord 0, 0
	lb bc, 16, 12
	call TextBoxBorder
	hlcoord 13, 0
	lb bc, 4, 5
	call TextBoxBorder
	hlcoord 1, 1
	ld de, MovedexContentsText
	call PlaceString
	hlcoord 14, 1
	ld de, MovedexHintText
	call PlaceString
	ret

Movedex_PlaceMoveList:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 1, 2
	lb bc, 14, 11
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
	call GetMoveName ; de = wcd6d
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

MovedexHintText:
	db   "START"
	next "FOR"
	next "#DEX@"
