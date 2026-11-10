	db DEX_DREADROW ; pokedex id
	base_stat_row 90, 115, 90, 75, 75, 85 ; hp atk def spatk spdef spd

	db DARK, FLYING ; type
	db 45 ; catch rate  ; final stage, BST 530, harder to handle
	db 170 ; base exp  ; BST 530

	INCBIN "gfx/pokemon/front/dreadrow.pic", 0, 1 ; sprite dimensions
	dw DreadrowPicFront, DreadrowPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v1.0 (2026-11-09): the aged hunter FEAROW becomes at L40, the first
	; species past the 151. FEAROW's machines, the four fun moves of a last
	; stage, SCARY_FACE and DARK_PULSE. HM CUT/FLY.
	tmhm QUICK_ATTACK, FAINT_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, INTIMIDATE, SCARY_FACE, TAKE_DOWN, \
	     DARK_PULSE, SWORDS_DANCE, DOUBLE_EDGE, CUT, FLY
	; end

	db BANK(DreadrowPicFront) ; which bank this mon's pics live in
	assert BANK(DreadrowPicFront) == BANK(DreadrowPicBack), \
	    "Dreadrow: front and back pics must share a bank"
