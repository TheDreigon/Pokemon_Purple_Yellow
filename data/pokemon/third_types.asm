; v1.0 (2026-11-02): the #MON with a third type, Forte's list. The two types every struct keeps (base stats,
; party, box, battle) stay as they are: the third comes from the species, through GetThirdType (home), so a
; save holds nothing new, and a TRANSFORM, which copies the species, copies it too.
;
; The chart, STAB and the AI read any third type; the table accepts the types whose rules read it too. Of the
; rules that hang on a type, POISON's (a POISON or STEEL #MON is never poisoned: PoisonEffect,
; CheckStatusImmunity) and, since 2026-11-07, GRASS's (LEECH SEED never seeds a GRASS #MON: LeechSeedEffect_
; and the AI's .checkSeeded) read it; FLYING, DRAGON, NORMAL, PSYCHIC, FAIRY, GHOST and WATER have no such rule
; (nothing in the engine tests for them). A third ELECTRIC, FIRE, ICE, MAGMA or GROUND would first need
; paralysis, burn and freeze taught to read it.

MACRO third_type
	ASSERT \2 == FLYING || \2 == POISON || \2 == DRAGON || \2 == GRASS || \2 == NORMAL || \2 == PSYCHIC_TYPE || \2 == FAIRY || \2 == GHOST || \2 == WATER, "\1: this third type needs its status rules taught first"
	db \1, \2
ENDM

ThirdTypes:
	third_type CHARIZARD,  DRAGON       ; FIRE/FLYING/DRAGON (2026-11-07)
	third_type NINETALES,  GHOST        ; FIRE/FAIRY/GHOST (2026-11-07: the kitsune, its 1,000-year curse)
	third_type PARASECT,   GRASS        ; BUG/FUNGUS/GRASS (2026-11-07)
	third_type FARFETCHD,  NORMAL       ; FIGHTING/FLYING/NORMAL (2026-11-07), and GROUNDED
	third_type JYNX,       PSYCHIC_TYPE ; GHOST/ICE/PSYCHIC (2026-11-07), and AIRBORNE
	third_type STARYU,     FAIRY        ; WATER/PSYCHIC/FAIRY (2026-11-07)
	third_type STARMIE,    FAIRY        ; WATER/PSYCHIC/FAIRY (2026-11-07)
	third_type KABUTO,     WATER        ; ROCK/BUG/WATER (2026-11-07: it hides on the sea floor)
	third_type KABUTOPS,   WATER        ; ROCK/BUG/WATER (2026-11-07: a fast swimmer)
	third_type BUTTERFREE, FLYING ; BUG/PSYCHIC/FLYING
	third_type BEEDRILL,   FLYING ; BUG/POISON/FLYING
	third_type VENOMOTH,   FLYING ; BUG/POISON/FLYING
	third_type GASTLY,     POISON ; GHOST/GAS/POISON (GHOST/POISON in every official game)
	third_type HAUNTER,    POISON ; GHOST/GAS/POISON
	third_type GENGAR,     POISON ; GHOST/DARK/POISON
	db -1 ; end
