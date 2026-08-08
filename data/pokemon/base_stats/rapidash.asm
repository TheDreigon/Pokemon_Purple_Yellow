	db DEX_RAPIDASH ; pokedex id
	base_stat_row 70, 100, 70, 85, 100 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 65 ; catch rate  ; set by hand
	db 192 ; base exp

	INCBIN "gfx/pokemon/front/rapidash.pic", 0, 1 ; sprite dimensions
	dw RapidashPicFront, RapidashPicBack

	db EMBER, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Fire unicorn horse. The horn justifies MEGAHORN. Fire-line
	; firepower (FLAME_BURST/IGNITE/FLAMETHROWER) plus equine charges.
	tmhm QUICK_ATTACK, BULLDOZE, BODY_SLAM, FLAME_BURST, IGNITE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, \
	     AGILITY, MEGAHORN, TAKE_DOWN, FLAMETHROWER, DOUBLE_EDGE
	; end

	db 0 ; padding
