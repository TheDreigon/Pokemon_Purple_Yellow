	db DEX_HAUNTER ; pokedex id
	base_stat_row 45, 60, 45, 105, 100 ; hp atk def spc spd
	db GHOST, GAS ; type
	db 90 ; catch rate
	db 126 ; base exp

	INCBIN "gfx/pokemon/front/haunter.pic", 0, 1 ; sprite dimensions
	dw HaunterPicFront, HaunterPicBack

	db LICK, CONFUSE_RAY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Haunter, handed sinister ghost, intermediate subset
	; above Gastly. auto
	; FAINT_ATTACK/NIGHT_SHADE/CONFUSE_RAY/TOXIC/EXTRASENSORY/INTIMIDATE/SCARY_FACE/DARK_PULSE/SHADOW_BALL.
	; bonus POISON_FANG.
	tmhm FAINT_ATTACK, NIGHT_SHADE, CONFUSE_RAY, POISON_FANG, TOXIC, \
	     EXTRASENSORY, INTIMIDATE, SCARY_FACE, DARK_PULSE, SHADOW_BALL
	; end

	db 0 ; padding
