	db DEX_GOLEM ; pokedex id
	base_stat_row 85, 110, 135, 65, 65 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 45 ; catch rate  ; final stage, BST 460, harder to handle
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/golem.pic", 0, 1 ; sprite dimensions
	dw GolemPicFront, GolemPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex turtle-shell rock (Rock/Ground). HM STRENGTH.
	; Fun moves (last-stage): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, IRON_HEAD, SCARY_FACE, TAKE_DOWN, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, STRENGTH, SEISMIC_TOSS
	; end

	db 0 ; padding
