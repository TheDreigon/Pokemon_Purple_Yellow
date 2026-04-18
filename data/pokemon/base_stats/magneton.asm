	db DEX_MAGNETON ; pokedex id
	base_stat_row 60, 75, 100, 120, 65 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 60 ; catch rate
	db 161 ; base exp

	INCBIN "gfx/pokemon/front/magneton.pic", 0, 1 ; sprite dimensions
	dw MagnetonPicFront, MagnetonPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   RAGE,         \
	     THUNDERBOLT,  THUNDER,      TELEPORT,     MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         DISCHARGE,        REST,         THUNDER_WAVE, \
	     SUBSTITUTE,   FLASH,     TRI_ATTACK
	; end

	db 0 ; padding
