	object_const_def
	const_export LAVENDERCUBONEHOUSE_BRUNETTE_GIRL

LavenderCuboneHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 5
	warp_event  3,  7, LAST_MAP, 5

	def_bg_events

	def_object_events
; v1.0 (2026-09-23, Forte): the orphan CUBONE lives at MR. FUJI's Volunteer House
; now (vanilla kept her here, with the girl); the girl still talks about her.
	object_event  2,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, TEXT_LAVENDERCUBONEHOUSE_BRUNETTE_GIRL

	def_warps_to LAVENDER_CUBONE_HOUSE
