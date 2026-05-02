	db DEX_TENTACOOL ; pokedex id
	base_stat_row 50, 40, 30, 80, 60 ; hp atk def spc spd

	db WATER, POISON ; type
	db 190 ; catch rate
	db 105 ; base exp

	INCBIN "gfx/pokemon/front/tentacool.pic", 0, 1 ; sprite dimensions
	dw TentacoolPicFront, TentacoolPicBack

	db POISON_STING, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AGILITY,      ICE_BEAM,     LEECH_LIFE,   WATER_PULSE
	; end

	db 0 ; padding
