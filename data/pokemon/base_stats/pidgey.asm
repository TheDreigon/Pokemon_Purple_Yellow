	db DEX_PIDGEY ; pokedex id
	base_stat_row 45, 45, 40, 35, 55 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 255 ; catch rate
	db 55 ; base exp

	INCBIN "gfx/pokemon/front/pidgey.pic", 0, 1 ; sprite dimensions
	dw PidgeyPicFront, PidgeyPicBack

	db TACKLE, GUST, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: baby peaceful raptor. Minimal kit. NO fun moves (per
	; Forte's anatomy/lore-gated fun-move rule — birds don't fit MIMIC/
	; MIRROR_MOVE/SUBSTITUTE/METRONOME). FAINT_ATTACK TM per Forte (all 3
	; bird lines). HM02 Fly per Forte's natural-FLY list.
	tmhm QUICK_ATTACK, FAINT_ATTACK, AERIAL_ACE, HURRICANE, FLY
	; end

	db 0 ; padding
