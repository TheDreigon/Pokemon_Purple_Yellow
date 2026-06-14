	db DEX_ONIX ; pokedex id
	base_stat_row 60, 100, 160, 60, 40 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 108 ; base exp

	INCBIN "gfx/pokemon/front/onix.pic", 0, 1 ; sprite dimensions
	dw OnixPicFront, OnixPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: colossal single-stage rock-snake apex. auto
	; ROCK_THROW/BIND/BULLDOZE/BODY_SLAM/IRON_TAIL/IRON_HEAD/INTIMIDATE/TAKE_DOWN/EARTHQUAKE/ROCK_SLIDE/STRENGTH.
	; bonus SCARY_FACE/DOUBLE_EDGE. HM STRENGTH. fun (4 via TM, regra
	; global last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BIND, BULLDOZE, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, EARTHQUAKE, ROCK_SLIDE, \
	     DOUBLE_EDGE, STRENGTH
	; end

	db 0 ; padding
