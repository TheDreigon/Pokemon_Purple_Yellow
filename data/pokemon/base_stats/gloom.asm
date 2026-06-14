	db DEX_GLOOM ; pokedex id
	base_stat_row 80, 70, 70, 80, 40 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 120 ; catch rate
	db 132 ; base exp

	INCBIN "gfx/pokemon/front/gloom.pic", 0, 1 ; sprite dimensions
	dw GloomPicFront, GloomPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: mid-stage flower bud (Grass/Fungus). auto
	; TOXIC/PETAL_DANCE. bonus GIGA_DRAIN.
	tmhm GIGA_DRAIN, TOXIC, PETAL_DANCE
	; end

	db 0 ; padding
