	db DEX_VICTREEBEL ; pokedex id
	base_stat_row 80, 95, 70, 95, 90 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 191 ; base exp

	INCBIN "gfx/pokemon/front/victreebel.pic", 0, 1 ; sprite dimensions
	dw VictreebelPicFront, VictreebelPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex carnivorous pitcher plant (Grass/Poison). Drains prey
	; (GIGA_DRAIN/LEECH_LIFE), spreads venom (TOXIC), and intimidates
	; (SCARY_FACE/INTIMIDATE). Last-stage fun moves via TM.
	tmhm FAINT_ATTACK, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, GIGA_DRAIN, TOXIC, INTIMIDATE, SCARY_FACE, \
	     LEECH_LIFE, TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, CUT, \
	     BIND
	; end

	db 0 ; padding
