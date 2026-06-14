	db DEX_NIDORAN_F ; pokedex id
	base_stat_row 55, 47, 52, 40, 50 ; hp atk def spc spd

	db POISON, POISON ; type
	db 235 ; catch rate
	db 59 ; base exp

	INCBIN "gfx/pokemon/front/nidoranf.pic", 0, 1 ; sprite dimensions
	dw NidoranFPicFront, NidoranFPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: defensive female juvenile, poison glands. auto
	; BODY_SLAM/POISON_FANG/TOXIC. bonus TAKE_DOWN.
	tmhm BODY_SLAM, POISON_FANG, TOXIC, TAKE_DOWN
	; end

	db 0 ; padding
