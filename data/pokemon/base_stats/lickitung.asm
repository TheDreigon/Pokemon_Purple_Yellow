	db DEX_LICKITUNG ; pokedex id
	base_stat_row 95, 70, 75, 70, 40 ; hp atk def spc spd
	db NORMAL, POISON ; type
	db 145 ; catch rate  ; set by hand
	db 127 ; base exp

	INCBIN "gfx/pokemon/front/lickitung.pic", 0, 1 ; sprite dimensions
	dw LickitungPicFront, LickitungPicBack

	db LICK, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Normal/Poison single-stage, bulky reptile with a huge
	; tongue. Core BIND/SEISMIC_TOSS/BODY_SLAM/TOXIC/DOUBLE_EDGE.
	; Bonus BULLDOZE/CONFUSE_RAY/LEECH_LIFE/TAKE_DOWN/ROCK_THROW. HM STRENGTH. Fun
	; (last-stage)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, CONFUSE_RAY, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, TOXIC, \
	     LEECH_LIFE, TAKE_DOWN, DOUBLE_EDGE, STRENGTH, ROCK_THROW
	; end

	db BANK(LickitungPicFront) ; which bank this mon's pics live in
	assert BANK(LickitungPicFront) == BANK(LickitungPicBack), \
	    "Lickitung: front and back pics must share a bank"
