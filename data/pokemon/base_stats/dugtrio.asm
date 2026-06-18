	db DEX_DUGTRIO ; pokedex id
	base_stat_row 45, 90, 50, 70, 120 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 50 ; catch rate
	db 153 ; base exp

	INCBIN "gfx/pokemon/front/dugtrio.pic", 0, 1 ; sprite dimensions
	dw DugtrioPicFront, DugtrioPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex toupeira de 3 cabecas, ground speedster. auto
	; QUICK_ATTACK/FAINT_ATTACK/BULLDOZE/AGILITY/TAKE_DOWN/EARTHQUAKE. bonus
	; ROCK_THROW/BODY_SLAM/IRON_HEAD. HM CUT/STRENGTH. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, \
	     TAKE_DOWN, EARTHQUAKE, CUT, STRENGTH
	; end

	db 0 ; padding
