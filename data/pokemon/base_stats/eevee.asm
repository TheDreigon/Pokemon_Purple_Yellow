	db DEX_EEVEE ; pokedex id
	base_stat_row 65, 65, 65, 65, 65 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 92 ; base exp

	INCBIN "gfx/pokemon/front/eevee.pic", 0, 1 ; sprite dimensions
	dw EeveePicFront, EeveePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Cute Normal fox base, backbone-only.
	tmhm QUICK_ATTACK, BODY_SLAM, AGILITY, FAKE_TEARS, CHARM, \
	     DOUBLE_EDGE
	; end

	db 0 ; padding
