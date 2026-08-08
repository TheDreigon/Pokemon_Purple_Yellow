	db DEX_VAPOREON ; pokedex id
	base_stat_row 130, 65, 65, 110, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 75 ; catch rate  ; final stage, BST 450, easy to approach
	db 196 ; base exp

	INCBIN "gfx/pokemon/front/vaporeon.pic", 0, 1 ; sprite dimensions
	dw VaporeonPicFront, VaporeonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water fox with a fluid body that masters ice (WATER_PULSE/ICY_PULSE/
	; ICE_BEAM/SURF). Cute gestures (CHARM/FAKE_TEARS). Last-stage fun moves via
	; TM.
	tmhm QUICK_ATTACK, WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, FAKE_TEARS, \
	     CHARM, TAKE_DOWN, LIGHT_SCREEN, ICE_BEAM, REFLECT, \
	     DOUBLE_EDGE, SURF
	; end

	db 0 ; padding
