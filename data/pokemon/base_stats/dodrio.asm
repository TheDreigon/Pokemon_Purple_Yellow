	db DEX_DODRIO ; pokedex id
	base_stat_row 60, 120, 60, 60, 110 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 45 ; catch rate
	db 158 ; base exp

	INCBIN "gfx/pokemon/front/dodrio.pic", 0, 1 ; sprite dimensions
	dw DodrioPicFront, DodrioPicBack

	db PECK, FURY_ATTACK, DRILL_PECK, AGILITY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: 3-headed ratite. Doduo's 8 + 1 apex addition: INTIMIDATE
	; (3 heads, scary). NO EARTHQUAKE per Forte (bird isn't heavy enough
	; despite massive legs).
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE,   AGILITY,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  CUT,          STRENGTH,   INTIMIDATE, BODY_SLAM
	; end

	db 0 ; padding
