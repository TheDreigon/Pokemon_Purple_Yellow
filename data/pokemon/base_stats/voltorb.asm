	db DEX_VOLTORB ; pokedex id
	base_stat_row 20, 50, 40, 50, 110 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 190 ; catch rate
	db 103 ; base exp

	INCBIN "gfx/pokemon/front/voltorb.pic", 0, 1 ; sprite dimensions
	dw VoltorbPicFront, VoltorbPicBack

	db TACKLE, SCREECH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: living Poke Ball, Electric/Steel sphere — no limbs or
	; hands. auto
	; SHOCK_WAVE/THUNDER_WAVE/LIGHT_SCREEN/THUNDERBOLT/FLASH. bonus
	; IRON_HEAD. HM FLASH.
	tmhm SHOCK_WAVE, THUNDER_WAVE, IRON_HEAD, LIGHT_SCREEN, THUNDERBOLT, \
	     FLASH
	; end

	db 0 ; padding
