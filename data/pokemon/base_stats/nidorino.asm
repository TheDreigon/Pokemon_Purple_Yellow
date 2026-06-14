	db DEX_NIDORINO ; pokedex id
	base_stat_row 65, 80, 57, 40, 70 ; hp atk def spc spd

	db POISON, POISON ; type
	db 120 ; catch rate
	db 118 ; base exp

	INCBIN "gfx/pokemon/front/nidorino.pic", 0, 1 ; sprite dimensions
	dw NidorinoPicFront, NidorinoPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: mid-stage mature male, learns aggression primitives.
	; auto RAGE/BODY_SLAM/POISON_FANG/TAKE_DOWN. bonus
	; QUICK_ATTACK/FAINT_ATTACK/BULK_UP/TOXIC/SCARY_FACE/DOUBLE_EDGE.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, BULK_UP, \
	     POISON_FANG, TOXIC, SCARY_FACE, TAKE_DOWN, DOUBLE_EDGE
	; end

	db 0 ; padding
