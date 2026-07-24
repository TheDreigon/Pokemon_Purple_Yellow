	db DEX_MAGMAR ; pokedex id
	base_stat_row 75, 95, 80, 95, 85 ; hp atk def spc spd
	db FIRE, MAGMA ; type
	db 45 ; catch rate
	db 167 ; base exp

	INCBIN "gfx/pokemon/front/magmar.pic", 0, 1 ; sprite dimensions
	dw MagmarPicFront, MagmarPicBack

	db EMBER, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Volcanic Fire/Magma boxer, counterpart to Electabuzz. Last-stage
	; fun moves allowed.
	; Ladder prereqs: ROCK_THROW, BULLDOZE, FLAME_BURST.
	tmhm ROCK_THROW, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, FLAME_BURST, \
	     CONFUSE_RAY, IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, TAKE_DOWN, LIGHT_SCREEN, FLAMETHROWER, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, CUT, STRENGTH, FLASH
	; end

	db 0 ; padding
