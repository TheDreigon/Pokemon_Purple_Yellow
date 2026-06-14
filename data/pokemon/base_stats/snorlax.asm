	db DEX_SNORLAX ; pokedex id
	base_stat_row 180, 110, 70, 70, 20 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 25 ; catch rate
	db 154 ; base exp

	INCBIN "gfx/pokemon/front/snorlax.pic", 0, 1 ; sprite dimensions
	dw SnorlaxPicFront, SnorlaxPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: gentle lazy giant of sheer mass. auto
	; BIND/BULLDOZE/BODY_SLAM/BULK_UP/TAKE_DOWN/EARTHQUAKE/DOUBLE_EDGE/THRASH.
	; HM STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, TAKE_DOWN, EARTHQUAKE, \
	     DOUBLE_EDGE, THRASH, STRENGTH
	; end

	db 0 ; padding
