	db DEX_PRIMEAPE ; pokedex id
	base_stat_row 80, 110, 65, 60, 95 ; hp atk def spc spd
	db FIGHTING, DARK ; type
	db 60 ; catch rate  ; final stage, BST 410, harder to handle
	db 160 ; base exp  ; BST 410

	INCBIN "gfx/pokemon/front/primeape.pic", 0, 1 ; sprite dimensions
	dw PrimeapePicFront, PrimeapePicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex rage-monkey, grappler/setup fighter identity:
	; ROCK_THROW/QUICK_ATTACK/RAGE/BODY_SLAM/BULK_UP/INTIMIDATE/
	; TAKE_DOWN/SWORDS_DANCE/THRASH/OUTRAGE plus
	; BIND/BULLDOZE/SEISMIC_TOSS/DOUBLE_EDGE/ROCK_SLIDE. HM CUT/STRENGTH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, BULLDOZE, SEISMIC_TOSS, \
	     RAGE, BODY_SLAM, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, INTIMIDATE, TAKE_DOWN, SWORDS_DANCE, \
	     DOUBLE_EDGE, THRASH, OUTRAGE, STRENGTH, CUT, \
	     ROCK_SLIDE
	; end

	db BANK(PrimeapePicFront) ; which bank this mon's pics live in
	assert BANK(PrimeapePicFront) == BANK(PrimeapePicBack), \
	    "Primeape: front and back pics must share a bank"
