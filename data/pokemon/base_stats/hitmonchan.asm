	db DEX_HITMONCHAN ; pokedex id
	base_stat_row 90, 80, 90, 80, 80 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 140 ; base exp

	INCBIN "gfx/pokemon/front/hitmonchan.pic", 0, 1 ; sprite dimensions
	dw HitmonchanPicFront, HitmonchanPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: fist-only puncher, single-stage last. auto
	; QUICK_ATTACK/FAINT_ATTACK/BULK_UP/AGILITY/CALM_MIND. bonus
	; BIND/SEISMIC_TOSS/BODY_SLAM/TAKE_DOWN. HM STRENGTH. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, SEISMIC_TOSS, BODY_SLAM, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     AGILITY, TAKE_DOWN, CALM_MIND, STRENGTH
	; end

	db 0 ; padding
