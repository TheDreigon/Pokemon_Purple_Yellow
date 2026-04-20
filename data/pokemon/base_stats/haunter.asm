	db DEX_HAUNTER ; pokedex id
	base_stat_row 45, 60, 45, 105, 100 ; hp atk def spc spd
	db GHOST, GAS ; type
	db 90 ; catch rate
	db 126 ; base exp

	INCBIN "gfx/pokemon/front/haunter.pic", 0, 1 ; sprite dimensions
	dw HaunterPicFront, HaunterPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
