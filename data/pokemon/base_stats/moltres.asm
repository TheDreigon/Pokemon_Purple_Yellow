	db DEX_MOLTRES ; pokedex id
	base_stat_row 100, 100, 90, 130, 100 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 3 ; catch rate
	db 217 ; base exp

	INCBIN "gfx/pokemon/front/moltres.pic", 0, 1 ; sprite dimensions
	dw MoltresPicFront, MoltresPicBack

	db PECK, EMBER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
