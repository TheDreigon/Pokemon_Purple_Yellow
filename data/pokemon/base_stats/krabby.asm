	db DEX_KRABBY ; pokedex id
	base_stat_row 30, 75, 75, 35, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 225 ; catch rate
	db 115 ; base exp

	INCBIN "gfx/pokemon/front/krabby.pic", 0, 1 ; sprite dimensions
	dw KrabbyPicFront, KrabbyPicBack

	db WATER_GUN, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: scrappy pincer crab, pre-evo backbone (subset of
	; Kingler). auto BIND/WATER_PULSE. bonus
	; SEISMIC_TOSS/BODY_SLAM/ICE_BEAM. HM CUT/SURF/STRENGTH.
	tmhm BIND, WATER_PULSE, SEISMIC_TOSS, BODY_SLAM, ICE_BEAM, \
	     CUT, SURF, STRENGTH
	; end

	db 0 ; padding
