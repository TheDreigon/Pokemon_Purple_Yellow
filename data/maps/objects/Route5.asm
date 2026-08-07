	object_const_def
	const_export ROUTE5_LITTLE_GIRL
	const_export ROUTE5_YOUNGSTER

Route5_Object:
	db $a ; border block

	def_warp_events
	warp_event 10, 37, ROUTE_5_GATE, 3
	warp_event  9, 37, ROUTE_5_GATE, 3
	warp_event 10, 41, ROUTE_5_GATE, 1
	warp_event 17, 33, UNDERGROUND_PATH_ROUTE_5, 1
	warp_event 10, 21, DAYCARE, 1

	def_bg_events
	bg_event 17, 35, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN
	bg_event  9, 25, TEXT_ROUTE5_DAYCARE_SIGN

	def_object_events
; LEFT_RIGHT rather than ANY_DIR on purpose: Route 5 is a split-set map
; (PEWTER_CERULEAN north of row 33, SAFFRON south of it) and only the north
; set carries LITTLE_GIRL. Free to wander, she could drift south of row 28
; and turn to garbage tiles for a player standing in the south half. Pinned
; to her row she stays a day-care visitor and stays renderable.
	object_event  8, 27, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT, TEXT_ROUTE5_LITTLE_GIRL
	object_event 12, 36, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, TEXT_ROUTE5_YOUNGSTER

	def_warps_to ROUTE_5
