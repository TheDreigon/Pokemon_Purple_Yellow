	db DEX_DRAGONITE ; pokedex id
	base_stat_row 110, 115, 80, 110, 85 ; hp atk def spc spd
	db DRAGON, DRAGON ; type
	db 9 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/dragonite.pic", 0, 1 ; sprite dimensions
	dw DragonitePicFront, DragonitePicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,  FLAMETHROWER,  TOXIC,    HORN_DRILL,   BODY_SLAM,  TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   RAGE,         DRAGON_RAGE,  THUNDERBOLT,  THUNDER,      \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
	     DISCHARGE,        HEAD_SMASH,   REST,         THUNDER_WAVE, SUBSTITUTE,   \
	     SURF,         STRENGTH, 	 FLY
	; end

	db 0 ; padding
