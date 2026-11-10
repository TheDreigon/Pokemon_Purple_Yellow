	db DEX_FEAROW ; pokedex id
	base_stat_row 65, 95, 65, 60, 60, 90 ; hp atk def spatk spdef spd

	db NORMAL, FLYING ; type
	db 100 ; catch rate  ; mid stage, BST 435, harder to handle
	db 135 ; base exp  ; BST 435

	INCBIN "gfx/pokemon/front/fearow.pic", 0, 1 ; sprite dimensions
	dw FearowPicFront, FearowPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; The raptor before DREADROW (it evolves at L40, 2026-11-09), DRILL_PECK
	; (shared with Dodrio line/Zapdos/Beedrill). No fun moves: a middle
	; stage leaves them to its last one. HM CUT/FLY.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE, INTIMIDATE, TAKE_DOWN, \
	     SWORDS_DANCE, DOUBLE_EDGE, CUT, FLY
	; end

	db BANK(FearowPicFront) ; which bank this mon's pics live in
	assert BANK(FearowPicFront) == BANK(FearowPicBack), \
	    "Fearow: front and back pics must share a bank"
