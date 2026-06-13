	db DEX_GOLBAT ; pokedex id
	base_stat_row 65, 80, 65, 70, 110 ; hp atk def spc spd

	db POISON, FLYING ; type
	db 90 ; catch rate
	db 171 ; base exp

	INCBIN "gfx/pokemon/front/golbat.pic", 0, 1 ; sprite dimensions
	dw GolbatPicFront, GolbatPicBack

	db BITE, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: matured vampire bat. Zubat's 7 + 4 apex additions:
	; Hurricane TM (per Forte #16 — TM only, NOT levelup), Giga Drain TM
	; (per Forte #17 — vampire-bat mass-drain via fangs), Intimidate (big
	; bat scary), HM02 Fly (Forte's natural list — Golbat only).
	tmhm QUICK_ATTACK, LEECH_LIFE,   POISON_FANG,  AERIAL_ACE,   TOXIC, \
	     AGILITY,      CUT,          GIGA_DRAIN,   HURRICANE,    INTIMIDATE, \
	     FLY,          MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
