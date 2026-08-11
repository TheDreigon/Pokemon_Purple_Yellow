	db DEX_ARBOK ; pokedex id
	base_stat_row 60, 90, 90, 60, 100 ; hp atk def spc spd
	db POISON, DARK ; type
	db 60 ; catch rate  ; final stage, BST 400, harder to handle
	db 160 ; base exp  ; BST 400 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/arbok.pic", 0, 1 ; sprite dimensions
	dw ArbokPicFront, ArbokPicBack

	db CONSTRICT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Poison/Dark matured cobra, last-stage.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     POISON_BITE, TOXIC, INTIMIDATE, SCARY_FACE, TAKE_DOWN, \
	     DOUBLE_EDGE, CUT
	; end

	db BANK(ArbokPicFront) ; which bank this mon's pics live in
	assert BANK(ArbokPicFront) == BANK(ArbokPicBack), \
	    "Arbok: front and back pics must share a bank"
