	db DEX_MAROWAK ; pokedex id
	base_stat_row 75, 90, 100, 80, 70 ; hp atk def spc spd
	db GROUND, DARK ; type
	db 75 ; catch rate
	db 124 ; base exp

	INCBIN "gfx/pokemon/front/marowak.pic", 0, 1 ; sprite dimensions
	dw MarowakPicFront, MarowakPicBack

	db GROWL, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   BULLDOZE,     RAGE,         BODY_SLAM,    BULK_UP, \
	     FAINT_ATTACK, CHARM,        TAKE_DOWN,    SWORDS_DANCE, ROCK_SLIDE, \
	     DOUBLE_EDGE,  QUICK_ATTACK, NIGHT_SHADE,  IRON_HEAD,    EXTRASENSORY, \
	     INTIMIDATE,   SCARY_FACE,   DARK_PULSE,   PSYCHIC_M,    EARTHQUAKE, \
	     SHADOW_BALL,  THRASH,       OUTRAGE,      MIMIC,        MIRROR_MOVE, \
	     SUBSTITUTE,   METRONOME,    STRENGTH
	; end

	db 0 ; padding
