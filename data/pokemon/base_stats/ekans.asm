	db DEX_EKANS ; pokedex id
	base_stat_row 30, 60, 45, 40, 80 ; hp atk def spc spd

	db POISON, POISON ; type
	db 225 ; catch rate  ; base stage, BST 255
	db 62 ; base exp

	INCBIN "gfx/pokemon/front/ekans.pic", 0, 1 ; sprite dimensions
	dw EkansPicFront, EkansPicBack

	db CONSTRICT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Poison snake (pre-evo backbone). HM CUT.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, IRON_TAIL, SUBSTITUTE, \
	     AGILITY, POISON_BITE, TOXIC, TAKE_DOWN, CUT
	; end

	db 0 ; padding
