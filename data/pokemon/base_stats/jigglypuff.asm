	db DEX_JIGGLYPUFF ; pokedex id
	base_stat_row 120, 45, 20, 40, 40, 70 ; hp atk def spatk spdef spd
	db NORMAL, FAIRY ; type
	db 230 ; catch rate  ; base stage, BST 335, easy to approach
	db 95 ; base exp  ; BST 335

	INCBIN "gfx/pokemon/front/jigglypuff.pic", 0, 1 ; sprite dimensions
	dw JigglypuffPicFront, JigglypuffPicBack

	db SING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Normal/Fairy balloon-singer pre-evo. HM FLY.
	tmhm RAGE, BODY_SLAM, DAZZLE_GLEAM, FAKE_TEARS, CHARM, \
	     DOUBLE_EDGE, FLY
	; end

	db BANK(JigglypuffPicFront) ; which bank this mon's pics live in
	assert BANK(JigglypuffPicFront) == BANK(JigglypuffPicBack), \
	    "Jigglypuff: front and back pics must share a bank"
