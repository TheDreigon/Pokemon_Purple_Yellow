	db DEX_WIGGLYTUFF ; pokedex id
	base_stat_row 140, 70, 40, 70, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 90 ; catch rate  ; final stage, BST 390, easy to approach
	db 109 ; base exp

	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Normal/Fairy balloon singer. Sound and fairy moves, charm
	; tricks and psychic flair. Buoyant enough to fly. Fun moves
	; (last-stage).
	tmhm RAGE, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, \
	     PSYCHIC_M, DOUBLE_EDGE, FLY
	; end

	db BANK(WigglytuffPicFront) ; which bank this mon's pics live in
	assert BANK(WigglytuffPicFront) == BANK(WigglytuffPicBack), \
	    "Wigglytuff: front and back pics must share a bank"
