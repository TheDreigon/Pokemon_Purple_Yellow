	db DEX_GROWLITHE ; pokedex id
	base_stat_row 65, 70, 45, 50, 70 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 190 ; catch rate
	db 91 ; base exp

	INCBIN "gfx/pokemon/front/growlithe.pic", 0, 1 ; sprite dimensions
	dw GrowlithePicFront, GrowlithePicBack

	db BITE, SCARY_FACE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm FLAMETHROWER, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE,  RAGE,        \
	     DRAGON_RAGE,  DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   DISCHARGE,        HEAD_SMASH,   REST,         \
	     SUBSTITUTE
	; end

	db 0 ; padding
