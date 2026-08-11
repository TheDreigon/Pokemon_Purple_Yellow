	db DEX_PIDGEOTTO ; pokedex id
	base_stat_row 70, 65, 55, 50, 75 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 115 ; catch rate  ; mid stage, BST 315
	db 105 ; base exp  ; BST 315 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/pidgeotto.pic", 0, 1 ; sprite dimensions
	dw PidgeottoPicFront, PidgeottoPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Mid-size hawk. Flight kit: QUICK_ATTACK/AERIAL_ACE/HURRICANE
	; plus BODY_SLAM/TAKE_DOWN. HM CUT/FLY.
	tmhm QUICK_ATTACK, BODY_SLAM, TAKE_DOWN, AERIAL_ACE, HURRICANE, CUT, \
	     FLY
	; end

	db BANK(PidgeottoPicFront) ; which bank this mon's pics live in
	assert BANK(PidgeottoPicFront) == BANK(PidgeottoPicBack), \
	    "Pidgeotto: front and back pics must share a bank"
