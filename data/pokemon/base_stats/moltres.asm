	db DEX_MOLTRES ; pokedex id
	base_stat_row 100, 100, 90, 130, 100 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 3 ; catch rate  ; exception: legendary: one in the world
	db 217 ; base exp

	INCBIN "gfx/pokemon/front/moltres.pic", 0, 1 ; sprite dimensions
	dw MoltresPicFront, MoltresPicBack

	db PECK, EMBER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; Legendary fire raptor. Last-stage fun moves allowed.
	tmhm FLAME_BURST, IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     SCARY_FACE, TAKE_DOWN, FLAMETHROWER, SWORDS_DANCE, CALM_MIND, \
	     ROCK_SLIDE, DOUBLE_EDGE, LIGHT_SCREEN, REFLECT, CUT, FLY, FLASH
	; end

	db BANK(MoltresPicFront) ; which bank this mon's pics live in
	assert BANK(MoltresPicFront) == BANK(MoltresPicBack), \
	    "Moltres: front and back pics must share a bank"
