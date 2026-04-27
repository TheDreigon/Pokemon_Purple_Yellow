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
	; v0.7 Pass 3: pre-moth Bug/Poison. Leech Life + Toxic (levelup-doubles),
	; Extrasensory, Psychic_M (levelup-double), Light Screen. No FLY (no
	; wings — Venomoth-only). No powder TMs (Venomoth-exclusive per Forte).
	; NO fun moves (per Forte's revised rule — Bug/Poison typing not
	; psychic-coded enough for Mimic/Mirror Move; not magical, not decoy).
	tmhm LEECH_LIFE,   TOXIC,        EXTRASENSORY, PSYCHIC_M,    LIGHT_SCREEN
	; end

	db 0 ; padding
