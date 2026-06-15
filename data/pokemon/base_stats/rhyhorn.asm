	db DEX_RHYHORN ; pokedex id
	base_stat_row 80, 85, 95, 40, 55 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 120 ; catch rate
	db 135 ; base exp

	INCBIN "gfx/pokemon/front/rhyhorn.pic", 0, 1 ; sprite dimensions
	dw RhyhornPicFront, RhyhornPicBack

	db LEER, GROUND_STOMP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: pre-evo rhinoceros charger (Ground/Rock). auto
	; BULLDOZE/RAGE/BODY_SLAM/IRON_HEAD/TAKE_DOWN. bonus
	; ROCK_THROW/EARTHQUAKE/MEGAHORN/DOUBLE_EDGE. HM STRENGTH.
	tmhm ROCK_THROW, BULLDOZE, RAGE, BODY_SLAM, IRON_HEAD, \
	     MEGAHORN, TAKE_DOWN, EARTHQUAKE, DOUBLE_EDGE, STRENGTH
	; end

	db 0 ; padding
