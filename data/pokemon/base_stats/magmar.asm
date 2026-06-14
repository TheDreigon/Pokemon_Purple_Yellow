	db DEX_MAGMAR ; pokedex id
	base_stat_row 75, 95, 75, 95, 85 ; hp atk def spc spd
	db FIRE, MAGMA ; type
	db 45 ; catch rate
	db 167 ; base exp

	INCBIN "gfx/pokemon/front/magmar.pic", 0, 1 ; sprite dimensions
	dw MagmarPicFront, MagmarPicBack

	db EMBER, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Magmar, boxer Fire/Magma vulcanico (counterpart de
	; Electabuzz). auto
	; SEISMIC_TOSS/BODY_SLAM/FLAME_BURST/CONFUSE_RAY/IGNITE/LIGHT_SCREEN/FLAMETHROWER/ROCK_SLIDE.
	; bonus BULLDOZE/TAKE_DOWN/EARTHQUAKE/DOUBLE_EDGE. HM
	; CUT/STRENGTH/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BULLDOZE, SEISMIC_TOSS, BODY_SLAM, FLAME_BURST, CONFUSE_RAY, \
	     IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     TAKE_DOWN, LIGHT_SCREEN, FLAMETHROWER, EARTHQUAKE, ROCK_SLIDE, \
	     DOUBLE_EDGE, CUT, STRENGTH, FLASH
	; end

	db 0 ; padding
