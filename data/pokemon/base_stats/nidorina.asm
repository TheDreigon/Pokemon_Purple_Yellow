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
	; v0.7 Pass 3 (Forte review F#2): mid-stage female. Inherits Nidoran♀'s
	; 4 + 3 additions: HONE_CLAWS, FAINT_ATTACK (Forte F-old #8 — F-line
	; Dark-coded), DOUBLE_EDGE (Forte F#2 — Nidorina+Nidoqueen). NO ROCK_
	; SLIDE (Forte F-old #6 — Nidoqueen-only). Removed SCRATCH from L1.
	tmhm BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN,    FAINT_ATTACK, \
	     DOUBLE_EDGE
	; end

	db 0 ; padding
