	db DEX_MACHOP ; pokedex id
	base_stat_row 70, 80, 50, 35, 50 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 180 ; catch rate
	db 88 ; base exp

	INCBIN "gfx/pokemon/front/machop.pic", 0, 1 ; sprite dimensions
	dw MachopPicFront, MachopPicBack

	db LOW_KICK, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Disciplined humanoid fighter-in-training.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, BULLDOZE, SEISMIC_TOSS, \
	     RAGE, BULK_UP, TAKE_DOWN, DOUBLE_EDGE, THRASH, \
	     STRENGTH
	; end

	db 0 ; padding
