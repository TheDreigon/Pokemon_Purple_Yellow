	db DEX_ONIX ; pokedex id
	base_stat_row 60, 100, 160, 60, 40 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 108 ; base exp

	INCBIN "gfx/pokemon/front/onix.pic", 0, 1 ; sprite dimensions
	dw OnixPicFront, OnixPicBack

	db HEAVY_SLAM, INTIMIDATE, ROCK_SLIDE, EARTHQUAKE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): single-mon apex rock-snake. 12 TMs,
	; mostly mirroring levelup. NO MEGAHORN (no horn). NO BULK_UP per
	; Forte (rock not muscle). NO HORN_DRILL (Forte: Dodrio+Rhydon only).
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    IRON_TAIL,    IRON_HEAD, \
	     INTIMIDATE,   SCARY_FACE,   DOUBLE_EDGE,  TAKE_DOWN,    ROCK_SLIDE, \
	     EARTHQUAKE,   STRENGTH,     MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME
	; end

	db 0 ; padding
