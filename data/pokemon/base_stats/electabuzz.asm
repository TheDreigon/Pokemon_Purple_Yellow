	db DEX_ELECTABUZZ ; pokedex id
	base_stat_row 75, 95, 65, 95, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 156 ; base exp

	INCBIN "gfx/pokemon/front/electabuzz.pic", 0, 1 ; sprite dimensions
	dw ElectabuzzPicFront, ElectabuzzPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electabuzz, boxer Electric do power-plant
	; (counterpart de Magmar). auto
	; QUICK_ATTACK/FAINT_ATTACK/SHOCK_WAVE/THUNDER_WAVE/BULK_UP/AGILITY/LIGHT_SCREEN/THUNDERBOLT/FLASH.
	; bonus
	; RAGE/BODY_SLAM/FLAME_BURST/IRON_HEAD/TAKE_DOWN/REFLECT/DOUBLE_EDGE.
	; HM STRENGTH/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, FLAME_BURST, \
	     SHOCK_WAVE, THUNDER_WAVE, BULK_UP, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, IRON_HEAD, TAKE_DOWN, \
	     LIGHT_SCREEN, REFLECT, THUNDERBOLT, DOUBLE_EDGE, STRENGTH, \
	     FLASH
	; end

	db 0 ; padding
