	db DEX_GLOOM ; pokedex id
	base_stat_row 75, 70, 70, 75, 75, 40 ; hp atk def spatk spdef spd
	db GRASS, POISON ; type
	db 125 ; catch rate  ; mid stage, BST 405, easy to approach
	db 125 ; base exp  ; BST 405

	INCBIN "gfx/pokemon/front/gloom.pic", 0, 1 ; sprite dimensions
	dw GloomPicFront, GloomPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage flower bud (Grass/Poison).
	; v1.0 (2026-11-07): LEECH_LIFE is a level-up auto (L40).
	tmhm GIGA_DRAIN, TOXIC, LEECH_LIFE, PETAL_DANCE
	; end

	db BANK(GloomPicFront) ; which bank this mon's pics live in
	assert BANK(GloomPicFront) == BANK(GloomPicBack), \
	    "Gloom: front and back pics must share a bank"
