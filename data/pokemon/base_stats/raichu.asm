	db DEX_RAICHU ; pokedex id
	base_stat_row 75, 90, 70, 110, 90 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 75 ; catch rate
	db 122 ; base exp

	INCBIN "gfx/pokemon/front/raichu.pic", 0, 1 ; sprite dimensions
	dw RaichuPicFront, RaichuPicBack

	db NUZZLE, GROWL, QUICK_ATTACK, IRON_TAIL ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: bigger orange mouse. Pikachu's 11 + 3 apex additions:
	; BULK_UP (warrior mouse), DOUBLE_EDGE (levelup-double — bigger reckless
	; body), TAKE_DOWN.
	tmhm QUICK_ATTACK, BODY_SLAM,    IRON_TAIL,    THUNDERBOLT,  THUNDER_WAVE, \
	     AGILITY,      REFLECT,      LIGHT_SCREEN, FAKE_TEARS,   FLASH, \
	     BULK_UP,      DOUBLE_EDGE,  TAKE_DOWN,    MIMIC,        MIRROR_MOVE, \
	     SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
