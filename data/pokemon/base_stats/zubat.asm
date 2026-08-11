	db DEX_ZUBAT ; pokedex id
	base_stat_row 40, 45, 35, 40, 90 ; hp atk def spc spd

	db POISON, FLYING ; type
	db 230 ; catch rate  ; base stage, BST 250
	db 70 ; base exp  ; BST 250 - poucas fraquezas (+2)

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

	db BANK(ZubatPicFront) ; which bank this mon's pics live in
	assert BANK(ZubatPicFront) == BANK(ZubatPicBack), \
	    "Zubat: front and back pics must share a bank"
