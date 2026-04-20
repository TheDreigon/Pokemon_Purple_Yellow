	db DEX_FLAREON ; pokedex id
	base_stat_row 65, 110, 80, 130, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 198 ; base exp

	INCBIN "gfx/pokemon/front/flareon.pic", 0, 1 ; sprite dimensions
	dw FlareonPicFront, FlareonPicBack

	db TACKLE, TAIL_WHIP, EMBER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
