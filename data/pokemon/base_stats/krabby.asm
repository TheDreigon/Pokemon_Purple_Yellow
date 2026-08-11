	db DEX_KRABBY ; pokedex id
	base_stat_row 30, 75, 75, 35, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 220 ; catch rate  ; base stage, BST 275
	db 80 ; base exp  ; BST 275

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
