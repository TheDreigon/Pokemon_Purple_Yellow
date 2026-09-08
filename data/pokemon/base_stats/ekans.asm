	db DEX_EKANS ; pokedex id
	base_stat_row 35, 60, 45, 40, 55, 80 ; hp atk def spatk spdef spd

	db POISON, POISON ; type
	db 220 ; catch rate  ; base stage, BST 315
	db 90 ; base exp  ; BST 315

	INCBIN "gfx/pokemon/front/ekans.pic", 0, 1 ; sprite dimensions
	dw EkansPicFront, EkansPicBack

	db CONSTRICT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Poison snake (pre-evo backbone). HM CUT.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, IRON_TAIL, SUBSTITUTE, \
	     AGILITY, POISON_BITE, TOXIC, TAKE_DOWN, CUT
	; end

	db BANK(EkansPicFront) ; which bank this mon's pics live in
	assert BANK(EkansPicFront) == BANK(EkansPicBack), \
	    "Ekans: front and back pics must share a bank"
