	db DEX_VICTREEBEL ; pokedex id
	base_stat_row 80, 95, 70, 95, 90 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 191 ; base exp

	INCBIN "gfx/pokemon/front/victreebel.pic", 0, 1 ; sprite dimensions
	dw VictreebelPicFront, VictreebelPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex carnivore (Grass/Poison). auto
	; BODY_SLAM/GIGA_DRAIN/TOXIC/SCARY_FACE/LEECH_LIFE/TAKE_DOWN. bonus
	; FAINT_ATTACK/INTIMIDATE/SWORDS_DANCE/DOUBLE_EDGE. HM CUT. fun (4
	; via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm FAINT_ATTACK, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, GIGA_DRAIN, TOXIC, INTIMIDATE, SCARY_FACE, \
	     LEECH_LIFE, TAKE_DOWN, SWORDS_DANCE, DOUBLE_EDGE, CUT
	; end

	db 0 ; padding
