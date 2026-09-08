	db DEX_BELLSPROUT ; pokedex id
	base_stat_row 40, 65, 40, 70, 40, 45 ; hp atk def spatk spdef spd

	db GRASS, GRASS ; type ; v0.7 (2026-09-05, Forte): pure GRASS; POISON arrives with WEEPINBELL (the BULBASAUR -> IVYSAUR shape)
	db 220 ; catch rate  ; base stage, BST 300
	db 85 ; base exp  ; BST 300

	INCBIN "gfx/pokemon/front/bellsprout.pic", 0, 1 ; sprite dimensions
	dw BellsproutPicFront, BellsproutPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Basic carnivorous pitcher plant (pure Grass; Poison arrives with WEEPINBELL). Grass STAB
	; GIGA_DRAIN, digestive TOXIC, ambush FAINT_ATTACK.
	tmhm FAINT_ATTACK, GIGA_DRAIN, TOXIC
	; end

	db BANK(BellsproutPicFront) ; which bank this mon's pics live in
	assert BANK(BellsproutPicFront) == BANK(BellsproutPicBack), \
	    "Bellsprout: front and back pics must share a bank"
