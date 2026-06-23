	db DEX_VOLTORB ; pokedex id
	base_stat_row 20, 50, 40, 50, 110 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 190 ; catch rate
	db 103 ; base exp

	INCBIN "gfx/pokemon/front/voltorb.pic", 0, 1 ; sprite dimensions
	dw VoltorbPicFront, VoltorbPicBack

	db TACKLE, BIDE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Living Poke Ball, Electric/Steel sphere — no limbs or hands.
	; Steel shell drives IRON_HEAD; electric charge powers THUNDERBOLT.
	tmhm SHOCK_WAVE, THUNDER_WAVE, IRON_HEAD, LIGHT_SCREEN, THUNDERBOLT, \
	     FLASH
	; end

	db 0 ; padding
