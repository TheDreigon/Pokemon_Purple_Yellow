	db DEX_PONYTA ; pokedex id
	base_stat_row 50, 65, 50, 65, 80 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 190 ; catch rate
	db 152 ; base exp

	INCBIN "gfx/pokemon/front/ponyta.pic", 0, 1 ; sprite dimensions
	dw PonytaPicFront, PonytaPicBack

	db EMBER, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm FLAMETHROWER, TOXIC,  HORN_DRILL, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE,  \
	     RAGE,         MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE
	; end

	db 0 ; padding
