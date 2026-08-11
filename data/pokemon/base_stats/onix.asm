	db DEX_ONIX ; pokedex id
	base_stat_row 65, 100, 150, 60, 45 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 60 ; catch rate  ; set by hand: armoured, and enormous
	db 165 ; base exp  ; BST 420 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/onix.pic", 0, 1 ; sprite dimensions
	dw OnixPicFront, OnixPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Colossal single-stage rock-snake apex. HM STRENGTH.
	; Last-stage fun moves via TM.
	tmhm ROCK_THROW, BIND, BULLDOZE, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, EARTHQUAKE, ROCK_SLIDE, \
	     DOUBLE_EDGE, STRENGTH, THRASH, OUTRAGE
	; end

	db BANK(OnixPicFront) ; which bank this mon's pics live in
	assert BANK(OnixPicFront) == BANK(OnixPicBack), \
	    "Onix: front and back pics must share a bank"
