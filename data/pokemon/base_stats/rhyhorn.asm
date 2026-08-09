	db DEX_RHYHORN ; pokedex id
	base_stat_row 80, 85, 95, 40, 55 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 190 ; catch rate  ; base stage, BST 355, harder to handle
	db 135 ; base exp

	INCBIN "gfx/pokemon/front/rhyhorn.pic", 0, 1 ; sprite dimensions
	dw RhyhornPicFront, RhyhornPicBack

	db LEER, GROUND_STOMP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Pre-evo Ground/Rock rhinoceros charger. The horn justifies MEGAHORN;
	; ROCK_THROW from forelimbs. Heavy frame learns HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, RAGE, BODY_SLAM, IRON_HEAD, \
	     MEGAHORN, TAKE_DOWN, EARTHQUAKE, DOUBLE_EDGE, STRENGTH, \
	     ROCK_SLIDE
	; end

	db BANK(RhyhornPicFront) ; which bank this mon's pics live in
	assert BANK(RhyhornPicFront) == BANK(RhyhornPicBack), \
	    "Rhyhorn: front and back pics must share a bank"
