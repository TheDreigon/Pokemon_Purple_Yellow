	db DEX_FLAREON ; pokedex id
	base_stat_row 65, 110, 80, 130, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 198 ; base exp

	INCBIN "gfx/pokemon/front/flareon.pic", 0, 1 ; sprite dimensions
	dw FlareonPicFront, FlareonPicBack

	db TACKLE, TAIL_WHIP, EMBER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Fire fox. Eevee's 6 + 6 fire/utility: IGNITE¹,
	; FLAMETHROWER¹, FIRE_BLAST¹, HM05 FLASH (fire type), LIGHT_SCREEN/
	; REFLECT (Forte #9), TAKE_DOWN.
	tmhm QUICK_ATTACK, BODY_SLAM,    DOUBLE_EDGE,  AGILITY,      FAKE_TEARS, \
	     IGNITE,       FLAMETHROWER, FLASH,        LIGHT_SCREEN, REFLECT, \
	     TAKE_DOWN,    MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
