	db DEX_PARASECT ; pokedex id
	base_stat_row 95, 90, 90, 90, 20 ; hp atk def spc spd
	db BUG, FUNGUS ; type
	db 75 ; catch rate
	db 128 ; base exp

	INCBIN "gfx/pokemon/front/parasect.pic", 0, 1 ; sprite dimensions
	dw ParasectPicFront, ParasectPicBack

	db SPORE, PARASITE, TOXIC_FANGS, NIGHT_SLASH ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): mushroom-dominated apex (Bug/Fungus).
	; Paras' 3 + 8 Parasect additions: SCARY_FACE¹ (creepy fungal-zombie
	; — Forte add to levelup, also TM), SWORDS_DANCE (claws warrior),
	; HONE_CLAWS (sharp claws), BODY_SLAM (heavy fungal-bug), TAKE_DOWN
	; (apex), DOUBLE_EDGE¹ (recoil — Forte swap from BODY_SLAM in
	; levelup), POISON_FANG (mandibular toxin TM, sister to TOXIC_FANGS¹
	; levelup), HM01 CUT (per Forte's HM list).
	tmhm LEECH_LIFE,   GIGA_DRAIN,   TOXIC,        SCARY_FACE,   SWORDS_DANCE, \
	     BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  POISON_FANG,  CUT, \
	     MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
