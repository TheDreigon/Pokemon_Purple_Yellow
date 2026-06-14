	db DEX_MANKEY ; pokedex id
	base_stat_row 40, 80, 35, 30, 80 ; hp atk def spc spd
	db FIGHTING, DARK ; type
	db 190 ; catch rate
	db 74 ; base exp

	INCBIN "gfx/pokemon/front/mankey.pic", 0, 1 ; sprite dimensions
	dw MankeyPicFront, MankeyPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: macaco selvagem rage-fueled, backbone de lutador
	; grappler. auto
	; ROCK_THROW/QUICK_ATTACK/RAGE/BODY_SLAM/TAKE_DOWN/THRASH/OUTRAGE.
	; bonus BIND/SEISMIC_TOSS/BULK_UP/DOUBLE_EDGE. HM STRENGTH.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, SEISMIC_TOSS, RAGE, \
	     BODY_SLAM, BULK_UP, TAKE_DOWN, DOUBLE_EDGE, THRASH, \
	     OUTRAGE, STRENGTH
	; end

	db 0 ; padding
