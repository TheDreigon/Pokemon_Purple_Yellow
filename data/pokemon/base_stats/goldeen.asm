	db DEX_GOLDEEN ; pokedex id
	base_stat_row 45, 65, 60, 35, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 225 ; catch rate
	db 111 ; base exp

	INCBIN "gfx/pokemon/front/goldeen.pic", 0, 1 ; sprite dimensions
	dw GoldeenPicFront, GoldeenPicBack

	db TAIL_WHIP, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        HORN_DRILL,   TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     WATER_GUN,    ICE_BEAM,     BLIZZARD,     RAGE,         MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         DISCHARGE,        HEAD_SMASH,   REST,         \
	     SUBSTITUTE,   SURF,     SWORDS_DANCE
	; end

	db 0 ; padding
