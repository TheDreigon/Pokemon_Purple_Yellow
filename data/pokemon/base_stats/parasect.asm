	db DEX_PARASECT ; pokedex id
	base_stat_row 95, 90, 90, 90, 20 ; hp atk def spc spd
	db BUG, FUNGUS ; type
	db 75 ; catch rate
	db 128 ; base exp

	INCBIN "gfx/pokemon/front/parasect.pic", 0, 1 ; sprite dimensions
	dw ParasectPicFront, ParasectPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         MEGA_DRAIN,   SOLARBEAM,    DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         HEAD_SMASH,   \
	     REST,         SUBSTITUTE,   CUT
	; end

	db 0 ; padding
