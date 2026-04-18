	db DEX_HITMONLEE ; pokedex id
	base_stat_row 80, 110, 70, 60, 100 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 139 ; base exp

	INCBIN "gfx/pokemon/front/hitmonlee.pic", 0, 1 ; sprite dimensions
	dw HitmonleePicFront, HitmonleePicBack

	db DOUBLE_KICK, CALM_MIND, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   HEAVY_SLAM,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  SUBMISSION,   CALM_MIND,      SEISMIC_TOSS, RAGE,         \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         METRONOME,    DISCHARGE,        \
	     HEAD_SMASH,   REST,         SUBSTITUTE,   STRENGTH, ROCK_SLIDE
	; end

	db 0 ; padding
