	db DEX_KANGASKHAN ; pokedex id
	base_stat_row 105, 85, 80, 50, 80 ; hp atk def spc spd
	db NORMAL, FIGHTING ; type
	db 75 ; catch rate  ; solo stage, BST 400, harder to handle
	db 175 ; base exp

	INCBIN "gfx/pokemon/front/kangaskhan.pic", 0, 1 ; sprite dimensions
	dw KangaskhanPicFront, KangaskhanPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Protective kangaroo mother, Normal/Fighting bruiser with fists +
	; tail. BULK_UP/SEISMIC_TOSS/THRASH from raw power; IRON_TAIL and
	; EARTHQUAKE/BULLDOZE from the heavy tail; ROCK_THROW too;
	; INTIMIDATE as a mother.
	; Last-stage fun moves MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, IRON_TAIL, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     INTIMIDATE, TAKE_DOWN, EARTHQUAKE, THRASH, STRENGTH, \
	     ROCK_THROW, CUT, ROCK_SLIDE
	; end

	db BANK(KangaskhanPicFront) ; which bank this mon's pics live in
	assert BANK(KangaskhanPicFront) == BANK(KangaskhanPicBack), \
	    "Kangaskhan: front and back pics must share a bank"
