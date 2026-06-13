	db DEX_ELECTABUZZ ; pokedex id
	base_stat_row 75, 90, 65, 100, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 156 ; base exp

	INCBIN "gfx/pokemon/front/electabuzz.pic", 0, 1 ; sprite dimensions
	dw ElectabuzzPicFront, ElectabuzzPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm QUICK_ATTACK, RAGE,         BODY_SLAM,    FLAME_BURST,  SHOCK_WAVE, \
	     THUNDER_WAVE, BULK_UP,      AGILITY,      IRON_HEAD,    TAKE_DOWN, \
	     LIGHT_SCREEN, REFLECT,      THUNDERBOLT,  DOUBLE_EDGE,  MIMIC, \
	     MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    STRENGTH,     FLASH
	; end

	db 0 ; padding
