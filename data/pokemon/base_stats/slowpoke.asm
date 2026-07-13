	db DEX_SLOWPOKE ; pokedex id
	base_stat_row 90, 45, 65, 55, 15 ; hp atk def spc spd
	db WATER, NORMAL ; type
	db 190 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/slowpoke.pic", 0, 1 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack

	db REST, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset. REST<->TACKLE swap w/ the L10 learnset slot (Forte 2026-07-13: born sleepy)
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Slow docile Water/Normal pre-evo.
	tmhm WATER_PULSE, CONFUSE_RAY, EXTRASENSORY, SURF, STRENGTH
	; end

	db 0 ; padding
