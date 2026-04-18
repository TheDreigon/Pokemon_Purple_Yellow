	db DEX_MANKEY ; pokedex id
	base_stat_row 40, 80, 35, 30, 80 ; hp atk def spc spd
	db FIGHTING, DARK ; type
	db 190 ; catch rate
	db 74 ; base exp

	INCBIN "gfx/pokemon/front/mankey.pic", 0, 1 ; sprite dimensions
	dw MankeyPicFront, MankeyPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  PAY_DAY,      SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, \
	     RAGE,         THUNDERBOLT,  THUNDER,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         METRONOME,    DISCHARGE,        HEAD_SMASH,   \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	; end

	db 0 ; padding
