	db DEX_VAPOREON ; pokedex id
	base_stat_row 130, 65, 65, 110, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 196 ; base exp

	INCBIN "gfx/pokemon/front/vaporeon.pic", 0, 1 ; sprite dimensions
	dw VaporeonPicFront, VaporeonPicBack

	db TACKLE, TAIL_WHIP, WATER_GUN, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Water fox. Eevee's 6 + 7 water/utility additions:
	; WATER_PULSE¹, ICE_BEAM¹, HYDRO_PUMP¹, BLIZZARD, HM03 SURF¹,
	; LIGHT_SCREEN/REFLECT (Forte #9), TAKE_DOWN (per Forte #10 — Eevee
	; loses, evolutions keep). NO HM05 FLASH (Forte #8 — water mons don't
	; FLASH).
	tmhm QUICK_ATTACK, BODY_SLAM,    DOUBLE_EDGE,  AGILITY,      HONE_CLAWS,   \
	     FAKE_TEARS,   WATER_PULSE,  ICE_BEAM,     HYDRO_PUMP,   BLIZZARD,     \
	     SURF,         LIGHT_SCREEN, REFLECT,      TAKE_DOWN
	; end

	db 0 ; padding
