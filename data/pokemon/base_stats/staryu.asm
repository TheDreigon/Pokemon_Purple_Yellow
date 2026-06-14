	db DEX_STARYU ; pokedex id
	base_stat_row 30, 40, 50, 75, 75 ; hp atk def spc spd
	db WATER, PSYCHIC_TYPE ; type
	db 225 ; catch rate
	db 106 ; base exp

	INCBIN "gfx/pokemon/front/staryu.pic", 0, 1 ; sprite dimensions
	dw StaryuPicFront, StaryuPicBack

	db TACKLE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Water/Psychic gem-core star (pre-evo). auto
	; QUICK_ATTACK/WATER_PULSE/DAZZLE_GLEAM/LIGHT_SCREEN/FLASH. bonus
	; ICE_BEAM/REFLECT. HM SURF/FLASH.
	tmhm QUICK_ATTACK, WATER_PULSE, DAZZLE_GLEAM, LIGHT_SCREEN, ICE_BEAM, \
	     REFLECT, SURF, FLASH
	; end

	db 0 ; padding
