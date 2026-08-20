	db DEX_ARTICUNO ; pokedex id
	base_stat_row 100, 90, 100, 130, 100 ; hp atk def spc spd

	db ICE, FLYING ; type
	db 11 ; catch rate  ; exception: legendary: one in the world, and ICE cannot be frozen
	db 250 ; base exp  ; trio dos passaros lendarios

	INCBIN "gfx/pokemon/front/articuno.pic", 0, 1 ; sprite dimensions
	dw ArticunoPicFront, ArticunoPicBack

	db PECK, POWDER_SNOW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; Legendary ice raptor. Ladder prereq: ICY_PULSE.
	tmhm ICY_PULSE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, SCARY_FACE, \
	     TAKE_DOWN, LIGHT_SCREEN, ICE_BEAM, REFLECT, SWORDS_DANCE, \
	     CALM_MIND, ROCK_SLIDE, DOUBLE_EDGE, CUT, FLY, \
	     FLASH
	; end

	db BANK(ArticunoPicFront) ; which bank this mon's pics live in
	assert BANK(ArticunoPicFront) == BANK(ArticunoPicBack), \
	    "Articuno: front and back pics must share a bank"
