	db DEX_SEADRA ; pokedex id
	base_stat_row 60, 70, 90, 80, 80 ; hp atk def spc spd
	db WATER, DRAGON ; type
	db 90 ; catch rate  ; set by hand
	db 140 ; base exp  ; BST 380 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/seadra.pic", 0, 1 ; sprite dimensions
	dw SeadraPicFront, SeadraPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water/Dragon last-stage; Horsea backbone plus dragon apex.
	tmhm WATER_PULSE, ICY_PULSE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TOXIC, SCARY_FACE, ICE_BEAM, \
	     OUTRAGE, SURF
	; end

	db BANK(SeadraPicFront) ; which bank this mon's pics live in
	assert BANK(SeadraPicFront) == BANK(SeadraPicBack), \
	    "Seadra: front and back pics must share a bank"
