PlayPokedexRatingSfx::
	ldh a, [hDexRatingNumMonsOwned]
	ld c, $0
	ld hl, OwnedMonValues
.getSfxPointer
	cp [hl]
	jr c, .gotSfxPointer
	inc c
	inc hl
	jr .getSfxPointer
.gotSfxPointer
	push bc
	call StopAllMusic
	pop bc
	ld b, $0
	ld hl, PokedexRatingSfxPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, [hl]
	call PlayMusic
	jp PlayDefaultMusic

PokedexRatingSfxPointers:
	db SFX_DENIED,         BANK(SFX_Denied_3)
	db SFX_POKEDEX_RATING, BANK(SFX_Pokedex_Rating_1)
	db SFX_GET_ITEM_1,     BANK(SFX_Get_Item1_1)
	db SFX_CAUGHT_MON,     BANK(SFX_Caught_Mon)
	db SFX_LEVEL_UP,       BANK(SFX_Level_Up)
	db SFX_GET_KEY_ITEM,   BANK(SFX_Get_Key_Item_1)
	db SFX_GET_ITEM_2,     BANK(SFX_Get_Item2_1)

OwnedMonValues:
; v1.0 (2026-11-09): the last jingle (SFX_GET_ITEM_2) is the complete #DEX's, and complete is every species since
; DREADROW: NUM_POKEMON, not vanilla's 150 (all but MEW)
	db 10, 40, 60, 90, 120, NUM_POKEMON, $ff
