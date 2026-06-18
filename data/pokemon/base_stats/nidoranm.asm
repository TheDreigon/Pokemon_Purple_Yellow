	db DEX_NIDORAN_M ; pokedex id
	base_stat_row 46, 57, 40, 40, 55 ; hp atk def spc spd

	db POISON, POISON ; type
	db 235 ; catch rate
	db 60 ; base exp

	INCBIN "gfx/pokemon/front/nidoranm.pic", 0, 1 ; sprite dimensions
	dw NidoranMPicFront, NidoranMPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: juvenile aggressive male single-horn. auto
	; BODY_SLAM/POISON_BITE. bonus QUICK_ATTACK/TOXIC/TAKE_DOWN.
	tmhm QUICK_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, TAKE_DOWN
	; end

	db 0 ; padding
