	db DEX_STARMIE ; pokedex id
	base_stat_row 60, 75, 90, 100, 100 ; hp atk def spc spd

	db WATER, PSYCHIC_TYPE ; type
	db 70 ; catch rate  ; final stage, BST 425
	db 170 ; base exp  ; BST 425 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/starmie.pic", 0, 1 ; sprite dimensions
	dw StarmiePicFront, StarmiePicBack

	db TACKLE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water/Psychic mystic gem-core star (last). Glowing core drives
	; DAZZLE_GLEAM/FLASH. Ladder prereqs: WATER_PULSE, ICY_PULSE,
	; SHOCK_WAVE, EXTRASENSORY.
	tmhm QUICK_ATTACK, WATER_PULSE, ICY_PULSE, SHOCK_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, THUNDERBOLT, \
	     CALM_MIND, SURF, FLASH
	; end

	db BANK(StarmiePicFront) ; which bank this mon's pics live in
	assert BANK(StarmiePicFront) == BANK(StarmiePicBack), \
	    "Starmie: front and back pics must share a bank"
