	db DEX_STARYU ; pokedex id
	base_stat_row 30, 40, 50, 75, 75 ; hp atk def spc spd
	db WATER, PSYCHIC_TYPE ; type
	db 220 ; catch rate  ; base stage, BST 270
	db 75 ; base exp  ; BST 270 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/staryu.pic", 0, 1 ; sprite dimensions
	dw StaryuPicFront, StaryuPicBack

	db TACKLE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water/Psychic gem-core star (pre-evo). Glowing core drives
	; DAZZLE_GLEAM/FLASH. Ladder prereqs: WATER_PULSE, ICY_PULSE.
	tmhm QUICK_ATTACK, WATER_PULSE, ICY_PULSE, DAZZLE_GLEAM, LIGHT_SCREEN, \
	     ICE_BEAM, REFLECT, SURF, FLASH
	; end

	db BANK(StaryuPicFront) ; which bank this mon's pics live in
	assert BANK(StaryuPicFront) == BANK(StaryuPicBack), \
	    "Staryu: front and back pics must share a bank"
