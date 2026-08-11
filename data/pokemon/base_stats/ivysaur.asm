	db DEX_IVYSAUR ; pokedex id
	base_stat_row 70, 60, 65, 75, 60 ; hp atk def spc spd

	db GRASS, POISON ; type
	db 75 ; catch rate  ; set by hand: starter line, middle
	db 115 ; base exp  ; BST 330 - grupo mantido igual

	INCBIN "gfx/pokemon/front/ivysaur.pic", 0, 1 ; sprite dimensions
	dw IvysaurPicFront, IvysaurPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Matured Grass/Poison; superset of Bulbasaur. HM CUT/STRENGTH/FLASH.
	tmhm BIND, BULLDOZE, BODY_SLAM, GIGA_DRAIN, TOXIC, \
	     TAKE_DOWN, LIGHT_SCREEN, REFLECT, EARTHQUAKE, PETAL_DANCE, \
	     DOUBLE_EDGE, CUT, STRENGTH, FLASH
	; end

	db BANK(IvysaurPicFront) ; which bank this mon's pics live in
	assert BANK(IvysaurPicFront) == BANK(IvysaurPicBack), \
	    "Ivysaur: front and back pics must share a bank"
