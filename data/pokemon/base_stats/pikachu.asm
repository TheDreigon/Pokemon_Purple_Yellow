	db DEX_PIKACHU ; pokedex id
	base_stat_row 55, 55, 50, 80, 95 ; hp atk def spc spd

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 82 ; base exp

	INCBIN "gfx/pokemon/front/pikachu.pic", 0, 1 ; sprite dimensions
	dw PikachuPicFront, PikachuPicBack

	db NUZZLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electric mouse. Per Forte's revisions: REFLECT/LIGHT_
	; SCREEN/FAKE_TEARS added (#3); TOXIC removed (#3); HM05 FLASH (electric
	; can flash). NO fun moves (anatomy/lore-gated).
	tmhm QUICK_ATTACK, BODY_SLAM,    IRON_TAIL,    THUNDERBOLT,  THUNDER_WAVE, \
	     AGILITY,      REFLECT,      LIGHT_SCREEN, FAKE_TEARS,   FLASH
	; end

	db 0 ; padding
