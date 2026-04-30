	db DEX_GRAVELER ; pokedex id
	base_stat_row 55, 100, 115, 50, 45 ; hp atk def spc spd

	db ROCK, GROUND ; type
	db 120 ; catch rate
	db 134 ; base exp

	INCBIN "gfx/pokemon/front/graveler.pic", 0, 1 ; sprite dimensions
	dw GravelerPicFront, GravelerPicBack

	db BODY_SLAM, DEFENSE_CURL, ROCK_PUNCH, BULLDOZE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): mid-stage. Geodude's 4 + 5 mid-evo
	; additions matching levelup: TAKE_DOWN¹, EARTHQUAKE¹, IRON_HEAD¹,
	; ROCK_SLIDE¹ (post-HEAD_SMASH), DOUBLE_EDGE¹ (apex recoil).
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    STRENGTH,     TAKE_DOWN,    \
	     EARTHQUAKE,   IRON_HEAD,    ROCK_SLIDE,   DOUBLE_EDGE
	; end

	db 0 ; padding
