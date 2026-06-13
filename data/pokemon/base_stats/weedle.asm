	db DEX_WEEDLE ; pokedex id
	base_stat_row 40, 35, 30, 20, 50 ; hp atk def spc spd

	db BUG, POISON ; type
	db 255 ; catch rate
	db 52 ; base exp

	INCBIN "gfx/pokemon/front/weedle.pic", 0, 1 ; sprite dimensions
	dw WeedlePicFront, WeedlePicBack

	db POISON_STING, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: joke-tier baby spike-bug. STRING_SHOT moved to L7
	; levelup (1 before evo) per Forte. NO TMs at all (per Forte's revised
	; rule — Weedle too small/primitive even for silk-substitute, which
	; only Kakuna gets).
	tmhm
	; end

	db 0 ; padding
