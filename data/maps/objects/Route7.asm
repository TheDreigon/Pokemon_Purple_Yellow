Route7_Object:
	db $f ; border block

	def_warp_events
	warp_event 24,  9, ROUTE_7_GATE, 3
	warp_event 24, 10, ROUTE_7_GATE, 3
	warp_event 17,  9, ROUTE_7_GATE, 1
	warp_event 17, 10, ROUTE_7_GATE, 1
	warp_event 11, 13, UNDERGROUND_PATH_ROUTE_7, 1

	def_bg_events
	bg_event 15,  7, TEXT_ROUTE7_UNDERGROUND_PATH_SIGN

	def_object_events

	def_warps_to ROUTE_7
