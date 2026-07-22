	db DEX_POLIWRATH ; pokedex id
	base_stat_row 90, 95, 80, 85, 75 ; hp atk def spc spd

	db WATER, FIGHTING ; type
	db 45 ; catch rate
	db 185 ; base exp

	INCBIN "gfx/pokemon/front/poliwrath.pic", 0, 1 ; sprite dimensions
	dw PoliwrathPicFront, PoliwrathPicBack

	db DOUBLESLAP, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Water/Fighting boxer-frog:
	; WATER_PULSE/SEISMIC_TOSS/BODY_SLAM/BULK_UP/TAKE_DOWN/ROCK_THROW/
	; DOUBLE_EDGE/SURF plus ICE_BEAM/EARTHQUAKE/ROCK_SLIDE + ladder
	; prereqs BULLDOZE/ICY_PULSE. HM SURF/STRENGTH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BULLDOZE, WATER_PULSE, ICY_PULSE, SEISMIC_TOSS, BODY_SLAM, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     TAKE_DOWN, ROCK_THROW, ICE_BEAM, EARTHQUAKE, DOUBLE_EDGE, \
	     SURF, STRENGTH, ROCK_SLIDE
	; end

	db 0 ; padding
