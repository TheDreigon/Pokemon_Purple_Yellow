	db DEX_DRATINI ; pokedex id
	base_stat_row 60, 60, 40, 50, 60 ; hp atk def spc spd

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 67 ; base exp

	INCBIN "gfx/pokemon/front/dratini.pic", 0, 1 ; sprite dimensions
	dw DratiniPicFront, DratiniPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm BIND,         BODY_SLAM,    DRAGON_CLAW,  ICY_PULSE,    IRON_TAIL, \
	     SHOCK_WAVE,   TAKE_DOWN,    WATER_PULSE
	; end

	db 0 ; padding
