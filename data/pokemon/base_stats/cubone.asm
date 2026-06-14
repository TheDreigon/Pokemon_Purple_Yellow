	db DEX_CUBONE ; pokedex id
	base_stat_row 50, 50, 80, 40, 40 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp

	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
	dw CubonePicFront, CubonePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Cubone, baby ground bone-wielder solitario. auto
	; FAINT_ATTACK/BULLDOZE/RAGE/BULK_UP/DOUBLE_EDGE. bonus
	; ROCK_THROW/BODY_SLAM/CHARM/TAKE_DOWN/ROCK_SLIDE.
	tmhm ROCK_THROW, FAINT_ATTACK, BULLDOZE, RAGE, BODY_SLAM, \
	     BULK_UP, CHARM, TAKE_DOWN, ROCK_SLIDE, DOUBLE_EDGE
	; end

	db 0 ; padding
