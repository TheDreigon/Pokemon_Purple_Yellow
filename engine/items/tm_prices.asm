GetMachinePrice::
; Input:  [wcf91] = Item Id of a TM
; Output: Stores the 3-byte BCD price at hItemPrice..hItemPrice+2.
; HMs are priceless: returns immediately without writing hItemPrice.
	ld a, [wcf91]
	sub TM01
	ret c ; HMs underflow and exit
	; offset = (TM_index) * 3
	ld b, a
	add a       ; *2
	add b       ; *3
	ld c, a
	ld b, 0
	ld hl, TechnicalMachinePrices
	add hl, bc
	ld a, [hli]
	ldh [hItemPrice + 0], a
	ld a, [hli]
	ldh [hItemPrice + 1], a
	ld a, [hl]
	ldh [hItemPrice + 2], a
	ret

INCLUDE "data/items/tm_prices.asm"
