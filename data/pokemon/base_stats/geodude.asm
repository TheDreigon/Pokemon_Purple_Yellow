	db DEX_GEODUDE ; pokedex id
	base_stat_row 40, 80, 100, 30, 20 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 255 ; catch rate
	db 86 ; base exp

	INCBIN "gfx/pokemon/front/geodude.pic", 0, 1 ; sprite dimensions
	dw GeodudePicFront, GeodudePicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic rolling rock with arms (Rock/Ground). HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, STRENGTH, ROCK_SLIDE
	; end

	db 0 ; padding
