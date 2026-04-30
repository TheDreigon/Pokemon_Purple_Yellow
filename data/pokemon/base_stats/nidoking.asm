	db DEX_NIDOKING ; pokedex id
	base_stat_row 90, 100, 90, 75, 75 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 195 ; base exp

	INCBIN "gfx/pokemon/front/nidoking.pic", 0, 1 ; sprite dimensions
	dw NidokingPicFront, NidokingPicBack

	db FIERCE_ROAR, HORN_ATTACK, POISON_FANG, BULLDOZE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review #5): apex predator male. Inherits Nidorino's
	; 11 + 9 apex additions: ROCK_THROW (poison/ground rock-thrower),
	; MEGAHORN¹ (Forte #9 — TM only after THRASH swap), INTIMIDATE (apex
	; presence), EARTHQUAKE¹/OUTRAGE¹ (capstone TMs matching levelup),
	; ROCK_SLIDE (Forte #5 add — Nidoking-only), BIND (Forte #5 add),
	; HM01 CUT (horn), HM04 STRENGTH¹.
	tmhm QUICK_ATTACK, BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN, \
	     BULK_UP,      DOUBLE_EDGE,  SWORDS_DANCE, SCARY_FACE,   FAINT_ATTACK, \
	     ROCK_THROW,   MEGAHORN,     INTIMIDATE,   EARTHQUAKE,   OUTRAGE, \
	     ROCK_SLIDE,   BIND,         CUT,          STRENGTH
	; end

	db 0 ; padding
