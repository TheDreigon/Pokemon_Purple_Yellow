	db DEX_SANDSLASH ; pokedex id
	base_stat_row 70, 110, 110, 55, 65 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 90 ; catch rate
	db 163 ; base exp

	INCBIN "gfx/pokemon/front/sandslash.pic", 0, 1 ; sprite dimensions
	dw SandslashPicFront, SandslashPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    IRON_TAIL,    DRAGON_CLAW, \
	     IRON_HEAD,    TAKE_DOWN,    SWORDS_DANCE, EARTHQUAKE,   ROCK_SLIDE, \
	     DOUBLE_EDGE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME, \
	     CUT,          STRENGTH
	; end

	db 0 ; padding
