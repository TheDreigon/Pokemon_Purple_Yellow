	db DEX_KOFFING ; pokedex id
	base_stat_row 40, 65, 80, 65, 40 ; hp atk def spc spd
	db POISON, GAS ; type
	db 190 ; catch rate
	db 114 ; base exp

	INCBIN "gfx/pokemon/front/koffing.pic", 0, 1 ; sprite dimensions
	dw KoffingPicFront, KoffingPicBack

	db TACKLE, SMOG, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm FLAMETHROWER, LIGHT_SCREEN, NIGHT_SHADE,  TOXIC
	; end

	db 0 ; padding
