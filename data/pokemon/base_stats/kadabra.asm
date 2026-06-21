	db DEX_KADABRA ; pokedex id
	base_stat_row 40, 35, 30, 115, 105 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 100 ; catch rate
	db 145 ; base exp

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

	db 0 ; padding
