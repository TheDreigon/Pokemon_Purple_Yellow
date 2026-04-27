	db DEX_ARBOK ; pokedex id
	base_stat_row 60, 90, 90, 60, 100 ; hp atk def spc spd
	db POISON, DARK ; type
	db 90 ; catch rate
	db 147 ; base exp

	INCBIN "gfx/pokemon/front/arbok.pic", 0, 1 ; sprite dimensions
	dw ArbokPicFront, ArbokPicBack

	db WRAP, LEER, BITE, POISON_STING ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: cobra Poison/Dark. Ekans's 9 + 4 apex additions:
	; Body Slam (bigger snake), Iron Tail (per Forte — heavy whip-tail),
	; Intimidate (cobra hood — levelup-double), Scary Face (per Forte —
	; cobra hood at evo level, levelup-double).
	tmhm QUICK_ATTACK, SUBSTITUTE,   BIND,         POISON_FANG,  TOXIC,        \
	     AGILITY,      TAKE_DOWN,    FAINT_ATTACK, CUT,          BODY_SLAM,    \
	     IRON_TAIL,    INTIMIDATE,   SCARY_FACE,   DOUBLE_EDGE
	; end

	db 0 ; padding
