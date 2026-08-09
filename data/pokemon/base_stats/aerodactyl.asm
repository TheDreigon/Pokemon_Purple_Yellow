	db DEX_AERODACTYL ; pokedex id
	base_stat_row 70, 110, 80, 75, 120 ; hp atk def spc spd

	db ROCK, FLYING ; type
	db 60 ; catch rate  ; solo stage, BST 455, harder to handle
	db 202 ; base exp

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
