	db DEX_METAPOD ; pokedex id
	base_stat_row 50, 20, 75, 25, 5 ; hp atk def spc spd

	db BUG, BUG ; type
	db 200 ; catch rate  ; set by hand: an immobile cocoon whose only move is to harden
	db 40 ; base exp  ; escolha dele

	INCBIN "gfx/pokemon/front/metapod.pic", 0, 1 ; sprite dimensions
	dw MetapodPicFront, MetapodPicBack

	db BUG_BITE, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Cocoon; minimal pool, SUBSTITUTE as a rare pre-evo fun exception.
	tmhm SUBSTITUTE, LEECH_LIFE
	; end

	db BANK(MetapodPicFront) ; which bank this mon's pics live in
	assert BANK(MetapodPicFront) == BANK(MetapodPicBack), \
	    "Metapod: front and back pics must share a bank"
