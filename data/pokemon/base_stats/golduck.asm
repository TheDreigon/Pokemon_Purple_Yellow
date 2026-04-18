	db DEX_GOLDUCK ; pokedex id
	base_stat_row 80, 80, 70, 90, 85 ; hp atk def spc spd
	db WATER, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 174 ; base exp

	INCBIN "gfx/pokemon/front/golduck.pic", 0, 1 ; sprite dimensions
	dw GolduckPicFront, GolduckPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   PAY_DAY,      SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, \
	     RAGE,         DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE,   SURF,         \
	     STRENGTH, PSYCHIC_M, PSYWAVE
	; end

	db 0 ; padding
