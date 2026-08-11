	db DEX_CUBONE ; pokedex id
	base_stat_row 50, 50, 80, 40, 40 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 225 ; catch rate  ; base stage, BST 260
	db 75 ; base exp  ; BST 260 - poucas fraquezas (+2)

	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
	dw CubonePicFront, CubonePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Solitary baby ground bone-wielder. Ground/rock attacks
	; (BULLDOZE/ROCK_THROW/ROCK_SLIDE), bone-club melee
	; (BODY_SLAM/DOUBLE_EDGE), grief-driven RAGE/FAINT_ATTACK, BULK_UP.
	tmhm ROCK_THROW, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     BULK_UP, CHARM, TAKE_DOWN, ROCK_SLIDE, DOUBLE_EDGE, \
	     IRON_HEAD
	; end

	db BANK(CubonePicFront) ; which bank this mon's pics live in
	assert BANK(CubonePicFront) == BANK(CubonePicBack), \
	    "Cubone: front and back pics must share a bank"
