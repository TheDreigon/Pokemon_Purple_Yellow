	db DEX_WARTORTLE ; pokedex id
	base_stat_row 65, 60, 80, 70, 55 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 143 ; base exp

	INCBIN "gfx/pokemon/front/wartortle.pic", 0, 1 ; sprite dimensions
	dw WartortlePicFront, WartortlePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Warrior turtle mid-stage. Water attacks, body-slam bulk and
	; strength moves. Natural HM surfer/swimmer.
	tmhm BULLDOZE, WATER_PULSE, BODY_SLAM, BULK_UP, TAKE_DOWN, \
	     LIGHT_SCREEN, REFLECT, DOUBLE_EDGE, CUT, SURF, \
	     STRENGTH, ROCK_THROW
	; end

	db 0 ; padding
