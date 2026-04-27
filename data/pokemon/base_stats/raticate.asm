	db DEX_RATICATE ; pokedex id
	base_stat_row 70, 90, 65, 60, 90 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 90 ; catch rate
	db 116 ; base exp

	INCBIN "gfx/pokemon/front/raticate.pic", 0, 1 ; sprite dimensions
	dw RaticatePicFront, RaticatePicBack

	db TACKLE, TAIL_WHIP, QUICK_ATTACK, BITE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: matured Normal/Dark rodent. Rattata's 9 + 3 apex
	; additions: Bulk Up (warrior rat), Faint Attack (Dark levelup-double),
	; Intimidate (matured rat presence).
	tmhm QUICK_ATTACK, BODY_SLAM,    HONE_CLAWS,   POISON_FANG,  TOXIC,        \
	     DOUBLE_EDGE,  TAKE_DOWN,    AGILITY,      CUT,          BULK_UP,      \
	     FAINT_ATTACK, INTIMIDATE
	; end

	db 0 ; padding
