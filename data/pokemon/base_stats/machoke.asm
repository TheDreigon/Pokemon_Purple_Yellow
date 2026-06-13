	db DEX_MACHOKE ; pokedex id
	base_stat_row 90, 100, 70, 65, 60 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 90 ; catch rate
	db 146 ; base exp

	INCBIN "gfx/pokemon/front/machoke.pic", 0, 1 ; sprite dimensions
	dw MachokePicFront, MachokePicBack

	db LOW_KICK, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   QUICK_ATTACK, BIND,         BULLDOZE,     SEISMIC_TOSS, \
	     RAGE,         BODY_SLAM,    BULK_UP,      TAKE_DOWN,    SWORDS_DANCE, \
	     EARTHQUAKE,   DOUBLE_EDGE,  THRASH,       STRENGTH
	; end

	db 0 ; padding
