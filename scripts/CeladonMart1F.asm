CeladonMart1F_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMart1F_TextPointers:
	def_text_pointers
	dw_const CeladonMart1FReceptionistText,     TEXT_CELADONMART1F_RECEPTIONIST
	dw_const CeladonMart1FInfoClerkText,        TEXT_CELADONMART1F_INFO_CLERK
	dw_const CeladonMart1FDirectorySignText,    TEXT_CELADONMART1F_DIRECTORY_SIGN
	dw_const CeladonMart1FCurrentFloorSignText, TEXT_CELADONMART1F_CURRENT_FLOOR_SIGN

CeladonMart1FReceptionistText:
	text_far _CeladonMart1FReceptionistText
	text_end

; The information desk. Answers "what does this thing actually do?" for the
; ordinary goods the shops sell -- the one class of item a player cannot look up
; any other way until they own one, since the BAG's own INFO option only covers
; what is already in your pocket.
;
; Deliberately NOT tier-filtered: that FULL RESTORE exists is not a spoiler the
; way a TM list would be, and the closing line turns the locked half into a
; reason to go and earn badges. TMs, key items, fossils and the MASTER BALL are
; not here at all -- those stay bag-only.
;
; Two levels: a category board (the two-column shape the Viridian school
; blackboard uses) and then the game's own priced item list, so every entry
; shows its price beside its name for free. Splitting by category also keeps
; each sublist far inside wItemList -- the whole catalogue at once would be 45
; entries against an ITEM_LIST_SIZE of 41 that is already exactly full at the
; tiered mart's worst case, with wMartExtras sitting immediately behind it.
CeladonMart1FInfoClerkText:
	text_asm
	; Snapshot the map BEFORE the greeting, so restoring it between screens does
	; not leave the greeting's box sitting under the item list.
	call SaveScreenTilesToBuffer1
	ld hl, .IntroText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	; A stale poll count left by the Cable Club makes a menu give up before
	; reading any input and return its default -- a phantom accept. Zero it
	; before every menu of consequence.
	ld [wMenuJoypadPollCount], a
	ld a, D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	call .leftColumn

.categoryLoop
	; Re-armed EVERY pass, not just on entry: DisplayListMenuID is a scrolling
	; menu and leaves wMenuWatchMovingOutOfBounds set, which switches
	; HandleMenuInput from "wrap around" to "return the direction key to the
	; caller". This board wraps, so it must be clear -- otherwise Down on the
	; bottom row returned D_DOWN, fell past the B/Left/Right tests, and got
	; treated as a selection.
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wMenuJoypadPollCount], a
	ld hl, wd730
	set 6, [hl]
	hlcoord 0, 0
	lb bc, 10, 18
	call TextBoxBorder
	hlcoord 1, 2
	ld de, .CategoriesLeft
	call PlaceString
	hlcoord 10, 2
	ld de, .CategoriesRight
	call PlaceString
	ld hl, .WhichText
	call PrintText
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .done
	bit BIT_D_RIGHT, a
	jr z, .didNotPressRight
	call .rightColumn
	jr .categoryLoop
.didNotPressRight
	bit BIT_D_LEFT, a
	jr z, .checkA
	call .leftColumn
	jr .categoryLoop
.checkA
	; Test A rather than assuming "not B, not Left, not Right" means A. Anything
	; else HandleMenuInput hands back -- a direction key, a spurious 0 -- must
	; redraw, never select.
	bit BIT_A_BUTTON, a
	jr z, .categoryLoop

.chose
	ld a, [wMenuItemOffset]
	ld c, a
	ld a, [wCurrentMenuItem]
	ld b, a
	add c ; a = the category index
	cp NUM_INFO_DESK_CATEGORIES ; the slot after the last category is QUIT
	jr z, .done
	push bc ; remember the cursor, so backing out of a list lands on it again
	call .showCategory
	pop bc
	ld a, c
	and a
	jr nz, .restoreRight
	call .leftColumn
	jr .restoreCursor
.restoreRight
	call .rightColumn
.restoreCursor
	ld a, b
	ld [wCurrentMenuItem], a
	jr .categoryLoop

.done
	ld hl, wd730
	res 6, [hl]
	call LoadScreenTilesFromBuffer1
	ld hl, .BadgeNoteText
	call PrintText
	jp TextScriptEnd

; -- cursor placement for the two columns -------------------------------------
.leftColumn
	ld a, NUM_INFO_DESK_ROWS - 1
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	xor a
	ld [wMenuItemOffset], a
	ret

.rightColumn
	ld a, NUM_INFO_DESK_ROWS - 1
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 10
	ld [wTopMenuItemX], a
	ld a, NUM_INFO_DESK_ROWS
	ld [wMenuItemOffset], a
	ret

; -- one category: copy its list into wItemList and browse it -----------------
; in: a = category index
.showCategory
	add a
	ld d, 0
	ld e, a
	ld hl, .CategoryLists
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl -> db count, item, item, ...
	ld de, wItemList
	ld a, [hli]
	ld [de], a
	inc de
	ld b, a
.copyItem
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyItem
	ld a, -1
	ld [de], a ; terminator
	ld hl, wd730
	res 6, [hl]
	ld a, INIT_OTHER_ITEM_LIST
	ld [wInitListType], a
	callfar InitList

.itemLoop
	call LoadScreenTilesFromBuffer1
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wMenuJoypadPollCount], a
	inc a
	ld [wPrintItemPrices], a
	inc a ; a = 2 (PRICEDITEMLISTMENU) -- puts the price beside each name
	ld [wListMenuID], a
	call DisplayListMenuID
	ret c ; the player backed out of the list
	farcall DisplayItemDescription
	jr .itemLoop

.IntroText
	text_far _CeladonMart1FInfoClerkIntroText
	text_end

.WhichText
	text_far _CeladonMart1FInfoClerkWhichText
	text_end

.BadgeNoteText
	text_far _CeladonMart1FInfoClerkBadgeNoteText
	text_end

; Two columns of NUM_INFO_DESK_ROWS. Left column is indices 0-4, right column
; 5-9 via wMenuItemOffset, and the slot right after the last real category is
; QUIT -- so .CategoryLists must stay in exactly this order.
.CategoriesLeft
	db   " BALLS"
	next " HEALING"
	next " STATUS"
	next " REPELS"
	next " OTHER@"

.CategoriesRight
	db   " STONES"
	next " VITAMINS"
	next " BATTLE"
	next " DRINKS"
	next " QUIT@"

.CategoryLists
	dw .BallsList
	dw .HealingList
	dw .StatusList
	dw .RepelsList
	dw .OtherList
	dw .StonesList
	dw .VitaminsList
	dw .BattleList
	dw .DrinksList

.BallsList
	db 3, POKE_BALL, GREAT_BALL, ULTRA_BALL

.HealingList
	db 7, POTION, SUPER_POTION, HYPER_POTION, MAX_POTION, FULL_RESTORE, REVIVE, MAX_REVIVE

.StatusList
	db 6, ANTIDOTE, AWAKENING, PARLYZ_HEAL, BURN_HEAL, ICE_HEAL, FULL_HEAL

; ESCAPE ROPE rides with the repels: together they are the "get me out of here"
; shelf, and neither has enough friends for a category of its own.
.RepelsList
	db 4, REPEL, SUPER_REPEL, MAX_REPEL, ESCAPE_ROPE

; The NUGGET is the only thing here nobody sells -- it exists to be sold, which
; is precisely what a first-time finder does not know, so its description earns
; the slot.
.OtherList
	db 2, POKE_DOLL, NUGGET

.StonesList
	db 5, FIRE_STONE, LEAF_STONE, MOON_STONE, THUNDER_STONE, WATER_STONE

.VitaminsList
	db 12, HP_UP, PROTEIN, IRON, CALCIUM, CARBOS, RARE_CANDY, PP_UP, PP_MAX, ETHER, MAX_ETHER, ELIXIR, MAX_ELIXIR

.BattleList
	db 7, X_ATTACK, X_DEFEND, X_SPECIAL, X_SPEED, X_ACCURACY, DIRE_HIT, GUARD_SPEC

; Sold by the machine on this store's own roof.
.DrinksList
	db 3, FRESH_WATER, SODA_POP, LEMONADE

CeladonMart1FDirectorySignText:
	text_far _CeladonMart1FDirectorySignText
	text_end

CeladonMart1FCurrentFloorSignText:
	text_far _CeladonMart1FCurrentFloorSignText
	text_end
