	db DEX_VULPIX ; pokedex id
	base_stat_row 50, 40, 40, 70, 70 ; hp atk def spc spd
	db FIRE, FAIRY ; type
	db 190 ; catch rate
	db 63 ; base exp

	INCBIN "gfx/pokemon/front/vulpix.pic", 0, 1 ; sprite dimensions
	dw VulpixPicFront, VulpixPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC, FLAMETHROWER, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE,  RAGE,        \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE
	; end

	db 0 ; padding
