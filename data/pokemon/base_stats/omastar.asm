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
	; Apex spiral-shell ammonite Rock/Water. HM SURF/STRENGTH.
	; Last-stage fun moves via TM.
	tmhm ROCK_THROW, BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     TAKE_DOWN, ICE_BEAM, ROCK_SLIDE, DOUBLE_EDGE, SURF, \
	     STRENGTH
	; end

	db 0 ; padding
