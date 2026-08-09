	db DEX_SANDSLASH ; pokedex id
	base_stat_row 70, 110, 110, 55, 65 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 75 ; catch rate  ; final stage, BST 410
	db 163 ; base exp

	INCBIN "gfx/pokemon/front/sandslash.pic", 0, 1 ; sprite dimensions
	dw SandslashPicFront, SandslashPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex armoured spiked digger with long claws; claws drive
	; SWORDS_DANCE/DRAGON_CLAW/CUT, the digging body the ground moves.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, IRON_TAIL, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, DRAGON_CLAW, \
	     TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, \
	     CUT, STRENGTH
	; end

	db BANK(SandslashPicFront) ; which bank this mon's pics live in
	assert BANK(SandslashPicFront) == BANK(SandslashPicBack), \
	    "Sandslash: front and back pics must share a bank"
