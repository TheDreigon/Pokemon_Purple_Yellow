	db DEX_FEAROW ; pokedex id
	base_stat_row 70, 95, 65, 65, 95 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 90 ; catch rate
	db 162 ; base exp

	INCBIN "gfx/pokemon/front/fearow.pic", 0, 1 ; sprite dimensions
	dw FearowPicFront, FearowPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex raptor (DRILL_PECK signature), honorary
	; Dark/Flying. auto QUICK_ATTACK/FAINT_ATTACK/AERIAL_ACE/INTIMIDATE.
	; bonus TAKE_DOWN/SWORDS_DANCE/DOUBLE_EDGE. HM CUT/FLY. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, INTIMIDATE, TAKE_DOWN, SWORDS_DANCE, \
	     DOUBLE_EDGE, CUT, FLY
	; end

	db 0 ; padding
