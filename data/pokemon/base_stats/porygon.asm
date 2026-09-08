	db DEX_PORYGON ; pokedex id
	base_stat_row 75, 75, 75, 100, 100, 75 ; hp atk def spatk spdef spd
	db NORMAL, ELECTRIC ; type
	db 10 ; catch rate  ; set by hand: not an animal: it is code, and it does not want holding
	db 240 ; base exp  ; escolha dele

	INCBIN "gfx/pokemon/front/porygon.pic", 0, 1 ; sprite dimensions
	dw PorygonPicFront, PorygonPicBack

	db THUNDERSHOCK, FOCUS_ENERGY, NO_MOVE, NO_MOVE ; level 1 learnset (silent digital construct, no GROWL)
	db GROWTH_MEDIUM_FAST ; growth rate  ; v0.7 (2026-09-08, Forte): was FAST - handed over at L20, L25 and L30 mid-game with 475 BST, nothing to compensate

	; tm/hm learnset
	; Single-stage digital construct:
	; SHOCK_WAVE/THUNDER_WAVE/AGILITY/LIGHT_SCREEN/REFLECT/
	; THUNDERBOLT/FLASH plus EXTRASENSORY/PSYCHIC_M. HM FLASH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SHOCK_WAVE, THUNDER_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT, FLASH, ICY_PULSE, ICE_BEAM
	; end

	db BANK(PorygonPicFront) ; which bank this mon's pics live in
	assert BANK(PorygonPicFront) == BANK(PorygonPicBack), \
	    "Porygon: front and back pics must share a bank"
