	db DEX_MEWTWO ; pokedex id
	base_stat_row 120, 90, 90, 150, 150 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 3 ; catch rate
	db 220 ; base exp

	INCBIN "gfx/pokemon/front/mewtwo.pic", 0, 1 ; sprite dimensions
	dw MewtwoPicFront, MewtwoPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLIGHTLY_SLOW ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex psiquico + honorary Dark, arma genetica
	; definitiva. auto
	; QUICK_ATTACK/FAINT_ATTACK/AGILITY/EXTRASENSORY/INTIMIDATE/SCARY_FACE/PSYCHIC_M/LIGHT_SCREEN/DARK_PULSE/SHADOW_BALL/REFLECT/OUTRAGE.
	; bonus
	; NIGHT_SHADE/CONFUSE_RAY/TOXIC/ICE_BEAM/FLAMETHROWER/THUNDERBOLT.
	; HM STRENGTH/FLASH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, ICY_PULSE, FLAME_BURST, SHOCK_WAVE, \
	     NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TOXIC, EXTRASENSORY, INTIMIDATE, \
	     SCARY_FACE, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, DARK_PULSE, \
	     SHADOW_BALL, FLAMETHROWER, REFLECT, THUNDERBOLT, OUTRAGE, \
	     STRENGTH, FLASH
	; end

	db 0 ; padding
