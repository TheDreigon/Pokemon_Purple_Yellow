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
	; Dragon sea-serpent mid-evo. HM FLY/SURF/STRENGTH.
	tmhm BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, SHOCK_WAVE, \
	     IRON_TAIL, DRAGON_CLAW, TAKE_DOWN, ICE_BEAM, FLY, \
	     SURF, STRENGTH
	; end

	db 0 ; padding
