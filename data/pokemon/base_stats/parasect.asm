	db DEX_PARASECT ; pokedex id
	base_stat_row 95, 90, 90, 90, 20 ; hp atk def spc spd
	db BUG, FUNGUS ; type
	db 75 ; catch rate
	db 128 ; base exp

	INCBIN "gfx/pokemon/front/parasect.pic", 0, 1 ; sprite dimensions
	dw ParasectPicFront, ParasectPicBack

	db BUG_BITE, SCRATCH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex dominado pelo cogumelo (Bug/Fungus), 14 TMs.
	; auto GIGA_DRAIN/TOXIC/SCARY_FACE/LEECH_LIFE/DOUBLE_EDGE. bonus
	; BODY_SLAM/POISON_FANG/TAKE_DOWN/SWORDS_DANCE. HM CUT. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, POISON_FANG, TOXIC, SCARY_FACE, LEECH_LIFE, \
	     TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, CUT
	; end

	db 0 ; padding
