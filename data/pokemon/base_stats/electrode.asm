	db DEX_ELECTRODE ; pokedex id
	base_stat_row 40, 90, 80, 90, 130 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 75 ; catch rate  ; set by hand
	db 180 ; base exp  ; BST 430 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/electrode.pic", 0, 1 ; sprite dimensions
	dw ElectrodePicFront, ElectrodePicBack

	db TACKLE, BIDE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Electric/Steel sphere (130 Spd), no limbs or hands. HM FLASH.
	; Limbless but rolls/slams its whole body: QUICK_ATTACK/BODY_SLAM/DOUBLE_EDGE.
	tmhm BULLDOZE, SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, FLASH, QUICK_ATTACK, BODY_SLAM, \
	     DOUBLE_EDGE
	; end

	db BANK(ElectrodePicFront) ; which bank this mon's pics live in
	assert BANK(ElectrodePicFront) == BANK(ElectrodePicBack), \
	    "Electrode: front and back pics must share a bank"
