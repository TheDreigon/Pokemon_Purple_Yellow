	db DEX_PARAS ; pokedex id
	base_stat_row 45, 70, 55, 45, 40 ; hp atk def spc spd

	db BUG, GRASS ; type
	db 190 ; catch rate
	db 70 ; base exp

	INCBIN "gfx/pokemon/front/paras.pic", 0, 1 ; sprite dimensions
	dw ParasPicFront, ParasPicBack

	db BUG_BITE, SCRATCH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: bug cordyceps-controlado (Bug/Grass), pre-evo
	; backbone curto. auto GIGA_DRAIN/LEECH_LIFE. bonus TOXIC.
	tmhm GIGA_DRAIN, TOXIC, LEECH_LIFE
	; end

	db 0 ; padding
