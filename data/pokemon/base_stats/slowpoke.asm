	db DEX_SLOWPOKE ; pokedex id
	base_stat_row 90, 45, 65, 55, 15 ; hp atk def spc spd
	db WATER, NORMAL ; type
	db 235 ; catch rate  ; base stage, BST 270, easy to approach
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/slowpoke.pic", 0, 1 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack

	db REST, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset (born sleepy: REST as the egg move)
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Slow docile Water/Normal pre-evo.
	tmhm WATER_PULSE, CONFUSE_RAY, EXTRASENSORY, SURF, STRENGTH
	; end

	db 0 ; padding
