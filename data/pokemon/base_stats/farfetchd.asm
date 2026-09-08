	db DEX_FARFETCHD ; pokedex id
	base_stat_row 100, 75, 60, 50, 60, 75 ; hp atk def spatk spdef spd
	db FIGHTING, FLYING ; type
	db 115 ; catch rate  ; set by hand: run feedback 2026-09-05: a bit easier; one step off its 100
	db 130 ; base exp  ; BST 420

	INCBIN "gfx/pokemon/front/farfetchd.pic", 0, 1 ; sprite dimensions
	dw FarfetchdPicFront, FarfetchdPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Samurai-duck Fighting/Flying with a leek-blade (slash + physical
	; recklessness). HM CUT/FLY/STRENGTH.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, AERIAL_ACE, \
	     TAKE_DOWN, SWORDS_DANCE, PETAL_DANCE, DOUBLE_EDGE, CUT, \
	     FLY, STRENGTH, THRASH, OUTRAGE
	; end

	db BANK(FarfetchdPicFront) ; which bank this mon's pics live in
	assert BANK(FarfetchdPicFront) == BANK(FarfetchdPicBack), \
	    "Farfetchd: front and back pics must share a bank"
