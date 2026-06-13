	db DEX_VICTREEBEL ; pokedex id
	base_stat_row 80, 100, 70, 100, 90 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 191 ; base exp

	INCBIN "gfx/pokemon/front/victreebel.pic", 0, 1 ; sprite dimensions
	dw VictreebelPicFront, VictreebelPicBack

	db ABSORB, WRAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): apex carnivore. Weepinbell's 7 + 5
	; Victreebel additions: TAKE_DOWN¹ (vine grapple — levelup), DOUBLE_
	; EDGE¹ (apex predator overcommit — levelup), SWORDS_DANCE (Forte
	; filter: aggressive carnivore + iniciativa), SCARY_FACE¹ (giant
	; trap mouth — levelup), INTIMIDATE (Forte add). NO AGILITY (Forte
	; removed). NO DOUBLE_TEAM (Forte removed).
	tmhm GIGA_DRAIN,   TOXIC,        FAINT_ATTACK, BODY_SLAM,    LEECH_LIFE, \
	     CUT,          TAKE_DOWN,    DOUBLE_EDGE,  SWORDS_DANCE, SCARY_FACE, \
	     INTIMIDATE,   MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
