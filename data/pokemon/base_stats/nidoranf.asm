	db DEX_NIDORAN_F ; pokedex id
	base_stat_row 60, 45, 50, 40, 55 ; hp atk def spc spd

	db POISON, POISON ; type
	db 230 ; catch rate  ; base stage, BST 250
	db 70 ; base exp  ; BST 250 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidoranf.pic", 0, 1 ; sprite dimensions
	dw NidoranFPicFront, NidoranFPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Defensive female juvenile, poison glands.
	tmhm QUICK_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, TAKE_DOWN
	; end

	db BANK(NidoranFPicFront) ; which bank this mon's pics live in
	assert BANK(NidoranFPicFront) == BANK(NidoranFPicBack), \
	    "NidoranF: front and back pics must share a bank"
