	db DEX_AERODACTYL ; pokedex id
	base_stat_row 70, 110, 80, 65, 75, 120 ; hp atk def spatk spdef spd

	db ROCK, FLYING ; type
	db 65 ; catch rate  ; solo stage, BST 520, harder to handle
	db 200 ; base exp  ; fossil final

	INCBIN "gfx/pokemon/front/aerodactyl.pic", 0, 1 ; sprite dimensions
	dw AerodactylPicFront, AerodactylPicBack

	db BITE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Rock/Flying apex predator pterodactyl, single-stage.
	tmhm ROCK_THROW, QUICK_ATTACK, FAINT_ATTACK, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, AERIAL_ACE, DRAGON_CLAW, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, ROCK_SLIDE, \
	     DOUBLE_EDGE, CUT, FLY, STRENGTH, IRON_HEAD
	; end

	db BANK(AerodactylPicFront) ; which bank this mon's pics live in
	assert BANK(AerodactylPicFront) == BANK(AerodactylPicBack), \
	    "Aerodactyl: front and back pics must share a bank"
