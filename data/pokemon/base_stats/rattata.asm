	db DEX_RATTATA ; pokedex id
	base_stat_row 35, 60, 35, 25, 80 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 235 ; catch rate  ; base stage, BST 235
	db 55 ; base exp  ; BST 235

	INCBIN "gfx/pokemon/front/rattata.pic", 0, 1 ; sprite dimensions
	dw RattataPicFront, RattataPicBack

	db BITE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Sharp-fanged Normal rodent pre-evo. Fangs justify POISON_BITE/
	; FAINT_ATTACK; gnawing incisors learn HM CUT.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, AGILITY, \
	     POISON_BITE, TOXIC, TAKE_DOWN, DOUBLE_EDGE, CUT
	; end

	db BANK(RattataPicFront) ; which bank this mon's pics live in
	assert BANK(RattataPicFront) == BANK(RattataPicBack), \
	    "Rattata: front and back pics must share a bank"
