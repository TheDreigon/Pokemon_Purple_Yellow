	db DEX_BULBASAUR ; pokedex id
	base_stat_row 55, 50, 50, 65, 45 ; hp atk def spc spd
	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 64 ; base exp

	INCBIN "gfx/pokemon/front/bulbasaur.pic", 0, 1 ; sprite dimensions
	dw BulbasaurPicFront, BulbasaurPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: pure Grass baby. Universals (Mimic/Substitute/Metronome),
	; signature Grass damage (Giga Drain, Solarbeam), vine-coded utility
	; (Bind for trap, Cut for leaf-cutting), bulky basics (Take Down),
	; defensive plant screens (Light Screen, Reflect — leaf canopy framing).
	tmhm MIMIC,        SUBSTITUTE,   METRONOME,    GIGA_DRAIN,   BIND,         \
	     TAKE_DOWN,    LIGHT_SCREEN, SOLARBEAM,    REFLECT,      CUT
	; end

	db 0 ; padding
