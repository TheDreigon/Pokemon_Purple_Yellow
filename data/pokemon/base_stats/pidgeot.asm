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
	; v0.7 Pass 3: aguia/falcao apex (raptor mach-2). auto
	; QUICK_ATTACK/AERIAL_ACE/HURRICANE/INTIMIDATE/TAKE_DOWN/FLY. bonus
	; BODY_SLAM/AGILITY/DOUBLE_EDGE. HM CUT/FLY. fun (4 via TM, regra
	; global last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     TAKE_DOWN, DOUBLE_EDGE, CUT, FLY
	; end

	db 0 ; padding
