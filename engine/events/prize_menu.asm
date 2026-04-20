CeladonPrizeMenu::
	ld b, COIN_CASE
	call IsItemInBag
	jr nz, .havingCoinCase
	ld hl, RequireCoinCaseTextPtr
	jp PrintText
.havingCoinCase
	ld hl, wd730
	set 6, [hl] ; disable letter-printing delay
	ld hl, ExchangeCoinsForPrizesTextPtr
	call PrintText
; v0.5 Phase B.3: determine menu type up front so we can size the layout.
; TM menu (window 2) shows 4 prizes; Mon menus (windows 0, 1) show 3.
	ldh a, [hSpriteIndexOrTextID]
	sub 4
	ld [wWhichPrizeWindow], a
; common menu setup
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, $04
	ld [wTopMenuItemY], a
	ld a, $01
	ld [wTopMenuItemX], a
	call PrintPrizePrice
	ld a, [wWhichPrizeWindow]
	cp 2
	jr z, .tmMenuLayout
; Mon menu: 3 prizes + NO_THANKS = 4 items, textbox 8 rows
	ld a, $03
	ld [wMaxMenuItem], a
	hlcoord 0, 2
	lb bc, 8, 16
	jr .drawTextBox
.tmMenuLayout
; TM menu: 4 prizes + NO_THANKS = 5 items, textbox 10 rows
	ld a, $04
	ld [wMaxMenuItem], a
	hlcoord 0, 2
	lb bc, 10, 16
.drawTextBox
	call TextBoxBorder
	call GetPrizeMenuId
	call UpdateSprites
	ld hl, WhichPrizeTextPtr
	call PrintText
	call HandleMenuInput ; menu choice handler
	bit BIT_B_BUTTON, a
	jr nz, .noChoice
	ld a, [wCurrentMenuItem]
	ld hl, wMaxMenuItem
	cp [hl] ; "NO,THANKS" is always the last item (index = wMaxMenuItem)
	jr z, .noChoice
	call HandlePrizeChoice
.noChoice
	ld hl, wd730
	res 6, [hl]
	ret

RequireCoinCaseTextPtr:
	text_far _RequireCoinCaseText
	text_waitbutton
	text_end

ExchangeCoinsForPrizesTextPtr:
	text_far _ExchangeCoinsForPrizesText
	text_end

WhichPrizeTextPtr:
	text_far _WhichPrizeText
	text_end

GetPrizeMenuId:
; v0.5 Phase B.3: handles 3 (Mon) or 4 (TM) prizes depending on
; wWhichPrizeWindow (already set by CeladonPrizeMenu).
; Loads the prizes at wPrize1.., the prices at wPrize1Price.., and
; displays them at the right rows for each menu type.
	ldh a, [hSpriteIndexOrTextID]
	sub 4       ; prize-texts' id are 3, 4 and 5
	ld [wWhichPrizeWindow], a    ; prize-texts' id (relative, i.e. 0, 1 or 2)
	add a
	add a
	ld d, 0
	ld e, a
	ld hl, PrizeDifferentMenuPtrs
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc hl
	push hl
	ld hl, wPrize1
	call CopyString
	pop hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wPrize1Price
; TM menu has 4 prices (8 bytes); Mon menus have 3 (6 bytes).
	ld a, [wWhichPrizeWindow]
	cp 2
	ld bc, 6
	jr nz, .gotPriceBytes
	ld bc, 8
.gotPriceBytes
	call CopyData
	ld a, [wWhichPrizeWindow]
	cp 2        ;is TM_menu?
	jr nz, .putMonName
	ld a, [wPrize1]
	ld [wd11e], a
	call GetItemName
	hlcoord 2, 4
	call PlaceString
	ld a, [wPrize2]
	ld [wd11e], a
	call GetItemName
	hlcoord 2, 6
	call PlaceString
	ld a, [wPrize3]
	ld [wd11e], a
	call GetItemName
	hlcoord 2, 8
	call PlaceString
	ld a, [wPrize4]
	ld [wd11e], a
	call GetItemName
	hlcoord 2, 10
	call PlaceString
	hlcoord 2, 12
	ld de, NoThanksText
	call PlaceString
	jr .putPrices
.putMonName
	ld a, [wPrize1]
	ld [wd11e], a
	call GetMonName
	hlcoord 2, 4
	call PlaceString
	ld a, [wPrize2]
	ld [wd11e], a
	call GetMonName
	hlcoord 2, 6
	call PlaceString
	ld a, [wPrize3]
	ld [wd11e], a
	call GetMonName
	hlcoord 2, 8
	call PlaceString
	hlcoord 2, 10
	ld de, NoThanksText
	call PlaceString
.putPrices
; put prices on the right side of the textbox
; reg. c: [low nybble] number of bytes; [bits 765 = %100] space-padding
	ld de, wPrize1Price
	hlcoord 13, 5
	ld c, (1 << 7 | 2)
	call PrintBCDNumber
	ld de, wPrize2Price
	hlcoord 13, 7
	ld c, (1 << 7 | 2)
	call PrintBCDNumber
	ld de, wPrize3Price
	hlcoord 13, 9
	ld c, (1 << 7 | 2)
	call PrintBCDNumber
	ld a, [wWhichPrizeWindow]
	cp 2 ; is TM menu?
	ret nz
	ld de, wPrize4Price
	hlcoord 13, 11
	ld c, (1 << 7 | 2)
	jp PrintBCDNumber

NoThanksText:
	db "NO THANKS@"

INCLUDE "data/events/prizes.asm"

PrintPrizePrice:
	hlcoord 11, 0
	lb bc, 1, 7
	call TextBoxBorder
	call UpdateSprites
	hlcoord 12, 0
	ld de, .CoinString
	call PlaceString
	hlcoord 13, 1
	ld de, .SixSpacesString
	call PlaceString
	hlcoord 13, 1
	ld de, wPlayerCoins
	ld c, %10000010
	call PrintBCDNumber
	ret

.CoinString:
	db "COIN@"

.SixSpacesString:
	db "      @"

LoadCoinsToSubtract:
	ld a, [wWhichPrize]
	add a
	ld d, 0
	ld e, a
	ld hl, wPrize1Price
	add hl, de ; get selected prize's price
	xor a
	ldh [hUnusedCoinsByte], a
	ld a, [hli]
	ldh [hCoins], a
	ld a, [hl]
	ldh [hCoins + 1], a
	ret

HandlePrizeChoice:
	ld a, [wCurrentMenuItem]
	ld [wWhichPrize], a
	ld d, 0
	ld e, a
	ld hl, wPrize1
	add hl, de
	ld a, [hl]
	ld [wd11e], a
	ld a, [wWhichPrizeWindow]
	cp 2 ; is prize a TM?
	jr nz, .getMonName
	call GetItemName
	jr .givePrize
.getMonName
	call GetMonName
.givePrize
	ld hl, SoYouWantPrizeTextPtr
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; yes/no answer (Y=0, N=1)
	and a
	jr nz, .printOhFineThen
	call LoadCoinsToSubtract
	call HasEnoughCoins
	jr c, .notEnoughCoins
	ld a, [wWhichPrizeWindow]
	cp $02
	jr nz, .giveMon
	ld a, [wd11e]
	ld b, a
	ld a, 1
	ld c, a
	call GiveItem
	jr nc, .bagFull
	jr .subtractCoins
.giveMon
	ld a, [wd11e]
	ld [wcf91], a
	push af
	call GetPrizeMonLevel
	ld c, a
	pop af
	ld b, a
	call GivePokemon

; If either the party or box was full, wait after displaying message.
	push af
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	pop af

; If the mon couldn't be given to the player (because both the party and box
; were full), return without subtracting coins.
	ret nc

.subtractCoins
	call LoadCoinsToSubtract
	ld hl, hCoins + 1
	ld de, wPlayerCoins + 1
	ld c, $02 ; how many bytes
	predef SubBCDPredef
	jp PrintPrizePrice
.bagFull
	ld hl, PrizeRoomBagIsFullTextPtr
	jp PrintText
.notEnoughCoins
	ld hl, SorryNeedMoreCoinsText
	jp PrintText
.printOhFineThen
	ld hl, OhFineThenTextPtr
	jp PrintText

UnknownPrizeData:
; XXX what's this?
	db $00,$01,$00,$01,$00,$01,$00,$00,$01

HereYouGoTextPtr:
	text_far _HereYouGoText
	text_waitbutton
	text_end

SoYouWantPrizeTextPtr:
	text_far _SoYouWantPrizeText
	text_end

SorryNeedMoreCoinsText:
	text_far _SorryNeedMoreCoinsText
	text_waitbutton
	text_end

PrizeRoomBagIsFullTextPtr:
	text_far _OopsYouDontHaveEnoughRoomText
	text_waitbutton
	text_end

OhFineThenTextPtr:
	text_far _OhFineThenText
	text_waitbutton
	text_end

GetPrizeMonLevel:
	ld a, [wcf91]
	ld b, a
	ld hl, PrizeMonLevelDictionary
.loop
	ld a, [hli]
	cp b
	jr z, .matchFound
	inc hl
	jr .loop
.matchFound
	ld a, [hl]
	ld [wCurEnemyLVL], a
	ret

INCLUDE "data/events/prize_mon_levels.asm"
