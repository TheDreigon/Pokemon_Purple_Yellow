	db DEX_BLASTOISE ; pokedex id
	base_stat_row 90, 85, 110, 95, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/blastoise.pic", 0, 1 ; sprite dimensions
	dw BlastoisePicFront, BlastoisePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water-tank apex. Water STAB WATER_PULSE/SURF, pressure-cannon
	; ICE_BEAM/ICY_PULSE. Heavy shell BODY_SLAM/BULK_UP/IRON_HEAD,
	; weight EARTHQUAKE/BULLDOZE. HM CUT/SURF/STRENGTH. Fun moves:
	; last-stage line. Ladder prereq: ROCK_THROW.
	tmhm BULLDOZE, WATER_PULSE, ICY_PULSE, BODY_SLAM, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     INTIMIDATE, TAKE_DOWN, LIGHT_SCREEN, ICE_BEAM, REFLECT, \
	     EARTHQUAKE, DOUBLE_EDGE, CUT, SURF, STRENGTH, \
	     ROCK_THROW, SEISMIC_TOSS
	; end

	db 0 ; padding
