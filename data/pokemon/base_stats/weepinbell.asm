	db DEX_WEEPINBELL ; pokedex id
	base_stat_row 60, 85, 50, 75, 60 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 120 ; catch rate
	db 151 ; base exp

	INCBIN "gfx/pokemon/front/weepinbell.pic", 0, 1 ; sprite dimensions
	dw WeepinbellPicFront, WeepinbellPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): mid-stage carnivore. Bellsprout's 4 +
	; 3 additions: BODY_SLAM¹ (pitcher mass — levelup), LEECH_LIFE¹
	; (insect drain — levelup), HM01 CUT (per Forte's natural CUT list).
	tmhm GIGA_DRAIN,   TOXIC,        FAINT_ATTACK, BODY_SLAM,    LEECH_LIFE, \
	     CUT
	; end

	db 0 ; padding
