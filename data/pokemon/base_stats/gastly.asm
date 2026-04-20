	db DEX_GASTLY ; pokedex id
	base_stat_row 30, 40, 30, 90, 90 ; hp atk def spc spd
	db GHOST, GAS ; type
	db 190 ; catch rate
	db 95 ; base exp

	INCBIN "gfx/pokemon/front/gastly.pic", 0, 1 ; sprite dimensions
	dw GastlyPicFront, GastlyPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
