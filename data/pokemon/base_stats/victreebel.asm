	db DEX_VICTREEBEL ; pokedex id
	base_stat_row 80, 100, 70, 100, 90 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 191 ; base exp

	INCBIN "gfx/pokemon/front/victreebel.pic", 0, 1 ; sprite dimensions
	dw VictreebelPicFront, VictreebelPicBack

	db STUN_POWDER, SLEEP_POWDER, ACID, RAZOR_LEAF ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
