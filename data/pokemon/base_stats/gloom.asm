	db DEX_GLOOM ; pokedex id
	base_stat_row 80, 70, 70, 80, 40 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 125 ; catch rate  ; mid stage, BST 340, easy to approach
	db 132 ; base exp

	INCBIN "gfx/pokemon/front/gloom.pic", 0, 1 ; sprite dimensions
	dw GloomPicFront, GloomPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-stage flower bud (Grass/Fungus).
	tmhm GIGA_DRAIN, TOXIC, PETAL_DANCE
	; end

	db 0 ; padding
