	db DEX_SHELLDER ; pokedex id
	base_stat_row 30, 50, 100, 45, 30 ; hp atk def spc spd

	db WATER, WATER ; type
	db 240 ; catch rate  ; base stage, BST 255, easy to approach
	db 97 ; base exp

	INCBIN "gfx/pokemon/front/shellder.pic", 0, 1 ; sprite dimensions
	dw ShellderPicFront, ShellderPicBack

	db BITE, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-evo clam, Water backbone subset.
	tmhm BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, ICE_BEAM, \
	     SURF
	; end

	db BANK(ShellderPicFront) ; which bank this mon's pics live in
	assert BANK(ShellderPicFront) == BANK(ShellderPicBack), \
	    "Shellder: front and back pics must share a bank"
