	db DEX_JOLTEON ; pokedex id
	base_stat_row 65, 80, 65, 110, 130 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 75 ; catch rate  ; final stage, BST 450, easy to approach
	db 210 ; base exp  ; eeveelution

	INCBIN "gfx/pokemon/front/jolteon.pic", 0, 1 ; sprite dimensions
	dw JolteonPicFront, JolteonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Electric fox, fastest Eeveelution. HM CUT/FLASH.
	; Fun moves (global last-stage rule): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, FAKE_TEARS, \
	     CHARM, TAKE_DOWN, LIGHT_SCREEN, REFLECT, THUNDERBOLT, \
	     DOUBLE_EDGE, CUT, FLASH
	; end

	db BANK(JolteonPicFront) ; which bank this mon's pics live in
	assert BANK(JolteonPicFront) == BANK(JolteonPicBack), \
	    "Jolteon: front and back pics must share a bank"
