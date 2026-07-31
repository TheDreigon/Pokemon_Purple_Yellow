	object_const_def
	const_export VIRIDIANOLDRODHOUSE_FISHING_GURU

ViridianOldRodHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 6
	warp_event  3,  7, LAST_MAP, 6

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_FISHING_GURU, STAY, RIGHT, TEXT_VIRIDIANOLDRODHOUSE_FISHING_GURU

	def_warps_to VIRIDIAN_OLD_ROD_HOUSE
