	db DEX_KABUTO ; pokedex id
	base_stat_row 35, 80, 90, 45, 40 ; hp atk def spc spd
	db ROCK, BUG ; type
	db 45 ; catch rate
	db 119 ; base exp

	INCBIN "gfx/pokemon/front/kabuto.pic", 0, 1 ; sprite dimensions
	dw KabutoPicFront, KabutoPicBack

	db SCRATCH, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: armored trilobite-crab fossil (Rock/Bug here),
	; aquatic pre-evo backbone. auto
	; ROCK_THROW/ICY_PULSE/LEECH_LIFE/CUT. bonus
	; WATER_PULSE/BODY_SLAM/TAKE_DOWN/ICE_BEAM. HM CUT.
	tmhm ROCK_THROW, WATER_PULSE, ICY_PULSE, BODY_SLAM, LEECH_LIFE, \
	     TAKE_DOWN, ICE_BEAM, CUT
	; end

	db 0 ; padding
