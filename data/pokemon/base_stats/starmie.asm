	db DEX_STARMIE ; pokedex id
	base_stat_row 60, 75, 90, 100, 100 ; hp atk def spc spd

	db WATER, PSYCHIC_TYPE ; type
	db 60 ; catch rate
	db 207 ; base exp

	INCBIN "gfx/pokemon/front/starmie.pic", 0, 1 ; sprite dimensions
	dw StarmiePicFront, StarmiePicBack

	db TACKLE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Water/Psychic mystic gem-core star (last). auto
	; QUICK_ATTACK/WATER_PULSE/DAZZLE_GLEAM/PSYCHIC_M/LIGHT_SCREEN/CALM_MIND/SURF/FLASH.
	; bonus EXTRASENSORY/ICE_BEAM/REFLECT/THUNDERBOLT. HM SURF/FLASH.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, WATER_PULSE, ICY_PULSE, SHOCK_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, THUNDERBOLT, \
	     CALM_MIND, SURF, FLASH
	; end

	db 0 ; padding
