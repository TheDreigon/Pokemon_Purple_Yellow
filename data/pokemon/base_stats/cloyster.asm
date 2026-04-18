	db DEX_CLOYSTER ; pokedex id
	base_stat_row 45, 90, 180, 90, 45 ; hp atk def spc spd

	db WATER, ICE ; type
	db 60 ; catch rate
	db 203 ; base exp

	INCBIN "gfx/pokemon/front/cloyster.pic", 0, 1 ; sprite dimensions
	dw CloysterPicFront, CloysterPicBack

	db TACKLE, WITHDRAW, CLAMP, AURORA_BEAM ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   RAGE,         TELEPORT,     \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         DARK_PULSE, \
	     DISCHARGE,        REST,         EXPLOSION,    TRI_ATTACK,   SUBSTITUTE,   \
	     SURF
	; end

	db 0 ; padding
