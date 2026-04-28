	db DEX_NIDORAN_F ; pokedex id
	base_stat_row 55, 47, 52, 40, 50 ; hp atk def spc spd

	db POISON, POISON ; type
	db 235 ; catch rate
	db 59 ; base exp

	INCBIN "gfx/pokemon/front/nidoranf.pic", 0, 1 ; sprite dimensions
	dw NidoranFPicFront, NidoranFPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review F#2): juvenile defensive female. 4 TMs:
	; BODY_SLAM¹/POISON_FANG¹ (levelup TMs), TOXIC (all 3 nidos),
	; TAKE_DOWN. NO SCARY_FACE/BULLDOZE/IRON_TAIL (Forte F#2 — Nidorina+
	; only or never). NO QUICK_ATTACK (M-only basic move per gender split).
	tmhm BODY_SLAM,    POISON_FANG,  TOXIC,        TAKE_DOWN
	; end

	db 0 ; padding
