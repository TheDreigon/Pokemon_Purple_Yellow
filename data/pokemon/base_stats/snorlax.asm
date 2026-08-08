	db DEX_SNORLAX ; pokedex id
	base_stat_row 180, 110, 70, 70, 20 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 20 ; catch rate  ; set by hand: one per game, and it is an event
	db 154 ; base exp

	INCBIN "gfx/pokemon/front/snorlax.pic", 0, 1 ; sprite dimensions
	dw SnorlaxPicFront, SnorlaxPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Gentle lazy giant of sheer mass. Heavy body drives the ground
	; moves (BULLDOZE/EARTHQUAKE) and DOUBLE_EDGE/THRASH.
	tmhm BIND, BULLDOZE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, TAKE_DOWN, EARTHQUAKE, \
	     DOUBLE_EDGE, THRASH, STRENGTH, ROCK_THROW, SEISMIC_TOSS
	; end

	db 0 ; padding
