	db DEX_NIDOQUEEN ; pokedex id
	base_stat_row 100, 85, 90, 80, 75 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 50 ; catch rate  ; final stage, BST 430, harder to handle
	db 180 ; base exp  ; BST 430 - poucas fraquezas (+5)

	INCBIN "gfx/pokemon/front/nidoqueen.pic", 0, 1 ; sprite dimensions
	dw NidoqueenPicFront, NidoqueenPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Matriarch, fairy-tinged Poison/Ground apex. HM CUT/STRENGTH.
	; Last-stage fun moves via TM. Ladder prereqs: ROCK_THROW, BULLDOZE.
	tmhm ROCK_THROW, QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, BODY_SLAM, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, POISON_BITE, FAKE_TEARS, CHARM, TOXIC, \
	     INTIMIDATE, TAKE_DOWN, SWORDS_DANCE, CALM_MIND, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, CUT, STRENGTH, SEISMIC_TOSS, \
	     IRON_TAIL, IRON_HEAD, MEGAHORN, DRAGON_CLAW
	; end

	db BANK(NidoqueenPicFront) ; which bank this mon's pics live in
	assert BANK(NidoqueenPicFront) == BANK(NidoqueenPicBack), \
	    "Nidoqueen: front and back pics must share a bank"
