	db DEX_TENTACOOL ; pokedex id
	base_stat_row 50, 40, 30, 50, 90, 60 ; hp atk def spatk spdef spd

	db WATER, POISON ; type
	db 230 ; catch rate  ; base stage, BST 320, easy to approach
	db 90 ; base exp  ; BST 320

	INCBIN "gfx/pokemon/front/tentacool.pic", 0, 1 ; sprite dimensions
	dw TentacoolPicFront, TentacoolPicBack

	db POISON_STING, HINDER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic Water/Poison jellyfish, pre-evo backbone. Tentacles bind and
	; drain (LEECH_LIFE). Ladder prereqs: WATER_PULSE, ICY_PULSE.
	tmhm BIND, WATER_PULSE, ICY_PULSE, AGILITY, LEECH_LIFE, \
	     ICE_BEAM, SURF
	; end

	db BANK(TentacoolPicFront) ; which bank this mon's pics live in
	assert BANK(TentacoolPicFront) == BANK(TentacoolPicBack), \
	    "Tentacool: front and back pics must share a bank"
