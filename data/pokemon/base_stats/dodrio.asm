	db DEX_DODRIO ; pokedex id
	base_stat_row 60, 120, 60, 60, 110 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 60 ; catch rate  ; final stage, BST 410, harder to handle
	db 160 ; base exp  ; BST 410 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/dodrio.pic", 0, 1 ; sprite dimensions
	dw DodrioPicFront, DodrioPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Three-headed ratite, last-stage apex of the line. HM CUT/STRENGTH.
	; Fun moves (last-stage) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     INTIMIDATE, TAKE_DOWN, DOUBLE_EDGE, THRASH, CUT, \
	     STRENGTH
	; end

	db BANK(DodrioPicFront) ; which bank this mon's pics live in
	assert BANK(DodrioPicFront) == BANK(DodrioPicBack), \
	    "Dodrio: front and back pics must share a bank"
