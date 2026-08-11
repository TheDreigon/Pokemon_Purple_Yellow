	db DEX_GOLBAT ; pokedex id
	base_stat_row 65, 80, 65, 70, 110 ; hp atk def spc spd

	db POISON, FLYING ; type
	db 80 ; catch rate  ; final stage, BST 390
	db 150 ; base exp  ; BST 390 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/golbat.pic", 0, 1 ; sprite dimensions
	dw GolbatPicFront, GolbatPicBack

	db BITE, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Matured vampire bat (last-stage). HM CUT/FLY.
	; Fun moves (last-stage): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, AGILITY, POISON_BITE, AERIAL_ACE, HURRICANE, \
	     TOXIC, INTIMIDATE, LEECH_LIFE, DARK_PULSE, CUT, \
	     FLY
	; end

	db BANK(GolbatPicFront) ; which bank this mon's pics live in
	assert BANK(GolbatPicFront) == BANK(GolbatPicBack), \
	    "Golbat: front and back pics must share a bank"
