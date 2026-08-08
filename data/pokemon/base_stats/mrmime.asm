	db DEX_MR_MIME ; pokedex id
	base_stat_row 60, 50, 65, 110, 95 ; hp atk def spc spd
	db PSYCHIC_TYPE, FAIRY ; type
	db 65 ; catch rate  ; set by hand: it puts a wall between you and it
	db 136 ; base exp

	INCBIN "gfx/pokemon/front/mr.mime.pic", 0, 1 ; sprite dimensions
	dw MrMimePicFront, MrMimePicBack

	db TACKLE, HINDER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Psychic/Fairy mime, single-stage (counts as last-stage for fun
	; moves).
	tmhm MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, \
	     FAKE_TEARS, CHARM, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, \
	     REFLECT, PETAL_DANCE
	; end

	db 0 ; padding
