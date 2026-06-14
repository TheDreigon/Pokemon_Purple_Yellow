	db DEX_PIKACHU ; pokedex id
	base_stat_row 55, 55, 50, 80, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 82 ; base exp

	INCBIN "gfx/pokemon/front/pikachu.pic", 0, 1 ; sprite dimensions
	dw PikachuPicFront, PikachuPicBack

	db NUZZLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electric mouse pre-evo. auto
	; QUICK_ATTACK/BODY_SLAM/SHOCK_WAVE/IRON_TAIL/THUNDER_WAVE/AGILITY/CHARM/THUNDERBOLT.
	; bonus FAKE_TEARS/LIGHT_SCREEN/REFLECT. HM FLASH.
	tmhm QUICK_ATTACK, BODY_SLAM, SHOCK_WAVE, IRON_TAIL, THUNDER_WAVE, \
	     AGILITY, FAKE_TEARS, CHARM, LIGHT_SCREEN, REFLECT, \
	     THUNDERBOLT, FLASH
	; end

	db 0 ; padding
