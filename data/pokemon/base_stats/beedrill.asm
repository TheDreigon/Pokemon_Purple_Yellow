	db DEX_BEEDRILL ; pokedex id
	base_stat_row 65, 95, 65, 60, 90 ; hp atk def spc spd

	db BUG, POISON ; type
	db 45 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/beedrill.pic", 0, 1 ; sprite dimensions
	dw BeedrillPicFront, BeedrillPicBack

	db ENTANGLE, HARDEN, POISON_STING, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     RAGE,         MEGA_DRAIN,   MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         DISCHARGE,        HEAD_SMASH,   REST,         SUBSTITUTE,   \
	     CUT
	; end

	db 0 ; padding
