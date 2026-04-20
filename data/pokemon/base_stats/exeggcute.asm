	db DEX_EXEGGCUTE ; pokedex id
	base_stat_row 60, 35, 30, 80, 30 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 90 ; catch rate
	db 98 ; base exp

	INCBIN "gfx/pokemon/front/exeggcute.pic", 0, 1 ; sprite dimensions
	dw ExeggcutePicFront, ExeggcutePicBack

	db FURY_ATTACK, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
