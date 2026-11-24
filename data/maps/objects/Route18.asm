	object_const_def
	const_export ROUTE18_COOLTRAINER_M1
	const_export ROUTE18_COOLTRAINER_M2
	const_export ROUTE18_COOLTRAINER_M3

Route18_Object:
	db $43 ; border block

	def_warp_events
	warp_event 33, 12, ROUTE_18_GATE_1F, 1
	warp_event 33, 13, ROUTE_18_GATE_1F, 1
	warp_event 40, 12, ROUTE_18_GATE_1F, 3
	warp_event 40, 13, ROUTE_18_GATE_1F, 3

	def_bg_events
	bg_event 49, 11, TEXT_ROUTE18_SIGN
	bg_event 29,  9, TEXT_ROUTE18_CYCLING_ROAD_SIGN

	def_object_events
	object_event 41, 19, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, TEXT_ROUTE18_COOLTRAINER_M1, OPP_BIRD_KEEPER, 8, 4
	object_event 45, 24, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, TEXT_ROUTE18_COOLTRAINER_M2, OPP_BIRD_KEEPER, 9, 4
	object_event 50, 21, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, TEXT_ROUTE18_COOLTRAINER_M3, OPP_BIRD_KEEPER, 10, 4

	def_warps_to ROUTE_18
