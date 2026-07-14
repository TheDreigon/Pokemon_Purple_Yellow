	db DEX_GYARADOS ; pokedex id
	base_stat_row 90, 130, 90, 90, 80 ; hp atk def spc spd
	db WATER, DRAGON ; type
	db 45 ; catch rate
	db 214 ; base exp

	INCBIN "gfx/pokemon/front/gyarados.pic", 0, 1 ; sprite dimensions
	dw GyaradosPicFront, GyaradosPicBack

	db LEER, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset. TACKLE moved to the L10 learnset slot (R22, Forte 2026-07-15)
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Brutal Water/Dragon sea-serpent apex, mostly physical, not
	; docile. HM SURF/STRENGTH.
	; Fun moves (last-stage): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, WATER_PULSE, ICY_PULSE, RAGE, \
	     BODY_SLAM, IRON_TAIL, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, IRON_HEAD, DRAGON_CLAW, INTIMIDATE, \
	     SCARY_FACE, TAKE_DOWN, ICE_BEAM, EARTHQUAKE, ROCK_SLIDE, \
	     DOUBLE_EDGE, THRASH, OUTRAGE, SURF, STRENGTH
	; end

	db 0 ; padding
