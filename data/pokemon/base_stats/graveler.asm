	db DEX_GRAVELER ; pokedex id
	base_stat_row 55, 100, 115, 50, 45 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 120 ; catch rate
	db 134 ; base exp

	INCBIN "gfx/pokemon/front/graveler.pic", 0, 1 ; sprite dimensions
	dw GravelerPicFront, GravelerPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage rolling rock (Rock/Ground). HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, IRON_HEAD, TAKE_DOWN, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, STRENGTH, SEISMIC_TOSS
	; end

	db 0 ; padding
