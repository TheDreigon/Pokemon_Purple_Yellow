	db DEX_PORYGON ; pokedex id
	base_stat_row 75, 75, 75, 100, 75 ; hp atk def spc spd
	db NORMAL, ELECTRIC ; type
	db 45 ; catch rate
	db 130 ; base exp

	INCBIN "gfx/pokemon/front/porygon.pic", 0, 1 ; sprite dimensions
	dw PorygonPicFront, PorygonPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Porygon, single-stage digital construct (last). auto
	; SHOCK_WAVE/THUNDER_WAVE/MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME/AGILITY/LIGHT_SCREEN/REFLECT/THUNDERBOLT/FLASH.
	; bonus PSYCHIC_M. HM FLASH. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, FLASH
	; end

	db 0 ; padding
