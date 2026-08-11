	db DEX_VOLTORB ; pokedex id
	base_stat_row 20, 50, 40, 50, 110 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 205 ; catch rate  ; base stage, BST 270, harder to handle
	db 85 ; base exp  ; BST 270 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/voltorb.pic", 0, 1 ; sprite dimensions
	dw VoltorbPicFront, VoltorbPicBack

	db TACKLE, BIDE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Living Poke Ball, Electric/Steel sphere — no limbs or hands.
	; Steel shell drives IRON_HEAD; electric charge powers THUNDERBOLT.
	; Limbless but rolls/slams its whole body: QUICK_ATTACK/BODY_SLAM/AGILITY.
	tmhm SHOCK_WAVE, THUNDER_WAVE, IRON_HEAD, LIGHT_SCREEN, THUNDERBOLT, \
	     FLASH, QUICK_ATTACK, BODY_SLAM, AGILITY
	; end

	db BANK(VoltorbPicFront) ; which bank this mon's pics live in
	assert BANK(VoltorbPicFront) == BANK(VoltorbPicBack), \
	    "Voltorb: front and back pics must share a bank"
