	db DEX_AERODACTYL ; pokedex id
	base_stat_row 70, 110, 80, 75, 120 ; hp atk def spc spd

	db ROCK, FLYING ; type
	db 45 ; catch rate
	db 202 ; base exp

	INCBIN "gfx/pokemon/front/aerodactyl.pic", 0, 1 ; sprite dimensions
	dw AerodactylPicFront, AerodactylPicBack

	db WING_ATTACK, AGILITY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,   AGILITY,      DOUBLE_EDGE,  DRAGON_CLAW,  FAINT_ATTACK, \
	     INTIMIDATE,   QUICK_ATTACK, ROCK_SLIDE,   ROCK_THROW,   SCARY_FACE, \
	     SWORDS_DANCE, TAKE_DOWN,    MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    CUT,          FLY,          STRENGTH
	; end

	db 0 ; padding
