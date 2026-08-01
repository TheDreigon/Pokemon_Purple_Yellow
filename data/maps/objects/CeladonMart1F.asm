	object_const_def
	const_export CELADONMART1F_RECEPTIONIST
	const_export CELADONMART1F_INFO_CLERK

CeladonMart1F_Object:
	db $f ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 1
	warp_event  3,  7, LAST_MAP, 1
	warp_event 16,  7, LAST_MAP, 2
	warp_event 17,  7, LAST_MAP, 2
	warp_event 12,  1, CELADON_MART_2F, 1
	warp_event  1,  1, CELADON_MART_ELEVATOR, 1

	def_bg_events
	bg_event 11,  4, TEXT_CELADONMART1F_DIRECTORY_SIGN
	bg_event 14,  1, TEXT_CELADONMART1F_CURRENT_FLOOR_SIGN

	def_object_events
	object_event  9,  3, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, TEXT_CELADONMART1F_RECEPTIONIST
	; Information desk, sharing the counter with her. The whole run (7,4)-(11,4)
	; is a Lobby counter tile, so the player talks across it exactly as they do
	; to the receptionist.
	object_event  8,  3, SPRITE_CLERK, STAY, DOWN, TEXT_CELADONMART1F_INFO_CLERK

	def_warps_to CELADON_MART_1F
