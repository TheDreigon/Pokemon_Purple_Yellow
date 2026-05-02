	db DEX_HITMONCHAN ; pokedex id
	base_stat_row 90, 80, 90, 80, 80 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 140 ; base exp

	INCBIN "gfx/pokemon/front/hitmonchan.pic", 0, 1 ; sprite dimensions
	dw HitmonchanPicFront, HitmonchanPicBack

	db COMET_PUNCH, AGILITY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm QUICK_ATTACK, BIND,         SEISMIC_TOSS, BODY_SLAM,    BULK_UP, \
	     AGILITY,      TAKE_DOWN,    CALM_MIND,    MIMIC,        MIRROR_MOVE, \
	     SUBSTITUTE,   METRONOME,    STRENGTH
	; end

	db 0 ; padding
