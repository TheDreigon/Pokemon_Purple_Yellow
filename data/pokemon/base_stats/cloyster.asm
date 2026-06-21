	db DEX_CLOYSTER ; pokedex id
	base_stat_row 45, 85, 180, 90, 40 ; hp atk def spc spd

	db WATER, ICE ; type
	db 60 ; catch rate
	db 203 ; base exp

	INCBIN "gfx/pokemon/front/cloyster.pic", 0, 1 ; sprite dimensions
	dw CloysterPicFront, CloysterPicBack

	db TACKLE, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Water/Ice fortress with a hard spiked shell. Water/Ice offense
	; (WATER_PULSE/ICY_PULSE/ICE_BEAM/SURF), shell defense
	; (LIGHT_SCREEN/REFLECT), BIND clamp, ROCK_SLIDE, TOXIC. 4 fun moves
	; (last stage).
	tmhm BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, TOXIC, \
	     LIGHT_SCREEN, ICE_BEAM, REFLECT, ROCK_SLIDE, SURF
	; end

	db 0 ; padding
