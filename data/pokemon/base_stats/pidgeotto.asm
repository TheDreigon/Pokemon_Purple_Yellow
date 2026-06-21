	db DEX_PIDGEOTTO ; pokedex id
	base_stat_row 70, 65, 55, 50, 75 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 120 ; catch rate
	db 113 ; base exp

	INCBIN "gfx/pokemon/front/pidgeotto.pic", 0, 1 ; sprite dimensions
	dw PidgeottoPicFront, PidgeottoPicBack

	db TACKLE, GUST, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-size hawk. Flight kit: QUICK_ATTACK/AERIAL_ACE/HURRICANE
	; plus BODY_SLAM. HM CUT/FLY.
	tmhm QUICK_ATTACK, BODY_SLAM, AERIAL_ACE, HURRICANE, CUT, \
	     FLY
	; end

	db 0 ; padding
