	db DEX_GOLEM ; pokedex id
	base_stat_row 80, 110, 135, 65, 65 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/golem.pic", 0, 1 ; sprite dimensions
	dw GolemPicFront, GolemPicBack

	db HEAVY_SLAM, IRON_DEFENSE, ROCK_SLIDE, EARTHQUAKE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): apex turtle-shell rock. Graveler's 9 +
	; 1 Golem-only addition (per Forte's via-TM list): SCARY_FACE
	; (massive rock-shell intimidating).
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    STRENGTH,     TAKE_DOWN, \
	     EARTHQUAKE,   IRON_HEAD,    ROCK_SLIDE,   DOUBLE_EDGE,  SCARY_FACE, \
	     MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
