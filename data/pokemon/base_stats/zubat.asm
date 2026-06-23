	db DEX_ZUBAT ; pokedex id
	base_stat_row 40, 45, 35, 40, 90 ; hp atk def spc spd

	db POISON, FLYING ; type
	db 255 ; catch rate
	db 54 ; base exp

	INCBIN "gfx/pokemon/front/zubat.pic", 0, 1 ; sprite dimensions
	dw ZubatPicFront, ZubatPicBack

	db BITE, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Small vampire bat. Quick aerial strikes, life-draining bites and
	; toxic moves. Natural HM flyer/cutter.
	tmhm QUICK_ATTACK, AGILITY, POISON_BITE, AERIAL_ACE, TOXIC, \
	     LEECH_LIFE, CUT, FLY
	; end

	db 0 ; padding
