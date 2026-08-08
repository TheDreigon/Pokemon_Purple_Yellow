	db DEX_BELLSPROUT ; pokedex id
	base_stat_row 40, 65, 35, 55, 40 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 235 ; catch rate  ; base stage, BST 235
	db 84 ; base exp

	INCBIN "gfx/pokemon/front/bellsprout.pic", 0, 1 ; sprite dimensions
	dw BellsproutPicFront, BellsproutPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic carnivorous pitcher plant (Grass/Poison). Grass STAB
	; GIGA_DRAIN, digestive TOXIC, ambush FAINT_ATTACK.
	tmhm FAINT_ATTACK, GIGA_DRAIN, TOXIC
	; end

	db 0 ; padding
