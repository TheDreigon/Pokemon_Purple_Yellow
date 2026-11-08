	db DEX_PIDGEY ; pokedex id
	base_stat_row 45, 45, 40, 35, 35, 60 ; hp atk def spatk spdef spd

	db NORMAL, FLYING ; type
	db 230 ; catch rate  ; base stage, BST 260
	db 70 ; base exp  ; BST 260

	INCBIN "gfx/pokemon/front/pidgey.pic", 0, 1 ; sprite dimensions
	dw PidgeyPicFront, PidgeyPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Baby raptor. Flight kit: QUICK_ATTACK/AERIAL_ACE/HURRICANE.
	; HM FLY.
	tmhm QUICK_ATTACK, AERIAL_ACE, HURRICANE, FLY
	; end

	db BANK(PidgeyPicFront) ; which bank this mon's pics live in
	assert BANK(PidgeyPicFront) == BANK(PidgeyPicBack), \
	    "Pidgey: front and back pics must share a bank"
