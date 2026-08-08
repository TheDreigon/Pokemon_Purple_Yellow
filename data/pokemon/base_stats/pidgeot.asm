	db DEX_PIDGEOT ; pokedex id
	base_stat_row 95, 85, 75, 70, 100 ; hp atk def spc spd

	db NORMAL, FLYING ; type
	db 55 ; catch rate  ; final stage, BST 425, harder to handle
	db 172 ; base exp

	INCBIN "gfx/pokemon/front/pidgeot.pic", 0, 1 ; sprite dimensions
	dw PidgeotPicFront, PidgeotPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex raptor (mach-2 eagle/falcon). Flight kit:
	; QUICK_ATTACK/AERIAL_ACE/HURRICANE plus
	; INTIMIDATE/TAKE_DOWN/BODY_SLAM/AGILITY/SWORDS_DANCE/
	; DOUBLE_EDGE. HM CUT/FLY.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, AERIAL_ACE, HURRICANE, INTIMIDATE, \
	     TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, CUT, FLY
	; end

	db 0 ; padding
