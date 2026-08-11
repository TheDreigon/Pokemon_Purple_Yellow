	db DEX_ELECTABUZZ ; pokedex id
	base_stat_row 75, 95, 70, 95, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 65 ; catch rate  ; solo stage, BST 430, harder to handle
	db 175 ; base exp  ; BST 430 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/electabuzz.pic", 0, 1 ; sprite dimensions
	dw ElectabuzzPicFront, ElectabuzzPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Electric boxer from the power plant (Magmar counterpart).
	; HM CUT/STRENGTH/FLASH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, FLAME_BURST, \
	     SHOCK_WAVE, THUNDER_WAVE, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, TAKE_DOWN, \
	     LIGHT_SCREEN, REFLECT, THUNDERBOLT, DOUBLE_EDGE, STRENGTH, \
	     FLASH, THRASH, ROCK_THROW, SEISMIC_TOSS, CUT
	; end

	db BANK(ElectabuzzPicFront) ; which bank this mon's pics live in
	assert BANK(ElectabuzzPicFront) == BANK(ElectabuzzPicBack), \
	    "Electabuzz: front and back pics must share a bank"
