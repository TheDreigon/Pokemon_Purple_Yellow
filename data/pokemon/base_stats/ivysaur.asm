	db DEX_IVYSAUR ; pokedex id
	base_stat_row 70, 60, 65, 75, 60 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 141 ; base exp

	INCBIN "gfx/pokemon/front/ivysaur.pic", 0, 1 ; sprite dimensions
	dw IvysaurPicFront, IvysaurPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: matured plant — superset of Bulbasaur. Bulky additions
	; (Body Slam / Take Down stay shared / Double Edge — heavier frame),
	; ground-shaking (Bulldoze / Earthquake — quadruped weight), Poison
	; mature (Toxic — already Poison-type now), HM utility (Strength = push,
	; Flash = bulb opening glow).
	tmhm GIGA_DRAIN,   BIND,         TAKE_DOWN,    LIGHT_SCREEN, REFLECT, \
	     CUT,          BULLDOZE,     BODY_SLAM,    TOXIC,        DOUBLE_EDGE, \
	     EARTHQUAKE,   STRENGTH,     FLASH
	; end

	db 0 ; padding
