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
	; v0.7 Pass 3 (Forte review): cordyceps-controlled bug. 3 TMs:
	; LEECH_LIFE¹ (Parasect levelup; bug-drain), GIGA_DRAIN¹ (plant
	; drain levelup), TOXIC (fungal toxins).
	tmhm LEECH_LIFE,   GIGA_DRAIN,   TOXIC
	; end

	db 0 ; padding
