	db DEX_RHYHORN ; pokedex id
	base_stat_row 80, 85, 95, 40, 55 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 120 ; catch rate
	db 135 ; base exp

	INCBIN "gfx/pokemon/front/rhyhorn.pic", 0, 1 ; sprite dimensions
	dw RhyhornPicFront, RhyhornPicBack

	db HORN_ATTACK, LEER, GROUND_STOMP, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): rhinoceros charger. 8 TMs. ROCK_THROW
	; (rock-type basic), DOUBLE_EDGE (recoil charge — rhino canonical),
	; IRON_HEAD¹ (shared L46). HM04 STRENGTH per Forte's list.
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    IRON_HEAD,    DOUBLE_EDGE, \
	     TAKE_DOWN,    EARTHQUAKE,   STRENGTH
	; end

	db 0 ; padding
