	db DEX_MAROWAK ; pokedex id
	base_stat_row 75, 90, 100, 80, 70 ; hp atk def spc spd
	db GROUND, DARK ; type
	db 75 ; catch rate
	db 124 ; base exp

	INCBIN "gfx/pokemon/front/marowak.pic", 0, 1 ; sprite dimensions
	dw MarowakPicFront, MarowakPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex bone-wielder Ground/Dark; ghost-mother lore backs the dark
	; and ghost moves. Last-stage fun moves allowed.
	tmhm ROCK_THROW, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     NIGHT_SHADE, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, IRON_HEAD, CHARM, INTIMIDATE, SCARY_FACE, \
	     TAKE_DOWN, DARK_PULSE, SHADOW_BALL, SWORDS_DANCE, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, THRASH, OUTRAGE, STRENGTH, \
	     SEISMIC_TOSS, CUT
	; end

	db 0 ; padding
