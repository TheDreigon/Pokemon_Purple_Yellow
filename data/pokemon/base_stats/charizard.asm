	db DEX_CHARIZARD ; pokedex id
	base_stat_row 90, 100, 80, 100, 90 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 45 ; catch rate
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/charizard.pic", 0, 1 ; sprite dimensions
	dw CharizardPicFront, CharizardPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: dragon apex voador. auto
	; FLAME_BURST/IGNITE/AERIAL_ACE/HURRICANE/DRAGON_CLAW/FLAMETHROWER/FLY.
	; bonus
	; ROCK_THROW/QUICK_ATTACK/BODY_SLAM/BULK_UP/INTIMIDATE/TAKE_DOWN/SWORDS_DANCE/EARTHQUAKE/DOUBLE_EDGE/OUTRAGE.
	; HM CUT/FLY/STRENGTH/FLASH. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, BULLDOZE, BODY_SLAM, FLAME_BURST, \
	     IGNITE, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, HURRICANE, DRAGON_CLAW, INTIMIDATE, \
	     TAKE_DOWN, FLAMETHROWER, SWORDS_DANCE, EARTHQUAKE, DOUBLE_EDGE, \
	     OUTRAGE, CUT, FLY, STRENGTH, FLASH
	; end

	db 0 ; padding
