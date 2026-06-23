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
	; Colossal single-stage rock-snake apex. HM STRENGTH.
	; Last-stage fun moves via TM.
	tmhm ROCK_THROW, BIND, BULLDOZE, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, EARTHQUAKE, ROCK_SLIDE, \
	     DOUBLE_EDGE, STRENGTH
	; end

	db 0 ; padding
