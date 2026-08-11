	db DEX_PIKACHU ; pokedex id
	base_stat_row 60, 55, 50, 80, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 100 ; catch rate  ; set by hand: fast, skittish, and it shocks whoever grabs it
	db 120 ; base exp  ; escolha dele

	INCBIN "gfx/pokemon/front/pikachu.pic", 0, 1 ; sprite dimensions
	dw PikachuPicFront, PikachuPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Electric mouse pre-evo. Level-up autos (levelup subset-of TM):
	; QUICK_ATTACK/FAINT_ATTACK/BODY_SLAM/SHOCK_WAVE/IRON_TAIL/
	; THUNDER_WAVE/AGILITY/CHARM/THUNDERBOLT/DOUBLE_EDGE, plus
	; FAKE_TEARS/LIGHT_SCREEN/REFLECT. HM FLASH. No fun moves (pre-evo).
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, SHOCK_WAVE, IRON_TAIL, \
	     THUNDER_WAVE, AGILITY, FAKE_TEARS, CHARM, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, DOUBLE_EDGE, FLASH
	; end

	db BANK(PikachuPicFront) ; which bank this mon's pics live in
	assert BANK(PikachuPicFront) == BANK(PikachuPicBack), \
	    "Pikachu: front and back pics must share a bank"
