	db DEX_ARCANINE ; pokedex id
	base_stat_row 100, 100, 80, 80, 95 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 75 ; catch rate
	db 213 ; base exp

	INCBIN "gfx/pokemon/front/arcanine.pic", 0, 1 ; sprite dimensions
	dw ArcaninePicFront, ArcaninePicBack

	db BITE, SCARY_FACE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm FLAMETHROWER, TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         DRAGON_RAGE,  DIG,          TELEPORT,     \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
		 DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE
	; end

	db 0 ; padding
