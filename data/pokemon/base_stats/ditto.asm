	db DEX_DITTO ; pokedex id
	base_stat_row 50, 50, 50, 50, 50 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 35 ; catch rate
	db 61 ; base exp

	INCBIN "gfx/pokemon/front/ditto.pic", 0, 1 ; sprite dimensions
	dw DittoPicFront, DittoPicBack

	db TRANSFORM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Ditto. TRANSFORM only — sem TMs (Forte). A sua unica
	; jogada e copiar; nao tem anatomia/gesto proprio para qualquer
	; TM/HM.
	tmhm
	; end

	db 0 ; padding
