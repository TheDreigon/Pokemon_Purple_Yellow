	db DEX_NINETALES ; pokedex id
	base_stat_row 80, 70, 70, 110, 105 ; hp atk def spc spd
	db FIRE, FAIRY ; type
	db 75 ; catch rate
	db 178 ; base exp

	INCBIN "gfx/pokemon/front/ninetales.pic", 0, 1 ; sprite dimensions
	dw NinetalesPicFront, NinetalesPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm QUICK_ATTACK, BODY_SLAM,    FLAME_BURST,  NIGHT_SHADE,  CONFUSE_RAY, \
	     IGNITE,       AGILITY,      FAKE_TEARS,   CHARM,        DAZZLE_GLEAM, \
	     EXTRASENSORY, PSYCHIC_M,    LIGHT_SCREEN, SHADOW_BALL,  FLAMETHROWER, \
	     REFLECT,      CALM_MIND,    MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    FLASH
	; end

	db 0 ; padding
