	object_const_def
	const_export ROUTE16_BIKER1
	const_export ROUTE16_BIKER2
	const_export ROUTE16_BIKER3
	const_export ROUTE16_BIKER4
	const_export ROUTE16_BIKER5
	const_export ROUTE16_BIKER6
	const_export ROUTE16_SNORLAX

Route16_Object:
	db $f ; border block

	def_warp_events
	warp_event 15, 14, ROUTE_16_GATE_1F, 1
	warp_event 15, 15, ROUTE_16_GATE_1F, 1
	warp_event 22, 14, ROUTE_16_GATE_1F, 3
	warp_event 22, 15, ROUTE_16_GATE_1F, 3
	warp_event 15,  6, ROUTE_16_GATE_1F, 5
	warp_event 15,  7, ROUTE_16_GATE_1F, 5
	warp_event 22,  6, ROUTE_16_GATE_1F, 7
	warp_event 22,  7, ROUTE_16_GATE_1F, 7
	warp_event  7,  7, ROUTE_16_FLY_HOUSE, 1

	def_bg_events
	bg_event 25, 15, TEXT_ROUTE16_CYCLING_ROAD_SIGN
	bg_event  7, 25, TEXT_ROUTE16_SIGN

	def_object_events
	object_event 18, 16, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE16_BIKER1, OPP_BIKER, 5, 4
	object_event  6, 18, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE16_BIKER2, OPP_CUE_BALL, 1, 2
	object_event 12, 17, SPRITE_BIKER, STAY, UP, TEXT_ROUTE16_BIKER3, OPP_CUE_BALL, 2, 2
	object_event  9, 15, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE16_BIKER4, OPP_BIKER, 6, 2
	object_event  6, 14, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE16_BIKER5, OPP_CUE_BALL, 3, 2
	object_event  3, 16, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE16_BIKER6, OPP_BIKER, 7, 2
	object_event 25, 14, SPRITE_SNORLAX, STAY, DOWN, TEXT_ROUTE16_SNORLAX

	def_warps_to ROUTE_16
