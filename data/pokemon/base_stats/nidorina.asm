	db DEX_NIDORINA ; pokedex id
	base_stat_row 75, 62, 67, 55, 70 ; hp atk def spc spd

	db POISON, POISON ; type
	db 115 ; catch rate  ; mid stage, BST 329
	db 120 ; base exp  ; BST 329 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidorina.pic", 0, 1 ; sprite dimensions
	dw NidorinaPicFront, NidorinaPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage female, growing chemical bruiser.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, \
	     TAKE_DOWN, DOUBLE_EDGE
	; end

	db BANK(NidorinaPicFront) ; which bank this mon's pics live in
	assert BANK(NidorinaPicFront) == BANK(NidorinaPicBack), \
	    "Nidorina: front and back pics must share a bank"
