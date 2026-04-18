	db DEX_FEAROW ; pokedex id
	base_stat_row 70, 95, 65, 65, 95 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 90 ; catch rate
	db 162 ; base exp

	INCBIN "gfx/pokemon/front/fearow.pic", 0, 1 ; sprite dimensions
	dw FearowPicFront, FearowPicBack

	db PECK, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,     TOXIC,     TAKE_DOWN,     \
		 DOUBLE_EDGE,	HYPER_BEAM,   RAGE,         MIMIC,       DOUBLE_TEAM,   \
	     BIDE,		DISCHARGE,        HURRICANE,      REST,         SUBSTITUTE,    \
		 FLY

	; end

	db 0 ; padding
