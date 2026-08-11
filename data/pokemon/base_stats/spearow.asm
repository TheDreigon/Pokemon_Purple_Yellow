	db DEX_SPEAROW ; pokedex id
	base_stat_row 40, 65, 35, 30, 65 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 235 ; catch rate  ; base stage, BST 235
	db 55 ; base exp  ; BST 235 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/spearow.pic", 0, 1 ; sprite dimensions
	dw SpearowPicFront, SpearowPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Aggressive bird-of-prey (honorary Dark/Flying), pre-evo backbone.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE, TAKE_DOWN, DOUBLE_EDGE, \
	     CUT, FLY
	; end

	db BANK(SpearowPicFront) ; which bank this mon's pics live in
	assert BANK(SpearowPicFront) == BANK(SpearowPicBack), \
	    "Spearow: front and back pics must share a bank"
