	db DEX_PIDGEY ; pokedex id
	base_stat_row 45, 45, 40, 35, 55 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 240 ; catch rate  ; base stage, BST 220
	db 55 ; base exp

	INCBIN "gfx/pokemon/front/pidgey.pic", 0, 1 ; sprite dimensions
	dw PidgeyPicFront, PidgeyPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby raptor. Flight kit: QUICK_ATTACK/AERIAL_ACE/HURRICANE.
	; HM FLY.
	tmhm QUICK_ATTACK, AERIAL_ACE, HURRICANE, FLY
	; end

	db 0 ; padding
