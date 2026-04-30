	db DEX_CHARIZARD ; pokedex id
	base_stat_row 90, 100, 80, 100, 90 ; hp atk def spc spd

	db FIRE, FLYING ; type
	db 45 ; catch rate
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/charizard.pic", 0, 1 ; sprite dimensions
	dw CharizardPicFront, CharizardPicBack

	db BITE, FLY, WING_ATTACK, FLAMETHROWER ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: dragon apex. Charmeleon's 20 + 6 dragon/wing/warrior:
	; Aerial Ace + Hurricane (levelup-doubles), Intimidate (massive presence),
	; Swords Dance (warrior peak), Earthquake (heavy descent stomp), HM Fly
	; (in levelup too — Forte's natural-FLY learner).
	tmhm QUICK_ATTACK, TAKE_DOWN,    DRAGON_CLAW,  IGNITE,       FLAMETHROWER, \
	     OUTRAGE,      CUT,          FLASH,        BODY_SLAM,    BULK_UP, \
	     DOUBLE_EDGE,  STRENGTH,     AERIAL_ACE,   HURRICANE,    INTIMIDATE, \
	     SWORDS_DANCE, EARTHQUAKE,   FLY,          ROCK_THROW,   MIMIC, \
	     MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
