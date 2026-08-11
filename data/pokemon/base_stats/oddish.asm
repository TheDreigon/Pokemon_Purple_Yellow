	db DEX_ODDISH ; pokedex id
	base_stat_row 50, 50, 55, 60, 30 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 245 ; catch rate  ; base stage, BST 245, easy to approach
	db 60 ; base exp  ; BST 245 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/oddish.pic", 0, 1 ; sprite dimensions
	dw OddishPicFront, OddishPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic radish/turnip plant (Grass/Poison).
	tmhm GIGA_DRAIN, TOXIC, PETAL_DANCE
	; end

	db BANK(OddishPicFront) ; which bank this mon's pics live in
	assert BANK(OddishPicFront) == BANK(OddishPicBack), \
	    "Oddish: front and back pics must share a bank"
