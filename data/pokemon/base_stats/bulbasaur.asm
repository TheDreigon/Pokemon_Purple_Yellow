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
	; v0.7 Pass 3: pure Grass baby. auto GIGA_DRAIN/PETAL_DANCE. bonus
	; BIND/TAKE_DOWN/LIGHT_SCREEN/REFLECT. HM CUT.
	tmhm BIND, GIGA_DRAIN, TAKE_DOWN, LIGHT_SCREEN, REFLECT, \
	     PETAL_DANCE, CUT
	; end

	db 0 ; padding
