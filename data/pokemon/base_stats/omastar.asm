	db DEX_OMASTAR ; pokedex id
	base_stat_row 80, 90, 120, 100, 60 ; hp atk def spc spd

	db ROCK, WATER ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/omastar.pic", 0, 1 ; sprite dimensions
	dw OmastarPicFront, OmastarPicBack

	db WATER_GUN, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex spiral-shell ammonite Water/Rock. auto
	; ROCK_THROW/BIND/WATER_PULSE/ICY_PULSE/IRON_HEAD/ICE_BEAM. bonus
	; BODY_SLAM/TAKE_DOWN/ROCK_SLIDE/DOUBLE_EDGE. HM SURF/STRENGTH. fun
	; (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     TAKE_DOWN, ICE_BEAM, ROCK_SLIDE, DOUBLE_EDGE, SURF, \
	     STRENGTH
	; end

	db 0 ; padding
