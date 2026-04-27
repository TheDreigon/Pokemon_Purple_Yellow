	db DEX_DODUO ; pokedex id
	base_stat_row 40, 80, 40, 40, 90 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 190 ; catch rate
	db 96 ; base exp

	INCBIN "gfx/pokemon/front/doduo.pic", 0, 1 ; sprite dimensions
	dw DoduoPicFront, DoduoPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: 2-headed flightless ratite. NO flying TMs (no FLY/AERIAL_
	; ACE/HURRICANE) — Forte's anatomical exception. BULLDOZE (heavy ratite
	; legs). FAINT_ATTACK TM per Forte (all 3 bird lines). AGILITY natural
	; per Forte's list. HM01 Cut (sharp beak). HM04 Strength (powerful legs
	; to push).
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE,   AGILITY,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  CUT,          STRENGTH
	; end

	db 0 ; padding
