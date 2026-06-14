	db DEX_GENGAR ; pokedex id
	base_stat_row 65, 90, 65, 120, 110 ; hp atk def spc spd
	db GHOST, DARK ; type
	db 45 ; catch rate
	db 190 ; base exp

	INCBIN "gfx/pokemon/front/gengar.pic", 0, 1 ; sprite dimensions
	dw GengarPicFront, GengarPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Gengar = GOLD STANDARD (Ghost/Dark, final). auto
	; FAINT_ATTACK/NIGHT_SHADE/CONFUSE_RAY/TOXIC/EXTRASENSORY/INTIMIDATE/SCARY_FACE/PSYCHIC_M/DARK_PULSE/SHADOW_BALL.
	; bonus POISON_FANG/LIGHT_SCREEN/ICE_BEAM/REFLECT. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm FAINT_ATTACK, NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, POISON_FANG, TOXIC, EXTRASENSORY, \
	     INTIMIDATE, SCARY_FACE, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, \
	     DARK_PULSE, SHADOW_BALL, REFLECT
	; end

	db 0 ; padding
