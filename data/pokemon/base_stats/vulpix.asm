	db DEX_VULPIX ; pokedex id
	base_stat_row 50, 40, 40, 70, 70 ; hp atk def spc spd
	db FIRE, FAIRY ; type
	db 190 ; catch rate
	db 63 ; base exp

	INCBIN "gfx/pokemon/front/vulpix.pic", 0, 1 ; sprite dimensions
	dw VulpixPicFront, VulpixPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-evo kitsune fox, Fire/Fairy backbone subset. Fire breath
	; (FLAME_BURST/IGNITE/FLAMETHROWER) plus cute/mystical kitsune
	; gestures (FAKE_TEARS/CHARM/EXTRASENSORY). Apex setup reserved to
	; Ninetales.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, FLAME_BURST, NIGHT_SHADE, \
	     CONFUSE_RAY, IGNITE, AGILITY, FAKE_TEARS, CHARM, \
	     EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, FLAMETHROWER, REFLECT
	; end

	db 0 ; padding
