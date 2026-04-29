	db DEX_BELLSPROUT ; pokedex id
	base_stat_row 40, 65, 35, 55, 40 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 255 ; catch rate
	db 84 ; base exp

	INCBIN "gfx/pokemon/front/bellsprout.pic", 0, 1 ; sprite dimensions
	dw BellsproutPicFront, BellsproutPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): basic carnivorous plant. 4 TMs:
	; GIGA_DRAIN¹ (drain plant), TOXIC (poison-type tendency),
	; SOLARBEAM (plant TM apex — not levelup per Forte),
	; FAINT_ATTACK (Forte add — sneak vine strike).
	tmhm GIGA_DRAIN,   TOXIC,        SOLARBEAM,    FAINT_ATTACK
	; end

	db 0 ; padding
