	db DEX_NIDOQUEEN ; pokedex id
	base_stat_row 100, 85, 85, 80, 80 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 194 ; base exp

	INCBIN "gfx/pokemon/front/nidoqueen.pic", 0, 1 ; sprite dimensions
	dw NidoqueenPicFront, NidoqueenPicBack

	db CHARM, HEADBUTT, TOXIC_FANGS, SAND_ATTACK ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review F#2): matriarch, fairy + ground apex.
	; Inherits Nidorina's 7 + 9 queen additions: BULK_UP/SWORDS_DANCE/
	; CALM_MIND (training), FAKE_TEARS (queen emotional weapon), INTIMIDATE
	; (apex presence), ROCK_SLIDE (Forte F-old — Nidoqueen-only), EARTH-
	; QUAKE¹ (matches levelup), HM01 CUT (royal claws), HM04 STRENGTH¹.
	; Egg moves: CHARM/HEADBUTT/TOXIC_FANGS/SAND_ATTACK per Forte F#3.
	tmhm BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN,    FAINT_ATTACK, \
	     DOUBLE_EDGE,  BULK_UP,      FAKE_TEARS,   INTIMIDATE,   ROCK_SLIDE, \
	     SWORDS_DANCE, CALM_MIND,    EARTHQUAKE,   CUT,          STRENGTH
	; end

	db 0 ; padding
