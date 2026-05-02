	db DEX_HITMONLEE ; pokedex id
	base_stat_row 80, 110, 70, 60, 100 ; hp atk def spc spd

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 139 ; base exp

	INCBIN "gfx/pokemon/front/hitmonlee.pic", 0, 1 ; sprite dimensions
	dw HitmonleePicFront, HitmonleePicBack

	db CALM_MIND, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
