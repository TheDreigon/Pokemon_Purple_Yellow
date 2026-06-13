	db DEX_MEW ; pokedex id
	base_stat_row 140, 80, 80, 120, 140 ; hp atk def spc spd
	db PSYCHIC_TYPE, FAIRY ; type
	db 45 ; catch rate
	db 64 ; base exp

	INCBIN "gfx/pokemon/front/mew.pic", 0, 1 ; sprite dimensions
	dw MewPicFront, MewPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
