	db DEX_TENTACRUEL ; pokedex id
	base_stat_row 100, 80, 60, 120, 90 ; hp atk def spc spd

	db WATER, POISON ; type
	db 70 ; catch rate  ; set by hand
	db 190 ; base exp  ; BST 450 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/tentacruel.pic", 0, 1 ; sprite dimensions
	dw TentacruelPicFront, TentacruelPicBack

	db POISON_STING, HINDER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Water/Poison jellyfish. Tentacles bind and drain (LEECH_LIFE);
	; venom enables TOXIC. Last-stage fun moves via TM. Ladder prereqs:
	; WATER_PULSE, ICY_PULSE, SHOCK_WAVE.
	tmhm BIND, WATER_PULSE, ICY_PULSE, SHOCK_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, TOXIC, \
	     LEECH_LIFE, ICE_BEAM, CUT, SURF
	; end

	db BANK(TentacruelPicFront) ; which bank this mon's pics live in
	assert BANK(TentacruelPicFront) == BANK(TentacruelPicBack), \
	    "Tentacruel: front and back pics must share a bank"
