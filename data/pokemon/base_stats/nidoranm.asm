	db DEX_NIDORAN_M ; pokedex id
	base_stat_row 50, 60, 50, 30, 60 ; hp atk def spc spd

	db POISON, POISON ; type
	db 230 ; catch rate  ; base stage, BST 250
	db 70 ; base exp  ; BST 250 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidoranm.pic", 0, 1 ; sprite dimensions
	dw NidoranMPicFront, NidoranMPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Juvenile aggressive male single-horn.
	tmhm QUICK_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, TAKE_DOWN
	; end

	db BANK(NidoranMPicFront) ; which bank this mon's pics live in
	assert BANK(NidoranMPicFront) == BANK(NidoranMPicBack), \
	    "NidoranM: front and back pics must share a bank"
