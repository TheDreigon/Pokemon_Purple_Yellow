	db DEX_NIDOKING ; pokedex id
	base_stat_row 90, 100, 90, 75, 75 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 195 ; base exp

	INCBIN "gfx/pokemon/front/nidoking.pic", 0, 1 ; sprite dimensions
	dw NidokingPicFront, NidokingPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex predator male Poison/Ground bruiser, full kit.
	; auto
	; BULLDOZE/RAGE/BODY_SLAM/POISON_BITE/MEGAHORN/TAKE_DOWN/EARTHQUAKE/THRASH/OUTRAGE/STRENGTH.
	; bonus
	; ROCK_THROW/QUICK_ATTACK/BIND/FAINT_ATTACK/BULK_UP/TOXIC/INTIMIDATE/SCARY_FACE/SWORDS_DANCE/ROCK_SLIDE/DOUBLE_EDGE.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, QUICK_ATTACK, BIND, FAINT_ATTACK, BULLDOZE, \
	     RAGE, BODY_SLAM, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, POISON_BITE, MEGAHORN, TOXIC, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, THRASH, OUTRAGE, CUT, \
	     STRENGTH
	; end

	db 0 ; padding
