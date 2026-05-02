	db DEX_CLEFAIRY ; pokedex id
	base_stat_row 70, 45, 50, 70, 45 ; hp atk def spc spd
	db FAIRY, FAIRY ; type
	db 150 ; catch rate
	db 68 ; base exp

	INCBIN "gfx/pokemon/front/clefairy.pic", 0, 1 ; sprite dimensions
	dw ClefairyPicFront, ClefairyPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    CALM_MIND,    CHARM,        DAZZLE_GLEAM, EXTRASENSORY, \
	     FAKE_TEARS,   LIGHT_SCREEN, METRONOME,    MIMIC,        PSYCHIC_M, \
	     REFLECT
	; end

	db 0 ; padding
