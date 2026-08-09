	db DEX_HORSEA ; pokedex id
	base_stat_row 30, 40, 70, 60, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 235 ; catch rate  ; set by hand
	db 83 ; base exp

	INCBIN "gfx/pokemon/front/horsea.pic", 0, 1 ; sprite dimensions
	dw HorseaPicFront, HorseaPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Ink-spitting seahorse pre-evo; lean Water backbone. HM SURF.
	tmhm WATER_PULSE, ICY_PULSE, AGILITY, ICE_BEAM, SURF
	; end

	db BANK(HorseaPicFront) ; which bank this mon's pics live in
	assert BANK(HorseaPicFront) == BANK(HorseaPicBack), \
	    "Horsea: front and back pics must share a bank"
