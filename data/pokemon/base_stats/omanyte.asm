	db DEX_OMANYTE ; pokedex id
	base_stat_row 40, 40, 100, 80, 30 ; hp atk def spc spd

	db ROCK, WATER ; type
	db 45 ; catch rate
	db 120 ; base exp

	INCBIN "gfx/pokemon/front/omanyte.pic", 0, 1 ; sprite dimensions
	dw OmanytePicFront, OmanytePicBack

	db WATER_GUN, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Small spiral-shell ammonite Rock/Water pre-evo.
	tmhm ROCK_THROW, BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, \
	     TAKE_DOWN, ROCK_SLIDE
	; end

	db 0 ; padding
