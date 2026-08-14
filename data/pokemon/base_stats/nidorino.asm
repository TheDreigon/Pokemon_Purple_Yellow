	db DEX_NIDORINO ; pokedex id
	base_stat_row 70, 80, 70, 50, 70 ; hp atk def spc spd

	db POISON, POISON ; type
	db 110 ; catch rate  ; mid stage, BST 340
	db 125 ; base exp  ; BST 340 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidorino.pic", 0, 1 ; sprite dimensions
	dw NidorinoPicFront, NidorinoPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage mature male, learns aggression primitives.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, BULK_UP, \
	     POISON_BITE, TOXIC, SCARY_FACE, TAKE_DOWN, DOUBLE_EDGE, \
	     MEGAHORN
	; end

	db BANK(NidorinoPicFront) ; which bank this mon's pics live in
	assert BANK(NidorinoPicFront) == BANK(NidorinoPicBack), \
	    "Nidorino: front and back pics must share a bank"
