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
	; v0.7 Pass 3: pure Grass baby. Signature Grass damage (Giga Drain,
	; Solarbeam), vine-coded utility (Bind for trap, Cut for leaf-cutting),
	; bulky basics (Take Down), defensive plant screens (Light Screen,
	; Reflect — leaf canopy framing). NO fun moves (per Forte's revised
	; rule — Mimic/Mirror Move/Substitute/Metronome are anatomy/lore-gated,
	; not universal; plants don't fit any of the four).
	tmhm GIGA_DRAIN,   BIND,         TAKE_DOWN,    LIGHT_SCREEN, REFLECT, \
	     CUT
	; end

	db 0 ; padding
