	db DEX_NIDOKING ; pokedex id
	base_stat_row 90, 100, 90, 75, 75 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 195 ; base exp

	INCBIN "gfx/pokemon/front/nidoking.pic", 0, 1 ; sprite dimensions
	dw NidokingPicFront, NidokingPicBack

	db TACKLE, THRASH, DIG, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
