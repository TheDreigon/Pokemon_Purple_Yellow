	db DEX_PERSIAN ; pokedex id
	base_stat_row 90, 80, 50, 60, 115 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 90 ; catch rate
	db 148 ; base exp

	INCBIN "gfx/pokemon/front/persian.pic", 0, 1 ; sprite dimensions
	dw PersianPicFront, PersianPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Normal/Dark feline, smart sleek cat:
	; FAINT_ATTACK/RAGE/AGILITY/INTIMIDATE/QUICK_ATTACK plus
	; IRON_TAIL/NIGHT_SHADE/SCARY_FACE/DARK_PULSE/SWORDS_DANCE.
	; HM CUT/STRENGTH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, IRON_TAIL, NIGHT_SHADE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, DARK_PULSE, SWORDS_DANCE, \
	     CUT, STRENGTH, DRAGON_CLAW
	; end

	db 0 ; padding
