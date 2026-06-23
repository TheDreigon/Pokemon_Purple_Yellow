	db DEX_DODUO ; pokedex id
	base_stat_row 40, 80, 40, 40, 90 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 190 ; catch rate
	db 96 ; base exp

	INCBIN "gfx/pokemon/front/doduo.pic", 0, 1 ; sprite dimensions
	dw DoduoPicFront, DoduoPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Two-headed flightless biped ratite, pre-evo. HM CUT/STRENGTH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     AGILITY, TAKE_DOWN, DOUBLE_EDGE, CUT, STRENGTH
	; end

	db 0 ; padding
