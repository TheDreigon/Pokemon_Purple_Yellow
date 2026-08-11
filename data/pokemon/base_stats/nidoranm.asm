	db DEX_NIDORAN_M ; pokedex id
	base_stat_row 46, 57, 40, 40, 55 ; hp atk def spc spd

	db POISON, POISON ; type
	db 230 ; catch rate  ; base stage, BST 238
	db 65 ; base exp  ; BST 238 - poucas fraquezas (+5)

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
