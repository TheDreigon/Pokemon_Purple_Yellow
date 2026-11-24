	object_const_def
	const_export ROUTE17_BIKER1
	const_export ROUTE17_BIKER2
	const_export ROUTE17_BIKER3
	const_export ROUTE17_BIKER4
	const_export ROUTE17_BIKER5
	const_export ROUTE17_BIKER6
	const_export ROUTE17_BIKER7
	const_export ROUTE17_BIKER8
	const_export ROUTE17_BIKER9
	const_export ROUTE17_BIKER10

Route17_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event 11, 119, TEXT_ROUTE17_SOUTH_SIGN
; v0.7 (2026-09-01): the north sign, relocated here from Route
; 16 (5,17) - its old spot now teaches the slope rule. The two NOTICE
; signs came down (graphics already removed).
	bg_event  7,  3, TEXT_ROUTE17_NORTH_SIGN

	def_object_events
	object_event 12, 31, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE17_BIKER1, OPP_CUE_BALL, 4, 4
	object_event 15, 31, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE17_BIKER2, OPP_CUE_BALL, 5, 4
	object_event  8,  4, SPRITE_BIKER, STAY, DOWN, TEXT_ROUTE17_BIKER3, OPP_BIKER, 8, 3
	object_event  6, 43, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE17_BIKER4, OPP_BIKER, 9, 4
	object_event  9, 43, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE17_BIKER5, OPP_BIKER, 10, 2
	object_event 20, 93, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE17_BIKER6, OPP_CUE_BALL, 6, 4
	object_event  1, 93, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE17_BIKER7, OPP_CUE_BALL, 7, 4
	object_event 15, 113, SPRITE_BIKER, STAY, RIGHT, TEXT_ROUTE17_BIKER8, OPP_CUE_BALL, 8, 4
	object_event  6, 113, SPRITE_BIKER, STAY, LEFT, TEXT_ROUTE17_BIKER9, OPP_BIKER, 11, 4
	object_event 12, 120, SPRITE_BIKER, STAY, DOWN, TEXT_ROUTE17_BIKER10, OPP_BIKER, 12, 3

	def_warps_to ROUTE_17
