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
	; v0.7 Pass 3: apex Water/Fighting boxer-frog. auto
	; WATER_PULSE/SEISMIC_TOSS/BODY_SLAM/BULK_UP/TAKE_DOWN/DOUBLE_EDGE/SURF/STRENGTH.
	; bonus ICE_BEAM/EARTHQUAKE. HM SURF/STRENGTH. fun (4 via TM, regra
	; global last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, SEISMIC_TOSS, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, TAKE_DOWN, ICE_BEAM, \
	     EARTHQUAKE, DOUBLE_EDGE, SURF, STRENGTH
	; end

	db 0 ; padding
