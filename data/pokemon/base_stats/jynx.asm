	db DEX_JYNX ; pokedex id
	base_stat_row 65, 60, 50, 110, 95 ; hp atk def spc spd
	db GHOST, ICE ; type
	db 45 ; catch rate
	db 137 ; base exp

	INCBIN "gfx/pokemon/front/jynx.pic", 0, 1 ; sprite dimensions
	dw JynxPicFront, JynxPicBack

	db DOUBLESLAP, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Ghost/Ice Fairy-coded singer, single-stage psychic
	; special attacker. auto
	; ICY_PULSE/NIGHT_SHADE/CHARM/EXTRASENSORY/LIGHT_SCREEN/ICE_BEAM/DARK_PULSE/SHADOW_BALL.
	; bonus
	; CONFUSE_RAY/DAZZLE_GLEAM/FAKE_TEARS/SCARY_FACE/PSYCHIC_M/REFLECT/CALM_MIND.
	; HM FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ICY_PULSE, NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, DAZZLE_GLEAM, FAKE_TEARS, CHARM, \
	     EXTRASENSORY, SCARY_FACE, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, \
	     DARK_PULSE, SHADOW_BALL, REFLECT, CALM_MIND, FLASH
	; end

	db 0 ; padding
