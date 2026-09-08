	db DEX_OMANYTE ; pokedex id
	base_stat_row 40, 40, 100, 80, 55, 30 ; hp atk def spatk spdef spd

	db ROCK, WATER ; type
	db 210 ; catch rate  ; base stage, BST 345
	db 100 ; base exp  ; BST 345

	INCBIN "gfx/pokemon/front/omanyte.pic", 0, 1 ; sprite dimensions
	dw OmanytePicFront, OmanytePicBack

	db WATER_GUN, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Small spiral-shell ammonite Rock/Water pre-evo.
	tmhm ROCK_THROW, BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, \
	     TAKE_DOWN, ROCK_SLIDE, IRON_HEAD
	; end

	db BANK(OmanytePicFront) ; which bank this mon's pics live in
	assert BANK(OmanytePicFront) == BANK(OmanytePicBack), \
	    "Omanyte: front and back pics must share a bank"
