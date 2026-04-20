	db DEX_ELECTABUZZ ; pokedex id
	base_stat_row 75, 90, 65, 100, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 156 ; base exp

	INCBIN "gfx/pokemon/front/electabuzz.pic", 0, 1 ; sprite dimensions
	dw ElectabuzzPicFront, ElectabuzzPicBack

	db QUICK_ATTACK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
