	db DEX_MAGNETON ; pokedex id
	base_stat_row 60, 75, 100, 120, 65 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 80 ; catch rate  ; set by hand
	db 161 ; base exp

	INCBIN "gfx/pokemon/front/magneton.pic", 0, 1 ; sprite dimensions
	dw MagnetonPicFront, MagnetonPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Electric/Steel magnet cluster. Last-stage fun moves allowed.
	tmhm BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, IRON_HEAD, LIGHT_SCREEN, REFLECT, \
	     THUNDERBOLT
	; end

	db 0 ; padding
