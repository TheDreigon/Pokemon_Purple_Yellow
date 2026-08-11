	db DEX_MANKEY ; pokedex id
	base_stat_row 40, 80, 35, 30, 80 ; hp atk def spc spd
	db FIGHTING, FIGHTING ; type
	db 220 ; catch rate  ; base stage, BST 265
	db 75 ; base exp  ; BST 265 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/mankey.pic", 0, 1 ; sprite dimensions
	dw MankeyPicFront, MankeyPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Wild rage-fueled monkey, grappler-fighter backbone.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, SEISMIC_TOSS, RAGE, \
	     BODY_SLAM, BULK_UP, TAKE_DOWN, DOUBLE_EDGE, THRASH, \
	     OUTRAGE, STRENGTH, CUT
	; end

	db BANK(MankeyPicFront) ; which bank this mon's pics live in
	assert BANK(MankeyPicFront) == BANK(MankeyPicBack), \
	    "Mankey: front and back pics must share a bank"
