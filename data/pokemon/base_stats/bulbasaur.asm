	db DEX_BULBASAUR ; pokedex id
	base_stat_row 55, 50, 50, 65, 45 ; hp atk def spc spd
	db GRASS, GRASS ; type
	db 120 ; catch rate  ; set by hand: starter line: rarer than anything wild
	db 75 ; base exp  ; BST 265 - grupo mantido igual

	INCBIN "gfx/pokemon/front/bulbasaur.pic", 0, 1 ; sprite dimensions
	dw BulbasaurPicFront, BulbasaurPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pure Grass baby. Grass STAB GIGA_DRAIN/PETAL_DANCE. Vine BIND.
	; HM CUT (vine).
	tmhm BIND, GIGA_DRAIN, TAKE_DOWN, LIGHT_SCREEN, REFLECT, \
	     PETAL_DANCE, CUT
	; end

	db BANK(BulbasaurPicFront) ; which bank this mon's pics live in
	assert BANK(BulbasaurPicFront) == BANK(BulbasaurPicBack), \
	    "Bulbasaur: front and back pics must share a bank"
