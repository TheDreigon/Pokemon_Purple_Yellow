	db DEX_CHARIZARD ; pokedex id
	base_stat_row 90, 100, 80, 100, 90 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 55 ; catch rate  ; final stage, BST 460
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/charizard.pic", 0, 1 ; sprite dimensions
	dw CharizardPicFront, CharizardPicBack

	db SCRATCH, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex flying dragon. Fire offense (FLAME_BURST/IGNITE/FLAMETHROWER)
	; plus dragon heritage (DRAGON_CLAW/OUTRAGE) and aerial moves
	; (AERIAL_ACE/HURRICANE/FLY). Heavy melee (BODY_SLAM/EARTHQUAKE/BULLDOZE),
	; setup (BULK_UP/SWORDS_DANCE), INTIMIDATE. 4 fun moves (last stage).
	; Ladder prereq: ROCK_THROW.
	tmhm ROCK_THROW, QUICK_ATTACK, BULLDOZE, BODY_SLAM, FLAME_BURST, \
	     IGNITE, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, HURRICANE, DRAGON_CLAW, INTIMIDATE, \
	     TAKE_DOWN, FLAMETHROWER, SWORDS_DANCE, EARTHQUAKE, DOUBLE_EDGE, \
	     OUTRAGE, CUT, FLY, STRENGTH, FLASH, \
	     SEISMIC_TOSS, IRON_TAIL, BIND, ROCK_SLIDE
	; end

	db 0 ; padding
