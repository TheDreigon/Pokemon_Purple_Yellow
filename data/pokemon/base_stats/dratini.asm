	db DEX_DRATINI ; pokedex id
	base_stat_row 60, 60, 40, 50, 60 ; hp atk def spc spd

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 67 ; base exp

	INCBIN "gfx/pokemon/front/dratini.pic", 0, 1 ; sprite dimensions
	dw DratiniPicFront, DratiniPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC, FLAMETHROWER, BODY_SLAM,  TAKE_DOWN,  DOUBLE_EDGE,  BUBBLEBEAM,   \
	     WATER_GUN,    ICE_BEAM,     BLIZZARD,     RAGE,         DRAGON_RAGE,  \
	     THUNDERBOLT,  THUNDER,      MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   DISCHARGE,        HEAD_SMASH,   REST,         \
	     THUNDER_WAVE, SUBSTITUTE,   SURF
	; end

	db 0 ; padding
