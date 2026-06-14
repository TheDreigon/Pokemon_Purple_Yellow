	db DEX_MUK ; pokedex id
	base_stat_row 130, 95, 70, 95, 40 ; hp atk def spc spd
	db POISON, WATER ; type
	db 75 ; catch rate
	db 157 ; base exp

	INCBIN "gfx/pokemon/front/muk.pic", 0, 1 ; sprite dimensions
	dw MukPicFront, MukPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Muk apex sludge blob, Poison/Water. auto
	; BIND/BODY_SLAM/TOXIC/SCARY_FACE/TAKE_DOWN. bonus
	; BULLDOZE/EARTHQUAKE/DOUBLE_EDGE/THRASH. HM STRENGTH. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, TOXIC, SCARY_FACE, TAKE_DOWN, \
	     EARTHQUAKE, DOUBLE_EDGE, THRASH, STRENGTH
	; end

	db 0 ; padding
