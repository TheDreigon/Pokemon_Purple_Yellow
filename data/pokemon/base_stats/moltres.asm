	db DEX_MOLTRES ; pokedex id
	base_stat_row 100, 100, 90, 130, 100 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 3 ; catch rate
	db 217 ; base exp

	INCBIN "gfx/pokemon/front/moltres.pic", 0, 1 ; sprite dimensions
	dw MoltresPicFront, MoltresPicBack

	db PECK, EMBER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: legendary fire raptor. auto
	; FLAME_BURST/IGNITE/AGILITY/AERIAL_ACE/HURRICANE/FLAMETHROWER/FLY.
	; bonus
	; INTIMIDATE/SCARY_FACE/TAKE_DOWN/SWORDS_DANCE/CALM_MIND/ROCK_SLIDE/DOUBLE_EDGE.
	; HM CUT/FLY/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm FLAME_BURST, IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     SCARY_FACE, TAKE_DOWN, FLAMETHROWER, SWORDS_DANCE, CALM_MIND, \
	     ROCK_SLIDE, DOUBLE_EDGE, LIGHT_SCREEN, REFLECT, CUT, FLY, FLASH
	; end

	db 0 ; padding
