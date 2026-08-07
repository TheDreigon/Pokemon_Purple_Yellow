	object_const_def
	const_export DAYCARE_GENTLEMAN
	const_export DAYCARE_ODDISH
	const_export DAYCARE_JIGGLYPUFF
	const_export DAYCARE_PIDGEY
	const_export DAYCARE_PSYDUCK

Daycare_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 5
	warp_event  3,  7, LAST_MAP, 5
	warp_event  7,  1, DAYCARE_2F, 1

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GENTLEMAN, STAY, RIGHT, TEXT_DAYCARE_GENTLEMAN
; The current boarders, roaming the ground floor. Their sprites load from
; this map's own object list (indoor maps have no sprite-set limits).
	object_event  5,  4, SPRITE_ODDISH, WALK, ANY_DIR, TEXT_DAYCARE_ODDISH
	object_event  1,  5, SPRITE_JIGGLYPUFF, WALK, ANY_DIR, TEXT_DAYCARE_JIGGLYPUFF
	object_event  6,  5, SPRITE_PIDGEY, WALK, ANY_DIR, TEXT_DAYCARE_PIDGEY
	object_event  4,  6, SPRITE_PSYDUCK, WALK, ANY_DIR, TEXT_DAYCARE_PSYDUCK

	def_warps_to DAYCARE
