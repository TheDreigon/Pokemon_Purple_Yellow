	db DEX_WEEDLE ; pokedex id
	base_stat_row 30, 35, 30, 20, 20, 40 ; hp atk def spatk spdef spd

	db BUG, POISON ; type
	db 255 ; catch rate  ; base stage, BST 175
	db 35 ; base exp  ; BST 175

	INCBIN "gfx/pokemon/front/weedle.pic", 0, 1 ; sprite dimensions
	dw WeedlePicFront, WeedlePicBack

	db BUG_BITE, STRING_SHOT, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Joke-tier baby spike-bug. The larva is too small and primitive
	; even for the silk-substitute trick that only Kakuna gets, so no
	; TMs/HMs at all. Consistent with Kakuna (SUBSTITUTE only) and
	; Beedrill (full warrior-bee set).
	tmhm
	; end

	db BANK(WeedlePicFront) ; which bank this mon's pics live in
	assert BANK(WeedlePicFront) == BANK(WeedlePicBack), \
	    "Weedle: front and back pics must share a bank"
