	db DEX_WARTORTLE ; pokedex id
	base_stat_row 65, 60, 80, 70, 55 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 143 ; base exp

	INCBIN "gfx/pokemon/front/wartortle.pic", 0, 1 ; sprite dimensions
	dw WartortlePicFront, WartortlePicBack

	db TACKLE, TAIL_WHIP, WATER_GUN, WITHDRAW ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: warrior turtle mid-stage. Squirtle's 12 + 4 medium-tier
	; additions: Bulldoze (medium-heavy stomp — not yet earthquake-tier),
	; Bulk Up (warrior buff), Hone Claws (sharper turtle claws), HM Strength.
	; No Earthquake (saved for Blastoise — only fully-massive frame). No
	; HYDRO_PUMP — still no shell-cannons.
	tmhm WATER_PULSE,  BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  LIGHT_SCREEN, \
	     REFLECT,      CUT,          SURF,         BULLDOZE,     BULK_UP, \
	     STRENGTH
	; end

	db 0 ; padding
