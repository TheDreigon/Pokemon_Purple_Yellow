	db DEX_MEOWTH ; pokedex id
	base_stat_row 45, 50, 40, 40, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 255 ; catch rate
	db 69 ; base exp

	INCBIN "gfx/pokemon/front/meowth.pic", 0, 1 ; sprite dimensions
	dw MeowthPicFront, MeowthPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Normal/Dark feline pre-evo, slim claw cat.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AGILITY, INTIMIDATE, SCARY_FACE, \
	     TAKE_DOWN, CUT, STRENGTH
	; end

	db 0 ; padding
