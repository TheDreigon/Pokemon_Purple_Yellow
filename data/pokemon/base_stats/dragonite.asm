	db DEX_DRAGONITE ; pokedex id
	base_stat_row 110, 115, 80, 110, 85 ; hp atk def spc spd
	db DRAGON, DRAGON ; type
	db 9 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/dragonite.pic", 0, 1 ; sprite dimensions
	dw DragonitePicFront, DragonitePicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,   AGILITY,      BIND,         BODY_SLAM,    BULK_UP, \
	     BULLDOZE,     DOUBLE_EDGE,  DRAGON_CLAW,  EARTHQUAKE,   EXTRASENSORY, \
	     HURRICANE,    ICE_BEAM,     ICY_PULSE,    INTIMIDATE,   IRON_HEAD, \
	     IRON_TAIL,    OUTRAGE,      QUICK_ATTACK, ROCK_SLIDE,   SHOCK_WAVE, \
	     TAKE_DOWN,    THRASH,       WATER_PULSE,  MIMIC,        MIRROR_MOVE, \
	     SUBSTITUTE,   METRONOME,    CUT,          SURF,         STRENGTH, \
	     FLY
	; end

	db 0 ; padding
