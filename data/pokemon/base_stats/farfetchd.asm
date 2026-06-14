	db DEX_FARFETCHD ; pokedex id
	base_stat_row 100, 75, 50, 50, 75 ; hp atk def spc spd
	db FIGHTING, FLYING ; type
	db 45 ; catch rate
	db 94 ; base exp

	INCBIN "gfx/pokemon/front/farfetchd.pic", 0, 1 ; sprite dimensions
	dw FarfetchdPicFront, FarfetchdPicBack

	db PECK, SAND_ATTACK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: pato-samurai Fighting/Flying com alho-lamina (slash +
	; recklessness fisica). auto
	; QUICK_ATTACK/FAINT_ATTACK/AGILITY/SWORDS_DANCE/PETAL_DANCE/CUT.
	; bonus BODY_SLAM/BULK_UP/AERIAL_ACE/TAKE_DOWN/DOUBLE_EDGE. HM
	; CUT/FLY/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, AERIAL_ACE, \
	     TAKE_DOWN, SWORDS_DANCE, PETAL_DANCE, DOUBLE_EDGE, CUT, \
	     FLY, STRENGTH
	; end

	db 0 ; padding
