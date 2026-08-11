	db DEX_SQUIRTLE ; pokedex id
	base_stat_row 50, 50, 65, 55, 45 ; hp atk def spc spd

	db WATER, WATER ; type
	db 120 ; catch rate  ; set by hand: starter line
	db 75 ; base exp  ; BST 265 - grupo mantido igual

	INCBIN "gfx/pokemon/front/squirtle.pic", 0, 1 ; sprite dimensions
	dw SquirtlePicFront, SquirtlePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby water turtle.
	tmhm WATER_PULSE, BODY_SLAM, TAKE_DOWN, LIGHT_SCREEN, REFLECT, \
	     DOUBLE_EDGE, CUT, SURF
	; end

	db BANK(SquirtlePicFront) ; which bank this mon's pics live in
	assert BANK(SquirtlePicFront) == BANK(SquirtlePicBack), \
	    "Squirtle: front and back pics must share a bank"
