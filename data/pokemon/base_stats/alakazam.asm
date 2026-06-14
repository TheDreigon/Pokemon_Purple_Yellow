	db DEX_ALAKAZAM ; pokedex id
	base_stat_row 55, 50, 45, 135, 125 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 50 ; catch rate
	db 186 ; base exp

	INCBIN "gfx/pokemon/front/alakazam.pic", 0, 1 ; sprite dimensions
	dw AlakazamPicFront, AlakazamPicBack

	db TELEPORT, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex mago psychic, movepool largo coerente com
	; inteligencia maxima. auto
	; SHOCK_WAVE/METRONOME/AGILITY/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/DARK_PULSE/REFLECT/CALM_MIND.
	; bonus DAZZLE_GLEAM/FAKE_TEARS/SHADOW_BALL. HM FLASH. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SHOCK_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, AGILITY, FAKE_TEARS, EXTRASENSORY, PSYCHIC_M, \
	     LIGHT_SCREEN, DARK_PULSE, SHADOW_BALL, REFLECT, CALM_MIND, \
	     FLASH
	; end

	db 0 ; padding
