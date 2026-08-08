	db DEX_DITTO ; pokedex id
	base_stat_row 50, 50, 50, 50, 50 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 155 ; catch rate  ; set by hand: harmless: it copies you rather than resisting you
	db 61 ; base exp

	INCBIN "gfx/pokemon/front/ditto.pic", 0, 1 ; sprite dimensions
	dw DittoPicFront, DittoPicBack

	db TRANSFORM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Ditto. TRANSFORM only, no TMs. Its only play is to copy; it has no
	; anatomy or gesture of its own for any TM/HM.
	tmhm
	; end

	db 0 ; padding
