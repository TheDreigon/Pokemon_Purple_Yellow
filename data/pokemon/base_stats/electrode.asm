	db DEX_ELECTRODE ; pokedex id
	base_stat_row 40, 90, 80, 90, 130 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 60 ; catch rate
	db 150 ; base exp

	INCBIN "gfx/pokemon/front/electrode.pic", 0, 1 ; sprite dimensions
	dw ElectrodePicFront, ElectrodePicBack

	db TACKLE, SCREECH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Electric/Steel sphere (130 Spd), no limbs or
	; hands. auto
	; SHOCK_WAVE/THUNDER_WAVE/AGILITY/LIGHT_SCREEN/REFLECT/THUNDERBOLT/FLASH.
	; bonus BULLDOZE/IRON_HEAD. HM FLASH. fun (4 via TM, regra global
	; last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BULLDOZE, SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, FLASH
	; end

	db 0 ; padding
