	db DEX_RHYDON ; pokedex id
	base_stat_row 95, 120, 110, 65, 50 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 60 ; catch rate  ; set by hand
	db 180 ; base exp  ; BST 440 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/rhydon.pic", 0, 1 ; sprite dimensions
	dw RhydonPicFront, RhydonPicBack

	db LEER, GROUND_STOMP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Ground/Rock rhinoceros bruiser. The horn justifies MEGAHORN.
	; Massive frame learns HM STRENGTH; ROCK_THROW from forelimbs.
	tmhm ROCK_THROW, BULLDOZE, RAGE, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     MEGAHORN, INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, THRASH, STRENGTH, \
	     OUTRAGE, SEISMIC_TOSS, DRAGON_CLAW, CUT
	; end

	db BANK(RhydonPicFront) ; which bank this mon's pics live in
	assert BANK(RhydonPicFront) == BANK(RhydonPicBack), \
	    "Rhydon: front and back pics must share a bank"
