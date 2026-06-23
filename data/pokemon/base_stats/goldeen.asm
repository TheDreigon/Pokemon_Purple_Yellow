	db DEX_GOLDEEN ; pokedex id
	base_stat_row 45, 65, 60, 35, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 225 ; catch rate
	db 111 ; base exp

	INCBIN "gfx/pokemon/front/goldeen.pic", 0, 1 ; sprite dimensions
	dw GoldeenPicFront, GoldeenPicBack

	db TAIL_WHIP, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-evo horned river fish, backbone subset. HM SURF.
	tmhm WATER_PULSE, ICY_PULSE, AGILITY, TAKE_DOWN, ICE_BEAM, \
	     SURF
	; end

	db 0 ; padding
