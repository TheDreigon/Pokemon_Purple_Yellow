	db DEX_MAGMAR ; pokedex id
	base_stat_row 75, 95, 75, 95, 85 ; hp atk def spc spd
	db FIRE, MAGMA ; type
	db 45 ; catch rate
	db 167 ; base exp

	INCBIN "gfx/pokemon/front/magmar.pic", 0, 1 ; sprite dimensions
	dw MagmarPicFront, MagmarPicBack

	db EMBER, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BULLDOZE,     BODY_SLAM,    FLAME_BURST,  IGNITE,       TAKE_DOWN, \
	     LIGHT_SCREEN, FLAMETHROWER, REFLECT,      EARTHQUAKE,   ROCK_SLIDE, \
	     DOUBLE_EDGE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME, \
	     CUT,          STRENGTH,     FLASH
	; end

	db 0 ; padding
