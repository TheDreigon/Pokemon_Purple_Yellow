	db DEX_MAROWAK ; pokedex id
	base_stat_row 75, 90, 100, 80, 70 ; hp atk def spc spd
	db GROUND, DARK ; type
	db 75 ; catch rate
	db 124 ; base exp

	INCBIN "gfx/pokemon/front/marowak.pic", 0, 1 ; sprite dimensions
	dw MarowakPicFront, MarowakPicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH, FLAMETHROWER, HEAVY_SLAM, TOXIC,  BODY_SLAM, TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, RAGE,         \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,    	FIRE_BLAST,   	HEAD_SMASH,   REST, ROCK_SLIDE,  SUBSTITUTE,   \
	     CUT, 		STRENGTH, 		SWORDS_DANCE
	; end

	db 0 ; padding
