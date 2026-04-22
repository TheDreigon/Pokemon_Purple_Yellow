	db DEX_VILEPLUME ; pokedex id
	base_stat_row 110, 95, 85, 95, 45 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 45 ; catch rate
	db 184 ; base exp

	INCBIN "gfx/pokemon/front/vileplume.pic", 0, 1 ; sprite dimensions
	dw VileplumePicFront, VileplumePicBack

	db TACKLE, STUN_SPORE, SLEEP_POWDER, ACID ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
