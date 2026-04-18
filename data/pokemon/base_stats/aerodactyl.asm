	db DEX_AERODACTYL ; pokedex id
	base_stat_row 70, 110, 80, 75, 120 ; hp atk def spc spd

	db ROCK, FLYING ; type
	db 45 ; catch rate
	db 202 ; base exp

	INCBIN "gfx/pokemon/front/aerodactyl.pic", 0, 1 ; sprite dimensions
	dw AerodactylPicFront, AerodactylPicBack

	db WING_ATTACK, AGILITY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,   FLAMETHROWER,   TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         DRAGON_RAGE,  EARTHQUAKE, MIMIC,          \
	     DOUBLE_TEAM, REFLECT,      BIDE,         FIRE_BLAST,   DISCHARGE,         \
		 HURRICANE,  REST,         SUBSTITUTE,   FLY,  ROCK_SLIDE
	; end

	db 0 ; padding
