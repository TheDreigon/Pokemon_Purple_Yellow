	db DEX_DRAGONITE ; pokedex id
	base_stat_row 110, 115, 80, 110, 85 ; hp atk def spc spd
	db DRAGON, DRAGON ; type
	db 20 ; catch rate  ; exception: same line; vanilla 9 was near-impossible, this is hard
	db 230 ; base exp  ; escolha dele

	INCBIN "gfx/pokemon/front/dragonite.pic", 0, 1 ; sprite dimensions
	dw DragonitePicFront, DragonitePicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Dragon with a vast movepool. HM CUT/FLY/SURF/STRENGTH. Fun
	; moves (last-stage) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME. Ladder
	; prereqs: ROCK_THROW, BULLDOZE, WATER_PULSE, ICY_PULSE, FLAME_BURST,
	; SHOCK_WAVE, EXTRASENSORY.
	tmhm ROCK_THROW, BIND, BULLDOZE, WATER_PULSE, ICY_PULSE, \
	     BODY_SLAM, FLAME_BURST, SHOCK_WAVE, IRON_TAIL, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, SEISMIC_TOSS, \
	     IRON_HEAD, AERIAL_ACE, HURRICANE, DRAGON_CLAW, EXTRASENSORY, \
	     INTIMIDATE, TAKE_DOWN, ICE_BEAM, FLAMETHROWER, THUNDERBOLT, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, THRASH, OUTRAGE, \
	     CUT, FLY, SURF, STRENGTH
	; end

	db BANK(DragonitePicFront) ; which bank this mon's pics live in
	assert BANK(DragonitePicFront) == BANK(DragonitePicBack), \
	    "Dragonite: front and back pics must share a bank"
