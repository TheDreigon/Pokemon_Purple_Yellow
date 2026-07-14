	db DEX_HITMONLEE ; pokedex id
	base_stat_row 80, 110, 70, 60, 100 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 139 ; base exp

	INCBIN "gfx/pokemon/front/hitmonlee.pic", 0, 1 ; sprite dimensions
	dw HitmonleePicFront, HitmonleePicBack

	db LOW_KICK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Leg-only kicker, single-stage; hands still grab/throw (ROCK_THROW). HM STRENGTH.
	; Fun moves (global last-stage rule): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, BULLDOZE, SEISMIC_TOSS, \
	     ROCK_THROW, BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TAKE_DOWN, SWORDS_DANCE, CALM_MIND, \
	     THRASH, STRENGTH
	; end

	db 0 ; padding
