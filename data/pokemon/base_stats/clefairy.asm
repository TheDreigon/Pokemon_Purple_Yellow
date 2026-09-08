	db DEX_CLEFAIRY ; pokedex id
	base_stat_row 80, 40, 50, 75, 70, 50 ; hp atk def spatk spdef spd
	db FAIRY, FAIRY ; type
	db 220 ; catch rate  ; base stage, BST 365, easy to approach
	db 110 ; base exp  ; BST 365

	INCBIN "gfx/pokemon/front/clefairy.pic", 0, 1 ; sprite dimensions
	dw ClefairyPicFront, ClefairyPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mystical moon-fairy pre-evo. Fairy/psychic kit
	; (DAZZLE_GLEAM/CHARM/FAKE_TEARS/EXTRASENSORY/PSYCHIC_M), screens
	; (LIGHT_SCREEN/REFLECT/CALM_MIND), BODY_SLAM. 2 fun moves
	; (MIMIC/METRONOME).
	tmhm BODY_SLAM, MIMIC, METRONOME, DAZZLE_GLEAM, FAKE_TEARS, \
	     CHARM, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, REFLECT, \
	     CALM_MIND, FLASH
	; end

	db BANK(ClefairyPicFront) ; which bank this mon's pics live in
	assert BANK(ClefairyPicFront) == BANK(ClefairyPicBack), \
	    "Clefairy: front and back pics must share a bank"
