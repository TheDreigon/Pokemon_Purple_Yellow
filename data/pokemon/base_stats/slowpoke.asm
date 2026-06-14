	db DEX_SLOWPOKE ; pokedex id
	base_stat_row 90, 45, 65, 55, 15 ; hp atk def spc spd
	db WATER, NORMAL ; type
	db 190 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/slowpoke.pic", 0, 1 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: slow docile Water/Normal pre-evo. auto
	; WATER_PULSE/EXTRASENSORY. bonus CONFUSE_RAY. HM SURF/STRENGTH.
	tmhm WATER_PULSE, CONFUSE_RAY, EXTRASENSORY, SURF, STRENGTH
	; end

	db 0 ; padding
