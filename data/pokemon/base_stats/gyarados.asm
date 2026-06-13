	db DEX_GYARADOS ; pokedex id
	base_stat_row 90, 130, 90, 90, 80 ; hp atk def spc spd
	db WATER, DRAGON ; type
	db 45 ; catch rate
	db 214 ; base exp

	INCBIN "gfx/pokemon/front/gyarados.pic", 0, 1 ; sprite dimensions
	dw GyaradosPicFront, GyaradosPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AGILITY,      BIND,         BODY_SLAM,    DOUBLE_EDGE,  DRAGON_CLAW, \
	     EARTHQUAKE,   ICE_BEAM,     INTIMIDATE,   IRON_HEAD,    IRON_TAIL, \
	     OUTRAGE,      RAGE,         ROCK_SLIDE,   SCARY_FACE,   TAKE_DOWN, \
	     THRASH,       WATER_PULSE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    SURF,         STRENGTH
	; end

	db 0 ; padding
