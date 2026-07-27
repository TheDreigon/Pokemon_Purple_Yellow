	object_const_def
	const_export ROUTE2_MOON_STONE
	const_export ROUTE2_HP_UP

Route2_Object:
	db $f ; border block

	def_warp_events
	warp_event 14,  9, DIGLETTS_CAVE_ROUTE_2, 1
	warp_event  3, 11, VIRIDIAN_FOREST_NORTH_GATE, 2
	warp_event 15, 21, ROUTE_2_TRADE_HOUSE, 1
	warp_event 16, 35, ROUTE_2_GATE, 2
	warp_event 15, 39, ROUTE_2_GATE, 3
	warp_event  3, 43, VIRIDIAN_FOREST_SOUTH_GATE, 3
	warp_event 17, 35, ROUTE_2_GATE, 2

	def_bg_events
	bg_event   7, 65, TEXT_ROUTE2_SIGN
	bg_event 13, 11, TEXT_ROUTE2_DIGLETTS_CAVE_SIGN

	def_object_events
	object_event 17, 68, SPRITE_POKE_BALL, STAY, NONE, TEXT_ROUTE2_MOON_STONE, LEAF_STONE
	object_event 18, 67, SPRITE_POKE_BALL, STAY, NONE, TEXT_ROUTE2_HP_UP, ETHER

	def_warps_to ROUTE_2

	; unused
	warp_to 2, 7, 4
	db $12, $c7, $9, $7
	warp_to 2, 7, 4
	warp_to 2, 7, 4
	warp_to 2, 7, 4
