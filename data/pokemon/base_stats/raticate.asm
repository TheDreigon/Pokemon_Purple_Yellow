	db DEX_RATICATE ; pokedex id
	base_stat_row 70, 90, 65, 60, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 90 ; catch rate
	db 116 ; base exp

	INCBIN "gfx/pokemon/front/raticate.pic", 0, 1 ; sprite dimensions
	dw RaticatePicFront, RaticatePicBack

	db BITE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Matured Normal/Dark rodent, physical bruiser. Sharp fangs justify
	; POISON_BITE/FAINT_ATTACK; gnawing incisors learn HM CUT.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     POISON_BITE, TOXIC, INTIMIDATE, TAKE_DOWN, DOUBLE_EDGE, \
	     CUT
	; end

	db 0 ; padding
