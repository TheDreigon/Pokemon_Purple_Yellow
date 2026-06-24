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
	; Fist-only puncher, single-stage; hands grab/throw (ROCK_THROW). HM STRENGTH.
	; Fun moves (global last-stage rule): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, SWORDS_DANCE, BODY_SLAM, \
	     ROCK_THROW, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TAKE_DOWN, CALM_MIND, STRENGTH, \
	     THRASH
	; end

	db 0 ; padding
