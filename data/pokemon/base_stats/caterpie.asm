	db DEX_CATERPIE ; pokedex id
	base_stat_row 45, 30, 35, 20, 45 ; hp atk def spc spd

	db BUG, BUG ; type
	db 255 ; catch rate  ; base stage, BST 175
	db 53 ; base exp

	INCBIN "gfx/pokemon/front/caterpie.pic", 0, 1 ; sprite dimensions
	dw CaterpiePicFront, CaterpiePicBack

	db BUG_BITE, STRING_SHOT, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Joke-tier baby caterpillar, almost cannot fight. Only LEECH_LIFE,
	; befitting a tiny bug.
	tmhm LEECH_LIFE
	; end

	db 0 ; padding
