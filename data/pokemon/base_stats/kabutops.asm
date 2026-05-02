	db DEX_KABUTOPS ; pokedex id
	base_stat_row 75, 115, 110, 80, 80 ; hp atk def spc spd
	db ROCK, BUG ; type
	db 45 ; catch rate
	db 201 ; base exp

	INCBIN "gfx/pokemon/front/kabutops.pic", 0, 1 ; sprite dimensions
	dw KabutopsPicFront, KabutopsPicBack

	db SCRATCH, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    DOUBLE_EDGE,  DRAGON_CLAW,  ICE_BEAM,     ICY_PULSE, \
	     LEECH_LIFE,   ROCK_SLIDE,   ROCK_THROW,   SWORDS_DANCE, TAKE_DOWN, \
	     WATER_PULSE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME, \
	     CUT,          SURF,         STRENGTH
	; end

	db 0 ; padding
