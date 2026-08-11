	db DEX_RATICATE ; pokedex id
	base_stat_row 70, 90, 65, 60, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 85 ; catch rate  ; final stage, BST 375
	db 140 ; base exp  ; BST 375 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/raticate.pic", 0, 1 ; sprite dimensions
	dw RaticatePicFront, RaticatePicBack

	db BITE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Matured Normal/Dark rodent, physical bruiser. Sharp fangs justify
	; POISON_BITE/FAINT_ATTACK; gnawing incisors learn HM CUT.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     POISON_BITE, TOXIC, INTIMIDATE, TAKE_DOWN, DOUBLE_EDGE, \
	     CUT
	; end

	db BANK(RaticatePicFront) ; which bank this mon's pics live in
	assert BANK(RaticatePicFront) == BANK(RaticatePicBack), \
	    "Raticate: front and back pics must share a bank"
