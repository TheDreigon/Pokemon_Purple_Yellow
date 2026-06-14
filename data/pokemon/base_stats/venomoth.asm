	db DEX_VENOMOTH ; pokedex id
	base_stat_row 70, 75, 60, 80, 80 ; hp atk def spc spd

	db BUG, POISON ; type
	db 75 ; catch rate
	db 138 ; base exp

	INCBIN "gfx/pokemon/front/venomoth.pic", 0, 1 ; sprite dimensions
	dw VenomothPicFront, VenomothPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: full psychic moth, Bug/Poison flyer. auto
	; NIGHT_SHADE/TOXIC/LEECH_LIFE/PSYCHIC_M. bonus
	; CONFUSE_RAY/AERIAL_ACE/EXTRASENSORY/LIGHT_SCREEN/REFLECT. HM FLY.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AERIAL_ACE, TOXIC, EXTRASENSORY, LEECH_LIFE, \
	     PSYCHIC_M, LIGHT_SCREEN, REFLECT, FLY
	; end

	db 0 ; padding
