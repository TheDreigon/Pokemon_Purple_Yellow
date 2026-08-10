	db DEX_MAGIKARP ; pokedex id
	base_stat_row 30, 30, 30, 30, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 255 ; catch rate  ; base stage, BST 180, easy to approach
	db 20 ; base exp

	INCBIN "gfx/pokemon/front/magikarp.pic", 0, 1 ; sprite dimensions
	dw MagikarpPicFront, MagikarpPicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Canon-weakest flopping fish, intentionally minimalist.
	tmhm RAGE
	; end

	db BANK(MagikarpPicFront) ; which bank this mon's pics live in
	assert BANK(MagikarpPicFront) == BANK(MagikarpPicBack), \
	    "Magikarp: front and back pics must share a bank"
