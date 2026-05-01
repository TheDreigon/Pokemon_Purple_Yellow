	db DEX_RAPIDASH ; pokedex id
	base_stat_row 70, 100, 70, 85, 100 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 60 ; catch rate
	db 192 ; base exp

	INCBIN "gfx/pokemon/front/rapidash.pic", 0, 1 ; sprite dimensions
	dw RapidashPicFront, RapidashPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
