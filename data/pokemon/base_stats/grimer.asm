	db DEX_GRIMER ; pokedex id
	base_stat_row 80, 60, 50, 65, 30 ; hp atk def spc spd
	db POISON, WATER ; type
	db 190 ; catch rate  ; set by hand: sludge: less to hold than it looks
	db 90 ; base exp

	INCBIN "gfx/pokemon/front/grimer.pic", 0, 1 ; sprite dimensions
	dw GrimerPicFront, GrimerPicBack

	db LICK, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-evo Poison/Water sludge blob.
	tmhm BIND, BULLDOZE, BODY_SLAM, TOXIC, TAKE_DOWN, \
	     DOUBLE_EDGE, THRASH
	; end

	db 0 ; padding
