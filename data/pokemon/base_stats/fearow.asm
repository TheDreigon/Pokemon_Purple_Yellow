	db DEX_FEAROW ; pokedex id
	base_stat_row 70, 95, 65, 65, 95 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 90 ; catch rate
	db 162 ; base exp

	INCBIN "gfx/pokemon/front/fearow.pic", 0, 1 ; sprite dimensions
	dw FearowPicFront, FearowPicBack

	db PECK, LEER, FURY_ATTACK, AERIAL_ACE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex predator. Spearow's 8 + 2 apex additions: INTIMIDATE
	; (also levelup), SWORDS_DANCE (per Forte — talons-as-swords for the
	; Fearow-only sword-dance).
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE,   TAKE_DOWN,    DOUBLE_EDGE, \
	     FLY,          CUT,          INTIMIDATE,   SWORDS_DANCE, MIMIC, \
	     MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
