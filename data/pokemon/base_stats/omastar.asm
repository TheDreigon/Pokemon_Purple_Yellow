	db DEX_OMASTAR ; pokedex id
	base_stat_row 80, 90, 120, 100, 60 ; hp atk def spc spd

	db ROCK, WATER ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/omastar.pic", 0, 1 ; sprite dimensions
	dw OmastarPicFront, OmastarPicBack

	db WATER_GUN, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        HORN_DRILL,   BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SUBMISSION,   SEISMIC_TOSS, RAGE,         MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         HEAD_SMASH,   REST,         SUBSTITUTE,   \
	     SURF,   ROCK_SLIDE
	; end

	db 0 ; padding
