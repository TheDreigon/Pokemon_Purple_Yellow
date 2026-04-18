	db DEX_EEVEE ; pokedex id
	base_stat_row 65, 65, 65, 65, 65 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 92 ; base exp

	INCBIN "gfx/pokemon/front/eevee.pic", 0, 1 ; sprite dimensions
	dw EeveePicFront, EeveePicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  RAGE,         \
	     DIG,          MIMIC,   DOUBLE_TEAM,  REFLECT,      BIDE,              \
	     DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE
	; end

	db 0 ; padding
