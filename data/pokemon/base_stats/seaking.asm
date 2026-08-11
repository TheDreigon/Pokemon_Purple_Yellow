	db DEX_SEAKING ; pokedex id
	base_stat_row 90, 90, 70, 80, 75 ; hp atk def spc spd

	db WATER, WATER ; type
	db 85 ; catch rate  ; set by hand
	db 160 ; base exp  ; BST 405

	INCBIN "gfx/pokemon/front/seaking.pic", 0, 1 ; sprite dimensions
	dw SeakingPicFront, SeakingPicBack

	db TAIL_WHIP, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex horned river guardian. MEGAHORN signature off the horn.
	tmhm WATER_PULSE, ICY_PULSE, RAGE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, MEGAHORN, \
	     SCARY_FACE, TAKE_DOWN, ICE_BEAM, SURF, STRENGTH
	; end

	db BANK(SeakingPicFront) ; which bank this mon's pics live in
	assert BANK(SeakingPicFront) == BANK(SeakingPicBack), \
	    "Seaking: front and back pics must share a bank"
