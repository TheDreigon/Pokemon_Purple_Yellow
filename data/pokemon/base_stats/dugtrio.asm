	db DEX_DUGTRIO ; pokedex id
	base_stat_row 45, 90, 50, 70, 120 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 70 ; catch rate  ; final stage, BST 375, harder to handle
	db 153 ; base exp

	INCBIN "gfx/pokemon/front/dugtrio.pic", 0, 1 ; sprite dimensions
	dw DugtrioPicFront, DugtrioPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex three-headed mole, ground speedster. HM CUT/STRENGTH. Fun
	; moves (last-stage) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, FAINT_ATTACK, BULLDOZE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, \
	     TAKE_DOWN, EARTHQUAKE, CUT, STRENGTH
	; end

	db BANK(DugtrioPicFront) ; which bank this mon's pics live in
	assert BANK(DugtrioPicFront) == BANK(DugtrioPicBack), \
	    "Dugtrio: front and back pics must share a bank"
