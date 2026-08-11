	db DEX_GEODUDE ; pokedex id
	base_stat_row 40, 80, 100, 30, 20 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 220 ; catch rate  ; base stage, BST 270
	db 75 ; base exp  ; BST 270 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/geodude.pic", 0, 1 ; sprite dimensions
	dw GeodudePicFront, GeodudePicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic rolling rock with arms (Rock/Ground). HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, STRENGTH, ROCK_SLIDE
	; end

	db BANK(GeodudePicFront) ; which bank this mon's pics live in
	assert BANK(GeodudePicFront) == BANK(GeodudePicBack), \
	    "Geodude: front and back pics must share a bank"
