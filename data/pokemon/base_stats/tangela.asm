	db DEX_TANGELA ; pokedex id
	base_stat_row 40, 60, 100, 80, 80, 50 ; hp atk def spatk spdef spd

	db GRASS, WATER ; type
	db 150 ; catch rate  ; set by hand: vines and not much else; it does not fight back
	db 125 ; base exp  ; BST 410

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

	db BANK(TangelaPicFront) ; which bank this mon's pics live in
	assert BANK(TangelaPicFront) == BANK(TangelaPicBack), \
	    "Tangela: front and back pics must share a bank"
