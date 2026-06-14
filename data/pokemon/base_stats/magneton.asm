	db DEX_MAGNETON ; pokedex id
	base_stat_row 60, 75, 100, 120, 65 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 60 ; catch rate
	db 161 ; base exp

	INCBIN "gfx/pokemon/front/magneton.pic", 0, 1 ; sprite dimensions
	dw MagnetonPicFront, MagnetonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Electric/Steel magnet cluster. auto
	; BODY_SLAM/SHOCK_WAVE/THUNDER_WAVE/IRON_HEAD/LIGHT_SCREEN/THUNDERBOLT.
	; bonus REFLECT. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, IRON_HEAD, LIGHT_SCREEN, REFLECT, \
	     THUNDERBOLT
	; end

	db 0 ; padding
