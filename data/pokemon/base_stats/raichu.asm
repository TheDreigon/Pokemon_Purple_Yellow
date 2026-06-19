	db DEX_RAICHU ; pokedex id
	base_stat_row 80, 90, 70, 110, 90 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 75 ; catch rate
	db 122 ; base exp

	INCBIN "gfx/pokemon/front/raichu.pic", 0, 1 ; sprite dimensions
	dw RaichuPicFront, RaichuPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: bigger orange warrior-mouse final stage. auto
	; QUICK_ATTACK/BODY_SLAM/SHOCK_WAVE/IRON_TAIL/THUNDER_WAVE/AGILITY/CHARM/THUNDERBOLT/DOUBLE_EDGE.
	; bonus BULK_UP/FAKE_TEARS/TAKE_DOWN/LIGHT_SCREEN/REFLECT. HM FLASH.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BODY_SLAM, SHOCK_WAVE, IRON_TAIL, THUNDER_WAVE, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     AGILITY, FAKE_TEARS, CHARM, TAKE_DOWN, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, DOUBLE_EDGE, FLASH
	; end

	db 0 ; padding
