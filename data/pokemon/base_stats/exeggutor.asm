	db DEX_EXEGGUTOR ; pokedex id
	base_stat_row 90, 70, 90, 120, 60 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 212 ; base exp

	INCBIN "gfx/pokemon/front/exeggutor.pic", 0, 1 ; sprite dimensions
	dw ExeggutorPicFront, ExeggutorPicBack

	db FURY_ATTACK, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    DARK_PULSE,   DOUBLE_EDGE,  EARTHQUAKE,   PETAL_DANCE, \
	     PSYCHIC_M,    TAKE_DOWN,    MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME
	; end

	db 0 ; padding
