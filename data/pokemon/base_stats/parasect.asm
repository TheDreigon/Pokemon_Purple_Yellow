	db DEX_PARASECT ; pokedex id
	base_stat_row 100, 90, 90, 75, 85, 20 ; hp atk def spatk spdef spd
	db BUG, FUNGUS ; type (+ GRASS, its third: data/pokemon/third_types.asm)
	db 90 ; catch rate  ; final stage, BST 460, easy to approach
	db 145 ; base exp  ; BST 460

	INCBIN "gfx/pokemon/front/parasect.pic", 0, 1 ; sprite dimensions
	dw ParasectPicFront, ParasectPicBack

	db BUG_BITE, SCRATCH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex dominated by the mushroom (Bug/Fungus):
	; GIGA_DRAIN/TOXIC/SCARY_FACE/LEECH_LIFE/DOUBLE_EDGE plus
	; BODY_SLAM/POISON_BITE/TAKE_DOWN/SWORDS_DANCE. HM CUT.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	; v1.0 (2026-11-07): DARK_PULSE is a level-up auto (L56).
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     GIGA_DRAIN, POISON_BITE, TOXIC, SCARY_FACE, LEECH_LIFE, \
	     TAKE_DOWN, DARK_PULSE, SWORDS_DANCE, DOUBLE_EDGE, CUT
	; end

	db BANK(ParasectPicFront) ; which bank this mon's pics live in
	assert BANK(ParasectPicFront) == BANK(ParasectPicBack), \
	    "Parasect: front and back pics must share a bank"
