	db DEX_LAPRAS ; pokedex id
	base_stat_row 130, 75, 95, 100, 60 ; hp atk def spc spd

	db WATER, ICE ; type
	db 90 ; catch rate  ; solo stage, BST 460, easy to approach
	db 219 ; base exp

	INCBIN "gfx/pokemon/front/lapras.pic", 0, 1 ; sprite dimensions
	dw LaprasPicFront, LaprasPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Docile singing ferry, huge Water/Ice tank. Core
	; WATER_PULSE/ICY_PULSE/BODY_SLAM/CONFUSE_RAY/CHARM/ICE_BEAM. Bonus
	; DAZZLE_GLEAM/TOXIC/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/REFLECT. HM
	; SURF/STRENGTH. Fun (last-stage)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, CONFUSE_RAY, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, CHARM, \
	     TOXIC, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, \
	     REFLECT, SURF, STRENGTH
	; end

	db 0 ; padding
