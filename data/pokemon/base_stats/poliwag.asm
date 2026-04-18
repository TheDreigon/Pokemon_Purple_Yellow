	db DEX_POLIWAG ; pokedex id
	base_stat_row 40, 40, 40, 40, 70 ; hp atk def spc spd

	db WATER, WATER ; type
	db 255 ; catch rate
	db 77 ; base exp

	INCBIN "gfx/pokemon/front/poliwag.pic", 0, 1 ; sprite dimensions
	dw PoliwagPicFront, PoliwagPicBack

	db DOUBLESLAP, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     WATER_GUN,    ICE_BEAM,     BLIZZARD,     RAGE,         PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         HEAD_SMASH,   REST,         \
	     PSYWAVE,      SUBSTITUTE,   SURF,   DREAM_EATER
	; end

	db 0 ; padding
