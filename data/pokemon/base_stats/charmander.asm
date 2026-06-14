	db DEX_CHARMANDER ; pokedex id
	base_stat_row 50, 55, 40, 55, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 65 ; base exp

	INCBIN "gfx/pokemon/front/charmander.pic", 0, 1 ; sprite dimensions
	dw CharmanderPicFront, CharmanderPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: baby fire reptile. auto
	; FLAME_BURST/IGNITE/DRAGON_CLAW/FLAMETHROWER. bonus
	; QUICK_ATTACK/TAKE_DOWN/OUTRAGE. HM CUT/FLASH.
	tmhm QUICK_ATTACK, FLAME_BURST, IGNITE, DRAGON_CLAW, TAKE_DOWN, \
	     FLAMETHROWER, OUTRAGE, CUT, FLASH
	; end

	db 0 ; padding
