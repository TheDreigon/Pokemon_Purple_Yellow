	db DEX_CUBONE ; pokedex id
	base_stat_row 50, 50, 80, 40, 40 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp

	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
	dw CubonePicFront, CubonePicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   BULLDOZE,     RAGE,         BODY_SLAM,    BULK_UP, \
	     FAINT_ATTACK, CHARM,        TAKE_DOWN,    SWORDS_DANCE, ROCK_SLIDE, \
	     DOUBLE_EDGE
	; end

	db 0 ; padding
