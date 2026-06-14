	db DEX_GOLEM ; pokedex id
	base_stat_row 80, 110, 135, 65, 65 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/golem.pic", 0, 1 ; sprite dimensions
	dw GolemPicFront, GolemPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex turtle-shell rock (Rock/Ground). auto
	; ROCK_THROW/BULLDOZE/BODY_SLAM/IRON_HEAD/TAKE_DOWN/EARTHQUAKE/ROCK_SLIDE/DOUBLE_EDGE/STRENGTH.
	; bonus SCARY_FACE. HM STRENGTH. fun (4 via TM, regra global
	; last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, IRON_HEAD, SCARY_FACE, TAKE_DOWN, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, STRENGTH
	; end

	db 0 ; padding
