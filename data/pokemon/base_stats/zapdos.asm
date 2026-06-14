	db DEX_ZAPDOS ; pokedex id
	base_stat_row 100, 100, 80, 130, 110 ; hp atk def spc spd

	db ELECTRIC, FLYING ; type
	db 3 ; catch rate
	db 216 ; base exp

	INCBIN "gfx/pokemon/front/zapdos.pic", 0, 1 ; sprite dimensions
	dw ZapdosPicFront, ZapdosPicBack

	db PECK, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: legendary electric raptor. auto
	; SHOCK_WAVE/THUNDER_WAVE/AGILITY/AERIAL_ACE/HURRICANE/THUNDERBOLT/FLY.
	; bonus
	; INTIMIDATE/SCARY_FACE/TAKE_DOWN/SWORDS_DANCE/CALM_MIND/ROCK_SLIDE/DOUBLE_EDGE.
	; HM CUT/FLY/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     SCARY_FACE, TAKE_DOWN, THUNDERBOLT, SWORDS_DANCE, CALM_MIND, \
	     ROCK_SLIDE, DOUBLE_EDGE, CUT, FLY, FLASH
	; end

	db 0 ; padding
