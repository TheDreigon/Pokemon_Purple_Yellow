	db DEX_PIDGEOT ; pokedex id
	base_stat_row 95, 85, 75, 70, 100 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 45 ; catch rate
	db 172 ; base exp

	INCBIN "gfx/pokemon/front/pidgeot.pic", 0, 1 ; sprite dimensions
	dw PidgeotPicFront, PidgeotPicBack

	db TACKLE, GUST, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex eagle (mach-2 raptor). Pidgeotto's 8 + 3 apex
	; additions: INTIMIDATE (also levelup), AGILITY (per Forte — Pidgeot-
	; only TM access), DOUBLE_EDGE (per Forte — Pidgeot-only).
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE,   HURRICANE,    FLY, \
	     TAKE_DOWN,    CUT,          INTIMIDATE,   AGILITY,      DOUBLE_EDGE, \
	     BODY_SLAM,    MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
