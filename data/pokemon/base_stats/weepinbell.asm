	db DEX_WEEPINBELL ; pokedex id
	base_stat_row 60, 85, 50, 75, 60 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 130 ; catch rate  ; mid stage, BST 330, easy to approach
	db 110 ; base exp  ; BST 330 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/weepinbell.pic", 0, 1 ; sprite dimensions
	dw WeepinbellPicFront, WeepinbellPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage carnivore (Grass/Poison). Draining and toxic moves,
	; body-slam bulk. Natural HM cutter.
	tmhm FAINT_ATTACK, BODY_SLAM, GIGA_DRAIN, TOXIC, LEECH_LIFE, \
	     TAKE_DOWN, CUT
	; end

	db BANK(WeepinbellPicFront) ; which bank this mon's pics live in
	assert BANK(WeepinbellPicFront) == BANK(WeepinbellPicBack), \
	    "Weepinbell: front and back pics must share a bank"
