	db DEX_LAPRAS ; pokedex id
	base_stat_row 130, 75, 95, 100, 60 ; hp atk def spc spd

	db WATER, ICE ; type
	db 45 ; catch rate
	db 219 ; base exp

	INCBIN "gfx/pokemon/front/lapras.pic", 0, 1 ; sprite dimensions
	dw LaprasPicFront, LaprasPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
