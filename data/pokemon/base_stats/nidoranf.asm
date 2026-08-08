	db DEX_NIDORAN_F ; pokedex id
	base_stat_row 55, 47, 52, 40, 50 ; hp atk def spc spd

	db POISON, POISON ; type
	db 230 ; catch rate  ; base stage, BST 244
	db 59 ; base exp

	INCBIN "gfx/pokemon/front/nidoranf.pic", 0, 1 ; sprite dimensions
	dw NidoranFPicFront, NidoranFPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Defensive female juvenile, poison glands.
	tmhm QUICK_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, TAKE_DOWN
	; end

	db 0 ; padding
