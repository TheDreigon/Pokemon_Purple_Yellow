	db DEX_POLIWAG ; pokedex id
	base_stat_row 40, 40, 40, 40, 65 ; hp atk def spc spd

	db WATER, WATER ; type
	db 235 ; catch rate  ; base stage, BST 225
	db 77 ; base exp

	INCBIN "gfx/pokemon/front/poliwag.pic", 0, 1 ; sprite dimensions
	dw PoliwagPicFront, PoliwagPicBack

	db DOUBLESLAP, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic Water tadpole: WATER_PULSE/BODY_SLAM plus ICY_PULSE/ICE_BEAM.
	; HM SURF.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, ICE_BEAM, SURF
	; end

	db BANK(PoliwagPicFront) ; which bank this mon's pics live in
	assert BANK(PoliwagPicFront) == BANK(PoliwagPicBack), \
	    "Poliwag: front and back pics must share a bank"
