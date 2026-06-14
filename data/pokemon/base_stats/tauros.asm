	db DEX_TAUROS ; pokedex id
	base_stat_row 90, 120, 90, 50, 100 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 211 ; base exp

	INCBIN "gfx/pokemon/front/tauros.pic", 0, 1 ; sprite dimensions
	dw TaurosPicFront, TaurosPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: raging horned bull, heavy physical bruiser (gold
	; standard). auto
	; BULLDOZE/RAGE/BODY_SLAM/INTIMIDATE/SCARY_FACE/TAKE_DOWN/SWORDS_DANCE/DOUBLE_EDGE/THRASH/OUTRAGE/STRENGTH.
	; bonus BULK_UP/IRON_HEAD/MEGAHORN/EARTHQUAKE. HM STRENGTH. fun (4
	; via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BULLDOZE, RAGE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, MEGAHORN, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     DOUBLE_EDGE, THRASH, OUTRAGE, STRENGTH
	; end

	db 0 ; padding
