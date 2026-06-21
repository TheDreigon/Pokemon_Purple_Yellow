	db DEX_JIGGLYPUFF ; pokedex id
	base_stat_row 120, 45, 20, 35, 55 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 170 ; catch rate
	db 76 ; base exp

	INCBIN "gfx/pokemon/front/jigglypuff.pic", 0, 1 ; sprite dimensions
	dw JigglypuffPicFront, JigglypuffPicBack

	db SING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Normal/Fairy balloon-singer pre-evo. HM FLY.
	tmhm RAGE, BODY_SLAM, DAZZLE_GLEAM, FAKE_TEARS, CHARM, \
	     DOUBLE_EDGE, FLY
	; end

	db 0 ; padding
