	db DEX_FLAREON ; pokedex id
	base_stat_row 65, 110, 80, 130, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 75 ; catch rate  ; final stage, BST 450, easy to approach
	db 210 ; base exp  ; eeveelution

	INCBIN "gfx/pokemon/front/flareon.pic", 0, 1 ; sprite dimensions
	dw FlareonPicFront, FlareonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Fire fox with strong claws. HM CUT/FLASH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, FLAME_BURST, IGNITE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     FAKE_TEARS, CHARM, TAKE_DOWN, LIGHT_SCREEN, FLAMETHROWER, \
	     REFLECT, SWORDS_DANCE, DOUBLE_EDGE, CUT, FLASH
	; end

	db BANK(FlareonPicFront) ; which bank this mon's pics live in
	assert BANK(FlareonPicFront) == BANK(FlareonPicBack), \
	    "Flareon: front and back pics must share a bank"
