	db DEX_MACHOKE ; pokedex id
	base_stat_row 90, 100, 70, 65, 60 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 100 ; catch rate  ; mid stage, BST 385, harder to handle
	db 150 ; base exp  ; BST 385 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/machoke.pic", 0, 1 ; sprite dimensions
	dw MachokePicFront, MachokePicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Bulkier humanoid powerhouse.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, BULLDOZE, SEISMIC_TOSS, \
	     RAGE, BODY_SLAM, BULK_UP, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     DOUBLE_EDGE, THRASH, STRENGTH, ROCK_SLIDE
	; end

	db BANK(MachokePicFront) ; which bank this mon's pics live in
	assert BANK(MachokePicFront) == BANK(MachokePicBack), \
	    "Machoke: front and back pics must share a bank"
