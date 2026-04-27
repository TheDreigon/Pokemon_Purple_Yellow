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
	; v0.7 Pass 3: small bat. Levelup-doubles for several. TOXIC TM per
	; Forte #6. NO FLY (Forte: Golbat-only natural — small wings can't
	; carry rider).
	tmhm QUICK_ATTACK, LEECH_LIFE,   POISON_FANG,  AERIAL_ACE,   TOXIC,        \
	     AGILITY,      CUT
	; end

	db 0 ; padding
