	db DEX_KABUTOPS ; pokedex id
	base_stat_row 75, 115, 110, 80, 80 ; hp atk def spc spd
	db ROCK, BUG ; type
	db 45 ; catch rate
	db 201 ; base exp

	INCBIN "gfx/pokemon/front/kabutops.pic", 0, 1 ; sprite dimensions
	dw KabutopsPicFront, KabutopsPicBack

	db SCRATCH, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex aquatic slasher fossil (Rock/Bug here). auto
	; ROCK_THROW/ICY_PULSE/LEECH_LIFE/SWORDS_DANCE/CUT. bonus
	; WATER_PULSE/BODY_SLAM/DRAGON_CLAW/TAKE_DOWN/ICE_BEAM/ROCK_SLIDE/DOUBLE_EDGE.
	; HM CUT/SURF/STRENGTH. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DRAGON_CLAW, LEECH_LIFE, \
	     TAKE_DOWN, ICE_BEAM, SWORDS_DANCE, ROCK_SLIDE, DOUBLE_EDGE, \
	     CUT, SURF, STRENGTH
	; end

	db 0 ; padding
