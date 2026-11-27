	db DEX_TANGROWTH ; pokedex id
	base_stat_row 100, 80, 120, 90, 90, 40 ; hp atk def spatk spdef spd

	db GRASS, WATER ; type
	db 65 ; catch rate  ; final stage, BST 520
	db 165 ; base exp  ; BST 520

	INCBIN "gfx/pokemon/front/tangrowth.pic", 0, 1 ; sprite dimensions
	dw TangrowthPicFront, TangrowthPicBack

	db CONSTRICT, HINDER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v1.0 (2026-11-26): TANGELA's evolution at L35, the second species past the
	; 151. TANGELA's machines and the four fun moves of a last stage, which
	; TANGELA gave up to it. HM CUT/SURF.
	tmhm BIND, WATER_PULSE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, GIGA_DRAIN, LEECH_LIFE, PETAL_DANCE, \
	     CUT, SURF
	; end

	db BANK(TangrowthPicFront) ; which bank this mon's pics live in
	assert BANK(TangrowthPicFront) == BANK(TangrowthPicBack), \
	    "Tangrowth: front and back pics must share a bank"
