	db DEX_TANGELA ; pokedex id
	base_stat_row 80, 60, 100, 70, 50 ; hp atk def spc spd

	db GRASS, WATER ; type — v0.7 Forte: Tangela now Grass/Water dual
	db 45 ; catch rate
	db 166 ; base exp

	INCBIN "gfx/pokemon/front/tangela.pic", 0, 1 ; sprite dimensions
	dw TangelaPicFront, TangelaPicBack

	db CONSTRICT, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BIND,         BODY_SLAM,    GIGA_DRAIN,   LEECH_LIFE,   PETAL_DANCE, \
	     TAKE_DOWN,    WATER_PULSE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    CUT,          SURF
	; end

	db 0 ; padding
