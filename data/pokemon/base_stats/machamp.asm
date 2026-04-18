	db DEX_MACHAMP ; pokedex id
	base_stat_row 100, 130, 85, 65, 80 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 193 ; base exp

	INCBIN "gfx/pokemon/front/machamp.pic", 0, 1 ; sprite dimensions
	dw MachampPicFront, MachampPicBack

	db KARATE_CHOP, LOW_KICK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, \
	     RAGE,         EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         METRONOME,    FIRE_BLAST,   HEAD_SMASH,   \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	; end

	db 0 ; padding
