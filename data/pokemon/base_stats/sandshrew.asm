	db DEX_SANDSHREW ; pokedex id
	base_stat_row 50, 70, 90, 30, 40 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 255 ; catch rate
	db 93 ; base exp

	INCBIN "gfx/pokemon/front/sandshrew.pic", 0, 1 ; sprite dimensions
	dw SandshrewPicFront, SandshrewPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: armoured Ground armadillo, defensive digger pre-evo.
	; auto BULLDOZE. bonus
	; ROCK_THROW/BODY_SLAM/IRON_TAIL/IRON_HEAD/TAKE_DOWN/EARTHQUAKE/ROCK_SLIDE/DOUBLE_EDGE.
	; HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, IRON_TAIL, IRON_HEAD, \
	     TAKE_DOWN, EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, CUT, \
	     STRENGTH
	; end

	db 0 ; padding
