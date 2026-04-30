	db DEX_VENOMOTH ; pokedex id
	base_stat_row 70, 75, 60, 80, 80 ; hp atk def spc spd

	db BUG, POISON ; type
	db 75 ; catch rate
	db 138 ; base exp

	INCBIN "gfx/pokemon/front/venomoth.pic", 0, 1 ; sprite dimensions
	dw VenomothPicFront, VenomothPicBack

	db TACKLE, DISABLE, GUST, POISONPOWDER ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: full moth. Venonat's 5 + 3 wing additions: Aerial Ace
	; (levelup-double), HM02 Fly (Forte's HM-Fly list), Reflect. No fun
	; moves (same logic as Venonat).
	tmhm LEECH_LIFE,   TOXIC,        EXTRASENSORY, PSYCHIC_M,    LIGHT_SCREEN, \
	     AERIAL_ACE,   REFLECT,      FLY,          MIMIC,        MIRROR_MOVE, \
	     SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
