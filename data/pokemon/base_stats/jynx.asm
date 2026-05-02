	db DEX_JYNX ; pokedex id
	base_stat_row 65, 60, 50, 110, 95 ; hp atk def spc spd
	db GHOST, ICE ; type
	db 45 ; catch rate
	db 137 ; base exp

	INCBIN "gfx/pokemon/front/jynx.pic", 0, 1 ; sprite dimensions
	dw JynxPicFront, JynxPicBack

	db TACKLE, LOVELY_KISS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ICY_PULSE,    NIGHT_SHADE,  CONFUSE_RAY,  DAZZLE_GLEAM, FAKE_TEARS, \
	     CHARM,        EXTRASENSORY, SCARY_FACE,   PSYCHIC_M,    LIGHT_SCREEN, \
	     ICE_BEAM,     DARK_PULSE,   SHADOW_BALL,  REFLECT,      CALM_MIND, \
	     MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    FLASH
	; end

	db 0 ; padding
