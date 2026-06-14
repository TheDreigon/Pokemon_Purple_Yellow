	db DEX_SPEAROW ; pokedex id
	base_stat_row 40, 65, 35, 30, 65 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 255 ; catch rate
	db 58 ; base exp

	INCBIN "gfx/pokemon/front/spearow.pic", 0, 1 ; sprite dimensions
	dw SpearowPicFront, SpearowPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: aggressive bird-of-prey (honorary Dark/Flying),
	; pre-evo backbone. auto QUICK_ATTACK/FAINT_ATTACK/AERIAL_ACE. bonus
	; TAKE_DOWN/DOUBLE_EDGE. HM CUT/FLY.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE, TAKE_DOWN, DOUBLE_EDGE, \
	     CUT, FLY
	; end

	db 0 ; padding
