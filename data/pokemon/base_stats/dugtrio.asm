	db DEX_DUGTRIO ; pokedex id
	base_stat_row 45, 90, 50, 70, 120 ; hp atk def spc spd

	db GROUND, GROUND ; type
	db 50 ; catch rate
	db 153 ; base exp

	INCBIN "gfx/pokemon/front/dugtrio.pic", 0, 1 ; sprite dimensions
	dw DugtrioPicFront, DugtrioPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm ROCK_THROW,   BULLDOZE,     BODY_SLAM,    AGILITY,      IRON_HEAD, \
	     TAKE_DOWN,    EARTHQUAKE,   MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    STRENGTH
	; end

	db 0 ; padding
