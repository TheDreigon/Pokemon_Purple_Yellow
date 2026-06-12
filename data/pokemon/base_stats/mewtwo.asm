	db DEX_MEWTWO ; pokedex id
	base_stat_row 120, 90, 90, 150, 150 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 3 ; catch rate
	db 220 ; base exp

	INCBIN "gfx/pokemon/front/mewtwo.pic", 0, 1 ; sprite dimensions
	dw MewtwoPicFront, MewtwoPicBack

	db TELEPORT, CONFUSION, DISABLE, FAINT_ATTACK ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
