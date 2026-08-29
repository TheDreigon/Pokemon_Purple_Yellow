	db DEX_VENOMOTH ; pokedex id
	base_stat_row 70, 75, 60, 80, 80 ; hp atk def spc spd

	db BUG, POISON ; type
	db 85 ; catch rate  ; final stage, BST 365
	db 130 ; base exp  ; BST 365 - muitas fraquezas (-5)

	INCBIN "gfx/pokemon/front/venomoth.pic", 0, 1 ; sprite dimensions
	dw VenomothPicFront, VenomothPicBack

	db BUG_BITE, CONFUSION, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Full psychic moth, Bug/Poison flyer. Spreads venom (TOXIC), drains
	; (LEECH_LIFE), and wields psychic powers (PSYCHIC_M/CONFUSE_RAY).
	; Flight enables AERIAL_ACE/FLY. Last-stage fun moves via TM.
	tmhm NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, TOXIC, EXTRASENSORY, LEECH_LIFE, \
	     PSYCHIC_M, LIGHT_SCREEN, REFLECT, FLY
	; end

	db BANK(VenomothPicFront) ; which bank this mon's pics live in
	assert BANK(VenomothPicFront) == BANK(VenomothPicBack), \
	    "Venomoth: front and back pics must share a bank"
