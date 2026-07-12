	db DEX_CHARMELEON ; pokedex id
	base_stat_row 60, 70, 55, 70, 75 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 142 ; base exp

	INCBIN "gfx/pokemon/front/charmeleon.pic", 0, 1 ; sprite dimensions
	dw CharmeleonPicFront, CharmeleonPicBack

	db SCRATCH, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Aggressive warrior teen. Fire offense
	; (FLAME_BURST/IGNITE/FLAMETHROWER) plus dragon heritage
	; (DRAGON_CLAW/OUTRAGE). Bulkier melee (BODY_SLAM/BULK_UP). Claws CUT.
	tmhm ROCK_THROW, QUICK_ATTACK, BODY_SLAM, FLAME_BURST, IGNITE, \
	     BULK_UP, DRAGON_CLAW, TAKE_DOWN, FLAMETHROWER, DOUBLE_EDGE, \
	     OUTRAGE, CUT, STRENGTH, FLASH
	; end

	db 0 ; padding
