	db DEX_METAPOD ; pokedex id
	base_stat_row 50, 20, 75, 25, 5 ; hp atk def spc spd

	db BUG, BUG ; type
	db 150 ; catch rate  ; mid stage, BST 175, easy to approach
	db 72 ; base exp

	INCBIN "gfx/pokemon/front/metapod.pic", 0, 1 ; sprite dimensions
	dw MetapodPicFront, MetapodPicBack

	db TACKLE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Cocoon; minimal pool, SUBSTITUTE as a rare pre-evo fun exception.
	tmhm SUBSTITUTE, LEECH_LIFE
	; end

	db 0 ; padding
