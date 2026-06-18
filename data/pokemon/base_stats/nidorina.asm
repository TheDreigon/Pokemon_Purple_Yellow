	db DEX_NIDORINA ; pokedex id
	base_stat_row 75, 62, 67, 55, 70 ; hp atk def spc spd

	db POISON, POISON ; type
	db 120 ; catch rate
	db 117 ; base exp

	INCBIN "gfx/pokemon/front/nidorina.pic", 0, 1 ; sprite dimensions
	dw NidorinaPicFront, NidorinaPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: mid-stage female, growing chemical bruiser. auto
	; BODY_SLAM/POISON_BITE/TOXIC/TAKE_DOWN. bonus
	; FAINT_ATTACK/DOUBLE_EDGE.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, POISON_BITE, TOXIC, \
	     TAKE_DOWN, DOUBLE_EDGE
	; end

	db 0 ; padding
