	db DEX_LICKITUNG ; pokedex id
	base_stat_row 95, 70, 75, 70, 40 ; hp atk def spc spd
	db NORMAL, POISON ; type
	db 45 ; catch rate
	db 127 ; base exp

	INCBIN "gfx/pokemon/front/lickitung.pic", 0, 1 ; sprite dimensions
	dw LickitungPicFront, LickitungPicBack

	db LICK, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Lickitung Normal/Poison single-stage, reptil bulky de
	; lingua enorme. auto BIND/SEISMIC_TOSS/BODY_SLAM/TOXIC/DOUBLE_EDGE.
	; bonus BULLDOZE/CONFUSE_RAY/LEECH_LIFE/TAKE_DOWN. HM STRENGTH. fun
	; (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, CONFUSE_RAY, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, TOXIC, \
	     LEECH_LIFE, TAKE_DOWN, DOUBLE_EDGE, STRENGTH
	; end

	db 0 ; padding
