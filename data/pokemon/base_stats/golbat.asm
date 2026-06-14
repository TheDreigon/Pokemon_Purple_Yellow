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
	; v0.7 Pass 3: matured vampire bat (last-stage). auto
	; QUICK_ATTACK/AGILITY/POISON_FANG/AERIAL_ACE/TOXIC/LEECH_LIFE/DARK_PULSE/FLY.
	; bonus GIGA_DRAIN/HURRICANE/INTIMIDATE. HM CUT/FLY. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, AGILITY, POISON_FANG, AERIAL_ACE, HURRICANE, \
	     TOXIC, INTIMIDATE, LEECH_LIFE, DARK_PULSE, CUT, \
	     FLY
	; end

	db 0 ; padding
