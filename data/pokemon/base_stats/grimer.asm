	db DEX_GRIMER ; pokedex id
	base_stat_row 80, 60, 50, 65, 30 ; hp atk def spc spd
	db POISON, WATER ; type
	db 190 ; catch rate
	db 90 ; base exp

	INCBIN "gfx/pokemon/front/grimer.pic", 0, 1 ; sprite dimensions
	dw GrimerPicFront, GrimerPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BIND,         BODY_SLAM,    BULLDOZE,     DOUBLE_EDGE,  EARTHQUAKE, \
	     TAKE_DOWN,    THRASH,       TOXIC
	; end

	db 0 ; padding
