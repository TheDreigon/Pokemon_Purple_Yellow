	db DEX_NIDOKING ; pokedex id
	base_stat_row 90, 100, 90, 75, 75 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 50 ; catch rate  ; final stage, BST 430, harder to handle
	db 180 ; base exp  ; BST 430 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidoking.pic", 0, 1 ; sprite dimensions
	dw NidokingPicFront, NidokingPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex predator male Poison/Ground bruiser, full kit.
	; HM CUT/STRENGTH. Last-stage fun moves via TM.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, FAINT_ATTACK, BULLDOZE, \
	     RAGE, BODY_SLAM, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, POISON_BITE, MEGAHORN, TOXIC, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, THRASH, OUTRAGE, CUT, \
	     STRENGTH, SEISMIC_TOSS, IRON_TAIL, IRON_HEAD, DRAGON_CLAW
	; end

	db BANK(NidokingPicFront) ; which bank this mon's pics live in
	assert BANK(NidokingPicFront) == BANK(NidokingPicBack), \
	    "Nidoking: front and back pics must share a bank"
