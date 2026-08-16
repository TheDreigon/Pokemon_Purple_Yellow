	db DEX_VILEPLUME ; pokedex id
	base_stat_row 110, 90, 90, 95, 45 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 65 ; catch rate  ; final stage, BST 430
	db 170 ; base exp  ; BST 430 - muitas fraquezas (-5)

	INCBIN "gfx/pokemon/front/vileplume.pic", 0, 1 ; sprite dimensions
	dw VileplumePicFront, VileplumePicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Rafflesia bloom (Grass/Fungus) — powder warfare and dark-spore
	; specialist. Spreads venom (TOXIC) and dark spores (DARK_PULSE);
	; drains (GIGA_DRAIN/LEECH_LIFE). Last-stage fun moves via TM.
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, TOXIC, EXTRASENSORY, LEECH_LIFE, TAKE_DOWN, \
	     DARK_PULSE, PETAL_DANCE, DOUBLE_EDGE
	; end

	db BANK(VileplumePicFront) ; which bank this mon's pics live in
	assert BANK(VileplumePicFront) == BANK(VileplumePicBack), \
	    "Vileplume: front and back pics must share a bank"
