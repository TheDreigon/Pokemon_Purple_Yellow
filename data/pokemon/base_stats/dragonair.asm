	db DEX_DRAGONAIR ; pokedex id
	base_stat_row 80, 80, 60, 80, 70 ; hp atk def spc spd

	db DRAGON, DRAGON ; type
	db 27 ; catch rate
	db 144 ; base exp

	INCBIN "gfx/pokemon/front/dragonair.pic", 0, 1 ; sprite dimensions
	dw DragonairPicFront, DragonairPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AERIAL_ACE,   AGILITY,      BIND,         BODY_SLAM,    DRAGON_CLAW, \
	     ICE_BEAM,     ICY_PULSE,    IRON_TAIL,    OUTRAGE,      SHOCK_WAVE, \
	     TAKE_DOWN,    WATER_PULSE,  SURF,         STRENGTH,     FLY
	; end

	db 0 ; padding
