	db DEX_ELECTRODE ; pokedex id
	base_stat_row 40, 90, 80, 90, 130 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 60 ; catch rate
	db 150 ; base exp

	INCBIN "gfx/pokemon/front/electrode.pic", 0, 1 ; sprite dimensions
	dw ElectrodePicFront, ElectrodePicBack

	db TACKLE, SCREECH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    HYPER_BEAM,   RAGE,         THUNDERBOLT,  \
	     THUNDER,      TELEPORT,     MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         DARK_PULSE, DISCHARGE,        HEAD_SMASH,   REST,         \
	     THUNDER_WAVE, EXPLOSION,    SUBSTITUTE,   FLASH
	; end

	db 0 ; padding
