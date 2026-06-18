	db DEX_BEEDRILL ; pokedex id
	base_stat_row 65, 95, 65, 60, 90 ; hp atk def spc spd

	db BUG, POISON ; type
	db 45 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/beedrill.pic", 0, 1 ; sprite dimensions
	dw BeedrillPicFront, BeedrillPicBack

	db POISON_STING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: warrior drill-bee, deepest movepool of the line. auto
	; QUICK_ATTACK/RAGE/AGILITY/AERIAL_ACE/INTIMIDATE/DOUBLE_EDGE/OUTRAGE.
	; bonus POISON_BITE/TOXIC/LEECH_LIFE/TAKE_DOWN. HM FLY. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, RAGE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, POISON_BITE, AERIAL_ACE, TOXIC, \
	     INTIMIDATE, LEECH_LIFE, TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, \
	     THRASH, OUTRAGE, FLY
	; end

	db 0 ; padding
