	db DEX_BUTTERFREE ; pokedex id
	base_stat_row 60, 60, 55, 95, 85 ; hp atk def spc spd
	db BUG, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 160 ; base exp

	INCBIN "gfx/pokemon/front/butterfree.pic", 0, 1 ; sprite dimensions
	dw ButterfreePicFront, ButterfreePicBack

	db BUG_BITE, GUST, CONFUSION, PSYCHIC_M ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: butterfly Bug/Psychic. Caterpie/Metapod's 5 + 7 wing/
	; psychic/light additions. HM02 Fly per Forte's HM-Fly list. HM05 Flash
	; per Forte (powdery wing scales bright enough for cave illumination —
	; usual fire-type rule extended to bright-bodied bugs). HURRICANE TM
	; (also levelup-double). FAIRY_WIND, QUIVER_DANCE, WING_ATTACK are
	; levelup-only (not TMs in this hack).
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    LEECH_LIFE,   \
	     EXTRASENSORY, PSYCHIC_M,    LIGHT_SCREEN, REFLECT,      HURRICANE,    \
	     FLY,          FLASH
	; end

	db 0 ; padding
