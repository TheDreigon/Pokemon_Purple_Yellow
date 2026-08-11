	db DEX_ZAPDOS ; pokedex id
	base_stat_row 100, 100, 80, 130, 110 ; hp atk def spc spd

	db ELECTRIC, FLYING ; type
	db 3 ; catch rate  ; exception: legendary: one in the world
	db 250 ; base exp  ; trio dos passaros lendarios

	INCBIN "gfx/pokemon/front/zapdos.pic", 0, 1 ; sprite dimensions
	dw ZapdosPicFront, ZapdosPicBack

	db PECK, NUZZLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; Legendary electric raptor. Electric and flying attacks, agility
	; and intimidating presence, plus setup moves. Natural HM
	; flyer/cutter. Fun moves (last-stage).
	tmhm SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     SCARY_FACE, TAKE_DOWN, THUNDERBOLT, SWORDS_DANCE, CALM_MIND, \
	     ROCK_SLIDE, DOUBLE_EDGE, LIGHT_SCREEN, REFLECT, CUT, FLY, FLASH
	; end

	db BANK(ZapdosPicFront) ; which bank this mon's pics live in
	assert BANK(ZapdosPicFront) == BANK(ZapdosPicBack), \
	    "Zapdos: front and back pics must share a bank"
