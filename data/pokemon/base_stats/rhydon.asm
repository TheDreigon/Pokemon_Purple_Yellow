	db DEX_RHYDON ; pokedex id
	base_stat_row 95, 120, 110, 65, 50 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 60 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/rhydon.pic", 0, 1 ; sprite dimensions
	dw RhydonPicFront, RhydonPicBack

	db HORN_CHARGE, FIERCE_ROAR, HORN_DRILL, BULLDOZE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): apex rhinoceros. Rhyhorn's 8 + 4
	; Rhydon additions (per Forte's via-TM lists): SCARY_FACE (apex
	; intimidating presence), INTIMIDATE¹ (matches levelup-tier presence),
	; SWORDS_DANCE (Forte's filter: aggressive+iniciativa charger),
	; IRON_TAIL (Forte explicit add).
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    IRON_HEAD,    DOUBLE_EDGE, \
	     TAKE_DOWN,    EARTHQUAKE,   STRENGTH,     SCARY_FACE,   INTIMIDATE, \
	     SWORDS_DANCE, IRON_TAIL
	; end

	db 0 ; padding
