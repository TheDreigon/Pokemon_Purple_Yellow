	db DEX_WEEDLE ; pokedex id
	base_stat_row 40, 35, 30, 20, 50 ; hp atk def spc spd

	db BUG, POISON ; type
	db 255 ; catch rate
	db 52 ; base exp

	INCBIN "gfx/pokemon/front/weedle.pic", 0, 1 ; sprite dimensions
	dw WeedlePicFront, WeedlePicBack

	db BUG_BITE, STRING_SHOT, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: joke-tier baby spike-bug, pre-evo backbone subset.
	; Levelup (POISON_STING/STRING_SHOT/BUG_BITE/BIDE) has zero overlap
	; with the TM/HM list, so no auto. Per Forte's revised rule the
	; larva is too small/primitive even for the silk-substitute that
	; only Kakuna gets, so NO TMs/HMs/fun at all. Consistent with Kakuna
	; (SUBSTITUTE only) and Beedrill (full warrior-bee set).
	tmhm
	; end

	db 0 ; padding
