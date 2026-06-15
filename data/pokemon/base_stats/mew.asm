	db DEX_MEW ; pokedex id
	base_stat_row 140, 80, 80, 120, 140 ; hp atk def spc spd
	db PSYCHIC_TYPE, FAIRY ; type
	db 45 ; catch rate
	db 64 ; base exp

	INCBIN "gfx/pokemon/front/mew.pic", 0, 1 ; sprite dimensions
	dw MewPicFront, MewPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: ancestral curioso/transformista que aprende quase
	; tudo — o mais generoso. auto
	; QUICK_ATTACK/MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME/DAZZLE_GLEAM/AGILITY/CHARM/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/REFLECT/CALM_MIND.
	; bonus FAINT_ATTACK/FAKE_TEARS/ICE_BEAM/FLAMETHROWER/THUNDERBOLT.
	; HM FLY/SURF/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, WATER_PULSE, ICY_PULSE, FLAME_BURST, \
	     SHOCK_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, AGILITY, FAKE_TEARS, CHARM, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, FLAMETHROWER, REFLECT, \
	     THUNDERBOLT, CALM_MIND, FLY, SURF, FLASH
	; end

	db 0 ; padding
