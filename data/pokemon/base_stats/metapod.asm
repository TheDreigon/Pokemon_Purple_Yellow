	db DEX_METAPOD ; pokedex id
	base_stat_row 50, 20, 75, 25, 5 ; hp atk def spc spd

	db BUG, BUG ; type
	db 120 ; catch rate
	db 72 ; base exp

	INCBIN "gfx/pokemon/front/metapod.pic", 0, 1 ; sprite dimensions
	dw MetapodPicFront, MetapodPicBack

	db TACKLE, HARDEN, STRING_SHOT, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: cocoon. Same TM kit as Caterpie — cocoon doesn't gain
	; new techniques, just hardens.
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    LEECH_LIFE
	; end

	db 0 ; padding
