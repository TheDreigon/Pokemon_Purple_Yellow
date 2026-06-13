	db DEX_GLOOM ; pokedex id
	base_stat_row 80, 70, 70, 80, 40 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 120 ; catch rate
	db 132 ; base exp

	INCBIN "gfx/pokemon/front/gloom.pic", 0, 1 ; sprite dimensions
	dw GloomPicFront, GloomPicBack

	db ABSORB, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): mid-stage flower bud (Grass/Fungus).
	; Inherits Oddish's 3. No additions (SCREECH/TOXIC are levelup-only,
	; no separate TM; TOXIC TM34 already inherited).
	tmhm GIGA_DRAIN,   TOXIC
	; end

	db 0 ; padding
