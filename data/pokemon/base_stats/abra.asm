	db DEX_ABRA ; pokedex id
	base_stat_row 25, 20, 15, 105, 95 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 225 ; catch rate  ; base stage, BST 260
	db 73 ; base exp

	INCBIN "gfx/pokemon/front/abra.pic", 0, 1 ; sprite dimensions
	dw AbraPicFront, AbraPicBack

	db TELEPORT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby psychic, minimalist movepool (canon Abra knows only Teleport).
	tmhm CALM_MIND
	; end

	db BANK(AbraPicFront) ; which bank this mon's pics live in
	assert BANK(AbraPicFront) == BANK(AbraPicBack), \
	    "Abra: front and back pics must share a bank"
