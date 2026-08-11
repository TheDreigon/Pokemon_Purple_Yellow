	db DEX_HAUNTER ; pokedex id
	base_stat_row 45, 60, 45, 105, 100 ; hp atk def spc spd
	db GHOST, GAS ; type
	db 75 ; catch rate  ; exception: same line, less substance still
	db 130 ; base exp  ; BST 355 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/haunter.pic", 0, 1 ; sprite dimensions
	dw HaunterPicFront, HaunterPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Handed sinister ghost; intermediate subset above Gastly.
	tmhm FAINT_ATTACK, NIGHT_SHADE, CONFUSE_RAY, POISON_BITE, TOXIC, \
	     EXTRASENSORY, INTIMIDATE, SCARY_FACE, DARK_PULSE, SHADOW_BALL
	; end

	db BANK(HaunterPicFront) ; which bank this mon's pics live in
	assert BANK(HaunterPicFront) == BANK(HaunterPicBack), \
	    "Haunter: front and back pics must share a bank"
