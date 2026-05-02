	db DEX_MACHAMP ; pokedex id
	base_stat_row 100, 130, 85, 65, 80 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 193 ; base exp

	INCBIN "gfx/pokemon/front/machamp.pic", 0, 1 ; sprite dimensions
	dw MachampPicFront, MachampPicBack

	db KARATE_CHOP, LOW_KICK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   QUICK_ATTACK, BIND,         BULLDOZE,     SEISMIC_TOSS, \
	     RAGE,         BODY_SLAM,    BULK_UP,      IRON_HEAD,    TAKE_DOWN, \
	     SWORDS_DANCE, EARTHQUAKE,   DOUBLE_EDGE,  THRASH,       MIMIC, \
	     MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    STRENGTH
	; end

	db 0 ; padding
