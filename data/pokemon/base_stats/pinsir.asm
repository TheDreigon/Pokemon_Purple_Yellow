	db DEX_PINSIR ; pokedex id
	base_stat_row 70, 115, 100, 55, 70 ; hp atk def spc spd
	db BUG, FIGHTING ; type
	db 45 ; catch rate
	db 200 ; base exp

	INCBIN "gfx/pokemon/front/pinsir.pic", 0, 1 ; sprite dimensions
	dw PinsirPicFront, PinsirPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: stag-beetle pincer-BRUTE (R11 vs Scyther —
	; force/grapple identity). auto
	; BIND/SEISMIC_TOSS/BODY_SLAM/BULK_UP/MEGAHORN/TAKE_DOWN/DOUBLE_EDGE/THRASH/CUT/STRENGTH.
	; bonus
	; IRON_HEAD/INTIMIDATE/SCARY_FACE/SWORDS_DANCE/EARTHQUAKE/ROCK_SLIDE.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, SEISMIC_TOSS, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, MEGAHORN, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     ROCK_SLIDE, DOUBLE_EDGE, THRASH, CUT, STRENGTH
	; end

	db 0 ; padding
