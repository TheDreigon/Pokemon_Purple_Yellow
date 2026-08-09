	db DEX_RAICHU ; pokedex id
	base_stat_row 80, 90, 70, 110, 90 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 70 ; catch rate  ; set by hand: quick and it shocks you
	db 122 ; base exp

	INCBIN "gfx/pokemon/front/raichu.pic", 0, 1 ; sprite dimensions
	dw RaichuPicFront, RaichuPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Final-stage Electric warrior-mouse. Full electric kit
	; (SHOCK_WAVE/THUNDERBOLT/THUNDER_WAVE); FAINT_ATTACK is a level-up
	; auto; cheek sparks learn HM FLASH. All 4 fun moves (last stage).
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, SHOCK_WAVE, IRON_TAIL, \
	     THUNDER_WAVE, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, FAKE_TEARS, CHARM, TAKE_DOWN, \
	     LIGHT_SCREEN, REFLECT, THUNDERBOLT, DOUBLE_EDGE, FLASH
	; end

	db BANK(RaichuPicFront) ; which bank this mon's pics live in
	assert BANK(RaichuPicFront) == BANK(RaichuPicBack), \
	    "Raichu: front and back pics must share a bank"
