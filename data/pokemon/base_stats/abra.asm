	db DEX_ABRA ; pokedex id
	base_stat_row 25, 20, 15, 105, 55, 95 ; hp atk def spatk spdef spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 220 ; catch rate  ; base stage, BST 315
	db 90 ; base exp  ; BST 315

	INCBIN "gfx/pokemon/front/abra.pic", 0, 1 ; sprite dimensions
	dw AbraPicFront, AbraPicBack

	db TELEPORT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby psychic, minimalist movepool (canon Abra knows only Teleport).
	; v1.0 (2026-11-07): LIGHT_SCREEN, REFLECT and EXTRASENSORY are level-up
	; autos (L30/L31/L34; levelup subset-of TM).
	tmhm EXTRASENSORY, LIGHT_SCREEN, REFLECT, CALM_MIND
	; end

	db BANK(AbraPicFront) ; which bank this mon's pics live in
	assert BANK(AbraPicFront) == BANK(AbraPicBack), \
	    "Abra: front and back pics must share a bank"
