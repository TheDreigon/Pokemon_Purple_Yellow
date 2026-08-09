	db DEX_POLIWHIRL ; pokedex id
	base_stat_row 65, 65, 65, 70, 70 ; hp atk def spc spd

	db WATER, WATER ; type
	db 110 ; catch rate  ; mid stage, BST 335
	db 131 ; base exp

	INCBIN "gfx/pokemon/front/poliwhirl.pic", 0, 1 ; sprite dimensions
	dw PoliwhirlPicFront, PoliwhirlPicBack

	db DOUBLESLAP, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Muscled mid-evo Water:
	; WATER_PULSE/BODY_SLAM/BULK_UP/SURF plus SEISMIC_TOSS/ICY_PULSE/
	; ICE_BEAM. HM SURF/STRENGTH.
	tmhm WATER_PULSE, ICY_PULSE, SEISMIC_TOSS, BODY_SLAM, BULK_UP, \
	     ICE_BEAM, SURF, STRENGTH
	; end

	db BANK(PoliwhirlPicFront) ; which bank this mon's pics live in
	assert BANK(PoliwhirlPicFront) == BANK(PoliwhirlPicBack), \
	    "Poliwhirl: front and back pics must share a bank"
