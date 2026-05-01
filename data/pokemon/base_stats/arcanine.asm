	db DEX_ARCANINE ; pokedex id
	base_stat_row 100, 100, 80, 80, 95 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 75 ; catch rate
	db 213 ; base exp

	INCBIN "gfx/pokemon/front/arcanine.pic", 0, 1 ; sprite dimensions
	dw ArcaninePicFront, ArcaninePicBack

	db BITE, SCARY_FACE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
