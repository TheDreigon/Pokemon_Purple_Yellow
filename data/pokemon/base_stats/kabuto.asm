	db DEX_KABUTO ; pokedex id
	base_stat_row 35, 80, 90, 45, 40 ; hp atk def spc spd
	db ROCK, BUG ; type
	db 45 ; catch rate
	db 119 ; base exp

	INCBIN "gfx/pokemon/front/kabuto.pic", 0, 1 ; sprite dimensions
	dw KabutoPicFront, KabutoPicBack

	db SCRATCH, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    ICE_BEAM,     ICY_PULSE,    LEECH_LIFE,   ROCK_THROW, \
	     TAKE_DOWN,    WATER_PULSE
	; end

	db 0 ; padding
