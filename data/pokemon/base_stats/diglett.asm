	db DEX_DIGLETT ; pokedex id
	base_stat_row 15, 60, 25, 40, 95 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 190 ; catch rate  ; set by hand: it is underground before you finish reaching
	db 60 ; base exp  ; BST 235 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/diglett.pic", 0, 1 ; sprite dimensions
	dw DiglettPicFront, DiglettPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Ground mole burrower (pre-evo). HM CUT.
	tmhm ROCK_THROW, QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, BODY_SLAM, AGILITY, \
	     TAKE_DOWN, EARTHQUAKE, CUT
	; end

	db BANK(DiglettPicFront) ; which bank this mon's pics live in
	assert BANK(DiglettPicFront) == BANK(DiglettPicBack), \
	    "Diglett: front and back pics must share a bank"
