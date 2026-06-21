	db DEX_SEADRA ; pokedex id
	base_stat_row 60, 70, 90, 80, 80 ; hp atk def spc spd
	db WATER, DRAGON ; type
	db 75 ; catch rate
	db 155 ; base exp

	INCBIN "gfx/pokemon/front/seadra.pic", 0, 1 ; sprite dimensions
	dw SeadraPicFront, SeadraPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Water/Dragon last-stage; Horsea backbone plus dragon apex.
	tmhm WATER_PULSE, ICY_PULSE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TOXIC, SCARY_FACE, ICE_BEAM, \
	     OUTRAGE, SURF
	; end

	db 0 ; padding
