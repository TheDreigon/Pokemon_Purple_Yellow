	db DEX_NINETALES ; pokedex id
	base_stat_row 80, 70, 70, 110, 105 ; hp atk def spc spd
	db FIRE, FAIRY ; type
	db 75 ; catch rate
	db 178 ; base exp

	INCBIN "gfx/pokemon/front/ninetales.pic", 0, 1 ; sprite dimensions
	dw NinetalesPicFront, NinetalesPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; v0.7 Pass 3: Ninetales — apex mística kitsune Fire-Fairy. Last-stage generosa.
	; Autos +FAINT_ATTACK (QUICK_ATTACK/CONFUSE_RAY/NIGHT_SHADE/AGILITY/FLAMETHROWER/
	; DAZZLE_GLEAM). Bonus sinistro/espectral coerente com a kitsune mística
	; (SHADOW_BALL/DARK_PULSE — caudas canalizam o espectral) + CALM_MIND apex setup.
	; Sem HM FLASH (Forte: removido — EERIE_IMPULSE já cobre utility). 4 fun moves (regra global last-stage).
	; tm/hm learnset
	; v0.7 Pass 3: Ninetales - apex mistica kitsune Fire-Fairy,
	; last-stage generosa (24 entries). auto
	; QUICK_ATTACK/FAINT_ATTACK/NIGHT_SHADE/CONFUSE_RAY/DAZZLE_GLEAM/AGILITY/SHADOW_BALL/FLAMETHROWER.
	; bonus
	; BODY_SLAM/FLAME_BURST/IGNITE/FAKE_TEARS/CHARM/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/DARK_PULSE/REFLECT/CALM_MIND.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, FLAME_BURST, NIGHT_SHADE, \
	     CONFUSE_RAY, IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, DAZZLE_GLEAM, AGILITY, FAKE_TEARS, CHARM, \
	     EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, DARK_PULSE, SHADOW_BALL, \
	     FLAMETHROWER, REFLECT, CALM_MIND
	; end

	db 0 ; padding
