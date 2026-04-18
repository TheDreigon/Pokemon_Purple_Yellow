	db DEX_BUTTERFREE ; pokedex id
	base_stat_row 60, 60, 55, 95, 85 ; hp atk def spc spd
	db BUG, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 160 ; base exp

	INCBIN "gfx/pokemon/front/butterfree.pic", 0, 1 ; sprite dimensions
	dw ButterfreePicFront, ButterfreePicBack

	db TACKLE, HARDEN, ENTANGLE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,    TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         MEGA_DRAIN,   SOLARBEAM,    PSYCHIC_M,    \
	     TELEPORT,     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     DISCHARGE,        REST,         PSYWAVE,      SUBSTITUTE,   FLASH
	; end

	db 0 ; padding
