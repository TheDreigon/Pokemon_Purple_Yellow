	db DEX_EEVEE ; pokedex id
	base_stat_row 65, 65, 65, 65, 65 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 100 ; catch rate  ; set by hand: as scarce as a wild Pikachu
	db 92 ; base exp

	INCBIN "gfx/pokemon/front/eevee.pic", 0, 1 ; sprite dimensions
	dw EeveePicFront, EeveePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Cute Normal fox base, backbone-only. METRONOME is a level-up auto,
	; not the fun-move package: Eevee is the 5th approved pre-evo fun
	; exception (unstable genes = random move), like Clefairy's.
	tmhm QUICK_ATTACK, BODY_SLAM, METRONOME, AGILITY, FAKE_TEARS, \
	     CHARM, DOUBLE_EDGE
	; end

	db BANK(EeveePicFront) ; which bank this mon's pics live in
	assert BANK(EeveePicFront) == BANK(EeveePicBack), \
	    "Eevee: front and back pics must share a bank"
