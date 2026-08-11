	db DEX_KADABRA ; pokedex id
	base_stat_row 40, 35, 30, 115, 105 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 115 ; catch rate  ; mid stage, BST 325
	db 110 ; base exp  ; BST 325

	INCBIN "gfx/pokemon/front/kadabra.pic", 0, 1 ; sprite dimensions
	dw KadabraPicFront, KadabraPicBack

	db TELEPORT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-evo psychic conjurer. Full psychic suite:
	; EXTRASENSORY/PSYCHIC_M/CALM_MIND/LIGHT_SCREEN/REFLECT/AGILITY.
	; SHOCK_WAVE/DAZZLE_GLEAM as projected energy. FLASH from the spoon.
	tmhm SHOCK_WAVE, DAZZLE_GLEAM, AGILITY, EXTRASENSORY, PSYCHIC_M, \
	     LIGHT_SCREEN, SHADOW_BALL, REFLECT, CALM_MIND, FLASH
	; end

	db BANK(KadabraPicFront) ; which bank this mon's pics live in
	assert BANK(KadabraPicFront) == BANK(KadabraPicBack), \
	    "Kadabra: front and back pics must share a bank"
