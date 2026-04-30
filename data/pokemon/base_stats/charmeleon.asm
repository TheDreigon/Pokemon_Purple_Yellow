	db DEX_CHARMELEON ; pokedex id
	base_stat_row 60, 70, 55, 70, 75 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 142 ; base exp

	INCBIN "gfx/pokemon/front/charmeleon.pic", 0, 1 ; sprite dimensions
	dw CharmeleonPicFront, CharmeleonPicBack

	db SCRATCH, GROWL, EMBER, SMOKESCREEN ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: warrior teen. Charmander's 15 + 5 bulkier additions:
	; Double Team (more agile), Body Slam (bigger frame), Bulk Up (warrior
	; buff), Double Edge (heavy charge with recoil), HM Strength (push
	; heavy). No Agility — Char-line not on Forte's natural-or-TM list.
	tmhm QUICK_ATTACK, TAKE_DOWN,    DRAGON_CLAW,  IGNITE,       FLAMETHROWER, \
	     OUTRAGE,      CUT,          FLASH,        BODY_SLAM,    BULK_UP, \
	     DOUBLE_EDGE,  STRENGTH,     ROCK_THROW
	; end

	db 0 ; padding
