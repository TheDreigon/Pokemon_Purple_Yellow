	db DEX_MAGIKARP ; pokedex id
	base_stat_row 30, 30, 60, 30, 60 ; hp atk def spc spd

	db WATER, WATER ; type
	db 255 ; catch rate
	db 20 ; base exp

	INCBIN "gfx/pokemon/front/magikarp.pic", 0, 1 ; sprite dimensions
	dw MagikarpPicFront, MagikarpPicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: canon-weakest flopping fish, intentionally
	; minimalist. auto RAGE.
	tmhm RAGE
	; end

	db 0 ; padding
