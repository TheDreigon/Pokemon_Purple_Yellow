	db DEX_WARTORTLE ; pokedex id
	base_stat_row 65, 60, 80, 70, 55 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 143 ; base exp

	INCBIN "gfx/pokemon/front/wartortle.pic", 0, 1 ; sprite dimensions
	dw WartortlePicFront, WartortlePicBack

	db TACKLE, TAIL_WHIP, WATER_GUN, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, RAGE,         DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         HEAD_SMASH,   \
	     REST,         SUBSTITUTE,   SURF,         STRENGTH
	; end

	db 0 ; padding
