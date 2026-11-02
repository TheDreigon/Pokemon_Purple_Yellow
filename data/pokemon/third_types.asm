; v1.0 (2026-11-02): the #MON with a third type, Forte's list. The two types every struct keeps (base stats,
; party, box, battle) stay as they are: the third comes from the species, through GetThirdType (home), so a
; save holds nothing new, and a TRANSFORM, which copies the species, copies it too.
;
; Only FLYING and POISON may be a third type. The chart, STAB and the AI read any third type, but of the
; rules that hang on a type only POISON's (a POISON or STEEL #MON is never poisoned: PoisonEffect,
; CheckStatusImmunity) reads it; FLYING has no such rule. A third ELECTRIC, FIRE, ICE, MAGMA, GRASS or
; GROUND would first need paralysis, burn, freeze and LEECH SEED taught to read it.

MACRO third_type
	ASSERT \2 == FLYING || \2 == POISON, "\1: a third type other than FLYING or POISON needs the status rules taught first"
	db \1, \2
ENDM

ThirdTypes:
	third_type BUTTERFREE, FLYING ; BUG/PSYCHIC/FLYING
	third_type BEEDRILL,   FLYING ; BUG/POISON/FLYING
	third_type VENOMOTH,   FLYING ; BUG/POISON/FLYING
	third_type GASTLY,     POISON ; GHOST/GAS/POISON (GHOST/POISON in every official game)
	third_type HAUNTER,    POISON ; GHOST/GAS/POISON
	third_type GENGAR,     POISON ; GHOST/DARK/POISON
	db -1 ; end
