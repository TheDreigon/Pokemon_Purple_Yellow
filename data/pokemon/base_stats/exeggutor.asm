	db DEX_EXEGGUTOR ; pokedex id
	base_stat_row 90, 70, 90, 120, 60 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 212 ; base exp

	INCBIN "gfx/pokemon/front/exeggutor.pic", 0, 1 ; sprite dimensions
	dw ExeggutorPicFront, ExeggutorPicBack

	db FURY_ATTACK, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   RAGE,         \
	     MEGA_DRAIN,   SOLARBEAM,    PSYCHIC_M,    TELEPORT,     MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         DARK_PULSE, GUNK_SHOT,     \
	     SOFTBOILED,   REST,   PSYWAVE,  EXPLOSION,   SUBSTITUTE,  STRENGTH,   \
		 MEGA_DRAIN,   DREAM_EATER
	; end

	db 0 ; padding
