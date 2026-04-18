	db DEX_PSYDUCK ; pokedex id
	base_stat_row 50, 52, 48, 70, 55 ; hp atk def spc spd

	db WATER, WATER ; type
	db 190 ; catch rate
	db 80 ; base exp

	INCBIN "gfx/pokemon/front/psyduck.pic", 0, 1 ; sprite dimensions
	dw PsyduckPicFront, PsyduckPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     PAY_DAY,      SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, RAGE,         \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         DISCHARGE,        \
	     HEAD_SMASH,   REST, PSYCHIC_M, PSYWAVE,  SUBSTITUTE,  SURF, STRENGTH	   
	; end

	db 0 ; padding
