	db DEX_KABUTO ; pokedex id
	base_stat_row 35, 80, 90, 55, 45, 40 ; hp atk def spatk spdef spd
	db ROCK, BUG ; type
	db 205 ; catch rate  ; base stage, BST 300
	db 90 ; base exp  ; BST 290 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/kabuto.pic", 0, 1 ; sprite dimensions
	dw KabutoPicFront, KabutoPicBack

	db SCRATCH, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Armored trilobite-crab fossil (Rock/Bug), aquatic pre-evo
	; backbone. Pincers cut; ICY_PULSE/ICE_BEAM from cold-sea habitat.
	tmhm ROCK_THROW, WATER_PULSE, ICY_PULSE, BODY_SLAM, LEECH_LIFE, \
	     TAKE_DOWN, ICE_BEAM, CUT, IRON_HEAD
	; end

	db BANK(KabutoPicFront) ; which bank this mon's pics live in
	assert BANK(KabutoPicFront) == BANK(KabutoPicBack), \
	    "Kabuto: front and back pics must share a bank"
