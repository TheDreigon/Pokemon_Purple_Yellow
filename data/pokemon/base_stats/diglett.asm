	db DEX_DIGLETT ; pokedex id
	base_stat_row 15, 60, 25, 40, 95 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 255 ; catch rate
	db 81 ; base exp

	INCBIN "gfx/pokemon/front/diglett.pic", 0, 1 ; sprite dimensions
	dw DiglettPicFront, DiglettPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    AGILITY,      TAKE_DOWN, \
	     EARTHQUAKE
	; end

	db 0 ; padding
