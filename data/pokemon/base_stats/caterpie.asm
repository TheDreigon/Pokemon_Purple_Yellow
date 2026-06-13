	db DEX_CATERPIE ; pokedex id
	base_stat_row 45, 30, 35, 20, 45 ; hp atk def spc spd

	db BUG, BUG ; type
	db 255 ; catch rate
	db 53 ; base exp

	INCBIN "gfx/pokemon/front/caterpie.pic", 0, 1 ; sprite dimensions
	dw CaterpiePicFront, CaterpiePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: joke-tier baby caterpillar. Almost can't fight; minimal
	; kit reflects that. STRING_SHOT moved to L7 levelup (1 before evo) per
	; Forte. NO fun moves (per Forte's revised rule — Caterpie too small/
	; primitive even for silk-substitute, which only Metapod gets).
	tmhm LEECH_LIFE
	; end

	db 0 ; padding
