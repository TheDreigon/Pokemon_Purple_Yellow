	db DEX_DODUO ; pokedex id
	base_stat_row 40, 80, 40, 40, 90 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 190 ; catch rate
	db 96 ; base exp

	INCBIN "gfx/pokemon/front/doduo.pic", 0, 1 ; sprite dimensions
	dw DoduoPicFront, DoduoPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: ratite bipede flightless de 2 cabecas, pre-evo
	; backbone. auto QUICK_ATTACK/RAGE/AGILITY/TAKE_DOWN/DOUBLE_EDGE.
	; bonus FAINT_ATTACK/BULLDOZE/BODY_SLAM. HM CUT/STRENGTH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     AGILITY, TAKE_DOWN, DOUBLE_EDGE, CUT, STRENGTH
	; end

	db 0 ; padding
