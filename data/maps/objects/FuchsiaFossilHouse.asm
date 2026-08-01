	object_const_def
	const_export FUCHSIAFOSSILHOUSE_FISHING_GURU

FuchsiaFossilHouse_Object:
	db $c ; border block

	def_warp_events
	warp_event  2,  0, LAST_MAP, 9
	warp_event  2,  7, LAST_MAP, 8
	warp_event  3,  7, LAST_MAP, 8

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, STAY, RIGHT, TEXT_FUCHSIAFOSSILHOUSE_FISHING_GURU

	def_warps_to FUCHSIA_FOSSIL_HOUSE
