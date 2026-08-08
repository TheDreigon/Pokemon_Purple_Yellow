	db DEX_PARAS ; pokedex id
	base_stat_row 45, 70, 55, 45, 40 ; hp atk def spc spd

	db BUG, GRASS ; type
	db 240 ; catch rate  ; base stage, BST 255, easy to approach
	db 70 ; base exp

	INCBIN "gfx/pokemon/front/paras.pic", 0, 1 ; sprite dimensions
	dw ParasPicFront, ParasPicBack

	db BUG_BITE, SCRATCH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Cordyceps-controlled bug (Bug/Grass), short pre-evo backbone:
	; GIGA_DRAIN/LEECH_LIFE plus TOXIC. HM CUT.
	tmhm GIGA_DRAIN, TOXIC, LEECH_LIFE, CUT
	; end

	db 0 ; padding
