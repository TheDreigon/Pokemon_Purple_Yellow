	db DEX_SLOWPOKE ; pokedex id
	base_stat_row 90, 45, 65, 55, 15 ; hp atk def spc spd
	db WATER, NORMAL ; type
	db 190 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/slowpoke.pic", 0, 1 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     WATER_GUN,    ICE_BEAM,     BLIZZARD,     PAY_DAY,      RAGE,         \
	     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    TELEPORT,     \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
	     DISCHARGE,        HEAD_SMASH,   REST,         THUNDER_WAVE, PSYWAVE,      \
	     TRI_ATTACK,   SUBSTITUTE,   SURF,         STRENGTH,     FLASH
	; end

	db 0 ; padding
