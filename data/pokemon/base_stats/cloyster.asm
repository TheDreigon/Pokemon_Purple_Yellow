	db DEX_CLOYSTER ; pokedex id
	base_stat_row 45, 90, 180, 90, 45 ; hp atk def spc spd

	db WATER, ICE ; type
	db 60 ; catch rate
	db 203 ; base exp

	INCBIN "gfx/pokemon/front/cloyster.pic", 0, 1 ; sprite dimensions
	dw CloysterPicFront, CloysterPicBack

	db TACKLE, WITHDRAW, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Cloyster apex Water/Ice fortress, hard spiked shell.
	; auto BIND/WATER_PULSE/ICY_PULSE/BODY_SLAM/ICE_BEAM/ROCK_SLIDE.
	; bonus DAZZLE_GLEAM/TOXIC/LIGHT_SCREEN/REFLECT. HM SURF. fun (4 via
	; TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, TOXIC, \
	     LIGHT_SCREEN, ICE_BEAM, REFLECT, ROCK_SLIDE, SURF
	; end

	db 0 ; padding
