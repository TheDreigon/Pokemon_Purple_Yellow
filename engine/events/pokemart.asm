DisplayPokemartDialogue_::
	ld a, [wListScrollOffset]
	ld [wSavedListScrollOffset], a
	call UpdateSprites
	xor a
	ld [wBoughtOrSoldItemInMart], a
.loop
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld [wPlayerMonNumber], a
	inc a
	ld [wPrintItemPrices], a
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, BUY_SELL_QUIT_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID

; This code is useless. It copies the address of the pokemart's inventory to hl,
; but the address is never used.
	ld hl, wItemListPointer
	ld a, [hli]
	ld l, [hl]
	ld h, a

	ld a, [wMenuExitMethod]
	cp CANCELLED_MENU
	jp z, .done
	ld a, [wChosenMenuItem]
	and a ; buying?
	jp z, .buyMenu
	dec a ; selling?
	jp z, .sellMenu
	dec a ; quitting?
	jp z, .done
.sellMenu

; the same variables are set again below, so this code has no effect
	xor a
	ld [wPrintItemPrices], a
	ld a, INIT_BAG_ITEM_LIST
	ld [wInitListType], a
	callfar InitList

	ld a, [wNumBagItems]
	and a
	jp z, .bagEmpty
	ld hl, PokemonSellingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1 ; save screen
.sellMenuLoop
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID ; draw money text box
	ld hl, wNumBagItems
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wCurrentMenuItem], a
	ld a, ITEMLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jp c, .returnToMainPokemartMenu ; if the player closed the menu
.confirmItemSale ; if the player is trying to sell a specific item
	call IsKeyItem
	ld a, [wIsKeyItem]
	and a
	jr nz, .unsellableItem
	ld a, [wcf91]
	call IsItemHM
	jr c, .unsellableItem
	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	ldh [hHalveItemPrices], a ; halve prices when selling
	call CapQuantityByPrice ; the sum is built from the FULL price, then halved
	call DisplayChooseQuantityMenu
	inc a
	jr z, .sellMenuLoop ; if the player closed the choose quantity menu with the B button
	ld hl, PokemartTellSellPriceText
	lb bc, 14, 1 ; location that PrintText always prints to, this is useless
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM
	jr z, .sellMenuLoop ; if the player chose No or pressed the B button

; The following code is supposed to check if the player chose No, but the above
; check already catches it.
	ld a, [wChosenMenuItem]
	dec a
	jr z, .sellMenuLoop

.sellItem
	ld a, [wBoughtOrSoldItemInMart]
	and a
	jr nz, .skipSettingFlag1
	inc a
	ld [wBoughtOrSoldItemInMart], a
.skipSettingFlag1
	call AddAmountSoldToMoney
	ld hl, wNumBagItems
	call RemoveItemFromInventory
	jp .sellMenuLoop
.unsellableItem
	ld hl, PokemartUnsellableItemText
	call PrintText
	jp .returnToMainPokemartMenu
.bagEmpty
	ld hl, PokemartItemBagEmptyText
	call PrintText
	call SaveScreenTilesToBuffer1
	jp .returnToMainPokemartMenu
.buyMenu

; the same variables are set again below, so this code has no effect
	ld a, 1
	ld [wPrintItemPrices], a
	ld a, INIT_OTHER_ITEM_LIST
	ld [wInitListType], a
	callfar InitList

	ld hl, PokemartBuyingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1
.buyMenuLoop
	call LoadScreenTilesFromBuffer1
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wCurrentMenuItem], a
	inc a
	ld [wPrintItemPrices], a
	inc a ; a = 2 (PRICEDITEMLISTMENU)
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .returnToMainPokemartMenu ; if the player closed the menu
	ld a, 99
	ld [wMaxItemQuantity], a
	call CapQuantityByPrice
	xor a
	ldh [hHalveItemPrices], a ; don't halve item prices when buying
	call DisplayChooseQuantityMenu
	inc a
	jr z, .buyMenuLoop ; if the player closed the choose quantity menu with the B button
	ld a, [wcf91] ; item ID
	ld [wd11e], a ; store item ID for GetItemName
	call GetItemName
	call CopyToStringBuffer
	ld hl, PokemartTellBuyPriceText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM
	jp z, .buyMenuLoop ; if the player chose No or pressed the B button

; The following code is supposed to check if the player chose No, but the above
; check already catches it.
	ld a, [wChosenMenuItem]
	dec a
	jr z, .buyMenuLoop

.buyItem
	call .isThereEnoughMoney
	jr c, .notEnoughMoney
	ld hl, wNumBagItems
	call AddItemToInventory
	jr nc, .bagFull
	call SubtractAmountPaidFromMoney
	ld a, [wBoughtOrSoldItemInMart]
	and a
	jr nz, .skipSettingFlag2
	ld a, 1
	ld [wBoughtOrSoldItemInMart], a
.skipSettingFlag2
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl, PokemartBoughtItemText
	call PrintText
	jp .buyMenuLoop
.returnToMainPokemartMenu
	call LoadScreenTilesFromBuffer1
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, PokemartAnythingElseText
	call PrintText
	jp .loop
.isThereEnoughMoney
	ld de, wPlayerMoney
	ld hl, hMoney
	ld c, 3 ; length of money in bytes
	jp StringCmp
.notEnoughMoney
	ld hl, PokemartNotEnoughMoneyText
	call PrintText
	jr .returnToMainPokemartMenu
.bagFull
	ld hl, PokemartItemBagFullText
	call PrintText
	jr .returnToMainPokemartMenu
.done
	ld hl, PokemartThankYouText
	call PrintText
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	call UpdateSprites
	ld a, [wSavedListScrollOffset]
	ld [wListScrollOffset], a
	ret

CapQuantityByPrice:
; v0.7 FIX: the running total in DisplayChooseQuantityMenu's .printPrice is a
; 3-byte BCD, so it tops out at 999999 - and AddBCD SATURATES there instead of
; failing, filling the sum with $99s. Any quantity whose true total overflowed
; was therefore charged the saturated value: 99 PP MAX (19600 each) really cost
; 1940400 but rang up as 999999, and 99 of TM55 OUTRAGE (27500) should cost
; 2722500. Selling had the mirror problem, because the loop sums the FULL price
; and only halves afterwards, so a big stack paid out 499999 instead of its
; real value.
;
; Fix: cap the quantity by the item's price so the product always fits. The top
; BCD byte of the price is exactly the tier we need - $00 means under 10000,
; where the existing 99 already fits (99 x 9999 = 989901); $0N means the price
; is at most N9999, so the cap is 999999 / N9999; $10 or more means the price
; is 100000+, where only one at a time can be represented. Deriving the cap
; from the price means no future repricing can reintroduce the bug.
;
; Only lowers the cap, never raises it, so selling a stack of 3 still offers 3.
; In: [wcf91] = item id, [wListMenuID] already set (GetItemPrice reads it).
	call GetItemPrice
	ldh a, [hItemPrice] ; top BCD byte of the 3-byte price
	and a
	ret z ; under 10000: 99 of them always fit, leave the cap alone
	cp $10
	jr nc, .singleUnitOnly ; 100000 or more: one at a time
	ld c, a
	ld b, 0
	ld hl, .capForTopDigit
	add hl, bc
	ld a, [hl]
	jr .clamp
.singleUnitOnly
	ld a, 1
.clamp
	ld b, a
	ld a, [wMaxItemQuantity]
	cp b
	ret c ; the caller's cap is already lower (e.g. selling a short stack)
	ld a, b
	ld [wMaxItemQuantity], a
	ret

.capForTopDigit
; index = top BCD byte of the price = floor(price / 10000); entry N is
; 999999 / N9999, the largest quantity that cannot overflow the BCD total.
; Index 0 is never read (handled by the early return above).
	db 99, 50, 33, 25, 20, 16, 14, 12, 11, 10

PokemartBuyingGreetingText:
	text_far _PokemartBuyingGreetingText
	text_end

PokemartTellBuyPriceText:
	text_far _PokemartTellBuyPriceText
	text_end

PokemartBoughtItemText:
	text_far _PokemartBoughtItemText
	text_end

PokemartNotEnoughMoneyText:
	text_far _PokemartNotEnoughMoneyText
	text_end

PokemartItemBagFullText:
	text_far _PokemartItemBagFullText
	text_end

PokemonSellingGreetingText:
	text_far _PokemonSellingGreetingText
	text_end

PokemartTellSellPriceText:
	text_far _PokemartTellSellPriceText
	text_end

PokemartItemBagEmptyText:
	text_far _PokemartItemBagEmptyText
	text_end

PokemartUnsellableItemText:
	text_far _PokemartUnsellableItemText
	text_end

PokemartThankYouText:
	text_far _PokemartThankYouText
	text_end

PokemartAnythingElseText:
	text_far _PokemartAnythingElseText
	text_end
