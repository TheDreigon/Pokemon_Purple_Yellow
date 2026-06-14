	db DEX_WEEZING ; pokedex id
	base_stat_row 90, 95, 100, 95, 50 ; hp atk def spc spd
	db POISON, GAS ; type
	db 60 ; catch rate
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/weezing.pic", 0, 1 ; sprite dimensions
	dw WeezingPicFront, WeezingPicBack

	db TACKLE, SMOG, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex gas balloon Poison/Gas, conceito sinistro de
	; nuvem toxica. auto
	; NIGHT_SHADE/TOXIC/SCARY_FACE/LIGHT_SCREEN/DARK_PULSE/FLAMETHROWER.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm NIGHT_SHADE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     TOXIC, SCARY_FACE, LIGHT_SCREEN, DARK_PULSE, FLAMETHROWER
	; end

	db 0 ; padding
