	db DEX_PORYGON ; pokedex id
	base_stat_row 75, 75, 75, 100, 75 ; hp atk def spc spd
	db NORMAL, ELECTRIC ; type
	db 45 ; catch rate
	db 130 ; base exp

	INCBIN "gfx/pokemon/front/porygon.pic", 0, 1 ; sprite dimensions
	dw PorygonPicFront, PorygonPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   RAGE,         THUNDERBOLT,  THUNDER,      PSYCHIC_M,    \
	     TELEPORT,     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     DISCHARGE,        HEAD_SMASH,   REST,         THUNDER_WAVE, PSYWAVE,      \
	     TRI_ATTACK,   SUBSTITUTE,   FLASH
	; end

	db 0 ; padding
