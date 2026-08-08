	db DEX_VENONAT ; pokedex id
	base_stat_row 60, 45, 50, 50, 50 ; hp atk def spc spd

	db BUG, POISON ; type
	db 225 ; catch rate  ; base stage, BST 255
	db 75 ; base exp

	INCBIN "gfx/pokemon/front/venonat.pic", 0, 1 ; sprite dimensions
	dw VenonatPicFront, VenonatPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-moth fuzzy Bug/Poison drainer. Spreads venom (TOXIC), drains
	; (LEECH_LIFE), and shows nascent psychic sense (PSYCHIC_M).
	tmhm TOXIC, EXTRASENSORY, LEECH_LIFE, PSYCHIC_M, LIGHT_SCREEN
	; end

	db 0 ; padding
