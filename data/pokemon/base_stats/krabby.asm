	db DEX_KRABBY ; pokedex id
	base_stat_row 30, 75, 75, 35, 30, 60 ; hp atk def spatk spdef spd

	db WATER, WATER ; type
	db 220 ; catch rate  ; base stage, BST 305
	db 85 ; base exp  ; BST 305

	INCBIN "gfx/pokemon/front/krabby.pic", 0, 1 ; sprite dimensions
	dw KrabbyPicFront, KrabbyPicBack

	db WATER_GUN, SCRATCH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Scrappy pincer crab, pre-evo backbone (subset of Kingler).
	; Pincer drives BIND/SEISMIC_TOSS/CUT/STRENGTH; aquatic
	; WATER_PULSE/SURF/ICE_BEAM/ICY_PULSE.
	tmhm BIND, WATER_PULSE, ICY_PULSE, SEISMIC_TOSS, BODY_SLAM, \
	     ICE_BEAM, CUT, SURF, STRENGTH
	; end

	db BANK(KrabbyPicFront) ; which bank this mon's pics live in
	assert BANK(KrabbyPicFront) == BANK(KrabbyPicBack), \
	    "Krabby: front and back pics must share a bank"
