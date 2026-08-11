	db DEX_PERSIAN ; pokedex id
	base_stat_row 90, 80, 50, 60, 115 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 65 ; catch rate  ; final stage, BST 395, harder to handle
	db 150 ; base exp  ; BST 395 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/persian.pic", 0, 1 ; sprite dimensions
	dw PersianPicFront, PersianPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Normal/Dark feline, smart sleek cat:
	; FAINT_ATTACK/RAGE/AGILITY/INTIMIDATE/QUICK_ATTACK plus
	; IRON_TAIL/NIGHT_SHADE/SCARY_FACE/TAKE_DOWN/DARK_PULSE/
	; SWORDS_DANCE/DRAGON_CLAW. HM CUT/STRENGTH.
	; Last-stage fun: MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, IRON_TAIL, NIGHT_SHADE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, DARK_PULSE, SWORDS_DANCE, \
	     CUT, STRENGTH, DRAGON_CLAW
	; end

	db BANK(PersianPicFront) ; which bank this mon's pics live in
	assert BANK(PersianPicFront) == BANK(PersianPicBack), \
	    "Persian: front and back pics must share a bank"
