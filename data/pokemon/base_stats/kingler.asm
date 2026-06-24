	db DEX_KINGLER ; pokedex id
	base_stat_row 60, 110, 110, 70, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 60 ; catch rate
	db 206 ; base exp

	INCBIN "gfx/pokemon/front/kingler.pic", 0, 1 ; sprite dimensions
	dw KinglerPicFront, KinglerPicBack

	db WATER_GUN, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex crusher crab (110 Atk/Def). Giant pincer drives
	; BIND/SEISMIC_TOSS/SWORDS_DANCE/CUT/STRENGTH; aquatic
	; WATER_PULSE/SURF/ICE_BEAM.
	; Last-stage fun moves MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, WATER_PULSE, ICY_PULSE, SEISMIC_TOSS, BODY_SLAM, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, ICE_BEAM, \
	     SWORDS_DANCE, CUT, SURF, STRENGTH, ROCK_THROW
	; end

	db 0 ; padding
