	db DEX_FEAROW ; pokedex id
	base_stat_row 70, 95, 65, 65, 95 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 65 ; catch rate  ; final stage, BST 390, harder to handle
	db 162 ; base exp

	INCBIN "gfx/pokemon/front/fearow.pic", 0, 1 ; sprite dimensions
	dw FearowPicFront, FearowPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex raptor, DRILL_PECK (shared with Dodrio line/Zapdos/Beedrill),
	; honorary Dark/Flying. HM CUT/FLY.
	tmhm QUICK_ATTACK, FAINT_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, INTIMIDATE, TAKE_DOWN, SWORDS_DANCE, \
	     DOUBLE_EDGE, CUT, FLY
	; end

	db 0 ; padding
