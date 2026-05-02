	db DEX_MUK ; pokedex id
	base_stat_row 130, 95, 70, 95, 40 ; hp atk def spc spd
	db POISON, WATER ; type
	db 75 ; catch rate
	db 157 ; base exp

	INCBIN "gfx/pokemon/front/muk.pic", 0, 1 ; sprite dimensions
	dw MukPicFront, MukPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BIND,         BODY_SLAM,    BULLDOZE,     DOUBLE_EDGE,  EARTHQUAKE, \
	     ROCK_SLIDE,   SCARY_FACE,   TAKE_DOWN,    THRASH,       TOXIC, \
	     MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    STRENGTH
	; end

	db 0 ; padding
