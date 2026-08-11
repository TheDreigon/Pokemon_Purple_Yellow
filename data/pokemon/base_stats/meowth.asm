	db DEX_MEOWTH ; pokedex id
	base_stat_row 45, 50, 40, 40, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 220 ; catch rate  ; base stage, BST 265
	db 75 ; base exp  ; BST 265 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/meowth.pic", 0, 1 ; sprite dimensions
	dw MeowthPicFront, MeowthPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Normal/Dark feline pre-evo, slim claw cat.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AGILITY, INTIMIDATE, SCARY_FACE, \
	     TAKE_DOWN, CUT, STRENGTH
	; end

	db BANK(MeowthPicFront) ; which bank this mon's pics live in
	assert BANK(MeowthPicFront) == BANK(MeowthPicBack), \
	    "Meowth: front and back pics must share a bank"
