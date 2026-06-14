	db DEX_JOLTEON ; pokedex id
	base_stat_row 65, 80, 65, 110, 130 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 197 ; base exp

	INCBIN "gfx/pokemon/front/jolteon.pic", 0, 1 ; sprite dimensions
	dw JolteonPicFront, JolteonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electric fox, fastest Eeveelution. auto
	; QUICK_ATTACK/BODY_SLAM/SHOCK_WAVE/THUNDER_WAVE/AGILITY/CHARM/TAKE_DOWN/THUNDERBOLT/DOUBLE_EDGE.
	; bonus FAKE_TEARS/LIGHT_SCREEN/REFLECT. HM FLASH. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, FAKE_TEARS, \
	     CHARM, TAKE_DOWN, LIGHT_SCREEN, REFLECT, THUNDERBOLT, \
	     DOUBLE_EDGE, FLASH
	; end

	db 0 ; padding
