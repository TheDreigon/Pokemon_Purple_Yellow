	db DEX_NIDORAN_M ; pokedex id
	base_stat_row 46, 57, 40, 40, 55 ; hp atk def spc spd

	db POISON, POISON ; type
	db 235 ; catch rate
	db 60 ; base exp

	INCBIN "gfx/pokemon/front/nidoranm.pic", 0, 1 ; sprite dimensions
	dw NidoranMPicFront, NidoranMPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review #5): juvenile aggressive male. 5 TMs:
	; QUICK_ATTACK (Forte add), BODY_SLAM¹/POISON_FANG¹ (levelup TMs),
	; TOXIC (all 3 nidos per Forte), TAKE_DOWN. NO SCARY_FACE/BULLDOZE
	; (Forte #5 — Nidorino+ only).
	tmhm QUICK_ATTACK, BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN
	; end

	db 0 ; padding
