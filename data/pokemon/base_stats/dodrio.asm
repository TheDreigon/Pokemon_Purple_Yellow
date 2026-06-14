	db DEX_DODRIO ; pokedex id
	base_stat_row 60, 120, 60, 60, 110 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 45 ; catch rate
	db 158 ; base exp

	INCBIN "gfx/pokemon/front/dodrio.pic", 0, 1 ; sprite dimensions
	dw DodrioPicFront, DodrioPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: ratite de 3 cabecas, last-stage e apex da linha. auto
	; QUICK_ATTACK/FAINT_ATTACK/RAGE/AGILITY/TAKE_DOWN/DOUBLE_EDGE/THRASH.
	; bonus BULLDOZE/BODY_SLAM/INTIMIDATE. HM CUT/STRENGTH. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     INTIMIDATE, TAKE_DOWN, DOUBLE_EDGE, THRASH, CUT, \
	     STRENGTH
	; end

	db 0 ; padding
