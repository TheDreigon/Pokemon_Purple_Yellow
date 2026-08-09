	db DEX_WEEZING ; pokedex id
	base_stat_row 90, 95, 100, 95, 50 ; hp atk def spc spd
	db POISON, GAS ; type
	db 55 ; catch rate  ; set by hand: level with Muk
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/weezing.pic", 0, 1 ; sprite dimensions
	dw WeezingPicFront, WeezingPicBack

	db SMOKESCREEN, SMOG, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex gas balloon (Poison/Gas), a sinister toxic-cloud concept.
	; Toxic, dark and flame moves (FLAME_BURST/FLAMETHROWER) with
	; intimidating scary-face. Fun moves (last-stage).
	tmhm FLAME_BURST, NIGHT_SHADE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, TOXIC, SCARY_FACE, LIGHT_SCREEN, DARK_PULSE, \
	     FLAMETHROWER
	; end

	db BANK(WeezingPicFront) ; which bank this mon's pics live in
	assert BANK(WeezingPicFront) == BANK(WeezingPicBack), \
	    "Weezing: front and back pics must share a bank"
