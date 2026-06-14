	db DEX_PRIMEAPE ; pokedex id
	base_stat_row 80, 110, 65, 60, 95 ; hp atk def spc spd
	db FIGHTING, DARK ; type
	db 75 ; catch rate
	db 149 ; base exp

	INCBIN "gfx/pokemon/front/primeape.pic", 0, 1 ; sprite dimensions
	dw PrimeapePicFront, PrimeapePicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex rage-monkey, identidade de lutador
	; grappler/setup. auto
	; ROCK_THROW/QUICK_ATTACK/RAGE/BODY_SLAM/BULK_UP/INTIMIDATE/TAKE_DOWN/SWORDS_DANCE/THRASH/OUTRAGE.
	; bonus BIND/BULLDOZE/SEISMIC_TOSS/DOUBLE_EDGE. HM STRENGTH. fun (4
	; via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, BULLDOZE, SEISMIC_TOSS, \
	     RAGE, BODY_SLAM, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, INTIMIDATE, TAKE_DOWN, SWORDS_DANCE, \
	     DOUBLE_EDGE, THRASH, OUTRAGE, STRENGTH
	; end

	db 0 ; padding
