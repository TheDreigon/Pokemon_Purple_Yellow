	db DEX_JOLTEON ; pokedex id
	base_stat_row 65, 80, 65, 110, 130 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 197 ; base exp

	INCBIN "gfx/pokemon/front/jolteon.pic", 0, 1 ; sprite dimensions
	dw JolteonPicFront, JolteonPicBack

	db TACKLE, TAIL_WHIP, THUNDERSHOCK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electric fox, fastest. Eevee's 6 + 6 electric/utility:
	; THUNDERBOLT¹, THUNDER_WAVE¹, THUNDER¹, HM05 FLASH (electric flash),
	; LIGHT_SCREEN/REFLECT (Forte #9), TAKE_DOWN.
	tmhm QUICK_ATTACK, BODY_SLAM,    DOUBLE_EDGE,  AGILITY,      FAKE_TEARS, \
	     THUNDERBOLT,  THUNDER_WAVE, FLASH,        LIGHT_SCREEN, REFLECT, \
	     TAKE_DOWN
	; end

	db 0 ; padding
