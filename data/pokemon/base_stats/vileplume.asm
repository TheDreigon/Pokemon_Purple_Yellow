	db DEX_VILEPLUME ; pokedex id
	base_stat_row 110, 95, 85, 95, 45 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 45 ; catch rate
	db 184 ; base exp

	INCBIN "gfx/pokemon/front/vileplume.pic", 0, 1 ; sprite dimensions
	dw VileplumePicFront, VileplumePicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Rafflesia bloom (Grass/Fungus) — powder warfare
	; and dark-spore specialist. auto
	; TOXIC/LEECH_LIFE/DARK_PULSE/PETAL_DANCE. bonus
	; BODY_SLAM/GIGA_DRAIN/EXTRASENSORY/TAKE_DOWN/DOUBLE_EDGE. fun (4
	; via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, TOXIC, EXTRASENSORY, LEECH_LIFE, TAKE_DOWN, \
	     DARK_PULSE, PETAL_DANCE, DOUBLE_EDGE
	; end

	db 0 ; padding
