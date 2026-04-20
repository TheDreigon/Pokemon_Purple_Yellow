	db DEX_GENGAR ; pokedex id
	base_stat_row 65, 90, 65, 120, 110 ; hp atk def spc spd
	db GHOST, DARK ; type
	db 45 ; catch rate
	db 190 ; base exp

	INCBIN "gfx/pokemon/front/gengar.pic", 0, 1 ; sprite dimensions
	dw GengarPicFront, GengarPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
