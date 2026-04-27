	db DEX_EKANS ; pokedex id
	base_stat_row 30, 60, 45, 40, 80 ; hp atk def spc spd

	db POISON, POISON ; type
	db 255 ; catch rate
	db 62 ; base exp

	INCBIN "gfx/pokemon/front/ekans.pic", 0, 1 ; sprite dimensions
	dw EkansPicFront, EkansPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: snake. Levelup-doubles for many. TOXIC TM per Forte #6.
	; HM01 Cut (fangs cut). NO HM02 Fly (no wings, snake).
	tmhm QUICK_ATTACK, SUBSTITUTE,   BIND,         POISON_FANG,  TOXIC,        \
	     AGILITY,      TAKE_DOWN,    FAINT_ATTACK, CUT
	; end

	db 0 ; padding
