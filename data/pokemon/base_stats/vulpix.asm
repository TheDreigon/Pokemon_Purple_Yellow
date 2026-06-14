	db DEX_VULPIX ; pokedex id
	base_stat_row 50, 40, 40, 70, 70 ; hp atk def spc spd
	db FIRE, FAIRY ; type
	db 190 ; catch rate
	db 63 ; base exp

	INCBIN "gfx/pokemon/front/vulpix.pic", 0, 1 ; sprite dimensions
	dw VulpixPicFront, VulpixPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; v0.7 Pass 3: Vulpix — pre-evo kitsune raposa Fire-Fairy. Backbone subset.
	; Autos QUICK_ATTACK/CONFUSE_RAY/NIGHT_SHADE/FAINT_ATTACK/AGILITY/FLAMETHROWER.
	; Bonus fire (FLAME_BURST/IGNITE) + cute/mystical kitsune gestures (FAKE_TEARS/
	; CHARM/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/REFLECT). Sem fun moves nem apex
	; setup (CALM_MIND/SHADOW_BALL/DARK_PULSE/DAZZLE_GLEAM reservados a Ninetales).
	; tm/hm learnset
	; v0.7 Pass 3: Vulpix - pre-evo kitsune raposa Fire-Fairy, backbone
	; subset. auto
	; QUICK_ATTACK/FAINT_ATTACK/NIGHT_SHADE/CONFUSE_RAY/AGILITY/FLAMETHROWER.
	; bonus
	; BODY_SLAM/FLAME_BURST/IGNITE/FAKE_TEARS/CHARM/EXTRASENSORY/PSYCHIC_M/LIGHT_SCREEN/REFLECT.
	tmhm QUICK_ATTACK, FAINT_ATTACK, BODY_SLAM, FLAME_BURST, NIGHT_SHADE, \
	     CONFUSE_RAY, IGNITE, AGILITY, FAKE_TEARS, CHARM, \
	     EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, FLAMETHROWER, REFLECT
	; end

	db 0 ; padding
