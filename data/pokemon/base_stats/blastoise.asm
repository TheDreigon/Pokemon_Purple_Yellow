	db DEX_BLASTOISE ; pokedex id
	base_stat_row 90, 85, 110, 95, 80 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/blastoise.pic", 0, 1 ; sprite dimensions
	dw BlastoisePicFront, BlastoisePicBack

	db BITE, WATERFALL, HEAD_SMASH, HYDRO_PUMP ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: full water tank. Wartortle's 16 + 5 cannon/massive-tier:
	; Intimidate (massive presence), Ice Beam (cold cannon — supercooled
	; water spray; modern canon stretch), Earthquake (levelup-double, only
	; truly massive turtle), Hydro Pump (levelup-double, signature cannon),
	; Blizzard (peak cold).
	tmhm WATER_PULSE,  BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  LIGHT_SCREEN, \
	     REFLECT,      CUT,          SURF,         BULLDOZE,     BULK_UP,      \
	     HONE_CLAWS,   STRENGTH,     INTIMIDATE,   ICE_BEAM,     EARTHQUAKE,   \
	     HYDRO_PUMP,   BLIZZARD,     IRON_HEAD
	; end

	db 0 ; padding
