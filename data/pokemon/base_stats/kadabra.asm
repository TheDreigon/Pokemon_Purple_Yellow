	db DEX_KADABRA ; pokedex id
	base_stat_row 40, 35, 30, 115, 105 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 100 ; catch rate
	db 145 ; base exp

	INCBIN "gfx/pokemon/front/kadabra.pic", 0, 1 ; sprite dimensions
	dw KadabraPicFront, KadabraPicBack

	db TELEPORT, PSYCHIC_BIND, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AGILITY,      CALM_MIND,    DAZZLE_GLEAM, EXTRASENSORY, LIGHT_SCREEN, \
	     PSYCHIC_M,    REFLECT,      SHADOW_BALL,  SHOCK_WAVE,   FLASH
	; end

	db 0 ; padding
