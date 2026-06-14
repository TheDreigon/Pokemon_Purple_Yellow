	db DEX_ABRA ; pokedex id
	base_stat_row 25, 20, 15, 105, 95 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 200 ; catch rate
	db 73 ; base exp

	INCBIN "gfx/pokemon/front/abra.pic", 0, 1 ; sprite dimensions
	dw AbraPicFront, AbraPicBack

	db TELEPORT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: baby psychic minimalista (canon Abra-so-Teleport).
	; auto CALM_MIND.
	tmhm CALM_MIND
	; end

	db 0 ; padding
