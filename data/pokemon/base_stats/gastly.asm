	db DEX_GASTLY ; pokedex id
	base_stat_row 30, 40, 30, 90, 35, 90 ; hp atk def spatk spdef spd
	db GHOST, GAS ; type
	db 120 ; catch rate  ; exception: a body of gas; the band cannot see there is nothing to hold
	db 90 ; base exp  ; BST 315

	INCBIN "gfx/pokemon/front/gastly.pic", 0, 1 ; sprite dimensions
	dw GastlyPicFront, GastlyPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Gaseous ghost wisp, pre-evo backbone.
	tmhm FAINT_ATTACK, NIGHT_SHADE, CONFUSE_RAY, SCARY_FACE
	; end

	db BANK(GastlyPicFront) ; which bank this mon's pics live in
	assert BANK(GastlyPicFront) == BANK(GastlyPicBack), \
	    "Gastly: front and back pics must share a bank"
