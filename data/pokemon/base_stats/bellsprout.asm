	db DEX_BELLSPROUT ; pokedex id
	base_stat_row 40, 65, 40, 55, 50 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 230 ; catch rate  ; base stage, BST 250
	db 65 ; base exp  ; BST 250 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/bellsprout.pic", 0, 1 ; sprite dimensions
	dw BellsproutPicFront, BellsproutPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic carnivorous pitcher plant (Grass/Poison). Grass STAB
	; GIGA_DRAIN, digestive TOXIC, ambush FAINT_ATTACK.
	tmhm FAINT_ATTACK, GIGA_DRAIN, TOXIC
	; end

	db BANK(BellsproutPicFront) ; which bank this mon's pics live in
	assert BANK(BellsproutPicFront) == BANK(BellsproutPicBack), \
	    "Bellsprout: front and back pics must share a bank"
