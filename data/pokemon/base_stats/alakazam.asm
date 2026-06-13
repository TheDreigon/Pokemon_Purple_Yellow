	db DEX_ALAKAZAM ; pokedex id
	base_stat_row 55, 50, 45, 135, 125 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 50 ; catch rate
	db 186 ; base exp

	INCBIN "gfx/pokemon/front/alakazam.pic", 0, 1 ; sprite dimensions
	dw AlakazamPicFront, AlakazamPicBack

	db TELEPORT, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AGILITY,      CALM_MIND,    DARK_PULSE,   DAZZLE_GLEAM, EXTRASENSORY, \
	     FAKE_TEARS,   LIGHT_SCREEN, METRONOME,    PSYCHIC_M,    REFLECT, \
	     SHADOW_BALL,  SHOCK_WAVE,   MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     FLASH
	; end

	db 0 ; padding
