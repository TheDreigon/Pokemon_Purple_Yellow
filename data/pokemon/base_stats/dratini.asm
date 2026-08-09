	db DEX_DRATINI ; pokedex id
	base_stat_row 60, 60, 40, 50, 60 ; hp atk def spc spd

	db DRAGON, DRAGON ; type
	db 40 ; catch rate  ; exception: precious, not strong: BST 270 would read as trivial
	db 67 ; base exp

	INCBIN "gfx/pokemon/front/dratini.pic", 0, 1 ; sprite dimensions
	dw DratiniPicFront, DratiniPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Dragon sea-snake baby. HM SURF.
	tmhm BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, SHOCK_WAVE, \
	     IRON_TAIL, DRAGON_CLAW, TAKE_DOWN, SURF
	; end

	db BANK(DratiniPicFront) ; which bank this mon's pics live in
	assert BANK(DratiniPicFront) == BANK(DratiniPicBack), \
	    "Dratini: front and back pics must share a bank"
