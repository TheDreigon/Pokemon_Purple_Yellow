	db DEX_MUK ; pokedex id
	base_stat_row 125, 95, 75, 95, 40 ; hp atk def spc spd
	db POISON, WATER ; type
	db 60 ; catch rate  ; set by hand: level with Weezing; his 2026-08-10 stat pass
	db 157 ; base exp

	INCBIN "gfx/pokemon/front/muk.pic", 0, 1 ; sprite dimensions
	dw MukPicFront, MukPicBack

	db LICK, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex sludge blob, Poison/Water. Last-stage fun moves allowed.
	tmhm BIND, BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, TOXIC, SCARY_FACE, TAKE_DOWN, \
	     EARTHQUAKE, DOUBLE_EDGE, THRASH, STRENGTH, ROCK_THROW
	; end

	db BANK(MukPicFront) ; which bank this mon's pics live in
	assert BANK(MukPicFront) == BANK(MukPicBack), \
	    "Muk: front and back pics must share a bank"
