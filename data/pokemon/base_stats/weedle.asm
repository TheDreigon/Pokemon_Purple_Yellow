	db DEX_WEEDLE ; pokedex id
	base_stat_row 40, 35, 30, 20, 50 ; hp atk def spc spd

	db BUG, POISON ; type
	db 255 ; catch rate
	db 52 ; base exp

	INCBIN "gfx/pokemon/front/weedle.pic", 0, 1 ; sprite dimensions
	dw WeedlePicFront, WeedlePicBack

	db POISON_STING, ENTANGLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db 0 ; padding
