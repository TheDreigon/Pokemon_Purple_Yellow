	db DEX_SANDSLASH ; pokedex id
	base_stat_row 70, 110, 110, 55, 65 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 90 ; catch rate
	db 163 ; base exp

	INCBIN "gfx/pokemon/front/sandslash.pic", 0, 1 ; sprite dimensions
	dw SandslashPicFront, SandslashPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex armoured spiked digger with long claws. auto
	; BULLDOZE/EARTHQUAKE/ROCK_SLIDE/CUT. bonus
	; ROCK_THROW/BODY_SLAM/IRON_TAIL/IRON_HEAD/DRAGON_CLAW/TAKE_DOWN/SWORDS_DANCE/DOUBLE_EDGE.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, IRON_TAIL, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, DRAGON_CLAW, \
	     TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, \
	     CUT, STRENGTH
	; end

	db 0 ; padding
