	db DEX_CHARIZARD ; pokedex id
	base_stat_row 90, 100, 80, 100, 90 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 45 ; catch rate
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/charizard.pic", 0, 1 ; sprite dimensions
	dw CharizardPicFront, CharizardPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
