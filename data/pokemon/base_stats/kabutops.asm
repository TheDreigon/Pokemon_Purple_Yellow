	db DEX_KABUTOPS ; pokedex id
	base_stat_row 75, 115, 110, 80, 80 ; hp atk def spc spd
	db ROCK, BUG ; type
	db 60 ; catch rate  ; set by hand: level with Aerodactyl
	db 201 ; base exp

	INCBIN "gfx/pokemon/front/kabutops.pic", 0, 1 ; sprite dimensions
	dw KabutopsPicFront, KabutopsPicBack

	db SCRATCH, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex aquatic slasher fossil (Rock/Bug). Scythe arms power
	; SWORDS_DANCE/CUT/DRAGON_CLAW. Cold-sea ICY_PULSE/ICE_BEAM.
	; Last-stage fun moves MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DRAGON_CLAW, LEECH_LIFE, \
	     TAKE_DOWN, ICE_BEAM, SWORDS_DANCE, ROCK_SLIDE, DOUBLE_EDGE, \
	     CUT, SURF, STRENGTH, IRON_HEAD
	; end

	db BANK(KabutopsPicFront) ; which bank this mon's pics live in
	assert BANK(KabutopsPicFront) == BANK(KabutopsPicBack), \
	    "Kabutops: front and back pics must share a bank"
