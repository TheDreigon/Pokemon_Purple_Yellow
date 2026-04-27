	db DEX_VENONAT ; pokedex id
	base_stat_row 60, 45, 50, 50, 50 ; hp atk def spc spd

	db BUG, POISON ; type
	db 190 ; catch rate
	db 75 ; base exp

	INCBIN "gfx/pokemon/front/venonat.pic", 0, 1 ; sprite dimensions
	dw VenonatPicFront, VenonatPicBack

	db TACKLE, DISABLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: pre-moth Bug/Poison. 4 universals + Leech Life, Toxic
	; (levelup-doubles), Extrasensory, Psychic_M (levelup-double), Light
	; Screen. No FLY (no wings — Venomoth-only). No powder TMs (powders
	; are Venomoth-exclusive per Forte).
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    LEECH_LIFE,   \
	     TOXIC,        EXTRASENSORY, PSYCHIC_M,    LIGHT_SCREEN
	; end

	db 0 ; padding
