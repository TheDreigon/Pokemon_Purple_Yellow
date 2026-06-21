	db DEX_SEEL ; pokedex id
	base_stat_row 65, 45, 55, 65, 50 ; hp atk def spc spd
	db WATER, ICE ; type
	db 190 ; catch rate
	db 100 ; base exp

	INCBIN "gfx/pokemon/front/seel.pic", 0, 1 ; sprite dimensions
	dw SeelPicFront, SeelPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Docile Water/Ice seal pre-evo.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, FAKE_TEARS, CHARM, \
	     TAKE_DOWN, ICE_BEAM, SURF
	; end

	db 0 ; padding
