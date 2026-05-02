	db DEX_MR_MIME ; pokedex id
	base_stat_row 60, 50, 65, 110, 95 ; hp atk def spc spd
	db PSYCHIC_TYPE, FAIRY ; type
	db 45 ; catch rate
	db 136 ; base exp

	INCBIN "gfx/pokemon/front/mr.mime.pic", 0, 1 ; sprite dimensions
	dw MrMimePicFront, MrMimePicBack

	db REFLECT, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    CHARM,        DAZZLE_GLEAM, EXTRASENSORY, FAKE_TEARS, \
	     LIGHT_SCREEN, METRONOME,    MIMIC,        MIRROR_MOVE,  PETAL_DANCE, \
	     PSYCHIC_M,    REFLECT,      SHADOW_BALL,  SUBSTITUTE
	; end

	db 0 ; padding
