	db DEX_CUBONE ; pokedex id
	base_stat_row 50, 50, 80, 40, 40 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp

	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
	dw CubonePicFront, CubonePicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH, FLAMETHROWER, HEAVY_SLAM, TOXIC, BODY_SLAM,  TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, RAGE,         EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     FIRE_BLAST,   HEAD_SMASH,   REST, SUBSTITUTE,   CUT,  STRENGTH,	   \
		 SWORDS_DANCE
	; end

	db 0 ; padding
