	db DEX_BEEDRILL ; pokedex id
	base_stat_row 65, 95, 65, 60, 90 ; hp atk def spc spd

	db BUG, POISON ; type
	db 45 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/beedrill.pic", 0, 1 ; sprite dimensions
	dw BeedrillPicFront, BeedrillPicBack

	db POISON_STING, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Warrior drill-bee. Aggressive RAGE/THRASH/OUTRAGE/SWORDS_DANCE,
	; agile QUICK_ATTACK/AGILITY/AERIAL_ACE. Stinger POISON_BITE/TOXIC,
	; LEECH_LIFE drain. HM FLY. Fun moves: last-stage line.
	tmhm QUICK_ATTACK, RAGE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, POISON_BITE, AERIAL_ACE, TOXIC, \
	     INTIMIDATE, LEECH_LIFE, TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, \
	     THRASH, OUTRAGE, FLY
	; end

	db 0 ; padding
