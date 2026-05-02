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
	tmhm BIND,         BULLDOZE,     BODY_SLAM,    CONFUSE_RAY,  TOXIC, \
	     LEECH_LIFE,   TAKE_DOWN,    DOUBLE_EDGE,  SHADOW_BALL,  MIMIC, \
	     MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
