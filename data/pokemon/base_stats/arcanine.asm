	db DEX_ARCANINE ; pokedex id
	base_stat_row 100, 100, 80, 80, 95 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 60 ; catch rate  ; final stage, BST 455
	db 213 ; base exp

	INCBIN "gfx/pokemon/front/arcanine.pic", 0, 1 ; sprite dimensions
	dw ArcaninePicFront, ArcaninePicBack

	db BITE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex legendary Fire canine. SEISMIC_TOSS is a level-up auto (L56).
	tmhm QUICK_ATTACK, FAINT_ATTACK, SEISMIC_TOSS, RAGE, BODY_SLAM, \
	     FLAME_BURST, IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, INTIMIDATE, SCARY_FACE, TAKE_DOWN, \
	     FLAMETHROWER, SWORDS_DANCE, DOUBLE_EDGE, THRASH, CUT, \
	     STRENGTH, DRAGON_CLAW
	; end

	db BANK(ArcaninePicFront) ; which bank this mon's pics live in
	assert BANK(ArcaninePicFront) == BANK(ArcaninePicBack), \
	    "Arcanine: front and back pics must share a bank"
