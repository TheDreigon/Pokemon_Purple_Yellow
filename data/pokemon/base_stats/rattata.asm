	db DEX_RATTATA ; pokedex id
	base_stat_row 35, 60, 35, 25, 80 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 255 ; catch rate
	db 57 ; base exp

	INCBIN "gfx/pokemon/front/rattata.pic", 0, 1 ; sprite dimensions
	dw RattataPicFront, RattataPicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: rodent. Levelup-doubles for Quick Attack, Body Slam,
	; Hone Claws, Poison Fang, Agility, Double Edge, Cut. TOXIC TM per
	; Forte #6 (rats carry disease).
	tmhm QUICK_ATTACK, BODY_SLAM,    POISON_FANG,  TOXIC,        DOUBLE_EDGE, \
	     TAKE_DOWN,    AGILITY,      CUT
	; end

	db 0 ; padding
