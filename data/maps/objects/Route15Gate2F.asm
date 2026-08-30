	object_const_def
	const_export ROUTE15GATE2F_WATCHER ; was the EXP.SHARE aide (moved to Saffron 2026-08-30)

Route15Gate2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  7, ROUTE_15_GATE_1F, 5

	def_bg_events
	bg_event  6,  2, TEXT_ROUTE15GATE2F_BINOCULARS

	def_object_events
	object_event  4,  2, SPRITE_YOUNGSTER, STAY, DOWN, TEXT_ROUTE15GATE2F_WATCHER

	def_warps_to ROUTE_15_GATE_2F
