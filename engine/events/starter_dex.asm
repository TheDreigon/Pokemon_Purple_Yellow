; temporarily marks the starters (and Ivysaur) as OWNED so that
; ShowPokedexData displays their full Pokedex entries (Gen 1 gates
; height/weight/entry on the owned flag, not seen).
; Leftover from Red/Blue's Oak's Lab pokeball check; no caller in Yellow.
StarterDex:
	ld a, 1 << (DEX_BULBASAUR - 1) | 1 << (DEX_IVYSAUR - 1) | 1 << (DEX_CHARMANDER - 1) | 1 << (DEX_SQUIRTLE - 1)
	ld [wPokedexOwned], a
	ld a, 0
	ld [wMoveListCounter], a
	predef ShowPokedexData
	xor a
	ld [wPokedexOwned], a
	ret
