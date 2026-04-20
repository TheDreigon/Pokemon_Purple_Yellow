	db DEX_TANGELA ; pokedex id
	base_stat_row 80, 60, 100, 70, 50 ; hp atk def spc spd

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 166 ; base exp

	INCBIN "gfx/pokemon/front/tangela.pic", 0, 1 ; sprite dimensions
	dw TangelaPicFront, TangelaPicBack

	db CONSTRICT, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
