	db DEX_PORYGON ; pokedex id
	base_stat_row 75, 75, 75, 100, 75 ; hp atk def spc spd
	db NORMAL, ELECTRIC ; type
	db 10 ; catch rate  ; set by hand: not an animal: it is code, and it does not want holding
	db 130 ; base exp

	INCBIN "gfx/pokemon/front/porygon.pic", 0, 1 ; sprite dimensions
	dw PorygonPicFront, PorygonPicBack

	db THUNDERSHOCK, FOCUS_ENERGY, NO_MOVE, NO_MOVE ; level 1 learnset (silent digital construct, no GROWL)
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Single-stage digital construct:
	; SHOCK_WAVE/THUNDER_WAVE/AGILITY/LIGHT_SCREEN/REFLECT/
	; THUNDERBOLT/FLASH plus EXTRASENSORY/PSYCHIC_M. HM FLASH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, FLASH, ICY_PULSE, ICE_BEAM
	; end

	db 0 ; padding
