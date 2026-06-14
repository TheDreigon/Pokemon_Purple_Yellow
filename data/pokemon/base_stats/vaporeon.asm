	db DEX_VAPOREON ; pokedex id
	base_stat_row 130, 65, 65, 110, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 196 ; base exp

	INCBIN "gfx/pokemon/front/vaporeon.pic", 0, 1 ; sprite dimensions
	dw VaporeonPicFront, VaporeonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Water fox, fluid body that masters ice. auto
	; QUICK_ATTACK/WATER_PULSE/BODY_SLAM/CHARM/TAKE_DOWN/ICE_BEAM/DOUBLE_EDGE/SURF.
	; bonus AGILITY/FAKE_TEARS/LIGHT_SCREEN/REFLECT. HM SURF. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, WATER_PULSE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, FAKE_TEARS, CHARM, \
	     TAKE_DOWN, LIGHT_SCREEN, ICE_BEAM, REFLECT, DOUBLE_EDGE, \
	     SURF
	; end

	db 0 ; padding
