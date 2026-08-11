	db DEX_SCYTHER ; pokedex id
	base_stat_row 60, 105, 80, 55, 110 ; hp atk def spc spd

	db BUG, FLYING ; type
	db 70 ; catch rate  ; solo stage, BST 410, harder to handle
	db 155 ; base exp  ; BST 410 - muitas fraquezas (-5)

	INCBIN "gfx/pokemon/front/scyther.pic", 0, 1 ; sprite dimensions
	dw ScytherPicFront, ScytherPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Blade-ninja mantis; speed/blades identity (vs Pinsir). Scythe
	; arms drive SWORDS_DANCE/DRAGON_CLAW/CUT, wings AGILITY/AERIAL_ACE.
	tmhm QUICK_ATTACK, FAINT_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, DRAGON_CLAW, SCARY_FACE, \
	     TAKE_DOWN, DARK_PULSE, SWORDS_DANCE, DOUBLE_EDGE, CUT, \
	     FLY
	; end

	db BANK(ScytherPicFront) ; which bank this mon's pics live in
	assert BANK(ScytherPicFront) == BANK(ScytherPicBack), \
	    "Scyther: front and back pics must share a bank"
