	db DEX_GROWLITHE ; pokedex id
	base_stat_row 65, 70, 45, 50, 70 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 210 ; catch rate  ; base stage, BST 300
	db 91 ; base exp

	INCBIN "gfx/pokemon/front/growlithe.pic", 0, 1 ; sprite dimensions
	dw GrowlithePicFront, GrowlithePicBack

	db BITE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Fire canine puppy. HM CUT/STRENGTH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, FLAME_BURST, \
	     IGNITE, INTIMIDATE, SCARY_FACE, TAKE_DOWN, FLAMETHROWER, \
	     DOUBLE_EDGE, CUT, STRENGTH, DRAGON_CLAW
	; end

	db BANK(GrowlithePicFront) ; which bank this mon's pics live in
	assert BANK(GrowlithePicFront) == BANK(GrowlithePicBack), \
	    "Growlithe: front and back pics must share a bank"
