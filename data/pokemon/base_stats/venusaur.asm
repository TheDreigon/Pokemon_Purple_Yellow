	db DEX_VENUSAUR ; pokedex id
	base_stat_row 100, 85, 90, 105, 80 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 208 ; base exp

	INCBIN "gfx/pokemon/front/venusaur.pic", 0, 1 ; sprite dimensions
	dw VenusaurPicFront, VenusaurPicBack

	db VINE_WHIP, LEECH_SEED, RAZOR_LEAF, POISONPOWDER ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: full bloom — superset of Ivysaur. Adds Intimidate (massive
	; presence at full bloom). DAZZLE_GLEAM was considered and rejected
	; (Fairy-coded sparkle; Venusaur is plant, not magical creature).
	tmhm GIGA_DRAIN,   BIND,         TAKE_DOWN,    LIGHT_SCREEN, REFLECT, \
	     CUT,          BULLDOZE,     BODY_SLAM,    TOXIC,        DOUBLE_EDGE, \
	     EARTHQUAKE,   STRENGTH,     FLASH,        INTIMIDATE
	; end

	db 0 ; padding
