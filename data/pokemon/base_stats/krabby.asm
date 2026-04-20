	db DEX_KRABBY ; pokedex id
	base_stat_row 30, 75, 75, 35, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 225 ; catch rate
	db 115 ; base exp

	INCBIN "gfx/pokemon/front/krabby.pic", 0, 1 ; sprite dimensions
	dw KrabbyPicFront, KrabbyPicBack

	db WATER_GUN, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
