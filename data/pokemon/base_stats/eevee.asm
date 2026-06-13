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
	; v0.7 Pass 3: cute fox base. AGILITY TM per Forte's TM-agility list
	; (Eevee included). FAKE_TEARS TM per Forte #11. NO TAKE_DOWN per Forte
	; #10 (only Eevee loses; the 3 evolutions keep). NO fun moves.
	tmhm QUICK_ATTACK, BODY_SLAM,    DOUBLE_EDGE,  AGILITY,      FAKE_TEARS
	; end

	db 0 ; padding
