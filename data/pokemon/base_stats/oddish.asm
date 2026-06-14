	db DEX_ODDISH ; pokedex id
	base_stat_row 50, 50, 55, 60, 30 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 255 ; catch rate
	db 78 ; base exp

	INCBIN "gfx/pokemon/front/oddish.pic", 0, 1 ; sprite dimensions
	dw OddishPicFront, OddishPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: basic radish/turnip plant (Grass/Poison). auto
	; PETAL_DANCE. bonus GIGA_DRAIN/TOXIC.
	tmhm GIGA_DRAIN, TOXIC, PETAL_DANCE
	; end

	db 0 ; padding
