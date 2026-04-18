	db DEX_ELECTABUZZ ; pokedex id
	base_stat_row 75, 95, 65, 95, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 156 ; base exp

	INCBIN "gfx/pokemon/front/electabuzz.pic", 0, 1 ; sprite dimensions
	dw ElectabuzzPicFront, ElectabuzzPicBack

	db QUICK_ATTACK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, \
	     RAGE,         THUNDERBOLT,  THUNDER,      PSYCHIC_M,    TELEPORT,     \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         METRONOME,    \
	     DISCHARGE,        HEAD_SMASH,   REST,         THUNDER_WAVE, PSYWAVE,      \
	     SUBSTITUTE,   STRENGTH,     FLASH
	; end

	db 0 ; padding
