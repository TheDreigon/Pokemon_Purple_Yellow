	db DEX_CHARMANDER ; pokedex id
	base_stat_row 50, 55, 40, 55, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 120 ; catch rate  ; set by hand: starter line
	db 75 ; base exp  ; BST 265 - grupo mantido igual

	INCBIN "gfx/pokemon/front/charmander.pic", 0, 1 ; sprite dimensions
	dw CharmanderPicFront, CharmanderPicBack

	db SCRATCH, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby fire reptile. Fire offense (FLAME_BURST/IGNITE/FLAMETHROWER)
	; plus its dragon heritage (DRAGON_CLAW/OUTRAGE). Claws enable CUT.
	tmhm QUICK_ATTACK, FLAME_BURST, IGNITE, DRAGON_CLAW, TAKE_DOWN, \
	     FLAMETHROWER, OUTRAGE, CUT, FLASH
	; end

	db BANK(CharmanderPicFront) ; which bank this mon's pics live in
	assert BANK(CharmanderPicFront) == BANK(CharmanderPicBack), \
	    "Charmander: front and back pics must share a bank"
