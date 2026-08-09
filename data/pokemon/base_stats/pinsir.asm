	db DEX_PINSIR ; pokedex id
	base_stat_row 70, 115, 100, 55, 70 ; hp atk def spc spd
	db BUG, FIGHTING ; type
	db 70 ; catch rate  ; solo stage, BST 410, harder to handle
	db 200 ; base exp

	INCBIN "gfx/pokemon/front/pinsir.pic", 0, 1 ; sprite dimensions
	dw PinsirPicFront, PinsirPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Stag-beetle pincer-BRUTE; force/grapple identity vs Scyther's
	; blade. BIND/SEISMIC_TOSS/BODY_SLAM/BULK_UP/MEGAHORN/TAKE_DOWN/
	; DOUBLE_EDGE/THRASH plus IRON_HEAD/INTIMIDATE/SCARY_FACE/
	; SWORDS_DANCE/EARTHQUAKE/ROCK_SLIDE + ladder prereqs
	; ROCK_THROW/BULLDOZE. HM CUT/STRENGTH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BIND, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     IRON_HEAD, MEGAHORN, INTIMIDATE, SCARY_FACE, TAKE_DOWN, \
	     SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, THRASH, \
	     CUT, STRENGTH
	; end

	db BANK(PinsirPicFront) ; which bank this mon's pics live in
	assert BANK(PinsirPicFront) == BANK(PinsirPicBack), \
	    "Pinsir: front and back pics must share a bank"
