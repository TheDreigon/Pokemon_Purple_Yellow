	db DEX_TANGELA ; pokedex id
	base_stat_row 80, 60, 100, 70, 50 ; hp atk def spc spd

	db GRASS, WATER ; type — v0.7 Forte: Tangela now Grass/Water dual
	db 45 ; catch rate
	db 166 ; base exp

	INCBIN "gfx/pokemon/front/tangela.pic", 0, 1 ; sprite dimensions
	dw TangelaPicFront, TangelaPicBack

	db CONSTRICT, HINDER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Grass/Water single-stage, semi-defensive vine blob that constricts
	; (BIND) and drains (GIGA_DRAIN/LEECH_LIFE). Last-stage fun moves via
	; TM.
	tmhm BIND, WATER_PULSE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, GIGA_DRAIN, LEECH_LIFE, PETAL_DANCE, \
	     CUT, SURF
	; end

	db 0 ; padding
