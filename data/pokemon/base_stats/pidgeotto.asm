	db DEX_PIDGEOTTO ; pokedex id
	base_stat_row 70, 65, 55, 50, 75 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 120 ; catch rate
	db 113 ; base exp

	INCBIN "gfx/pokemon/front/pidgeotto.pic", 0, 1 ; sprite dimensions
	dw PidgeottoPicFront, PidgeottoPicBack

	db TACKLE, GUST, SAND_ATTACK, QUICK_ATTACK ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: medium hawk. Pidgey's 5 + 3 grown-talon additions:
	; HONE_CLAWS (also levelup), TAKE_DOWN, HM01 CUT (sharper beak/talons).
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE,   HURRICANE,    FLY, \
	     TAKE_DOWN,    CUT,          BODY_SLAM
	; end

	db 0 ; padding
