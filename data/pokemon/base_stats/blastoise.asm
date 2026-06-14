	db DEX_BLASTOISE ; pokedex id
	base_stat_row 90, 85, 110, 95, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/blastoise.pic", 0, 1 ; sprite dimensions
	dw BlastoisePicFront, BlastoisePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: full water-tank apex. auto
	; WATER_PULSE/BODY_SLAM/ICE_BEAM/SURF. bonus
	; BULLDOZE/BULK_UP/IRON_HEAD/INTIMIDATE/TAKE_DOWN/LIGHT_SCREEN/REFLECT/EARTHQUAKE/DOUBLE_EDGE.
	; HM CUT/SURF/STRENGTH. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BULLDOZE, WATER_PULSE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, INTIMIDATE, \
	     TAKE_DOWN, LIGHT_SCREEN, ICE_BEAM, REFLECT, EARTHQUAKE, \
	     DOUBLE_EDGE, CUT, SURF, STRENGTH
	; end

	db 0 ; padding
