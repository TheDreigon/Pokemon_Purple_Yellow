	db DEX_WIGGLYTUFF ; pokedex id
	base_stat_row 140, 70, 40, 70, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 50 ; catch rate
	db 109 ; base exp

	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Normal/Fairy balloon singer. auto
	; RAGE/BODY_SLAM/MIRROR_MOVE/FAKE_TEARS/CHARM/FLY. bonus
	; DAZZLE_GLEAM/EXTRASENSORY/PSYCHIC_M/DOUBLE_EDGE. HM FLY. fun (4
	; via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm RAGE, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, \
	     PSYCHIC_M, DOUBLE_EDGE, FLY
	; end

	db 0 ; padding
