	db DEX_BEEDRILL ; pokedex id
	base_stat_row 65, 95, 65, 60, 90 ; hp atk def spc spd

	db BUG, POISON ; type
	db 45 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/beedrill.pic", 0, 1 ; sprite dimensions
	dw BeedrillPicFront, BeedrillPicBack

	db TWINEEDLE, POISON_STING, FURY_ATTACK, AGILITY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte's favorite): 11 warrior-bee additions. Outrage TM
	; per Forte. Levelup-doubles for Leech Life, Hone Claws, Agility, Quick
	; Attack, Aerial Ace, Intimidate, Double Edge. HM02 Fly per Forte's
	; HM-Fly list. Drill Peck and Extreme Speed levelup-only (no TMs in
	; this hack). NO fun moves (per Forte's revised rule — bee not a
	; mind-mimic, no silk-decoy capability after metamorphosis, not magical).
	tmhm LEECH_LIFE,   AGILITY,      TOXIC,        DOUBLE_EDGE,  TAKE_DOWN, \
	     AERIAL_ACE,   INTIMIDATE,   QUICK_ATTACK, OUTRAGE,      FLY
	; end

	db 0 ; padding
