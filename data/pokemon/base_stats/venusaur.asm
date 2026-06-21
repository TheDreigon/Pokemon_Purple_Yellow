	db DEX_VENUSAUR ; pokedex id
	base_stat_row 100, 85, 90, 105, 80 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 208 ; base exp

	INCBIN "gfx/pokemon/front/venusaur.pic", 0, 1 ; sprite dimensions
	dw VenusaurPicFront, VenusaurPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Full-bloom Grass/Poison — superset of Ivysaur. Bloom drains
	; (GIGA_DRAIN) and spreads venom (TOXIC); heavy body powers
	; EARTHQUAKE/STRENGTH. Last-stage fun moves via TM.
	tmhm BIND, BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, GIGA_DRAIN, TOXIC, INTIMIDATE, \
	     TAKE_DOWN, LIGHT_SCREEN, REFLECT, EARTHQUAKE, PETAL_DANCE, \
	     DOUBLE_EDGE, CUT, STRENGTH, FLASH
	; end

	db 0 ; padding
