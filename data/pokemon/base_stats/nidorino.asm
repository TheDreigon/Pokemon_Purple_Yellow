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
	; v0.7 Pass 3 (Forte review #5): mid-stage male, mature. Inherits
	; Nidoran♂'s 5 + 6 additions per Forte: BULK_UP/DOUBLE_EDGE/SWORDS_
	; DANCE (training-tier — bulk muscular), SCARY_FACE (Forte #5 add),
	; HONE_CLAWS (Forte #5 add), FAINT_ATTACK (Forte #5 add). NO ROCK_
	; SLIDE (Forte #5 — Nidoking-only).
	tmhm QUICK_ATTACK, BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN, \
	     BULK_UP,      DOUBLE_EDGE,  SWORDS_DANCE, SCARY_FACE,   FAINT_ATTACK
	; end

	db 0 ; padding
