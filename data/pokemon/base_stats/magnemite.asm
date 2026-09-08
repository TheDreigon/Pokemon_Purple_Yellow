	db DEX_MAGNEMITE ; pokedex id
	base_stat_row 20, 40, 80, 80, 50, 40 ; hp atk def spatk spdef spd
	db ELECTRIC, STEEL ; type
	db 220 ; catch rate  ; base stage, BST 310
	db 85 ; base exp  ; BST 310

	INCBIN "gfx/pokemon/front/magnemite.pic", 0, 1 ; sprite dimensions
	dw MagnemitePicFront, MagnemitePicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Electric/Steel magnet pre-evo.
	tmhm BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, IRON_HEAD, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT
	; end

	db BANK(MagnemitePicFront) ; which bank this mon's pics live in
	assert BANK(MagnemitePicFront) == BANK(MagnemitePicBack), \
	    "Magnemite: front and back pics must share a bank"
