	db DEX_RATICATE ; pokedex id
	base_stat_row 70, 90, 65, 60, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 90 ; catch rate
	db 116 ; base exp

	INCBIN "gfx/pokemon/front/raticate.pic", 0, 1 ; sprite dimensions
	dw RaticatePicFront, RaticatePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Normal/Dark matured rodent, physical bruiser. auto
	; QUICK_ATTACK/FAINT_ATTACK/RAGE/BODY_SLAM/AGILITY/POISON_FANG/DOUBLE_EDGE/CUT.
	; bonus BULK_UP/TOXIC/INTIMIDATE/TAKE_DOWN. HM CUT. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     POISON_FANG, TOXIC, INTIMIDATE, TAKE_DOWN, DOUBLE_EDGE, \
	     CUT
	; end

	db 0 ; padding
