	db DEX_CHARMELEON ; pokedex id
	base_stat_row 60, 70, 55, 70, 75 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 142 ; base exp

	INCBIN "gfx/pokemon/front/charmeleon.pic", 0, 1 ; sprite dimensions
	dw CharmeleonPicFront, CharmeleonPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH, SWORDS_DANCE, FLAMETHROWER, HEAVY_SLAM, TOXIC,  BODY_SLAM,  \
	     TAKE_DOWN,    DOUBLE_EDGE,  SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, \
	     RAGE,         DRAGON_RAGE,  DIG,          MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         FIRE_BLAST,   DISCHARGE,        HEAD_SMASH,   \
	     REST,         SUBSTITUTE,   CUT,          STRENGTH
	; end

	db 0 ; padding
